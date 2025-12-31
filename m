Return-Path: <linux-can+bounces-5970-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9CECEC4A5
	for <lists+linux-can@lfdr.de>; Wed, 31 Dec 2025 17:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B6803000EAF
	for <lists+linux-can@lfdr.de>; Wed, 31 Dec 2025 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D304286417;
	Wed, 31 Dec 2025 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="FScB4wzv";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="9t/pFafU"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81468281358
	for <linux-can@vger.kernel.org>; Wed, 31 Dec 2025 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767199917; cv=pass; b=jeyR8iHwEWsx5DBBPvI4jOVBD6/hWZh798TdONVhUoB66HgCV0ixhnnHtHCRpP2jTpOBt11AOLEP3SdFx95bauAK8WBeS7COwIKPJkEZFexO+NKSbhubEPikT6AvzbkxQX/tarOwGIWdb352oJUFpVz0BR7y1d0dfAmBme95g3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767199917; c=relaxed/simple;
	bh=GZPGfLEyOw5yeKk6E2RVSfjG2MmiDv61gySOOZAWcho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bZzsWjcJMTKqNzhLabLDxpqzeCuwtUS2vHiTceHXXn+1jRRblPre/IvZRXEPDoE9ppICkHSyG1b5CAuIeBqQe64mli0ZZC6jlxPoVZi1IL+4LCW6YsuLE/ErZWWybM8wu878jP+1NwNxq166XQ1JFGmhELhSAmCQ1w5LHp7NIyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=FScB4wzv; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=9t/pFafU; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767199894; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=o7lb88Gk0MAUv916qDR4ln2ixpxwT7QHdDJvgNojjFjeebSIDuzHF3zYYjZSSUax+t
    mIHvPohskxwKTkqs6Gw4EeQUP9T2czE3IdlIH60DyUhiv1oHqN25/JuPBCX8QWA0kODN
    COv6hmU6ym2wDO6SJViLdbuougiuKZePHE0NbxiuOgdDnwKrtwx26EX1A88CraKrAmI4
    ftu777ziVWbf7seehtUUvGyezqQFw6qKZKf0QS5FmJ9n4EMHYJMbTSbKJVem6NzCFsl+
    M0zO7hQoi1jqtaRd2E5U4nnZH27LDi+iASXosuIPWjRwEPhr78yQvOP5zSd4uxLBNslB
    edWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767199894;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=N6RePI59y/cFOsIrt32ukJNk4pL+b1U7mz8AkJUw8xo=;
    b=SLcqA1+G+h3HYf5FUtT2pwMFLjauhbA04wn9ctVGaA4+SqjMtvfdbnbCiv+2/pf+Dx
    rxZuCxflop2FgInRw44FzMwYDlMC5H9kzmx+0yQi9Iy8fzWz5hUGBwZLUcvU/OYh8/kt
    07xsJuEttWH7pq9sgc+spUddBRGy4K7i4wl6jrIGLeA16aDGTKlHYbllC11oLB6YR0a6
    PInnw6bSFwSqhrYuByitgQeQTHeYUG/oe7JytOqP1zFtZfXJmBJoNzv1DUOo3OTiWrZX
    vpUtGsNM6P93fTOvrAOUbGM4pEtWkNj02xIPD5WSjhONtLhNXA46y0/mBxikFrSxqu4b
    FPUQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767199894;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=N6RePI59y/cFOsIrt32ukJNk4pL+b1U7mz8AkJUw8xo=;
    b=FScB4wzvPpekPb66GDm77sib3i3QcQvBrHh19nXmsu7KoRwIvQg9dcVEMlUm+VCilG
    sFivxufgrStYVHTHbR+JjiU044CXWkxtoQpf6mJAquu0TUk585KxSy0152OxKyOr7+Yh
    69RGTF5xLJNd2LWvH92Fhqx0aBeGzrAOCHwvp4TI4f6aiKiOPXAIZiI+ILmBhRMkgmMl
    RM3sbyT571mMiJtI0NjGNy7xiCpQAdfP0I1+gojt5yXwU5fJnmWDpVeI0+lC0upaNUFH
    YYaKm2IHV7vlmkaoc8MPyGKitVTgarV6mAvdK+9vgj7rlPsKA7MuXgGvTRqRbCFdZtsx
    JgVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767199894;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=N6RePI59y/cFOsIrt32ukJNk4pL+b1U7mz8AkJUw8xo=;
    b=9t/pFafUpYP4qCYUae3scsGLcURxo/l9r93MmEoQZJ2pY5YQEaKrMFhL1GYqyqCi8K
    zEHq/QT0jN5McA0eUiAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b1BVGpYaFo
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 31 Dec 2025 17:51:34 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2] can: propagate CAN device capabilities via ml_priv
Date: Wed, 31 Dec 2025 17:51:27 +0100
Message-ID: <20251231165127.4206-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Commit 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
caused a sequence of dependency and linker fixes starting with commit
cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by default").

