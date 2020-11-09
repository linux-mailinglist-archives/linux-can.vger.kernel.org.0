Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68A72ABFF9
	for <lists+linux-can@lfdr.de>; Mon,  9 Nov 2020 16:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbgKIPhW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Nov 2020 10:37:22 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:33836 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbgKIPhV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Nov 2020 10:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1604936236;
        s=strato-dkim-0002; d=hartkopp.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ShD5wP8N+wA7/jyGa7FFyWPH1RJMVxvRkuGIWHO4RkY=;
        b=ap1SJ8YQnFt+WLFl2sYZW9FKQJFS99LF/CvSnKnNx5d1pSLSUt/JqHQOhNVKG3wCYu
        f0a8aHx3QB2elAIgP1mvOh3gtMiA0DmGkMUBWP2qkU4DslAOz86diijqEEOoDCAkf9jv
        PNo4nCOedqDT56dC4K42sSjQDbsK8N46cHS/1ZThnJKz8gl9nz/oIi/mfuovyqLg9QCc
        XAEhUkx0zcpqQdGV2xd+4grek+fAuUkMBFj5YwN4Dowp1kA/rYY7VAPbRG/eEHttbS5m
        Yj59UCFxYQYUncZXV45IfoMLEniG/pVc3wyd7GSJYTEzV7/pvM4B6jK8J6pkuWp3XcM2
        /Mgg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0lu8GW272ZqqIaA=="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
        by smtp.strato.de (RZmta 47.3.3 DYNA|AUTH)
        with ESMTPSA id V0298cwA9FbD85Z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 9 Nov 2020 16:37:13 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org, mkl@pengutronix.de,
        mailhol.vincent@wanadoo.fr
