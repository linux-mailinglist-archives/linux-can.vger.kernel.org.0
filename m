Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A81485613
	for <lists+linux-can@lfdr.de>; Wed,  5 Jan 2022 16:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241658AbiAEPna (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jan 2022 10:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241619AbiAEPnI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jan 2022 10:43:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4373AC0611FF
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 07:43:08 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n58RO-0002w1-PD
        for linux-can@vger.kernel.org; Wed, 05 Jan 2022 16:43:06 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 3B0896D1CAD
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 15:43:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 34E366D1C8C;
        Wed,  5 Jan 2022 15:43:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5d92ab95;
        Wed, 5 Jan 2022 15:43:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 02/13] can: mcp251xfd: mcp251xfd_tef_obj_read(): fix typo in error message
Date:   Wed,  5 Jan 2022 16:42:49 +0100
Message-Id: <20220105154300.1258636-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105154300.1258636-1-mkl@pengutronix.de>
References: <20220105154300.1258636-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch fixes a typo in the error message in
mcp251xfd_tef_obj_read(), if trying to read too many objects.

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 509a76e66dd8..9d1a8992d8ce 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1335,7 +1335,7 @@ mcp251xfd_tef_obj_read(const struct mcp251xfd_priv *priv,
 	     len > tx_ring->obj_num ||
 	     offset + len > tx_ring->obj_num)) {
 		netdev_err(priv->ndev,
-			   "Trying to read to many TEF objects (max=%d, offset=%d, len=%d).\n",
+			   "Trying to read too many TEF objects (max=%d, offset=%d, len=%d).\n",
 			   tx_ring->obj_num, offset, len);
 		return -ERANGE;
 	}
-- 
2.34.1


