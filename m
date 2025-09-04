Return-Path: <linux-can+bounces-4479-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182F6B43923
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 12:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3266F5401CA
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 10:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65EF2C11EC;
	Thu,  4 Sep 2025 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="FOqwUvJs"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1D32ECEB9
	for <linux-can@vger.kernel.org>; Thu,  4 Sep 2025 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982821; cv=none; b=bgOcU/pkPciwuWYBJCuvuqFfs9bAxLYsswVUyo4wW06t01LctI/9ZQ3gO5k/izre1BBeJvO2UeOcpLxHvIwS4hzrDesZdjZoYbuBW8yplVUWtApTyScJ+s9bq55lTRLspWfK9KCHIYpe9H6/3Ey5okvgieMylQUnABuuW6v1fXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982821; c=relaxed/simple;
	bh=0N4VNUuCEpjHcp51nEzHGqA3IBJyXNGThAjT5keaz6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cSUFqLczEJ/ZsJlMc09Bgpa7eXDBH6MWybzWdGtHpakHVRSBtbf94wyBujPdnjdmUj6/VHUlGXKHBCdLfAPeFdKSwGZwp5DIH65Qy90Cr/XnLWmONcmcuiH5HXIjGnTypgswmCGaH9UIoYA1TK+8CUn3r6Tg8j4HAEZKdYEJi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=FOqwUvJs; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from stf-laptop.. (unknown [IPv6:2a02:8428:60a1:3e01:a8ab:8ea9:2e2e:13e5])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 38AD919F733;
	Thu,  4 Sep 2025 12:46:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1756982811;
	bh=0N4VNUuCEpjHcp51nEzHGqA3IBJyXNGThAjT5keaz6s=;
	h=From:To:Cc:Subject:Date:From;
	b=FOqwUvJsAm8lWtO1LuncK+zr2eWicLYu+FIULfsv9IwWgjIE8b+BVA7UswERwjn/c
	 7svYqhYQwvnebxf4Lyuq1xT3XdiUcmgwwXvc/kw8zVyhT4ys+1LXTenvuPA4D/Gpd3
	 elLGJ+s1KXr76fPZTdqX7Xg0WksucsMf6rFeXlPIVqKAIcyi8bD2o01B0Cgc4DZld9
	 R7rFSVVEui3d49EL0XmoWu2Pfgo/z5O5GNWHG65wkWuSxrxrWEJ41X3sQCejk+CE2Z
	 yXsNWXf78U839Obp5jIVzeI1roXaOC8fnTGULjxi1C5kn18I2uxmNCu5Cr2AoGIJbc
	 fUaK/tP3fGVmA==
From: Stephane Grosjean <stephane.grosjean@free.fr>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <stephane.grosjean@hms-networks.com>
Subject: [PATCH] can: peak: Modification of references to email accounts being deleted
Date: Thu,  4 Sep 2025 12:46:05 +0200
Message-ID: <20250904104618.634972-1-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stephane Grosjean <stephane.grosjean@hms-networks.com>

With the upcoming deletion of @peak-system.com accounts and following the
acquisition of PEAK-System and its brand by HMS-Networks, this patch
aims to migrate all references to @hms-networks.com.

Signed-off-by: Stephane Grosjean <stephane.grosjean@hms-networks.com>
---
 drivers/net/can/peak_canfd/peak_canfd.c       | 4 ++--
 drivers/net/can/peak_canfd/peak_canfd_user.h  | 4 ++--
 drivers/net/can/peak_canfd/peak_pciefd_main.c | 6 +++---
 drivers/net/can/sja1000/peak_pci.c            | 6 +++---
 drivers/net/can/sja1000/peak_pcmcia.c         | 8 ++++----
 drivers/net/can/usb/peak_usb/pcan_usb.c       | 6 +++---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  | 6 +++---
 drivers/net/can/usb/peak_usb/pcan_usb_core.h  | 4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c    | 3 ++-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c   | 4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h   | 4 ++--
 include/linux/can/dev/peak_canfd.h            | 4 ++--
 12 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 77292afaed22..2d269c10f56c 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2007, 2011 Wolfgang Grandegger <wg@grandegger.com>
- * Copyright (C) 2012 Stephane Grosjean <s.grosjean@peak-system.com>
  *
- * Copyright (C) 2016  PEAK System-Technik GmbH
+ * Copyright (C) 2016-2025 PEAK System-Technik GmbH
+ * Author: Stephane Grosjean <stephane.grosjean@hms-networks.com>
  */
 
 #include <linux/can.h>
