Return-Path: <linux-can+bounces-5222-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EED72BE98C2
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 17:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FC01AE012C
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 15:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462A336CDEE;
	Fri, 17 Oct 2025 15:08:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6426F336EC1
	for <linux-can@vger.kernel.org>; Fri, 17 Oct 2025 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713725; cv=none; b=KTlrpYHI/Kp1Pi3hVL25gYurWRJjyEAlyHQNN0UIr4zmAdFrBJ2HzCWgYFBxw+Uajawy9mqnnuscVuE4MgyjmoxZqpEzWD+zxsVBqiF+TKQ1FYb3BO+OiiG9PSxPrNx9V1Ri7qB3VUGWqGEYCiCpgzX7hgjwSz9XkuiYm7sUpr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713725; c=relaxed/simple;
	bh=i7GlmmzGrsWId0qWdurB13ekKjuFl1J3TBA+cQzYW70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdBhiL642yn/8ukHqKwAHEaE7fRTyF3ZPndTwb1avSQ1X5QULDz/A8SapjeIXLIQR5LxHvZKzoXitxOydKL6nZe1XjG6eR0c8sQqQYb0+FMtQLGsK6lhTs/vn06O9ZShqozvuN/il6YsgvQsaqJF1YnqwZBtTopBqkWwOKULe1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4E-0003NG-2U; Fri, 17 Oct 2025 17:08:30 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4D-00450Y-1e;
	Fri, 17 Oct 2025 17:08:29 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 17AD04892B3;
	Fri, 17 Oct 2025 15:08:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/13] can: treewide: remove can_change_mtu()
Date: Fri, 17 Oct 2025 17:04:10 +0200
Message-ID: <20251017150819.1415685-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017150819.1415685-1-mkl@pengutronix.de>
References: <20251017150819.1415685-1-mkl@pengutronix.de>
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

