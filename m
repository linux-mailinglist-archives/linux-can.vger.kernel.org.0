Return-Path: <linux-can+bounces-5282-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D3CC1DAB3
	for <lists+linux-can@lfdr.de>; Thu, 30 Oct 2025 00:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7955A188B9B3
	for <lists+linux-can@lfdr.de>; Wed, 29 Oct 2025 23:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0512FFDE1;
	Wed, 29 Oct 2025 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CQHkNhmf"
X-Original-To: linux-can@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8B2F656B
	for <linux-can@vger.kernel.org>; Wed, 29 Oct 2025 23:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779817; cv=none; b=eiHE4joEHfEMBaZW8NTtQc8kKghSBoMhbmR1xboXNqO9MnatSHGOZoaSAqkjpDLXooYpB/2zy1OCXb05WnWZIYxzwCs7oJoBA2EVA3CSJmvQhRtR2fqLt/fNDGbY5eEomOlK28vpdE96UfPwXvJ5ETy+WhK5CgaAl9YMhiXvWnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779817; c=relaxed/simple;
	bh=3RysrlZ1SKtKesPJ0BYB6VFgysWkDgyUr5O5M9eV070=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqdlugFJmoFCIKJg/qmRP7j0lassdd3h+MrHlGpnnWCC0DEqqgTXimcqnILmGn48y17Gt7wwI1IQhdt94vbbKfpqnGAJSN1Cd6v0XRtsgd+TVIcMWnvWyEPOKYdk9Q7+kA/l5foy5IaWX7QffNvREIanGfkzG+GyiC538eT0iao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CQHkNhmf; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761779812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pCSvkLNxe028Qnx/oKBoKG7ksvtsHAkMKQeOzg2HqE=;
	b=CQHkNhmfg7W1WgBFpV0C9POkfEZG5W3J3KlcHSTf7+iXONRfmNGGDGWNNyshDGwt7ytOJX
	2XwA/6DG8q7Wh1lgAPCFv9pg5ED1bmInCtdpQjCyIGp3jfzCQhh7H+E+ZSOIv/VeMTKiBV
	fMv+m4v+/VYlWV19K95o1MEwXltIejM=
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
Subject: [PATCH net-next 2/3] can: peak_canfd: convert to use ndo_hwtstamp callbacks
Date: Wed, 29 Oct 2025 23:16:19 +0000
Message-ID: <20251029231620.1135640-3-vadim.fedorenko@linux.dev>
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

Convert driver to use ndo_hwtstamp_set()/ndo_hwtstamp_get() callbacks.
ndo_eth_ioctl handler does nothing after conversion - remove it.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/can/peak_canfd/peak_canfd.c | 35 +++++++++++--------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index a53c9d347b7b..06cb2629f66a 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -743,36 +743,33 @@ static netdev_tx_t peak_canfd_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static int peak_eth_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+static int peak_eth_hwtstamp_get(struct net_device *netdev,
+				 struct kernel_hwtstamp_config *config)
 {
-	struct hwtstamp_config hwts_cfg = { 0 };
+	config->tx_type = HWTSTAMP_TX_OFF;
+	config->rx_filter = HWTSTAMP_FILTER_ALL;
 
-	switch (cmd) {
-	case SIOCSHWTSTAMP: /* set */
-		if (copy_from_user(&hwts_cfg, ifr->ifr_data, sizeof(hwts_cfg)))
-			return -EFAULT;
-		if (hwts_cfg.tx_type == HWTSTAMP_TX_OFF &&
-		    hwts_cfg.rx_filter == HWTSTAMP_FILTER_ALL)
-			return 0;
-		return -ERANGE;
+	return 0;
+}
 
-	case SIOCGHWTSTAMP: /* get */
-		hwts_cfg.tx_type = HWTSTAMP_TX_OFF;
-		hwts_cfg.rx_filter = HWTSTAMP_FILTER_ALL;
-		if (copy_to_user(ifr->ifr_data, &hwts_cfg, sizeof(hwts_cfg)))
-			return -EFAULT;
+static int peak_eth_hwtstamp_set(struct net_device *netdev,
+				 struct kernel_hwtstamp_config *config,
+				 struct netlink_ext_ack *extack)
+{
+	if (config->tx_type == HWTSTAMP_TX_OFF &&
+	    config->rx_filter == HWTSTAMP_FILTER_ALL)
 		return 0;
 
-	default:
-		return -EOPNOTSUPP;
-	}
+	NL_SET_ERR_MSG_MOD(extack, "Only RX HWTSTAMP_FILTER_ALL is supported");
+	return -ERANGE;
 }
 
 static const struct net_device_ops peak_canfd_netdev_ops = {
 	.ndo_open = peak_canfd_open,
 	.ndo_stop = peak_canfd_close,
-	.ndo_eth_ioctl = peak_eth_ioctl,
 	.ndo_start_xmit = peak_canfd_start_xmit,
+	.ndo_hwtstamp_get = peak_eth_hwtstamp_get,
+	.ndo_hwtstamp_set = peak_eth_hwtstamp_set,
 };
 
 static int peak_get_ts_info(struct net_device *dev,
-- 
2.47.3


