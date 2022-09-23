Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059DB5E7504
	for <lists+linux-can@lfdr.de>; Fri, 23 Sep 2022 09:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiIWHlW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Sep 2022 03:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiIWHlU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Sep 2022 03:41:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0DF128898
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 00:41:18 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1obdJF-0002XY-Ac
        for linux-can@vger.kernel.org; Fri, 23 Sep 2022 09:41:17 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A3F3FEAD38
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 07:41:16 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D14F2EAD35;
        Fri, 23 Sep 2022 07:41:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8dee51dc;
        Fri, 23 Sep 2022 07:41:14 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Daniel Trevitz <daniel.trevitz@wika.com>,
        Ryan Edwards <ryan.edwards@gmail.com>
Subject: [PATCH v2] can: gs_usb: add switchable termination support
Date:   Fri, 23 Sep 2022 09:41:14 +0200
Message-Id: <20220923074114.662045-1-mkl@pengutronix.de>
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
termination value of 120Ω.

Link: https://github.com/candle-usb/candleLight_fw/issues/92
Link: https://github.com/candle-usb/candleLight_fw/pull/108
Cc: Daniel Trevitz <daniel.trevitz@wika.com>
Cc: Ryan Edwards <ryan.edwards@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

changes since v1 https://lore.kernel.org/all/20220918211802.692405-4-mkl@pengutronix.de:
- renamed struct gs_termination_state -> struct gs_device_termination_state
- gs_make_candev(): don't fail with error, if initial
  gs_usb_get_termination() fails, only disable termination support.
  (Suggested by Daniel Trevitz)

 drivers/net/can/usb/gs_usb.c | 79 +++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 9400993ae717..f0065d40eb24 100644
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
 
+struct gs_device_termination_state {
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
 
@@ -1053,6 +1069,52 @@ static const struct ethtool_ops gs_usb_ethtool_ops = {
 	.get_ts_info = gs_usb_get_ts_info,
 };
 
+static int gs_usb_get_termination(struct net_device *netdev, u16 *term)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct gs_device_termination_state term_state;
+	int rc;
+
+	rc = usb_control_msg_recv(interface_to_usbdev(dev->iface), 0,
+				  GS_USB_BREQ_GET_TERMINATION,
+				  USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+				  dev->channel, 0,
+				  &term_state, sizeof(term_state), 1000,
+				  GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	if (term_state.state == cpu_to_le32(GS_CAN_TERMINATION_STATE_ON))
+		*term = GS_USB_TERMINATION_ENABLED;
+	else
+		*term = GS_USB_TERMINATION_DISABLED;
+
+	return 0;
+}
+
+static int gs_usb_set_termination(struct net_device *netdev, u16 term)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct gs_device_termination_state term_state;
+
+	if (term == GS_USB_TERMINATION_ENABLED)
+		term_state.state = cpu_to_le32(GS_CAN_TERMINATION_STATE_ON);
+	else
+		term_state.state = cpu_to_le32(GS_CAN_TERMINATION_STATE_OFF);
+
+	return usb_control_msg_send(interface_to_usbdev(dev->iface), 0,
+				    GS_USB_BREQ_SET_TERMINATION,
+				    USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+				    dev->channel, 0,
+				    &term_state, sizeof(term_state), 1000,
+				    GFP_KERNEL);
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
@@ -1147,6 +1209,21 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->can.do_set_data_bittiming = gs_usb_set_data_bittiming;
 	}
 
+	if (feature & GS_CAN_FEATURE_TERMINATION) {
+		rc = gs_usb_get_termination(netdev, &dev->can.termination);
+		if (rc) {
+			dev->feature &= ~GS_CAN_FEATURE_TERMINATION;
+
+			dev_info(&intf->dev,
+				 "Disabling termination support for channel %d (%pe)\n",
+				 channel, ERR_PTR(rc));
+		} else {
+			dev->can.termination_const = gs_usb_termination_const;
+			dev->can.termination_const_cnt = ARRAY_SIZE(gs_usb_termination_const);
+			dev->can.do_set_termination = gs_usb_set_termination;
+		}
+	}
+
 	/* The CANtact Pro from LinkLayer Labs is based on the
 	 * LPC54616 µC, which is affected by the NXP LPC USB transfer
 	 * erratum. However, the current firmware (version 2) doesn't
-- 
2.35.1