Cc:     netdev@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v5 3/8] can: remove obsolete get_canfd_dlc() macro
Date:   Mon,  9 Nov 2020 16:36:52 +0100
Message-Id: <20201109153657.17897-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201109153657.17897-1-socketcan@hartkopp.net>
References: <20201109153657.17897-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The macro was always used together with can_dlc2len() which sanitizes the
given dlc value on its own.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/flexcan.c                         | 2 +-
 drivers/net/can/peak_canfd/peak_canfd.c           | 2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c    | 2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c        | 2 +-
 include/linux/can/dev.h                           | 1 -
 include/linux/can/dev/peak_canfd.h                | 2 +-
 7 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index d77276cd1d99..e76fb1500fa1 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -996,11 +996,11 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 		cfd->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
 	else
 		cfd->can_id = (reg_id >> 18) & CAN_SFF_MASK;
 
 	if (reg_ctrl & FLEXCAN_MB_CNT_EDL) {
-		cfd->len = can_dlc2len(get_canfd_dlc((reg_ctrl >> 16) & 0xf));
+		cfd->len = can_dlc2len((reg_ctrl >> 16) & 0xf);
 
 		if (reg_ctrl & FLEXCAN_MB_CNT_BRS)
 			cfd->flags |= CANFD_BRS;
 	} else {
 		cfd->len = can_cc_dlc2len((reg_ctrl >> 16) & 0xf);
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 9ea2adea3f0f..c6077e07214e 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -255,11 +255,11 @@ static int pucan_handle_can_rx(struct peak_canfd_priv *priv,
 	struct sk_buff *skb;
 	const u16 rx_msg_flags = le16_to_cpu(msg->flags);
 	u8 cf_len;
 
 	if (rx_msg_flags & PUCAN_MSG_EXT_DATA_LEN)
-		cf_len = can_dlc2len(get_canfd_dlc(pucan_msg_get_dlc(msg)));
+		cf_len = can_dlc2len(pucan_msg_get_dlc(msg));
 	else
 		cf_len = can_cc_dlc2len(pucan_msg_get_dlc(msg));
 
 	/* if this frame is an echo, */
 	if (rx_msg_flags & PUCAN_MSG_LOOPED_BACK) {
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index c0a08400f444..3bac7274ee5b 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1403,11 +1403,11 @@ mcp251xfd_hw_rx_obj_to_skb(const struct mcp251xfd_priv *priv,
 
 		if (hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_BRS)
 			cfd->flags |= CANFD_BRS;
 
 		dlc = FIELD_GET(MCP251XFD_OBJ_FLAGS_DLC, hw_rx_obj->flags);
-		cfd->len = can_dlc2len(get_canfd_dlc(dlc));
+		cfd->len = can_dlc2len(dlc);
 	} else {
 		if (hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_RTR)
 			cfd->can_id |= CAN_RTR_FLAG;
 
 		cfd->len = can_cc_dlc2len(FIELD_GET(MCP251XFD_OBJ_FLAGS_DLC,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 399e9698ffeb..906a3a340131 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1249,11 +1249,11 @@ static void kvaser_usb_hydra_rx_msg_ext(const struct kvaser_usb *dev,
 
 	if (flags & KVASER_USB_HYDRA_CF_FLAG_OVERRUN)
 		kvaser_usb_can_rx_over_error(priv->netdev);
 
 	if (flags & KVASER_USB_HYDRA_CF_FLAG_FDF) {
-		cf->len = can_dlc2len(get_canfd_dlc(dlc));
+		cf->len = can_dlc2len(dlc);
 		if (flags & KVASER_USB_HYDRA_CF_FLAG_BRS)
 			cf->flags |= CANFD_BRS;
 		if (flags & KVASER_USB_HYDRA_CF_FLAG_ESI)
 			cf->flags |= CANFD_ESI;
 	} else {
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 1f08dd22b3d5..1233ef20646a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -490,11 +490,11 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
 			cfd->flags |= CANFD_BRS;
 
 		if (rx_msg_flags & PUCAN_MSG_ERROR_STATE_IND)
 			cfd->flags |= CANFD_ESI;
 
-		cfd->len = can_dlc2len(get_canfd_dlc(pucan_msg_get_dlc(rm)));
+		cfd->len = can_dlc2len(pucan_msg_get_dlc(rm));
 	} else {
 		/* CAN 2.0 frame case */
 		skb = alloc_can_skb(netdev, (struct can_frame **)&cfd);
 		if (!skb)
 			return -ENOMEM;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 9bc84c6978ec..802606e36b58 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -103,11 +103,10 @@ static inline unsigned int can_bit_time(const struct can_bittiming *bt)
  *
  * To be used in the CAN netdriver receive path to ensure conformance with
  * ISO 11898-1 Chapter 8.4.2.3 (DLC field)
  */
 #define can_cc_dlc2len(dlc)	(min_t(u8, (dlc), CAN_MAX_DLEN))
-#define get_canfd_dlc(dlc)	(min_t(u8, (dlc), CANFD_MAX_DLC))
 
 /* Check for outgoing skbs that have not been created by the CAN subsystem */
 static inline bool can_skb_headroom_valid(struct net_device *dev,
 					  struct sk_buff *skb)
 {
diff --git a/include/linux/can/dev/peak_canfd.h b/include/linux/can/dev/peak_canfd.h
index 5fd627e9da19..f38772fd0c07 100644
--- a/include/linux/can/dev/peak_canfd.h
+++ b/include/linux/can/dev/peak_canfd.h
@@ -280,11 +280,11 @@ static inline int pucan_msg_get_channel(const struct pucan_rx_msg *msg)
 {
 	return msg->channel_dlc & 0xf;
 }
 
 /* return the dlc value from any received message channel_dlc field */
-static inline int pucan_msg_get_dlc(const struct pucan_rx_msg *msg)
+static inline u8 pucan_msg_get_dlc(const struct pucan_rx_msg *msg)
 {
 	return msg->channel_dlc >> 4;
 }
 
 static inline int pucan_ermsg_get_channel(const struct pucan_error_msg *msg)
-- 
2.28.0

