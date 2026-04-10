Return-Path: <linux-can+bounces-7363-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AmRCBDx2GnrjwgAu9opvQ
	(envelope-from <linux-can+bounces-7363-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Apr 2026 14:46:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A82713D7A37
	for <lists+linux-can@lfdr.de>; Fri, 10 Apr 2026 14:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3E423035B26
	for <lists+linux-can@lfdr.de>; Fri, 10 Apr 2026 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3581DD877;
	Fri, 10 Apr 2026 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="R67RQokw"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80764191F98
	for <linux-can@vger.kernel.org>; Fri, 10 Apr 2026 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775825058; cv=none; b=fZwF1IgwJu8gtjtaWkQqxBmgsp5SuMmYE7N4HnD+93oR5YGu7sQxHpT7WSGN2yYL47K/wVNIPp0QEwKaL8A0MK0iZScAt19KYaBDcGZUZkIypJK+UBfsjRswbzi9AHJYbE0JU1pqSUQVD0YFI/zecSkuaNFgmf45LFuesdbuns0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775825058; c=relaxed/simple;
	bh=gcmfIPIxC4htsc+GbGKGUMXyBeUskoJLU6HtUoeWg64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qE4hGvDJTjWm/EJp4aQM+mpWveBKzdZHWzcTByYs+GB0d7c8OafhouWwK0Q/lv1AxHoa5b8ftrKgS1aHlyLDxLIxnQReMs6mJy+EyH5pUKJceVyuLEaSN2n7O3a1RvvklHTyPJCGwnlL8XRo9wjOZZwkhHdeu1UfHyDLASUMmMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=R67RQokw; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from stf-laptop (unknown [IPv6:2a02:8428:60a1:3e01:f7cf:b982:702d:7118])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 88CD75FFB4;
	Fri, 10 Apr 2026 14:44:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1775825047;
	bh=gcmfIPIxC4htsc+GbGKGUMXyBeUskoJLU6HtUoeWg64=;
	h=From:To:Cc:Subject:Date:From;
	b=R67RQokwObv89OWTeE40r9OVe/eChveK5t4tvU58U5tKIiXt+9kyX13MOtMJvRU6T
	 M2MwA7tpaYEbOEJe0BKyBg9XvpQ+sOQPvbrGP89QcQABwCilyy8VvkcThHLjH+V42V
	 8l+UYxbAiE05oSTcCWZb22ayPkMyhhfh6aWzXUnvNFPVaeHD2nueyZBlcvmrWFso9L
	 Fcwtt2KXAk+woLyDPlKLD5tyUsbisknOkf+ti6jiM5Sv5e8yM3VESxf4Q2nLRSuEUl
	 K9qW++phekbAdzObZZfHcxonE/x7l4onpD85syvPz/P1YPUDp6E/7KgEjRYmfJEXLf
	 10fhtMaFlxphQ==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>
Subject: [PATCH] can: peak: Modification of references to email accounts being deleted
Date: Fri, 10 Apr 2026 14:42:17 +0200
Message-ID: <20260410124251.40506-1-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[free.fr,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[free.fr:s=smtp-20201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-7363-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephane.grosjean@free.fr,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[free.fr:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[free.fr]
X-Rspamd-Queue-Id: A82713D7A37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

Following the sale of PEAK-System France by HMS-Networks, this update is
intended to change all my @hms-networks.com email addresses to my new
@peak-system.fr address.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 .mailmap                                      | 4 ++--
 drivers/net/can/peak_canfd/peak_canfd.c       | 2 +-
 drivers/net/can/peak_canfd/peak_canfd_user.h  | 2 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c | 4 ++--
 drivers/net/can/sja1000/peak_pci.c            | 4 ++--
 drivers/net/can/sja1000/peak_pcmcia.c         | 4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb.c       | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  | 4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.h  | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c    | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c   | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h   | 2 +-
 include/linux/can/dev/peak_canfd.h            | 2 +-
 13 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/.mailmap b/.mailmap
index 22c5ab1c5d55..48cbab98d728 100644
--- a/.mailmap
+++ b/.mailmap
@@ -789,8 +789,8 @@ Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@est.tech>
 Stanislav Fomichev <sdf@fomichev.me> <sdf@google.com>
 Stanislav Fomichev <sdf@fomichev.me> <stfomichev@gmail.com>
 Stefan Wahren <wahrenst@gmx.net> <stefan.wahren@i2se.com>
-Stéphane Grosjean <stephane.grosjean@hms-networks.com> <s.grosjean@peak-system.com>
-Stéphane Grosjean <stephane.grosjean@hms-networks.com> <stephane.grosjean@free.fr>
+Stéphane Grosjean <s.grosjean@peak-system.fr> <s.grosjean@peak-system.com>
+Stéphane Grosjean <s.grosjean@peak-system.fr> <stephane.grosjean@free.fr>
 Stéphane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@linux-foundation.org>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@osdl.org>
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 06cb2629f66a..4fd1aefb780f 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -2,7 +2,7 @@
 /* Copyright (C) 2007, 2011 Wolfgang Grandegger <wg@grandegger.com>
  *
  * Copyright (C) 2016-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 
 #include <linux/can.h>
diff --git a/drivers/net/can/peak_canfd/peak_canfd_user.h b/drivers/net/can/peak_canfd/peak_canfd_user.h
index 60c6542028cf..dc0ecb566a85 100644
--- a/drivers/net/can/peak_canfd/peak_canfd_user.h
+++ b/drivers/net/can/peak_canfd/peak_canfd_user.h
@@ -2,7 +2,7 @@
 /* CAN driver for PEAK System micro-CAN based adapters
  *
  * Copyright (C) 2003-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 #ifndef PEAK_CANFD_USER_H
 #define PEAK_CANFD_USER_H
diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
index 93558e33bc02..7c749301ea84 100644
--- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -4,7 +4,7 @@
  * Derived from the PCAN project file driver/src/pcan_pci.c:
  *
  * Copyright (C) 2001-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 
 #include <linux/kernel.h>
@@ -19,7 +19,7 @@
 
 #include "peak_canfd_user.h"
 
-MODULE_AUTHOR("Stéphane Grosjean <stephane.grosjean@hms-networks.com>");
+MODULE_AUTHOR("Stéphane Grosjean <s.grosjean@peak-system.fr>");
 MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCIe/M.2 FD family cards");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 4cc4a1581dd1..69c61ccf621d 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -5,7 +5,7 @@
  * Derived from the PCAN project file driver/src/pcan_pci.c:
  *
  * Copyright (C) 2001-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 
 #include <linux/kernel.h>
@@ -22,7 +22,7 @@
 
 #include "sja1000.h"
 
-MODULE_AUTHOR("Stéphane Grosjean <stephane.grosjean@hms-networks.com>");
+MODULE_AUTHOR("Stéphane Grosjean <s.grosjean@peak-system.fr>");
 MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCI family cards");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index 42a77d435b39..c3c2aa21da47 100644
--- a/drivers/net/can/sja1000/peak_pcmcia.c
+++ b/drivers/net/can/sja1000/peak_pcmcia.c
@@ -4,7 +4,7 @@
  * Derived from the PCAN project file driver/src/pcan_pccard.c
  *
  * Copyright (C) 2006-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -19,7 +19,7 @@
 #include <linux/can/dev.h>
 #include "sja1000.h"
 
-MODULE_AUTHOR("Stéphane Grosjean <stephane.grosjean@hms-networks.com>");
+MODULE_AUTHOR("Stéphane Grosjean <s.grosjean@peak-system.fr>");
 MODULE_DESCRIPTION("CAN driver for PEAK-System PCAN-PC Cards");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 9278a1522aae..8fd058c32856 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -4,7 +4,7 @@
  * Derived from the PCAN project file driver/src/pcan_usb.c
  *
  * Copyright (C) 2003-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  *
  * Many thanks to Klaus Hitschler <klaus.hitschler@gmx.de>
  */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index cf48bb26d46d..c7933d1acc99 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -4,7 +4,7 @@
  * Derived from the PCAN project file driver/src/pcan_usb_core.c
  *
  * Copyright (C) 2003-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  *
  * Many thanks to Klaus Hitschler <klaus.hitschler@gmx.de>
  */
@@ -24,7 +24,7 @@
 
 #include "pcan_usb_core.h"
 
-MODULE_AUTHOR("Stéphane Grosjean <stephane.grosjean@hms-networks.com>");
+MODULE_AUTHOR("Stéphane Grosjean <s.grosjean@peak-system.fr>");
 MODULE_DESCRIPTION("CAN driver for PEAK-System USB adapters");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index d1c1897d47b9..65999f04f4b7 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -4,7 +4,7 @@
  * Derived from the PCAN project file driver/src/pcan_usb_core.c
  *
  * Copyright (C) 2003-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  *
  * Many thanks to Klaus Hitschler <klaus.hitschler@gmx.de>
  */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index eb4f5884ad73..ef9fd693e9bd 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -3,7 +3,7 @@
  * CAN driver for PEAK System PCAN-USB FD / PCAN-USB Pro FD adapter
  *
  * Copyright (C) 2013-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 #include <linux/ethtool.h>
 #include <linux/module.h>
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 4bfa8d0fbb32..aefcded8e12a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -4,7 +4,7 @@
  * Derived from the PCAN project file driver/src/pcan_usbpro.c
  *
  * Copyright (C) 2003-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 #include <linux/ethtool.h>
 #include <linux/module.h>
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
index 162c7546d3a8..d669c9e610c7 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
@@ -4,7 +4,7 @@
  * Derived from the PCAN project file driver/src/pcan_usbpro_fw.h
  *
  * Copyright (C) 2003-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 #ifndef PCAN_USB_PRO_H
 #define PCAN_USB_PRO_H
diff --git a/include/linux/can/dev/peak_canfd.h b/include/linux/can/dev/peak_canfd.h
index d3788a3d0942..056e0efa649f 100644
--- a/include/linux/can/dev/peak_canfd.h
+++ b/include/linux/can/dev/peak_canfd.h
@@ -3,7 +3,7 @@
  * CAN driver for PEAK System micro-CAN based adapters
  *
  * Copyright (C) 2003-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 #ifndef PUCAN_H
 #define PUCAN_H
-- 
2.53.0


