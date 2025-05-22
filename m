Return-Path: <linux-can+bounces-3660-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A89A5AC0785
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 10:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F671BC5805
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 08:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8324526A0F4;
	Thu, 22 May 2025 08:41:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0DE28934B
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903311; cv=none; b=BvzHeJZ2FgPHhmgzq1h3LGOfZdbDJbJBmKVz2H9WcPdxflLceslnl3ijxYsE49/JS2+fyTV2u3IS0hMO3tCKpHgBXL+zkFvdD3QoeXiOtqkkPsxTSFL5JqS50Q7/tqG1lWKkbaWSb72IVI61iFaQw5asnj7GZFa19PeKdalyUJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903311; c=relaxed/simple;
	bh=jryZtgffgqtl7/t5SjFFQYT/j+YsEAsbsNGmxBJnKpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATYN9s50ychIPb/Fr+qgwJG3vyUt+OhjPTtPr7DnNqwgskVjYz3IIGENQcN4Xzhkl7fgc4XUDKFYFefn2HJbZ25GfeYFeyUMVCuuhwKlrredU34bXcADKydUBYC+9PRgJkVslFJOxt6Srf1g/Wnj+Kl8VlobKOlOBIN3lTcoaBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Um-0006Ht-7V
	for linux-can@vger.kernel.org; Thu, 22 May 2025 10:41:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Uj-000hqc-0G
	for linux-can@vger.kernel.org;
	Thu, 22 May 2025 10:41:41 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id BF6CA41736C
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:40 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id EB531417333;
	Thu, 22 May 2025 08:41:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 50282a2d;
	Thu, 22 May 2025 08:41:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 20/22] can: dev: add struct data_bittiming_params to group FD parameters
Date: Thu, 22 May 2025 10:36:48 +0200
Message-ID: <20250522084128.501049-21-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522084128.501049-1-mkl@pengutronix.de>
References: <20250522084128.501049-1-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

This is a preparation patch for the introduction of CAN XL.

CAN FD and CAN XL uses similar bittiming parameters. Add one level of
nesting for all the CAN FD parameters. Typically:

  priv->can.data_bittiming;

becomes:

  priv->can.fd.data_bittiming;

This way, the CAN XL equivalent (to be introduced later) would be:

  priv->can.xl.data_bittiming;

Add the new struct data_bittiming_params which contains all the data
bittiming parameters, including the TDC and the callback functions.

