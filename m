Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A032DB7AA
	for <lists+linux-can@lfdr.de>; Wed, 16 Dec 2020 01:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgLPABT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 19:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbgLOXZJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 18:25:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A955AC061257
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 15:18:05 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kpJa0-0002ez-8O
        for linux-can@vger.kernel.org; Wed, 16 Dec 2020 00:18:04 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4B76C5AE3F8
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 23:17:55 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 6A2F65AE3A4;
        Tue, 15 Dec 2020 23:17:50 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3c83f853;
        Tue, 15 Dec 2020 23:17:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 07/16] can: tcan4x5x: remove regmap async support
Date:   Wed, 16 Dec 2020 00:17:37 +0100
Message-Id: <20201215231746.1132907-8-mkl@pengutronix.de>
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

The driver doesn't use regmap async support, so remove the stubs.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x-regmap.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-regmap.c b/drivers/net/can/m_can/tcan4x5x-regmap.c
index 20bf9a57c9b1..8905fc36b00a 100644
--- a/drivers/net/can/m_can/tcan4x5x-regmap.c
+++ b/drivers/net/can/m_can/tcan4x5x-regmap.c
@@ -44,19 +44,6 @@ static int tcan4x5x_regmap_write(void *context, const void *data, size_t count)
 	return regmap_spi_gather_write(context, reg, 4, val, count - 4);
 }
 
-static int regmap_spi_async_write(void *context,
-				  const void *reg, size_t reg_len,
-				  const void *val, size_t val_len,
-				  struct regmap_async *a)
-{
-	return -ENOTSUPP;
-}
-
-static struct regmap_async *regmap_spi_async_alloc(void)
-{
-	return NULL;
-}
-
 static int tcan4x5x_regmap_read(void *context,
 				const void *reg, size_t reg_size,
 				void *val, size_t val_size)
@@ -79,8 +66,6 @@ static const struct regmap_config tcan4x5x_regmap = {
 static const struct regmap_bus tcan4x5x_bus = {
 	.write = tcan4x5x_regmap_write,
 	.gather_write = regmap_spi_gather_write,
-	.async_write = regmap_spi_async_write,
-	.async_alloc = regmap_spi_async_alloc,
 	.read = tcan4x5x_regmap_read,
 	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
-- 
2.29.2


