Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8560E739988
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 10:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjFVI1c (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 04:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjFVI1Z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 04:27:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D412683
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 01:27:08 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qCFek-0002UR-HO
        for linux-can@vger.kernel.org; Thu, 22 Jun 2023 10:27:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 915ED1DF385
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:27:03 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 98A3F1DF345;
        Thu, 22 Jun 2023 08:27:01 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a8b3b864;
        Thu, 22 Jun 2023 08:27:00 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 06/33] can: esd_usb: Prefix all structures with the device name
Date:   Thu, 22 Jun 2023 10:26:31 +0200
Message-Id: <20230622082658.571150-7-mkl@pengutronix.de>
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

Prefix all the structures with the device name.
For commonly used structures make use of (the module name) esd_usb_.
For esd CAN-USB/2 and CAN-USB/Micro specific structures use
esd_usb_2_ and esd_usb_m.

Link: https://lore.kernel.org/all/CAMZ6RqLaDNy-fZ2G0+QMhUEckkXLL+ZyELVSDFmqpd++aBzZQg@mail.gmail.com/
Suggested-by: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Signed-off-by: Frank Jungclaus <frank.jungclaus@esd.eu>
Link: https://lore.kernel.org/r/20230519195600.420644-5-frank.jungclaus@esd.eu
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 44 +++++++++++++++++------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index b7d5a82d602b..842e4dd187d4 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -89,13 +89,13 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB_MAX_RX_URBS		4
 #define ESD_USB_MAX_TX_URBS		16 /* must be power of 2 */
 
-struct header_msg {
+struct esd_usb_header_msg {
 	u8 len; /* len is always the total message length in 32bit words */
 	u8 cmd;
 	u8 rsvd[2];
 };
 
-struct version_msg {
+struct esd_usb_version_msg {
 	u8 len;
 	u8 cmd;
 	u8 rsvd;
@@ -103,7 +103,7 @@ struct version_msg {
 	__le32 drv_version;
 };
 
-struct version_reply_msg {
+struct esd_usb_version_reply_msg {
 	u8 len;
 	u8 cmd;
 	u8 nets;
@@ -114,7 +114,7 @@ struct version_reply_msg {
 	__le32 ts;
 };
 
-struct rx_msg {
+struct esd_usb_rx_msg {
 	u8 len;
 	u8 cmd;
 	u8 net;
@@ -132,7 +132,7 @@ struct rx_msg {
 	};
 };
 
-struct tx_msg {
+struct esd_usb_tx_msg {
 	u8 len;
 	u8 cmd;
 	u8 net;
@@ -142,7 +142,7 @@ struct tx_msg {
 	u8 data[CAN_MAX_DLEN];
 };
 
-struct tx_done_msg {
+struct esd_usb_tx_done_msg {
 	u8 len;
 	u8 cmd;
 	u8 net;
@@ -151,7 +151,7 @@ struct tx_done_msg {
 	__le32 ts;
 };
 
-struct id_filter_msg {
+struct esd_usb_id_filter_msg {
 	u8 len;
 	u8 cmd;
 	u8 net;
@@ -159,7 +159,7 @@ struct id_filter_msg {
 	__le32 mask[ESD_USB_MAX_ID_SEGMENT + 1];
 };
 
-struct set_baudrate_msg {
+struct esd_usb_set_baudrate_msg {
 	u8 len;
 	u8 cmd;
 	u8 net;
@@ -169,14 +169,14 @@ struct set_baudrate_msg {
 
 /* Main message type used between library and application */
 union __packed esd_usb_msg {
-	struct header_msg hdr;
-	struct version_msg version;
-	struct version_reply_msg version_reply;
-	struct rx_msg rx;
-	struct tx_msg tx;
-	struct tx_done_msg txdone;
-	struct set_baudrate_msg setbaud;
-	struct id_filter_msg filter;
+	struct esd_usb_header_msg hdr;
+	struct esd_usb_version_msg version;
+	struct esd_usb_version_reply_msg version_reply;
+	struct esd_usb_rx_msg rx;
+	struct esd_usb_tx_msg tx;
+	struct esd_usb_tx_done_msg txdone;
+	struct esd_usb_set_baudrate_msg setbaud;
+	struct esd_usb_id_filter_msg filter;
 };
 
 static struct usb_device_id esd_usb_table[] = {
@@ -899,8 +899,8 @@ static const struct ethtool_ops esd_usb_ethtool_ops = {
 	.get_ts_info = ethtool_op_get_ts_info,
 };
 
-static const struct can_bittiming_const esd_usb2_bittiming_const = {
-	.name = "esd_usb2",
+static const struct can_bittiming_const esd_usb_2_bittiming_const = {
+	.name = "esd_usb_2",
 	.tseg1_min = 1,
 	.tseg1_max = 16,
 	.tseg2_min = 1,
@@ -911,9 +911,9 @@ static const struct can_bittiming_const esd_usb2_bittiming_const = {
 	.brp_inc = 1,
 };
 
-static int esd_usb2_set_bittiming(struct net_device *netdev)
+static int esd_usb_2_set_bittiming(struct net_device *netdev)
 {
-	const struct can_bittiming_const *btc = &esd_usb2_bittiming_const;
+	const struct can_bittiming_const *btc = &esd_usb_2_bittiming_const;
 	struct esd_usb_net_priv *priv = netdev_priv(netdev);
 	struct can_bittiming *bt = &priv->can.bittiming;
 	union esd_usb_msg *msg;
@@ -1026,8 +1026,8 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 	}
 
-	priv->can.bittiming_const = &esd_usb2_bittiming_const;
-	priv->can.do_set_bittiming = esd_usb2_set_bittiming;
+	priv->can.bittiming_const = &esd_usb_2_bittiming_const;
+	priv->can.do_set_bittiming = esd_usb_2_set_bittiming;
 	priv->can.do_set_mode = esd_usb_set_mode;
 	priv->can.do_get_berr_counter = esd_usb_get_berr_counter;
 
-- 
2.40.1


