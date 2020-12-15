Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE32DB7A1
	for <lists+linux-can@lfdr.de>; Wed, 16 Dec 2020 01:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgLPABQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 19:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbgLOXZH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 18:25:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE95FC0611C5
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 15:18:05 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kpJa0-0002fE-B9
        for linux-can@vger.kernel.org; Wed, 16 Dec 2020 00:18:04 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 972505AE3FF
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 23:17:55 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7E1F35AE3A5;
        Tue, 15 Dec 2020 23:17:50 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b2ddbe47;
        Tue, 15 Dec 2020 23:17:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 08/16] can: tcan4x5x: rename regmap_spi_gather_write() -> tcan4x5x_regmap_gather_write()
Date:   Wed, 16 Dec 2020 00:17:38 +0100
Message-Id: <20201215231746.1132907-9-mkl@pengutronix.de>
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

This patch renames the regmap_spi_gather_write() function to
tcan4x5x_regmap_gather_write(). Now it has a "tcan4x5x_" prefix as all other
functions in this driver.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x-regmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-regmap.c b/drivers/net/can/m_can/tcan4x5x-regmap.c
index 8905fc36b00a..8f718f4395c3 100644
--- a/drivers/net/can/m_can/tcan4x5x-regmap.c
+++ b/drivers/net/can/m_can/tcan4x5x-regmap.c
@@ -14,9 +14,9 @@
 
 #define TCAN4X5X_MAX_REGISTER 0x8fff
 
-static int regmap_spi_gather_write(void *context, const void *reg,
-				   size_t reg_len, const void *val,
-				   size_t val_len)
+static int tcan4x5x_regmap_gather_write(void *context, const void *reg,
+					size_t reg_len, const void *val,
+					size_t val_len)
 {
 	struct device *dev = context;
 	struct spi_device *spi = to_spi_device(dev);
@@ -41,7 +41,7 @@ static int tcan4x5x_regmap_write(void *context, const void *data, size_t count)
 	u16 *reg = (u16 *)(data);
 	const u32 *val = data + 4;
 
-	return regmap_spi_gather_write(context, reg, 4, val, count - 4);
+	return tcan4x5x_regmap_gather_write(context, reg, 4, val, count - 4);
 }
 
 static int tcan4x5x_regmap_read(void *context,
@@ -65,7 +65,7 @@ static const struct regmap_config tcan4x5x_regmap = {
 
 static const struct regmap_bus tcan4x5x_bus = {
 	.write = tcan4x5x_regmap_write,
-	.gather_write = regmap_spi_gather_write,
+	.gather_write = tcan4x5x_regmap_gather_write,
 	.read = tcan4x5x_regmap_read,
 	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
-- 
2.29.2


