Return-Path: <linux-can+bounces-6137-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC67D1E3D2
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 11:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F24A30049F3
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 10:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FE9397AAE;
	Wed, 14 Jan 2026 10:54:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5599B396D13
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388055; cv=none; b=FKVumPOb3GeAech4SprtjumEpCAuoaPVKyhPwQW2mQ+FPfPR15TuI+hFR5zPJ8mXbvhTzJnnqEHtAa0OwaGzPsE3NxJH2WPkmtl848X7Yp93GGtz7gcdNcVQ8Ru6ucSQShgxz3n+DDIiQtaEMHz7f6yXrCuxQfBEG4LullNF74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388055; c=relaxed/simple;
	bh=dmZ1esgMNgnEFzSBSSQSl82K4WIaVVp+psV9xgR2mOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFMumO6VI8hOvQNg7HADb4DvVx6AdO5rW+EX4zQHK6B14PYp3iHZiNSrAiASIH+mqQPeHPFny1ZZZijTvLmAAi+jwMm7/vKhJP9KDnxOt+Y6njzxBBMJNmAuelHPqo7ER/0lTg/dpM3kzpAxd8Wek7uCBfJVqUCyrE+ctxjakwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vfyU4-0006p4-5U; Wed, 14 Jan 2026 11:52:16 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vfyU4-000Zew-1A;
	Wed, 14 Jan 2026 11:52:15 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6C53A4CCB69;
	Wed, 14 Jan 2026 10:52:15 +0000 (UTC)
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
Subject: [PATCH net 2/4] can: propagate CAN device capabilities via ml_priv
Date: Wed, 14 Jan 2026 11:45:01 +0100
Message-ID: <20260114105212.1034554-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114105212.1034554-1-mkl@pengutronix.de>
References: <20260114105212.1034554-1-mkl@pengutronix.de>
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

Commit 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
caused a sequence of dependency and linker fixes.

Instead of accessing CAN device internal data structures which caused the
dependency problems this patch introduces capability information into the
CAN specific ml_priv data which is accessible from both sides.

With this change the CAN network layer can check the required features and
the decoupling of the driver layer and network layer is restored.

Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260109144135.8495-3-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c     | 27 +++++++++++++++++++++++++++
 drivers/net/can/dev/netlink.c |  1 +
 drivers/net/can/vcan.c        | 15 +++++++++++++++
 drivers/net/can/vxcan.c       | 15 +++++++++++++++
 include/linux/can/can-ml.h    | 24 ++++++++++++++++++++++++
 include/linux/can/dev.h       |  1 +
 6 files changed, 83 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 091f30e94c61..7ab9578f5b89 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -375,6 +375,32 @@ void can_set_default_mtu(struct net_device *dev)
 	}
 }
 
+void can_set_cap_info(struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	u32 can_cap;
+
+	if (can_dev_in_xl_only_mode(priv)) {
+		/* XL only mode => no CC/FD capability */
+		can_cap = CAN_CAP_XL;
+	} else {
+		/* mixed mode => CC + FD/XL capability */
+		can_cap = CAN_CAP_CC;
+
+		if (priv->ctrlmode & CAN_CTRLMODE_FD)
+			can_cap |= CAN_CAP_FD;
+
+		if (priv->ctrlmode & CAN_CTRLMODE_XL)
+			can_cap |= CAN_CAP_XL;
+	}
+
+	if (priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
+			      CAN_CTRLMODE_RESTRICTED))
+		can_cap |= CAN_CAP_RO;
+
+	can_set_cap(dev, can_cap);
+}
+
 /* helper to define static CAN controller features at device creation time */
 int can_set_static_ctrlmode(struct net_device *dev, u32 static_mode)
 {
@@ -390,6 +416,7 @@ int can_set_static_ctrlmode(struct net_device *dev, u32 static_mode)
 
 	/* override MTU which was set by default in can_setup()? */
 	can_set_default_mtu(dev);
+	can_set_cap_info(dev);
 
 	return 0;
 }
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index d6b0e686fb11..0498198a4696 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -377,6 +377,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 	}
 
 	can_set_default_mtu(dev);
+	can_set_cap_info(dev);
 
 	return 0;
 }
diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index fdc662aea279..76e6b7b5c6a1 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -130,6 +130,19 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+static void vcan_set_cap_info(struct net_device *dev)
+{
+	u32 can_cap = CAN_CAP_CC;
+
+	if (dev->mtu > CAN_MTU)
+		can_cap |= CAN_CAP_FD;
+
+	if (dev->mtu >= CANXL_MIN_MTU)
+		can_cap |= CAN_CAP_XL;
+
+	can_set_cap(dev, can_cap);
+}
+
 static int vcan_change_mtu(struct net_device *dev, int new_mtu)
 {
 	/* Do not allow changing the MTU while running */
@@ -141,6 +154,7 @@ static int vcan_change_mtu(struct net_device *dev, int new_mtu)
 		return -EINVAL;
 
 	WRITE_ONCE(dev->mtu, new_mtu);
+	vcan_set_cap_info(dev);
 	return 0;
 }
 