The entire problem was caused by the requirement that a new network layer
feature needed to know about the protocol capabilities of the CAN devices.
Instead of accessing CAN device internal data structures which caused the
dependency problems this patch introduces capabilty information into the
CAN specific ml_priv data which is accessible from both sides.

With this change the CAN network layer can check the required features and
the decoupling of the driver layer and network layer is restored.
Therefore the Kconfig and Makefile changes/fixes are reverted too.

Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
Fixes: cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by default")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/Kconfig       |  7 ++++--
 drivers/net/can/Makefile      |  2 +-
 drivers/net/can/dev/Makefile  |  5 ++--
 drivers/net/can/dev/dev.c     | 19 +++++++++++++++
 drivers/net/can/dev/netlink.c |  1 +
 drivers/net/can/vcan.c        | 15 ++++++++++++
 drivers/net/can/vxcan.c       | 15 ++++++++++++
 include/linux/can/can-ml.h    | 24 +++++++++++++++++++
 include/linux/can/dev.h       |  8 +------
 net/can/raw.c                 | 45 ++++-------------------------------
 10 files changed, 88 insertions(+), 53 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index cfaea6178a71..e15e320db476 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 menuconfig CAN_DEV
-	bool "CAN Device Drivers"
+	tristate "CAN Device Drivers"
 	default y
 	depends on CAN
 	help
 	  Controller Area Network (CAN) is serial communications protocol up to
 	  1Mbit/s for its original release (now known as Classical CAN) and up
@@ -15,11 +15,14 @@ menuconfig CAN_DEV
 
 	  This section contains all the CAN(-FD) device drivers including the
 	  virtual ones. If you own such devices or plan to use the virtual CAN
 	  interfaces to develop applications, say Y here.
 
-if CAN_DEV && CAN
+	  To compile as a module, choose M here: the module will be called
+	  can-dev.
+
+if CAN_DEV
 
 config CAN_VCAN
 	tristate "Virtual Local CAN Interface (vcan)"
 	help
 	  Similar to the network loopback devices, vcan offers a
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 37e2f1a2faec..d7bc10a6b8ea 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -5,11 +5,11 @@
 
 obj-$(CONFIG_CAN_VCAN)		+= vcan.o
 obj-$(CONFIG_CAN_VXCAN)		+= vxcan.o
 obj-$(CONFIG_CAN_SLCAN)		+= slcan/
 
-obj-$(CONFIG_CAN_DEV)		+= dev/
+obj-y				+= dev/
 obj-y				+= esd/
 obj-y				+= rcar/
 obj-y				+= rockchip/
 obj-y				+= spi/
 obj-y				+= usb/
diff --git a/drivers/net/can/dev/Makefile b/drivers/net/can/dev/Makefile
index 64226acf0f3d..633687d6b6c0 100644
--- a/drivers/net/can/dev/Makefile
+++ b/drivers/net/can/dev/Makefile
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_CAN) += can-dev.o
+obj-$(CONFIG_CAN_DEV) += can-dev.o
+
+can-dev-y += skb.o
 
-can-dev-$(CONFIG_CAN_DEV) += skb.o
 can-dev-$(CONFIG_CAN_CALC_BITTIMING) += calc_bittiming.o
 can-dev-$(CONFIG_CAN_NETLINK) += bittiming.o
 can-dev-$(CONFIG_CAN_NETLINK) += dev.o
 can-dev-$(CONFIG_CAN_NETLINK) += length.o
 can-dev-$(CONFIG_CAN_NETLINK) += netlink.o
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 091f30e94c61..3b726643f0ca 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -373,10 +373,28 @@ void can_set_default_mtu(struct net_device *dev)
 		dev->min_mtu = CAN_MTU;
 		dev->max_mtu = CAN_MTU;
 	}
 }
 
