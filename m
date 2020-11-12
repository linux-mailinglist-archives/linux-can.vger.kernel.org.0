Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF7F2B0C39
	for <lists+linux-can@lfdr.de>; Thu, 12 Nov 2020 19:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKLSEx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Nov 2020 13:04:53 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:33143 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgKLSEx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Nov 2020 13:04:53 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 163FAFFA5D
        for <linux-can@vger.kernel.org>; Thu, 12 Nov 2020 18:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id coxSmqIfY0KP for <linux-can@vger.kernel.org>;
        Thu, 12 Nov 2020 19:04:50 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 09/16] can: ems_usb: Added CAN controller initialization for CAN FD
Date:   Thu, 12 Nov 2020 19:03:39 +0100
Message-Id: <20201112180346.29070-10-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
References: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch added initialization code for CPC-USB/FD 

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 136 ++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 41f9fb126e0a..96012052a375 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -56,6 +56,7 @@ MODULE_LICENSE("GPL v2");
 #define CPC_CMD_TYPE_CLEAR_CMD_QUEUE 28 /* clear CPC_CMD queue */
 
 #define CPC_CC_TYPE_SJA1000 2 /* NXP CAN controller */
+#define CPC_CC_TYPE_GENERIC 6 /* GENERIC CAN controller */
 
 #define CPC_CAN_ECODE_ERRFRAME 0x01 /* Ecode type */
 
@@ -77,6 +78,7 @@ MODULE_LICENSE("GPL v2");
 #define USB_CPCUSB_VENDOR_ID 0x12D6
 
 #define USB_CPCUSB_ARM7_PRODUCT_ID 0x0444
+#define USB_CPCUSB_FD_PRODUCT_ID   0x0544
 
 /* Mode register NXP LPC2119/SJA1000 CAN Controller */
 #define SJA1000_MOD_NORMAL 0x00
@@ -104,6 +106,17 @@ MODULE_LICENSE("GPL v2");
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
 
@@ -265,6 +278,7 @@ MODULE_DEVICE_TABLE(usb, ems_usb_table);
 #define CPC_HEADER_SIZE     4
 #define INTR_IN_BUFFER_SIZE 4
 #define CPC_USB_ARM7_RX_BUFFER_SIZE 64
+#define CPC_USB_FD_RX_BUFFER_SIZE 512
 
 #define MAX_RX_URBS 10
 #define MAX_TX_URBS 10
@@ -974,6 +988,30 @@ static const struct can_bittiming_const ems_usb_bittiming_const_arm7 = {
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
@@ -1019,6 +1057,69 @@ static int ems_usb_set_bittiming_arm7(struct net_device *netdev)
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
+	gcp->can_clk = cpu_to_le32(dev->can.clock.freq);
+
+	gcp->nominal_bitrate.tseg1 = cpu_to_le16(bt->prop_seg + bt->phase_seg1);
+	gcp->nominal_bitrate.tseg2 = cpu_to_le16(bt->phase_seg2);
+	gcp->nominal_bitrate.brp = cpu_to_le16(bt->brp);
+	gcp->nominal_bitrate.sjw = cpu_to_le16(bt->sjw);
+
+	err = ems_usb_clear_cmd_queue(dev);
+	if (err)
+		return err;
+
+	netdev_dbg(netdev, "Set nominal bitrate: CAN Clock: %uMHz, Tseg1: %u, Tseg2: %u, BRP: %u, SJW: %u\n",
+		   le32_to_cpu(gcp->can_clk) / 1000000,
+		   gcp->nominal_bitrate.tseg1,
+		   gcp->nominal_bitrate.tseg2,
+		   gcp->nominal_bitrate.brp,
+		   gcp->nominal_bitrate.sjw);
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
+	if (!(dev->can.ctrlmode & CAN_CTRLMODE_FD))
+		return 0;
+	gcp->config |= cpu_to_le32(CPC_GENERICCONF_FD);
+
+	if (dev->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
+		gcp->config |= cpu_to_le32(CPC_GENERICCONF_FD_BOSCH);
+
+	gcp->data_bitrate.tseg1 = cpu_to_le16(bt->prop_seg + bt->phase_seg1);
+	gcp->data_bitrate.tseg2 = cpu_to_le16(bt->phase_seg2);
+	gcp->data_bitrate.brp = cpu_to_le16(bt->brp);
+	gcp->data_bitrate.sjw = cpu_to_le16(bt->sjw);
+
+	err = ems_usb_clear_cmd_queue(dev);
+	if (err)
+		return err;
+
+	netdev_dbg(netdev, "Set data bitrate: Tseg1: %u, Tseg2: %u, BRP: %u, SJW: %u\n",
+		   gcp->data_bitrate.tseg1,
+		   gcp->data_bitrate.tseg2,
+		   gcp->data_bitrate.brp,
+		   gcp->data_bitrate.sjw);
+
+	return ems_usb_command_msg(dev, &dev->active_params);
+}
+
 static void init_params_sja1000(struct ems_cpc_msg *msg)
 {
 	struct cpc_sja1000_params *sja1000 =
@@ -1027,6 +1128,8 @@ static void init_params_sja1000(struct ems_cpc_msg *msg)
 	msg->type = CPC_CMD_TYPE_CAN_PARAMS;
 	msg->length = sizeof(struct cpc_can_params);
 	msg->msgid = 0;
+	msg->ts_sec = 0;
+	msg->ts_nsec = 0;
 
 	msg->msg.can_params.cc_type = CPC_CC_TYPE_SJA1000;
 
@@ -1049,6 +1152,24 @@ static void init_params_sja1000(struct ems_cpc_msg *msg)
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
+	gcp->config = cpu_to_le32(CPC_GENERICCONF_RESET_MODE);
+	gcp->can_clk = cpu_to_le32(EMS_USB_FD_CLOCK);
+}
+
 /* probe function for new CPC-USB devices
  */
 static int ems_usb_probe(struct usb_interface *intf,
@@ -1085,6 +1206,21 @@ static int ems_usb_probe(struct usb_interface *intf,
 		dev->bulk_rd_buf_size = CPC_USB_ARM7_RX_BUFFER_SIZE;
 	break;
 
+	case USB_CPCUSB_FD_PRODUCT_ID:
+		dev->can.clock.freq = EMS_USB_FD_CLOCK;
+		dev->can.bittiming_const = &ems_usb_bittiming_const_generic;
+		dev->can.data_bittiming_const = &ems_usb_bittiming_const_generic_data;
+		dev->can.do_set_bittiming = ems_usb_set_bittiming_generic;
+		dev->can.do_set_data_bittiming = ems_usb_set_bittiming_generic_data;
+		dev->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+					      CAN_CTRLMODE_ONE_SHOT |
+					      CAN_CTRLMODE_BERR_REPORTING |
+					      CAN_CTRLMODE_FD |
+					      CAN_CTRLMODE_FD_NON_ISO;
+		init_params_generic(&dev->active_params);
+		dev->bulk_rd_buf_size = CPC_USB_FD_RX_BUFFER_SIZE;
+	break;
+
 	default:
 		err = -ENODEV;
 		goto cleanup_candev;
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
