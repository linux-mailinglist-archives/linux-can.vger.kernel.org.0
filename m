Return-Path: <linux-can+bounces-1997-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E87889C5DEC
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 17:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2FE0B38323
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 16:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798FD20B20B;
	Tue, 12 Nov 2024 16:51:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD9E2076B4;
	Tue, 12 Nov 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430299; cv=none; b=nD0DqulF5Ri6o96wJk4MlZ4HSxuybukghnAogtuKDnOrXgIq2uFsczEJP5YdE7vhhldUaJK0MmIgNRpgbUXP2C2+UpBHQxem68s9GFF/MN5Oof6ooZgtuiewOjGS6FUBjXRlT4ql1V14gyLbkIwxhXsaIxd4ITxsr0rBsFACXuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430299; c=relaxed/simple;
	bh=W0ZtfqcrNgJyM5/yTtjbujeplYa3lvhlI8BJwGCuddc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmSOu/d5pI9Kgf9s7wGrLdv7ryAN/EWA02E7q/8TgaQzGr5UKo3/d3hgRGew5zZOMxdTADGqzJLBXAFmMWpUiMeMHp6/61uZq8ZhgVFg8+xjEpVXEtj5Mm10smtHYjj7icnXVj+Gp2GcMi1D8jF7gAMbEF4SFTyQXkOFtZQPZLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso4234522b3a.0;
        Tue, 12 Nov 2024 08:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430294; x=1732035094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SAeZ0UwocyOR3UKNM6ZfDlKb6Gg0lHsUROiOhDjNN8=;
        b=OLzk+Di1IJJKTxMoJlGZM1RASdkf1EAPZjCn5JKOazTpr5KjPb86UUSLXPTkktcwpR
         N+d8bI5tH9DQDTSnrUfMRQJERsEyuzVUEebmBhLh1fhWxIAqIy+aZy5MhiSO4OKywKL9
         adsV1eynk2CtUXqzFSkx5wCUxC0gA50l4V7N608i3S0kSuGspx5sZGeuJm10NGu8efc4
         /U9OdnblZqVqlBQ7xI9WS8rS0oFwQ2o2MDJbpbB5aPxeOIj2QgPzfmg1+ldXQM3Rqzla
         iyIR3FuEuwbxf8WTDhPr8B/FnVd4UYpVFd3FLMSK4cvlBnuj45LCsDi3JAa9hjWTpKrC
         KfRw==
X-Forwarded-Encrypted: i=1; AJvYcCUs3ynl9+0kzuvUYE/1/2cgYNTW1ctsFOGPrsyQPJb5kDgP5m3jvyBhYli5tiMnAXzz8KNIGuWiSxRAQnU=@vger.kernel.org, AJvYcCVrmzwmQWQn6PPr5QjSJs5dWZk2cPjUXpZrpufEyfLjkqW1eoAjbNUKv6cgbemxZbQufh4fzy3A@vger.kernel.org
X-Gm-Message-State: AOJu0YyColDeXBP5rEcrqcyGbkUwNSd6Y2gHD0J4FD4WBulwKprQVtpn
	vOUh+ED+iN4LkPjTAr9fuocH0rPdbG/Ja+hVjJBG4r5MjcCeMYdo7Vjrvw==
X-Google-Smtp-Source: AGHT+IFCBgqHBU37wCx4VEPlvRUDvrNadlP0MK2bWdAih8TXxqTbM074+esCXrnQUH1g2w2VG5t7MQ==
X-Received: by 2002:a05:6a20:12ce:b0:1d9:15b2:83e with SMTP id adf61e73a8af0-1dc23322093mr27166447637.7.1731430293749;
        Tue, 12 Nov 2024 08:51:33 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407860aa5sm11271260b3a.32.2024.11.12.08.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:51:33 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 1/5] can: dev: add struct data_bittiming_params to group FD parameters
