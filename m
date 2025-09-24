Return-Path: <linux-can+bounces-4935-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD37B98CB5
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D9719C794C
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACC5286D5D;
	Wed, 24 Sep 2025 08:21:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73382853EB
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702109; cv=none; b=qHL5PE7oHK78k/48ZzxvNdpEc+c0ow5hpsvZtmd9/csJjxkXGfCMXtI8ld00Ui2a209Rr0xVLNhSI26deg+ENZdkJpy7mdo1/seEEKJpBJhWwWvF7B74unxlubS8U9ZzdjtsXKuPzGfMe+fdupQ3HynaeafxGlLWANQov0g/z9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702109; c=relaxed/simple;
	bh=DkjqKTodE1WppLOAjg5GgUwEWI9DeG5ZgFbctrtBv+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nawIxQAuAuc9ZiToLVcTAX4AOLaFnPGpNQU34hm9guDwhosuY2vcv95c8dHE8JULIo1eOAFhiIv3rDTpisIXWAtfwn7U952R/14h3e2AOBzOcPAA1tqzCILb4mauTrX0JatfqlaKNmlJBGMlD9lemqD7g55/TsBq+cV2v//F78E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kke-0001Fx-VN; Wed, 24 Sep 2025 10:21:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-000Dw7-1P;
	Wed, 24 Sep 2025 10:21:23 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 813AF478898;
	Wed, 24 Sep 2025 08:21:09 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 26/48] can: dev: turn can_set_static_ctrlmode() into a non-inline function
Date: Wed, 24 Sep 2025 10:06:43 +0200
Message-ID: <20250924082104.595459-27-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol@kernel.org>

can_set_static_ctrlmode() is declared as a static inline. But it is
only called in the probe function of the devices and so does not
really benefit from any kind of optimization.

Transform it into a "normal" function by moving it to

  drivers/net/can/dev/dev.c

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-can-fix-mtu-v3-2-581bde113f52@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 21 +++++++++++++++++++++
 include/linux/can/dev.h   | 23 ++---------------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 99b78cbb2252..02bfed37cc93 100644
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
index 9a92cbe5b2cb..5dc58360c2d7 100644
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
2.51.0


