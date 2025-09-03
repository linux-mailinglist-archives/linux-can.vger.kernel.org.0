Return-Path: <linux-can+bounces-4446-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A19BAB41956
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5FC3BA742
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB3A2FB610;
	Wed,  3 Sep 2025 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekjgf4hi"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF92FAC1E;
	Wed,  3 Sep 2025 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889553; cv=none; b=OlnybEu6ZSMKa3N86kku5cGbuJ+GK2PNE5yO1GlUcfIe8Xe2hKMq0c2aZSeeJQv3frCFm6mndMO2CbLI1vKAGCDvjfRTiMKkn4auZXaIWWfgpxQJTqnY4M/JY61kQbH+REPJpoVqHpiGHV6KaklaxbyYvaZ8/hGc18Gth+Xtt7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889553; c=relaxed/simple;
	bh=+0t4xaF4YQWKUKq5oT/NXwwt6M4dMUzezfpU6070hs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZpBslYEnEgdZ+QJAQ47dNAcH0cNXFRVeax7ggqTb+Pdgh+90ZB2nLb1lHtvgbCdNF0OC1FMdSxIsDAoM0zB4JC57ctuKmvnQWqK9My9+Cv0FQQ70H8TJLA+JUPMRjazGDXZu50btuk/kgh+TqA7AINRRtt7/NMFGUd8OEnbtKFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekjgf4hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758ABC4CEF5;
	Wed,  3 Sep 2025 08:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889552;
	bh=+0t4xaF4YQWKUKq5oT/NXwwt6M4dMUzezfpU6070hs0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ekjgf4hiIitzsM8p8Y3R8SGF+e4hpG+ZFwa5b3TGSYgJuHJFVCKLOhkdVvaOtrs4V
	 RXc9Dem0zcblgutxa+K/8brJvVRafKM/7DqambCp6jXCex/xhXSRFCHWmdK+Yr0nQz
	 kWYhEIVf74+bfOD5J84kICPj3I9sJX84gp/glm5eT5M1IhljYJLLRlYunCuoaP3w5Y
	 c7pbs9AvPZ4mfoxO0+rPh32O6t8LevH6tGd3GIZhYR0og49rohc/djZgdj+JG5WhJA
	 1eqSaNvOdqrGlFyS0MnqsMorEdF5JCAYI0Cik6ktJ4gi5M1KycZrnueLUF4/YZbrZO
	 6U0kwaROMfnmw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:20 +0900
Subject: [PATCH 21/21] can: netlink: add userland error messages
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-21-904bd6037cd9@kernel.org>
References: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
In-Reply-To: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6019; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=+0t4xaF4YQWKUKq5oT/NXwwt6M4dMUzezfpU6070hs0=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GFdbfbwi9MHBy6Fc4brlibdPZJs7vy85GBNX3MjJ4
 +kY1WrXUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCIBhQz/IzvYuWUNPz/kT1ub
 k1h7YV/UdMXFl8Ufd9ssXOVgkJPAxcgw4fTCVDaFbLG/6+3f/jjbNeMcc3NG/poOyyMdbJsZcmu
 YAQ==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Use NL_SET_ERR_MSG() and NL_SET_ERR_MSG_FMT() to return meaningful
error messages to the userland whenever a -EOPNOTSUPP error is
returned due to a failed validation of the CAN netlink arguments.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 82 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index d1c54c7dd333d229f03fc653d61a21a48f8c8865..f39f6310312aa404e025fb7ff11e483a3d9f9f20 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -63,15 +63,23 @@ static int can_validate_tdc(struct nlattr *data_tdc,
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
@@ -85,15 +93,23 @@ static int can_validate_tdc(struct nlattr *data_tdc,
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
@@ -104,6 +120,7 @@ static int can_validate_databittiming(struct nlattr *data[],
 				      int ifla_can_data_bittiming, u32 flags)
 {
 	struct nlattr *data_tdc;
+	const char *type;
 	u32 tdc_flags;
 	bool is_on;
 	int err;
@@ -112,18 +129,31 @@ static int can_validate_databittiming(struct nlattr *data[],
 		data_tdc = data[IFLA_CAN_TDC];
 		tdc_flags = flags & CAN_CTRLMODE_FD_TDC_MASK;
 		is_on = flags & CAN_CTRLMODE_FD;
+		type = "FD";
 	} else {
 		WARN_ON(1); /* Place holder for CAN XL */
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
@@ -170,8 +200,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 {
 	struct can_priv *priv = netdev_priv(dev);
 	struct can_ctrlmode *cm;
-	u32 maskedflags;
-	u32 ctrlstatic;
+	u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing;
 
 	if (!data[IFLA_CAN_CTRLMODE])
 		return 0;
@@ -181,20 +210,28 @@ static int can_ctrlmode_changelink(struct net_device *dev,
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
@@ -227,8 +264,10 @@ static int can_tdc_changelink(struct data_bittiming_params *dbt_params,
 	const struct can_tdc_const *tdc_const = dbt_params->tdc_const;
 	int err;
 
-	if (!tdc_const)
+	if (!tdc_const) {
+		NL_SET_ERR_MSG(extack, "The device does not support TDC");
 		return -EOPNOTSUPP;
+	}
 
 	err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX, nla,
 			       can_tdc_policy, extack);
@@ -443,8 +482,11 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
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
2.49.1


