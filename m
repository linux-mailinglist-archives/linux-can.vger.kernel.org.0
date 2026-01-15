Return-Path: <linux-can+bounces-6156-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BB1D23586
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 10:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC7B93016FAC
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 09:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9458F346E5E;
	Thu, 15 Jan 2026 09:06:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCB7345CAB
	for <linux-can@vger.kernel.org>; Thu, 15 Jan 2026 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467981; cv=none; b=nXOTgb9y5HKyi+DGWcIFBFXv+0G62/QEgRWnkV1/Asmk/f5oalUDbcZ2Y84ubfK7F39HgUp7Ga9RjQHCm9lIzALnNhXgtvW5sRXMgOHqXvniTxAYKyyEcC5dzofRZ7gSbsuxHC3tcI0T/fdvGr1guxVPQOwtS0W4XLiDbsISLhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467981; c=relaxed/simple;
	bh=MTSLMk0Q3OlGlBxBTij1G+Ia857D/TmDzz0WdX6kQDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOcrbvocjIihoZnmuvMHpGoHp4Sowz5jeUX9Uz4wmxBRnT/p+neIp+WckpXNHihjbE/mClGoEXv5ik8kULoUF75954csmGAgyGxXwtRqHxaPXZYncSLEApPjvvMCG74pLwNsY98WRncVGSXVXt1hInhFXJTXNupzDHqBKWF3wrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgJIv-0004cQ-2T; Thu, 15 Jan 2026 10:06:09 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgJIv-000jGQ-1O;
	Thu, 15 Jan 2026 10:06:08 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7CB5E4CD6B0;
	Thu, 15 Jan 2026 09:06:08 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH net 1/4] Revert "can: raw: instantly reject unsupported CAN frames"
Date: Thu, 15 Jan 2026 09:57:08 +0100
Message-ID: <20260115090603.1124860-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260115090603.1124860-1-mkl@pengutronix.de>
References: <20260115090603.1124860-1-mkl@pengutronix.de>
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

This reverts commit 1a620a723853a0f49703c317d52dc6b9602cbaa8

and its follow-up fixes for the introduced dependency issues.

commit 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
commit cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by default")
commit 6abd4577bccc ("can: fix build dependency")
commit 5a5aff6338c0 ("can: fix build dependency")

The entire problem was caused by the requirement that a new network layer
feature needed to know about the protocol capabilities of the CAN devices.
Instead of accessing CAN device internal data structures which caused the
dependency problems a better approach has been developed which makes use of
CAN specific ml_priv data which is accessible from both sides.

Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260109144135.8495-2-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Kconfig      |  7 +++--
 drivers/net/can/Makefile     |  2 +-
 drivers/net/can/dev/Makefile |  5 ++--
 include/linux/can/dev.h      |  7 -----
 net/can/raw.c                | 54 ++++++------------------------------
 5 files changed, 17 insertions(+), 58 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index cfaea6178a71..e15e320db476 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 menuconfig CAN_DEV
-	bool "CAN Device Drivers"
+	tristate "CAN Device Drivers"
 	default y
 	depends on CAN
 	help
@@ -17,7 +17,10 @@ menuconfig CAN_DEV
 	  virtual ones. If you own such devices or plan to use the virtual CAN
 	  interfaces to develop applications, say Y here.
 
-if CAN_DEV && CAN
+	  To compile as a module, choose M here: the module will be called
+	  can-dev.
+
+if CAN_DEV
 
 config CAN_VCAN
 	tristate "Virtual Local CAN Interface (vcan)"
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 37e2f1a2faec..d7bc10a6b8ea 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_CAN_VCAN)		+= vcan.o
 obj-$(CONFIG_CAN_VXCAN)		+= vxcan.o
 obj-$(CONFIG_CAN_SLCAN)		+= slcan/
 
-obj-$(CONFIG_CAN_DEV)		+= dev/
+obj-y				+= dev/
 obj-y				+= esd/
 obj-y				+= rcar/
 obj-y				+= rockchip/
