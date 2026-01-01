Return-Path: <linux-can+bounces-5983-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E433ACED4AD
	for <lists+linux-can@lfdr.de>; Thu, 01 Jan 2026 20:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C22A3000970
	for <lists+linux-can@lfdr.de>; Thu,  1 Jan 2026 19:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30CA2E285C;
	Thu,  1 Jan 2026 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="c7sZlAge";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KfiklUf1"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C7E145348
	for <linux-can@vger.kernel.org>; Thu,  1 Jan 2026 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767294849; cv=pass; b=J9oj680Ds5EAxNbVbtcis/qjEte6zURAlTrxXl6METlNYet0QIYWLIjJ8q6Mc5KB6QmbGRfqdkE9VMei9RDPd6AA5Iki5SBp8pQpweS0I+TcZW0rPt4XV2w7s39tm7DhVftGABuVsSBZ8w6zNXuOafnSLTtI9T44crsIYTnYAbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767294849; c=relaxed/simple;
	bh=AZSllwFtUWCTL9igCLaCDeW9Hsm5dp0VZknOUha5TOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXjdDxG4wK2WJ+wHMHEIP0K0pW5F8hHlWop6RB3TJiCtmr1nKo1C0wCEnXmnyji7bKj6j2jgY1USiyh6OWktX6SFGWind2GZ9zSUyLj5osYSyhACKQVN+LjiuFIz9j+dbwlQWMrDWdfxBaKQIiSlchO3MdFg0BIvHargUg+cNI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=c7sZlAge; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KfiklUf1; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767294827; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lk4NmGrgSgeghnxU4nyqryov+zTIGkO/PPBFV4fSLVCRtxi3KQ6tDdZ9GnMIwfRwEj
    tfgyOVAJChIqL2IpvIsZvd+lEsoM5HnVORB7GVVyi+U9DLpIvGZAHol6aGeLFQSaUAy2
    xAVGaGx+ht/W2ZFOJSG89NB8RW60nsLBOD6BLSoNLeq9AeSErN5KXMhlBUeJYiqd4qGy
    p6mAr/tglVzRF61XLIKuBxy+72MThfgwzXTYxpQTlcmVFvP9O5mmeBj4kXQ51jF3I0tT
    0sy15IvZH7lUtkte75UTqK521iiGvghTErpxDLAf8QP2hPtFS982q8cajzvvLjglyFcs
    hPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767294827;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nk3aeG1DuA4S2Wvniu0IOjYLLTVbUy5QP7X5lsncIzI=;
    b=fIcm+0v07VykZOnNPWnJK53h/7zz2qMuFlIFexMs+V4S5MGr6H51Yoikv66O/cMzUq
    ACB0lNnfG7KjsGUmxmidd5KqmQGFKJ7DTF9LVvWVgpKP/qZfSj5wGZzwDHcGEn7Yt/gU
    NbgeHZNC3bJsMeVFUP4rBe2Basrny0i8rLr7dcLulkG+maOe/g6UrQbUse8TPbGuVR7H
    hY5LtnaowZe8c9W8DsRX3/eC2TKT4grh6Um3PXjKmh0Bf51ZRgcOWo+9VWqV+Ep/WXls
    KdNaceEsuMdDSs7BzacqBXPgCLYLO3IOgROZ1joI1MSp9cFKIEGWHVd/v7j3d4Qn2eKR
    xaZg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767294827;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nk3aeG1DuA4S2Wvniu0IOjYLLTVbUy5QP7X5lsncIzI=;
    b=c7sZlAgevwA0V0huGIIF7IYfYETPgq/A7P88cgo4HMdROdOOebRnDXV7nhVBBtDy8t
    oRe7iz0rfdr1tBBD5JEGXtzQZwiEGFLaqNMbnjv/nhvOqASUqOjpZ3QIwXLrBTTPiqYt
    RtsOMBglNgZS1X5vnKXgBJfz14Gf6fCqFPwylMf3DEoVES2O7o8aPo2qioixHxMyyn/r
    JMfskdUpgew7+PbjA0/4doeX7JgyjCTSgEHwNRn7qYRwNQohLvHWH0EEeIhnRku9iNbs
    YjWtuvY04O2vQz/L/gI9ySpt/zBnDvnEKMIGmZTQw/upTHTKAxewoIEoCyAjq2EyazuK
    WubA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767294827;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nk3aeG1DuA4S2Wvniu0IOjYLLTVbUy5QP7X5lsncIzI=;
    b=KfiklUf13ry3n1zrPnkGmmTS0fxnFSCmgfU6fNgIUn11zRBJ6mk8bkXz9IRMbNCqYS
    CKTgHDjTiVmmlozxVjCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b201JDle42
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 1 Jan 2026 20:13:47 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH 2/3] can: propagate CAN device capabilities via ml_priv
Date: Thu,  1 Jan 2026 20:13:29 +0100
Message-ID: <20260101191330.1836-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260101191330.1836-1-socketcan@hartkopp.net>
References: <20260101191330.1836-1-socketcan@hartkopp.net>
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

The entire problem was caused by the requirement that a new network layer
feature needed to know about the protocol capabilities of the CAN devices.
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
 drivers/net/can/dev/dev.c     | 24 ++++++++++++++++++++++++
 drivers/net/can/dev/netlink.c |  1 +
 drivers/net/can/vcan.c        | 15 +++++++++++++++
 drivers/net/can/vxcan.c       | 15 +++++++++++++++
 include/linux/can/can-ml.h    | 25 +++++++++++++++++++++++++
 include/linux/can/dev.h       |  1 +
 6 files changed, 81 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 091f30e94c61..aaa669fc0d2b 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -373,10 +373,33 @@ void can_set_default_mtu(struct net_device *dev)
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
 
@@ -388,10 +411,11 @@ int can_set_static_ctrlmode(struct net_device *dev, u32 static_mode)
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
index 8afa92d15a66..ff77097ae79f 100644
--- a/include/linux/can/can-ml.h
+++ b/include/linux/can/can-ml.h
@@ -44,10 +44,16 @@
 
 #include <linux/can.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
 
+/* exposed CAN device capabilities for network layer */
+#define CAN_CAP_CC 0x1U /* CAN CC aka Classical CAN */
+#define CAN_CAP_FD 0x2U /* CAN FD */
+#define CAN_CAP_XL 0x4U /* CAN XL */
+#define CAN_CAP_RO 0x8U /* read-only mode (LISTEN/RESTRICTED) */
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
@@ -75,6 +82,24 @@ static inline void can_set_ml_priv(struct net_device *dev,
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


