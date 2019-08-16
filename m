Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 396388FE9A
	for <lists+linux-can@lfdr.de>; Fri, 16 Aug 2019 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfHPI6Q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Aug 2019 04:58:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41687 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfHPI6Q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Aug 2019 04:58:16 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hyY3p-00049x-Ji; Fri, 16 Aug 2019 10:58:13 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Dan Murphy <dmurphy@ti.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: tcan4x5x: fix data length in regmap write path
Date:   Fri, 16 Aug 2019 10:58:12 +0200
Message-Id: <20190816085812.16886-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In regmap_spi_gather_write() the "addr" is prepared. The chip expects
the number of 32 bit words to write in the lower 8 bits of addr. However
the number of byte to write in shifted left by 3 (== divided by 8).

The function tcan4x5x_regmap_write() is called with a data buffer, which
holds the register information in the first 32 bits, followed by the
actual data. tcan4x5x_regmap_write() calls regmap_spi_gather_write()
with the val pointer pointing to the actual data, but without
decrementing the count point.

If the regmap framework only calls tcan4x5x_regmap_write() to read
single 32 bit registers these two bugs cancel each other.

This patch fixes the code.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index b115b2e5333f..0d27ef81e6ea 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -179,7 +179,7 @@ static int regmap_spi_gather_write(void *context, const void *reg,
 		{ .tx_buf = val, .len = val_len, },
 	};
 
-	addr = TCAN4X5X_WRITE_CMD | (*((u16 *)reg) << 8) | val_len >> 3;
+	addr = TCAN4X5X_WRITE_CMD | (*((u16 *)reg) << 8) | val_len >> 2;
 
 	spi_message_init(&m);
 	spi_message_add_tail(&t[0], &m);
@@ -193,7 +193,7 @@ static int tcan4x5x_regmap_write(void *context, const void *data, size_t count)
 	u16 *reg = (u16 *)(data);
 	const u32 *val = data + 4;
 
-	return regmap_spi_gather_write(context, reg, 4, val, count);
+	return regmap_spi_gather_write(context, reg, 4, val, count - 4);
 }
 
 static int regmap_spi_async_write(void *context,
-- 
2.23.0.rc1

