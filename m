Return-Path: <linux-can+bounces-4844-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFE6B94729
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBDA4444CB
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022573115BC;
	Tue, 23 Sep 2025 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJVRS7tQ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEFE3115AC;
	Tue, 23 Sep 2025 05:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606062; cv=none; b=uGTYt14HkRo3cxjfrL4uwmpqjhI0OVJLa3+hhY8ksJMRkQ+GbcCwTUwhpysBVT0W3IO0dbfhE5s9W2NhLQYH2e5RDprI87tHPgonXiezS4B6x5VAsrFsFA4I8o/+cIersKsbZqEFsHXagbQfkrNdZkhLLTWw0ID35fyvDfTA3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606062; c=relaxed/simple;
	bh=Dud2tKNYSuJSlB6InOKLskOp5O1lGbmhGp2orl1cCrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wf57tN9ymXS0wNbxMtRsIlcehGvxrYL8iOGkGzgZVqYa+/0lGKqx9J/dOFeVRFjY2inEInSVvdTbnwhLZsGOHY9uvZFQyDOYT/piQEXminaFbSP446hnfZumghNYRee8TVK7d1kihDVvblm7GmucABsZHmGwpZmVC6S0goCUCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJVRS7tQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E42CC113CF;
	Tue, 23 Sep 2025 05:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606062;
	bh=Dud2tKNYSuJSlB6InOKLskOp5O1lGbmhGp2orl1cCrI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GJVRS7tQAp7Y/yR2EXM87pSGcie6BAygmnEWFG7WtilxXHXx85648VA3H+cQN1ypp
	 dng1uRw7Eo95SNcdy+r2bak+u5fp7IzcauqEiyw62A3UlkawbJdzSa8VaUkyKKGmRt
	 jVmwx8md+al81242a+ezJkXGWVLhbVqBsIGgrOcGvaXnNNCFtIBeWRxcWJIgZtMxX3
	 pP6Bamhlnm61UiomqkHC5ohqVyopI75HBeK8X/Rf9HcNXxtte5zdUmzz0YRnOvnYgQ
	 uTeGvb6IY7HqbC0OWnztJtDHezvKUizT3TJVEYqeKAoebrkyPc1nKWk1cbffGibTVz
	 9mio2IhLK4emA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 14:39:45 +0900
Subject: [PATCH v3 10/20] can: netlink: add can_dtb_changelink()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v3-10-87a7684333f3@kernel.org>
References: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
In-Reply-To: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6646; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=Dud2tKNYSuJSlB6InOKLskOp5O1lGbmhGp2orl1cCrI=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXjA40NDZ/mfX/y+HCSy8WN9hx7FWS0X3SEq2StGvSb
 oeiyz8COkpZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAEwkXJrhr4Rk2rfisz8ec+pd
 8D6+t7H36BE1LxW2bxqTlEv1dC4ezmdk2Ky4pIT3ScbVuoLjyyaLSxq2boziq1Hb5XH+osgO2VX
 3OAE=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Factorise the databittiming parsing out of can_changelink() and move
it in the new can_dtb_changelink() function. This is a preparation
patch for the introduction of CAN XL because the databittiming
changelink logic will be reused later on.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

v1 -> v2:

  - Change WARN_ON(1) into return -EOPNOTSUPP to suppress a gcc
    warning.
    Link: https://lore.kernel.org/linux-can/202509050404.ZLQknagH-lkp@intel.com/

RFC -> v1:

  - In the RFC, can_dbt_changelink() required 8 parameters. Instead,
    just pass a boolean and then get the FD/XL specific parameters in
    an "if (fd) {} else {}" conditional.
---
 drivers/net/can/dev/netlink.c | 152 ++++++++++++++++++++++++------------------
 1 file changed, 88 insertions(+), 64 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index abff7b84fdce9641e1a5338ec6cef992774b0ec0..5f2962aab5763a0dc8f86a6fa7fa3afbef125d26 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -221,12 +221,95 @@ static int can_tdc_changelink(struct data_bittiming_params *dbt_params,
 	return 0;
 }
 
