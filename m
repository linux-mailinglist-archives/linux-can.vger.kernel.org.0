Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD66283208
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2019 14:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbfHFM7s (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Aug 2019 08:59:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44063 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbfHFM7s (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Aug 2019 08:59:48 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1huz37-0002wF-7d; Tue, 06 Aug 2019 14:58:45 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1huz36-0003qz-Im; Tue, 06 Aug 2019 14:58:44 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 1/6] j1939: remove CAN_J1939_DEBUG option
Date:   Tue,  6 Aug 2019 14:58:35 +0200
Message-Id: <20190806125840.5634-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806125840.5634-1-o.rempel@pengutronix.de>
References: <20190806125840.5634-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

all debugging options are dynamic now

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/Kconfig  | 6 ------
 net/can/j1939/Makefile | 2 --
 2 files changed, 8 deletions(-)

diff --git a/net/can/j1939/Kconfig b/net/can/j1939/Kconfig
index 4f4c8142b185..2998298b71ec 100644
--- a/net/can/j1939/Kconfig
+++ b/net/can/j1939/Kconfig
@@ -13,9 +13,3 @@ config CAN_J1939
 	  The relevant parts in kernel are
 	  SAE j1939-21 (datalink & transport protocol)
 	  & SAE j1939-81 (network management).
-
-config CAN_J1939_DEBUG
-	bool "debug SAE J1939"
-	depends on CAN_J1939
-	help
-	  Say Y to add extra debug code (via printk) in the j1939 stack
diff --git a/net/can/j1939/Makefile b/net/can/j1939/Makefile
index 46e6c6ed221d..19181bdae173 100644
--- a/net/can/j1939/Makefile
+++ b/net/can/j1939/Makefile
@@ -1,7 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-cppflags-$(CONFIG_CAN_J1939_DEBUG) += -DDEBUG
-
 obj-$(CONFIG_CAN_J1939) += can-j1939.o
 
 can-j1939-objs := \
-- 
2.20.1

