Return-Path: <linux-can+bounces-5001-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E00B9F1E3
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F24F4E49E0
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC962FFDD4;
	Thu, 25 Sep 2025 12:14:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892782FF157
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802443; cv=none; b=iH7HHbfuljCSmIVzmlDiXfXBHzF/M6v1DF91/FxyebhkeQNNl6M1LntZFoZsKYdQPjnj3nG1c85W6bJ0DpXPuKFEKCoGi5+PbmBs5DldsVmPz+BbD5sN2SmOg/TSOdqViq+wtz3BUoEMKDeqoEJILFnU4mxgeKVB9TWZ2NWRjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802443; c=relaxed/simple;
	bh=ARoB4N4UyQFWYljOs3TO8QYdImHXJ73Z2AEofYwRdnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlnmatLLPU9ueg8TsNi9bkC0PP1OdvmVaevAhYxhUrtN0T2AgRMR246D0p4fzr7Mdac4Aqv/RGBSUjv1IcNbusMmclnFS4SkycWxnYx2h5NbEfbLUbXYEjI9W4nWtXheAiT8BLSjYpXK+efYEjuq2/CHRpnDj8plBwF8kuHbdro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqy-0000Zt-1s; Thu, 25 Sep 2025 14:13:40 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqw-000Pxk-0y;
	Thu, 25 Sep 2025 14:13:38 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0FB0047999C;
	Thu, 25 Sep 2025 12:13:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 48/48] can: netlink: add userland error messages
Date: Thu, 25 Sep 2025 14:08:25 +0200
Message-ID: <20250925121332.848157-49-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925121332.848157-1-mkl@pengutronix.de>
References: <20250925121332.848157-1-mkl@pengutronix.de>
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

Use NL_SET_ERR_MSG() and NL_SET_ERR_MSG_FMT() to return meaningful
error messages to the userland whenever a -EOPNOTSUPP error is
returned due to a failed validation of the CAN netlink arguments.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-20-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 82 ++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 92d8df13e886..0591406b6f32 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -64,15 +64,23 @@ static int can_validate_tdc(struct nlattr *data_tdc,
 	bool tdc_auto = tdc_flags & CAN_CTRLMODE_TDC_AUTO_MASK;
 	int err;
 
-	/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive */
-	if (tdc_auto && tdc_manual)
+	if (tdc_auto && tdc_manual) {
+		NL_SET_ERR_MSG(extack,
+			       "TDC manual and auto modes are mutually exclusive");
 		return -EOPNOTSUPP;
+	}
 
 	/* If one of the CAN_CTRLMODE_TDC_* flag is set then TDC
 	 * must be set and vice-versa
 	 */
-	if ((tdc_auto || tdc_manual) != !!data_tdc)
+	if ((tdc_auto || tdc_manual) && !data_tdc) {
+		NL_SET_ERR_MSG(extack, "TDC parameters are missing");
 		return -EOPNOTSUPP;
+	}
+	if (!(tdc_auto || tdc_manual) && data_tdc) {
+		NL_SET_ERR_MSG(extack, "TDC mode (auto or manual) is missing");
+		return -EOPNOTSUPP;
+	}
 
 	/* If providing TDC parameters, at least TDCO is needed. TDCV
 	 * is needed if and only if CAN_CTRLMODE_TDC_MANUAL is set
@@ -86,15 +94,23 @@ static int can_validate_tdc(struct nlattr *data_tdc,
 			return err;
 
 		if (tb_tdc[IFLA_CAN_TDC_TDCV]) {
-			if (tdc_auto)
+			if (tdc_auto) {
+				NL_SET_ERR_MSG(extack,
+					       "TDCV is incompatible with TDC auto mode");
 				return -EOPNOTSUPP;
+			}
 		} else {
-			if (tdc_manual)
+			if (tdc_manual) {
+				NL_SET_ERR_MSG(extack,
+					       "TDC manual mode requires TDCV");
 				return -EOPNOTSUPP;
+			}
 		}
 
-		if (!tb_tdc[IFLA_CAN_TDC_TDCO])
+		if (!tb_tdc[IFLA_CAN_TDC_TDCO]) {
+			NL_SET_ERR_MSG(extack, "TDCO is missing");
 			return -EOPNOTSUPP;
+		}
 	}
 
 	return 0;
@@ -105,6 +121,7 @@ static int can_validate_databittiming(struct nlattr *data[],
 				      int ifla_can_data_bittiming, u32 flags)
 {
 	struct nlattr *data_tdc;
+	const char *type;
 	u32 tdc_flags;
 	bool is_on;
 	int err;
@@ -120,18 +137,31 @@ static int can_validate_databittiming(struct nlattr *data[],
 		data_tdc = data[IFLA_CAN_TDC];
 		tdc_flags = flags & CAN_CTRLMODE_FD_TDC_MASK;
 		is_on = flags & CAN_CTRLMODE_FD;
+		type = "FD";
 	} else {
 		return -EOPNOTSUPP; /* Place holder for CAN XL */
 	}
 
 	if (is_on) {
-		if (!data[IFLA_CAN_BITTIMING] || !data[ifla_can_data_bittiming])
+		if (!data[IFLA_CAN_BITTIMING] || !data[ifla_can_data_bittiming]) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Provide both nominal and %s data bittiming",
+					   type);
 			return -EOPNOTSUPP;
