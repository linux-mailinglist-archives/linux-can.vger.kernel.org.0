Return-Path: <linux-can+bounces-3706-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB18AC5B1E
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 21:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CC03ACE23
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 19:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CFD20296A;
	Tue, 27 May 2025 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="OIZKGcxC";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="8X+rJteR"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932AF1FDE33
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375993; cv=pass; b=jWxX9r6nM92MwVw6eUqL6OBD35hsm8gdCsCaQJ+nQLNzVWCgy6R8XDR3xtjemqBWtglh6kAO/iZOA5C8tQXwuyzYfTujbEroFpF6nzo5mmAyC+APYohUZTK19QTMu6PVfB1edCwT6qlBG0247p25rp5bPsGHxNhoGXhRulhqPuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375993; c=relaxed/simple;
	bh=79dTzUKejBg5TMJdybiV3R3VS0DzKTNnzmF4BpNeN3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lSkvNWrM8i1Tri7jgJ3OplZhZ/Jd7/LePXFwjwyZ6F7AtjnERd2GXqYXzhJBrfH08nwp1NQBQh0m337oZwxdi0ahDkDT/aBtCKMUdg1jp70/+jbl1wZ246oVc1gKvqhJmHSfLTZs2i8+E9oVi1wLCfNsh/XuhIA4iVjwSIguIWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OIZKGcxC; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=8X+rJteR; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1748375801; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PmFXR5Uj5Ou4rnJK2i5rT0VoeCY2Usn8eaSb6hPSePO+SRpoIQMDMjUtu5jDY0E0Pd
    g2isopyO8bZH8jTmnX6g5Vf49OVBKWZ9AIKZCkVwHFhIhiKudG919pbtL64RY+lzukKg
    q4Uw1rqbv1k49+Cewy7Dt8ACwaoj9gdVkFasSV6npnC6oUwd/LuM+4p7Y7auRgFRj4wI
    nDUxt8s3Z9CSCdm7OFikYKPq7A3ZyXttTNhsjeBiZ8BtyYbhkudsBOJgEkNmez71DNzt
    cQa55bFFRyBs61TjDbm24LMcDKPGv3lI21iVJINQJSHG/BgqwQ/ZTnm7PFlN1NMS9j1r
    Ld/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375801;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aOBMSEKEPwCN3MWkm9Y2lJNEMr0nbK6Sy2lvFx3AISE=;
    b=i+vyVOYcmyW7PKZN/BAyBu7bWPz+nSH7XM047adQnLdP7tV+E3MIRGK7hEj0cydf5m
    Tz0BqusKnD/bxsWAzVD9uNlmXSB3EAjP/voYE3c8oAcXB7LPsBOr6B61/ess1u9nXahM
    NqNnghf7kgoHXrUXD3arLHxIgWEW+Yh5J2CpAF8eL3QqjyXFZaxoYX3mboxFwqtiUC24
    WuEUWGjZnK+XzTW3JzDqyMmACAefMa0CZbIvWubEtAj6QCkxrzzKiDk8jF7xvqt7XK1y
    rhKhbWQ7KoQbkiumG91WjhV2RiE20x/AHvLJ0BlRMBA/6iw9sqfnSybkzcnkM+aSYXRO
    lTkg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375801;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aOBMSEKEPwCN3MWkm9Y2lJNEMr0nbK6Sy2lvFx3AISE=;
    b=OIZKGcxCyyMQ9LoBfWyNVlQfXnXRwaVaeTtEAZEbTVHVlwfQnQEpXBcF69geQGoKIM
    86RAEigtcOiykvR+NbFNIHOVD69+LdQsvnO0P7OSURU7CkRP0Yuv7zlbERZ4y4z8wAlZ
    Ekxuqe7NkChKJPLY98kc3ncWyOXbJBSPAlVYLIWH8TO28U6pAWSQhg/7SFfai9wWrpw1
    8OgNkViewLTOdph3y9KaypEryGA4qbf6/0yLBbvbEIUakxoY/IC5Avlr4tir8nEl0iB7
    rvHH5eyKaVryasMMCoORB94xIUc0ePwMICKF3Ml3VQff6rltnctrjH1gXy/MFb21GJbJ
    VB1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748375801;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aOBMSEKEPwCN3MWkm9Y2lJNEMr0nbK6Sy2lvFx3AISE=;
    b=8X+rJteR/OVuyFTUBXi6c02KFbH+6P4KNA8ZdH9r+K39gBNaQ4+rtdUP+/y7rhdFih
    V2LCfKsoBW5X33R7Z9Aw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514RJufiW3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 May 2025 21:56:41 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 01/11] can: dev: add struct data_bittiming_params to group FD parameters