This done, update all the CAN FD drivers to make use of the new
layout.

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250501171213.2161572-2-mailhol.vincent@wanadoo.fr
[mkl: fix rcar_canfd]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c      |  8 +-
 drivers/net/can/dev/dev.c                     | 12 +--
 drivers/net/can/dev/netlink.c                 | 74 +++++++++----------
 drivers/net/can/flexcan/flexcan-core.c        |  4 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c         | 10 +--
 drivers/net/can/kvaser_pciefd.c               |  6 +-
 drivers/net/can/m_can/m_can.c                 |  8 +-
 drivers/net/can/peak_canfd/peak_canfd.c       |  6 +-
 drivers/net/can/rcar/rcar_canfd.c             |  4 +-
 .../net/can/rockchip/rockchip_canfd-core.c    |  4 +-
 .../can/rockchip/rockchip_canfd-timestamp.c   |  2 +-
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 10 +--
 drivers/net/can/usb/esd_usb.c                 |  6 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c   |  4 +-
 drivers/net/can/usb/etas_es58x/es58x_fd.c     |  6 +-
 drivers/net/can/usb/gs_usb.c                  |  8 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  2 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  6 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  |  6 +-
 drivers/net/can/xilinx_can.c                  | 16 ++--
 include/linux/can/dev.h                       | 28 ++++---
 21 files changed, 117 insertions(+), 113 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index f65c1a1e05cc..bf6398772960 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -275,7 +275,7 @@ static int ctucan_set_bittiming(struct net_device *ndev)
 static int ctucan_set_data_bittiming(struct net_device *ndev)
 {
 	struct ctucan_priv *priv = netdev_priv(ndev);
-	struct can_bittiming *dbt = &priv->can.data_bittiming;
+	struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 
 	/* Note that dbt may be modified here */
 	return ctucan_set_btr(ndev, dbt, false);
@@ -290,7 +290,7 @@ static int ctucan_set_data_bittiming(struct net_device *ndev)
 static int ctucan_set_secondary_sample_point(struct net_device *ndev)
 {
 	struct ctucan_priv *priv = netdev_priv(ndev);
-	struct can_bittiming *dbt = &priv->can.data_bittiming;
+	struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	int ssp_offset = 0;
 	u32 ssp_cfg = 0; /* No SSP by default */
 
@@ -1358,12 +1358,12 @@ int ctucan_probe_common(struct device *dev, void __iomem *addr, int irq, unsigne
 	priv->ntxbufs = ntxbufs;
 	priv->dev = dev;
 	priv->can.bittiming_const = &ctu_can_fd_bit_timing_max;
-	priv->can.data_bittiming_const = &ctu_can_fd_bit_timing_data_max;
+	priv->can.fd.data_bittiming_const = &ctu_can_fd_bit_timing_data_max;
 	priv->can.do_set_mode = ctucan_do_set_mode;
 
 	/* Needed for timing adjustment to be performed as soon as possible */
 	priv->can.do_set_bittiming = ctucan_set_bittiming;
-	priv->can.do_set_data_bittiming = ctucan_set_data_bittiming;
+	priv->can.fd.do_set_data_bittiming = ctucan_set_data_bittiming;
 
 	priv->can.do_get_berr_counter = ctucan_get_berr_counter;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 5ec3170b896a..ea8c807af4d8 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -404,8 +404,8 @@ int open_candev(struct net_device *dev)
 
 	/* For CAN FD the data bitrate has to be >= the arbitration bitrate */
 	if ((priv->ctrlmode & CAN_CTRLMODE_FD) &&
-	    (!priv->data_bittiming.bitrate ||
-	     priv->data_bittiming.bitrate < priv->bittiming.bitrate)) {
+	    (!priv->fd.data_bittiming.bitrate ||
+	     priv->fd.data_bittiming.bitrate < priv->bittiming.bitrate)) {
 		netdev_err(dev, "incorrect/missing data bit-timing\n");
 		return -EINVAL;
 	}
@@ -543,16 +543,16 @@ int register_candev(struct net_device *dev)
 	if (!priv->bitrate_const != !priv->bitrate_const_cnt)
 		return -EINVAL;
 
-	if (!priv->data_bitrate_const != !priv->data_bitrate_const_cnt)
+	if (!priv->fd.data_bitrate_const != !priv->fd.data_bitrate_const_cnt)
 		return -EINVAL;
 
 	/* We only support either fixed bit rates or bit timing const. */
-	if ((priv->bitrate_const || priv->data_bitrate_const) &&
-	    (priv->bittiming_const || priv->data_bittiming_const))
+	if ((priv->bitrate_const || priv->fd.data_bitrate_const) &&
+	    (priv->bittiming_const || priv->fd.data_bittiming_const))
 		return -EINVAL;
 
 	if (!can_bittiming_const_valid(priv->bittiming_const) ||
-	    !can_bittiming_const_valid(priv->data_bittiming_const))
+	    !can_bittiming_const_valid(priv->fd.data_bittiming_const))
 		return -EINVAL;
 
 	if (!priv->termination_const) {
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index f1db9b7ffd4d..a36842ace084 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -141,7 +141,7 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 {
 	struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
 	struct can_tdc tdc = { 0 };
-	const struct can_tdc_const *tdc_const = priv->tdc_const;
+	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
 	int err;
 
 	if (!tdc_const || !can_tdc_is_enabled(priv))
@@ -179,7 +179,7 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 		tdc.tdcf = tdcf;
 	}
 
-	priv->tdc = tdc;
+	priv->fd.tdc = tdc;
 
 	return 0;
 }
@@ -228,10 +228,10 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			dev->mtu = CANFD_MTU;
 		} else {
 			dev->mtu = CAN_MTU;
-			memset(&priv->data_bittiming, 0,
-			       sizeof(priv->data_bittiming));
+			memset(&priv->fd.data_bittiming, 0,
+			       sizeof(priv->fd.data_bittiming));
 			priv->ctrlmode &= ~CAN_CTRLMODE_TDC_MASK;
-			memset(&priv->tdc, 0, sizeof(priv->tdc));
+			memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 		}
 
 		tdc_mask = cm->mask & CAN_CTRLMODE_TDC_MASK;
@@ -312,16 +312,16 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		 * directly via do_set_bitrate(). Bail out if neither
 		 * is given.
 		 */
-		if (!priv->data_bittiming_const && !priv->do_set_data_bittiming &&
-		    !priv->data_bitrate_const)
+		if (!priv->fd.data_bittiming_const && !priv->fd.do_set_data_bittiming &&
+		    !priv->fd.data_bitrate_const)
 			return -EOPNOTSUPP;
 
 		memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
 		       sizeof(dbt));
 		err = can_get_bittiming(dev, &dbt,
-					priv->data_bittiming_const,
-					priv->data_bitrate_const,
-					priv->data_bitrate_const_cnt,
+					priv->fd.data_bittiming_const,
+					priv->fd.data_bitrate_const,
+					priv->fd.data_bitrate_const_cnt,
 					extack);
 		if (err)
 			return err;
@@ -333,7 +333,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			return -EINVAL;
 		}
 
