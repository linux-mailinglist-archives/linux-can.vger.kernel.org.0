Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF232A9A87
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgKFRL0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:11:26 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:36910 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgKFRLX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:11:23 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id C8F7BFFAA1
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 17:05:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xzX9PQuDvHdb for <linux-can@vger.kernel.org>;
        Fri,  6 Nov 2020 18:05:24 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 09/17] can: ems_usb: For CPC-USB/FD added clock definitions, bittiming constants, set_bittiming functions, bittiming init function and add all that to probe function
Date:   Fri,  6 Nov 2020 18:01:58 +0100
Message-Id: <20201106170206.32162-10-uttenthaler@ems-wuensche.com>
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
 drivers/net/can/usb/ems_usb.c | 141 +++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 6a9ea6a4e687..d6b52b265536 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -108,6 +108,17 @@ MODULE_LICENSE("GPL v2");
  */
 #define EMS_USB_ARM7_CLOCK 8000000
 
+/* CPC-USB/FD supports the following CAN clocks
+ */
+#define EMS_USB_FD_8MHZ   8000000
+#define EMS_USB_FD_16MHZ 16000000
+#define EMS_USB_FD_20MHZ 20000000
+#define EMS_USB_FD_24MHZ 24000000
+#define EMS_USB_FD_32MHZ 32000000
+#define EMS_USB_FD_40MHZ 40000000
+#define EMS_USB_FD_80MHZ 80000000
+#define EMS_USB_FD_CLOCK EMS_USB_FD_40MHZ
+
 #define CPC_TX_QUEUE_TRIGGER_LOW	25
 #define CPC_TX_QUEUE_TRIGGER_HIGH	35
 
@@ -970,6 +981,30 @@ static const struct can_bittiming_const ems_usb_bittiming_const_arm7 = {
 	.brp_inc = 1,
 };
 
+static const struct can_bittiming_const ems_usb_bittiming_const_generic = {
+	.name = "ems_usb_fd",
+	.tseg1_min = 1,
+	.tseg1_max = 256,
+	.tseg2_min = 1,
+	.tseg2_max = 128,
+	.sjw_max = 128,
+	.brp_min = 1,
+	.brp_max = 512,
+	.brp_inc = 1,
+};
+
+static const struct can_bittiming_const ems_usb_bittiming_const_generic_data = {
+	.name = "ems_usb_fd",
+	.tseg1_min = 1,
+	.tseg1_max = 16,
+	.tseg2_min = 1,
+	.tseg2_max = 16,
+	.sjw_max = 16,
+	.brp_min = 1,
+	.brp_max = 32,
+	.brp_inc = 1,
+};
+
 static int ems_usb_set_mode(struct net_device *netdev, enum can_mode mode)
 {
 	struct ems_usb *dev = netdev_priv(netdev);
@@ -1016,6 +1051,76 @@ static int ems_usb_set_bittiming_arm7(struct net_device *netdev)
 	return ems_usb_command_msg(dev, &dev->active_params);
 }
 
