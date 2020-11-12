Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C722B0C35
	for <lists+linux-can@lfdr.de>; Thu, 12 Nov 2020 19:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgKLSEq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Nov 2020 13:04:46 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:32841 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgKLSEq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Nov 2020 13:04:46 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 2B555FFA5D
        for <linux-can@vger.kernel.org>; Thu, 12 Nov 2020 18:04:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3L7g0nd8l1Wy for <linux-can@vger.kernel.org>;
        Thu, 12 Nov 2020 19:04:42 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 06/16] can: ems_usb: Made RX_BUFFER_SIZE, ems_usb_write_mode and ems_usb_probe device dependent
Date:   Thu, 12 Nov 2020 19:03:36 +0100
Message-Id: <20201112180346.29070-7-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
References: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

RX_BUFFER_SIZE, ems_usb_write_mode and the device probe function in the
present version of the driver are fixed for CPC-USB/ARM7. This is made
device depended with this patch

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 69 ++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index cb7a002e8627..3eb3698d5ae6 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -261,9 +261,9 @@ static struct usb_device_id ems_usb_table[] = {
 
 MODULE_DEVICE_TABLE(usb, ems_usb_table);
 
-#define RX_BUFFER_SIZE      64
 #define CPC_HEADER_SIZE     4
 #define INTR_IN_BUFFER_SIZE 4
+#define CPC_USB_ARM7_RX_BUFFER_SIZE 64
 
 #define MAX_RX_URBS 10
 #define MAX_TX_URBS 10
@@ -285,6 +285,8 @@ struct ems_usb {
 	struct usb_device *udev;
 	struct net_device *netdev;
 
+	u32 bulk_rd_buf_size;
+
 	atomic_t active_tx_urbs;
 	struct usb_anchor tx_submitted;
 	struct ems_tx_urb_context tx_contexts[MAX_TX_URBS];
@@ -298,6 +300,8 @@ struct ems_usb {
 	u8 *intr_in_buffer;
 	unsigned int free_slots; /* remember number of available slots */
 
+	int (*ems_usb_write_mode)(struct ems_usb *dev, u32 mode);
+
 	struct ems_cpc_msg active_params; /* active controller parameters */
 };
 
@@ -517,7 +521,7 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
 
 resubmit_urb:
 	usb_fill_bulk_urb(urb, dev->udev, usb_rcvbulkpipe(dev->udev, 2),
-			  urb->transfer_buffer, RX_BUFFER_SIZE,
+			  urb->transfer_buffer, dev->bulk_rd_buf_size,
 			  ems_usb_read_bulk_callback, dev);
 
 	retval = usb_submit_urb(urb, GFP_ATOMIC);
@@ -591,9 +595,18 @@ static int ems_usb_command_msg(struct ems_usb *dev, struct ems_cpc_msg *msg)
 
 /* Change CAN controllers' mode register
  */
-static int ems_usb_write_mode(struct ems_usb *dev, u8 mode)
+static int ems_usb_write_mode_arm7(struct ems_usb *dev, u32 mode)
 {
-	dev->active_params.msg.can_params.cc_params.sja1000.mode = mode;
+	struct cpc_sja1000_params *sja1000 =
+		&dev->active_params.msg.can_params.cc_params.sja1000;
+
+	if (mode == CPC_USB_RESET_MODE)
+		sja1000->mode |= SJA1000_MOD_RM;
+	else if (mode == CPC_USB_RUN_MODE)
+		sja1000->mode &= ~SJA1000_MOD_RM;
+
+	else
+		return -EINVAL;
 
 	return ems_usb_command_msg(dev, &dev->active_params);
 }
@@ -652,7 +665,7 @@ static int ems_usb_start(struct ems_usb *dev)
 			break;
 		}
 
-		buf = usb_alloc_coherent(dev->udev, RX_BUFFER_SIZE, GFP_KERNEL,
+		buf = usb_alloc_coherent(dev->udev, dev->bulk_rd_buf_size, GFP_KERNEL,
 					 &urb->transfer_dma);
 		if (!buf) {
 			netdev_err(netdev, "No memory left for USB buffer\n");
@@ -662,7 +675,7 @@ static int ems_usb_start(struct ems_usb *dev)
 		}
 
 		usb_fill_bulk_urb(urb, dev->udev, usb_rcvbulkpipe(dev->udev, 2),
-				  buf, RX_BUFFER_SIZE,
+				  buf, dev->bulk_rd_buf_size,
 				  ems_usb_read_bulk_callback, dev);
 		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 		usb_anchor_urb(urb, &dev->rx_submitted);
@@ -670,7 +683,7 @@ static int ems_usb_start(struct ems_usb *dev)
 		err = usb_submit_urb(urb, GFP_KERNEL);
 		if (err) {
 			usb_unanchor_urb(urb);
-			usb_free_coherent(dev->udev, RX_BUFFER_SIZE, buf,
+			usb_free_coherent(dev->udev, dev->bulk_rd_buf_size, buf,
 					  urb->transfer_dma);
 			usb_free_urb(urb);
 			break;
@@ -719,7 +732,7 @@ static int ems_usb_start(struct ems_usb *dev)
 	if (err)
 		goto failed;
 
-	err = ems_usb_write_mode(dev, SJA1000_MOD_NORMAL);
+	err = dev->can.do_set_mode(netdev, CAN_MODE_START);
 	if (err)
 		goto failed;
 
@@ -753,7 +766,7 @@ static int ems_usb_open(struct net_device *netdev)
 	struct ems_usb *dev = netdev_priv(netdev);
 	int err;
 
-	err = ems_usb_write_mode(dev, SJA1000_MOD_RM);
+	err = dev->ems_usb_write_mode(dev, CPC_USB_RESET_MODE);
 	if (err)
 		return err;
 
@@ -801,7 +814,10 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 	if (!urb)
 		goto nomem;
 
-	buf = usb_alloc_coherent(dev->udev, size, GFP_ATOMIC, &urb->transfer_dma);
+	buf = usb_alloc_coherent(dev->udev,
+				 size,
+				 GFP_ATOMIC,
+				 &urb->transfer_dma);
 	if (!buf) {
 		netdev_err(netdev, "No memory left for USB buffer\n");
 		usb_free_urb(urb);
@@ -911,7 +927,7 @@ static int ems_usb_close(struct net_device *netdev)
 	netif_stop_queue(netdev);
 
 	/* Set CAN controller to reset mode */
-	if (ems_usb_write_mode(dev, SJA1000_MOD_RM))
+	if (dev->ems_usb_write_mode(dev, CPC_USB_RESET_MODE))
 		netdev_warn(netdev, "couldn't stop device");
 
 	close_candev(netdev);
@@ -926,7 +942,7 @@ static const struct net_device_ops ems_usb_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
-static const struct can_bittiming_const ems_usb_bittiming_const = {
+static const struct can_bittiming_const ems_usb_bittiming_const_arm7 = {
 	.name = "ems_usb",
 	.tseg1_min = 1,
 	.tseg1_max = 16,
@@ -944,7 +960,7 @@ static int ems_usb_set_mode(struct net_device *netdev, enum can_mode mode)
 
 	switch (mode) {
 	case CAN_MODE_START:
-		if (ems_usb_write_mode(dev, SJA1000_MOD_NORMAL))
+		if (dev->ems_usb_write_mode(dev, CPC_USB_RUN_MODE))
 			netdev_warn(netdev, "couldn't start device");
 
 		if (netif_queue_stopped(netdev))
@@ -958,7 +974,7 @@ static int ems_usb_set_mode(struct net_device *netdev, enum can_mode mode)
 	return 0;
 }
 
-static int ems_usb_set_bittiming(struct net_device *netdev)
+static int ems_usb_set_bittiming_arm7(struct net_device *netdev)
 {
 	struct ems_usb *dev = netdev_priv(netdev);
 	struct can_bittiming *bt = &dev->can.bittiming;
@@ -1037,11 +1053,24 @@ static int ems_usb_probe(struct usb_interface *intf,
 	dev->netdev = netdev;
 
 	dev->can.state = CAN_STATE_STOPPED;
-	dev->can.clock.freq = EMS_USB_ARM7_CLOCK;
-	dev->can.bittiming_const = &ems_usb_bittiming_const;
-	dev->can.do_set_bittiming = ems_usb_set_bittiming;
-	dev->can.do_set_mode = ems_usb_set_mode;
-	dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES;
+
+	/* Select CPC-USB/ARM7 or CPC-USB/FD */
+	switch (le16_to_cpu(dev->udev->descriptor.idProduct)) {
+	case USB_CPCUSB_ARM7_PRODUCT_ID:
+		dev->can.clock.freq = EMS_USB_ARM7_CLOCK;
+		dev->can.bittiming_const = &ems_usb_bittiming_const_arm7;
+		dev->can.do_set_bittiming = ems_usb_set_bittiming_arm7;
+		dev->can.do_set_mode = ems_usb_set_mode;
+		dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES;
+		init_params_sja1000(&dev->active_params);
+		dev->ems_usb_write_mode = ems_usb_write_mode_arm7;
+		dev->bulk_rd_buf_size = CPC_USB_ARM7_RX_BUFFER_SIZE;
+	break;
+
+	default:
+		err = -ENODEV;
+		goto cleanup_candev;
+	}
 
 	netdev->netdev_ops = &ems_usb_netdev_ops;
 
@@ -1072,8 +1101,6 @@ static int ems_usb_probe(struct usb_interface *intf,
 
 	SET_NETDEV_DEV(netdev, &intf->dev);
 
-	init_params_sja1000(&dev->active_params);
-
 	err = ems_usb_command_msg(dev, &dev->active_params);
 	if (err) {
 		netdev_err(netdev, "couldn't initialize controller: %d\n", err);
-- 
2.26.2

-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