+static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
+			      bool fd, struct netlink_ext_ack *extack)
+{
+	struct nlattr *data_bittiming, *data_tdc;
+	struct can_priv *priv = netdev_priv(dev);
+	struct data_bittiming_params *dbt_params;
+	struct can_bittiming dbt;
+	bool need_tdc_calc = false;
+	u32 tdc_mask;
+	int err;
+
+	if (fd) {
+		data_bittiming = data[IFLA_CAN_DATA_BITTIMING];
+		data_tdc = data[IFLA_CAN_TDC];
+		dbt_params = &priv->fd;
+		tdc_mask = CAN_CTRLMODE_FD_TDC_MASK;
+	} else {
+		return -EOPNOTSUPP; /* Place holder for CAN XL */
+	}
+
+	if (!data_bittiming)
+		return 0;
+
+	/* Do not allow changing bittiming while running */
+	if (dev->flags & IFF_UP)
+		return -EBUSY;
+
+	/* Calculate bittiming parameters based on data_bittiming_const
+	 * if set, otherwise pass bitrate directly via do_set_bitrate().
+	 * Bail out if neither is given.
+	 */
+	if (!dbt_params->data_bittiming_const && !dbt_params->do_set_data_bittiming &&
+	    !dbt_params->data_bitrate_const)
+		return -EOPNOTSUPP;
+
+	memcpy(&dbt, nla_data(data_bittiming), sizeof(dbt));
+	err = can_get_bittiming(dev, &dbt, dbt_params->data_bittiming_const,
+				dbt_params->data_bitrate_const,
+				dbt_params->data_bitrate_const_cnt, extack);
+	if (err)
+		return err;
+
+	if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "CAN data bitrate %u bps surpasses transceiver capabilities of %u bps",
+				   dbt.bitrate, priv->bitrate_max);
+		return -EINVAL;
+	}
+
+	memset(&dbt_params->tdc, 0, sizeof(dbt_params->tdc));
+	if (data[IFLA_CAN_CTRLMODE]) {
+		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
+
+		need_tdc_calc = !(cm->mask & tdc_mask);
+	}
+	if (data_tdc) {
+		/* TDC parameters are provided: use them */
+		err = can_tdc_changelink(dbt_params, data_tdc, extack);
+		if (err) {
+			priv->ctrlmode &= ~tdc_mask;
+			return err;
+		}
+	} else if (need_tdc_calc) {
+		/* Neither of TDC parameters nor TDC flags are provided:
+		 * do calculation
+		 */
+		can_calc_tdco(&dbt_params->tdc, dbt_params->tdc_const, &dbt,
+			      &priv->ctrlmode, priv->ctrlmode_supported);
+	} /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
+	   * turned off. TDC is disabled: do nothing
+	   */
+
+	memcpy(&dbt_params->data_bittiming, &dbt, sizeof(dbt));
+
+	if (dbt_params->do_set_data_bittiming) {
+		/* Finally, set the bit-timing registers */
+		err = dbt_params->do_set_data_bittiming(dev);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			  struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	bool fd_tdc_flag_provided = false;
 	int err;
 
 	/* We need synchronization with dev->stop() */
@@ -273,8 +356,6 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		}
 
 		can_set_default_mtu(dev);
-
-		fd_tdc_flag_provided = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
 	}
 
 	if (data[IFLA_CAN_BITTIMING]) {
@@ -347,67 +428,10 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			return err;
 	}
 
-	if (data[IFLA_CAN_DATA_BITTIMING]) {
-		struct can_bittiming dbt;
-
-		/* Do not allow changing bittiming while running */
-		if (dev->flags & IFF_UP)
-			return -EBUSY;
-
-		/* Calculate bittiming parameters based on
-		 * data_bittiming_const if set, otherwise pass bitrate
-		 * directly via do_set_bitrate(). Bail out if neither
-		 * is given.
-		 */
-		if (!priv->fd.data_bittiming_const && !priv->fd.do_set_data_bittiming &&
-		    !priv->fd.data_bitrate_const)
-			return -EOPNOTSUPP;
-
-		memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
-		       sizeof(dbt));
-		err = can_get_bittiming(dev, &dbt,
-					priv->fd.data_bittiming_const,
-					priv->fd.data_bitrate_const,
-					priv->fd.data_bitrate_const_cnt,
-					extack);
-		if (err)
-			return err;
-
-		if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
-			NL_SET_ERR_MSG_FMT(extack,
-					   "CANFD data bitrate %u bps surpasses transceiver capabilities of %u bps",
-					   dbt.bitrate, priv->bitrate_max);
-			return -EINVAL;
-		}
-
-		memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
-		if (data[IFLA_CAN_TDC]) {
-			/* TDC parameters are provided: use them */
-			err = can_tdc_changelink(&priv->fd,
-						 data[IFLA_CAN_TDC], extack);
-			if (err) {
-				priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
-				return err;
-			}
-		} else if (!fd_tdc_flag_provided) {
-			/* Neither of TDC parameters nor TDC flags are
-			 * provided: do calculation
-			 */
-			can_calc_tdco(&priv->fd.tdc, priv->fd.tdc_const, &dbt,
-				      &priv->ctrlmode, priv->ctrlmode_supported);
-		} /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
-		   * turned off. TDC is disabled: do nothing
-		   */
-
-		memcpy(&priv->fd.data_bittiming, &dbt, sizeof(dbt));
-
-		if (priv->fd.do_set_data_bittiming) {
-			/* Finally, set the bit-timing registers */
-			err = priv->fd.do_set_data_bittiming(dev);
-			if (err)
-				return err;
-		}
-	}
+	/* CAN FD */
+	err = can_dbt_changelink(dev, data, true, extack);
+	if (err)
+		return err;
 
 	if (data[IFLA_CAN_TERMINATION]) {
 		const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);

-- 
2.49.1