can_change_mtu() became obsolete by commit 23049938605b ("can: populate the
minimum and maximum MTU values"). Now that net_device->min_mtu and
net_device->max_mtu are populated, all the checks are already done by
dev_validate_mtu() in net/core/dev.c.

Remove the net_device_ops->ndo_change_mtu() callback of all the physical
interfaces, then remove can_change_mtu(). Only keep the vcan_change_mtu()
and vxcan_change_mtu() because the virtual interfaces use their own
different MTU logic.

The only functional change this patch introduces is that now the user will
be able to change the MTU even if the interface is up. This does not matter
for Classical CAN and CAN FD because their MTU range is composed of only
one value, respectively CAN_MTU and CANFD_MTU. For the upcoming CAN XL, the
MTU will be configurable within the CANXL_MIN_MTU to CANXL_MAX_MTU range at
any time, even if the interface is up. This is consistent with the other
net protocols and does not contradict ISO 11898-1:2024 as having a
modifiable MTU is a kernel extension.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20251003-remove-can_change_mtu-v1-1-337f8bc21181@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c                    |  1 -
 drivers/net/can/bxcan.c                       |  1 -
 drivers/net/can/c_can/c_can_main.c            |  1 -
 drivers/net/can/can327.c                      |  1 -
 drivers/net/can/cc770/cc770.c                 |  1 -
 drivers/net/can/ctucanfd/ctucanfd_base.c      |  1 -
 drivers/net/can/dev/dev.c                     | 38 -------------------
 drivers/net/can/esd/esd_402_pci-core.c        |  1 -
 drivers/net/can/flexcan/flexcan-core.c        |  1 -
 drivers/net/can/grcan.c                       |  1 -
 drivers/net/can/ifi_canfd/ifi_canfd.c         |  1 -
 drivers/net/can/janz-ican3.c                  |  1 -
 .../can/kvaser_pciefd/kvaser_pciefd_core.c    |  1 -
 drivers/net/can/m_can/m_can.c                 |  1 -
 drivers/net/can/mscan/mscan.c                 |  1 -
 drivers/net/can/peak_canfd/peak_canfd.c       |  1 -
 drivers/net/can/rcar/rcar_can.c               |  1 -
 drivers/net/can/rcar/rcar_canfd.c             |  1 -
 .../net/can/rockchip/rockchip_canfd-core.c    |  1 -
 drivers/net/can/sja1000/sja1000.c             |  1 -
 drivers/net/can/slcan/slcan-core.c            |  1 -
 drivers/net/can/softing/softing_main.c        |  1 -
 drivers/net/can/spi/hi311x.c                  |  1 -
 drivers/net/can/spi/mcp251x.c                 |  1 -
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    |  1 -
 drivers/net/can/sun4i_can.c                   |  1 -
 drivers/net/can/ti_hecc.c                     |  1 -
 drivers/net/can/usb/ems_usb.c                 |  1 -
 drivers/net/can/usb/esd_usb.c                 |  1 -
 drivers/net/can/usb/etas_es58x/es58x_core.c   |  1 -
 drivers/net/can/usb/f81604.c                  |  1 -
 drivers/net/can/usb/gs_usb.c                  |  1 -
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  1 -
 drivers/net/can/usb/mcba_usb.c                |  1 -
 drivers/net/can/usb/nct6694_canfd.c           |  1 -
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  |  1 -
 drivers/net/can/usb/ucan.c                    |  1 -
 drivers/net/can/usb/usb_8dev.c                |  1 -
 drivers/net/can/xilinx_can.c                  |  1 -
 include/linux/can/dev.h                       |  1 -
 40 files changed, 77 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 191707d7e3da..c2a3a4eef5b2 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -948,7 +948,6 @@ static const struct net_device_ops at91_netdev_ops = {
 	.ndo_open	= at91_open,
 	.ndo_stop	= at91_close,
 	.ndo_start_xmit	= at91_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops at91_ethtool_ops = {
diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
index bfc60eb33dc3..9c3af7049814 100644
--- a/drivers/net/can/bxcan.c
+++ b/drivers/net/can/bxcan.c
@@ -881,7 +881,6 @@ static const struct net_device_ops bxcan_netdev_ops = {
 	.ndo_open = bxcan_open,
 	.ndo_stop = bxcan_stop,
 	.ndo_start_xmit = bxcan_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops bxcan_ethtool_ops = {
diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index cc371d0c9f3c..3702cac7fbf0 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -1362,7 +1362,6 @@ static const struct net_device_ops c_can_netdev_ops = {
 	.ndo_open = c_can_open,
 	.ndo_stop = c_can_close,
 	.ndo_start_xmit = c_can_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 int register_c_can_dev(struct net_device *dev)
diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 24af63961030..b66fc16aedd2 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -849,7 +849,6 @@ static const struct net_device_ops can327_netdev_ops = {
 	.ndo_open = can327_netdev_open,
 	.ndo_stop = can327_netdev_close,
 	.ndo_start_xmit = can327_netdev_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops can327_ethtool_ops = {
diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 30909f3aab57..8d5abd643c06 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -834,7 +834,6 @@ static const struct net_device_ops cc770_netdev_ops = {
 	.ndo_open = cc770_open,
 	.ndo_stop = cc770_close,
 	.ndo_start_xmit = cc770_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops cc770_ethtool_ops = {
diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 8bd3f0fc385c..1e6b9e3dc2fe 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -1301,7 +1301,6 @@ static const struct net_device_ops ctucan_netdev_ops = {
 	.ndo_open	= ctucan_open,
 	.ndo_stop	= ctucan_close,
 	.ndo_start_xmit	= ctucan_start_xmit,
-	.ndo_change_mtu	= can_change_mtu,
 };
 
 static const struct ethtool_ops ctucan_ethtool_ops = {
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 15ccedbb3f8d..0cc3d008adb3 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -359,44 +359,6 @@ void can_set_default_mtu(struct net_device *dev)
 	}
 }
 
-/* changing MTU and control mode for CAN/CANFD devices */
-int can_change_mtu(struct net_device *dev, int new_mtu)
-{
-	struct can_priv *priv = netdev_priv(dev);
-	u32 ctrlmode_static = can_get_static_ctrlmode(priv);
-
-	/* Do not allow changing the MTU while running */
-	if (dev->flags & IFF_UP)
-		return -EBUSY;
-
-	/* allow change of MTU according to the CANFD ability of the device */
-	switch (new_mtu) {
-	case CAN_MTU:
-		/* 'CANFD-only' controllers can not switch to CAN_MTU */
-		if (ctrlmode_static & CAN_CTRLMODE_FD)
-			return -EINVAL;
-
-		priv->ctrlmode &= ~CAN_CTRLMODE_FD;
-		break;
-
-	case CANFD_MTU:
-		/* check for potential CANFD ability */
-		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD) &&
-		    !(ctrlmode_static & CAN_CTRLMODE_FD))
-			return -EINVAL;
-
-		priv->ctrlmode |= CAN_CTRLMODE_FD;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	WRITE_ONCE(dev->mtu, new_mtu);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(can_change_mtu);
-
 /* helper to define static CAN controller features at device creation time */
 int can_set_static_ctrlmode(struct net_device *dev, u32 static_mode)
 {
diff --git a/drivers/net/can/esd/esd_402_pci-core.c b/drivers/net/can/esd/esd_402_pci-core.c
index 5d6d2828cd04..05adecae6375 100644
--- a/drivers/net/can/esd/esd_402_pci-core.c
+++ b/drivers/net/can/esd/esd_402_pci-core.c
@@ -86,7 +86,6 @@ static const struct net_device_ops pci402_acc_netdev_ops = {
 	.ndo_open = acc_open,
 	.ndo_stop = acc_close,
 	.ndo_start_xmit = acc_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 };
 
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 06d5d35fc1b5..f5d22c61503f 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1867,7 +1867,6 @@ static const struct net_device_ops flexcan_netdev_ops = {
 	.ndo_open	= flexcan_open,
 	.ndo_stop	= flexcan_close,
 	.ndo_start_xmit	= flexcan_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static int register_flexcandev(struct net_device *dev)
diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index c5784d9779ef..3b1b09943436 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1561,7 +1561,6 @@ static const struct net_device_ops grcan_netdev_ops = {
 	.ndo_open	= grcan_open,
 	.ndo_stop	= grcan_close,
 	.ndo_start_xmit	= grcan_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops grcan_ethtool_ops = {
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 2eeee65f606f..0f83335e4d07 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -944,7 +944,6 @@ static const struct net_device_ops ifi_canfd_netdev_ops = {
 	.ndo_open	= ifi_canfd_open,
 	.ndo_stop	= ifi_canfd_close,
 	.ndo_start_xmit	= ifi_canfd_start_xmit,
-	.ndo_change_mtu	= can_change_mtu,
 };
 
 static const struct ethtool_ops ifi_canfd_ethtool_ops = {
diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index bfa5cbe88017..1efdd1fd8caa 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1752,7 +1752,6 @@ static const struct net_device_ops ican3_netdev_ops = {
 	.ndo_open	= ican3_open,
 	.ndo_stop	= ican3_stop,
 	.ndo_start_xmit	= ican3_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops ican3_ethtool_ops = {
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
index 0880023611be..705f9bb74cd2 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
@@ -904,7 +904,6 @@ static const struct net_device_ops kvaser_pciefd_netdev_ops = {
 	.ndo_stop = kvaser_pciefd_stop,
 	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 	.ndo_start_xmit = kvaser_pciefd_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static int kvaser_pciefd_set_phys_id(struct net_device *netdev,
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 48b7a67336b5..873f5991fc5a 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2148,7 +2148,6 @@ static const struct net_device_ops m_can_netdev_ops = {
 	.ndo_open = m_can_open,
 	.ndo_stop = m_can_close,
 	.ndo_start_xmit = m_can_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static int m_can_get_coalesce(struct net_device *dev,
diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 8c2a7bc64d3d..39c7aa2a0b2f 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -607,7 +607,6 @@ static const struct net_device_ops mscan_netdev_ops = {
 	.ndo_open	= mscan_open,
 	.ndo_stop	= mscan_close,
 	.ndo_start_xmit	= mscan_start_xmit,
-	.ndo_change_mtu	= can_change_mtu,
 };
 
 static const struct ethtool_ops mscan_ethtool_ops = {
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index b5bc80ac7876..a53c9d347b7b 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -773,7 +773,6 @@ static const struct net_device_ops peak_canfd_netdev_ops = {
 	.ndo_stop = peak_canfd_close,
 	.ndo_eth_ioctl = peak_eth_ioctl,
 	.ndo_start_xmit = peak_canfd_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static int peak_get_ts_info(struct net_device *dev,
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 5f85f4e27205..fc3df328e877 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -635,7 +635,6 @@ static const struct net_device_ops rcar_can_netdev_ops = {
 	.ndo_open = rcar_can_open,
 	.ndo_stop = rcar_can_close,
 	.ndo_start_xmit = rcar_can_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops rcar_can_ethtool_ops = {
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 45d36adb51b7..49ab65274b51 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1818,7 +1818,6 @@ static const struct net_device_ops rcar_canfd_netdev_ops = {
 	.ndo_open = rcar_canfd_open,
 	.ndo_stop = rcar_canfd_close,
 	.ndo_start_xmit = rcar_canfd_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops rcar_canfd_ethtool_ops = {
diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 046f0a0ae4d4..29de0c01e4ed 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -761,7 +761,6 @@ static const struct net_device_ops rkcanfd_netdev_ops = {
 	.ndo_open = rkcanfd_open,
 	.ndo_stop = rkcanfd_stop,
 	.ndo_start_xmit = rkcanfd_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static int __maybe_unused rkcanfd_runtime_suspend(struct device *dev)
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 4d245857ef1c..acfa49db3907 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -697,7 +697,6 @@ static const struct net_device_ops sja1000_netdev_ops = {
 	.ndo_open	= sja1000_open,
 	.ndo_stop	= sja1000_close,
 	.ndo_start_xmit	= sja1000_start_xmit,
-	.ndo_change_mtu	= can_change_mtu,
 };
 
 static const struct ethtool_ops sja1000_ethtool_ops = {
diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 58ff2ec1d975..cd789e178d34 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -774,7 +774,6 @@ static const struct net_device_ops slcan_netdev_ops = {
 	.ndo_open               = slcan_netdev_open,
 	.ndo_stop               = slcan_netdev_close,
 	.ndo_start_xmit         = slcan_netdev_xmit,
-	.ndo_change_mtu         = can_change_mtu,
 };
 
 /******************************************
diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index 278ee8722770..79bc64395ac4 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -609,7 +609,6 @@ static const struct net_device_ops softing_netdev_ops = {
 	.ndo_open = softing_netdev_open,
 	.ndo_stop = softing_netdev_stop,
 	.ndo_start_xmit	= softing_netdev_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops softing_ethtool_ops = {
diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 6d4b643e135f..e00d3dbc4cf4 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -799,7 +799,6 @@ static const struct net_device_ops hi3110_netdev_ops = {
 	.ndo_open = hi3110_open,
 	.ndo_stop = hi3110_stop,
 	.ndo_start_xmit = hi3110_hard_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops hi3110_ethtool_ops = {
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index b797e08499d7..1e54e1a22702 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1270,7 +1270,6 @@ static const struct net_device_ops mcp251x_netdev_ops = {
 	.ndo_open = mcp251x_open,
 	.ndo_stop = mcp251x_stop,
 	.ndo_start_xmit = mcp251x_hard_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops mcp251x_ethtool_ops = {
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 7450ea42c1ea..9402530ba3d4 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1715,7 +1715,6 @@ static const struct net_device_ops mcp251xfd_netdev_ops = {
 	.ndo_stop = mcp251xfd_stop,
 	.ndo_start_xmit	= mcp251xfd_start_xmit,
 	.ndo_eth_ioctl = can_eth_ioctl_hwts,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static void
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 53bfd873de9b..6fcb301ef611 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -768,7 +768,6 @@ static const struct net_device_ops sun4ican_netdev_ops = {
 	.ndo_open = sun4ican_open,
 	.ndo_stop = sun4ican_close,
 	.ndo_start_xmit = sun4ican_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops sun4ican_ethtool_ops = {
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index e6d6661a908a..1d3dbf28b105 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -829,7 +829,6 @@ static const struct net_device_ops ti_hecc_netdev_ops = {
 	.ndo_open		= ti_hecc_open,
 	.ndo_stop		= ti_hecc_close,
 	.ndo_start_xmit		= ti_hecc_xmit,
-	.ndo_change_mtu		= can_change_mtu,
 };
 
 static const struct ethtool_ops ti_hecc_ethtool_ops = {
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 5355bac4dccb..de8e212a1366 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -885,7 +885,6 @@ static const struct net_device_ops ems_usb_netdev_ops = {
 	.ndo_open = ems_usb_open,
 	.ndo_stop = ems_usb_close,
 	.ndo_start_xmit = ems_usb_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops ems_usb_ethtool_ops = {
diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 9bc1824d7be6..08da507faef4 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -1011,7 +1011,6 @@ static const struct net_device_ops esd_usb_netdev_ops = {
 	.ndo_open = esd_usb_open,
 	.ndo_stop = esd_usb_close,
 	.ndo_start_xmit = esd_usb_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops esd_usb_ethtool_ops = {
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index adc91873c083..47d9e03f3044 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -1977,7 +1977,6 @@ static const struct net_device_ops es58x_netdev_ops = {
 	.ndo_stop = es58x_stop,
 	.ndo_start_xmit = es58x_start_xmit,
 	.ndo_eth_ioctl = can_eth_ioctl_hwts,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops es58x_ethtool_ops = {
diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index e0cfa1460b0b..efe61ece79ea 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -1052,7 +1052,6 @@ static const struct net_device_ops f81604_netdev_ops = {
 	.ndo_open = f81604_open,
 	.ndo_stop = f81604_close,
 	.ndo_start_xmit = f81604_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct can_bittiming_const f81604_bittiming_const = {
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 69b8d6da651b..30608901a974 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1101,7 +1101,6 @@ static const struct net_device_ops gs_usb_netdev_ops = {
 	.ndo_open = gs_can_open,
 	.ndo_stop = gs_can_close,
 	.ndo_start_xmit = gs_can_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 	.ndo_eth_ioctl = gs_can_eth_ioctl,
 };
 
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 90e77fa0ff4a..89e22b66f919 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -786,7 +786,6 @@ static const struct net_device_ops kvaser_usb_netdev_ops = {
 	.ndo_stop = kvaser_usb_close,
 	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 	.ndo_start_xmit = kvaser_usb_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops kvaser_usb_ethtool_ops = {
diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index 1f9b915094e6..41c0a1c399bf 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -761,7 +761,6 @@ static const struct net_device_ops mcba_netdev_ops = {
 	.ndo_open = mcba_usb_open,
 	.ndo_stop = mcba_usb_close,
 	.ndo_start_xmit = mcba_usb_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops mcba_ethtool_ops = {
diff --git a/drivers/net/can/usb/nct6694_canfd.c b/drivers/net/can/usb/nct6694_canfd.c
index 8deff16491a1..dd6df2ec3742 100644
--- a/drivers/net/can/usb/nct6694_canfd.c
+++ b/drivers/net/can/usb/nct6694_canfd.c
@@ -690,7 +690,6 @@ static const struct net_device_ops nct6694_canfd_netdev_ops = {
 	.ndo_open = nct6694_canfd_open,
 	.ndo_stop = nct6694_canfd_close,
 	.ndo_start_xmit = nct6694_canfd_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops nct6694_canfd_ethtool_ops = {
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index c74302ca7cee..94b1d7f15d27 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -814,7 +814,6 @@ static const struct net_device_ops peak_usb_netdev_ops = {
 	.ndo_stop = peak_usb_ndo_stop,
 	.ndo_eth_ioctl = peak_eth_ioctl,
 	.ndo_start_xmit = peak_usb_ndo_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 /* CAN-USB devices generally handle 32-bit CAN channel IDs.
diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 07406daf7c88..de61d9da99e3 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1233,7 +1233,6 @@ static const struct net_device_ops ucan_netdev_ops = {
 	.ndo_open = ucan_open,
 	.ndo_stop = ucan_close,
 	.ndo_start_xmit = ucan_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops ucan_ethtool_ops = {
diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index 8a5596ce4e46..7449328f7cd7 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -868,7 +868,6 @@ static const struct net_device_ops usb_8dev_netdev_ops = {
 	.ndo_open = usb_8dev_open,
 	.ndo_stop = usb_8dev_close,
 	.ndo_start_xmit = usb_8dev_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops usb_8dev_ethtool_ops = {
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index a25a3ca62c12..43d7f22820b8 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1702,7 +1702,6 @@ static const struct net_device_ops xcan_netdev_ops = {
 	.ndo_open	= xcan_open,
 	.ndo_stop	= xcan_close,
 	.ndo_start_xmit	= xcan_start_xmit,
-	.ndo_change_mtu	= can_change_mtu,
 };
 
 static const struct ethtool_ops xcan_ethtool_ops = {
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index a2229a61ccde..0fe8f80f223e 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -127,7 +127,6 @@ struct can_priv *safe_candev_priv(struct net_device *dev);
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
 void can_set_default_mtu(struct net_device *dev);
-int can_change_mtu(struct net_device *dev, int new_mtu);
 int __must_check can_set_static_ctrlmode(struct net_device *dev,
 					 u32 static_mode);
 int can_eth_ioctl_hwts(struct net_device *netdev, struct ifreq *ifr, int cmd);
-- 
2.51.0


