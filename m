Return-Path: <linux-can+bounces-5099-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A47FEBB5D89
	for <lists+linux-can@lfdr.de>; Fri, 03 Oct 2025 05:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 817F74E146E
	for <lists+linux-can@lfdr.de>; Fri,  3 Oct 2025 03:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6463F42AA9;
	Fri,  3 Oct 2025 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru8rgkZ/"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B214A8B;
	Fri,  3 Oct 2025 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759461456; cv=none; b=nbQOzPTOdywQz2bnHxikdeUHOSRwAe5srN0bsRhbcoX54azOpycVq6CP/FeXRCM9LHdXyL0aOW2s8BPge1JYH5n5ZVxC2bOri/LVbbF6xtLXFVHUmz7sXPEY1wwaaL5a4C+Oi2TNiWWY7N+nuR37B78C/ySLL0jqMkk1DDcPNME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759461456; c=relaxed/simple;
	bh=aQcsjYTZESdxGoQkRfLj0JfM4I3vXx+kRPO/aGy6V1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tcwY1D3P4nX42gGKK5MLkjmjxPPJ+3m+ZVDcpGtTEJ/yCPgj0PqYM9uMt/qyulP4MxBcoab0bwCEVWNO/h58dSpeNd2OscL4B/3ZKt4ex0XCfvh99jjUlhAHBb3zsrKZds3EYRPgXCyInPlt7Ax1+INeqmuZRllS5hvvPJXUmJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ru8rgkZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39890C4CEF4;
	Fri,  3 Oct 2025 03:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759461455;
	bh=aQcsjYTZESdxGoQkRfLj0JfM4I3vXx+kRPO/aGy6V1I=;
	h=From:Date:Subject:To:Cc:From;
	b=ru8rgkZ/nB7O0qxsH2WkfPmOY5pha2rpij/AbFEsRZxXwFWu9CK5/N+Cz1nIBQFIZ
	 gkKFrTMSuYtfctfsJy6mNcLqflsqncNJkoSPZmez/KxbrIQM1hU2sqFGXGY2lSquxf
	 M/ziRh3rwGh2Hcczg1lOu9k4uhB7OfPiv11/WkMeSpc0fuyCGRAEnomxO21BE9T4Tt
	 cKMe8qMBd8OK9SCERNb75Tv2x07pYlkOlZQI29X+79S1dCoigWvWHVXO9e2saIE46u
	 1GlqU+1u2r9ozQUWZbqTHSuOsa+mq6GQqbHsyTrLhvAufh842SVe6ORZenuXH5tFhY
	 FTP5ty8k/0q4g==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Fri, 03 Oct 2025 12:16:38 +0900
Subject: [PATCH] can: treewide: remove can_change_mtu()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-remove-can_change_mtu-v1-1-337f8bc21181@kernel.org>
X-B4-Tracking: v=1; b=H4sIABVA32gC/yWMQQ7CIBREr0L+WuJvq5texTQN0Kn+BaBAG5Omd
 5fI8k3mvYMykiDTqA5K2CVLDBW6iyL3MuEJLUtl6rm/d8yDTvBxh3YmzO0w+7JpMNzNsV0BS9V
 9J6zy/XcfU+OEz1bzpY1kTa6V6L2UUQWUqzcSaDrPH2Uom1mTAAAA
X-Change-ID: 20251003-remove-can_change_mtu-e0ec4c0bfeeb
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Max Staudt <max@enpas.org>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
 Ondrej Ille <ondrej.ille@gmail.com>, 
 =?utf-8?q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>, socketcan@esd.eu, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, kernel@pengutronix.de, 
 Heiko Stuebner <heiko@sntech.de>, Manivannan Sadhasivam <mani@kernel.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Frank Jungclaus <frank.jungclaus@esd.eu>, 
 "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>, 
 Yasushi SHOJI <yashi@spacecubics.com>, Ming Yu <tmyu0@nuvoton.com>, 
 Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, linux-can@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=25384; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=aQcsjYTZESdxGoQkRfLj0JfM4I3vXx+kRPO/aGy6V1I=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBn3Hdw1DUXkpknMic5gOCwd/zbrOm+afNB9tplPxXXuL
 Xv3nndhRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgInMeMLIcCrC6eXRrEuW7JNj
 MtIOnGguvv3g3TLrmgZRCyt+rq/n+xn+aab+v7Ti9EIOkeUdtY4P5/XUNhiHHJoW+8B+daj0guA
 V7AA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

can_change_mtu() became obsolete by commit 23049938605b ("can:
populate the minimum and maximum MTU values"). Now that
net_device->min_mtu and net_device->max_mtu are populated, all the
checks are already done by dev_validate_mtu() in net/core/dev.c.

Remove the net_device_ops->ndo_change_mtu() callback of all the
physical interfaces, then remove can_change_mtu(). Only keep the
vcan_change_mtu() and vxcan_change_mtu() because the virtual
interfaces use their own different MTU logic.

The only functional change this patch introduces is that now the user
will be able to change the MTU even if the interface is up. This does
not matter for Classical CAN and CAN FD because their MTU range is
composed of only one value, respectively CAN_MTU and CANFD_MTU. For
the upcoming CAN XL, the MTU will be configurable within the
CANXL_MIN_MTU to CANXL_MAX_MTU range at any time, even if the
interface is up. This is consistent with the other net protocols and
does not contradict ISO 11898-1:2024 as having a modifiable MTU is a
kernel extension.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
This patch used to be part of [1]. But it had to be removed from that
series to avoid some merge conflict because some pending changes from
other maintainers' trees still depended on can_change_mtu().

Now that all those pending changes reached upstream, this patch can be
merged without any merge conflict. If possible, I would like this to
go through net/main. Even if this is not a bug fix, keeping the now
dead-code can_change_mtu() is a bit ugly and this removal was planned
anyway for the v6.18 merge windows, it was artificially delayed to
prevent the previously mentioned merge conflicts.

Changelog:

patch from [1] -> v1

  - rebase on latest net/main tree.
  - also remove the can_change_mtu() from the nct6694_canfd driver.
  - add further details to the patch description.

[1] can: rework the CAN MTU logic
Link: https://lore.kernel.org/linux-can/20250918-can-fix-mtu-v1-0-471edb942295@kernel.org/
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
 drivers/net/can/usb/nct6694_canfd.c                |  1 -
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |  1 -
 drivers/net/can/usb/ucan.c                         |  1 -
 drivers/net/can/usb/usb_8dev.c                     |  1 -
 drivers/net/can/xilinx_can.c                       |  1 -
 include/linux/can/dev.h                            |  1 -
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
index e1d725979685..a9e63a75085f 100644
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
index c9482d6e947b..aea35aa15a7c 100644
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

---
base-commit: 07fdad3a93756b872da7b53647715c48d0f4a2d0
change-id: 20251003-remove-can_change_mtu-e0ec4c0bfeeb

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