-		memset(&priv->tdc, 0, sizeof(priv->tdc));
+		memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 		if (data[IFLA_CAN_TDC]) {
 			/* TDC parameters are provided: use them */
 			err = can_tdc_changelink(priv, data[IFLA_CAN_TDC],
@@ -346,17 +346,17 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			/* Neither of TDC parameters nor TDC flags are
 			 * provided: do calculation
 			 */
-			can_calc_tdco(&priv->tdc, priv->tdc_const, &dbt,
+			can_calc_tdco(&priv->fd.tdc, priv->fd.tdc_const, &dbt,
 				      &priv->ctrlmode, priv->ctrlmode_supported);
 		} /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
 		   * turned off. TDC is disabled: do nothing
 		   */
 
-		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
+		memcpy(&priv->fd.data_bittiming, &dbt, sizeof(dbt));
 
-		if (priv->do_set_data_bittiming) {
+		if (priv->fd.do_set_data_bittiming) {
 			/* Finally, set the bit-timing registers */
-			err = priv->do_set_data_bittiming(dev);
+			err = priv->fd.do_set_data_bittiming(dev);
 			if (err)
 				return err;
 		}
@@ -394,7 +394,7 @@ static size_t can_tdc_get_size(const struct net_device *dev)
 	struct can_priv *priv = netdev_priv(dev);
 	size_t size;
 
-	if (!priv->tdc_const)
+	if (!priv->fd.tdc_const)
 		return 0;
 
 	size = nla_total_size(0);			/* nest IFLA_CAN_TDC */
@@ -404,17 +404,17 @@ static size_t can_tdc_get_size(const struct net_device *dev)
 	}
 	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO_MIN */
 	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO_MAX */
-	if (priv->tdc_const->tdcf_max) {
+	if (priv->fd.tdc_const->tdcf_max) {
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF_MIN */
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF_MAX */
 	}
 
 	if (can_tdc_is_enabled(priv)) {
 		if (priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL ||
-		    priv->do_get_auto_tdcv)
+		    priv->fd.do_get_auto_tdcv)
 			size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV */
 		size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO */
-		if (priv->tdc_const->tdcf_max)
+		if (priv->fd.tdc_const->tdcf_max)
 			size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF */
 	}
 
@@ -442,9 +442,9 @@ static size_t can_get_size(const struct net_device *dev)
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
 	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
 		size += nla_total_size(sizeof(struct can_berr_counter));
-	if (priv->data_bittiming.bitrate)			/* IFLA_CAN_DATA_BITTIMING */
+	if (priv->fd.data_bittiming.bitrate)			/* IFLA_CAN_DATA_BITTIMING */
 		size += nla_total_size(sizeof(struct can_bittiming));
-	if (priv->data_bittiming_const)				/* IFLA_CAN_DATA_BITTIMING_CONST */
+	if (priv->fd.data_bittiming_const)			/* IFLA_CAN_DATA_BITTIMING_CONST */
 		size += nla_total_size(sizeof(struct can_bittiming_const));
 	if (priv->termination_const) {
 		size += nla_total_size(sizeof(priv->termination));		/* IFLA_CAN_TERMINATION */
@@ -454,9 +454,9 @@ static size_t can_get_size(const struct net_device *dev)
 	if (priv->bitrate_const)				/* IFLA_CAN_BITRATE_CONST */
 		size += nla_total_size(sizeof(*priv->bitrate_const) *
 				       priv->bitrate_const_cnt);
-	if (priv->data_bitrate_const)				/* IFLA_CAN_DATA_BITRATE_CONST */
-		size += nla_total_size(sizeof(*priv->data_bitrate_const) *
-				       priv->data_bitrate_const_cnt);
+	if (priv->fd.data_bitrate_const)			/* IFLA_CAN_DATA_BITRATE_CONST */
+		size += nla_total_size(sizeof(*priv->fd.data_bitrate_const) *
+				       priv->fd.data_bitrate_const_cnt);
 	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
 	size += can_tdc_get_size(dev);				/* IFLA_CAN_TDC */
 	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
@@ -468,8 +468,8 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct nlattr *nest;
 	struct can_priv *priv = netdev_priv(dev);
-	struct can_tdc *tdc = &priv->tdc;
-	const struct can_tdc_const *tdc_const = priv->tdc_const;
+	struct can_tdc *tdc = &priv->fd.tdc;
+	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
 
 	if (!tdc_const)
 		return 0;
@@ -497,8 +497,8 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		if (priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL) {
 			tdcv = tdc->tdcv;
 			err = 0;
-		} else if (priv->do_get_auto_tdcv) {
-			err = priv->do_get_auto_tdcv(dev, &tdcv);
+		} else if (priv->fd.do_get_auto_tdcv) {
+			err = priv->fd.do_get_auto_tdcv(dev, &tdcv);
 		}
 		if (!err && nla_put_u32(skb, IFLA_CAN_TDC_TDCV, tdcv))
 			goto err_cancel;
@@ -564,14 +564,14 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	     !priv->do_get_berr_counter(dev, &bec) &&
 	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
 
-	    (priv->data_bittiming.bitrate &&
+	    (priv->fd.data_bittiming.bitrate &&
 	     nla_put(skb, IFLA_CAN_DATA_BITTIMING,
-		     sizeof(priv->data_bittiming), &priv->data_bittiming)) ||
+		     sizeof(priv->fd.data_bittiming), &priv->fd.data_bittiming)) ||
 
-	    (priv->data_bittiming_const &&
+	    (priv->fd.data_bittiming_const &&
 	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
-		     sizeof(*priv->data_bittiming_const),
-		     priv->data_bittiming_const)) ||
+		     sizeof(*priv->fd.data_bittiming_const),
+		     priv->fd.data_bittiming_const)) ||
 
 	    (priv->termination_const &&
 	     (nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination) ||
@@ -586,11 +586,11 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		     priv->bitrate_const_cnt,
 		     priv->bitrate_const)) ||
 
