Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1385627E4BE
	for <lists+linux-can@lfdr.de>; Wed, 30 Sep 2020 11:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgI3JOe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 30 Sep 2020 05:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbgI3JOd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Sep 2020 05:14:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC02C0613D6
        for <linux-can@vger.kernel.org>; Wed, 30 Sep 2020 02:14:30 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kNYBw-0007UQ-EM; Wed, 30 Sep 2020 11:14:28 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 07/12] can: mcp251xfd: rename driver files and subdir to mcp251xfd
Date:   Wed, 30 Sep 2020 11:14:19 +0200
Message-Id: <20200930091424.792165-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930091424.792165-1-mkl@pengutronix.de>
References: <20200930091424.792165-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In [1] Geert noted that the autodetect compatible for the mcp25xxfd driver,
which is "microchip,mcp25xxfd" might be too generic and overlap with upcoming,
but incompatible chips.

In the previous patch the autodetect DT compatbile has been renamed to
"microchip,mcp251xfd", this patch changes the name of the driver subdir and the
individual files accordinly.

[1] http://lore.kernel.org/r/CAMuHMdVkwGjr6dJuMyhQNqFoJqbh6Ec5V2b5LenCshwpM2SDsQ@mail.gmail.com

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/Kconfig                               | 2 +-
 drivers/net/can/spi/Makefile                              | 2 +-
 drivers/net/can/spi/{mcp25xxfd => mcp251xfd}/Kconfig      | 0
 drivers/net/can/spi/mcp251xfd/Makefile                    | 8 ++++++++
 .../mcp25xxfd-core.c => mcp251xfd/mcp251xfd-core.c}       | 2 +-
 .../mcp25xxfd-crc16.c => mcp251xfd/mcp251xfd-crc16.c}     | 2 +-
 .../mcp25xxfd-regmap.c => mcp251xfd/mcp251xfd-regmap.c}   | 2 +-
 .../spi/{mcp25xxfd/mcp25xxfd.h => mcp251xfd/mcp251xfd.h}  | 0
 drivers/net/can/spi/mcp25xxfd/Makefile                    | 8 --------
 9 files changed, 13 insertions(+), 13 deletions(-)
 rename drivers/net/can/spi/{mcp25xxfd => mcp251xfd}/Kconfig (100%)
 create mode 100644 drivers/net/can/spi/mcp251xfd/Makefile
 rename drivers/net/can/spi/{mcp25xxfd/mcp25xxfd-core.c => mcp251xfd/mcp251xfd-core.c} (99%)
 rename drivers/net/can/spi/{mcp25xxfd/mcp25xxfd-crc16.c => mcp251xfd/mcp251xfd-crc16.c} (99%)
 rename drivers/net/can/spi/{mcp25xxfd/mcp25xxfd-regmap.c => mcp251xfd/mcp251xfd-regmap.c} (99%)
 rename drivers/net/can/spi/{mcp25xxfd/mcp25xxfd.h => mcp251xfd/mcp251xfd.h} (100%)
 delete mode 100644 drivers/net/can/spi/mcp25xxfd/Makefile

diff --git a/drivers/net/can/spi/Kconfig b/drivers/net/can/spi/Kconfig
index a82240628c33..f45449210047 100644
--- a/drivers/net/can/spi/Kconfig
+++ b/drivers/net/can/spi/Kconfig
@@ -13,6 +13,6 @@ config CAN_MCP251X
 	  Driver for the Microchip MCP251x and MCP25625 SPI CAN
 	  controllers.
 
-source "drivers/net/can/spi/mcp25xxfd/Kconfig"
+source "drivers/net/can/spi/mcp251xfd/Kconfig"
 
 endmenu
diff --git a/drivers/net/can/spi/Makefile b/drivers/net/can/spi/Makefile
index 20c18ac96b1c..33e3f60bbc10 100644
--- a/drivers/net/can/spi/Makefile
+++ b/drivers/net/can/spi/Makefile
@@ -6,4 +6,4 @@
 
 obj-$(CONFIG_CAN_HI311X)	+= hi311x.o
 obj-$(CONFIG_CAN_MCP251X)	+= mcp251x.o
-obj-y				+= mcp25xxfd/
+obj-y				+= mcp251xfd/
diff --git a/drivers/net/can/spi/mcp25xxfd/Kconfig b/drivers/net/can/spi/mcp251xfd/Kconfig
similarity index 100%
rename from drivers/net/can/spi/mcp25xxfd/Kconfig
rename to drivers/net/can/spi/mcp251xfd/Kconfig
diff --git a/drivers/net/can/spi/mcp251xfd/Makefile b/drivers/net/can/spi/mcp251xfd/Makefile
new file mode 100644
index 000000000000..e943e6a2db0c
--- /dev/null
+++ b/drivers/net/can/spi/mcp251xfd/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_CAN_MCP25XXFD) += mcp25xxfd.o
+
+mcp25xxfd-objs :=
+mcp25xxfd-objs += mcp251xfd-core.o
+mcp25xxfd-objs += mcp251xfd-crc16.o
+mcp25xxfd-objs += mcp251xfd-regmap.o
diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
similarity index 99%
rename from drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
rename to drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 95d5cb46bc63..2988d93fbf82 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -23,7 +23,7 @@
 
 #include <asm/unaligned.h>
 
-#include "mcp25xxfd.h"
+#include "mcp251xfd.h"
 
 #define DEVICE_NAME "mcp25xxfd"
 
diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-crc16.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-crc16.c
similarity index 99%
rename from drivers/net/can/spi/mcp25xxfd/mcp25xxfd-crc16.c
rename to drivers/net/can/spi/mcp251xfd/mcp251xfd-crc16.c
index 79d09aaebf33..bc90afb34df2 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-crc16.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-crc16.c
@@ -12,7 +12,7 @@
 // Copyright (c) 2019 Martin Sperl <kernel@martin.sperl.org>
 //
 
-#include "mcp25xxfd.h"
+#include "mcp251xfd.h"
 
 /* The standard crc16 in linux/crc16.h is unfortunately not computing
  * the correct results (left shift vs. right shift). So here an
diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
similarity index 99%
rename from drivers/net/can/spi/mcp25xxfd/mcp25xxfd-regmap.c
rename to drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 376649c7e443..3511317bb49b 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -6,7 +6,7 @@
 //                          Marc Kleine-Budde <kernel@pengutronix.de>
 //
 
-#include "mcp25xxfd.h"
+#include "mcp251xfd.h"
 
 #include <asm/unaligned.h>
 
diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
similarity index 100%
rename from drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h
rename to drivers/net/can/spi/mcp251xfd/mcp251xfd.h
diff --git a/drivers/net/can/spi/mcp25xxfd/Makefile b/drivers/net/can/spi/mcp25xxfd/Makefile
deleted file mode 100644
index 4e17f592e22e..000000000000
--- a/drivers/net/can/spi/mcp25xxfd/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-
-obj-$(CONFIG_CAN_MCP25XXFD) += mcp25xxfd.o
-
-mcp25xxfd-objs :=
-mcp25xxfd-objs += mcp25xxfd-core.o
-mcp25xxfd-objs += mcp25xxfd-crc16.o
-mcp25xxfd-objs += mcp25xxfd-regmap.o
-- 
2.28.0

