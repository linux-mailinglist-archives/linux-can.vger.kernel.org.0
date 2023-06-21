Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB4F738503
	for <lists+linux-can@lfdr.de>; Wed, 21 Jun 2023 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjFUN32 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Jun 2023 09:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjFUN31 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Jun 2023 09:29:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE551BC6
        for <linux-can@vger.kernel.org>; Wed, 21 Jun 2023 06:29:21 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qBxtf-0006SJ-MS
        for linux-can@vger.kernel.org; Wed, 21 Jun 2023 15:29:19 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id DA8B21DE87F
        for <linux-can@vger.kernel.org>; Wed, 21 Jun 2023 13:29:17 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1B0C51DE854;
        Wed, 21 Jun 2023 13:29:16 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 14507e34;
        Wed, 21 Jun 2023 13:29:15 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Carsten Schmidt <carsten.schmidt-achim@t-online.de>,
        Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 01/33] can: kvaser_usb: Add len8_dlc support
Date:   Wed, 21 Jun 2023 15:28:42 +0200
Message-Id: <20230621132914.412546-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621132914.412546-1-mkl@pengutronix.de>
References: <20230621132914.412546-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Carsten Schmidt <carsten.schmidt-achim@t-online.de>

Add support for the Classical CAN raw DLC functionality to send and
receive DLC values from 9 .. 15.

v1: https://lore.kernel.org/all/20230506105529.4023-1-carsten.schmidt-achim@t-online.de

Signed-off-by: Carsten Schmidt <carsten.schmidt-achim@t-online.de>
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://lore.kernel.org/r/20230516125332.82894-1-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  |  2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 13 +++++++++----
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  |  6 +++---
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 7135ec851341..71ef4db5c09f 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -816,7 +816,7 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	init_completion(&priv->stop_comp);
 	init_completion(&priv->flush_comp);
 	init_completion(&priv->get_busparams_comp);
-	priv->can.ctrlmode_supported = 0;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
 
 	priv->dev = dev;
 	priv->netdev = netdev;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index ef341c4254fc..c7ba768dfe17 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1263,7 +1263,7 @@ static void kvaser_usb_hydra_rx_msg_std(const struct kvaser_usb *dev,
 	if (flags & KVASER_USB_HYDRA_CF_FLAG_OVERRUN)
 		kvaser_usb_can_rx_over_error(priv->netdev);
 
-	cf->len = can_cc_dlc2len(cmd->rx_can.dlc);
+	can_frame_set_cc_len((struct can_frame *)cf, cmd->rx_can.dlc, priv->can.ctrlmode);
 
 	if (flags & KVASER_USB_HYDRA_CF_FLAG_REMOTE_FRAME) {
 		cf->can_id |= CAN_RTR_FLAG;
@@ -1342,7 +1342,7 @@ static void kvaser_usb_hydra_rx_msg_ext(const struct kvaser_usb *dev,
 		if (flags & KVASER_USB_HYDRA_CF_FLAG_ESI)
 			cf->flags |= CANFD_ESI;
 	} else {
-		cf->len = can_cc_dlc2len(dlc);
+		can_frame_set_cc_len((struct can_frame *)cf, dlc, priv->can.ctrlmode);
 	}
 
 	if (flags & KVASER_USB_HYDRA_CF_FLAG_REMOTE_FRAME) {
@@ -1442,7 +1442,7 @@ kvaser_usb_hydra_frame_to_cmd_ext(const struct kvaser_usb_net_priv *priv,
 	struct kvaser_usb *dev = priv->dev;
 	struct kvaser_cmd_ext *cmd;
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
-	u8 dlc = can_fd_len2dlc(cf->len);
+	u8 dlc;
 	u8 nbr_of_bytes = cf->len;
 	u32 flags;
 	u32 id;
@@ -1467,6 +1467,11 @@ kvaser_usb_hydra_frame_to_cmd_ext(const struct kvaser_usb_net_priv *priv,
 
 	cmd->len = cpu_to_le16(*cmd_len);
 
+	if (can_is_canfd_skb(skb))
+		dlc = can_fd_len2dlc(cf->len);
+	else
+		dlc = can_get_cc_dlc((struct can_frame *)cf, priv->can.ctrlmode);
+
 	cmd->tx_can.databytes = nbr_of_bytes;
 	cmd->tx_can.dlc = dlc;
 
@@ -1542,7 +1547,7 @@ kvaser_usb_hydra_frame_to_cmd_std(const struct kvaser_usb_net_priv *priv,
 		id = cf->can_id & CAN_SFF_MASK;
 	}
 
-	cmd->tx_can.dlc = cf->len;
+	cmd->tx_can.dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
 
 	flags = (cf->can_id & CAN_EFF_FLAG ?
 		 KVASER_USB_HYDRA_CF_FLAG_EXTENDED_ID : 0);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 1c2f99ce4c6c..23bd7574b1c7 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -573,7 +573,7 @@ kvaser_usb_leaf_frame_to_cmd(const struct kvaser_usb_net_priv *priv,
 			cmd->u.tx_can.data[1] = cf->can_id & 0x3f;
 		}
 
-		cmd->u.tx_can.data[5] = cf->len;
+		cmd->u.tx_can.data[5] = can_get_cc_dlc(cf, priv->can.ctrlmode);
 		memcpy(&cmd->u.tx_can.data[6], cf->data, cf->len);
 
 		if (cf->can_id & CAN_RTR_FLAG)
@@ -1349,7 +1349,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 		else
 			cf->can_id &= CAN_SFF_MASK;
 
-		cf->len = can_cc_dlc2len(cmd->u.leaf.log_message.dlc);
+		can_frame_set_cc_len(cf, cmd->u.leaf.log_message.dlc & 0xF, priv->can.ctrlmode);
 
 		if (cmd->u.leaf.log_message.flags & MSG_FLAG_REMOTE_FRAME)
 			cf->can_id |= CAN_RTR_FLAG;
@@ -1367,7 +1367,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 			cf->can_id |= CAN_EFF_FLAG;
 		}
 
-		cf->len = can_cc_dlc2len(rx_data[5]);
+		can_frame_set_cc_len(cf, rx_data[5] & 0xF, priv->can.ctrlmode);
 
 		if (cmd->u.rx_can_header.flag & MSG_FLAG_REMOTE_FRAME)
 			cf->can_id |= CAN_RTR_FLAG;

base-commit: d49b9b07725f5dfa3344dc3eed59b8ccc0a0ddbc
-- 
2.40.1


