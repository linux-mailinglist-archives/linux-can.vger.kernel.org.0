Return-Path: <linux-can+bounces-2290-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F249DF55D
	for <lists+linux-can@lfdr.de>; Sun,  1 Dec 2024 12:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4988E281176
	for <lists+linux-can@lfdr.de>; Sun,  1 Dec 2024 11:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A578A78685;
	Sun,  1 Dec 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="U+QerlYc";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="3Af+O74a"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595554087C
	for <linux-can@vger.kernel.org>; Sun,  1 Dec 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733052202; cv=pass; b=pjdYJfPnhyJsxXBTl1SLoBfzY9jdvE6ejMetRWTsGXu5aMAeBYnB0kUQ+m8pBrbqzQDsojRvg6MDNdP65wjkefeIlVET6g9Khn2qi0a31lAokUCcCBW/xSLTDGuh7Bq4jLkuLhOJKDHEQ1jECyInIZ1IuDh+ke2wWY52GwIkv1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733052202; c=relaxed/simple;
	bh=f/32SZM9USMrgD8w1MZdrTzzcNGYsKg94ltN5Kmstf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TJnaU5XWNuEz/KrGcZezrvWdonWdqVx4+84lkZDSzcCBjppPzbk/kvCrExRErc9lH92f2JPLJppPQf6XZ5U9xFWYKZKBFsIJoyjw8zLM+LlexIQXw1tvy+RZXA1rbqaDVnHnzcJj+JcOdA2vtqTw0m3fjAVT3MfHM1tA6oKpBJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=U+QerlYc; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=3Af+O74a; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1733052196; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XpZInYWMuwPoYuMYlPLEge4MzfieyslszpSq5DJ72QEH0sieCb7T8eRz+HFvBSgpTY
    iRZT0aqsJScjAAVpcFk6LhrA4W68dtml5dkEROKgck2W11lBrQxWy71CSmlZY/qIcxay
    bahpj5VWm8bYjE6iiooCu3zlwvWhltEv3dH3HvSxRpJ+cVPL+LTFuKzq/ED66UHCi+2L
    8ERuomjDrJfz9C+TATYcJvUhjHFcaC/RJ9qlmWkKNms6WKy0AQhwPGk6Tl46wppRQ9pn
    yf98+vjGnHHK0IUrPd/2fUltMGr4YXgNQZCnDbg1qmgDqa93hIAI14Rjamcxpx3fA/XL
    Kf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733052196;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ldu+8qhCVdr060wg4R/yBHdrG/+CJ9YX4W2oouhYGbo=;
    b=O32cykI/CUKfzz8Ku8/Wb0pMW3rueCK5yAsb94lV+q2NO6DGdkUHbhOkk5LfQ++97v
    su3N+Dgd3xrfur8Tb24OWbVKjqSFcrFHw9WCN3VTxXxTMpy6oc91vFBd9T+2e1Fn3dSj
    D7/upym/3PPk+yHB6VbeSPuRmFOIZGFAzUGTqIMtbrTRp5kRftzdF7bE/qElwIZ5GOhP
    iLnIn3ckVXloEpRDHzsS3MU2wfMLyF9McmAk3QABf/jnaj8UzeV1MZoyhUuqxblonR95
    i+QLsQ34GnVR94z/LuD/dziivbSvWDh94MLMDU12z0kC3syF5SnAxB6Vj18YZmOGc3zc
    5JZA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733052196;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ldu+8qhCVdr060wg4R/yBHdrG/+CJ9YX4W2oouhYGbo=;
    b=U+QerlYcgEZ4M9Qna2KP9yWqFX0+whyB0ACMTEXIDpEksdmwtG/dDaJu3VPGZKdtrH
    LPXJDeuG31WIpKGq/NjlJ0z7lk3sNA9tuFERIIzgPQcUx3W3+poT1LrjtdhUI+Io+hCv
    VDY/twrkk1YSDsM4ZsKc58GZpKAxtog/NHkx8Z3YJheHSaA8qoPZT+KXSLNAl2PmHxcM
    0emIFMm048tbuG7EjBU1Fz9IknWLEsrstLbBBdbxjpTVpEAwR9skDFQe9cgh/KJeZS/I
    1PdtWrAnLG6+8Dz2LeTAKrzrqZjs94Lqh0DhJvTYa3oH3XXM19107tJFA+DkXqf7+Zuo
    arhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733052195;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ldu+8qhCVdr060wg4R/yBHdrG/+CJ9YX4W2oouhYGbo=;
    b=3Af+O74aj0p7TRbcD+UcCCJv2o3/z2vPdjQ6LMFcblcN25aCyZm3a+i4cTi0r91QGX
    mEJHsMNSObk0DWc9jpCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSXVT6pap5"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id K63ada0B1BNFgXD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 1 Dec 2024 12:23:15 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH 1/2] add CAN XL support RFC based on Vicents cleanups
