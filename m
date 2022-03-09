Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD394D2F37
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 13:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiCIMmn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 07:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiCIMmm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 07:42:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9CD177750
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 04:41:43 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nRvdN-0002nK-PP
        for linux-can@vger.kernel.org; Wed, 09 Mar 2022 13:41:41 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 34BCE46BD2
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 12:41:39 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8629F46BBD;
        Wed,  9 Mar 2022 12:41:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2437fd74;
        Wed, 9 Mar 2022 12:41:33 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Peter Fink <pfink@christ-es.de>,
        =?UTF-8?q?Christoph=20M=C3=B6hring?= <cmoehring@christ-es.de>,
        Alexander Schartner <aschartner@christ-es.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 16/21] can: gs_usb: add usb quirk for NXP LPC546xx controllers
Date:   Wed,  9 Mar 2022 13:41:27 +0100
Message-Id: <20220309124132.291861-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309124132.291861-1-mkl@pengutronix.de>
References: <20220309124132.291861-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Peter Fink <pfink@christ-es.de>

Introduce a workaround for a NXP chip errata on LPC546xx
controllers (Errata sheet LPC546xx / USB.15).

According to the document corruption can occur when the following
conditions are met:
* A TX (IN) transfer happens after a RX (OUT) transfer.
* The RX (OUT) transfer length is 4 + N * 16 (N >= 0) bytes.

Even though the struct gs_host_frame has a size of 76 bytes for a FD
frame, which does not apply to the above rule, corruption could be
seen.

Adding a dummy byte to break the second condition also on transfer
lengths with 4 + N * 8 bytes reliably circumvents USB transfer data
corruption.

The firmware can now request this quirk by setting
GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX.

Signed-off-by: Peter Fink <pfink@christ-es.de>
Signed-off-by: Christoph Möhring <cmoehring@christ-es.de>
Signed-off-by: Alexander Schartner <aschartner@christ-es.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 29389de99326..b0651789ccd3 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -9,6 +9,7 @@
  * Many thanks to all socketcan devs!
  */
 
+#include <linux/bitfield.h>
 #include <linux/ethtool.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -100,6 +101,7 @@ struct gs_device_config {
 /* GS_CAN_FEATURE_USER_ID BIT(6) */
 #define GS_CAN_MODE_PAD_PKTS_TO_MAX_PKT_SIZE BIT(7)
 #define GS_CAN_MODE_FD BIT(8)
+/* GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX BIT(9) */
 
 struct gs_device_mode {
 	__le32 mode;
@@ -133,6 +135,8 @@ struct gs_identify_mode {
 #define GS_CAN_FEATURE_USER_ID BIT(6)
 #define GS_CAN_FEATURE_PAD_PKTS_TO_MAX_PKT_SIZE BIT(7)
 #define GS_CAN_FEATURE_FD BIT(8)
+#define GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX BIT(9)
+#define GS_CAN_FEATURE_MASK GENMASK(9, 0)
 
 struct gs_device_bt_const {
 	__le32 feature;
@@ -156,10 +160,20 @@ struct classic_can {
 	u8 data[8];
 } __packed;
 
+struct classic_can_quirk {
+	u8 data[8];
+	u8 quirk;
+} __packed;
+
 struct canfd {
 	u8 data[64];
 } __packed;
 
+struct canfd_quirk {
+	u8 data[64];
+	u8 quirk;
+} __packed;
+
 struct gs_host_frame {
 	u32 echo_id;
 	__le32 can_id;
@@ -171,7 +185,9 @@ struct gs_host_frame {
 
 	union {
 		DECLARE_FLEX_ARRAY(struct classic_can, classic_can);
+		DECLARE_FLEX_ARRAY(struct classic_can_quirk, classic_can_quirk);
 		DECLARE_FLEX_ARRAY(struct canfd, canfd);
+		DECLARE_FLEX_ARRAY(struct canfd_quirk, canfd_quirk);
 	};
 } __packed;
 /* The GS USB devices make use of the same flags and masks as in
@@ -204,6 +220,7 @@ struct gs_can {
 	struct can_bittiming_const bt_const;
 	unsigned int channel;	/* channel number */
 
+	u32 feature;
 	unsigned int hf_size_tx;
 
 	/* This lock prevents a race condition between xmit and receive. */
@@ -666,9 +683,16 @@ static int gs_can_open(struct net_device *netdev)
 	ctrlmode = dev->can.ctrlmode;
 	if (ctrlmode & CAN_CTRLMODE_FD) {
 		flags |= GS_CAN_MODE_FD;
-		dev->hf_size_tx = struct_size(hf, canfd, 1);
+
+		if (dev->feature & GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX)
+			dev->hf_size_tx = struct_size(hf, canfd_quirk, 1);
+		else
+			dev->hf_size_tx = struct_size(hf, canfd, 1);
 	} else {
-		dev->hf_size_tx = struct_size(hf, classic_can, 1);
+		if (dev->feature & GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX)
+			dev->hf_size_tx = struct_size(hf, classic_can_quirk, 1);
+		else
+			dev->hf_size_tx = struct_size(hf, classic_can, 1);
 	}
 
 	if (!parent->active_channels) {
@@ -938,6 +962,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	dev->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
 
 	feature = le32_to_cpu(bt_const->feature);
+	dev->feature = FIELD_GET(GS_CAN_FEATURE_MASK, feature);
 	if (feature & GS_CAN_FEATURE_LISTEN_ONLY)
 		dev->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
 
-- 
2.34.1


