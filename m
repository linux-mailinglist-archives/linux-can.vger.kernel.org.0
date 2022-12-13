Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6526864B0BF
	for <lists+linux-can@lfdr.de>; Tue, 13 Dec 2022 09:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbiLMIEt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Dec 2022 03:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiLMIEq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Dec 2022 03:04:46 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CA71057F
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2022 00:04:45 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id F15C1240104
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2022 09:04:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1670918684; bh=g9/G4G3z2G2SiAc8RShk1DPSP9KSXZHpKDQkUl3l9CE=;
        h=From:To:Cc:Subject:Date:From;
        b=cKktopJX90T6jdf/4yKV2QiOM3GpeMFKLru6ZKD32l/IZu3zT8MmGSnfBYYwbCpq2
         XH7V7ZkuXPssmt8nj3PCOmIBKLXWKeVj2Mu2UY+EZTBDP1UtJXkx74b3E14Ur4tKJC
         I1WZc28guMPGJofwKsqtYRJuZ+Pii2BJSLItOxZncxpEZ/Bz3omo+gGpB/haG2UCMe
         wmkZC09U1FJv8z1DAfr1PuD5TfWgtbgDaexgQ5r8shZrLGoATcaIufSu3jYEbj6A68
         DkGnlLeM6fxEyxUEuPq1TUr0cLdhkVqxxZfxieiOmSoKO5A5PspI4D23FITcsAqyQB
         Eg2yMbQLAIgGw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NWWHb48dbz6tm6;
        Tue, 13 Dec 2022 09:04:43 +0100 (CET)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH v3 8/8] can: peak_usb: Reorder include directives alphabetically
Date:   Tue, 13 Dec 2022 08:03:10 +0000
Message-Id: <20221213080309.9013-9-lukas.magel@posteo.net>
In-Reply-To: <20220801080446.36374-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
Reply-To: Lukas Magel <lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The include directives in all source files are reordered alphabetically
according to the names of the header files.

Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 10 +++++-----
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   |  4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 926d1359f433..f7305edc2784 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -8,15 +8,15 @@
  *
  * Many thanks to Klaus Hitschler <klaus.hitschler@gmx.de>
  */
+#include <linux/device.h>
+#include <linux/ethtool.h>
 #include <linux/init.h>
-#include <linux/signal.h>
-#include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
-#include <linux/usb.h>
-#include <linux/ethtool.h>
+#include <linux/signal.h>
+#include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/device.h>
+#include <linux/usb.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index fd925ae96331..4d85b29a17b7 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -4,10 +4,10 @@
  *
  * Copyright (C) 2013-2014 Stephane Grosjean <s.grosjean@peak-system.com>
  */
+#include <linux/ethtool.h>
+#include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/usb.h>
-#include <linux/module.h>
-#include <linux/ethtool.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 0c805d9672bf..f736196383ac 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -6,10 +6,10 @@
  * Copyright (C) 2003-2011 PEAK System-Technik GmbH
  * Copyright (C) 2011-2012 Stephane Grosjean <s.grosjean@peak-system.com>
  */
+#include <linux/ethtool.h>
+#include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/usb.h>
-#include <linux/module.h>
-#include <linux/ethtool.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
-- 
2.38.1