diff --git a/drivers/net/can/peak_canfd/peak_canfd_user.h b/drivers/net/can/peak_canfd/peak_canfd_user.h
index a72719dc3b74..a951849f0f80 100644
--- a/drivers/net/can/peak_canfd/peak_canfd_user.h
+++ b/drivers/net/can/peak_canfd/peak_canfd_user.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* CAN driver for PEAK System micro-CAN based adapters
  *
- * Copyright (C) 2003-2011 PEAK System-Technik GmbH
- * Copyright (C) 2011-2013 Stephane Grosjean <s.grosjean@peak-system.com>
+ * Copyright (C) 2003-2025 PEAK System-Technik GmbH
+ * Author: Stephane Grosjean <stephane.grosjean@hms-networks.com>
  */
 #ifndef PEAK_CANFD_USER_H
 #define PEAK_CANFD_USER_H
diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
index 1df3c4b54f03..8ef03f6314ff 100644
--- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2007, 2011 Wolfgang Grandegger <wg@grandegger.com>
- * Copyright (C) 2012 Stephane Grosjean <s.grosjean@peak-system.com>
  *
  * Derived from the PCAN project file driver/src/pcan_pci.c:
  *
- * Copyright (C) 2001-2006  PEAK System-Technik GmbH
+ * Copyright (C) 2001-2025 PEAK System-Technik GmbH
+ * Author: Stephane Grosjean <stephane.grosjean@hms-networks.com>
  */
 
 #include <linux/kernel.h>
@@ -19,7 +19,7 @@
 
 #include "peak_canfd_user.h"
 
-MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
+MODULE_AUTHOR("Stephane Grosjean <stephane.grosjean@hms-networks.com>");
 MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCIe/M.2 FD family cards");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index da396d641e24..27b8649d7696 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2007, 2011 Wolfgang Grandegger <wg@grandegger.com>
- * Copyright (C) 2012 Stephane Grosjean <s.grosjean@peak-system.com>
  *
  * Derived from the PCAN project file driver/src/pcan_pci.c:
  *
- * Copyright (C) 2001-2006  PEAK System-Technik GmbH
+ * Copyright (C) 2001-2025 PEAK System-Technik GmbH
+ * Author: Stephane Grosjean <stephane.grosjean@hms-networks.com>
  */
 
 #include <linux/kernel.h>
@@ -22,7 +22,7 @@
 
 #include "sja1000.h"
 
-MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
+MODULE_AUTHOR("Stephane Grosjean <stephane.grosjean@hms-networks.com>");
 MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCI family cards");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index ce18e9e56059..6a72c16ea417 100644
--- a/drivers/net/can/sja1000/peak_pcmcia.c
+++ b/drivers/net/can/sja1000/peak_pcmcia.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2010-2012 Stephane Grosjean <s.grosjean@peak-system.com>
- *
  * CAN driver for PEAK-System PCAN-PC Card
  * Derived from the PCAN project file driver/src/pcan_pccard.c
- * Copyright (C) 2006-2010 PEAK System-Technik GmbH
+ *
+ * Copyright (C) 2006-2025 PEAK System-Technik GmbH
+ * Author: Stephane Grosjean <stephane.grosjean@hms-networks.com>
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -19,7 +19,7 @@
 #include <linux/can/dev.h>
 #include "sja1000.h"
 
-MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
+MODULE_AUTHOR("Stephane Grosjean <stephane.grosjean@hms-networks.com>");
 MODULE_DESCRIPTION("CAN driver for PEAK-System PCAN-PC Cards");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 6b293a9056c2..2d9f6c82c634 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -3,8 +3,8 @@
  * CAN driver for PEAK System PCAN-USB adapter
  * Derived from the PCAN project file driver/src/pcan_usb.c
  *
- * Copyright (C) 2003-2010 PEAK System-Technik GmbH
- * Copyright (C) 2011-2012 Stephane Grosjean <s.grosjean@peak-system.com>
+ * Copyright (C) 2003-2025 PEAK System-Technik GmbH
+ * Author: Stephane Grosjean <stephane.grosjean@hms-networks.com>
  *
  * Many thanks to Klaus Hitschler <klaus.hitschler@gmx.de>
  */
