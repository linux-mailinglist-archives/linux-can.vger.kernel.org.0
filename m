Return-Path: <linux-can+bounces-5839-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E743CB2725
	for <lists+linux-can@lfdr.de>; Wed, 10 Dec 2025 09:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A09ED3139FFE
	for <lists+linux-can@lfdr.de>; Wed, 10 Dec 2025 08:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00D2306D49;
	Wed, 10 Dec 2025 08:35:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72F3064BC
	for <linux-can@vger.kernel.org>; Wed, 10 Dec 2025 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765355702; cv=none; b=aABu6z5JbgalXqrdMb3XEgfYwGDEcs2+6N2faHjKxsuZLZHMpgCCjE4WbRQoehxujPG6Qx1vTY8SNI9z+XKqe4x7FZkbCAG7aBw+x58OdYIl7uEw/fRbtZ7saEiSLdlMA2bYCK2iWtKM/40RUEArUBF4apw+6diB7toxJZFwT+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765355702; c=relaxed/simple;
	bh=o0capNAfJqtCk2BjzNo4EZWTWOUUc8nBwgQCMyr38nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mU+YXVU7XxNKftHegQpMYBum/DJxGh1EBYMpN4ng7bsz0JrPRgoaojLA1wxSNgr73ATD0bOe4gcn6PB8BK2yTT6VHgwRhdNmKBKy56yBPmXS6ci2xtGKAxjsdl0CleG/v+WGZ+9JAhguw2yP1HDtaQGM+pjiIa6Wbqx2l/rs7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vTFeu-0007fY-6x; Wed, 10 Dec 2025 09:34:52 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vTFes-004vMh-2J;
	Wed, 10 Dec 2025 09:34:50 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 605114B3B24;
	Wed, 10 Dec 2025 08:34:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Arnd Bergmann <arnd@arndb.de>,
	kernel test robot <lkp@intel.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 1/2] can: fix build dependency
Date: Wed, 10 Dec 2025 09:32:23 +0100
Message-ID: <20251210083448.2116869-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251210083448.2116869-1-mkl@pengutronix.de>
References: <20251210083448.2116869-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A recent bugfix introduced a new problem with Kconfig dependencies:

WARNING: unmet direct dependencies detected for CAN_DEV
  Depends on [n]: NETDEVICES [=n] && CAN [=m]
  Selected by [m]:
  - CAN [=m] && NET [=y]

Since the CAN core code now links into the CAN device code, that
particular function needs to be available, though the rest of it
does not.

Revert the incomplete fix and instead use Makefile logic to avoid
the link failure.

Fixes: cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by default")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512091523.zty3CLmc-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20251204100015.1033688-1-arnd@kernel.org
[mkl: removed module option from CAN_DEV help text (thanks Vincent)]
[mkl: removed '&& CAN' from Kconfig dependency (thanks Vincent)]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Kconfig      | 5 +----
 drivers/net/can/Makefile     | 2 +-
 drivers/net/can/dev/Makefile | 5 ++---
 net/can/Kconfig              | 1 -
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index e15e320db476..460a74ae6923 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 menuconfig CAN_DEV
-	tristate "CAN Device Drivers"
+	bool "CAN Device Drivers"
 	default y
 	depends on CAN
 	help
@@ -17,9 +17,6 @@ menuconfig CAN_DEV
 	  virtual ones. If you own such devices or plan to use the virtual CAN
 	  interfaces to develop applications, say Y here.
 
-	  To compile as a module, choose M here: the module will be called
-	  can-dev.
-
 if CAN_DEV
 
 config CAN_VCAN
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index d7bc10a6b8ea..37e2f1a2faec 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_CAN_VCAN)		+= vcan.o
 obj-$(CONFIG_CAN_VXCAN)		+= vxcan.o
 obj-$(CONFIG_CAN_SLCAN)		+= slcan/
 
-obj-y				+= dev/
+obj-$(CONFIG_CAN_DEV)		+= dev/
 obj-y				+= esd/
 obj-y				+= rcar/
 obj-y				+= rockchip/
diff --git a/drivers/net/can/dev/Makefile b/drivers/net/can/dev/Makefile
index 633687d6b6c0..64226acf0f3d 100644
--- a/drivers/net/can/dev/Makefile
+++ b/drivers/net/can/dev/Makefile
@@ -1,9 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_CAN_DEV) += can-dev.o
-
-can-dev-y += skb.o
+obj-$(CONFIG_CAN) += can-dev.o
 
+can-dev-$(CONFIG_CAN_DEV) += skb.o
 can-dev-$(CONFIG_CAN_CALC_BITTIMING) += calc_bittiming.o
 can-dev-$(CONFIG_CAN_NETLINK) += bittiming.o
 can-dev-$(CONFIG_CAN_NETLINK) += dev.o
diff --git a/net/can/Kconfig b/net/can/Kconfig
index e4ccf731a24c..af64a6f76458 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -5,7 +5,6 @@
 
 menuconfig CAN
 	tristate "CAN bus subsystem support"
-	select CAN_DEV
 	help
 	  Controller Area Network (CAN) is a slow (up to 1Mbit/s) serial
 	  communications protocol. Development of the CAN bus started in

base-commit: 186468c67fc687650b7fb713d8c627d5c8566886
-- 
2.51.0