-	}
-
-	if (data[ifla_can_data_bittiming] || data_tdc) {
-		if (!is_on)
+		}
+	} else {
+		if (data[ifla_can_data_bittiming]) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "%s data bittiming requires CAN %s",
+					   type, type);
 			return -EOPNOTSUPP;
+		}
+		if (data_tdc) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "%s TDC requires CAN %s",
+					   type, type);
+			return -EOPNOTSUPP;
+		}
 	}
 
 	err = can_validate_bittiming(data, extack, ifla_can_data_bittiming);
@@ -178,8 +208,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 {
 	struct can_priv *priv = netdev_priv(dev);
 	struct can_ctrlmode *cm;
-	u32 maskedflags;
-	u32 ctrlstatic;
+	u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing;
 
 	if (!data[IFLA_CAN_CTRLMODE])
 		return 0;
@@ -189,20 +218,28 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 		return -EBUSY;
 
 	cm = nla_data(data[IFLA_CAN_CTRLMODE]);
-	maskedflags = cm->flags & cm->mask;
 	ctrlstatic = can_get_static_ctrlmode(priv);
+	maskedflags = cm->flags & cm->mask;
+	notsupp = maskedflags & ~(priv->ctrlmode_supported | ctrlstatic);
+	ctrlstatic_missing = (maskedflags & ctrlstatic) ^ ctrlstatic;
 
-	/* check whether provided bits are allowed to be passed */
-	if (maskedflags & ~(priv->ctrlmode_supported | ctrlstatic))
+	if (notsupp) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "requested control mode %s not supported",
+				   can_get_ctrlmode_str(notsupp));
 		return -EOPNOTSUPP;
+	}
 
 	/* do not check for static fd-non-iso if 'fd' is disabled */
 	if (!(maskedflags & CAN_CTRLMODE_FD))
 		ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
 
-	/* make sure static options are provided by configuration */
-	if ((maskedflags & ctrlstatic) != ctrlstatic)
+	if (ctrlstatic_missing) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "missing required %s static control mode",
+				   can_get_ctrlmode_str(ctrlstatic_missing));
 		return -EOPNOTSUPP;
+	}
 
 	/* If a top dependency flag is provided, reset all its dependencies */
 	if (cm->mask & CAN_CTRLMODE_FD)
@@ -234,8 +271,10 @@ static int can_tdc_changelink(struct data_bittiming_params *dbt_params,
 	const struct can_tdc_const *tdc_const = dbt_params->tdc_const;
 	int err;
 
-	if (!tdc_const)
+	if (!tdc_const) {
+		NL_SET_ERR_MSG(extack, "The device does not support TDC");
 		return -EOPNOTSUPP;
+	}
 
 	err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX, nla,
 			       can_tdc_policy, extack);
@@ -450,8 +489,11 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		const unsigned int num_term = priv->termination_const_cnt;
 		unsigned int i;
 
-		if (!priv->do_set_termination)
+		if (!priv->do_set_termination) {
+			NL_SET_ERR_MSG(extack,
+				       "Termination is not configurable on this device");
 			return -EOPNOTSUPP;
+		}
 
 		/* check whether given value is supported by the interface */
 		for (i = 0; i < num_term; i++) {
-- 
2.51.0


