Return-Path: <linux-can+bounces-5362-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BA5C51591
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 10:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2443B925D
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 09:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FAA2FFDF9;
	Wed, 12 Nov 2025 09:17:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E02FF15F
	for <linux-can@vger.kernel.org>; Wed, 12 Nov 2025 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939078; cv=none; b=XmSXN+HVeIptMNSOBNvnp8KQHvW+BmIUMP5tpMgnrFcHQ4GeFqU1M9H+1lWDzL9/qsolyMrNLUQljAAoH5zOqi95ULGpfhYrHtMR2k2CJTJvYAvOeSzEu43Y0GnU94QO82Zcafx4NgrAaJ9u/53XZJHAbQ0JwuVMR/8qXuMNqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939078; c=relaxed/simple;
	bh=AW7kgSmkrxzbFDoWM68dq4FFV6JmO+GBvqwkcwA7z3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNQXMIaXqyPTcefV2ZMRaZJl6H+6lGSHtWNoAZ+G56R6seTCTjz9gKfhwDdJ29sJeDCsGIC4od6N3YjmQm+W3ITmuztrwOe88mB5IHnOgrlAxPbVkoh4ItK+vCadBM9S4BflOL5WNX4VzAsoWcWgsHHWoobZhikeDyiGUV9+bCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6yw-0007V5-Fw; Wed, 12 Nov 2025 10:17:38 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6yv-0003cL-2a;
	Wed, 12 Nov 2025 10:17:37 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8099B49D99A;
	Wed, 12 Nov 2025 09:17:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/11] can: peak_usb: convert to use ndo_hwtstamp callbacks
Date: Wed, 12 Nov 2025 10:13:43 +0100
Message-ID: <20251112091734.74315-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112091734.74315-1-mkl@pengutronix.de>
References: <20251112091734.74315-1-mkl@pengutronix.de>
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

From: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Convert driver to use ndo_hwtstamp_set()/ndo_hwtstamp_get() callbacks.
ndo_eth_ioctl handler does nothing after conversion - remove it.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20251029231620.1135640-4-vadim.fedorenko@linux.dev
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 35 +++++++++-----------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 94b1d7f15d27..cf48bb26d46d 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -784,36 +784,33 @@ static int peak_usb_set_data_bittiming(struct net_device *netdev)
 	return 0;
 }
 
-static int peak_eth_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+static int peak_hwtstamp_get(struct net_device *netdev,
+			     struct kernel_hwtstamp_config *config)
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
+static int peak_hwtstamp_set(struct net_device *netdev,
+			     struct kernel_hwtstamp_config *config,
+			     struct netlink_ext_ack *extack)
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
 
 static const struct net_device_ops peak_usb_netdev_ops = {
 	.ndo_open = peak_usb_ndo_open,
 	.ndo_stop = peak_usb_ndo_stop,
-	.ndo_eth_ioctl = peak_eth_ioctl,
 	.ndo_start_xmit = peak_usb_ndo_start_xmit,
+	.ndo_hwtstamp_get = peak_hwtstamp_get,
+	.ndo_hwtstamp_set = peak_hwtstamp_set,
 };
 
 /* CAN-USB devices generally handle 32-bit CAN channel IDs.
-- 
2.51.0


