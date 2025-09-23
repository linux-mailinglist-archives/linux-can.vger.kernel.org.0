Return-Path: <linux-can+bounces-4830-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94848B9442E
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 06:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BE817F275
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 04:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B626E30E0F1;
	Tue, 23 Sep 2025 04:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSmE6Lcq"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5DB30E0DB;
	Tue, 23 Sep 2025 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758603213; cv=none; b=WcAFKlDrQ+yeRjdB0aq8eLf4Z4YK4EYXmrU2DKmEw8IMv1xY9Xuo0cIDp7MIeIer+nSmW0DqYcJHwD+fpnv0fUYq6EGoCxfVJVXhCgDBo7ABIoyVSo7nLuMF9Bl+ucoyBic6ZQJIKwm7Rwy2K7QttOC1CzIa7jPKBwUcS3BMAtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758603213; c=relaxed/simple;
	bh=DneGXtD8h1Dl78Xv228aP26RFX4kDLuiIxklWvQi2F0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPO948g82uHbbBcsmz/XN/CwucDOolHNGuQ3f+vi37CXPSlT/HknrZ6aPyu6l9yaWlPWxHKSH7spkcl5Eq8n3NsEebPCSGTD0CnuJXvOoX8J81vMDiZTrlWJNmO87ObI+dV/sntNgRWyPk46H1NdpkGwjz3KNoNBBJLAUtL7u+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSmE6Lcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789FBC4CEF5;
	Tue, 23 Sep 2025 04:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758603212;
	bh=DneGXtD8h1Dl78Xv228aP26RFX4kDLuiIxklWvQi2F0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jSmE6Lcq1I4jlaTl0gdU1MiSeQZaCWUd+i6vBbOLtE6HcvpJ4vZRfr1OLXzwmmVXQ
	 OFTi1y6ZJdqgZs80Y1B7lzDh7dJkEGcojhENdisT0/4Bq60o2HuAXPcFZEetlMTVka
	 Uzqo6iwEfbhqQVYMfH3i96npSNzQrNM/VHzc4jP/thLJu6kvg0dqkxrfvuTkses2C2
	 8Ruuai0PnrldTmve0V9DyEgXVjCu/3zAOjQHuLxLBynhtYq5zulWTHaSQdfgEX+DVy
	 gk+tOqSGVWREedMYeKQ1kCgtkIhLiWstWGZ9Q4gWpdZ/0/5xoWMRMWwl5YXrIyVfbF
	 evvN/zzOn9uCQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 13:52:42 +0900
Subject: [PATCH v2 2/4] can: dev: turn can_set_static_ctrlmode() into a
 non-inline function
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-can-fix-mtu-v2-2-984f9868db69@kernel.org>
References: <20250923-can-fix-mtu-v2-0-984f9868db69@kernel.org>
In-Reply-To: <20250923-can-fix-mtu-v2-0-984f9868db69@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3911; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=DneGXtD8h1Dl78Xv228aP26RFX4kDLuiIxklWvQi2F0=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmX1A/FHVCt9CqWTmX6siAlqU9msusch7SvcU/EdFudA
 rVYWaZ2lLIwiHExyIopsiwr5+RW6Cj0Djv01xJmDisTyBAGLk4BmEjYXIb/Vdef/BS89ZhTjEvs
 k/Vh5kR29gsxiptObzl5SU0k4/bGLkaGM5Yrr6nddOeJWFO/teGQ/Jk3ajL7XI5Pv7LjT5rEZp4
 oLgA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

can_set_static_ctrlmode() is declared as a static inline. But it is
only called in the probe function of the devices and so does not
really benefit from any kind of optimization.

Transform it into a "normal" function by moving it to

  drivers/net/can/dev/dev.c

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
This also serves as a preparation for the next patch in which we are
adding can_set_default_mtu(). That function will only be used by the
can_dev.ko module and so we do not need to export its GPL
symbol. However, if can_set_static_ctrlmode() stays as a static
inline, then the call to set_default_mtu(), which we plan to add in
can_set_static_ctrlmode(), would also be inlined and thus would become
visible to the users of can_set_static_ctrlmode().

Making can_set_static_ctrlmode() a non-inline function resolves this
dependency.
---
 drivers/net/can/dev/dev.c | 21 +++++++++++++++++++++
 include/linux/can/dev.h   | 23 ++---------------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 3913971125de0ab16b4ad9f36712954141014ddf..a0ae659beedcd1fa0979662c12614ae7846032c0 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -347,6 +347,27 @@ int can_change_mtu(struct net_device *dev, int new_mtu)
 }
 EXPORT_SYMBOL_GPL(can_change_mtu);
 
+/* helper to define static CAN controller features at device creation time */
+int can_set_static_ctrlmode(struct net_device *dev, u32 static_mode)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	/* alloc_candev() succeeded => netdev_priv() is valid at this point */
+	if (priv->ctrlmode_supported & static_mode) {
+		netdev_warn(dev,
+			    "Controller features can not be supported and static at the same time\n");
+		return -EINVAL;
+	}
+	priv->ctrlmode = static_mode;
+
+	/* override MTU which was set by default in can_setup()? */
+	if (static_mode & CAN_CTRLMODE_FD)
+		dev->mtu = CANFD_MTU;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(can_set_static_ctrlmode);
+
 /* generic implementation of netdev_ops::ndo_eth_ioctl for CAN devices
  * supporting hardware timestamps
  */
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 9a92cbe5b2cb7ccdfca3121718856d096e9ecfa6..5dc58360c2d74a1711d4e02d28fe52ae20b146e0 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -125,27 +125,6 @@ static inline s32 can_get_relative_tdco(const struct can_priv *priv)
 	return (s32)priv->fd.tdc.tdco - sample_point_in_tc;
 }
 
-/* helper to define static CAN controller features at device creation time */
-static inline int __must_check can_set_static_ctrlmode(struct net_device *dev,
-						       u32 static_mode)
-{
-	struct can_priv *priv = netdev_priv(dev);
-
-	/* alloc_candev() succeeded => netdev_priv() is valid at this point */
-	if (priv->ctrlmode_supported & static_mode) {
-		netdev_warn(dev,
-			    "Controller features can not be supported and static at the same time\n");
-		return -EINVAL;
-	}
-	priv->ctrlmode = static_mode;
-
-	/* override MTU which was set by default in can_setup()? */
-	if (static_mode & CAN_CTRLMODE_FD)
-		dev->mtu = CANFD_MTU;
-
-	return 0;
-}
-
 static inline u32 can_get_static_ctrlmode(struct can_priv *priv)
 {
 	return priv->ctrlmode & ~priv->ctrlmode_supported;
@@ -188,6 +167,8 @@ struct can_priv *safe_candev_priv(struct net_device *dev);
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
 int can_change_mtu(struct net_device *dev, int new_mtu);
+int __must_check can_set_static_ctrlmode(struct net_device *dev,
+					 u32 static_mode);
 int can_eth_ioctl_hwts(struct net_device *netdev, struct ifreq *ifr, int cmd);
 int can_ethtool_op_get_ts_info_hwts(struct net_device *dev,
 				    struct kernel_ethtool_ts_info *info);

-- 
2.49.1


