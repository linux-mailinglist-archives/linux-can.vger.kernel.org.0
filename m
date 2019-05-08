Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A2617AF0
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2019 15:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfEHNoY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 May 2019 09:44:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39077 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfEHNoY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2019 09:44:24 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <mkl@pengutronix.de>)
        id 1hOMrv-0007vK-Bv; Wed, 08 May 2019 15:44:23 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@martin.sperl.org, linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6/6] can: mcp25xxfd: include own header files into .c files
Date:   Wed,  8 May 2019 15:44:20 +0200
Message-Id: <20190508134420.29982-7-mkl@pengutronix.de>
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

...to avoid sparse warnings:

| warning: symbol '...' was not declared. Should it be static?

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c         | 1 +
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_debugfs.c | 2 ++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c    | 1 +
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c     | 1 +
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_clock.c       | 1 +
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_gpio.c        | 1 +
 6 files changed, 7 insertions(+)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c
index 8b81811abd9a..56f5dbdef43f 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c
@@ -49,6 +49,7 @@
 #include <linux/spi/spi.h>
 
 #include "mcp25xxfd_base.h"
+#include "mcp25xxfd_can.h"
 #include "mcp25xxfd_can_debugfs.h"
 #include "mcp25xxfd_can_fifo.h"
 #include "mcp25xxfd_can_int.h"
diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_debugfs.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_debugfs.c
index d2caf82a6b3e..312656867e82 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_debugfs.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_debugfs.c
@@ -9,6 +9,8 @@
 
 #include <linux/dcache.h>
 #include <linux/debugfs.h>
+
+#include "mcp25xxfd_can_debugfs.h"
 #include "mcp25xxfd_can_priv.h"
 #include "mcp25xxfd_can_tx.h"
 
diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c
index 7204864ee07e..63e687a01b24 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c
@@ -12,6 +12,7 @@
 #include <linux/spi/spi.h>
 
 #include "mcp25xxfd_can.h"
+#include "mcp25xxfd_can_fifo.h"
 #include "mcp25xxfd_can_priv.h"
 #include "mcp25xxfd_can_tx.h"
 #include "mcp25xxfd_cmd.h"
diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c
index 446716d38c10..c8baf42e3c11 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c
@@ -20,6 +20,7 @@
 
 #include "mcp25xxfd_can.h"
 #include "mcp25xxfd_can_debugfs.h"
+#include "mcp25xxfd_can_int.h"
 #include "mcp25xxfd_can_priv.h"
 #include "mcp25xxfd_can_rx.h"
 #include "mcp25xxfd_can_tx.h"
diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_clock.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_clock.c
index aee482e7c02a..a2935b784edd 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_clock.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_clock.c
@@ -76,6 +76,7 @@
 #include <linux/spi/spi.h>
 
 #include "mcp25xxfd_can.h"
+#include "mcp25xxfd_clock.h"
 #include "mcp25xxfd_cmd.h"
 #include "mcp25xxfd_priv.h"
 
diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_gpio.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_gpio.c
index 69eb9c6ef176..dfa914666f6d 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_gpio.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_gpio.c
@@ -15,6 +15,7 @@
 
 #include "mcp25xxfd_clock.h"
 #include "mcp25xxfd_cmd.h"
+#include "mcp25xxfd_gpio.h"
 #include "mcp25xxfd_priv.h"
 
 /* GPIO component */
-- 
2.20.1

