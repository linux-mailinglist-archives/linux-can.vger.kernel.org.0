Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37CD2A9A86
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgKFRLY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:11:24 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:33177 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgKFRLX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:11:23 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 651E2FF9CE
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 17:04:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.902
X-Spam-Level: 
X-Spam-Status: No, score=-1.902 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001]
        autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z0jqBOJF_u8h for <linux-can@vger.kernel.org>;
        Fri,  6 Nov 2020 18:03:37 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 06/17] can: ems_usb: Added listen only mode for CPC-USB/ARM7 and moved evaluation of can.ctrlmode from set_bittiming routine to ems_usb_write_mode_arm7 routine. Wrapped a long line.
Date:   Fri,  6 Nov 2020 18:01:55 +0100
Message-Id: <20201106170206.32162-7-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 39 ++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index a3943042b8c8..66418e5af87d 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -85,6 +85,7 @@ MODULE_LICENSE("GPL v2");
 /* Mode register NXP LPC2119/SJA1000 CAN Controller */
 #define SJA1000_MOD_NORMAL 0x00
 #define SJA1000_MOD_RM     0x01
+#define SJA1000_MOD_LOM    0x02
 
 /* ECC register NXP LPC2119/SJA1000 CAN Controller */
 #define SJA1000_ECC_SEG   0x1F
@@ -604,13 +605,23 @@ static int ems_usb_write_mode_arm7(struct ems_usb *dev, u32 mode)
 	struct cpc_sja1000_params *sja1000 =
 		&dev->active_params.msg.can_params.cc_params.sja1000;
 
-	if (mode == CPC_USB_RESET_MODE)
+	if (mode == CPC_USB_RESET_MODE) {
 		sja1000->mode |= SJA1000_MOD_RM;
-	else if (mode == CPC_USB_RUN_MODE)
+	} else if (mode == CPC_USB_RUN_MODE) {
 		sja1000->mode &= ~SJA1000_MOD_RM;
 
-	else
+		if (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+			sja1000->mode |= SJA1000_MOD_LOM;
+		else
+			sja1000->mode &= ~SJA1000_MOD_LOM;
+
+		if (dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+			sja1000->btr1 |= 0x80;
+		else
+			sja1000->btr1 &= ~0x80;
+	} else {
 		return -EINVAL;
+	}
 
 	return ems_usb_command_msg(dev, &dev->active_params);
 }
@@ -653,7 +664,9 @@ static int ems_usb_start(struct ems_usb *dev)
 			break;
 		}
 
-		buf = usb_alloc_coherent(dev->udev, dev->bulk_rd_buf_size, GFP_KERNEL,
+		buf = usb_alloc_coherent(dev->udev,
+					 dev->bulk_rd_buf_size,
+					 GFP_KERNEL,
 					 &urb->transfer_dma);
 		if (!buf) {
 			netdev_err(netdev, "No memory left for USB buffer\n");
@@ -963,18 +976,16 @@ static int ems_usb_set_bittiming_arm7(struct net_device *netdev)
 {
 	struct ems_usb *dev = netdev_priv(netdev);
 	struct can_bittiming *bt = &dev->can.bittiming;
-	u8 btr0, btr1;
+	struct cpc_sja1000_params *sja1000 =
+		&dev->active_params.msg.can_params.cc_params.sja1000;
 
-	btr0 = ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
-	btr1 = ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) |
+	sja1000->btr0 = ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
+	sja1000->btr1 = ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) |
 		(((bt->phase_seg2 - 1) & 0x7) << 4);
-	if (dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
-		btr1 |= 0x80;
-
-	netdev_info(netdev, "setting BTR0=0x%02x BTR1=0x%02x\n", btr0, btr1);
 
-	dev->active_params.msg.can_params.cc_params.sja1000.btr0 = btr0;
-	dev->active_params.msg.can_params.cc_params.sja1000.btr1 = btr1;
+	netdev_info(netdev, "Set bit timing for CPC-USB/ARM7\n");
+	netdev_info(netdev, "BTR0=0x%02x, BTR1=0x%02x\n",
+		    sja1000->btr0, sja1000->btr1);
 
 	return ems_usb_command_msg(dev, &dev->active_params);
 }
@@ -1039,7 +1050,7 @@ static int ems_usb_probe(struct usb_interface *intf,
 	dev->can.bittiming_const = &ems_usb_bittiming_const_arm7;
 	dev->can.do_set_bittiming = ems_usb_set_bittiming_arm7;
 	dev->can.do_set_mode = ems_usb_set_mode;
-	dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES;
+	dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY;
 	init_params_sja1000(&dev->active_params);
 	dev->ems_usb_write_mode = ems_usb_write_mode_arm7;
 	dev->bulk_rd_buf_size = 64;
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