Date: Sun,  1 Dec 2024 12:22:29 +0100
Message-ID: <20241201112230.6917-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Fixes from Oliver:
- add can_validate_tdc(data[IFLA_CAN_XL_TDC], ..) in can_validate()
- fix nested can_tdc_fill_info() to support CAN XL too
- fix copy/paste issue in CAN_CTRLMODE_XL_TDC_ definitions

Based on the CAN XL preparations patch set
"can: netlink: preparation before introduction of CAN XL"
at
https://lore.kernel.org/linux-can/20241112165118.586613-7-mailhol.vincent@wanadoo.fr/T/#t

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/netlink.c    | 392 +++++++++++++++++++++----------
 drivers/net/can/xilinx_can.c     |  12 +-
 include/linux/can/bittiming.h    |   2 +
 include/linux/can/dev.h          |  13 +-
 include/uapi/linux/can/netlink.h |  21 +-
 5 files changed, 296 insertions(+), 144 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index f346b4208f1c..64f675e874f6 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -20,10 +20,13 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 	[IFLA_CAN_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
 	[IFLA_CAN_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
 	[IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
 	[IFLA_CAN_TDC] = { .type = NLA_NESTED },
 	[IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
+	[IFLA_CAN_XL_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
+	[IFLA_CAN_XL_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_XL_TDC] = { .type = NLA_NESTED },
 };
 
 static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
 	[IFLA_CAN_TDC_TDCV_MIN] = { .type = NLA_U32 },
 	[IFLA_CAN_TDC_TDCV_MAX] = { .type = NLA_U32 },
@@ -47,14 +50,60 @@ static int can_validate_bittiming(const struct can_bittiming *bt,
 	}
 
 	return 0;
 }
 
+static int can_validate_tdc(struct nlattr *data_tdc,
+			    bool tdc_auto, bool tdc_manual,
+			    struct netlink_ext_ack *extack)
+{
+	int err;
+
+	/* TDC is optional */
+	if (!data_tdc)
+		return 0;
+
+	/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive */
+	if (tdc_auto == tdc_manual)
+		return -EOPNOTSUPP;
+
+	/* If one of the CAN_CTRLMODE_TDC_* flag is set then
+	 * TDC must be set and vice-versa
+	 */
+	if ((tdc_auto || tdc_manual) != !!data_tdc)
+		return -EOPNOTSUPP;
+
+	/* If providing TDC parameters, at least TDCO is needed. TDCV
+	 * is needed if and only if CAN_CTRLMODE_TDC_MANUAL is set
+	 */
+	if (!data_tdc) {
+		struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
+
+		err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX,
+				       data_tdc, can_tdc_policy, extack);
+		if (err)
+			return err;
+
+		if (tb_tdc[IFLA_CAN_TDC_TDCV]) {
+			if (tdc_auto)
+				return -EOPNOTSUPP;
+		} else {
+			if (tdc_manual)
+				return -EOPNOTSUPP;
+		}
+
+		if (!tb_tdc[IFLA_CAN_TDC_TDCO])
+			return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
-	bool is_can_fd = false;
+	bool is_can_fd = false, is_can_xl = false;
 	int err;
 
 	/* Make sure that valid CAN FD configurations always consist of
 	 * - nominal/arbitration bittiming
 	 * - data bittiming
@@ -65,88 +114,112 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	if (!data)
 		return 0;
 
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
-		u32 tdc_flags = cm->flags & CAN_CTRLMODE_FD_TDC_MASK;
 
 		is_can_fd = cm->flags & cm->mask & CAN_CTRLMODE_FD;
+		is_can_xl = cm->flags & cm->mask & CAN_CTRLMODE_XL;
 
-		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive */
-		if (tdc_flags == CAN_CTRLMODE_FD_TDC_MASK)
-			return -EOPNOTSUPP;
-		/* If one of the CAN_CTRLMODE_TDC_* flag is set then
-		 * TDC must be set and vice-versa
-		 */
-		if (!!tdc_flags != !!data[IFLA_CAN_TDC])
-			return -EOPNOTSUPP;
-		/* If providing TDC parameters, at least TDCO is
-		 * needed. TDCV is needed if and only if
-		 * CAN_CTRLMODE_TDC_MANUAL is set
-		 */
-		if (data[IFLA_CAN_TDC]) {
-			struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
-
-			err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX,
-					       data[IFLA_CAN_TDC],
-					       can_tdc_policy, extack);
-			if (err)
-				return err;
-
-			if (tb_tdc[IFLA_CAN_TDC_TDCV]) {
-				if (tdc_flags & CAN_CTRLMODE_TDC_AUTO)
-					return -EOPNOTSUPP;
-			} else {
-				if (tdc_flags & CAN_CTRLMODE_TDC_MANUAL)
-					return -EOPNOTSUPP;
-			}
-
-			if (!tb_tdc[IFLA_CAN_TDC_TDCO])
-				return -EOPNOTSUPP;
+		err = can_validate_tdc(data[IFLA_CAN_TDC],
+				       cm->flags & CAN_CTRLMODE_TDC_AUTO,
+				       cm->flags & CAN_CTRLMODE_TDC_MANUAL,
+				       extack);
+		if (err) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "TDC parameters are incorrect");
+			return err;
+		}
+		err = can_validate_tdc(data[IFLA_CAN_XL_TDC],
+				       cm->flags & CAN_CTRLMODE_XL_TDC_AUTO,
+				       cm->flags & CAN_CTRLMODE_XL_TDC_MANUAL,
+				       extack);
+		if (err) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "XL TDC parameters are incorrect");
+			return err;
 		}
 	}
 
 	if (data[IFLA_CAN_BITTIMING]) {
 		struct can_bittiming bt;
 
 		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
 		err = can_validate_bittiming(&bt, extack);
-		if (err)
+		if (err) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Nominal bittiming parameters are incorrect");
 			return err;
+		}
 	}
 
 	if (is_can_fd) {
-		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING])
+		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING]) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Provide both nominal and FD data bittiming");
+			return -EOPNOTSUPP;
+		}
+	}
+	if (is_can_xl) {
+		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_XL_DATA_BITTIMING]) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Provide both nominal and XL data bittiming");
 			return -EOPNOTSUPP;
