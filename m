Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A2230740F
	for <lists+linux-can@lfdr.de>; Thu, 28 Jan 2021 11:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhA1Krq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 28 Jan 2021 05:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhA1Krg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Jan 2021 05:47:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C13C0613D6
        for <linux-can@vger.kernel.org>; Thu, 28 Jan 2021 02:46:55 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l54pC-0000sb-E8
        for linux-can@vger.kernel.org; Thu, 28 Jan 2021 11:46:54 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 0B6DA5D06D9
        for <linux-can@vger.kernel.org>; Thu, 28 Jan 2021 10:46:51 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id B4A425D06AF;
        Thu, 28 Jan 2021 10:46:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9f9fb2cd;
        Thu, 28 Jan 2021 10:46:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6/8] can: mcp251xfd: add missing _MASK postfix to MCP251XFD_OBJ_FLAGS_DLC
Date:   Thu, 28 Jan 2021 11:46:42 +0100
Message-Id: <20210128104644.2982125-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128104644.2982125-1-mkl@pengutronix.de>
References: <20210128104644.2982125-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

As MCP251XFD_OBJ_FLAGS_DLC is a mask, add the missing _MASK postfix,
that all other masks in the driver have.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 4 ++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 5c7fdf31dce8..04870a741792 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1465,7 +1465,7 @@ mcp251xfd_hw_rx_obj_to_skb(const struct mcp251xfd_priv *priv,
 					hw_rx_obj->id);
 	}
 
-	dlc = FIELD_GET(MCP251XFD_OBJ_FLAGS_DLC, hw_rx_obj->flags);
+	dlc = FIELD_GET(MCP251XFD_OBJ_FLAGS_DLC_MASK, hw_rx_obj->flags);
 
 	/* CANFD */
 	if (hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_FDF) {
@@ -2359,7 +2359,7 @@ mcp251xfd_tx_obj_from_skb(const struct mcp251xfd_priv *priv,
 				     priv->can.ctrlmode);
 	}
 
-	flags |= FIELD_PREP(MCP251XFD_OBJ_FLAGS_DLC, dlc);
+	flags |= FIELD_PREP(MCP251XFD_OBJ_FLAGS_DLC_MASK, dlc);
 
 	load_buf = &tx_obj->buf;
 	if (priv->devtype_data.quirks & MCP251XFD_QUIRK_CRC_TX)
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index cb6398c2a560..480bd4480bdf 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -305,7 +305,7 @@
 #define MCP251XFD_OBJ_FLAGS_BRS BIT(6)
 #define MCP251XFD_OBJ_FLAGS_RTR BIT(5)
 #define MCP251XFD_OBJ_FLAGS_IDE BIT(4)
-#define MCP251XFD_OBJ_FLAGS_DLC GENMASK(3, 0)
+#define MCP251XFD_OBJ_FLAGS_DLC_MASK GENMASK(3, 0)
 
 #define MCP251XFD_REG_FRAME_EFF_SID_MASK GENMASK(28, 18)
 #define MCP251XFD_REG_FRAME_EFF_EID_MASK GENMASK(17, 0)
-- 
2.29.2


