Return-Path: <linux-can+bounces-4749-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44183B84B90
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 15:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FF64A0E6D
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536A6306D5F;
	Thu, 18 Sep 2025 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTAe/rcD"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD5E30507B;
	Thu, 18 Sep 2025 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200378; cv=none; b=a3N3XT0UjQPQHu29r7VXEsL5nqe5E6p+zP+VttQz+RajVmMSPwJjDLyEhmUQAG6lhgd5cxuAhErPOFczXsMVApr5S1RMmOZyItGPW4CKo1WRiZyWlOqJhbxiDk0bDiTtllt21xZt3lDvniJqEdD6XGwmAbl3IpnRRzNY4kPvXYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200378; c=relaxed/simple;
	bh=8e4AH5cMTHHcqjoFLfIew9bWw0KbjnDI78BfLcnDKcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iQEJP9BcWKdRBr47Ktk0ChhVyIeJnVC21X9Duz2ZTmvbYygPVxEaIsZ9Sfap1KojSBqpzMgsH6CGQW9kyFT7eepyP0MtlKAGscCGHBb64w73PeIZU0e10BycK3Xb28+lcaFDaT+jIfWZNYsCv0oEXWVzNAiNWIMoGuJRrkkiFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTAe/rcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAA9C4CEEB;
	Thu, 18 Sep 2025 12:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758200377;
	bh=8e4AH5cMTHHcqjoFLfIew9bWw0KbjnDI78BfLcnDKcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rTAe/rcDFjTREakgABUjVvyBYijhbRyEJSdTUmVSTIwfa5iQduY8OA1cTmYejU82p
	 JctZ/uh46Q7LTtohmg+7eXsm2gGRR05chg1ucYZa712O7HfR77Kvk3AIjAZ04ycW0t
	 gzTFqrcMEShu/u5M0jXgqbl6CYAek7rCLJByAyC1Y87Ppdaa0z18GJaE3vBRrO/E/y
	 1q61Y+T8bUpdKs0PmylpY7Dsnz3lWLQLosBPkncGhc2y9F6XvNAv4TD1C54otrz+Xj
	 hUrDnsFsiobys+y2A8h+WgqPEYMfoz7hnDiA5kcDa7ABMdBNHcVScfHtDkW5f/VenN
	 DScjvdH/tw+gg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 18 Sep 2025 21:59:14 +0900
Subject: [PATCH RFC 4/5] can: treewide: remove can_change_mtu()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-can-fix-mtu-v1-4-471edb942295@kernel.org>
References: <20250918-can-fix-mtu-v1-0-471edb942295@kernel.org>
In-Reply-To: <20250918-can-fix-mtu-v1-0-471edb942295@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=25252; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=8e4AH5cMTHHcqjoFLfIew9bWw0KbjnDI78BfLcnDKcE=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlnmAzOHj6XeeJe1cYEw9LDGrHzLuwO0an/42V26Nk9+
 f2lTqlRHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACbys5WR4YX59dwkY+n03jsV
 9svuXJ7NZWZjevPAw00MSq9NTwYyv2P4Z+Lt2zX78oKv0latoX+0H/DKFAecSXh+c06mUc2adQu
 fMAMA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

can_change_mtu() became obsolete by the previous patch. Now that
net_device->min_mtu and net_device->max_mtu are populated, all the
checks are already done by dev_validate_mtu() in net/core/dev.c.

