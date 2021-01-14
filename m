Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC32F64C1
	for <lists+linux-can@lfdr.de>; Thu, 14 Jan 2021 16:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbhANPgQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Jan 2021 10:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbhANPgP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Jan 2021 10:36:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047EAC0613D6
        for <linux-can@vger.kernel.org>; Thu, 14 Jan 2021 07:34:57 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l04eF-0004YX-K9
        for linux-can@vger.kernel.org; Thu, 14 Jan 2021 16:34:55 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 319185C3C7C
        for <linux-can@vger.kernel.org>; Thu, 14 Jan 2021 15:34:53 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 56FCF5C3C5D;
        Thu, 14 Jan 2021 15:34:50 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 60a187ce;
        Thu, 14 Jan 2021 15:34:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/6] can: mcp251xfd: add len8_dlc support
Date:   Thu, 14 Jan 2021 16:34:47 +0100
Message-Id: <20210114153448.1506901-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114153448.1506901-1-mkl@pengutronix.de>
References: <20210114153448.1506901-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds support for the Classical CAN raw DLC functionality to send and
receive DLC values from 9 ... 15 to the mcp251xfd driver.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index f6e684210689..9ffcfd64b904 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1438,6 +1438,7 @@ mcp251xfd_hw_rx_obj_to_skb(const struct mcp251xfd_priv *priv,
 			   struct sk_buff *skb)
 {
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+	u8 dlc;
 
 	if (hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_IDE) {
 		u32 sid, eid;
@@ -1453,9 +1454,10 @@ mcp251xfd_hw_rx_obj_to_skb(const struct mcp251xfd_priv *priv,
 					hw_rx_obj->id);
 	}
 
+	dlc = FIELD_GET(MCP251XFD_OBJ_FLAGS_DLC, hw_rx_obj->flags);
+
 	/* CANFD */
 	if (hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_FDF) {
-		u8 dlc;
 
 		if (hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_ESI)
 			cfd->flags |= CANFD_ESI;
@@ -1463,14 +1465,13 @@ mcp251xfd_hw_rx_obj_to_skb(const struct mcp251xfd_priv *priv,
 		if (hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_BRS)
 			cfd->flags |= CANFD_BRS;
 
-		dlc = FIELD_GET(MCP251XFD_OBJ_FLAGS_DLC, hw_rx_obj->flags);
 		cfd->len = can_fd_dlc2len(dlc);
 	} else {
 		if (hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_RTR)
 			cfd->can_id |= CAN_RTR_FLAG;
 
-		cfd->len = can_cc_dlc2len(FIELD_GET(MCP251XFD_OBJ_FLAGS_DLC,
-						 hw_rx_obj->flags));
+		can_frame_set_cc_len((struct can_frame *)cfd, dlc,
+				     priv->can.ctrlmode);
 	}
 
 	if (!(hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_RTR))
@@ -2322,9 +2323,7 @@ mcp251xfd_tx_obj_from_skb(const struct mcp251xfd_priv *priv,
 	 * harm, only the lower 7 bits will be transferred into the
 	 * TEF object.
 	 */
-	dlc = can_fd_len2dlc(cfd->len);
-	flags |= FIELD_PREP(MCP251XFD_OBJ_FLAGS_SEQ_MCP2518FD_MASK, seq) |
-		FIELD_PREP(MCP251XFD_OBJ_FLAGS_DLC, dlc);
+	flags |= FIELD_PREP(MCP251XFD_OBJ_FLAGS_SEQ_MCP2518FD_MASK, seq);
 
 	if (cfd->can_id & CAN_RTR_FLAG)
 		flags |= MCP251XFD_OBJ_FLAGS_RTR;
@@ -2340,8 +2339,15 @@ mcp251xfd_tx_obj_from_skb(const struct mcp251xfd_priv *priv,
 
 		if (cfd->flags & CANFD_BRS)
 			flags |= MCP251XFD_OBJ_FLAGS_BRS;
+
+		dlc = can_fd_len2dlc(cfd->len);
+	} else {
+		dlc = can_get_cc_dlc((struct can_frame *)cfd,
+				     priv->can.ctrlmode);
 	}
 
+	flags |= FIELD_PREP(MCP251XFD_OBJ_FLAGS_DLC, dlc);
+
 	load_buf = &tx_obj->buf;
 	if (priv->devtype_data.quirks & MCP251XFD_QUIRK_CRC_TX)
 		hw_tx_obj = &load_buf->crc.hw_tx_obj;
@@ -2893,7 +2899,8 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->can.data_bittiming_const = &mcp251xfd_data_bittiming_const;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING |
-		CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO;
+		CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO |
+		CAN_CTRLMODE_CC_LEN8_DLC;
 	priv->ndev = ndev;
 	priv->spi = spi;
 	priv->rx_int = rx_int;
-- 
2.29.2


