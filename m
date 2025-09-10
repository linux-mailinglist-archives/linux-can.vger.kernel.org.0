Return-Path: <linux-can+bounces-4619-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C80B50DCE
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F1B1C2570F
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADF330E0F9;
	Wed, 10 Sep 2025 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPd7Q+5s"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69F630E0ED;
	Wed, 10 Sep 2025 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484317; cv=none; b=Qzl1fn77vvH/FnJH1dRvfuxDxFgGaXepj6bghd58xcuDJhGxF0z/lZzTzagNOjuA5uh+zQPRjt0CVjON2EJUjZwL8LeEOCHrqSgejkffInH4f0x1OTISgmch1euR0xzsbJVWz0FXh3qIWq7PcJN2GL73u5pd1b4dk65Q40F3LtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484317; c=relaxed/simple;
	bh=7jkGwc8sJb5bE4Z0FuNn78xdbtlCemUTIWLBt8xL5Ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pl/NciGXP0vuCmHgMfkRfeV7gDS24nmvcrun3pphbgdlinBqVA9Hm5mZ1ag1X7oem4uJhAP2sUYtAsxN1cBfF2IU7o6yHnupQQi5iypiB8aVpO67Pp5FqtOHFRKzmcPLrITkZiDQtJwX+FXfzS+2PswE8Lwpk0szMSR+HFEMLrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPd7Q+5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ADFC4CEFA;
	Wed, 10 Sep 2025 06:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484317;
	bh=7jkGwc8sJb5bE4Z0FuNn78xdbtlCemUTIWLBt8xL5Ps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fPd7Q+5sguJgA6pWJDPefhJ173WiMI3vpAEGMaCwsn3hYsjkt8hh+mmruxtgAJD6Q
	 +e37IbDxB6Rj6YhAqKqc66ldOVSPbw+ww+k2g1wemvCygR3UXcCAZ5E2OHHJDvVO89
	 eJfCa7MFBFO2vrizaxJmj2JxGOTA75txbga4WYELDlqCkVEXVC6+e/+d4iuJ/rmA4Q
	 3hjf8WcO+6zS3c+0r4y01lN4qnwKSbb9H1vWN299Mo75qYMULUc9ATqUAWOustxoZD
	 SdrhhErC237jwLbiC3DOwcLjrzW3JZqNHo68MFHWw8Q1kZctg7IMiMlaiEhOh3J+WO
	 w0xHtAOX0ihpw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:45 +0900
Subject: [PATCH v2 20/20] can: netlink: add userland error messages
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-20-f128d4083721@kernel.org>
References: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
In-Reply-To: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6027; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=7jkGwc8sJb5bE4Z0FuNn78xdbtlCemUTIWLBt8xL5Ps=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRX49EJB6vOvW676kA7u/yjW/sK1uUF9cEvT5ouJH1
 W1HHfg/dJSyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZhIxjtGht2yfGfsIxxj3k6Q
 dnaKmplcHvv30onEo5YzZqizaZlPW8nwP29WnfJ9PYkoodMTVnCX/frrpuOv6lHNFbfgaJzCdQd
 7fgA=
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
index 48a74808dbc881d1d46ff7d03d347ddb8af3d16c..d4f13701e719ca52e41188c7e6d989d00bc70073 100644
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
@@ -119,18 +136,31 @@ static int can_validate_databittiming(struct nlattr *data[],
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
@@ -177,8 +207,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 {
 	struct can_priv *priv = netdev_priv(dev);
 	struct can_ctrlmode *cm;
-	u32 maskedflags;
-	u32 ctrlstatic;
+	u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing;
 
 	if (!data[IFLA_CAN_CTRLMODE])
 		return 0;
@@ -188,20 +217,28 @@ static int can_ctrlmode_changelink(struct net_device *dev,
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
2.49.1


