Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B94A4D2F46
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 13:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiCIMmm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 07:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiCIMml (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 07:42:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6571768FC
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 04:41:42 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nRvdM-0002lw-OR
        for linux-can@vger.kernel.org; Wed, 09 Mar 2022 13:41:40 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id DA10946BCA
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 12:41:38 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9A46946BC1;
        Wed,  9 Mar 2022 12:41:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 51b52ed0;
        Wed, 9 Mar 2022 12:41:33 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 17/21] can: gs_usb: add quirk for CANtact Pro overlapping GS_USB_BREQ value
Date:   Wed,  9 Mar 2022 13:41:28 +0100
Message-Id: <20220309124132.291861-18-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309124132.291861-1-mkl@pengutronix.de>
References: <20220309124132.291861-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

For the GS_USB_BREQ_DATA_BITTIMING USB control message the CANtact Pro
firmware uses a request value, which is already used by the
candleLight firmware for a different
purpose (GS_USB_BREQ_GET_USER_ID).

This patch adds a quirk to use the CANtact Pro's value for the
GS_USB_BREQ_DATA_BITTIMING USB control message instead of the official
one.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index b0651789ccd3..1661b91de364 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -42,6 +42,7 @@ enum gs_usb_breq {
 	GS_USB_BREQ_TIMESTAMP,
 	GS_USB_BREQ_IDENTIFY,
 	GS_USB_BREQ_GET_USER_ID,
+	GS_USB_BREQ_QUIRK_CANTACT_PRO_DATA_BITTIMING = GS_USB_BREQ_GET_USER_ID,
 	GS_USB_BREQ_SET_USER_ID,
 	GS_USB_BREQ_DATA_BITTIMING,
 };
@@ -138,6 +139,13 @@ struct gs_identify_mode {
 #define GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX BIT(9)
 #define GS_CAN_FEATURE_MASK GENMASK(9, 0)
 
+/* internal quirks - keep in GS_CAN_FEATURE space for now */
+
+/* CANtact Pro original firmware:
+ * BREQ DATA_BITTIMING overlaps with GET_USER_ID
+ */
+#define GS_CAN_FEATURE_QUIRK_BREQ_CANTACT_PRO BIT(31)
+
 struct gs_device_bt_const {
 	__le32 feature;
 	__le32 fclk_can;
@@ -506,6 +514,7 @@ static int gs_usb_set_data_bittiming(struct net_device *netdev)
 	struct can_bittiming *bt = &dev->can.data_bittiming;
 	struct usb_interface *intf = dev->iface;
 	struct gs_device_bittiming *dbt;
+	u8 request = GS_USB_BREQ_DATA_BITTIMING;
 	int rc;
 
 	dbt = kmalloc(sizeof(*dbt), GFP_KERNEL);
@@ -518,10 +527,13 @@ static int gs_usb_set_data_bittiming(struct net_device *netdev)
 	dbt->sjw = cpu_to_le32(bt->sjw);
 	dbt->brp = cpu_to_le32(bt->brp);
 
+	if (dev->feature & GS_CAN_FEATURE_QUIRK_BREQ_CANTACT_PRO)
+		request = GS_USB_BREQ_QUIRK_CANTACT_PRO_DATA_BITTIMING;
+
 	/* request bit timings */
 	rc = usb_control_msg(interface_to_usbdev(intf),
 			     usb_sndctrlpipe(interface_to_usbdev(intf), 0),
-			     GS_USB_BREQ_DATA_BITTIMING,
+			     request,
 			     USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
 			     dev->channel, 0, dbt, sizeof(*dbt), 1000);
 
-- 
2.34.1


