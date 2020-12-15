Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151A42DB7A2
	for <lists+linux-can@lfdr.de>; Wed, 16 Dec 2020 01:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgLPABQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 19:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgLOXZC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 18:25:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0D6C0611CF
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 15:18:07 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kpJa1-0002gn-MH
        for linux-can@vger.kernel.org; Wed, 16 Dec 2020 00:18:05 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D264D5AE412
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 23:17:56 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7EEB25AE3B8;
        Tue, 15 Dec 2020 23:17:51 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0436c5b1;
        Tue, 15 Dec 2020 23:17:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 16/16] can: tcan4x5x: add support for half-duplex controllers
Date:   Wed, 16 Dec 2020 00:17:46 +0100
Message-Id: <20201215231746.1132907-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215231746.1132907-1-mkl@pengutronix.de>
References: <20201215231746.1132907-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds back support for half-duplex controllers, which was removed in
the last patch.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x-regmap.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-regmap.c b/drivers/net/can/m_can/tcan4x5x-regmap.c
index 660e9d87dffb..ca80dbaf7a3f 100644
--- a/drivers/net/can/m_can/tcan4x5x-regmap.c
+++ b/drivers/net/can/m_can/tcan4x5x-regmap.c
@@ -51,7 +51,7 @@ static int tcan4x5x_regmap_read(void *context,
 	struct tcan4x5x_priv *priv = spi_get_drvdata(spi);
 	struct tcan4x5x_map_buf *buf_rx = &priv->map_buf_rx;
 	struct tcan4x5x_map_buf *buf_tx = &priv->map_buf_tx;
-	struct spi_transfer xfer[] = {
+	struct spi_transfer xfer[2] = {
 		{
 			.tx_buf = buf_tx,
 		}
@@ -66,17 +66,26 @@ static int tcan4x5x_regmap_read(void *context,
 	       sizeof(buf_tx->cmd.addr));
 	tcan4x5x_spi_cmd_set_len(&buf_tx->cmd, val_len);
 
-	xfer[0].rx_buf = buf_rx;
-	xfer[0].len = sizeof(buf_tx->cmd) + val_len;
+	if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX) {
+		xfer[0].len = sizeof(buf_tx->cmd);
+
+		xfer[1].rx_buf = val_buf;
+		xfer[1].len = val_len;
+		spi_message_add_tail(&xfer[1], &msg);
+	} else {
+		xfer[0].rx_buf = buf_rx;
+		xfer[0].len = sizeof(buf_tx->cmd) + val_len;
 
-	if (TCAN4X5X_SANITIZE_SPI)
-		memset(buf_tx->data, 0x0, val_len);
+		if (TCAN4X5X_SANITIZE_SPI)
+			memset(buf_tx->data, 0x0, val_len);
+	}
 
 	err = spi_sync(spi, &msg);
 	if (err)
 		return err;
 
-	memcpy(val_buf, buf_rx->data, val_len);
+	if (!(spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX))
+		memcpy(val_buf, buf_rx->data, val_len);
 
 	return 0;
 }
-- 
2.29.2