+		}
 	}
 
 	if (data[IFLA_CAN_DATA_BITTIMING] || data[IFLA_CAN_TDC]) {
-		if (!is_can_fd)
+		if (!is_can_fd) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "CAN FD is required to use FD data bittiming or FD TDC");
+			return -EOPNOTSUPP;
+		}
+	}
+	if (data[IFLA_CAN_XL_DATA_BITTIMING] || data[IFLA_CAN_XL_TDC]) {
+		if (!is_can_xl) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "CAN XL is required to use XL data bittiming or XL TDC");
 			return -EOPNOTSUPP;
+		}
 	}
 
 	if (data[IFLA_CAN_DATA_BITTIMING]) {
 		struct can_bittiming bt;
 
 		memcpy(&bt, nla_data(data[IFLA_CAN_DATA_BITTIMING]), sizeof(bt));
 		err = can_validate_bittiming(&bt, extack);
-		if (err)
+		if (err) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "FD data bittiming parameters are incorrect");
 			return err;
+		}
+	}
+	if (data[IFLA_CAN_XL_DATA_BITTIMING]) {
+		struct can_bittiming bt;
+
+		memcpy(&bt, nla_data(data[IFLA_CAN_XL_DATA_BITTIMING]), sizeof(bt));
+		err = can_validate_bittiming(&bt, extack);
+		if (err) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "FD data bittiming parameters are incorrect");
+			return err;
+		}
 	}
 
 	return 0;
 }
 
