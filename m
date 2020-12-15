Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2DF2DB7A4
	for <lists+linux-can@lfdr.de>; Wed, 16 Dec 2020 01:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgLPABQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 19:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgLOXYX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 18:24:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2909DC0611CA
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 15:18:06 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kpJa0-0002fh-LG
        for linux-can@vger.kernel.org; Wed, 16 Dec 2020 00:18:04 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id F31D05AE404
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 23:17:55 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C08015AE3A9;
        Tue, 15 Dec 2020 23:17:50 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 22338dc7;
        Tue, 15 Dec 2020 23:17:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 10/16] can: tcan4x5x: tcan4x5x_regmap_init(): use spi as context pointer
Date:   Wed, 16 Dec 2020 00:17:40 +0100
Message-Id: <20201215231746.1132907-11-mkl@pengutronix.de>
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

This patch replaces the context pointer of the regmap callback functions by a
pointer to the spi_device. This saves one level of indirection in the
callbacks.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x-regmap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-regmap.c b/drivers/net/can/m_can/tcan4x5x-regmap.c
index 6345bcb7704f..4d43c145fdec 100644
--- a/drivers/net/can/m_can/tcan4x5x-regmap.c
+++ b/drivers/net/can/m_can/tcan4x5x-regmap.c
@@ -18,8 +18,7 @@ static int tcan4x5x_regmap_gather_write(void *context, const void *reg,
 					size_t reg_len, const void *val,
 					size_t val_len)
 {
-	struct device *dev = context;
-	struct spi_device *spi = to_spi_device(dev);
+	struct spi_device *spi = context;
 	struct spi_message m;
 	u32 addr;
 	struct spi_transfer t[2] = {
@@ -47,8 +46,7 @@ static int tcan4x5x_regmap_read(void *context,
 				const void *reg, size_t reg_size,
 				void *val, size_t val_size)
 {
-	struct device *dev = context;
-	struct spi_device *spi = to_spi_device(dev);
+	struct spi_device *spi = context;
 
 	u32 addr = TCAN4X5X_READ_CMD | (*((u16 *)reg) << 8) | val_size >> 2;
 
@@ -73,6 +71,6 @@ static const struct regmap_bus tcan4x5x_bus = {
 int tcan4x5x_regmap_init(struct tcan4x5x_priv *priv)
 {
 	priv->regmap = devm_regmap_init(&priv->spi->dev, &tcan4x5x_bus,
-					&priv->spi->dev, &tcan4x5x_regmap);
+					priv->spi, &tcan4x5x_regmap);
 	return PTR_ERR_OR_ZERO(priv->regmap);
 }
-- 
2.29.2