+static int ems_usb_set_bittiming_generic(struct net_device *netdev)
+{
+	struct ems_usb *dev = netdev_priv(netdev);
+	struct can_bittiming *bt = &dev->can.bittiming;
+	struct cpc_generic_can_params *gcp =
+		&dev->active_params.msg.can_params.cc_params.generic;
+	int err;
+
+	gcp->config = 0;
+	gcp->can_clk = dev->can.clock.freq;
+
+	gcp->n.tseg1 = bt->prop_seg + bt->phase_seg1;
+	gcp->n.tseg2 = bt->phase_seg2;
+	gcp->n.brp = bt->brp;
+	gcp->n.sjw = bt->sjw;
+
+	err = ems_usb_clear_cmd_queue(dev);
+	if (err)
+		return err;
+
+	netdev_info(netdev, "Set nominal bit timing for CPC-USB/FD with config %X\n",
+		    gcp->config);
+	netdev_info(netdev, "CAN Clock: %uMHz, Tseg1: %u, Tseg2: %u, BRP: %u, SJW: %u\n",
+		    gcp->can_clk / 1000000,
+		    gcp->n.tseg1,
+		    gcp->n.tseg2,
+		    gcp->n.brp,
+		    gcp->n.sjw);
+
+	return ems_usb_command_msg(dev, &dev->active_params);
+}
+
+static int ems_usb_set_bittiming_generic_data(struct net_device *netdev)
+{
+	struct ems_usb *dev = netdev_priv(netdev);
+	struct can_bittiming *bt = &dev->can.data_bittiming;
+	struct cpc_generic_can_params *gcp =
+		&dev->active_params.msg.can_params.cc_params.generic;
+	int err;
+
+	if (dev->can.ctrlmode & CAN_CTRLMODE_FD) {
+		gcp->config |= CPC_GENERICCONF_FD;
+		if (dev->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
+			gcp->config |= CPC_GENERICCONF_FD_BOSCH;
+	} else {
+		// If CAN FD is not requested we can return here
+		return 0;
+	}
+
+	gcp->d.tseg1 = bt->prop_seg + bt->phase_seg1;
+	gcp->d.tseg2 = bt->phase_seg2;
+	gcp->d.brp = bt->brp;
+	gcp->d.sjw = bt->sjw;
+
+	err = ems_usb_clear_cmd_queue(dev);
+	if (err)
+		return err;
+
+	netdev_info(netdev, "Set data bit timing for CPC-USB/FD with config %X\n",
+		    gcp->config);
+	netdev_info(netdev, "CAN Clock: %uMHz, Tseg1: %u, Tseg2: %u, BRP: %u, SJW: %u\n",
+		    gcp->can_clk / 1000000,
+		    gcp->d.tseg1,
+		    gcp->d.tseg2,
+		    gcp->d.brp,
+		    gcp->d.sjw);
+
+	return ems_usb_command_msg(dev, &dev->active_params);
+}
+
 static void init_params_sja1000(struct ems_cpc_msg *msg)
 {
 	struct cpc_sja1000_params *sja1000 =
@@ -1024,6 +1129,8 @@ static void init_params_sja1000(struct ems_cpc_msg *msg)
 	msg->type = CPC_CMD_TYPE_CAN_PARAMS;
 	msg->length = sizeof(struct cpc_can_params);
 	msg->msgid = 0;
+	msg->ts_sec = 0;
+	msg->ts_nsec = 0;
 
 	msg->msg.can_params.cc_type = CPC_CC_TYPE_SJA1000;
 
@@ -1046,6 +1153,24 @@ static void init_params_sja1000(struct ems_cpc_msg *msg)
 	sja1000->mode = SJA1000_MOD_RM;
 }
 
+static void init_params_generic(struct ems_cpc_msg *msg)
+{
+	struct cpc_generic_can_params *gcp =
+		&msg->msg.can_params.cc_params.generic;
+
+	msg->type = CPC_CMD_TYPE_CAN_PARAMS;
+	msg->length = sizeof(struct cpc_can_params);
+	msg->msgid = 0;
+	msg->ts_sec = 0;
+	msg->ts_nsec = 0;
+
+	memset((u8 *)gcp, 0, sizeof(struct cpc_generic_can_params));
+	msg->msg.can_params.cc_type = CPC_CC_TYPE_GENERIC;
+
+	gcp->config = CPC_GENERICCONF_RESET_MODE;
+	gcp->can_clk = EMS_USB_FD_CLOCK;
+}
+
 /* probe function for new CPC-USB devices
  */
 static int ems_usb_probe(struct usb_interface *intf,
@@ -1076,14 +1201,26 @@ static int ems_usb_probe(struct usb_interface *intf,
 	dev->can.bittiming_const = &ems_usb_bittiming_const_arm7;
 	dev->can.do_set_bittiming = ems_usb_set_bittiming_arm7;
 	dev->can.do_set_mode = ems_usb_set_mode;
-	dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY;
+	dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
+				      CAN_CTRLMODE_LISTENONLY;
 	init_params_sja1000(&dev->active_params);
 	dev->ems_usb_write_mode = ems_usb_write_mode_arm7;
 	dev->bulk_rd_buf_size = 64;
 	break;
 
 	case USB_CPCUSB_FD_PRODUCT_ID:
-	// Placeholder for next patchess
+		dev->can.clock.freq = EMS_USB_FD_CLOCK;
+		dev->can.bittiming_const = &ems_usb_bittiming_const_generic;
+		dev->can.data_bittiming_const = &ems_usb_bittiming_const_generic_data;
+		dev->can.do_set_bittiming = ems_usb_set_bittiming_generic;
+		dev->can.do_set_data_bittiming = ems_usb_set_bittiming_generic_data;
+		dev->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+				CAN_CTRLMODE_ONE_SHOT |
+				CAN_CTRLMODE_BERR_REPORTING |
+				CAN_CTRLMODE_FD |
+				CAN_CTRLMODE_FD_NON_ISO;
+		init_params_generic(&dev->active_params);
+		dev->bulk_rd_buf_size = 512;
 	break;
 
 	default:
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
