Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E09D99E6EE
	for <lists+linux-can@lfdr.de>; Tue, 27 Aug 2019 13:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfH0Llp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Aug 2019 07:41:45 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42827 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfH0Llp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Aug 2019 07:41:45 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i2Zr4-0000Z4-7V; Tue, 27 Aug 2019 13:41:42 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Alexander Shiyan <shc_work@mail.ru>, linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: mcp251x: remove deprecated board file setup example
Date:   Tue, 27 Aug 2019 13:41:36 +0200
Message-Id: <20190827114136.15438-1-mkl@pengutronix.de>
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

In the pre device-tree ARM aera there were board files that configured
the system (instead of a device tree). A "struct spi_board_info" was
used to describe the SPI bus.

As new systems should be described via device trees, this patch removes
the board setup example from the driver. The "struct
mcp251x_platform_data" cannot be removed completely, as there are still
some in-tree users of this file.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 58992fd61cb9..6e5831308c70 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -17,26 +17,6 @@
  * - Sascha Hauer, Marc Kleine-Budde, Pengutronix
  * - Simon Kallweit, intefo AG
  * Copyright 2007
- *
- * Your platform definition file should specify something like:
- *
- * static struct mcp251x_platform_data mcp251x_info = {
- *         .oscillator_frequency = 8000000,
- * };
- *
- * static struct spi_board_info spi_board_info[] = {
- *         {
- *                 .modalias = "mcp2510",
- *			// "mcp2515" or "mcp25625" depending on your controller
- *                 .platform_data = &mcp251x_info,
- *                 .irq = IRQ_EINT13,
- *                 .max_speed_hz = 2*1000*1000,
- *                 .chip_select = 2,
- *         },
- * };
- *
- * Please see mcp251x.h for a description of the fields in
- * struct mcp251x_platform_data.
  */
 
 #include <linux/can/core.h>
-- 
2.23.0.rc1

