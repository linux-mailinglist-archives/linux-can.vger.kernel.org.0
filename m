Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C004073998C
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 10:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjFVI1f (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 04:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjFVI1a (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 04:27:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DCF269A
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 01:27:11 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qCFen-0002Yr-Bp
        for linux-can@vger.kernel.org; Thu, 22 Jun 2023 10:27:09 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 81B961DF3B1
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:27:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 315591DF356;
        Thu, 22 Jun 2023 08:27:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9eb1eef3;
        Thu, 22 Jun 2023 08:27:00 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Frank Jungclaus <frank.jungclaus@esd.eu>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 10/33] can: esd_usb: Use consistent prefix ESD_USB_ for macros
Date:   Thu, 22 Jun 2023 10:26:35 +0200
Message-Id: <20230622082658.571150-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622082658.571150-1-mkl@pengutronix.de>
References: <20230622082658.571150-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
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

From: Frank Jungclaus <frank.jungclaus@esd.eu>

Rename the following macros:
- ESD_RTR to ESD_USB_RTR
- ESD_EV_CAN_ERROR_EXT to ESD_USB_EV_CAN_ERROR_EXT

Additionally remove the double newline trailing to definition
of ESD_USB_RTR.

Signed-off-by: Frank Jungclaus <frank.jungclaus@esd.eu>
Link: https://lore.kernel.org/r/20230523173105.3175086-3-frank.jungclaus@esd.eu
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index d40a04db7458..6201637ac0ff 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -43,8 +43,7 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB_CMD_IDADD		6 /* also used for IDADD_REPLY */
 
 /* esd CAN message flags - dlc field */
-#define ESD_RTR	BIT(4)
-
+#define ESD_USB_RTR	BIT(4)
 
 /* esd CAN message flags - id field */
 #define ESD_USB_EXTID	BIT(29)
@@ -52,7 +51,7 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB_IDMASK	GENMASK(28, 0)
 
 /* esd CAN event ids */
-#define ESD_EV_CAN_ERROR_EXT	2 /* CAN controller specific diagnostic data */
+#define ESD_USB_EV_CAN_ERROR_EXT	2 /* CAN controller specific diagnostic data */
 
 /* baudrate message flags */
 #define ESD_USB_LOM	BIT(30) /* Listen Only Mode */
@@ -228,7 +227,7 @@ static void esd_usb_rx_event(struct esd_usb_net_priv *priv,
 	struct sk_buff *skb;
 	u32 id = le32_to_cpu(msg->rx.id) & ESD_USB_IDMASK;
 
-	if (id == ESD_EV_CAN_ERROR_EXT) {
+	if (id == ESD_USB_EV_CAN_ERROR_EXT) {
 		u8 state = msg->rx.ev_can_err_ext.status;
 		u8 ecc = msg->rx.ev_can_err_ext.ecc;
 
@@ -341,13 +340,13 @@ static void esd_usb_rx_can_msg(struct esd_usb_net_priv *priv,
 		}
 
 		cf->can_id = id & ESD_USB_IDMASK;
-		can_frame_set_cc_len(cf, msg->rx.dlc & ~ESD_RTR,
+		can_frame_set_cc_len(cf, msg->rx.dlc & ~ESD_USB_RTR,
 				     priv->can.ctrlmode);
 
 		if (id & ESD_USB_EXTID)
 			cf->can_id |= CAN_EFF_FLAG;
 
-		if (msg->rx.dlc & ESD_RTR) {
+		if (msg->rx.dlc & ESD_USB_RTR) {
 			cf->can_id |= CAN_RTR_FLAG;
 		} else {
 			for (i = 0; i < cf->len; i++)
@@ -767,7 +766,7 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	msg->tx.id = cpu_to_le32(cf->can_id & CAN_ERR_MASK);
 
 	if (cf->can_id & CAN_RTR_FLAG)
-		msg->tx.dlc |= ESD_RTR;
+		msg->tx.dlc |= ESD_USB_RTR;
 
 	if (cf->can_id & CAN_EFF_FLAG)
 		msg->tx.id |= cpu_to_le32(ESD_USB_EXTID);
-- 
2.40.1


