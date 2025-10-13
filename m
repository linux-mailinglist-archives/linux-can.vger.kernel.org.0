Return-Path: <linux-can+bounces-5157-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AB3BD2B17
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 13:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1973C472D
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 11:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8962F306490;
	Mon, 13 Oct 2025 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/Pb6ogZ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61989305E3E;
	Mon, 13 Oct 2025 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353343; cv=none; b=IlL/l5G4mET28yCbgV0BNjhhgg+xnCsLqbHEAXhauGHEB8TnbbMfRLQdnhfoZn4erzfgqeDFmFF29KYP4X0c4ySa+V4MOFOXSnWXehCAzxFsdSDTRvA1Hdi6Ufai2ip7a8uWdUdjm1MV1okjFvSkAk9ktCGXUbCMZbHPF6JvzLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353343; c=relaxed/simple;
	bh=Rg0WRegGJp200GiVP+CAtULnWY0ko3CKjuNVobkCRN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/uhn1jcemOrBCB0S1fMqBS5+MlTl89PfdcyjKIc1ystL0gORs4lwX60DFVb/EgL1MvTmUDk2EDEcp3Y8Y8vrg8kAoXsToMc3/fQeybhX/onieo2k2Cl8FDO+ipAxk/arsJ8bwG1kFP1ZGNsq5ZiVLwIChhmjN2duBjcjnXbzyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/Pb6ogZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC54C4CEF8;
	Mon, 13 Oct 2025 11:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760353341;
	bh=Rg0WRegGJp200GiVP+CAtULnWY0ko3CKjuNVobkCRN4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A/Pb6ogZe9dhMjDWCQUO59u6re5AW/407VjbuaC4jvxWPeQS1mhvyPMmWYHfGsH0J
	 Gpz4BDnxoGM7sKlHbmg3zVjTABFJxQul+W0YCsGSrvMGT5F0GQ6/MDzQbxu7OjoJ+5
	 /g+J0JQzk++tQeOzebV4CGFpaeR4cRNxgoUSoupibIRkMsIotKfJG8XOZ+B2iMtFhv
	 telJR7fh4Uj9cgCfies8Nw/SlI7arpTWh6qk7n++SwhLhibqNkHvsYURqQTDzLTVpo
	 XOq/ROmDqOZQ4LsQIaluL2SE4p0yF3Y0QLn82QIsP/REQ0AX5lV3jhr8KMSaEK6Qdi
	 0q9XJ4EVzcTKw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 13 Oct 2025 20:01:25 +0900
Subject: [PATCH 3/9] can: netlink: add initial CAN XL support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-canxl-netlink-v1-3-f422b7e2729f@kernel.org>
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
In-Reply-To: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14038; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=Rg0WRegGJp200GiVP+CAtULnWY0ko3CKjuNVobkCRN4=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlv7ijd/yE1W//3hKfbNi3W3DX7W1f7JZlO+9o90Yt+3
 j979/FU2Y5SFgYxLgZZMUWWZeWc3Aodhd5hh/5awsxhZQIZwsDFKQATUXnA8L/s9bN9NmZ/Oa6/
 2X+YveCn3sLVmxmn7J0rybjoS1ld0sRQRoYV3WUb/m8+t5U3eXedd6fnd27+xNkrstR97m6zX5d
 u8ooNAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

CAN XL uses bittiming parameters different from Classical CAN and CAN
FD. Thus, all the data bittiming parameters, including TDC, need to be
duplicated for CAN XL.

Add the CAN XL netlink interface for all the features which are common
with CAN FD. Any new CAN XL specific features are added later on.

Add a check that CAN XL capable nodes correctly provide
CAN_CTRLMODE_RESTRIC_OP as mandated by ISO 11898-1:2024 §6.6.19.

The first time CAN XL is activated, the MTU is set by default to
CANXL_MAX_MTU. The user may then configure a custom MTU within the
CANXL_MIN_MTU to CANXL_MIN_MTU range, in which case, the custom MTU
value will be kept as long as CAN XL remains active.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

RFC -> v1:

  - Correctly wipe out the CAN XL data bittiming and TDC parameters
    when switching CAN_CTRLMODE_XL off.

  - Add one level on nesting for xl parameters so that:

     - bittiming are under priv->xl.data_bittiming{,_const}¨
     - pwm are under priv->xl.pwm{,_const}

  - Many other code refactors.
---
 drivers/net/can/dev/dev.c        | 14 ++++++-
 drivers/net/can/dev/netlink.c    | 87 ++++++++++++++++++++++++++++++++--------
 include/linux/can/bittiming.h    |  6 ++-
 include/linux/can/dev.h          |  7 +++-
 include/uapi/linux/can/netlink.h |  7 ++++
 5 files changed, 100 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 3377afb6f1c4..32f11db88295 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -117,6 +117,12 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
 		return "fd-tdc-manual";
 	case CAN_CTRLMODE_RESTRICTED:
 		return "restricted-operation";