Date: Wed, 13 Nov 2024 01:50:16 +0900
Message-ID: <20241112165118.586613-8-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112165118.586613-7-mailhol.vincent@wanadoo.fr>
References: <20241112165118.586613-7-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=36783; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=W0ZtfqcrNgJyM5/yTtjbujeplYa3lvhlI8BJwGCuddc=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnG7W33g/PsH/6VmnnA+tyJZR1TEiSjM++8nsP9zHLj2 xuHmtZ6dJSyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZhInQUjQ0PEpTr5q7fr7r33 y/7xwOiIoLTT+koP+eOt9rNXVSfVRTAyNF/ILdrxv3XrIq6L369tNg5IYN/p4+uklc0RX8YrdjG QDQA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

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

This done, all the drivers are updated to make use of the new layout.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
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
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    |  4 +-
 drivers/net/can/usb/esd_usb.c                 |  6 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c   |  4 +-
 drivers/net/can/usb/etas_es58x/es58x_fd.c     |  6 +-
 drivers/net/can/usb/gs_usb.c                  |  8 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  2 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  6 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  |  6 +-
 drivers/net/can/xilinx_can.c                  | 16 ++--
 include/linux/can/dev.h                       | 28 ++++---
 21 files changed, 114 insertions(+), 110 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 64c349fd4600..18bd7e4d23a5 100644
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
 