-	    (priv->data_bitrate_const &&
+	    (priv->fd.data_bitrate_const &&
 	     nla_put(skb, IFLA_CAN_DATA_BITRATE_CONST,
-		     sizeof(*priv->data_bitrate_const) *
-		     priv->data_bitrate_const_cnt,
-		     priv->data_bitrate_const)) ||
+		     sizeof(*priv->fd.data_bitrate_const) *
+		     priv->fd.data_bitrate_const_cnt,
+		     priv->fd.data_bitrate_const)) ||
 
 	    (nla_put(skb, IFLA_CAN_BITRATE_MAX,
 		     sizeof(priv->bitrate_max),
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 6d80c341b26f..06d5d35fc1b5 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1226,7 +1226,7 @@ static void flexcan_set_bittiming_cbt(const struct net_device *dev)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct can_bittiming *bt = &priv->can.bittiming;
-	struct can_bittiming *dbt = &priv->can.data_bittiming;
+	struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg_cbt, reg_fdctrl;
 
@@ -2239,7 +2239,7 @@ static int flexcan_probe(struct platform_device *pdev)
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_FD_NON_ISO;
 		priv->can.bittiming_const = &flexcan_fd_bittiming_const;
-		priv->can.data_bittiming_const =
+		priv->can.fd.data_bittiming_const =
 			&flexcan_fd_data_bittiming_const;
 	} else {
 		priv->can.bittiming_const = &flexcan_bittiming_const;
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index c86b57d47085..2eeee65f606f 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -669,7 +669,7 @@ static void ifi_canfd_set_bittiming(struct net_device *ndev)
 {
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
 	const struct can_bittiming *bt = &priv->can.bittiming;
-	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	u16 brp, sjw, tseg1, tseg2, tdc;
 
 	/* Configure bit timing */
@@ -1000,10 +1000,10 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
 
 	priv->can.clock.freq = readl(addr + IFI_CANFD_CANCLOCK);
 
-	priv->can.bittiming_const	= &ifi_canfd_bittiming_const;
-	priv->can.data_bittiming_const	= &ifi_canfd_bittiming_const;
-	priv->can.do_set_mode		= ifi_canfd_set_mode;
-	priv->can.do_get_berr_counter	= ifi_canfd_get_berr_counter;
+	priv->can.bittiming_const = &ifi_canfd_bittiming_const;
+	priv->can.fd.data_bittiming_const = &ifi_canfd_bittiming_const;
+	priv->can.do_set_mode = ifi_canfd_set_mode;
+	priv->can.do_get_berr_counter = ifi_canfd_get_berr_counter;
 
 	/* IFI CANFD can do both Bosch FD and ISO FD */
 	priv->can.ctrlmode = CAN_CTRLMODE_FD;
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index cf0d51805272..4022eb2e1a7d 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -856,7 +856,7 @@ static int kvaser_pciefd_set_bittiming(struct kvaser_pciefd_can *can, bool data)
 	struct can_bittiming *bt;
 
 	if (data)
-		bt = &can->can.data_bittiming;
+		bt = &can->can.fd.data_bittiming;
 	else
 		bt = &can->can.bittiming;
 
@@ -991,9 +991,9 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		spin_lock_init(&can->lock);
 
 		can->can.bittiming_const = &kvaser_pciefd_bittiming_const;
-		can->can.data_bittiming_const = &kvaser_pciefd_bittiming_const;
+		can->can.fd.data_bittiming_const = &kvaser_pciefd_bittiming_const;
 		can->can.do_set_bittiming = kvaser_pciefd_set_nominal_bittiming;
-		can->can.do_set_data_bittiming = kvaser_pciefd_set_data_bittiming;
+		can->can.fd.do_set_data_bittiming = kvaser_pciefd_set_data_bittiming;
 		can->can.do_set_mode = kvaser_pciefd_set_mode;
 		can->can.do_get_berr_counter = kvaser_pciefd_get_berr_counter;
 		can->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index c2c116ce1087..6c656bfdb323 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1372,7 +1372,7 @@ static int m_can_set_bittiming(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	const struct can_bittiming *bt = &cdev->can.bittiming;
-	const struct can_bittiming *dbt = &cdev->can.data_bittiming;
+	const struct can_bittiming *dbt = &cdev->can.fd.data_bittiming;
 	u16 brp, sjw, tseg1, tseg2;
 	u32 reg_btp;
 
@@ -1738,7 +1738,7 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		if (err)
 			return err;
 		cdev->can.bittiming_const = &m_can_bittiming_const_30X;
-		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_30X;
+		cdev->can.fd.data_bittiming_const = &m_can_data_bittiming_const_30X;
 		break;
 	case 31:
 		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
@@ -1746,13 +1746,13 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		if (err)
 			return err;
 		cdev->can.bittiming_const = &m_can_bittiming_const_31X;
-		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_31X;
+		cdev->can.fd.data_bittiming_const = &m_can_data_bittiming_const_31X;
 		break;
 	case 32:
 	case 33:
 		/* Support both MCAN version v3.2.x and v3.3.0 */
 		cdev->can.bittiming_const = &m_can_bittiming_const_31X;
-		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_31X;
+		cdev->can.fd.data_bittiming_const = &m_can_data_bittiming_const_31X;
 
 		niso = m_can_niso_supported(cdev);
 		if (niso < 0)
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 28f3fd805273..77292afaed22 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -624,7 +624,7 @@ static int peak_canfd_set_data_bittiming(struct net_device *ndev)
 {
 	struct peak_canfd_priv *priv = netdev_priv(ndev);
 
-	return pucan_set_timing_fast(priv, &priv->can.data_bittiming);
+	return pucan_set_timing_fast(priv, &priv->can.fd.data_bittiming);
 }
 
 static int peak_canfd_close(struct net_device *ndev)
@@ -813,12 +813,12 @@ struct net_device *alloc_peak_canfd_dev(int sizeof_priv, int index,
 	/* complete now socket-can initialization side */
 	priv->can.state = CAN_STATE_STOPPED;
 	priv->can.bittiming_const = &peak_canfd_nominal_const;
-	priv->can.data_bittiming_const = &peak_canfd_data_const;
+	priv->can.fd.data_bittiming_const = &peak_canfd_data_const;
 
 	priv->can.do_set_mode = peak_canfd_set_mode;
 	priv->can.do_get_berr_counter = peak_canfd_get_berr_counter;
 	priv->can.do_set_bittiming = peak_canfd_set_bittiming;
-	priv->can.do_set_data_bittiming = peak_canfd_set_data_bittiming;
+	priv->can.fd.do_set_data_bittiming = peak_canfd_set_data_bittiming;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 				       CAN_CTRLMODE_LISTENONLY |
 				       CAN_CTRLMODE_3_SAMPLES |
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 27d503ac87dc..7f10213738e5 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1441,7 +1441,7 @@ static void rcar_canfd_set_bittiming(struct net_device *dev)
 	struct rcar_canfd_channel *priv = netdev_priv(dev);
 	struct rcar_canfd_global *gpriv = priv->gpriv;
 	const struct can_bittiming *bt = &priv->can.bittiming;
-	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	u16 brp, sjw, tseg1, tseg2;
 	u32 cfg;
 	u32 ch = priv->channel;
@@ -1923,7 +1923,7 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 
 	if (gpriv->fdmode) {
 		priv->can.bittiming_const = gpriv->info->nom_bittiming;
-		priv->can.data_bittiming_const = gpriv->info->data_bittiming;
+		priv->can.fd.data_bittiming_const = gpriv->info->data_bittiming;
 
 		/* Controller starts in CAN FD only mode */
 		err = can_set_static_ctrlmode(ndev, CAN_CTRLMODE_FD);
diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index c3fb3176ce42..046f0a0ae4d4 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -118,7 +118,7 @@ static void rkcanfd_chip_set_work_mode(const struct rkcanfd_priv *priv)
 
 static int rkcanfd_set_bittiming(struct rkcanfd_priv *priv)
 {
-	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	u32 reg_nbt, reg_dbt, reg_tdc;
 	u32 tdco;
@@ -899,7 +899,7 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 	priv->can.clock.freq = clk_get_rate(priv->clks[0].clk);
 	priv->can.bittiming_const = &rkcanfd_bittiming_const;
-	priv->can.data_bittiming_const = &rkcanfd_data_bittiming_const;
+	priv->can.fd.data_bittiming_const = &rkcanfd_data_bittiming_const;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 		CAN_CTRLMODE_BERR_REPORTING;
 	priv->can.do_set_mode = rkcanfd_set_mode;
diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
index 43d4b5721812..fa85a75be65a 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
@@ -39,7 +39,7 @@ static void rkcanfd_timestamp_work(struct work_struct *work)
 
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv)
 {
-	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	struct cyclecounter *cc = &priv->cc;
 	u32 bitrate, div, reg, rate;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index c30b04f8fc0d..7450ea42c1ea 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -527,7 +527,7 @@ static int mcp251xfd_chip_timestamp_init(const struct mcp251xfd_priv *priv)
 static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 {
 	const struct can_bittiming *bt = &priv->can.bittiming;
-	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	u32 tdcmod, val = 0;
 	int err;
 
@@ -600,8 +600,8 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 		tdcmod = MCP251XFD_REG_TDC_TDCMOD_DISABLED;
 
 	val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK, tdcmod) |
-		FIELD_PREP(MCP251XFD_REG_TDC_TDCV_MASK, priv->can.tdc.tdcv) |
-		FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, priv->can.tdc.tdco);
+	      FIELD_PREP(MCP251XFD_REG_TDC_TDCV_MASK, priv->can.fd.tdc.tdcv) |
+	      FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, priv->can.fd.tdc.tdco);
 
 	return regmap_write(priv->map_reg, MCP251XFD_REG_TDC, val);
 }
@@ -2104,8 +2104,8 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->can.do_set_mode = mcp251xfd_set_mode;
 	priv->can.do_get_berr_counter = mcp251xfd_get_berr_counter;
 	priv->can.bittiming_const = &mcp251xfd_bittiming_const;
-	priv->can.data_bittiming_const = &mcp251xfd_data_bittiming_const;
-	priv->can.tdc_const = &mcp251xfd_tdc_const;
+	priv->can.fd.data_bittiming_const = &mcp251xfd_data_bittiming_const;
+	priv->can.fd.tdc_const = &mcp251xfd_tdc_const;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING |
 		CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO |
diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 03ad10b01867..27a3818885c2 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -1098,7 +1098,7 @@ static int esd_usb_3_set_bittiming(struct net_device *netdev)
 	const struct can_bittiming_const *data_btc = &esd_usb_3_data_bittiming_const;
 	struct esd_usb_net_priv *priv = netdev_priv(netdev);
 	struct can_bittiming *nom_bt = &priv->can.bittiming;
-	struct can_bittiming *data_bt = &priv->can.data_bittiming;
+	struct can_bittiming *data_bt = &priv->can.fd.data_bittiming;
 	struct esd_usb_3_set_baudrate_msg_x *baud_x;
 	union esd_usb_msg *msg;
 	u16 flags = 0;
@@ -1218,9 +1218,9 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 		priv->can.clock.freq = ESD_USB_3_CAN_CLOCK;
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 		priv->can.bittiming_const = &esd_usb_3_nom_bittiming_const;
-		priv->can.data_bittiming_const = &esd_usb_3_data_bittiming_const;
+		priv->can.fd.data_bittiming_const = &esd_usb_3_data_bittiming_const;
 		priv->can.do_set_bittiming = esd_usb_3_set_bittiming;
-		priv->can.do_set_data_bittiming = esd_usb_3_set_bittiming;
+		priv->can.fd.do_set_data_bittiming = esd_usb_3_set_bittiming;
 		break;
 
 	case ESD_USB_CANUSBM_PRODUCT_ID:
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 71f24dc0a927..db1acf6d504c 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -2059,8 +2059,8 @@ static int es58x_init_priv(struct es58x_device *es58x_dev,
 
 	can->bittiming_const = param->bittiming_const;
 	if (param->ctrlmode_supported & CAN_CTRLMODE_FD) {
-		can->data_bittiming_const = param->data_bittiming_const;
-		can->tdc_const = param->tdc_const;
+		can->fd.data_bittiming_const = param->data_bittiming_const;
+		can->fd.tdc_const = param->tdc_const;
 	}
 	can->bitrate_max = param->bitrate_max;
 	can->clock = param->clock;
diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
index 84ffa1839bac..d924b053677b 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
@@ -427,12 +427,12 @@ static int es58x_fd_enable_channel(struct es58x_priv *priv)
 
 	if (tx_conf_msg.canfd_enabled) {
 		es58x_fd_convert_bittiming(&tx_conf_msg.data_bittiming,
-					   &priv->can.data_bittiming);
+					   &priv->can.fd.data_bittiming);
 
 		if (can_tdc_is_enabled(&priv->can)) {
 			tx_conf_msg.tdc_enabled = 1;
-			tx_conf_msg.tdco = cpu_to_le16(priv->can.tdc.tdco);
-			tx_conf_msg.tdcf = cpu_to_le16(priv->can.tdc.tdcf);
+			tx_conf_msg.tdco = cpu_to_le16(priv->can.fd.tdc.tdco);
+			tx_conf_msg.tdcf = cpu_to_le16(priv->can.fd.tdc.tdcf);
 		}
 
 		conf_len = ES58X_FD_CANFD_CONF_LEN;
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3ccac6781b98..bb6335278e46 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -728,7 +728,7 @@ static int gs_usb_set_bittiming(struct net_device *netdev)
 static int gs_usb_set_data_bittiming(struct net_device *netdev)
 {
 	struct gs_can *dev = netdev_priv(netdev);
-	struct can_bittiming *bt = &dev->can.data_bittiming;
+	struct can_bittiming *bt = &dev->can.fd.data_bittiming;
 	struct gs_device_bittiming dbt = {
 		.prop_seg = cpu_to_le32(bt->prop_seg),
 		.phase_seg1 = cpu_to_le32(bt->phase_seg1),
@@ -1300,8 +1300,8 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		/* The data bit timing will be overwritten, if
 		 * GS_CAN_FEATURE_BT_CONST_EXT is set.
 		 */
-		dev->can.data_bittiming_const = &dev->bt_const;
-		dev->can.do_set_data_bittiming = gs_usb_set_data_bittiming;
+		dev->can.fd.data_bittiming_const = &dev->bt_const;
+		dev->can.fd.do_set_data_bittiming = gs_usb_set_data_bittiming;
 	}
 
 	if (feature & GS_CAN_FEATURE_TERMINATION) {
@@ -1381,7 +1381,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->data_bt_const.brp_max = le32_to_cpu(bt_const_extended.dbrp_max);
 		dev->data_bt_const.brp_inc = le32_to_cpu(bt_const_extended.dbrp_inc);
 
-		dev->can.data_bittiming_const = &dev->data_bt_const;
+		dev->can.fd.data_bittiming_const = &dev->data_bt_const;
 	}
 
 	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 078496d9b7ba..f6c77eca9f43 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -137,7 +137,7 @@ struct kvaser_usb_net_priv {
  * @dev_set_mode:		used for can.do_set_mode
  * @dev_set_bittiming:		used for can.do_set_bittiming
  * @dev_get_busparams:		readback arbitration busparams
- * @dev_set_data_bittiming:	used for can.do_set_data_bittiming
+ * @dev_set_data_bittiming:	used for can.fd.do_set_data_bittiming
  * @dev_get_data_busparams:	readback data busparams
  * @dev_get_berr_counter:	used for can.do_get_berr_counter
  *
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index dcb0bcbe0565..daf42080f942 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -592,7 +592,7 @@ static int kvaser_usb_set_data_bittiming(struct net_device *netdev)
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
 	struct kvaser_usb *dev = priv->dev;
 	const struct kvaser_usb_dev_ops *ops = dev->driver_info->ops;
-	struct can_bittiming *dbt = &priv->can.data_bittiming;
+	struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	struct kvaser_usb_busparams busparams;
 	int tseg1 = dbt->prop_seg + dbt->phase_seg1;
 	int tseg2 = dbt->phase_seg2;
@@ -842,8 +842,8 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	priv->can.ctrlmode_supported |= dev->card_data.ctrlmode_supported;
 
 	if (priv->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
-		priv->can.data_bittiming_const = dev->cfg->data_bittiming_const;
-		priv->can.do_set_data_bittiming = kvaser_usb_set_data_bittiming;
+		priv->can.fd.data_bittiming_const = dev->cfg->data_bittiming_const;
+		priv->can.fd.do_set_data_bittiming = kvaser_usb_set_data_bittiming;
 	}
 
 	netdev->flags |= IFF_ECHO;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 59f7cd8ceb39..117637b9b995 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -770,7 +770,7 @@ static int peak_usb_set_data_bittiming(struct net_device *netdev)
 	const struct peak_usb_adapter *pa = dev->adapter;
 
 	if (pa->dev_set_data_bittiming) {
-		struct can_bittiming *bt = &dev->can.data_bittiming;
+		struct can_bittiming *bt = &dev->can.fd.data_bittiming;
 		int err = pa->dev_set_data_bittiming(dev, bt);
 
 		if (err)
@@ -954,8 +954,8 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	dev->can.clock = peak_usb_adapter->clock;
 	dev->can.bittiming_const = peak_usb_adapter->bittiming_const;
 	dev->can.do_set_bittiming = peak_usb_set_bittiming;
-	dev->can.data_bittiming_const = peak_usb_adapter->data_bittiming_const;
-	dev->can.do_set_data_bittiming = peak_usb_set_data_bittiming;
+	dev->can.fd.data_bittiming_const = peak_usb_adapter->data_bittiming_const;
+	dev->can.fd.do_set_data_bittiming = peak_usb_set_data_bittiming;
 	dev->can.do_set_mode = peak_usb_set_mode;
 	dev->can.do_get_berr_counter = peak_usb_adapter->do_get_berr_counter;
 	dev->can.ctrlmode_supported = peak_usb_adapter->ctrlmode_supported;
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 436c0e4b0344..3f2e378199ab 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -481,7 +481,7 @@ static int xcan_set_bittiming(struct net_device *ndev)
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
 	struct can_bittiming *bt = &priv->can.bittiming;
-	struct can_bittiming *dbt = &priv->can.data_bittiming;
+	struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	u32 btr0, btr1;
 	u32 is_config_mode;
 
@@ -517,10 +517,10 @@ static int xcan_set_bittiming(struct net_device *ndev)
 		btr0 = dbt->brp - 1;
 		if (can_tdc_is_enabled(&priv->can)) {
 			if (priv->devtype.cantype == XAXI_CANFD)
-				btr0 |= FIELD_PREP(XCAN_BRPR_TDCO_MASK, priv->can.tdc.tdco) |
+				btr0 |= FIELD_PREP(XCAN_BRPR_TDCO_MASK, priv->can.fd.tdc.tdco) |
 					XCAN_BRPR_TDC_ENABLE;
 			else
-				btr0 |= FIELD_PREP(XCAN_2_BRPR_TDCO_MASK, priv->can.tdc.tdco) |
+				btr0 |= FIELD_PREP(XCAN_2_BRPR_TDCO_MASK, priv->can.fd.tdc.tdco) |
 					XCAN_BRPR_TDC_ENABLE;
 		}
 
@@ -1967,22 +1967,22 @@ static int xcan_probe(struct platform_device *pdev)
 		goto err_free;
 
 	if (devtype->cantype == XAXI_CANFD) {
-		priv->can.data_bittiming_const =
+		priv->can.fd.data_bittiming_const =
 			&xcan_data_bittiming_const_canfd;
-		priv->can.tdc_const = &xcan_tdc_const_canfd;
+		priv->can.fd.tdc_const = &xcan_tdc_const_canfd;
 	}
 
 	if (devtype->cantype == XAXI_CANFD_2_0) {
-		priv->can.data_bittiming_const =
+		priv->can.fd.data_bittiming_const =
 			&xcan_data_bittiming_const_canfd2;
-		priv->can.tdc_const = &xcan_tdc_const_canfd2;
+		priv->can.fd.tdc_const = &xcan_tdc_const_canfd2;
 	}
 
 	if (devtype->cantype == XAXI_CANFD ||
 	    devtype->cantype == XAXI_CANFD_2_0) {
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
 						CAN_CTRLMODE_TDC_AUTO;
-		priv->can.do_get_auto_tdcv = xcan_get_auto_tdcv;
+		priv->can.fd.do_get_auto_tdcv = xcan_get_auto_tdcv;
 	}
 
 	priv->reg_base = addr;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 23492213ea35..492d23bec7be 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -38,6 +38,17 @@ enum can_termination_gpio {
 	CAN_TERMINATION_GPIO_MAX,
 };
 
+struct data_bittiming_params {
+	const struct can_bittiming_const *data_bittiming_const;
+	struct can_bittiming data_bittiming;
+	const struct can_tdc_const *tdc_const;
+	struct can_tdc tdc;
+	const u32 *data_bitrate_const;
+	unsigned int data_bitrate_const_cnt;
+	int (*do_set_data_bittiming)(struct net_device *dev);
+	int (*do_get_auto_tdcv)(const struct net_device *dev, u32 *tdcv);
+};
+
 /*
  * CAN common private data
  */
@@ -45,16 +56,11 @@ struct can_priv {
 	struct net_device *dev;
 	struct can_device_stats can_stats;
 
-	const struct can_bittiming_const *bittiming_const,
-		*data_bittiming_const;
-	struct can_bittiming bittiming, data_bittiming;
-	const struct can_tdc_const *tdc_const;
-	struct can_tdc tdc;
-
+	const struct can_bittiming_const *bittiming_const;
+	struct can_bittiming bittiming;
+	struct data_bittiming_params fd;
 	unsigned int bitrate_const_cnt;
 	const u32 *bitrate_const;
-	const u32 *data_bitrate_const;
-	unsigned int data_bitrate_const_cnt;
 	u32 bitrate_max;
 	struct can_clock clock;
 
@@ -77,14 +83,12 @@ struct can_priv {
 	struct delayed_work restart_work;
 
 	int (*do_set_bittiming)(struct net_device *dev);
-	int (*do_set_data_bittiming)(struct net_device *dev);
 	int (*do_set_mode)(struct net_device *dev, enum can_mode mode);
 	int (*do_set_termination)(struct net_device *dev, u16 term);
 	int (*do_get_state)(const struct net_device *dev,
 			    enum can_state *state);
 	int (*do_get_berr_counter)(const struct net_device *dev,
 				   struct can_berr_counter *bec);
-	int (*do_get_auto_tdcv)(const struct net_device *dev, u32 *tdcv);
 };
 
 static inline bool can_tdc_is_enabled(const struct can_priv *priv)
@@ -114,11 +118,11 @@ static inline bool can_tdc_is_enabled(const struct can_priv *priv)
  */
 static inline s32 can_get_relative_tdco(const struct can_priv *priv)
 {
-	const struct can_bittiming *dbt = &priv->data_bittiming;
+	const struct can_bittiming *dbt = &priv->fd.data_bittiming;
 	s32 sample_point_in_tc = (CAN_SYNC_SEG + dbt->prop_seg +
 				  dbt->phase_seg1) * dbt->brp;
 
-	return (s32)priv->tdc.tdco - sample_point_in_tc;
+	return (s32)priv->fd.tdc.tdco - sample_point_in_tc;
 }
 
 /* helper to define static CAN controller features at device creation time */
-- 
2.47.2



