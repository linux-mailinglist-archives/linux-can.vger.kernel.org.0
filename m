Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C97AC7A6
	for <lists+linux-can@lfdr.de>; Sat,  7 Sep 2019 18:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392683AbfIGQdn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 7 Sep 2019 12:33:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:49821 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbfIGQdn (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 7 Sep 2019 12:33:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 09:33:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,477,1559545200"; 
   d="scan'208";a="174571401"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 07 Sep 2019 09:33:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 84A2B82; Sat,  7 Sep 2019 19:33:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kbuild test robot <lkp@intel.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v1] can: mcp251x: Add missed array marker for properties
Date:   Sat,  7 Sep 2019 19:33:38 +0300
Message-Id: <20190907163338.6032-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Properties structure is an array where the last, NULL one,
used as a terminator.

Fixes: c5176177e860 ("can: mcp251x: Get rid of legacy platform data")
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Marc, depending on your flow, since the culprit is in testing branch, consider
either follow up fixup, or folding it into the previous patch.

 arch/arm/mach-pxa/icontrol.c | 2 +-
 arch/arm/mach-pxa/zeus.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index aa4ccb9bb1c1..43d601b4f8a7 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -69,7 +69,7 @@ static struct pxa2xx_spi_chip mcp251x_chip_info4 = {
 	.gpio_cs        = ICONTROL_MCP251x_nCS4
 };
 
-static const struct property_entry mcp251x_properties = {
+static const struct property_entry mcp251x_properties[] = {
 	PROPERTY_ENTRY_U32("clock-frequency", 16000000),
 	{}
 };
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 645500ef427a..cc6576a14781 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -428,7 +428,7 @@ static struct gpiod_lookup_table can_regulator_gpiod_table = {
 	},
 };
 
-static const struct property_entry mcp251x_properties = {
+static const struct property_entry mcp251x_properties[] = {
 	PROPERTY_ENTRY_U32("clock-frequency", 16000000),
 	{}
 };
-- 
2.23.0.rc1