-static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
+static int can_tdc_changelink(struct data_bittiming_params *dbt_params,
+			      bool tdc_is_enabled, const struct nlattr *nla,
 			      struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
 	struct can_tdc tdc = { 0 };
-	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
+	const struct can_tdc_const *tdc_const = dbt_params->tdc_const;
 	int err;
 
-	if (!tdc_const || !can_fd_tdc_is_enabled(priv))
+	if (!tdc_const || !tdc_is_enabled)
 		return -EOPNOTSUPP;
 
 	err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX, nla,
 			       can_tdc_policy, extack);
 	if (err)
@@ -177,21 +250,92 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 			return -EINVAL;
 
 		tdc.tdcf = tdcf;
 	}
 
-	priv->fd.tdc = tdc;
+	dbt_params->tdc = tdc;
+
+	return 0;
+}
+
+static int can_dbt_changelink(struct net_device *dev,
+			      struct nlattr *data_databittiming,
+			      struct data_bittiming_params *dbt_params,
+			      struct nlattr *data_tdc, bool tdc_flags_provided,
+			      bool tdc_is_enabled, u32 tdc_mask,
+			      struct netlink_ext_ack *extack)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	struct can_bittiming dbt;
+	int err;
+
+	if (!data_databittiming)
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
+	memcpy(&dbt, nla_data(data_databittiming), sizeof(dbt));
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
+	if (data_tdc) {
+		/* TDC parameters are provided: use them */
+		err = can_tdc_changelink(dbt_params, tdc_is_enabled, data_tdc,
+					 extack);
+		if (err) {
+			priv->ctrlmode &= ~tdc_mask;
+			return err;
+		}
+	} else if (!tdc_flags_provided) {
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
 
 	return 0;
 }
 
 static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			  struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
+	bool fd_tdc_flag_provided = false, xl_tdc_flag_provided = false;
 	struct can_priv *priv = netdev_priv(dev);
-	bool fd_tdc_flag_provided = false;
 	int err;
 
 	/* We need synchronization with dev->stop() */
 	ASSERT_RTNL();
 
@@ -221,27 +365,32 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 
 		/* clear bits to be modified and copy the flag values */
 		priv->ctrlmode &= ~cm->mask;
 		priv->ctrlmode |= maskedflags;
 
