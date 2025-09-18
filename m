Return-Path: <linux-can+bounces-4747-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1DDB84B88
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 15:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8847188208A
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 13:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082CF305E33;
	Thu, 18 Sep 2025 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyI1+0FB"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D469F305E10;
	Thu, 18 Sep 2025 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200375; cv=none; b=Z/bldWFqpoBqirh/B8WQK9yebNiAIpGEX07HkvHphbApS6ipbcDOmEZIbVzaiLL/m5YlriXrwJiQf6HAwXmy5pdTnvcnHIvFUxE1U6qoMio4G6v2t2DtA0KPHv8mknz1PoEDv9yK3aYZIkFCRzHr/h4t4e/lK1g0KYjjLrIVNxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200375; c=relaxed/simple;
	bh=p+SNyRqG1hT8dME3Lyo4KZ5ep4YInxyeLrwIct6GIj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fi5ZY65AN8zemA2muK3uuFIo/x2S2uxrIeWcexNpLqQDIUavuw596FX8X7IZFjy4Zg4KT9Ef45NpsQPS/p/a8kNnY4nC8x2NIBhQA6qYLjlYKGg6A/LRslAEHWgx/3f2PRUEbJzh+iVJdPHrQKbqzrSBvMOxoeFlB7uG86iCK+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyI1+0FB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EB3C4CEFA;
	Thu, 18 Sep 2025 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758200375;
	bh=p+SNyRqG1hT8dME3Lyo4KZ5ep4YInxyeLrwIct6GIj0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dyI1+0FB/qG7lU/+B8gal/oKX4d6UXrODTJYnWQ0BcW9NBefRWgUROJpde9Nmxx40
	 HDGGCDgQSviMnkv2Ywzu9fcP3I/z9itTZT/vc5HuuHwag98XkGcpjByEHqcE0stLeN
	 bLPu4sGvdrX6D0qvP/1krXlD1hyUlyP8uVXFr+6TPQQn1oQQi4E/MIdjcITXesJRuF
	 fj7BO5U1dPPWspdDplcsPnRGy8c9iwjqYjAKNZAr74mPy1UbXkj1cKxeYtNu0NPo7x
	 Gg+lzrx1PyxnbVT1uNnLk8BnhWHbxdvfnDBX0hyNRH4xjPi6BNiYf0xmJGeqecCBo4
	 C9Q058thSBt8w==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 18 Sep 2025 21:59:12 +0900
Subject: [PATCH RFC 2/5] can: dev: turn can_set_static_ctrlmode() into a
 non-inline function
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-can-fix-mtu-v1-2-471edb942295@kernel.org>
References: <20250918-can-fix-mtu-v1-0-471edb942295@kernel.org>
In-Reply-To: <20250918-can-fix-mtu-v1-0-471edb942295@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3910; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=p+SNyRqG1hT8dME3Lyo4KZ5ep4YInxyeLrwIct6GIj0=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlnmLSn7xTNXq/p4PhsakuQ+ZK1O2zqjjpuDt+R833GE
 a+1wQusOkpZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAExE3I7hf+WMoIjg8y76GzwN
 VS5rXzGuPPeguiXMUFj9eNhNt105WxgZJphKNZ2ZtDi6y4RlRuohX1OO9bvd5jZdqMqsWRNl1j6
 fCQA=
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

Making can_set_static_ctrlmode() a non-inline function resolve this
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