@@ -919,7 +919,7 @@ static int pcan_usb_init(struct peak_usb_device *dev)
 					    CAN_CTRLMODE_LOOPBACK;
 	} else {
 		dev_info(dev->netdev->dev.parent,
-			 "Firmware update available. Please contact support@peak-system.com\n");
+			 "Firmware update available. Please contact support.peak@hms-networks.com\n");
 	}
 
 	return 0;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index d9927f438934..5a207c96383f 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -3,8 +3,8 @@
  * CAN driver for PEAK System USB adapters
  * Derived from the PCAN project file driver/src/pcan_usb_core.c
  *
- * Copyright (C) 2003-2010 PEAK System-Technik GmbH
- * Copyright (C) 2010-2012 Stephane Grosjean <s.grosjean@peak-system.com>
+ * Copyright (C) 2003-2025 PEAK System-Technik GmbH
+ * Author: Stephane Grosjean <stephane.grosjean@hms-networks.com>
  *
  * Many thanks to Klaus Hitschler <klaus.hitschler@gmx.de>
  */
@@ -24,7 +24,7 @@
 
 #include "pcan_usb_core.h"
 
-MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
+MODULE_AUTHOR("Stephane Grosjean <stephane.grosjean@hms-networks.com>");
 MODULE_DESCRIPTION("CAN driver for PEAK-System USB adapters");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index abab00930b9d..324e43dcfde9 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -3,8 +3,8 @@
  * CAN driver for PEAK System USB adapters
  * Derived from the PCAN project file driver/src/pcan_usb_core.c
  *
- * Copyright (C) 2003-2010 PEAK System-Technik GmbH
- * Copyright (C) 2010-2012 Stephane Grosjean <s.grosjean@peak-system.com>
+ * Copyright (C) 2003-2025 PEAK System-Technik GmbH
+ * Author: Stephane Grosjean <stephane.grosjean@hms-networks.com>
  *
  * Many thanks to Klaus Hitschler <klaus.hitschler@gmx.de>
  */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index ec77aa29a8c5..5728c531ff6d 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -2,7 +2,8 @@
 /*
  * CAN driver for PEAK System PCAN-USB FD / PCAN-USB Pro FD adapter
  *
- * Copyright (C) 2013-2014 Stephane Grosjean <s.grosjean@peak-system.com>
+ * Copyright (C) 2013-2025 PEAK System-Technik GmbH
+ * Author: Stephane Grosjean <stephane.grosjean@hms-networks.com>
  */
 #include <linux/ethtool.h>
 #include <linux/module.h>
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index f736196383ac..f11867102974 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -3,8 +3,8 @@
  * CAN driver for PEAK System PCAN-USB Pro adapter
  * Derived from the PCAN project file driver/src/pcan_usbpro.c
  *
- * Copyright (C) 2003-2011 PEAK System-Technik GmbH
- * Copyright (C) 2011-2012 Stephane Grosjean <s.grosjean@peak-system.com>
+ * Copyright (C) 2003-2025 PEAK System-Technik GmbH
+ * Author: Stephane Grosjean <stephane.grosjean@hms-networks.com>
  */
 #include <linux/ethtool.h>
 #include <linux/module.h>
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
index 28e740af905d..9911f6a7038c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
@@ -3,8 +3,8 @@
  * CAN driver for PEAK System PCAN-USB Pro adapter
  * Derived from the PCAN project file driver/src/pcan_usbpro_fw.h
  *
- * Copyright (C) 2003-2011 PEAK System-Technik GmbH
- * Copyright (C) 2011-2012 Stephane Grosjean <s.grosjean@peak-system.com>
+ * Copyright (C) 2003-2025 PEAK System-Technik GmbH
+ * Author: Stephane Grosjean <stephane.grosjean@hms-networks.com>
  */
 #ifndef PCAN_USB_PRO_H
 #define PCAN_USB_PRO_H
diff --git a/include/linux/can/dev/peak_canfd.h b/include/linux/can/dev/peak_canfd.h
index f38772fd0c07..5a92a875ab12 100644
--- a/include/linux/can/dev/peak_canfd.h
+++ b/include/linux/can/dev/peak_canfd.h
@@ -2,8 +2,8 @@
 /*
  * CAN driver for PEAK System micro-CAN based adapters
  *
- * Copyright (C) 2003-2011 PEAK System-Technik GmbH
- * Copyright (C) 2011-2013 Stephane Grosjean <s.grosjean@peak-system.com>
+ * Copyright (C) 2003-2025 PEAK System-Technik GmbH
+ * Author: Stephane Grosjean <stephane.grosjean@hms-networks.com>
  */
 #ifndef PUCAN_H
 #define PUCAN_H
-- 
2.43.0


