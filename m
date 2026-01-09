Return-Path: <linux-can+bounces-6084-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDB0D0AB8E
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 15:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34D9A300DA4A
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01874238C16;
	Fri,  9 Jan 2026 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ILAsLz3r";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Af7Y/Lab"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73831D750
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969755; cv=pass; b=iNixU4/qxZD8nqGbDaozhrrR+UFX86pUuYPXA+bCH6+9JzEfDaqinZXN3pm96uhK3FEqJz32xRTHrD/LesJJbFphRHacOf+h+NcI3DT7oumkmKmCzNeC25aopt533ow5pLEYBhINoMipr5DwZOtR+AsWKcQwl3ZxYF2KnyPHM1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969755; c=relaxed/simple;
	bh=CsLCKBnZ6y/P4qTYo3PqrDxlsTn+7MRhT3UdcOBehMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+gdmjdnNyIgfZ6TnxDEYXzQPkmKy+XDvxQF7Td5HrjutsG9oWoNUt48i5ZDEzQButwfR9jTkM0hWCUpFnHWpAOey4N+Zdw9zrAhD4z/+Og/HDn+o4pGA1Qsf6quW9aEAkwzKXN18orukH83QsJrEENgdpXUrMCZMvOgMtOe2fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ILAsLz3r; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Af7Y/Lab; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767969735; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QKW3AnBvtCmUYA6hgBoKYAZCutBC12nM2YdAoMHR4GCpjpCl0wcmhRkA6MPPUfT7YF
    M1deUeDQJwpuiAyb4p+4z9PVbW9iefinHIpcmeIkvODGAN/AubFibDYbhPPmT89Suyrf
    /C1TvduJw5tm/PKGRpe/lLbzTlNbjSHSINZi1iMaAQaAWCGq3CZbx1uamWUHX5ZVCsJ7
    WVWkj4vOTWNqNhI/re1fpeizRg+qKT4b9+ZxHUGURylbGHMn6wzzX+1sLt8Ez7LJcow4
    krSoa7nNJu2vmsuHTH5pQpWkCQZr6Y3KSXtmSXZBgZTIS7pV9VmaQLsJvq86egCkL5gJ
    wcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767969735;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=wi9a5tgBe+o+pgAwz70lXPzoEk1ctlZykoClWF5Pw4g=;
    b=DDPmyvuiWj0SpaqnFDOce+wTqZ/gALqOVXOzQRzU/iNtxbQ5zYSH5S+YDgxyCav/E8
    RKiVa7YCACV4nFii48/UJuxnKKJLXE0LpncRTu12c6tZ8V+0xo/lWhlN5ooEFogh0XsY
    1md+rjWgEnwrdiJjOAqKyhMQUWE3gtCq3f+nfGendmaQHvxgQwhKsouuuBguM4iLjdQY
    hjZsJQOWB58hzFkLO4HtKdKp32nbYsiDHr7gyRXQOeEFlieEDnryTQfjcwzr5PnHFw4/
    kvqkgePEBEuGd1a1jMW9KdaUX9QVA2pp1J+hXqVHOkSmnlnEt61YiL3ohsz8ls/V5U4n
    Dqtg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767969735;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=wi9a5tgBe+o+pgAwz70lXPzoEk1ctlZykoClWF5Pw4g=;
    b=ILAsLz3r59VrbE0dmAKGsZDuc83nOg/UMfbQZKGak+slON91fct8y1mfg2tS73Z8AV
    eyXfkEhhV+8LZx2s8HvoGPl0VoeEikDRuJGMpz9U+QY7xUIRWin+ynMB+a4x1cvTyiT3
    +6lgIy9bH+T3BYWkJl9zhbMQC0ohHqszqMjJCF2cnKb0yxbX1C5z8+9iJIX+xBGFu0pe
    7mcfiqmn6YmmyNu62o0qUWINqhbEI9d4WHqytl90v/jHQIMUYKYNSH1T2wRes2T1HStv
    UaB8qppz5CwXe1bCDMeSwEcQEwd9bRkNmyCSCpqZCUhZjdigh8n4/G4LUXD7VjNrIJCa
    LlUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767969735;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=wi9a5tgBe+o+pgAwz70lXPzoEk1ctlZykoClWF5Pw4g=;
    b=Af7Y/Labnse0TlOySvGLXoiHBxH3iqZNUCMlQL+cz3mW5d66QQuJ5Jj0J8OHBhFBqB
    dEDOjJ+XqXy1VyUXfYDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b209EgFPL8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 9 Jan 2026 15:42:15 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH 2/3] can: propagate CAN device capabilities via ml_priv
Date: Fri,  9 Jan 2026 15:41:34 +0100
Message-ID: <20260109144135.8495-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109144135.8495-1-socketcan@hartkopp.net>
References: <20260109144135.8495-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

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
@@ -373,10 +373,36 @@ void can_set_default_mtu(struct net_device *dev)
 		dev->min_mtu = CAN_MTU;
 		dev->max_mtu = CAN_MTU;
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
 	struct can_priv *priv = netdev_priv(dev);
 