Date: Tue, 27 May 2025 21:56:15 +0200
Message-ID: <20250527195625.65252-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

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

This done, all the drivers are updated to make use of the new layout.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
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
@@ -273,11 +273,11 @@ static int ctucan_set_bittiming(struct net_device *ndev)
  * Return: 0 on success, -%EPERM on error
  */
 static int ctucan_set_data_bittiming(struct net_device *ndev)
 {
 	struct ctucan_priv *priv = netdev_priv(ndev);
-	struct can_bittiming *dbt = &priv->can.data_bittiming;
+	struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 
 	/* Note that dbt may be modified here */
 	return ctucan_set_btr(ndev, dbt, false);
 }
 
@@ -288,11 +288,11 @@ static int ctucan_set_data_bittiming(struct net_device *ndev)
  * Return: 0 on success, -%EPERM if controller is enabled
  */
 static int ctucan_set_secondary_sample_point(struct net_device *ndev)
 {
 	struct ctucan_priv *priv = netdev_priv(ndev);
-	struct can_bittiming *dbt = &priv->can.data_bittiming;
+	struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	int ssp_offset = 0;
 	u32 ssp_cfg = 0; /* No SSP by default */
 
 	if (CTU_CAN_FD_ENABLED(priv)) {
 		netdev_err(ndev, "BUG! Cannot set SSP - CAN is enabled\n");
@@ -1356,16 +1356,16 @@ int ctucan_probe_common(struct device *dev, void __iomem *addr, int irq, unsigne
 	spin_lock_init(&priv->tx_lock);
 	INIT_LIST_HEAD(&priv->peers_on_pdev);
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
 					| CAN_CTRLMODE_LISTENONLY
 					| CAN_CTRLMODE_FD
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 5ec3170b896a..ea8c807af4d8 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -402,12 +402,12 @@ int open_candev(struct net_device *dev)
 		return -EINVAL;
 	}
 
 	/* For CAN FD the data bitrate has to be >= the arbitration bitrate */
 	if ((priv->ctrlmode & CAN_CTRLMODE_FD) &&
-	    (!priv->data_bittiming.bitrate ||
-	     priv->data_bittiming.bitrate < priv->bittiming.bitrate)) {
+	    (!priv->fd.data_bittiming.bitrate ||
+	     priv->fd.data_bittiming.bitrate < priv->bittiming.bitrate)) {
 		netdev_err(dev, "incorrect/missing data bit-timing\n");
 		return -EINVAL;
 	}
 
 	/* Switch carrier on if device was stopped while in bus-off state */
@@ -541,20 +541,20 @@ int register_candev(struct net_device *dev)
 		return -EINVAL;
 
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
 		err = can_get_termination(dev);
 		if (err)
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index f1db9b7ffd4d..a36842ace084 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -139,11 +139,11 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 			      struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
 	struct can_tdc tdc = { 0 };
-	const struct can_tdc_const *tdc_const = priv->tdc_const;
+	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
 	int err;
 
 	if (!tdc_const || !can_tdc_is_enabled(priv))
 		return -EOPNOTSUPP;
 
@@ -177,11 +177,11 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 			return -EINVAL;
 
 		tdc.tdcf = tdcf;
 	}
 
-	priv->tdc = tdc;
+	priv->fd.tdc = tdc;
 
 	return 0;
 }
 
 static int can_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -226,14 +226,14 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		/* CAN_CTRLMODE_FD can only be set when driver supports FD */
 		if (priv->ctrlmode & CAN_CTRLMODE_FD) {
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
 		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually
 		 * exclusive: make sure to turn the other one off
@@ -310,20 +310,20 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		/* Calculate bittiming parameters based on
 		 * data_bittiming_const if set, otherwise pass bitrate
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
 
 		if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
@@ -331,11 +331,11 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 					   "CANFD data bitrate %u bps surpasses transceiver capabilities of %u bps",
 					   dbt.bitrate, priv->bitrate_max);
 			return -EINVAL;
 		}
 
-		memset(&priv->tdc, 0, sizeof(priv->tdc));
+		memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 		if (data[IFLA_CAN_TDC]) {
 			/* TDC parameters are provided: use them */
 			err = can_tdc_changelink(priv, data[IFLA_CAN_TDC],
 						 extack);
 			if (err) {
@@ -344,21 +344,21 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			}
 		} else if (!tdc_mask) {
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
 	}
 