-		/* CAN_CTRLMODE_FD can only be set when driver supports FD */
-		if (priv->ctrlmode & CAN_CTRLMODE_FD) {
+		/* CAN_CTRLMODE_{FD,XL} can only be set when driver supports FD/XL */
+		if (priv->ctrlmode & CAN_CTRLMODE_XL) {
+			dev->mtu = CANXL_MAX_MTU;
+		} else if (priv->ctrlmode & CAN_CTRLMODE_FD) {
 			dev->mtu = CANFD_MTU;
 		} else {
 			dev->mtu = CAN_MTU;
 			memset(&priv->fd.data_bittiming, 0,
 			       sizeof(priv->fd.data_bittiming));
 			priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 			memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 		}
 
 		fd_tdc_flag_provided = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
-		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually
+		xl_tdc_flag_provided = cm->mask & CAN_CTRLMODE_XL_TDC_MASK;
+		/* CAN_CTRLMODE_(XL_)TDC_{AUTO,MANUAL} are mutually
 		 * exclusive: make sure to turn the other one off
 		 */
 		if (fd_tdc_flag_provided)
 			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_FD_TDC_MASK;
+		if (xl_tdc_flag_provided)
+			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_XL_TDC_MASK;
 	}
 
 	if (data[IFLA_CAN_BITTIMING]) {
 		struct can_bittiming bt;
 
@@ -298,71 +447,26 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		err = can_restart_now(dev);
 		if (err)
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
+	/* CAN FD */
+	err = can_dbt_changelink(dev, data[IFLA_CAN_DATA_BITTIMING], &priv->fd,
+				 data[IFLA_CAN_TDC], fd_tdc_flag_provided,
+				 can_fd_tdc_is_enabled(priv),
+				 CAN_CTRLMODE_FD_TDC_MASK, extack);
+	if (err)
+		return err;
 
-		memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
-		if (data[IFLA_CAN_TDC]) {
-			/* TDC parameters are provided: use them */
-			err = can_tdc_changelink(priv, data[IFLA_CAN_TDC],
-						 extack);
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
+	/* CAN XL */
+	err = can_dbt_changelink(dev,
+				 data[IFLA_CAN_XL_DATA_BITTIMING], &priv->xl,
+				 data[IFLA_CAN_XL_TDC], xl_tdc_flag_provided,
+				 can_xl_tdc_is_enabled(priv),
+				 CAN_CTRLMODE_XL_TDC_MASK, extack);
+	if (err)
+		return err;
 
 	if (data[IFLA_CAN_TERMINATION]) {
 		const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
 		const unsigned int num_term = priv->termination_const_cnt;
 		unsigned int i;
@@ -387,36 +491,35 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 
 	return 0;
 }
 
-static size_t can_tdc_get_size(const struct net_device *dev)
+static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
+			       bool tdc_is_enabled, bool tdc_manual)
 {
-	struct can_priv *priv = netdev_priv(dev);
 	size_t size;
 
-	if (!priv->fd.tdc_const)
+	if (!dbt_params->tdc_const)
 		return 0;
 
 	size = nla_total_size(0);			/* nest IFLA_CAN_TDC */
-	if (priv->ctrlmode_supported & CAN_CTRLMODE_TDC_MANUAL) {
+	if (tdc_manual) {
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV_MIN */
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV_MAX */
 	}
 	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO_MIN */
 	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO_MAX */
-	if (priv->fd.tdc_const->tdcf_max) {
+	if (dbt_params->tdc_const->tdcf_max) {
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF_MIN */
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF_MAX */
 	}
 
-	if (can_fd_tdc_is_enabled(priv)) {
-		if (priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL ||
-		    priv->fd.do_get_auto_tdcv)
+	if (tdc_is_enabled) {
+		if (tdc_manual || dbt_params->do_get_auto_tdcv)
 			size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV */
 		size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO */
-		if (priv->fd.tdc_const->tdcf_max)
+		if (dbt_params->tdc_const->tdcf_max)
 			size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF */
 	}
 
 	return size;
 }
@@ -456,31 +559,45 @@ static size_t can_get_size(const struct net_device *dev)
 				       priv->bitrate_const_cnt);
 	if (priv->fd.data_bitrate_const)			/* IFLA_CAN_DATA_BITRATE_CONST */
 		size += nla_total_size(sizeof(*priv->fd.data_bitrate_const) *
 				       priv->fd.data_bitrate_const_cnt);
 	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
-	size += can_tdc_get_size(dev);				/* IFLA_CAN_TDC */
+	size += can_tdc_get_size(&priv->fd,			/* IFLA_CAN_TDC */
+				 can_fd_tdc_is_enabled(priv),
+				 priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL);
 	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
+	if (priv->xl.data_bittiming.bitrate)			/* IFLA_CAN_XL_DATA_BITTIMING */
+		size += nla_total_size(sizeof(struct can_bittiming));
+	if (priv->xl.data_bittiming_const)			/* IFLA_CAN_XL_DATA_BITTIMING_CONST */
+		size += nla_total_size(sizeof(struct can_bittiming_const));
+	if (priv->xl.data_bitrate_const)			/* IFLA_CAN_DATA_BITRATE_CONST */
+		size += nla_total_size(sizeof(*priv->xl.data_bitrate_const) *
+				       priv->xl.data_bitrate_const_cnt);
+	size += can_tdc_get_size(&priv->xl,			/* IFLA_CAN_XL_TDC */
+				 can_xl_tdc_is_enabled(priv),
+				 priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MANUAL);
 
 	return size;
 }
 
-static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
+static int can_tdc_fill_info(struct sk_buff *skb,  const struct net_device *dev,
+			     struct data_bittiming_params *dbt_params,
+			     bool tdc_is_enabled, bool tdc_manual,
+			     int ifla_can_tdc_type)
 {
 	struct nlattr *nest;
-	struct can_priv *priv = netdev_priv(dev);
-	struct can_tdc *tdc = &priv->fd.tdc;
-	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
+	struct can_tdc *tdc = &dbt_params->tdc;
+	const struct can_tdc_const *tdc_const = dbt_params->tdc_const;
 
 	if (!tdc_const)
 		return 0;
 
-	nest = nla_nest_start(skb, IFLA_CAN_TDC);
+	nest = nla_nest_start(skb, ifla_can_tdc_type);
 	if (!nest)
 		return -EMSGSIZE;
 
-	if (priv->ctrlmode_supported & CAN_CTRLMODE_TDC_MANUAL &&
+	if (tdc_manual &&
 	    (nla_put_u32(skb, IFLA_CAN_TDC_TDCV_MIN, tdc_const->tdcv_min) ||
 	     nla_put_u32(skb, IFLA_CAN_TDC_TDCV_MAX, tdc_const->tdcv_max)))
 		goto err_cancel;
 	if (nla_put_u32(skb, IFLA_CAN_TDC_TDCO_MIN, tdc_const->tdco_min) ||
 	    nla_put_u32(skb, IFLA_CAN_TDC_TDCO_MAX, tdc_const->tdco_max))
@@ -488,19 +605,19 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (tdc_const->tdcf_max &&
 	    (nla_put_u32(skb, IFLA_CAN_TDC_TDCF_MIN, tdc_const->tdcf_min) ||
 	     nla_put_u32(skb, IFLA_CAN_TDC_TDCF_MAX, tdc_const->tdcf_max)))
 		goto err_cancel;
 
-	if (can_fd_tdc_is_enabled(priv)) {
+	if (tdc_is_enabled) {
 		u32 tdcv;
 		int err = -EINVAL;
 
-		if (priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL) {
+		if (tdc_manual) {
 			tdcv = tdc->tdcv;
 			err = 0;
-		} else if (priv->fd.do_get_auto_tdcv) {
-			err = priv->fd.do_get_auto_tdcv(dev, &tdcv);
+		} else if (dbt_params->do_get_auto_tdcv) {
+			err = dbt_params->do_get_auto_tdcv(dev, &tdcv);
 		}
 		if (!err && nla_put_u32(skb, IFLA_CAN_TDC_TDCV, tdcv))
 			goto err_cancel;
 		if (nla_put_u32(skb, IFLA_CAN_TDC_TDCO, tdc->tdco))
 			goto err_cancel;
@@ -594,13 +711,34 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	    (nla_put(skb, IFLA_CAN_BITRATE_MAX,
 		     sizeof(priv->bitrate_max),
 		     &priv->bitrate_max)) ||
 
-	    can_tdc_fill_info(skb, dev) ||
+	    can_tdc_fill_info(skb, dev, &priv->fd, can_fd_tdc_is_enabled(priv),
+			      priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL,
+			      IFLA_CAN_TDC) ||
+
+	    can_ctrlmode_ext_fill_info(skb, priv) ||
+
+	    (priv->xl.data_bittiming.bitrate &&
+	     nla_put(skb, IFLA_CAN_XL_DATA_BITTIMING,
+		     sizeof(priv->xl.data_bittiming), &priv->xl.data_bittiming)) ||
+
+	    (priv->xl.data_bittiming_const &&
+	     nla_put(skb, IFLA_CAN_XL_DATA_BITTIMING_CONST,
+		     sizeof(*priv->xl.data_bittiming_const),
+		     priv->xl.data_bittiming_const)) ||
+
+	    (priv->xl.data_bitrate_const &&
+	     nla_put(skb, IFLA_CAN_XL_DATA_BITRATE_CONST,
+		     sizeof(*priv->xl.data_bitrate_const) *
+		     priv->xl.data_bitrate_const_cnt,
+		     priv->xl.data_bitrate_const)) ||
 
-	    can_ctrlmode_ext_fill_info(skb, priv)
+	    can_tdc_fill_info(skb, dev, &priv->xl, can_xl_tdc_is_enabled(priv),
+			      priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MANUAL,
+			      IFLA_CAN_XL_TDC)
 	    )
 
 		return -EMSGSIZE;
 
 	return 0;
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 81baec8eb1e5..3bd861d5b8ac 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -513,16 +513,16 @@ static int xcan_set_bittiming(struct net_device *ndev)
 
 	if (priv->devtype.cantype == XAXI_CANFD ||
 	    priv->devtype.cantype == XAXI_CANFD_2_0) {
 		/* Setting Baud Rate prescaler value in F_BRPR Register */
 		btr0 = dbt->brp - 1;
-		if (can_fd_tdc_is_enabled(&priv->can)) {
+		if (can_tdc_is_enabled(&priv->can)) {
 			if (priv->devtype.cantype == XAXI_CANFD)
-				btr0 |= FIELD_PREP(XCAN_BRPR_TDCO_MASK, priv->can.fd.tdc.tdco) |
+				btr0 |= FIELD_PREP(XCAN_BRPR_TDCO_MASK, priv->can.tdc.tdco) |
 					XCAN_BRPR_TDC_ENABLE;
 			else
-				btr0 |= FIELD_PREP(XCAN_2_BRPR_TDCO_MASK, priv->can.fd.tdc.tdco) |
+				btr0 |= FIELD_PREP(XCAN_2_BRPR_TDCO_MASK, priv->can.tdc.tdco) |
 					XCAN_BRPR_TDC_ENABLE;
 		}
 
 		/* Setting Time Segment 1 in BTR Register */
 		btr1 = dbt->prop_seg + dbt->phase_seg1 - 1;
@@ -1967,24 +1967,24 @@ static int xcan_probe(struct platform_device *pdev)
 		goto err_free;
 
 	if (devtype->cantype == XAXI_CANFD) {
 		priv->can.fd.data_bittiming_const =
 			&xcan_data_bittiming_const_canfd;
-		priv->can.fd.tdc_const = &xcan_tdc_const_canfd;
+		priv->can.tdc_const = &xcan_tdc_const_canfd;
 	}
 
 	if (devtype->cantype == XAXI_CANFD_2_0) {
 		priv->can.fd.data_bittiming_const =
 			&xcan_data_bittiming_const_canfd2;
-		priv->can.fd.tdc_const = &xcan_tdc_const_canfd2;
+		priv->can.tdc_const = &xcan_tdc_const_canfd2;
 	}
 
 	if (devtype->cantype == XAXI_CANFD ||
 	    devtype->cantype == XAXI_CANFD_2_0) {
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
 						CAN_CTRLMODE_TDC_AUTO;
-		priv->can.fd.do_get_auto_tdcv = xcan_get_auto_tdcv;
+		priv->can.do_get_auto_tdcv = xcan_get_auto_tdcv;
 	}
 
 	priv->reg_base = addr;
 	priv->tx_max = tx_max;
 	priv->devtype = *devtype;
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 5dfdbb63b1d5..2053b9dff0ad 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -14,10 +14,12 @@
 #define CAN_BITRATE_UNSET 0
 #define CAN_BITRATE_UNKNOWN (-1U)
 
 #define CAN_CTRLMODE_FD_TDC_MASK				\
 	(CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMODE_TDC_MANUAL)
+#define CAN_CTRLMODE_XL_TDC_MASK				\
+	(CAN_CTRLMODE_XL_TDC_AUTO | CAN_CTRLMODE_XL_TDC_MANUAL)
 
 /*
  * struct can_tdc - CAN FD Transmission Delay Compensation parameters
  *
  * At high bit rates, the propagation delay from the TX pin to the RX
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 9a92cbe5b2cb..1ac98914f351 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -56,11 +56,11 @@ struct can_priv {
 	struct net_device *dev;
 	struct can_device_stats can_stats;
 
 	const struct can_bittiming_const *bittiming_const;
 	struct can_bittiming bittiming;
-	struct data_bittiming_params fd;
+	struct data_bittiming_params fd, xl;
 	unsigned int bitrate_const_cnt;
 	const u32 *bitrate_const;
 	u32 bitrate_max;
 	struct can_clock clock;
 
@@ -94,10 +94,15 @@ struct can_priv {
 static inline bool can_fd_tdc_is_enabled(const struct can_priv *priv)
 {
 	return !!(priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 }
 
+static inline bool can_xl_tdc_is_enabled(const struct can_priv *priv)
+{
+	return !!(priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MASK);
+}
+
 /*
  * can_get_relative_tdco() - TDCO relative to the sample point
  *
  * struct can_tdc::tdco represents the absolute offset from TDCV. Some
  * controllers use instead an offset relative to the Sample Point (SP)
@@ -114,17 +119,17 @@ static inline bool can_fd_tdc_is_enabled(const struct can_priv *priv)
  *                           |<------------------------>| absolute TDCO
  *                           |<--- Sample Point --->|
  *                           |                      |<->| relative TDCO
  *  |<------------- Secondary Sample Point ------------>|
  */
-static inline s32 can_get_relative_tdco(const struct can_priv *priv)
+static inline s32 can_get_relative_tdco(const struct data_bittiming_params *dbt_params)
 {
-	const struct can_bittiming *dbt = &priv->fd.data_bittiming;
+	const struct can_bittiming *dbt = &dbt_params->data_bittiming;
 	s32 sample_point_in_tc = (CAN_SYNC_SEG + dbt->prop_seg +
 				  dbt->phase_seg1) * dbt->brp;
 
-	return (s32)priv->fd.tdc.tdco - sample_point_in_tc;
+	return (s32)dbt_params->tdc.tdco - sample_point_in_tc;
 }
 
 /* helper to define static CAN controller features at device creation time */
 static inline int __must_check can_set_static_ctrlmode(struct net_device *dev,
 						       u32 static_mode)
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 02ec32d69474..f4fb8eea8f35 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -99,12 +99,15 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
 #define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
 #define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
 #define CAN_CTRLMODE_FD_NON_ISO		0x80	/* CAN FD in non-ISO mode */
 #define CAN_CTRLMODE_CC_LEN8_DLC	0x100	/* Classic CAN DLC option */
-#define CAN_CTRLMODE_TDC_AUTO		0x200	/* CAN transiver automatically calculates TDCV */
-#define CAN_CTRLMODE_TDC_MANUAL		0x400	/* TDCV is manually set up by user */
+#define CAN_CTRLMODE_TDC_AUTO		0x200	/* FD transceiver automatically calculates TDCV */
+#define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
+#define CAN_CTRLMODE_XL			0x800	/* CAN XL mode */
+#define CAN_CTRLMODE_XL_TDC_AUTO	0x1000	/* XL transceiver automatically calculates TDCV */
+#define CAN_CTRLMODE_XL_TDC_MANUAL	0x2000	/* XL TDCV is manually set up by user */
 
 /*
  * CAN device statistics
  */
 struct can_device_stats {
@@ -127,27 +130,31 @@ enum {
 	IFLA_CAN_STATE,
 	IFLA_CAN_CTRLMODE,
 	IFLA_CAN_RESTART_MS,
 	IFLA_CAN_RESTART,
 	IFLA_CAN_BERR_COUNTER,
-	IFLA_CAN_DATA_BITTIMING,
-	IFLA_CAN_DATA_BITTIMING_CONST,
+	IFLA_CAN_DATA_BITTIMING, /* FD */
+	IFLA_CAN_DATA_BITTIMING_CONST, /* FD */
 	IFLA_CAN_TERMINATION,
 	IFLA_CAN_TERMINATION_CONST,
 	IFLA_CAN_BITRATE_CONST,
-	IFLA_CAN_DATA_BITRATE_CONST,
+	IFLA_CAN_DATA_BITRATE_CONST, /* FD */
 	IFLA_CAN_BITRATE_MAX,
-	IFLA_CAN_TDC,
+	IFLA_CAN_TDC, /* FD */
 	IFLA_CAN_CTRLMODE_EXT,
+	IFLA_CAN_XL_DATA_BITTIMING,
+	IFLA_CAN_XL_DATA_BITTIMING_CONST,
+	IFLA_CAN_XL_DATA_BITRATE_CONST,
+	IFLA_CAN_XL_TDC,
 
 	/* add new constants above here */
 	__IFLA_CAN_MAX,
 	IFLA_CAN_MAX = __IFLA_CAN_MAX - 1
 };
 
 /*
- * CAN FD Transmitter Delay Compensation (TDC)
+ * CAN FD/XL Transmitter Delay Compensation (TDC)
  *
  * Please refer to struct can_tdc_const and can_tdc in
  * include/linux/can/bittiming.h for further details.
  */
 enum {
-- 
2.45.2


