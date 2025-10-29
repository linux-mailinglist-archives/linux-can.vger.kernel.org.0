Return-Path: <linux-can+bounces-5281-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D64C1DAAD
	for <lists+linux-can@lfdr.de>; Thu, 30 Oct 2025 00:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BE818842D2
	for <lists+linux-can@lfdr.de>; Wed, 29 Oct 2025 23:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071912FD69F;
	Wed, 29 Oct 2025 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BoV2FLbx"
X-Original-To: linux-can@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02589125A0
	for <linux-can@vger.kernel.org>; Wed, 29 Oct 2025 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779816; cv=none; b=kK+mwHvrdND8t/vYGEd9vqjs4dvGDanShW4pdHYiy9oUVOxjx9SeS1LBVLpUx4yR24pfFGK0S7fk8rVZkWLOz/UK3yfwFznos70bk71raM/v2NF8cJvGNURWHO5e/3PttXvveCgO6kv5nscpHm/3kfhdqDH8r8TEp9vSF9f2Moc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779816; c=relaxed/simple;
	bh=BCuy3Y0ig/2XRZiF9UCm7EXFqFzseYJc9hhw+IvSkKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msoYQAokvDy0IbbDV3AQHd2aPH/Llzp8UMFGdy5aMZZva8LnAR+O+vMx1t77db79zzuE7cCM4VLwY/ZkqLP6afcA/2qj5mKkaAKNF1eJ9sl+gPoCz7QO5GzbBqakuAulgT+kiLOGTTbJiqebADRk7iTDl6eDQRnIfrX1Tl88EKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BoV2FLbx; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761779811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RntAECq9f2+2hKQo8exNRA//2+v/1h+lfkUBpRC4rVg=;
	b=BoV2FLbx93znJXFV0RC5Z81JUOtUimxmNaVPHQFxGJLh5wurCvsJZEY5Qlkg9t1+kHkflm
	yxO1YfUccBev20y45ItGKYqgKap/nTvzX3+EDtP0YHLW/HLvVGOIeVpUX47qM6N2LNbWag
	8mvKYcX/4JEPDFf30QLEfEzbNFnErMY=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	=?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
	socketcan@esd.eu,
	Manivannan Sadhasivam <mani@kernel.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Jimmy Assarsson <extja@kvaser.com>,
	Axel Forsman <axfo@kvaser.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 1/3] can: convert generic HW timestamp ioctl to ndo_hwtstamp callbacks
Date: Wed, 29 Oct 2025 23:16:18 +0000
Message-ID: <20251029231620.1135640-2-vadim.fedorenko@linux.dev>
In-Reply-To: <20251029231620.1135640-1-vadim.fedorenko@linux.dev>
References: <20251029231620.1135640-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Can has generic implementation of ndo_eth_ioctl which implements only HW
timestamping commands. Implement generic ndo_hwtstamp callbacks and use
it in drivers instead of generic ioctl interface.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/can/dev/dev.c                     | 45 +++++++++----------
 drivers/net/can/esd/esd_402_pci-core.c        |  3 +-
 .../can/kvaser_pciefd/kvaser_pciefd_core.c    |  3 +-
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    |  3 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c   |  3 +-
 drivers/net/can/usb/gs_usb.c                  | 20 +++++++--
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  3 +-
 include/linux/can/dev.h                       |  6 ++-
 8 files changed, 54 insertions(+), 32 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 0cc3d008adb3..80e1ab18de87 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -379,34 +379,33 @@ int can_set_static_ctrlmode(struct net_device *dev, u32 static_mode)
 }
 EXPORT_SYMBOL_GPL(can_set_static_ctrlmode);
 
-/* generic implementation of netdev_ops::ndo_eth_ioctl for CAN devices
+/* generic implementation of netdev_ops::ndo_hwtstamp_get for CAN devices
  * supporting hardware timestamps
  */
