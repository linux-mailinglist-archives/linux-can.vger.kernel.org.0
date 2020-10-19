Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980FB292E24
	for <lists+linux-can@lfdr.de>; Mon, 19 Oct 2020 21:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbgJSTFj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Oct 2020 15:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731137AbgJSTFj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 15:05:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9EBC0613CE
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2020 12:05:39 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kUaTR-0005v5-Bi; Mon, 19 Oct 2020 21:05:37 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: [net-rfc 14/16] can: mcp251xfd: mcp251xfd_regmap_crc_read(): increase severity of CRC read error messages
Date:   Mon, 19 Oct 2020 21:05:22 +0200
Message-Id: <20201019190524.1285319-15-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019190524.1285319-1-mkl@pengutronix.de>
References: <20201019190524.1285319-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

During debugging it turned out that some people have setups where the SPI
communication is more prone to CRC errors.

Increase the severity of both the transfer retry and transfer failure message
to give users feedback without the need to recompile the driver with debug
enabled.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index ba25902dd78c..c9ffc5ea2b25 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -330,17 +330,17 @@ mcp251xfd_regmap_crc_read(void *context,
 			goto out;
 		}
 
-		netdev_dbg(priv->ndev,
-			   "CRC read error at address 0x%04x (length=%zd, data=%*ph, CRC=0x%04x) retrying.\n",
-			   reg, val_len, (int)val_len, buf_rx->data,
-			   get_unaligned_be16(buf_rx->data + val_len));
-	}
-
-	if (err) {
 		netdev_info(priv->ndev,
-			    "CRC read error at address 0x%04x (length=%zd, data=%*ph, CRC=0x%04x).\n",
+			    "CRC read error at address 0x%04x (length=%zd, data=%*ph, CRC=0x%04x) retrying.\n",
 			    reg, val_len, (int)val_len, buf_rx->data,
 			    get_unaligned_be16(buf_rx->data + val_len));
+	}
+
+	if (err) {
+		netdev_err(priv->ndev,
+			   "CRC read error at address 0x%04x (length=%zd, data=%*ph, CRC=0x%04x).\n",
+			   reg, val_len, (int)val_len, buf_rx->data,
+			   get_unaligned_be16(buf_rx->data + val_len));
 
 		return err;
 	}
-- 
2.28.0