Remove can_change_mtu() and remove the
net_device_ops->ndo_change_mtu() callback of all the physical
interfaces. Only keep the vcan_change_mtu() and vxcan_change_mtu()
because the virtual interfaces use their own different logic.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/at91_can.c                         |  1 -
 drivers/net/can/bxcan.c                            |  1 -
 drivers/net/can/c_can/c_can_main.c                 |  1 -
 drivers/net/can/can327.c                           |  1 -
 drivers/net/can/cc770/cc770.c                      |  1 -
 drivers/net/can/ctucanfd/ctucanfd_base.c           |  1 -
 drivers/net/can/dev/dev.c                          | 38 ----------------------
 drivers/net/can/esd/esd_402_pci-core.c             |  1 -
 drivers/net/can/flexcan/flexcan-core.c             |  1 -
 drivers/net/can/grcan.c                            |  1 -
 drivers/net/can/ifi_canfd/ifi_canfd.c              |  1 -
 drivers/net/can/janz-ican3.c                       |  1 -
 drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c |  1 -
 drivers/net/can/m_can/m_can.c                      |  1 -
 drivers/net/can/mscan/mscan.c                      |  1 -
 drivers/net/can/peak_canfd/peak_canfd.c            |  1 -
 drivers/net/can/rcar/rcar_can.c                    |  1 -
 drivers/net/can/rcar/rcar_canfd.c                  |  1 -
 drivers/net/can/rockchip/rockchip_canfd-core.c     |  1 -
 drivers/net/can/sja1000/sja1000.c                  |  1 -
 drivers/net/can/slcan/slcan-core.c                 |  1 -
 drivers/net/can/softing/softing_main.c             |  1 -
 drivers/net/can/spi/hi311x.c                       |  1 -
 drivers/net/can/spi/mcp251x.c                      |  1 -
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |  1 -
 drivers/net/can/sun4i_can.c                        |  1 -
 drivers/net/can/ti_hecc.c                          |  1 -
 drivers/net/can/usb/ems_usb.c                      |  1 -
 drivers/net/can/usb/esd_usb.c                      |  1 -
 drivers/net/can/usb/etas_es58x/es58x_core.c        |  1 -
 drivers/net/can/usb/f81604.c                       |  1 -
 drivers/net/can/usb/gs_usb.c                       |  1 -
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |  1 -
 drivers/net/can/usb/mcba_usb.c                     |  1 -
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |  1 -
 drivers/net/can/usb/ucan.c                         |  1 -
 drivers/net/can/usb/usb_8dev.c                     |  1 -
 drivers/net/can/xilinx_can.c                       |  1 -
 include/linux/can/dev.h                            |  1 -
 39 files changed, 76 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 191707d7e3dac2b816575b9232178a171559a494..c2a3a4eef5b281f6723e3fa7a40bba1a1d623a54 100644
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
index bfc60eb33dc3752722909c3cf6bffad29696f851..9c3af7049814385501bfd950c35c90ccfc42a2e8 100644
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
index cc371d0c9f3c769051ff1e0a8954d8c52dbcdbf6..3702cac7fbf0f08a509cf65f388c8707ed196fef 100644
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
index 24af639610309dd2a3372151782b8c9a32306306..b66fc16aedd2cc23f65ef3bf3d7f9e1a7c24d395 100644
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
index 30909f3aab576fb8eefb46b83f0aeca2fa7ffda1..8d5abd643c068e9f4d5a1eba8f3b0ce6a21c9de8 100644
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
index 8bd3f0fc385c3096e21aca20244e4ce04cf5708c..1e6b9e3dc2fea42801291cea75d55c268b0f3a41 100644
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
index 69c00720e9956cad986ea86fbba49285d76f51db..dcee4af436f4de837344fdf7965f7aa99f52df14 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -325,44 +325,6 @@ void can_set_default_mtu(struct net_device *dev)
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
index 5d6d2828cd0458bc87c9e5fbab1fd0c41a970cdd..05adecae63757b80b2b419e5831d0d7a671ae545 100644
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
index 06d5d35fc1b550d51dd92211340e9d71aa7f002c..f5d22c61503faa4fc20415aeaca22b6f25b8aa83 100644
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
index c5784d9779ef518ac253e66923ef542d52584373..3b1b09943436fab13024f88f7bf2cc67b1e11926 100644
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
index 2eeee65f606f37d8f1c1f1b8002daf8a12c93248..0f83335e4d075ed4c2a178efb4ea097f3c846d2a 100644
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
index bfa5cbe88017d42a61caa20d22e25084f1a9656a..1efdd1fd8caa424bf4d42ed3985f4b39e1c118da 100644
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
index 0880023611bebeef671ad1d9b9921d30b8193dd2..705f9bb74cd23c9c6a5f34fd7c0f7a529d0535d0 100644
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
index fe74dbd2c9663b7090678ab78318698d50ffb481..0e043aee045b40f11559f5a7728dad440dc3e85a 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2129,7 +2129,6 @@ static const struct net_device_ops m_can_netdev_ops = {
 	.ndo_open = m_can_open,
 	.ndo_stop = m_can_close,
 	.ndo_start_xmit = m_can_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static int m_can_get_coalesce(struct net_device *dev,
diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 8c2a7bc64d3d714d33445ebbff5fa41218d68b1f..39c7aa2a0b2f8e1d61745136ee694dd5e50724fd 100644
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
index 77292afaed227878fb9fb4b86199b28892bbc5ca..8cb642011235168d04028183dab67205630d2621 100644
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
index 87c134bcd48db559db45c901a12c40cef00dcde4..f157529a4934d6394abaed292e88816e21e8d439 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -628,7 +628,6 @@ static const struct net_device_ops rcar_can_netdev_ops = {
 	.ndo_open = rcar_can_open,
 	.ndo_stop = rcar_can_close,
 	.ndo_start_xmit = rcar_can_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops rcar_can_ethtool_ops = {
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index b3c8c592fb0e04edfef30989c3df659ad772a80f..bc0ddf31d21dd2b33726c34f7acb49e11c2a904a 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1810,7 +1810,6 @@ static const struct net_device_ops rcar_canfd_netdev_ops = {
 	.ndo_open = rcar_canfd_open,
 	.ndo_stop = rcar_canfd_close,
 	.ndo_start_xmit = rcar_canfd_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops rcar_canfd_ethtool_ops = {
diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 046f0a0ae4d4b06a076f9a72b9ad6603fa0ac31e..29de0c01e4edcf1a725a27dd47b5b61c0807b0be 100644
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
index 4d245857ef1cec0ae1ee82008b96912bbb1f2638..acfa49db3907ed2eeed748e0661c45a8e167c756 100644
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
index 58ff2ec1d9757e0ce55ce73b85e1884937a73d72..cd789e178d34bbbf3297f59823b90a0e1612ba37 100644
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
index 278ee8722770c252a2df20c7f3cd61a895a31b59..79bc64395ac4608fd1a1f9f4deac7b1f4b9a497b 100644
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
index 6441ff3b4198718e8e662daa3022f06a2405f322..09ae218315d73d49c2ec4280707911966fce1c31 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -812,7 +812,6 @@ static const struct net_device_ops hi3110_netdev_ops = {
 	.ndo_open = hi3110_open,
 	.ndo_stop = hi3110_stop,
 	.ndo_start_xmit = hi3110_hard_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops hi3110_ethtool_ops = {
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 313e1d241f0110ccee900c3f17e479ff1a4a1919..1075c9015f6b2c83c2cdc1c5c565879b50433020 100644
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
index 7450ea42c1ea51a908d1e016aacbf67c4e71c57f..9402530ba3d48beaa59ccefb929a4fd35290bd01 100644
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
index 53bfd873de9bdecaf6923049007f9efd71289dd3..6fcb301ef611d0c8bdb8720aaa77dc78950123d6 100644
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
index e6d6661a908ab12eb4c7ec61c162848c18ef20f4..1d3dbf28b1057c50effc43c488e472bbc71de9ca 100644
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
index 5355bac4dccbe0e31ba115909b0537a9b92c2fa6..de8e212a1366b4367e9abb6ae702769e399b45bc 100644
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
index 27a3818885c2ca7451e9ce959b06e6e15e70a4a6..a9418341dbf61630bd90dbf76689170f775bad9a 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -991,7 +991,6 @@ static const struct net_device_ops esd_usb_netdev_ops = {
 	.ndo_open = esd_usb_open,
 	.ndo_stop = esd_usb_close,
 	.ndo_start_xmit = esd_usb_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops esd_usb_ethtool_ops = {
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index adc91873c083f968ff7571a5b0db5747988482c5..47d9e03f304495db90e7d69bd135aaaa4a8d01ed 100644
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
index e0cfa1460b0b83110d5ce7ffe07bac442ce8a682..efe61ece79ea251056fd44d208de145e24eedf16 100644
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
index c9482d6e947b0c7b033dc4f0c35f5b111e1bfd92..aea35aa15a7cd667df04e047b42cc949d8b27fbb 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1105,7 +1105,6 @@ static const struct net_device_ops gs_usb_netdev_ops = {
 	.ndo_open = gs_can_open,
 	.ndo_stop = gs_can_close,
 	.ndo_start_xmit = gs_can_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 	.ndo_eth_ioctl = gs_can_eth_ioctl,
 };
 
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 90e77fa0ff4a58b25eec33e0f9ffcb54dab97438..89e22b66f91929ac1785b18289cb7669cfa2aaef 100644
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
index 1f9b915094e64de875adff35026e9cd3beb0410d..41c0a1c399bf36104fbf8991b537acdb01e7e950 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -761,7 +761,6 @@ static const struct net_device_ops mcba_netdev_ops = {
 	.ndo_open = mcba_usb_open,
 	.ndo_stop = mcba_usb_close,
 	.ndo_start_xmit = mcba_usb_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops mcba_ethtool_ops = {
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 117637b9b995b9e7aa8f313574cf9e0a9929e93d..7903de379de36f862209f2ee9a19e26e0026c336 100644
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
index 07406daf7c88ed64edbe501a87b259b77053be93..de61d9da99e359c3d3b0293302a72c96aabc1bb2 100644
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
index 8a5596ce4e46312e6080a424e0107e0c22595267..7449328f7cd7279bc259eb746131586f70bb1c0f 100644
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
index a25a3ca62c12e3a0a5674581c3787595e543d843..43d7f22820b88efcdba2ed5f0918c724b3bdd973 100644
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
index 3354f70ed2c684d7d482549560d4cb5838cbebd5..48a6851b047fd339a87e96cadda8d5e39b2e8c73 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -167,7 +167,6 @@ struct can_priv *safe_candev_priv(struct net_device *dev);
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
 void can_set_default_mtu(struct net_device *dev);
-int can_change_mtu(struct net_device *dev, int new_mtu);
 int __must_check can_set_static_ctrlmode(struct net_device *dev,
 					 u32 static_mode);
 int can_eth_ioctl_hwts(struct net_device *netdev, struct ifreq *ifr, int cmd);

-- 
2.49.1