+	case CAN_CTRLMODE_XL:
+		return "xl";
+	case CAN_CTRLMODE_XL_TDC_AUTO:
+		return "xl-tdc-auto";
+	case CAN_CTRLMODE_XL_TDC_MANUAL:
+		return "xl-tdc-manual";
 	default:
 		return "<unknown>";
 	}
@@ -350,7 +356,13 @@ void can_set_default_mtu(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
 
-	if (priv->ctrlmode & CAN_CTRLMODE_FD) {
+	if (priv->ctrlmode & CAN_CTRLMODE_XL) {
+		if (can_is_canxl_dev_mtu(dev->mtu))
+			return;
+		dev->mtu = CANXL_MTU;
+		dev->min_mtu = CANXL_MIN_MTU;
+		dev->max_mtu = CANXL_MAX_MTU;
+	} else if (priv->ctrlmode & CAN_CTRLMODE_FD) {
 		dev->mtu = CANFD_MTU;
 		dev->min_mtu = CANFD_MTU;
 		dev->max_mtu = CANFD_MTU;
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index f44b5dffa176..2405f1265488 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -2,7 +2,7 @@
 /* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
  * Copyright (C) 2006 Andrey Volkov, Varma Electronics
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
- * Copyright (C) 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (C) 2021-2025 Vincent Mailhol <mailhol@kernel.org>
  */
 
 #include <linux/can/dev.h>
@@ -22,6 +22,9 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 	[IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
 	[IFLA_CAN_TDC] = { .type = NLA_NESTED },
 	[IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
+	[IFLA_CAN_XL_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
+	[IFLA_CAN_XL_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_XL_TDC] = { .type = NLA_NESTED },
 };
 
 static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
@@ -70,7 +73,7 @@ static int can_validate_tdc(struct nlattr *data_tdc,
 		return -EOPNOTSUPP;
 	}
 
-	/* If one of the CAN_CTRLMODE_TDC_* flag is set then TDC
+	/* If one of the CAN_CTRLMODE_{,XL}_TDC_* flags is set then TDC
 	 * must be set and vice-versa
 	 */
 	if ((tdc_auto || tdc_manual) && !data_tdc) {
@@ -82,8 +85,8 @@ static int can_validate_tdc(struct nlattr *data_tdc,
 		return -EOPNOTSUPP;
 	}
 
-	/* If providing TDC parameters, at least TDCO is needed. TDCV
-	 * is needed if and only if CAN_CTRLMODE_TDC_MANUAL is set
+	/* If providing TDC parameters, at least TDCO is needed. TDCV is
+	 * needed if and only if CAN_CTRLMODE_{,XL}_TDC_MANUAL is set
 	 */
 	if (data_tdc) {
 		struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
@@ -126,10 +129,10 @@ static int can_validate_databittiming(struct nlattr *data[],
 	bool is_on;
 	int err;
 
-	/* Make sure that valid CAN FD configurations always consist of
+	/* Make sure that valid CAN FD/XL configurations always consist of
 	 * - nominal/arbitration bittiming
 	 * - data bittiming
-	 * - control mode with CAN_CTRLMODE_FD set
+	 * - control mode with CAN_CTRLMODE_{FD,XL} set
 	 * - TDC parameters are coherent (details in can_validate_tdc())
 	 */
 
@@ -139,7 +142,10 @@ static int can_validate_databittiming(struct nlattr *data[],
 		is_on = flags & CAN_CTRLMODE_FD;
 		type = "FD";
 	} else {
-		return -EOPNOTSUPP; /* Place holder for CAN XL */
+		data_tdc = data[IFLA_CAN_XL_TDC];
+		tdc_flags = flags & CAN_CTRLMODE_XL_TDC_MASK;
+		is_on = flags & CAN_CTRLMODE_XL;
+		type = "XL";
 	}
 
 	if (is_on) {
@@ -206,6 +212,11 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	if (err)
 		return err;
 
+	err = can_validate_databittiming(data, extack,
+					 IFLA_CAN_XL_DATA_BITTIMING, flags);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -215,7 +226,8 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 {
 	struct can_priv *priv = netdev_priv(dev);
 	struct can_ctrlmode *cm;
-	u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing;
+	const u32 xl_mandatory = CAN_CTRLMODE_RESTRICTED;
+	u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing, xl_missing;
 
 	if (!data[IFLA_CAN_CTRLMODE])
 		return 0;
@@ -229,6 +241,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 	maskedflags = cm->flags & cm->mask;
 	notsupp = maskedflags & ~(priv->ctrlmode_supported | ctrlstatic);
 	ctrlstatic_missing = (maskedflags & ctrlstatic) ^ ctrlstatic;
+	xl_missing = (priv->ctrlmode_supported & xl_mandatory) ^ xl_mandatory;
 
 	if (notsupp) {
 		NL_SET_ERR_MSG_FMT(extack,
@@ -248,21 +261,36 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 		return -EOPNOTSUPP;
 	}
 
+	if ((priv->ctrlmode_supported & CAN_CTRLMODE_XL) && xl_missing) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "bad device: CAN XL capable nodes must support the %s mode",
+				   can_get_ctrlmode_str(xl_missing));
+		return -EOPNOTSUPP;
+	}
+
 	/* If a top dependency flag is provided, reset all its dependencies */
 	if (cm->mask & CAN_CTRLMODE_FD)
 		priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
+	if (cm->mask & CAN_CTRLMODE_XL)
+		priv->ctrlmode &= ~(CAN_CTRLMODE_XL_TDC_MASK);
 
 	/* clear bits to be modified and copy the flag values */
 	priv->ctrlmode &= ~cm->mask;
 	priv->ctrlmode |= maskedflags;
 
-	/* Wipe potential leftovers from previous CAN FD config */
+	/* Wipe potential leftovers from previous CAN FD/XL config */
 	if (!(priv->ctrlmode & CAN_CTRLMODE_FD)) {
 		memset(&priv->fd.data_bittiming, 0,
 		       sizeof(priv->fd.data_bittiming));
 		priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 		memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 	}
+	if (!(priv->ctrlmode & CAN_CTRLMODE_XL)) {
+		memset(&priv->xl.data_bittiming, 0,
+		       sizeof(priv->fd.data_bittiming));
+		priv->ctrlmode &= ~CAN_CTRLMODE_XL_TDC_MASK;
+		memset(&priv->xl.tdc, 0, sizeof(priv->xl.tdc));
+	}
 
 	can_set_default_mtu(dev);
 
@@ -337,7 +365,10 @@ static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
 		dbt_params = &priv->fd;
 		tdc_mask = CAN_CTRLMODE_FD_TDC_MASK;
 	} else {
-		return -EOPNOTSUPP; /* Place holder for CAN XL */
+		data_bittiming = data[IFLA_CAN_XL_DATA_BITTIMING];
+		data_tdc = data[IFLA_CAN_XL_TDC];
+		dbt_params = &priv->xl;
+		tdc_mask = CAN_CTRLMODE_XL_TDC_MASK;
 	}
 
 	if (!data_bittiming)
@@ -388,7 +419,7 @@ static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
 		 */
 		can_calc_tdco(&dbt_params->tdc, dbt_params->tdc_const, &dbt,
 			      tdc_mask, &priv->ctrlmode, priv->ctrlmode_supported);
-	} /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
+	} /* else: both CAN_CTRLMODE_{,XL}_TDC_{AUTO,MANUAL} are explicitly
 	   * turned off. TDC is disabled: do nothing
 	   */
 
@@ -491,6 +522,11 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (err)
 		return err;
 
+	/* CAN XL */
+	err = can_dbt_changelink(dev, data, false, extack);
+	if (err)
+		return err;
+
 	if (data[IFLA_CAN_TERMINATION]) {
 		const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
 		const unsigned int num_term = priv->termination_const_cnt;
@@ -558,14 +594,14 @@ static size_t can_data_bittiming_get_size(struct data_bittiming_params *dbt_para
 {
 	size_t size = 0;
 
-	if (dbt_params->data_bittiming.bitrate)		/* IFLA_CAN_DATA_BITTIMING */
+	if (dbt_params->data_bittiming.bitrate)		/* IFLA_CAN_{,XL}_DATA_BITTIMING */
 		size += nla_total_size(sizeof(dbt_params->data_bittiming));
-	if (dbt_params->data_bittiming_const)		/* IFLA_CAN_DATA_BITTIMING_CONST */
+	if (dbt_params->data_bittiming_const)		/* IFLA_CAN_{,XL}_DATA_BITTIMING_CONST */
 		size += nla_total_size(sizeof(*dbt_params->data_bittiming_const));
-	if (dbt_params->data_bitrate_const)		/* IFLA_CAN_DATA_BITRATE_CONST */
+	if (dbt_params->data_bitrate_const)		/* IFLA_CAN_{,XL}_DATA_BITRATE_CONST */
 		size += nla_total_size(sizeof(*dbt_params->data_bitrate_const) *
 				       dbt_params->data_bitrate_const_cnt);
-	size += can_tdc_get_size(dbt_params, tdc_flags);/* IFLA_CAN_TDC */
+	size += can_tdc_get_size(dbt_params, tdc_flags);/* IFLA_CAN_{,XL}_TDC */
 
 	return size;
 }
@@ -605,6 +641,9 @@ static size_t can_get_size(const struct net_device *dev)
 	size += can_data_bittiming_get_size(&priv->fd,
 					    priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 
+	size += can_data_bittiming_get_size(&priv->xl,
+					    priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MASK);
+
 	return size;
 }
 
@@ -649,7 +688,9 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev,
 		tdc_is_enabled = can_fd_tdc_is_enabled(priv);
 		tdc_manual = priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL;
 	} else {
-		return -EOPNOTSUPP; /* Place holder for CAN XL */
+		dbt_params = &priv->xl;
+		tdc_is_enabled = can_xl_tdc_is_enabled(priv);
+		tdc_manual = priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MANUAL;
 	}
 	tdc_const = dbt_params->tdc_const;
 	tdc = &dbt_params->tdc;
@@ -771,7 +812,19 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	    can_tdc_fill_info(skb, dev, IFLA_CAN_TDC) ||
 
-	    can_ctrlmode_ext_fill_info(skb, priv)
+	    can_ctrlmode_ext_fill_info(skb, priv) ||
+
+	    can_bittiming_fill_info(skb, IFLA_CAN_XL_DATA_BITTIMING,
+				    &priv->xl.data_bittiming) ||
+
+	    can_bittiming_const_fill_info(skb, IFLA_CAN_XL_DATA_BITTIMING_CONST,
+					  priv->xl.data_bittiming_const) ||
+
+	    can_bitrate_const_fill_info(skb, IFLA_CAN_XL_DATA_BITRATE_CONST,
+					priv->xl.data_bitrate_const,
+					priv->xl.data_bitrate_const_cnt) ||
+
+	    can_tdc_fill_info(skb, dev, IFLA_CAN_XL_TDC)
 	    )
 
 		return -EMSGSIZE;
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index d30816dd93c7..68d533bb7856 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -16,10 +16,12 @@
 
 #define CAN_CTRLMODE_FD_TDC_MASK				\
 	(CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMODE_TDC_MANUAL)
+#define CAN_CTRLMODE_XL_TDC_MASK				\
+	(CAN_CTRLMODE_XL_TDC_AUTO | CAN_CTRLMODE_XL_TDC_MANUAL)
 #define CAN_CTRLMODE_TDC_AUTO_MASK				\
-	(CAN_CTRLMODE_TDC_AUTO)
+	(CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMODE_XL_TDC_AUTO)
 #define CAN_CTRLMODE_TDC_MANUAL_MASK				\
-	(CAN_CTRLMODE_TDC_MANUAL)
+	(CAN_CTRLMODE_TDC_MANUAL | CAN_CTRLMODE_XL_TDC_MANUAL)
 
 /*
  * struct can_tdc - CAN FD Transmission Delay Compensation parameters
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 9de8fde3ec9d..945c16743702 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -47,7 +47,7 @@ struct can_priv {
 
 	const struct can_bittiming_const *bittiming_const;
 	struct can_bittiming bittiming;
-	struct data_bittiming_params fd;
+	struct data_bittiming_params fd, xl;
 	unsigned int bitrate_const_cnt;
 	const u32 *bitrate_const;
 	u32 bitrate_max;
@@ -85,6 +85,11 @@ static inline bool can_fd_tdc_is_enabled(const struct can_priv *priv)
 	return !!(priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 }
 
+static inline bool can_xl_tdc_is_enabled(const struct can_priv *priv)
+{
+	return !!(priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MASK);
+}
+
 static inline u32 can_get_static_ctrlmode(struct can_priv *priv)
 {
 	return priv->ctrlmode & ~priv->ctrlmode_supported;
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index fafd1cce4798..c2c96c5978a8 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -104,6 +104,9 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_TDC_AUTO		0x200	/* FD transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
 #define CAN_CTRLMODE_RESTRICTED		0x800	/* Restricted operation mode */
+#define CAN_CTRLMODE_XL			0x1000	/* CAN XL mode */
+#define CAN_CTRLMODE_XL_TDC_AUTO	0x2000	/* XL transceiver automatically calculates TDCV */
+#define CAN_CTRLMODE_XL_TDC_MANUAL	0x4000	/* XL TDCV is manually set up by user */
 
 /*
  * CAN device statistics
@@ -139,6 +142,10 @@ enum {
 	IFLA_CAN_BITRATE_MAX,
 	IFLA_CAN_TDC, /* FD */
 	IFLA_CAN_CTRLMODE_EXT,
+	IFLA_CAN_XL_DATA_BITTIMING,
+	IFLA_CAN_XL_DATA_BITTIMING_CONST,
+	IFLA_CAN_XL_DATA_BITRATE_CONST,
+	IFLA_CAN_XL_TDC,
 
 	/* add new constants above here */
 	__IFLA_CAN_MAX,

-- 
2.49.1