@@ -1356,12 +1356,12 @@ int ctucan_probe_common(struct device *dev, void __iomem *addr, int irq, unsigne
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
index 6792c14fd7eb..6aeed870815f 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -406,8 +406,8 @@ int open_candev(struct net_device *dev)
 
 	/* For CAN FD the data bitrate has to be >= the arbitration bitrate */
 	if ((priv->ctrlmode & CAN_CTRLMODE_FD) &&
-	    (!priv->data_bittiming.bitrate ||
-	     priv->data_bittiming.bitrate < priv->bittiming.bitrate)) {
+	    (!priv->fd.data_bittiming.bitrate ||
+	     priv->fd.data_bittiming.bitrate < priv->bittiming.bitrate)) {
 		netdev_err(dev, "incorrect/missing data bit-timing\n");
 		return -EINVAL;
 	}
@@ -545,16 +545,16 @@ int register_candev(struct net_device *dev)
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
index 01aacdcda260..7455a7c5a383 100644
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
index ac1a860986df..cba899a46514 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1211,7 +1211,7 @@ static void flexcan_set_bittiming_cbt(const struct net_device *dev)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct can_bittiming *bt = &priv->can.bittiming;
-	struct can_bittiming *dbt = &priv->can.data_bittiming;
+	struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg_cbt, reg_fdctrl;
 
@@ -2191,7 +2191,7 @@ static int flexcan_probe(struct platform_device *pdev)
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_FD_NON_ISO;
 		priv->can.bittiming_const = &flexcan_fd_bittiming_const;
-		priv->can.data_bittiming_const =
+		priv->can.fd.data_bittiming_const =
 			&flexcan_fd_data_bittiming_const;
 	} else {
 		priv->can.bittiming_const = &flexcan_bittiming_const;
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index d32b10900d2f..c3069b948cb2 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -647,7 +647,7 @@ static void ifi_canfd_set_bittiming(struct net_device *ndev)
 {
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
 	const struct can_bittiming *bt = &priv->can.bittiming;
-	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	u16 brp, sjw, tseg1, tseg2, tdc;
 
 	/* Configure bit timing */
@@ -978,10 +978,10 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
 
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
index fee012b57f33..57e6d20804d3 100644
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
index 16e9e7d7527d..a7ebaa8c9ce9 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1347,7 +1347,7 @@ static int m_can_set_bittiming(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	const struct can_bittiming *bt = &cdev->can.bittiming;
-	const struct can_bittiming *dbt = &cdev->can.data_bittiming;
+	const struct can_bittiming *dbt = &cdev->can.fd.data_bittiming;
 	u16 brp, sjw, tseg1, tseg2;
 	u32 reg_btp;
 
@@ -1705,7 +1705,7 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		if (err)
 			return err;
 		cdev->can.bittiming_const = &m_can_bittiming_const_30X;
-		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_30X;
+		cdev->can.fd.data_bittiming_const = &m_can_data_bittiming_const_30X;
 		break;
 	case 31:
 		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
@@ -1713,13 +1713,13 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
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
index df1a5d0b37b2..5da6dab49298 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1312,7 +1312,7 @@ static void rcar_canfd_set_bittiming(struct net_device *dev)
 	struct rcar_canfd_channel *priv = netdev_priv(dev);
 	struct rcar_canfd_global *gpriv = priv->gpriv;
 	const struct can_bittiming *bt = &priv->can.bittiming;
-	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	u16 brp, sjw, tseg1, tseg2;
 	u32 cfg;
 	u32 ch = priv->channel;
@@ -1791,7 +1791,7 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 
 	if (gpriv->fdmode) {
 		priv->can.bittiming_const = &rcar_canfd_nom_bittiming_const;
-		priv->can.data_bittiming_const =
+		priv->can.fd.data_bittiming_const =
 			&rcar_canfd_data_bittiming_const;
 
 		/* Controller starts in CAN FD only mode */
diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index df18c85fc078..77050dd74a67 100644
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
@@ -904,7 +904,7 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 	priv->can.clock.freq = clk_get_rate(priv->clks[0].clk);
 	priv->can.bittiming_const = &rkcanfd_bittiming_const;
-	priv->can.data_bittiming_const = &rkcanfd_data_bittiming_const;
+	priv->can.fd.data_bittiming_const = &rkcanfd_data_bittiming_const;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 		CAN_CTRLMODE_BERR_REPORTING;
 	if (!(priv->devtype_data.quirks & RKCANFD_QUIRK_CANFD_BROKEN))
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
index 3bc56517fe7a..5370e1a26215 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -509,7 +509,7 @@ static int mcp251xfd_chip_timestamp_init(const struct mcp251xfd_priv *priv)
 static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 {
 	const struct can_bittiming *bt = &priv->can.bittiming;
-	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	u32 val = 0;
 	s8 tdco;
 	int err;
@@ -2082,7 +2082,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->can.do_set_mode = mcp251xfd_set_mode;
 	priv->can.do_get_berr_counter = mcp251xfd_get_berr_counter;
 	priv->can.bittiming_const = &mcp251xfd_bittiming_const;
-	priv->can.data_bittiming_const = &mcp251xfd_data_bittiming_const;
+	priv->can.fd.data_bittiming_const = &mcp251xfd_data_bittiming_const;
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
index bc86e9b329fd..a84152453809 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -725,7 +725,7 @@ static int gs_usb_set_bittiming(struct net_device *netdev)
 static int gs_usb_set_data_bittiming(struct net_device *netdev)
 {
 	struct gs_can *dev = netdev_priv(netdev);
-	struct can_bittiming *bt = &dev->can.data_bittiming;
+	struct can_bittiming *bt = &dev->can.fd.data_bittiming;
 	struct gs_device_bittiming dbt = {
 		.prop_seg = cpu_to_le32(bt->prop_seg),
 		.phase_seg1 = cpu_to_le32(bt->phase_seg1),
@@ -1298,8 +1298,8 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		/* The data bit timing will be overwritten, if
 		 * GS_CAN_FEATURE_BT_CONST_EXT is set.
 		 */
-		dev->can.data_bittiming_const = &dev->bt_const;
-		dev->can.do_set_data_bittiming = gs_usb_set_data_bittiming;
+		dev->can.fd.data_bittiming_const = &dev->bt_const;
+		dev->can.fd.do_set_data_bittiming = gs_usb_set_data_bittiming;
 	}
 
 	if (feature & GS_CAN_FEATURE_TERMINATION) {
@@ -1379,7 +1379,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
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
index 7d12776ab63e..bd565168bd0e 100644
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
@@ -841,8 +841,8 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
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
2.45.2