-int can_eth_ioctl_hwts(struct net_device *netdev, struct ifreq *ifr, int cmd)
+int can_hwtstamp_get(struct net_device *netdev,
+		     struct kernel_hwtstamp_config *cfg)
 {
-	struct hwtstamp_config hwts_cfg = { 0 };
-
-	switch (cmd) {
-	case SIOCSHWTSTAMP: /* set */
-		if (copy_from_user(&hwts_cfg, ifr->ifr_data, sizeof(hwts_cfg)))
-			return -EFAULT;
-		if (hwts_cfg.tx_type == HWTSTAMP_TX_ON &&
-		    hwts_cfg.rx_filter == HWTSTAMP_FILTER_ALL)
-			return 0;
-		return -ERANGE;
-
-	case SIOCGHWTSTAMP: /* get */
-		hwts_cfg.tx_type = HWTSTAMP_TX_ON;
-		hwts_cfg.rx_filter = HWTSTAMP_FILTER_ALL;
-		if (copy_to_user(ifr->ifr_data, &hwts_cfg, sizeof(hwts_cfg)))
-			return -EFAULT;
-		return 0;
+	cfg->tx_type = HWTSTAMP_TX_ON;
+	cfg->rx_filter = HWTSTAMP_FILTER_ALL;
 
-	default:
-		return -EOPNOTSUPP;
-	}
+	return 0;
+}
+EXPORT_SYMBOL(can_hwtstamp_get);
+
+/* generic implementation of netdev_ops::ndo_hwtstamp_set for CAN devices
+ * supporting hardware timestamps
+ */
+int can_hwtstamp_set(struct net_device *netdev,
+		     struct kernel_hwtstamp_config *cfg,
+		     struct netlink_ext_ack *extack)
+{
+	if (cfg->tx_type == HWTSTAMP_TX_ON &&
+	    cfg->rx_filter == HWTSTAMP_FILTER_ALL)
+		return 0;
+	NL_SET_ERR_MSG_MOD(extack, "Only TX on and RX all packets filter supported");
+	return -ERANGE;
 }