@@ -388,10 +414,11 @@ int can_set_static_ctrlmode(struct net_device *dev, u32 static_mode)
 	}
 	priv->ctrlmode = static_mode;
 
 	/* override MTU which was set by default in can_setup()? */
 	can_set_default_mtu(dev);
+	can_set_cap_info(dev);
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(can_set_static_ctrlmode);
 
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index d6b0e686fb11..0498198a4696 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -375,10 +375,11 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 		memset(&priv->xl.tdc, 0, sizeof(priv->xl.tdc));
 		memset(&priv->xl.pwm, 0, sizeof(priv->xl.pwm));
 	}
 
 	can_set_default_mtu(dev);
+	can_set_cap_info(dev);
 
 	return 0;
 }
 
 static int can_tdc_changelink(struct data_bittiming_params *dbt_params,
diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index fdc662aea279..76e6b7b5c6a1 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -128,10 +128,23 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 		consume_skb(skb);
 	}
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
 	if (dev->flags & IFF_UP)
 		return -EBUSY;
@@ -139,10 +152,11 @@ static int vcan_change_mtu(struct net_device *dev, int new_mtu)
 	if (new_mtu != CAN_MTU && new_mtu != CANFD_MTU &&
 	    !can_is_canxl_dev_mtu(new_mtu))
 		return -EINVAL;
 
 	WRITE_ONCE(dev->mtu, new_mtu);
+	vcan_set_cap_info(dev);
 	return 0;
 }
 
 static const struct net_device_ops vcan_netdev_ops = {
 	.ndo_start_xmit = vcan_tx,
@@ -160,10 +174,11 @@ static void vcan_setup(struct net_device *dev)
 	dev->hard_header_len	= 0;
 	dev->addr_len		= 0;
 	dev->tx_queue_len	= 0;
 	dev->flags		= IFF_NOARP;
 	can_set_ml_priv(dev, netdev_priv(dev));
+	vcan_set_cap_info(dev);
 
 	/* set flags according to driver capabilities */
 	if (echo)
 		dev->flags |= IFF_ECHO;
 
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index b2c19f8c5f8e..f14c6f02b662 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -123,10 +123,23 @@ static int vxcan_get_iflink(const struct net_device *dev)
 	rcu_read_unlock();
 
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
 	if (dev->flags & IFF_UP)
 		return -EBUSY;
@@ -134,10 +147,11 @@ static int vxcan_change_mtu(struct net_device *dev, int new_mtu)
 	if (new_mtu != CAN_MTU && new_mtu != CANFD_MTU &&
 	    !can_is_canxl_dev_mtu(new_mtu))
 		return -EINVAL;
 
 	WRITE_ONCE(dev->mtu, new_mtu);
+	vxcan_set_cap_info(dev);
 	return 0;
 }
 
 static const struct net_device_ops vxcan_netdev_ops = {
 	.ndo_open	= vxcan_open,
@@ -165,10 +179,11 @@ static void vxcan_setup(struct net_device *dev)
 	dev->ethtool_ops	= &vxcan_ethtool_ops;
 	dev->needs_free_netdev	= true;
 
 	can_ml = netdev_priv(dev) + ALIGN(sizeof(struct vxcan_priv), NETDEV_ALIGN);
 	can_set_ml_priv(dev, can_ml);
+	vxcan_set_cap_info(dev);
 }
 
 /* forward declaration for rtnl_create_link() */
 static struct rtnl_link_ops vxcan_link_ops;
 
diff --git a/include/linux/can/can-ml.h b/include/linux/can/can-ml.h
index 8afa92d15a66..1e99fda2b380 100644
--- a/include/linux/can/can-ml.h
+++ b/include/linux/can/can-ml.h
@@ -44,10 +44,16 @@
 
 #include <linux/can.h>
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
 
 enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
@@ -62,10 +68,11 @@ struct can_dev_rcv_lists {
 struct can_ml_priv {
 	struct can_dev_rcv_lists dev_rcv_lists;
 #ifdef CAN_J1939
 	struct j1939_priv *j1939_priv;
 #endif
+	u32 can_cap;
 };
 
 static inline struct can_ml_priv *can_get_ml_priv(struct net_device *dev)
 {
 	return netdev_get_ml_priv(dev, ML_PRIV_CAN);
@@ -75,6 +82,23 @@ static inline void can_set_ml_priv(struct net_device *dev,
 				   struct can_ml_priv *ml_priv)
 {
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
@@ -114,10 +114,11 @@ void free_candev(struct net_device *dev);
 struct can_priv *safe_candev_priv(struct net_device *dev);
 
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
 void can_set_default_mtu(struct net_device *dev);
+void can_set_cap_info(struct net_device *dev);
 int __must_check can_set_static_ctrlmode(struct net_device *dev,
 					 u32 static_mode);
 int can_hwtstamp_get(struct net_device *netdev,
 		     struct kernel_hwtstamp_config *cfg);
 int can_hwtstamp_set(struct net_device *netdev,
-- 
2.47.3


