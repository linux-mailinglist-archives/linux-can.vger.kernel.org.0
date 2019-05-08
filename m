Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1111C17AEE
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2019 15:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfEHNoY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 May 2019 09:44:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41635 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfEHNoY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2019 09:44:24 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <mkl@pengutronix.de>)
        id 1hOMru-0007vK-3o; Wed, 08 May 2019 15:44:22 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@martin.sperl.org, linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/6] can: mcp25xxfd: fix indention in Make and Kconfig
Date:   Wed,  8 May 2019 15:44:15 +0200
Message-Id: <20190508134420.29982-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508134420.29982-1-mkl@pengutronix.de>
References: <20190508134420.29982-1-mkl@pengutronix.de>
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

---
 drivers/net/can/spi/Makefile           |  2 +-
 drivers/net/can/spi/mcp25xxfd/Makefile | 29 +++++++++++++-------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/spi/Makefile b/drivers/net/can/spi/Makefile
index 67d3ad21730b..5c42658512ea 100644
--- a/drivers/net/can/spi/Makefile
+++ b/drivers/net/can/spi/Makefile
@@ -6,4 +6,4 @@
 obj-$(CONFIG_CAN_HI311X)	+= hi311x.o
 obj-$(CONFIG_CAN_MCP251X)	+= mcp251x.o
 
-obj-y                           += mcp25xxfd/
+obj-y				+= mcp25xxfd/
diff --git a/drivers/net/can/spi/mcp25xxfd/Makefile b/drivers/net/can/spi/mcp25xxfd/Makefile
index 8f455881b639..c9e721e9c908 100644
--- a/drivers/net/can/spi/mcp25xxfd/Makefile
+++ b/drivers/net/can/spi/mcp25xxfd/Makefile
@@ -2,17 +2,18 @@
 #  Makefile for the Linux Controller Area Network SPI drivers.
 #
 obj-$(CONFIG_CAN_MCP25XXFD)	+= mcp25xxfd.o
-mcp25xxfd-objs                  := mcp25xxfd_base.o
-mcp25xxfd-objs                  += mcp25xxfd_can.o
-mcp25xxfd-objs                  += mcp25xxfd_can_debugfs.o
-mcp25xxfd-objs                  += mcp25xxfd_can_fifo.o
-mcp25xxfd-objs                  += mcp25xxfd_can_int.o
-mcp25xxfd-objs                  += mcp25xxfd_can_rx.o
-mcp25xxfd-objs                  += mcp25xxfd_can_tx.o
-mcp25xxfd-objs                  += mcp25xxfd_clock.o
-mcp25xxfd-objs                  += mcp25xxfd_cmd.o
-mcp25xxfd-objs                  += mcp25xxfd_crc.o
-mcp25xxfd-objs                  += mcp25xxfd_debugfs.o
-mcp25xxfd-objs                  += mcp25xxfd_ecc.o
-mcp25xxfd-objs                  += mcp25xxfd_gpio.o
-mcp25xxfd-objs                  += mcp25xxfd_int.o
+
+mcp25xxfd-objs			:= mcp25xxfd_base.o
+mcp25xxfd-objs			+= mcp25xxfd_can.o
+mcp25xxfd-objs			+= mcp25xxfd_can_debugfs.o
+mcp25xxfd-objs			+= mcp25xxfd_can_fifo.o
+mcp25xxfd-objs			+= mcp25xxfd_can_int.o
+mcp25xxfd-objs			+= mcp25xxfd_can_rx.o
+mcp25xxfd-objs			+= mcp25xxfd_can_tx.o
+mcp25xxfd-objs			+= mcp25xxfd_clock.o
+mcp25xxfd-objs			+= mcp25xxfd_cmd.o
+mcp25xxfd-objs			+= mcp25xxfd_crc.o
+mcp25xxfd-objs			+= mcp25xxfd_debugfs.o
+mcp25xxfd-objs			+= mcp25xxfd_ecc.o
+mcp25xxfd-objs			+= mcp25xxfd_gpio.o
+mcp25xxfd-objs			+= mcp25xxfd_int.o
-- 
2.20.1

