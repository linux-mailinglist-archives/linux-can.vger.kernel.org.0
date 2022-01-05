Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31A5485612
	for <lists+linux-can@lfdr.de>; Wed,  5 Jan 2022 16:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbiAEPnW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jan 2022 10:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241630AbiAEPnG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jan 2022 10:43:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF37C061212
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 07:43:06 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n58RM-0002uV-KI
        for linux-can@vger.kernel.org; Wed, 05 Jan 2022 16:43:04 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id DCFEE6D1C99
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 15:43:02 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1FFA16D1C8A;
        Wed,  5 Jan 2022 15:43:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 79ad2376;
        Wed, 5 Jan 2022 15:43:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 01/13] can: mcp251xfd: remove double blank lines
Date:   Wed,  5 Jan 2022 16:42:48 +0100
Message-Id: <20220105154300.1258636-2-mkl@pengutronix.de>
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

This patch removes double blank lines from the driver.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c   | 1 -
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index e16dc482f327..509a76e66dd8 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -979,7 +979,6 @@ static u8 mcp251xfd_get_normal_mode(const struct mcp251xfd_priv *priv)
 {
 	u8 mode;
 
-
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
 		mode = MCP251XFD_REG_CON_MODE_INT_LOOPBACK;
 	else if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 297491516a26..7b120c716228 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -250,7 +250,6 @@ mcp251xfd_regmap_crc_read_check_crc(const struct mcp251xfd_map_buf_crc * const b
 	return 0;
 }
 
-
 static int
 mcp251xfd_regmap_crc_read_one(struct mcp251xfd_priv *priv,
 			      struct spi_message *msg, unsigned int data_len)
-- 
2.34.1