+void can_set_cap_info(struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	u32 can_cap = CAN_CAP_CC;
+
+	if (can_dev_in_xl_only_mode(priv)) {
+		/* XL only mode => no CC/FD capability */
+		can_cap = CAN_CAP_XL;
+	} else {
+		if (priv->ctrlmode & CAN_CTRLMODE_FD)
+			can_cap |= CAN_CAP_FD;
+
+		if (priv->ctrlmode & CAN_CTRLMODE_XL)
+			can_cap |= CAN_CAP_XL;
+	}
+	can_set_cap(dev, can_cap);
+}
+
 /* helper to define static CAN controller features at device creation time */
 int can_set_static_ctrlmode(struct net_device *dev, u32 static_mode)
 {
 	struct can_priv *priv = netdev_priv(dev);
 
@@ -388,10 +406,11 @@ int can_set_static_ctrlmode(struct net_device *dev, u32 static_mode)
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
index 8afa92d15a66..1f58ad3da44f 100644
--- a/include/linux/can/can-ml.h
+++ b/include/linux/can/can-ml.h
@@ -44,10 +44,15 @@
 
 #include <linux/can.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
 
+/* exposed CAN device capabilities for network layer */
+#define CAN_CAP_CC 0x1U
+#define CAN_CAP_FD 0x2U
+#define CAN_CAP_XL 0x4U
+
 #define CAN_SFF_RCV_ARRAY_SZ (1 << CAN_SFF_ID_BITS)
 #define CAN_EFF_RCV_HASH_BITS 10
 #define CAN_EFF_RCV_ARRAY_SZ (1 << CAN_EFF_RCV_HASH_BITS)
 
 enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
@@ -62,10 +67,11 @@ struct can_dev_rcv_lists {
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
@@ -75,6 +81,24 @@ static inline void can_set_ml_priv(struct net_device *dev,
 				   struct can_ml_priv *ml_priv)
 {
 	netdev_set_ml_priv(dev, ml_priv, ML_PRIV_CAN);
 }
 
+static inline bool can_cap_enabled(struct net_device *dev, u32 cap)
+{
+	struct can_ml_priv *can_ml = can_get_ml_priv(dev);
+
+	if (!can_ml)
+		return true;
+
+	return (can_ml->can_cap & cap);
+}
+
+static inline void can_set_cap(struct net_device *dev, u32 cap)
+{
+	struct can_ml_priv *can_ml = can_get_ml_priv(dev);
+
+	if (can_ml)
+		can_ml->can_cap = cap;
+}
+
 #endif /* CAN_ML_H */
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index f6416a56e95d..6d0710d6f571 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -109,22 +109,16 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 #define alloc_candev_mq(sizeof_priv, echo_skb_max, count) \
 	alloc_candev_mqs(sizeof_priv, echo_skb_max, count, count)
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
 void can_set_default_mtu(struct net_device *dev);
+void can_set_cap_info(struct net_device *dev);
 int __must_check can_set_static_ctrlmode(struct net_device *dev,
 					 u32 static_mode);
 int can_hwtstamp_get(struct net_device *netdev,
 		     struct kernel_hwtstamp_config *cfg);
 int can_hwtstamp_set(struct net_device *netdev,
diff --git a/net/can/raw.c b/net/can/raw.c
index be1ef7cf4204..baa29be9ab8a 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -48,11 +48,11 @@
 #include <linux/socket.h>
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
 #include <linux/can/core.h>
-#include <linux/can/dev.h> /* for can_is_canxl_dev_mtu() */
+#include <linux/can/can-ml.h> /* for can_cap_enabled() */
 #include <linux/can/skb.h>
 #include <linux/can/raw.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
@@ -890,62 +890,25 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
 		cxl->prio &= CANXL_PRIO_MASK;
 		cxl->prio |= ro->tx_vcid_shifted;
 	}
 }
 
-static inline bool raw_dev_cc_enabled(struct net_device *dev,
-				      struct can_priv *priv)
-{
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
 static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	struct can_priv *priv = safe_candev_priv(dev);
-
 	/* Classical CAN */
-	if (can_is_can_skb(skb) && raw_dev_cc_enabled(dev, priv))
+	if (can_is_can_skb(skb) && can_cap_enabled(dev, CAN_CAP_CC))
 		return CAN_MTU;
 
 	/* CAN FD */
 	if (ro->fd_frames && can_is_canfd_skb(skb) &&
-	    raw_dev_fd_enabled(dev, priv))
+	    can_cap_enabled(dev, CAN_CAP_FD))
 		return CANFD_MTU;
 
 	/* CAN XL */
 	if (ro->xl_frames && can_is_canxl_skb(skb) &&
-	    raw_dev_xl_enabled(dev, priv))
+	    can_cap_enabled(dev, CAN_CAP_XL))
 		return CANXL_MTU;
 
 	return 0;
 }
 
-- 
2.47.3


