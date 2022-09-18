Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FFA5BBFC4
	for <lists+linux-can@lfdr.de>; Sun, 18 Sep 2022 22:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiIRUX5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 18 Sep 2022 16:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIRUX4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 18 Sep 2022 16:23:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8709713E97
        for <linux-can@vger.kernel.org>; Sun, 18 Sep 2022 13:23:53 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oa0pT-0005qR-78
        for linux-can@vger.kernel.org; Sun, 18 Sep 2022 22:23:51 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 908B6E56CC
        for <linux-can@vger.kernel.org>; Sun, 18 Sep 2022 20:23:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E1D5BE56C9;
        Sun, 18 Sep 2022 20:23:49 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8c03e7df;
        Sun, 18 Sep 2022 20:23:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Daniel Trevitz <daniel.trevitz@wika.com>,
        Ryan Edwards <ryan.edwards@gmail.com>
Subject: [PATCH] can: gs_usb: add switchable termination support
Date:   Sun, 18 Sep 2022 22:23:48 +0200
Message-Id: <20220918202348.675850-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The candleLight community is working on switchable termination support
for the candleLight firmware. As the the Linux CAN framework supports
switchable termination add this feature to the gs_usb driver.

Devices supporting the feature should set the
GS_CAN_FEATURE_TERMINATION and implement the
GS_USB_BREQ_SET_TERMINATION and GS_USB_BREQ_GET_TERMINATION control
messages.

For now the driver assumes for activated termination the standard
termination of 120Ω.

Link: https://github.com/candle-usb/candleLight_fw/issues/92
Link: https://github.com/candle-usb/candleLight_fw/pull/108
Cc: Daniel Trevitz <daniel.trevitz@wika.com>
Cc: Ryan Edwards <ryan.edwards@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 77 +++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index cc363f1935ce..2d6c1fe0c8d3 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -64,6 +64,8 @@ enum gs_usb_breq {
 	GS_USB_BREQ_SET_USER_ID,
 	GS_USB_BREQ_DATA_BITTIMING,
 	GS_USB_BREQ_BT_CONST_EXT,
+	GS_USB_BREQ_SET_TERMINATION,
+	GS_USB_BREQ_GET_TERMINATION,
 };
 
 enum gs_can_mode {
@@ -87,6 +89,14 @@ enum gs_can_identify_mode {
 	GS_CAN_IDENTIFY_ON
 };
 
+enum gs_can_termination_state {
+	GS_CAN_TERMINATION_STATE_OFF = 0,
+	GS_CAN_TERMINATION_STATE_ON
+};
+
+#define GS_USB_TERMINATION_DISABLED CAN_TERMINATION_DISABLED
+#define GS_USB_TERMINATION_ENABLED 120
+
 /* data types passed between host and device */
 
 /* The firmware on the original USB2CAN by Geschwister Schneider
@@ -123,6 +133,7 @@ struct gs_device_config {
 #define GS_CAN_MODE_FD BIT(8)
 /* GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX BIT(9) */
 /* GS_CAN_FEATURE_BT_CONST_EXT BIT(10) */
+/* GS_CAN_FEATURE_TERMINATION BIT(11) */
 
 struct gs_device_mode {
 	__le32 mode;
@@ -147,6 +158,10 @@ struct gs_identify_mode {
 	__le32 mode;
 } __packed;
 
+struct gs_termination_state {
+	__le32 state;
+} __packed;
+
 #define GS_CAN_FEATURE_LISTEN_ONLY BIT(0)
 #define GS_CAN_FEATURE_LOOP_BACK BIT(1)
 #define GS_CAN_FEATURE_TRIPLE_SAMPLE BIT(2)
@@ -158,7 +173,8 @@ struct gs_identify_mode {
 #define GS_CAN_FEATURE_FD BIT(8)
 #define GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX BIT(9)
 #define GS_CAN_FEATURE_BT_CONST_EXT BIT(10)
-#define GS_CAN_FEATURE_MASK GENMASK(10, 0)
+#define GS_CAN_FEATURE_TERMINATION BIT(11)
+#define GS_CAN_FEATURE_MASK GENMASK(11, 0)
 
 /* internal quirks - keep in GS_CAN_FEATURE space for now */
 
@@ -1117,6 +1133,59 @@ static const struct ethtool_ops gs_usb_ethtool_ops = {
 	.get_ts_info = gs_usb_get_ts_info,
 };
 
+static int gs_usb_get_termination(struct net_device *netdev, u16 *term)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct gs_termination_state state;
+	int rc;
+
+	rc = usb_control_msg_recv(interface_to_usbdev(dev->iface), 0,
+				  GS_USB_BREQ_GET_TERMINATION,
+				  USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+				  dev->channel, 0,
+				  &state, sizeof(state), 1000,
+				  GFP_KERNEL);
+
+	return rc;
+}
+
+static int gs_usb_set_termination(struct net_device *netdev, u16 term)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct gs_termination_state state;
+	u16 actual_term;
+	int rc;
+
+	if (term == GS_USB_TERMINATION_ENABLED)
+		state.state = cpu_to_le32(GS_CAN_TERMINATION_STATE_ON);
+	else
+		state.state = cpu_to_le32(GS_CAN_TERMINATION_STATE_OFF);
+
+	rc = usb_control_msg_send(interface_to_usbdev(dev->iface), 0,
+				  GS_USB_BREQ_SET_TERMINATION,
+				  USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+				  dev->channel, 0,
+				  &state, sizeof(state), 1000,
+				  GFP_KERNEL);
+
+	if (rc)
+		return rc;
+
+	rc = gs_usb_get_termination(netdev, &actual_term);
+	if (rc)
+		return rc;
+
+	if (term != actual_term)
+		return -EIO;
+
+	return rc;
+}
+
+static const u16 gs_usb_termination_const[] = {
+	GS_USB_TERMINATION_DISABLED,
+	GS_USB_TERMINATION_ENABLED
+};
+
 static struct gs_can *gs_make_candev(unsigned int channel,
 				     struct usb_interface *intf,
 				     struct gs_device_config *dconf)
@@ -1217,6 +1286,12 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->can.do_set_data_bittiming = gs_usb_set_data_bittiming;
 	}
 
+	if (feature & GS_CAN_FEATURE_TERMINATION) {
+		dev->can.termination_const = gs_usb_termination_const;
+		dev->can.termination_const_cnt = ARRAY_SIZE(gs_usb_termination_const);
+		dev->can.do_set_termination = gs_usb_set_termination;
+	}
+
 	/* The CANtact Pro from LinkLayer Labs is based on the
 	 * LPC54616 µC, which is affected by the NXP LPC USB transfer
 	 * erratum. However, the current firmware (version 2) doesn't
-- 
2.35.1