@@ -392,31 +392,31 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 static size_t can_tdc_get_size(const struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
 	size_t size;
 
-	if (!priv->tdc_const)
+	if (!priv->fd.tdc_const)
 		return 0;
 
 	size = nla_total_size(0);			/* nest IFLA_CAN_TDC */
 	if (priv->ctrlmode_supported & CAN_CTRLMODE_TDC_MANUAL) {
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV_MIN */
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV_MAX */
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
 
 	return size;
 }
@@ -440,25 +440,25 @@ static size_t can_get_size(const struct net_device *dev)
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_STATE */
 	size += nla_total_size(sizeof(struct can_ctrlmode));	/* IFLA_CAN_CTRLMODE */
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
 		size += nla_total_size(sizeof(*priv->termination_const) *	/* IFLA_CAN_TERMINATION_CONST */
 				       priv->termination_const_cnt);
 	}
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
 
 	return size;
@@ -466,12 +466,12 @@ static size_t can_get_size(const struct net_device *dev)
 
 static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct nlattr *nest;
 	struct can_priv *priv = netdev_priv(dev);
-	struct can_tdc *tdc = &priv->tdc;
-	const struct can_tdc_const *tdc_const = priv->tdc_const;
+	struct can_tdc *tdc = &priv->fd.tdc;
+	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
 
 	if (!tdc_const)
 		return 0;
 
 	nest = nla_nest_start(skb, IFLA_CAN_TDC);
@@ -495,12 +495,12 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		int err = -EINVAL;
 
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
 		if (nla_put_u32(skb, IFLA_CAN_TDC_TDCO, tdc->tdco))
 			goto err_cancel;
