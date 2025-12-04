Return-Path: <linux-can+bounces-5819-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BDBCA3238
	for <lists+linux-can@lfdr.de>; Thu, 04 Dec 2025 11:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B4D6300C5DA
	for <lists+linux-can@lfdr.de>; Thu,  4 Dec 2025 10:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0FC2D3EFC;
	Thu,  4 Dec 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmftgP0f"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ACD2D1925;
	Thu,  4 Dec 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842422; cv=none; b=H+VVQq3T0hFuYpLG/sTrhHgC+AkJI9rn9Aaf53jWlax8aaV0az+NbmmD5iI0LxGPfymrODJ/jSDQNtXP/DJ7qPXsma2QMc5kA2O5B6+7IRYnS40h7ASAO78UKbgJeHyFiBWcCzkONvcTd0BZqw5mNPtA5ObV7aqE+OnIIqUGJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842422; c=relaxed/simple;
	bh=XLipculNMLZMqzZoOtN5zEJ7VrZGYAbGcZw2XeJzsDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KdNGu2XQMJE9nmzmNkBuGAvd9ZeNjtrw+kE9BYncC0cABkzNYj0MyagFCvzHthrcB3n0nL98eW3LVXAWREXD7AD6nZF5XMPhpHRYbdeXOrUkLrIsMrLNCz5Q22UPhAi9tZfvKPUCXAOKQi44qYT1fIwVOhQ60fAhsFacihFx6Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmftgP0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C6FC4CEFB;
	Thu,  4 Dec 2025 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764842421;
	bh=XLipculNMLZMqzZoOtN5zEJ7VrZGYAbGcZw2XeJzsDA=;
	h=From:To:Cc:Subject:Date:From;
	b=OmftgP0fYLLKcBJQL3HoPUw7Q+DoQULtjvvXA+s3lBblzCeskAS+SF7fdUNwcWoBa
	 nzpD1dPAtjtYC8428p3FzrK9w5z5qmv+WcaXLAHr9RfIiqEbXa8wRt/CLe9LvAODO4
	 b0lm7x7sfpMdkDM3TvuVGCm5xmd225RXWQ69i7eKuCk1qOPImslqSeotiAUZN0jsWH
	 fKFXQlSuGPRGXhN3QXBKZ2L9fSIX1aDCBvmc/7zp/sKXHmNUMy9cluLhOnhKhetOl0
	 5L/vIgNSd+Wc8MGJDiXuuT29O3Ek6gifnKehLK42rwDUe395LiebSkdFCetz84WTit
	 eix1Nz+Q3m1RQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jimmy Assarsson <extja@kvaser.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: can: fix build dependency
Date: Thu,  4 Dec 2025 11:00:09 +0100
Message-Id: <20251204100015.1033688-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/can/Kconfig      | 4 ++--
 drivers/net/can/Makefile     | 2 +-
 drivers/net/can/dev/Makefile | 5 ++---
 net/can/Kconfig              | 1 -
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index e15e320db476..bc074218d0ee 100644
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
@@ -20,7 +20,7 @@ menuconfig CAN_DEV
 	  To compile as a module, choose M here: the module will be called
 	  can-dev.
 
-if CAN_DEV
+if CAN_DEV && CAN
 
 config CAN_VCAN
 	tristate "Virtual Local CAN Interface (vcan)"
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
-- 
2.39.5