-EXPORT_SYMBOL(can_eth_ioctl_hwts);
+EXPORT_SYMBOL(can_hwtstamp_set);
 
 /* generic implementation of ethtool_ops::get_ts_info for CAN devices
  * supporting hardware timestamps
diff --git a/drivers/net/can/esd/esd_402_pci-core.c b/drivers/net/can/esd/esd_402_pci-core.c
index 05adecae6375..c826f00c551b 100644
--- a/drivers/net/can/esd/esd_402_pci-core.c
+++ b/drivers/net/can/esd/esd_402_pci-core.c
@@ -86,7 +86,8 @@ static const struct net_device_ops pci402_acc_netdev_ops = {
 	.ndo_open = acc_open,
 	.ndo_stop = acc_close,
 	.ndo_start_xmit = acc_start_xmit,
-	.ndo_eth_ioctl = can_eth_ioctl_hwts,
+	.ndo_hwtstamp_get = can_hwtstamp_get,
+	.ndo_hwtstamp_set = can_hwtstamp_set,
 };
 
 static const struct ethtool_ops pci402_acc_ethtool_ops = {
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
index 705f9bb74cd2..d8c9bfb20230 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
@@ -902,8 +902,9 @@ static void kvaser_pciefd_bec_poll_timer(struct timer_list *data)
 static const struct net_device_ops kvaser_pciefd_netdev_ops = {
 	.ndo_open = kvaser_pciefd_open,
 	.ndo_stop = kvaser_pciefd_stop,
-	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 	.ndo_start_xmit = kvaser_pciefd_start_xmit,
+	.ndo_hwtstamp_get = can_hwtstamp_get,
+	.ndo_hwtstamp_set = can_hwtstamp_set,
 };
 
 static int kvaser_pciefd_set_phys_id(struct net_device *netdev,
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 9402530ba3d4..c0f9d9fed02e 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1714,7 +1714,8 @@ static const struct net_device_ops mcp251xfd_netdev_ops = {
 	.ndo_open = mcp251xfd_open,
 	.ndo_stop = mcp251xfd_stop,
 	.ndo_start_xmit	= mcp251xfd_start_xmit,
-	.ndo_eth_ioctl = can_eth_ioctl_hwts,
+	.ndo_hwtstamp_get = can_hwtstamp_get,
+	.ndo_hwtstamp_set = can_hwtstamp_set,
 };
 
 static void
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 47d9e03f3044..f799233c2b72 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -1976,7 +1976,8 @@ static const struct net_device_ops es58x_netdev_ops = {
 	.ndo_open = es58x_open,
 	.ndo_stop = es58x_stop,
 	.ndo_start_xmit = es58x_start_xmit,
-	.ndo_eth_ioctl = can_eth_ioctl_hwts,
+	.ndo_hwtstamp_get = can_hwtstamp_get,
+	.ndo_hwtstamp_set = can_hwtstamp_set,
 };
 
 static const struct ethtool_ops es58x_ethtool_ops = {
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 30608901a974..1321eb5e89ae 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1087,12 +1087,25 @@ static int gs_can_close(struct net_device *netdev)
 	return 0;
 }
 
-static int gs_can_eth_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+static int gs_can_hwtstamp_get(struct net_device *netdev,
+			       struct kernel_hwtstamp_config *cfg)
 {
 	const struct gs_can *dev = netdev_priv(netdev);
 
 	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-		return can_eth_ioctl_hwts(netdev, ifr, cmd);
+		return can_hwtstamp_get(netdev, cfg);
+
+	return -EOPNOTSUPP;
+}
+
+static int gs_can_hwtstamp_set(struct net_device *netdev,
+			       struct kernel_hwtstamp_config *cfg,
+			       struct netlink_ext_ack *extack)
+{
+	const struct gs_can *dev = netdev_priv(netdev);
+
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		return can_hwtstamp_set(netdev, cfg, extack);
 
 	return -EOPNOTSUPP;
 }
@@ -1101,7 +1114,8 @@ static const struct net_device_ops gs_usb_netdev_ops = {
 	.ndo_open = gs_can_open,
 	.ndo_stop = gs_can_close,
 	.ndo_start_xmit = gs_can_start_xmit,
-	.ndo_eth_ioctl = gs_can_eth_ioctl,
+	.ndo_hwtstamp_get = gs_can_hwtstamp_get,
+	.ndo_hwtstamp_set = gs_can_hwtstamp_set,
 };
 
 static int gs_usb_set_identify(struct net_device *netdev, bool do_identify)
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 89e22b66f919..62701ec34272 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -784,8 +784,9 @@ static int kvaser_usb_set_phys_id(struct net_device *netdev,
 static const struct net_device_ops kvaser_usb_netdev_ops = {
 	.ndo_open = kvaser_usb_open,
 	.ndo_stop = kvaser_usb_close,
-	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 	.ndo_start_xmit = kvaser_usb_start_xmit,
+	.ndo_hwtstamp_get = can_hwtstamp_get,
+	.ndo_hwtstamp_set = can_hwtstamp_set,
 };
 
 static const struct ethtool_ops kvaser_usb_ethtool_ops = {
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 0fe8f80f223e..bd7410b5d8a6 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -129,7 +129,11 @@ void close_candev(struct net_device *dev);
 void can_set_default_mtu(struct net_device *dev);
 int __must_check can_set_static_ctrlmode(struct net_device *dev,
 					 u32 static_mode);
-int can_eth_ioctl_hwts(struct net_device *netdev, struct ifreq *ifr, int cmd);
+int can_hwtstamp_get(struct net_device *netdev,
+		     struct kernel_hwtstamp_config *cfg);
+int can_hwtstamp_set(struct net_device *netdev,
+		     struct kernel_hwtstamp_config *cfg,
+		     struct netlink_ext_ack *extack);
 int can_ethtool_op_get_ts_info_hwts(struct net_device *dev,
 				    struct kernel_ethtool_ts_info *info);
 
-- 
2.47.3