@@ -562,18 +562,18 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	    (priv->do_get_berr_counter &&
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
 	      nla_put(skb, IFLA_CAN_TERMINATION_CONST,
 		      sizeof(*priv->termination_const) *
@@ -584,15 +584,15 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	     nla_put(skb, IFLA_CAN_BITRATE_CONST,
 		     sizeof(*priv->bitrate_const) *
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
 		     &priv->bitrate_max)) ||
 
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 6d80c341b26f..06d5d35fc1b5 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1224,11 +1224,11 @@ static void flexcan_set_bittiming_ctrl(const struct net_device *dev)
 
 static void flexcan_set_bittiming_cbt(const struct net_device *dev)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct can_bittiming *bt = &priv->can.bittiming;
-	struct can_bittiming *dbt = &priv->can.data_bittiming;
+	struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg_cbt, reg_fdctrl;
 
 	/* CBT */
 	/* CBT[EPSEG1] is 5 bit long and CBT[EPROPSEG] is 6 bit
@@ -2237,11 +2237,11 @@ static int flexcan_probe(struct platform_device *pdev)
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_FD_NON_ISO;
 		priv->can.bittiming_const = &flexcan_fd_bittiming_const;
-		priv->can.data_bittiming_const =
+		priv->can.fd.data_bittiming_const =
 			&flexcan_fd_data_bittiming_const;
 	} else {
 		priv->can.bittiming_const = &flexcan_bittiming_const;
 	}
 
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index c86b57d47085..2eeee65f606f 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -667,11 +667,11 @@ static const struct can_bittiming_const ifi_canfd_bittiming_const = {
 
 static void ifi_canfd_set_bittiming(struct net_device *ndev)
 {
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
 	const struct can_bittiming *bt = &priv->can.bittiming;
-	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	u16 brp, sjw, tseg1, tseg2, tdc;
 
 	/* Configure bit timing */
 	brp = bt->brp - 2;
 	sjw = bt->sjw - 1;
@@ -998,14 +998,14 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
 
 	priv->can.state = CAN_STATE_STOPPED;
 
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
 
 	/* IFI CANFD can do both Bosch FD and ISO FD */
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index cf0d51805272..4022eb2e1a7d 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -854,11 +854,11 @@ static int kvaser_pciefd_set_bittiming(struct kvaser_pciefd_can *can, bool data)
 	unsigned long irq_flags;
 	int ret;
 	struct can_bittiming *bt;
 
 	if (data)
-		bt = &can->can.data_bittiming;
+		bt = &can->can.fd.data_bittiming;
 	else
 		bt = &can->can.bittiming;
 
 	btrn = FIELD_PREP(KVASER_PCIEFD_KCAN_BTRN_TSEG2_MASK, bt->phase_seg2 - 1) |
 	       FIELD_PREP(KVASER_PCIEFD_KCAN_BTRN_TSEG1_MASK, bt->prop_seg + bt->phase_seg1 - 1) |
@@ -989,13 +989,13 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->echo_idx = 0;
 		spin_lock_init(&can->echo_lock);
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
 					      CAN_CTRLMODE_FD |
 					      CAN_CTRLMODE_FD_NON_ISO |
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index c2c116ce1087..6c656bfdb323 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1370,11 +1370,11 @@ static const struct can_bittiming_const m_can_data_bittiming_const_31X = {
 
 static int m_can_set_bittiming(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	const struct can_bittiming *bt = &cdev->can.bittiming;
-	const struct can_bittiming *dbt = &cdev->can.data_bittiming;
+	const struct can_bittiming *dbt = &cdev->can.fd.data_bittiming;
 	u16 brp, sjw, tseg1, tseg2;
 	u32 reg_btp;
 
 	brp = bt->brp - 1;
 	sjw = bt->sjw - 1;
@@ -1736,25 +1736,25 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.x */
 		err = can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
 		if (err)
 			return err;
 		cdev->can.bittiming_const = &m_can_bittiming_const_30X;
-		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_30X;
+		cdev->can.fd.data_bittiming_const = &m_can_data_bittiming_const_30X;
 		break;
 	case 31:
 		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
 		err = can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
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
 			return niso;
 		if (niso)
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 28f3fd805273..77292afaed22 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -622,11 +622,11 @@ static int peak_canfd_set_bittiming(struct net_device *ndev)
 
 static int peak_canfd_set_data_bittiming(struct net_device *ndev)
 {
 	struct peak_canfd_priv *priv = netdev_priv(ndev);
 
-	return pucan_set_timing_fast(priv, &priv->can.data_bittiming);
+	return pucan_set_timing_fast(priv, &priv->can.fd.data_bittiming);
 }
 
 static int peak_canfd_close(struct net_device *ndev)
 {
 	struct peak_canfd_priv *priv = netdev_priv(ndev);
@@ -811,16 +811,16 @@ struct net_device *alloc_peak_canfd_dev(int sizeof_priv, int index,
 	priv = netdev_priv(ndev);
 
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
 				       CAN_CTRLMODE_FD |
 				       CAN_CTRLMODE_FD_NON_ISO |
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index aa3df0d05b85..7b7eb0df0d72 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1302,11 +1302,11 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
 static void rcar_canfd_set_bittiming(struct net_device *dev)
 {
 	struct rcar_canfd_channel *priv = netdev_priv(dev);
 	struct rcar_canfd_global *gpriv = priv->gpriv;
 	const struct can_bittiming *bt = &priv->can.bittiming;
-	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	u16 brp, sjw, tseg1, tseg2;
 	u32 cfg;
 	u32 ch = priv->channel;
 
 	/* Nominal bit timing settings */
@@ -1781,11 +1781,11 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 		}
 	}
 
 	if (gpriv->fdmode) {
 		priv->can.bittiming_const = &rcar_canfd_nom_bittiming_const;
-		priv->can.data_bittiming_const =
+		priv->can.fd.data_bittiming_const =
 			&rcar_canfd_data_bittiming_const;
 
 		/* Controller starts in CAN FD only mode */
 		err = can_set_static_ctrlmode(ndev, CAN_CTRLMODE_FD);
 		if (err)
diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index c3fb3176ce42..046f0a0ae4d4 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -116,11 +116,11 @@ static void rkcanfd_chip_set_work_mode(const struct rkcanfd_priv *priv)
 	rkcanfd_write(priv, RKCANFD_REG_MODE, priv->reg_mode_default);
 }
 
 static int rkcanfd_set_bittiming(struct rkcanfd_priv *priv)
 {
-	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	u32 reg_nbt, reg_dbt, reg_tdc;
 	u32 tdco;
 
 	reg_nbt = FIELD_PREP(RKCANFD_REG_FD_NOMINAL_BITTIMING_SJW,
@@ -897,11 +897,11 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	ndev->flags |= IFF_ECHO;
 
 	platform_set_drvdata(pdev, priv);
 	priv->can.clock.freq = clk_get_rate(priv->clks[0].clk);
 	priv->can.bittiming_const = &rkcanfd_bittiming_const;
-	priv->can.data_bittiming_const = &rkcanfd_data_bittiming_const;
+	priv->can.fd.data_bittiming_const = &rkcanfd_data_bittiming_const;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 		CAN_CTRLMODE_BERR_REPORTING;
 	priv->can.do_set_mode = rkcanfd_set_mode;
 	priv->can.do_get_berr_counter = rkcanfd_get_berr_counter;
 	priv->ndev = ndev;
diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
index 43d4b5721812..fa85a75be65a 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
@@ -37,11 +37,11 @@ static void rkcanfd_timestamp_work(struct work_struct *work)
 	schedule_delayed_work(&priv->timestamp, priv->work_delay_jiffies);
 }
 
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv)
 {
-	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	struct cyclecounter *cc = &priv->cc;
 	u32 bitrate, div, reg, rate;
 	u64 work_delay_ns;
 	u64 max_cycles;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index c30b04f8fc0d..ac046645c7d6 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -525,11 +525,11 @@ static int mcp251xfd_chip_timestamp_init(const struct mcp251xfd_priv *priv)
 }
 
 static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 {
 	const struct can_bittiming *bt = &priv->can.bittiming;
-	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	u32 tdcmod, val = 0;
 	int err;
 
 	/* CAN Control Register
 	 *
@@ -598,12 +598,12 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 		tdcmod = MCP251XFD_REG_TDC_TDCMOD_MANUAL;
 	else
 		tdcmod = MCP251XFD_REG_TDC_TDCMOD_DISABLED;
 
 	val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK, tdcmod) |
-		FIELD_PREP(MCP251XFD_REG_TDC_TDCV_MASK, priv->can.tdc.tdcv) |
-		FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, priv->can.tdc.tdco);
+		FIELD_PREP(MCP251XFD_REG_TDC_TDCV_MASK, priv->can.fd.tdc.tdcv) |
+		FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, priv->can.fd.tdc.tdco);
 
 	return regmap_write(priv->map_reg, MCP251XFD_REG_TDC, val);
 }
 
 static int mcp251xfd_chip_rx_int_enable(const struct mcp251xfd_priv *priv)
@@ -2102,12 +2102,12 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	if (pll_enable)
 		priv->can.clock.freq *= MCP251XFD_OSC_PLL_MULTIPLIER;
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
 		CAN_CTRLMODE_CC_LEN8_DLC | CAN_CTRLMODE_TDC_AUTO |
 		CAN_CTRLMODE_TDC_MANUAL;
diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 03ad10b01867..27a3818885c2 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -1096,11 +1096,11 @@ static int esd_usb_3_set_bittiming(struct net_device *netdev)
 {
 	const struct can_bittiming_const *nom_btc = &esd_usb_3_nom_bittiming_const;
 	const struct can_bittiming_const *data_btc = &esd_usb_3_data_bittiming_const;
 	struct esd_usb_net_priv *priv = netdev_priv(netdev);
 	struct can_bittiming *nom_bt = &priv->can.bittiming;
-	struct can_bittiming *data_bt = &priv->can.data_bittiming;
+	struct can_bittiming *data_bt = &priv->can.fd.data_bittiming;
 	struct esd_usb_3_set_baudrate_msg_x *baud_x;
 	union esd_usb_msg *msg;
 	u16 flags = 0;
 	int err;
 
@@ -1216,13 +1216,13 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 	switch (le16_to_cpu(dev->udev->descriptor.idProduct)) {
 	case ESD_USB_CANUSB3_PRODUCT_ID:
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
 		priv->can.clock.freq = ESD_USB_M_CAN_CLOCK;
 		priv->can.bittiming_const = &esd_usb_2_bittiming_const;
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 71f24dc0a927..db1acf6d504c 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -2057,12 +2057,12 @@ static int es58x_init_priv(struct es58x_device *es58x_dev,
 	priv->tx_urb = NULL;
 	priv->tx_can_msg_cnt = 0;
 
 	can->bittiming_const = param->bittiming_const;
 	if (param->ctrlmode_supported & CAN_CTRLMODE_FD) {
-		can->data_bittiming_const = param->data_bittiming_const;
-		can->tdc_const = param->tdc_const;
+		can->fd.data_bittiming_const = param->data_bittiming_const;
+		can->fd.tdc_const = param->tdc_const;
 	}
 	can->bitrate_max = param->bitrate_max;
 	can->clock = param->clock;
 	can->state = CAN_STATE_STOPPED;
 	can->ctrlmode_supported = param->ctrlmode_supported;
diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
index 84ffa1839bac..d924b053677b 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
@@ -425,16 +425,16 @@ static int es58x_fd_enable_channel(struct es58x_priv *priv)
 		tx_conf_msg.canfd_enabled = 1;
 	}
 
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
 	} else {
 		conf_len = ES58X_FD_CAN_CONF_LEN;
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3ccac6781b98..bb6335278e46 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -726,11 +726,11 @@ static int gs_usb_set_bittiming(struct net_device *netdev)
 }
 
 static int gs_usb_set_data_bittiming(struct net_device *netdev)
 {
 	struct gs_can *dev = netdev_priv(netdev);
-	struct can_bittiming *bt = &dev->can.data_bittiming;
+	struct can_bittiming *bt = &dev->can.fd.data_bittiming;
 	struct gs_device_bittiming dbt = {
 		.prop_seg = cpu_to_le32(bt->prop_seg),
 		.phase_seg1 = cpu_to_le32(bt->phase_seg1),
 		.phase_seg2 = cpu_to_le32(bt->phase_seg2),
 		.sjw = cpu_to_le32(bt->sjw),
@@ -1298,12 +1298,12 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	if (feature & GS_CAN_FEATURE_FD) {
 		dev->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 		/* The data bit timing will be overwritten, if
 		 * GS_CAN_FEATURE_BT_CONST_EXT is set.
 		 */
-		dev->can.data_bittiming_const = &dev->bt_const;
-		dev->can.do_set_data_bittiming = gs_usb_set_data_bittiming;
+		dev->can.fd.data_bittiming_const = &dev->bt_const;
+		dev->can.fd.do_set_data_bittiming = gs_usb_set_data_bittiming;
 	}
 
 	if (feature & GS_CAN_FEATURE_TERMINATION) {
 		rc = gs_usb_get_termination(netdev, &dev->can.termination);
 		if (rc) {
@@ -1379,11 +1379,11 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->data_bt_const.sjw_max = le32_to_cpu(bt_const_extended.dsjw_max);
 		dev->data_bt_const.brp_min = le32_to_cpu(bt_const_extended.dbrp_min);
 		dev->data_bt_const.brp_max = le32_to_cpu(bt_const_extended.dbrp_max);
 		dev->data_bt_const.brp_inc = le32_to_cpu(bt_const_extended.dbrp_inc);
 
-		dev->can.data_bittiming_const = &dev->data_bt_const;
+		dev->can.fd.data_bittiming_const = &dev->data_bt_const;
 	}
 
 	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
 	SET_NETDEV_DEV(netdev, &intf->dev);
 
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 078496d9b7ba..f6c77eca9f43 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -135,11 +135,11 @@ struct kvaser_usb_net_priv {
 /**
  * struct kvaser_usb_dev_ops - Device specific functions
  * @dev_set_mode:		used for can.do_set_mode
  * @dev_set_bittiming:		used for can.do_set_bittiming
  * @dev_get_busparams:		readback arbitration busparams
- * @dev_set_data_bittiming:	used for can.do_set_data_bittiming
+ * @dev_set_data_bittiming:	used for can.fd.do_set_data_bittiming
  * @dev_get_data_busparams:	readback data busparams
  * @dev_get_berr_counter:	used for can.do_get_berr_counter
  *
  * @dev_setup_endpoints:	setup USB in and out endpoints
  * @dev_init_card:		initialize card
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index dcb0bcbe0565..daf42080f942 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -590,11 +590,11 @@ static int kvaser_usb_set_bittiming(struct net_device *netdev)
 static int kvaser_usb_set_data_bittiming(struct net_device *netdev)
 {
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
 	struct kvaser_usb *dev = priv->dev;
 	const struct kvaser_usb_dev_ops *ops = dev->driver_info->ops;
-	struct can_bittiming *dbt = &priv->can.data_bittiming;
+	struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	struct kvaser_usb_busparams busparams;
 	int tseg1 = dbt->prop_seg + dbt->phase_seg1;
 	int tseg2 = dbt->phase_seg2;
 	int sjw = dbt->sjw;
 	int err;
@@ -840,12 +840,12 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
 
 	priv->can.ctrlmode_supported |= dev->card_data.ctrlmode_supported;
 
 	if (priv->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
-		priv->can.data_bittiming_const = dev->cfg->data_bittiming_const;
-		priv->can.do_set_data_bittiming = kvaser_usb_set_data_bittiming;
+		priv->can.fd.data_bittiming_const = dev->cfg->data_bittiming_const;
+		priv->can.fd.do_set_data_bittiming = kvaser_usb_set_data_bittiming;
 	}
 
 	netdev->flags |= IFF_ECHO;
 
 	netdev->netdev_ops = &kvaser_usb_netdev_ops;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 59f7cd8ceb39..117637b9b995 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -768,11 +768,11 @@ static int peak_usb_set_data_bittiming(struct net_device *netdev)
 {
 	struct peak_usb_device *dev = netdev_priv(netdev);
 	const struct peak_usb_adapter *pa = dev->adapter;
 
 	if (pa->dev_set_data_bittiming) {
-		struct can_bittiming *bt = &dev->can.data_bittiming;
+		struct can_bittiming *bt = &dev->can.fd.data_bittiming;
 		int err = pa->dev_set_data_bittiming(dev, bt);
 
 		if (err)
 			netdev_info(netdev,
 				    "couldn't set data bitrate (err %d)\n",
@@ -952,12 +952,12 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	dev->ep_msg_out = peak_usb_adapter->ep_msg_out[ctrl_idx];
 
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
 
 	netdev->netdev_ops = &peak_usb_netdev_ops;
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 436c0e4b0344..3f2e378199ab 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -479,11 +479,11 @@ static int set_reset_mode(struct net_device *ndev)
  */
 static int xcan_set_bittiming(struct net_device *ndev)
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
 	struct can_bittiming *bt = &priv->can.bittiming;
-	struct can_bittiming *dbt = &priv->can.data_bittiming;
+	struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
 	u32 btr0, btr1;
 	u32 is_config_mode;
 
 	/* Check whether Xilinx CAN is in configuration mode.
 	 * It cannot set bit timing if Xilinx CAN is not in configuration mode.
@@ -515,14 +515,14 @@ static int xcan_set_bittiming(struct net_device *ndev)
 	    priv->devtype.cantype == XAXI_CANFD_2_0) {
 		/* Setting Baud Rate prescaler value in F_BRPR Register */
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
 
 		/* Setting Time Segment 1 in BTR Register */
 		btr1 = dbt->prop_seg + dbt->phase_seg1 - 1;
@@ -1965,26 +1965,26 @@ static int xcan_probe(struct platform_device *pdev)
 	ret = reset_control_reset(priv->rstc);
 	if (ret)
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
 	priv->tx_max = tx_max;
 	priv->devtype = *devtype;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 23492213ea35..492d23bec7be 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -36,27 +36,33 @@ enum can_termination_gpio {
 	CAN_TERMINATION_GPIO_DISABLED = 0,
 	CAN_TERMINATION_GPIO_ENABLED,
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
 struct can_priv {
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
 
 	unsigned int termination_const_cnt;
 	const u16 *termination_const;
@@ -75,18 +81,16 @@ struct can_priv {
 
 	int restart_ms;
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
 {
 	return !!(priv->ctrlmode & CAN_CTRLMODE_TDC_MASK);
@@ -112,15 +116,15 @@ static inline bool can_tdc_is_enabled(const struct can_priv *priv)
  *                           |                      |<->| relative TDCO
  *  |<------------- Secondary Sample Point ------------>|
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
 static inline int __must_check can_set_static_ctrlmode(struct net_device *dev,
 						       u32 static_mode)
-- 
2.47.2


