Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D087C2DB7A7
	for <lists+linux-can@lfdr.de>; Wed, 16 Dec 2020 01:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgLPABR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 19:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbgLOXZI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 18:25:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5040C0611CD
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 15:18:06 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kpJa1-0002gN-E1
        for linux-can@vger.kernel.org; Wed, 16 Dec 2020 00:18:05 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 882405AE40E
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 23:17:56 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 3A7F35AE3B2;
        Tue, 15 Dec 2020 23:17:51 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 95640572;
        Tue, 15 Dec 2020 23:17:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 14/16] can: tcan4x5x: add {wr,rd}_table
Date:   Wed, 16 Dec 2020 00:17:44 +0100
Message-Id: <20201215231746.1132907-15-mkl@pengutronix.de>
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

The memory space of the chip is not fully populated, so add a regmap range
table to document this.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x-regmap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/can/m_can/tcan4x5x-regmap.c b/drivers/net/can/m_can/tcan4x5x-regmap.c
index f113881fb012..5ea162578619 100644
--- a/drivers/net/can/m_can/tcan4x5x-regmap.c
+++ b/drivers/net/can/m_can/tcan4x5x-regmap.c
@@ -53,10 +53,24 @@ static int tcan4x5x_regmap_read(void *context,
 	return spi_write_then_read(spi, &addr, reg_size, (u32 *)val, val_size);
 }
 
+static const struct regmap_range tcan4x5x_reg_table_yes_range[] = {
+	regmap_reg_range(0x0000, 0x002c),	/* Device ID and SPI Registers */
+	regmap_reg_range(0x0800, 0x083c),	/* Device configuration registers and Interrupt Flags*/
+	regmap_reg_range(0x1000, 0x10fc),	/* M_CAN */
+	regmap_reg_range(0x8000, 0x87fc),	/* MRAM */
+};
+
+static const struct regmap_access_table tcan4x5x_reg_table = {
+	.yes_ranges = tcan4x5x_reg_table_yes_range,
+	.n_yes_ranges = ARRAY_SIZE(tcan4x5x_reg_table_yes_range),
+};
+
 static const struct regmap_config tcan4x5x_regmap = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.wr_table = &tcan4x5x_reg_table,
+	.rd_table = &tcan4x5x_reg_table,
 	.cache_type = REGCACHE_NONE,
 	.max_register = TCAN4X5X_MAX_REGISTER,
 };
-- 
2.29.2


