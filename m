Return-Path: <linux-can+bounces-4858-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179E7B9493B
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 08:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80453B9F60
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 06:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1984A30FC0D;
	Tue, 23 Sep 2025 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtFkcKMp"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E042E30FC06;
	Tue, 23 Sep 2025 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609454; cv=none; b=ErMlLDnY7aPtwtF+HYxCK6g7TrOtTZr/7gLE1+JzPtqYfedtgZoLjZbVlLQtXzH5nPPqOV+L8MKYEisiEZv0eazlvIm90LDdrBGb7mQXnA9ZTq/6K+h0D8wLVkQBzV77j0twYrA0LXiU2FpyFm/dIyHF0O22JC4T0Thdn0e8o3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609454; c=relaxed/simple;
	bh=DneGXtD8h1Dl78Xv228aP26RFX4kDLuiIxklWvQi2F0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bc7hiaNmQe88NDrnV9GRv7ci3226lNHEU8KOq4m1T4ntHJDwxBlSGro8pIZYr7c0sjnfuY0w/T55i34UCmhgZwL3eOssSeX1CIIEnOImPaK8F0vlDJ/rjIvajq90sdHvJHERomcBjr1bmvSs9gcLwhfIz6cp1ers1Yv9hX/tk48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtFkcKMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9140C116B1;
	Tue, 23 Sep 2025 06:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758609453;
	bh=DneGXtD8h1Dl78Xv228aP26RFX4kDLuiIxklWvQi2F0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JtFkcKMp371j+R6Q7m+c+mwBRYLuT/uIaXSOYSuiZUKCsjt07bjVv9/LSGzHwh8cM
	 wFKUfrn5uz2bhWhyAJRn/Omy3PQkNAllQkl+DdF4WsyocwsFgovgTKKlfi51v/ImLB
	 +sYI6gh20A94jsr37MGphMTDaOJ+8DFc63Dd0I6MyurlzDjITrfLfW9ncYLphVVzd2
	 n5+NgpfddlLxMw+PMflIm3o7N7+LHqYaB7MW2GX9sRtwhfy4JwX62eERVNeGg2wNIb
	 R+Y+UDmrMU2NBoz+gSdw9WPYioxpjDUb3LypkbkJdK5W+Ekyu3JK5ViqX4Edvo0DkY
	 r+aPKGpuFsK0g==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:37:09 +0900
Subject: [PATCH v3 2/4] can: dev: turn can_set_static_ctrlmode() into a
 non-inline function
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-can-fix-mtu-v3-2-581bde113f52@kernel.org>
References: <20250923-can-fix-mtu-v3-0-581bde113f52@kernel.org>
In-Reply-To: <20250923-can-fix-mtu-v3-0-581bde113f52@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3911; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=DneGXtD8h1Dl78Xv228aP26RFX4kDLuiIxklWvQi2F0=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXHBRXbgjVnBB3bYa52f6vpl58p05ceNP60aNh17m1p
 56e+vniVUcpC4MYF4OsmCLLsnJOboWOQu+wQ38tYeawMoEMYeDiFICJGEgy/E/52Z5xe9bmOTum
 vpvG3SL7pig2YMbxlXVm5T85TZ/N0PZjZFi0Vf/45vj75gufP280ZdshnakVVB9lbvDRaMvXL1e
 OMnIBAA==
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


