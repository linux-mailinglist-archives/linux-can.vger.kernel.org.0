Return-Path: <linux-can+bounces-4988-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C74B9F1B9
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04BB44E3545
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C994E3002D7;
	Thu, 25 Sep 2025 12:14:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985232FC897
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802440; cv=none; b=r0Q50Io1e/DFE9Y6A7z3lZD7daDX/wzCeu3g6eGpXkaG3H6rI3V5ZbogwjslyaT4STPFld8QvdHvlD1eVnl5INhq0nUFEVfYWsJeeLsuvy2c94eGH7OUfa1k3vPI3kju61XfjuJRsq+jM+E+7MtFHFFppNgpt7F9L5Sdz2YBH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802440; c=relaxed/simple;
	bh=pYspMo1iFpjtEQKRlBVI2MuFCyVjej6VYZB1DjJQ2ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NPhldVSsIiBPibo+MarxcQSFJPM/ozR/5QYW5w9vsKP485nUiwEuBzQnOMgZvXcpZGyGe8RucBjfp2O+rnKLFCdb3QUpSfB7wzmtX2OAyGR+ZPd9CWtaXWi68a9TzMhE7Uy1OFrbXihk48U5Mqyo48uZLCHCQ7Vcj9/1JHnmAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqu-0000Vg-DN; Thu, 25 Sep 2025 14:13:36 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqt-000PvB-1L;
	Thu, 25 Sep 2025 14:13:35 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 18A04479970;
	Thu, 25 Sep 2025 12:13:35 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@hms-networks.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 04/48] can: peak: Modification of references to email accounts being deleted
Date: Thu, 25 Sep 2025 14:07:41 +0200
Message-ID: <20250925121332.848157-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925121332.848157-1-mkl@pengutronix.de>
References: <20250925121332.848157-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Stéphane Grosjean <stephane.grosjean@hms-networks.com>

With the upcoming deletion of @peak-system.com accounts and following
the acquisition of PEAK-System and its brand by HMS-Networks, this fix
aims to migrate all address references to @hms-networks.com, as well
as to map my personal committer addresses to author addresses, while
taking the opportunity to correct the accent on the first ‘e’ of my
first name.

Signed-off-by: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
Link: https://patch.msgid.link/20250912081820.86314-1-stephane.grosjean@free.fr
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .mailmap                                      | 2 ++
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
 13 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/.mailmap b/.mailmap
index 4a5f2c8deeff..c393045d9361 100644
--- a/.mailmap
+++ b/.mailmap
@@ -740,6 +740,8 @@ Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@est.tech>
 Stanislav Fomichev <sdf@fomichev.me> <sdf@google.com>
 Stanislav Fomichev <sdf@fomichev.me> <stfomichev@gmail.com>
 Stefan Wahren <wahrenst@gmx.net> <stefan.wahren@i2se.com>
+Stéphane Grosjean <stephane.grosjean@hms-networks.com> <s.grosjean@peak-system.com>
+Stéphane Grosjean <stephane.grosjean@hms-networks.com> <stephane.grosjean@free.fr>
 Stéphane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@linux-foundation.org>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@osdl.org>
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 77292afaed22..b5bc80ac7876 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2007, 2011 Wolfgang Grandegger <wg@grandegger.com>
- * Copyright (C) 2012 Stephane Grosjean <s.grosjean@peak-system.com>
  *
- * Copyright (C) 2016  PEAK System-Technik GmbH
+ * Copyright (C) 2016-2025 PEAK System-Technik GmbH
+ * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
  */
 
 #include <linux/can.h>
diff --git a/drivers/net/can/peak_canfd/peak_canfd_user.h b/drivers/net/can/peak_canfd/peak_canfd_user.h
index a72719dc3b74..60c6542028cf 100644
--- a/drivers/net/can/peak_canfd/peak_canfd_user.h
+++ b/drivers/net/can/peak_canfd/peak_canfd_user.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* CAN driver for PEAK System micro-CAN based adapters
  *
- * Copyright (C) 2003-2011 PEAK System-Technik GmbH
- * Copyright (C) 2011-2013 Stephane Grosjean <s.grosjean@peak-system.com>
+ * Copyright (C) 2003-2025 PEAK System-Technik GmbH
+ * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
  */
 #ifndef PEAK_CANFD_USER_H
 #define PEAK_CANFD_USER_H
diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
index 1df3c4b54f03..93558e33bc02 100644
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
+ * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
  */
 
 #include <linux/kernel.h>
@@ -19,7 +19,7 @@
 
 #include "peak_canfd_user.h"
 
-MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
+MODULE_AUTHOR("Stéphane Grosjean <stephane.grosjean@hms-networks.com>");
 MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCIe/M.2 FD family cards");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index da396d641e24..10d88cbda465 100644
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
+ * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
  */
 
 #include <linux/kernel.h>
@@ -22,7 +22,7 @@
 
 #include "sja1000.h"
 
-MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
+MODULE_AUTHOR("Stéphane Grosjean <stephane.grosjean@hms-networks.com>");
 MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCI family cards");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index ce18e9e56059..e1610b527d13 100644
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
+ * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -19,7 +19,7 @@
 #include <linux/can/dev.h>
 #include "sja1000.h"
 
-MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
+MODULE_AUTHOR("Stéphane Grosjean <stephane.grosjean@hms-networks.com>");
 MODULE_DESCRIPTION("CAN driver for PEAK-System PCAN-PC Cards");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 6b293a9056c2..9278a1522aae 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -3,8 +3,8 @@
  * CAN driver for PEAK System PCAN-USB adapter
  * Derived from the PCAN project file driver/src/pcan_usb.c
  *
- * Copyright (C) 2003-2010 PEAK System-Technik GmbH
- * Copyright (C) 2011-2012 Stephane Grosjean <s.grosjean@peak-system.com>
+ * Copyright (C) 2003-2025 PEAK System-Technik GmbH
+ * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
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
index 117637b9b995..decbf5ed10bd 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -3,8 +3,8 @@
  * CAN driver for PEAK System USB adapters
  * Derived from the PCAN project file driver/src/pcan_usb_core.c
  *
- * Copyright (C) 2003-2010 PEAK System-Technik GmbH
- * Copyright (C) 2010-2012 Stephane Grosjean <s.grosjean@peak-system.com>
+ * Copyright (C) 2003-2025 PEAK System-Technik GmbH
+ * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
  *
  * Many thanks to Klaus Hitschler <klaus.hitschler@gmx.de>
  */
@@ -24,7 +24,7 @@
 
 #include "pcan_usb_core.h"
 
-MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
+MODULE_AUTHOR("Stéphane Grosjean <stephane.grosjean@hms-networks.com>");
 MODULE_DESCRIPTION("CAN driver for PEAK-System USB adapters");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index abab00930b9d..d1c1897d47b9 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -3,8 +3,8 @@
  * CAN driver for PEAK System USB adapters
  * Derived from the PCAN project file driver/src/pcan_usb_core.c
  *
- * Copyright (C) 2003-2010 PEAK System-Technik GmbH
- * Copyright (C) 2010-2012 Stephane Grosjean <s.grosjean@peak-system.com>
+ * Copyright (C) 2003-2025 PEAK System-Technik GmbH
+ * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
  *
  * Many thanks to Klaus Hitschler <klaus.hitschler@gmx.de>
  */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index ebefc274b50a..be84191cde56 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -2,7 +2,8 @@
 /*
  * CAN driver for PEAK System PCAN-USB FD / PCAN-USB Pro FD adapter
  *
- * Copyright (C) 2013-2014 Stephane Grosjean <s.grosjean@peak-system.com>
+ * Copyright (C) 2013-2025 PEAK System-Technik GmbH
+ * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
  */
 #include <linux/ethtool.h>
 #include <linux/module.h>
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index f736196383ac..7be286293b1a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -3,8 +3,8 @@
  * CAN driver for PEAK System PCAN-USB Pro adapter
  * Derived from the PCAN project file driver/src/pcan_usbpro.c
  *
- * Copyright (C) 2003-2011 PEAK System-Technik GmbH
- * Copyright (C) 2011-2012 Stephane Grosjean <s.grosjean@peak-system.com>
+ * Copyright (C) 2003-2025 PEAK System-Technik GmbH
+ * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
  */
 #include <linux/ethtool.h>
 #include <linux/module.h>
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
index 28e740af905d..162c7546d3a8 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
@@ -3,8 +3,8 @@
  * CAN driver for PEAK System PCAN-USB Pro adapter
  * Derived from the PCAN project file driver/src/pcan_usbpro_fw.h
  *
- * Copyright (C) 2003-2011 PEAK System-Technik GmbH
- * Copyright (C) 2011-2012 Stephane Grosjean <s.grosjean@peak-system.com>
+ * Copyright (C) 2003-2025 PEAK System-Technik GmbH
+ * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
  */
 #ifndef PCAN_USB_PRO_H
 #define PCAN_USB_PRO_H
diff --git a/include/linux/can/dev/peak_canfd.h b/include/linux/can/dev/peak_canfd.h
index f38772fd0c07..d3788a3d0942 100644
--- a/include/linux/can/dev/peak_canfd.h
+++ b/include/linux/can/dev/peak_canfd.h
@@ -2,8 +2,8 @@
 /*
  * CAN driver for PEAK System micro-CAN based adapters
  *
- * Copyright (C) 2003-2011 PEAK System-Technik GmbH
- * Copyright (C) 2011-2013 Stephane Grosjean <s.grosjean@peak-system.com>
+ * Copyright (C) 2003-2025 PEAK System-Technik GmbH
+ * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
  */
 #ifndef PUCAN_H
 #define PUCAN_H
-- 
2.51.0