@@ -162,6 +176,7 @@ static void vcan_setup(struct net_device *dev)
 	dev->tx_queue_len	= 0;
 	dev->flags		= IFF_NOARP;
 	can_set_ml_priv(dev, netdev_priv(dev));
+	vcan_set_cap_info(dev);
 
 	/* set flags according to driver capabilities */
 	if (echo)
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index b2c19f8c5f8e..f14c6f02b662 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -125,6 +125,19 @@ static int vxcan_get_iflink(const struct net_device *dev)
 	return iflink;
 }
 
+static void vxcan_set_cap_info(struct net_device *dev)
+{
+	u32 can_cap = CAN_CAP_CC;
+
+	if (dev->mtu > CAN_MTU)
+		can_cap |= CAN_CAP_FD;
+
+	if (dev->mtu >= CANXL_MIN_MTU)
+		can_cap |= CAN_CAP_XL;
+
+	can_set_cap(dev, can_cap);
+}
+
 static int vxcan_change_mtu(struct net_device *dev, int new_mtu)
 {
 	/* Do not allow changing the MTU while running */
@@ -136,6 +149,7 @@ static int vxcan_change_mtu(struct net_device *dev, int new_mtu)
 		return -EINVAL;
 
 	WRITE_ONCE(dev->mtu, new_mtu);
+	vxcan_set_cap_info(dev);
 	return 0;
 }
 
@@ -167,6 +181,7 @@ static void vxcan_setup(struct net_device *dev)
 
 	can_ml = netdev_priv(dev) + ALIGN(sizeof(struct vxcan_priv), NETDEV_ALIGN);
 	can_set_ml_priv(dev, can_ml);
+	vxcan_set_cap_info(dev);
 }
 
 /* forward declaration for rtnl_create_link() */
diff --git a/include/linux/can/can-ml.h b/include/linux/can/can-ml.h
index 8afa92d15a66..1e99fda2b380 100644
--- a/include/linux/can/can-ml.h
+++ b/include/linux/can/can-ml.h
@@ -46,6 +46,12 @@
 #include <linux/list.h>
 #include <linux/netdevice.h>
 
+/* exposed CAN device capabilities for network layer */
+#define CAN_CAP_CC BIT(0) /* CAN CC aka Classical CAN */
+#define CAN_CAP_FD BIT(1) /* CAN FD */
+#define CAN_CAP_XL BIT(2) /* CAN XL */
+#define CAN_CAP_RO BIT(3) /* read-only mode (LISTEN/RESTRICTED) */
+
 #define CAN_SFF_RCV_ARRAY_SZ (1 << CAN_SFF_ID_BITS)
 #define CAN_EFF_RCV_HASH_BITS 10
 #define CAN_EFF_RCV_ARRAY_SZ (1 << CAN_EFF_RCV_HASH_BITS)
@@ -64,6 +70,7 @@ struct can_ml_priv {
 #ifdef CAN_J1939
 	struct j1939_priv *j1939_priv;
 #endif
+	u32 can_cap;
 };
 
 static inline struct can_ml_priv *can_get_ml_priv(struct net_device *dev)
@@ -77,4 +84,21 @@ static inline void can_set_ml_priv(struct net_device *dev,
 	netdev_set_ml_priv(dev, ml_priv, ML_PRIV_CAN);
 }
 
+static inline bool can_cap_enabled(struct net_device *dev, u32 cap)
+{
+	struct can_ml_priv *can_ml = can_get_ml_priv(dev);
+
+	if (!can_ml)
+		return false;
+
+	return (can_ml->can_cap & cap);
+}
+
+static inline void can_set_cap(struct net_device *dev, u32 cap)
+{
+	struct can_ml_priv *can_ml = can_get_ml_priv(dev);
+
+	can_ml->can_cap = cap;
+}
+
 #endif /* CAN_ML_H */
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 52c8be5c160e..6d0710d6f571 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -116,6 +116,7 @@ struct can_priv *safe_candev_priv(struct net_device *dev);
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
 void can_set_default_mtu(struct net_device *dev);
+void can_set_cap_info(struct net_device *dev);
 int __must_check can_set_static_ctrlmode(struct net_device *dev,
 					 u32 static_mode);
 int can_hwtstamp_get(struct net_device *netdev,
-- 
2.51.0