diff --git a/drivers/net/can/dev/Makefile b/drivers/net/can/dev/Makefile
index 64226acf0f3d..633687d6b6c0 100644
--- a/drivers/net/can/dev/Makefile
+++ b/drivers/net/can/dev/Makefile
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_CAN) += can-dev.o
+obj-$(CONFIG_CAN_DEV) += can-dev.o
+
+can-dev-y += skb.o
 
-can-dev-$(CONFIG_CAN_DEV) += skb.o
 can-dev-$(CONFIG_CAN_CALC_BITTIMING) += calc_bittiming.o
 can-dev-$(CONFIG_CAN_NETLINK) += bittiming.o
 can-dev-$(CONFIG_CAN_NETLINK) += dev.o
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index f6416a56e95d..52c8be5c160e 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -111,14 +111,7 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 void free_candev(struct net_device *dev);
 
 /* a candev safe wrapper around netdev_priv */
-#if IS_ENABLED(CONFIG_CAN_NETLINK)
 struct can_priv *safe_candev_priv(struct net_device *dev);
-#else
-static inline struct can_priv *safe_candev_priv(struct net_device *dev)
-{
-	return NULL;
-}
-#endif
 
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
diff --git a/net/can/raw.c b/net/can/raw.c
index be1ef7cf4204..f36a83d3447c 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -892,58 +892,20 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
 	}
 }
 
-static inline bool raw_dev_cc_enabled(struct net_device *dev,
-				      struct can_priv *priv)
+static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
 {
-	/* The CANXL-only mode disables error-signalling on the CAN bus
-	 * which is needed to send CAN CC/FD frames
-	 */
-	if (priv)
-		return !can_dev_in_xl_only_mode(priv);
-
-	/* virtual CAN interfaces always support CAN CC */
-	return true;
-}
-
-static inline bool raw_dev_fd_enabled(struct net_device *dev,
-				      struct can_priv *priv)
-{
-	/* check FD ctrlmode on real CAN interfaces */
-	if (priv)
-		return (priv->ctrlmode & CAN_CTRLMODE_FD);
-
-	/* check MTU for virtual CAN FD interfaces */
-	return (READ_ONCE(dev->mtu) >= CANFD_MTU);
-}
-
-static inline bool raw_dev_xl_enabled(struct net_device *dev,
-				      struct can_priv *priv)
-{
-	/* check XL ctrlmode on real CAN interfaces */
-	if (priv)
-		return (priv->ctrlmode & CAN_CTRLMODE_XL);
-
-	/* check MTU for virtual CAN XL interfaces */
-	return can_is_canxl_dev_mtu(READ_ONCE(dev->mtu));
-}
-
-static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
-				      struct net_device *dev)
-{
-	struct can_priv *priv = safe_candev_priv(dev);
-
-	/* Classical CAN */
-	if (can_is_can_skb(skb) && raw_dev_cc_enabled(dev, priv))
+	/* Classical CAN -> no checks for flags and device capabilities */
+	if (can_is_can_skb(skb))
 		return CAN_MTU;
 
-	/* CAN FD */
+	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
 	if (ro->fd_frames && can_is_canfd_skb(skb) &&
-	    raw_dev_fd_enabled(dev, priv))
+	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
 		return CANFD_MTU;
 
-	/* CAN XL */
+	/* CAN XL -> needs to be enabled and a CAN XL device */
 	if (ro->xl_frames && can_is_canxl_skb(skb) &&
-	    raw_dev_xl_enabled(dev, priv))
+	    can_is_canxl_dev_mtu(mtu))
 		return CANXL_MTU;
 
 	return 0;
@@ -999,7 +961,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	err = -EINVAL;
 
 	/* check for valid CAN (CC/FD/XL) frame content */
-	txmtu = raw_check_txframe(ro, skb, dev);
+	txmtu = raw_check_txframe(ro, skb, READ_ONCE(dev->mtu));
 	if (!txmtu)
 		goto free_skb;
 

base-commit: 3879cffd9d07aa0377c4b8835c4f64b4fb24ac78
-- 
2.51.0


