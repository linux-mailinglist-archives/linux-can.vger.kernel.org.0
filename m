Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB16030741B
	for <lists+linux-can@lfdr.de>; Thu, 28 Jan 2021 11:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhA1KuA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 28 Jan 2021 05:50:00 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53285 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhA1Ktr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Jan 2021 05:49:47 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l54pC-0000sF-MT
        for linux-can@vger.kernel.org; Thu, 28 Jan 2021 11:46:54 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 093F05D06D8
        for <linux-can@vger.kernel.org>; Thu, 28 Jan 2021 10:46:51 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8D41A5D06AD;
        Thu, 28 Jan 2021 10:46:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 694f10c0;
        Thu, 28 Jan 2021 10:46:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/8] can: mcp251xfd: unify error messages and commets
Date:   Thu, 28 Jan 2021 11:46:41 +0100
Message-Id: <20210128104644.2982125-6-mkl@pengutronix.de>
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

This patch unifies the error messages:
- have a "." and the end of each message
- write controller with a small "c", if not the first word of an error
  message.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index f76cc62cbac4..5c7fdf31dce8 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -651,7 +651,7 @@ static int mcp251xfd_chip_softreset_check(const struct mcp251xfd_priv *priv)
 
 	if (osc != osc_reference) {
 		netdev_info(priv->ndev,
-			    "Controller failed to reset. osc=0x%08x, reference value=0x%08x\n",
+			    "Controller failed to reset. osc=0x%08x, reference value=0x%08x.\n",
 			    osc, osc_reference);
 		return -ETIMEDOUT;
 	}
@@ -666,7 +666,7 @@ static int mcp251xfd_chip_softreset(const struct mcp251xfd_priv *priv)
 	for (i = 0; i < MCP251XFD_SOFTRESET_RETRIES_MAX; i++) {
 		if (i)
 			netdev_info(priv->ndev,
-				    "Retrying to reset Controller.\n");
+				    "Retrying to reset controller.\n");
 
 		err = mcp251xfd_chip_softreset_do(priv);
 		if (err == -ETIMEDOUT)
@@ -1239,7 +1239,7 @@ mcp251xfd_handle_tefif_recover(const struct mcp251xfd_priv *priv, const u32 seq)
 	}
 
 	netdev_info(priv->ndev,
-		    "Transmit Event FIFO buffer %s. (seq=0x%08x, tef_tail=0x%08x, tef_head=0x%08x, tx_head=0x%08x)\n",
+		    "Transmit Event FIFO buffer %s. (seq=0x%08x, tef_tail=0x%08x, tef_head=0x%08x, tx_head=0x%08x).\n",
 		    tef_sta & MCP251XFD_REG_TEFSTA_TEFFIF ?
 		    "full" : tef_sta & MCP251XFD_REG_TEFSTA_TEFNEIF ?
 		    "not empty" : "empty",
@@ -1891,7 +1891,7 @@ mcp251xfd_handle_modif(const struct mcp251xfd_priv *priv, bool *set_normal_mode)
 			   "Controller changed into %s Mode (%u).\n",
 			   mcp251xfd_get_mode_str(mode), mode);
 
-	/* After the application requests Normal mode, the Controller
+	/* After the application requests Normal mode, the controller
 	 * will automatically attempt to retransmit the message that
 	 * caused the TX MAB underflow.
 	 *
-- 
2.29.2


