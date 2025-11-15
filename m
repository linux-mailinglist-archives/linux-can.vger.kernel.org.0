Return-Path: <linux-can+bounces-5411-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFDEC60451
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 12:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116C93A9C61
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 11:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1299284B4F;
	Sat, 15 Nov 2025 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="q96UE38f";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="1ZhwnRqC"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DDD296BD3
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763207486; cv=pass; b=ptve6KNhKMZZiynK7Otv+zR+YZzKQkcREwYt/6IIV6ZrTptzDNMcXbgk4lcxkg+fvDm9ZE7wRHSGYv++1hdEO54/ahdRou0KHqbNORAQecrCrba8qBekpJqPNUCDuY7S3rVrNBPFwCbz2Kjc12BE3QEE68ihqTisZupUhfT3CiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763207486; c=relaxed/simple;
	bh=DJ6N5NsCzI4my9rNPrxqp1wVUObwQW1KeyZEF1ZOvJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MyDTQprP8wUfdoxP2RheA93SZsxWaIzUAmuVn85urUPi7ckyCsvkA4Pokga27GkzcwakLEw/Sf7iNqDxJfCwvSLr0N6pwYqPezy2S1f8krguSddY2rrcxBOzlHna4TBs5lXLUHXqnX2I6OXO4RkHHa9FTmkafZN5kXhx0+Q+x1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=q96UE38f; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=1ZhwnRqC; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763207465; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ly1AXPU3LdbHXuT6WTX/6Qpkjwm253xCToz1CRaE3ZHnmbLqkm2w+gfWoHkHJZIGGy
    JnsgtyFD/pcjADiKDKwDgTGXmVonRW14GbJDXrM3q9MBMWcqg+qGBSUCWaUJejh4fEr2
    V0od7hqUJ86GmW5SoQLfE2ZsV0jRudUmoNWYiighzO7HK7Q2bcIUNPoOYqROKLDspCuK
    X2TyhTiI5eStKc2gsBjaUitpP9SSh/xfIQsKrL2+8cMFjoirMy3NdXGAYThRcN02/m8V
    HQqDfnvt273tqBR0BID8QyAEYaw2EawvNsUswuH2RgHZb28dTdM0WE5PglA7yvUhkw5n
    yodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207465;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eV4PkT/QRYpshg1rrxSh3IJCj8UpJu1Fu75gwhU3+WQ=;
    b=TkWogHjCTBNlpBfFhymO/ufFz2WlSQdVCnseFi+2119dD8lSj06FkYvK2jenwtwVno
    3XI1uJ9eWZqkdfHWO0/Uo5u3AUWLYZxvycnpG/76vyuZqPeEViEP1/kFyJOlcjspiVKg
    erklORoig8XhLQ5wdiRsRNiXc3NmcnQlptMjt3gg5XlKBH3zaohw2+q4h4g9cuW3tlaW
    AYyyqPTFCP0RMPIC0xtvL8ImaVTogDtnkmSSCCi3YUeG20WgxObSMFgdd2DDNO6bWjK5
    C3wmjLEenNT0uvlxjNUuTuFqy3kuOPI/qcwfgDjIh9YS8QWKZFgcg/RcdryJ0pKKMUf1
    TnYg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207465;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eV4PkT/QRYpshg1rrxSh3IJCj8UpJu1Fu75gwhU3+WQ=;
    b=q96UE38fwuuc9m8L32I4YGxazeI1TqchIqizNkPWWIr8cOe8E8hjl8EmM9RH48GWU3
    oqIwRybR7zlW2R634yRzNhc56/7XeeYhTmJoYzLPk8CDeicJweBRHm1VXR94t1fBMaC7
    olvtyhIOz2IkJflFt9NrQl5nxvhgFDGdYZzdjp3fPjc24DSf0O1Mya9gh9gnokTMfNjw
    aqbcCssJbbwxWsHYHXrHQPVBrfSWIfPkuK7f5v9ilQoHpE+ZrjuIiQ9Diaw/pfVUTRx0
    trO3eI39MyzFY8QIg0nUdqvxPpbgWHx90X3gtd8tHATDew8fRbozBu33h3ckhoiZwCLB
    qEdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763207465;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eV4PkT/QRYpshg1rrxSh3IJCj8UpJu1Fu75gwhU3+WQ=;
    b=1ZhwnRqCNcP3XL/ORM+bMygRuqEyeD6VAzHcb4TeAfe94Hve7xjbvKPy0TrKlnnida
    cY47UrOiOk0qY+5JimBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFBp5dZj
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 12:51:05 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl 04/10] can: netlink: add initial CAN XL support
Date: Sat, 15 Nov 2025 12:50:47 +0100
Message-ID: <20251115115053.72673-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251115115053.72673-1-socketcan@hartkopp.net>
References: <20251115115053.72673-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Vincent Mailhol <mailhol@kernel.org>

CAN XL uses bittiming parameters different from Classical CAN and CAN
FD. Thus, all the data bittiming parameters, including TDC, need to be
duplicated for CAN XL.

Add the CAN XL netlink interface for all the features which are common
with CAN FD. Any new CAN XL specific features are added later on.

The first time CAN XL is activated, the MTU is set by default to
CANXL_MAX_MTU. The user may then configure a custom MTU within the
CANXL_MIN_MTU to CANXL_MIN_MTU range, in which case, the custom MTU
value will be kept as long as CAN XL remains active.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/dev.c        | 14 +++++-
 drivers/net/can/dev/netlink.c    | 76 +++++++++++++++++++++++++-------
 include/linux/can/bittiming.h    |  6 ++-
 include/linux/can/dev.h          |  7 ++-
 include/uapi/linux/can/netlink.h |  7 +++
 5 files changed, 90 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 5e24bc332a50..443692587217 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -115,10 +115,16 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
 		return "fd-tdc-auto";
 	case CAN_CTRLMODE_TDC_MANUAL:
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
 }
 EXPORT_SYMBOL_GPL(can_get_ctrlmode_str);
@@ -348,11 +354,17 @@ EXPORT_SYMBOL_GPL(free_candev);
 
 void can_set_default_mtu(struct net_device *dev)
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
 	} else {
 		dev->mtu = CAN_MTU;
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 7cb57b0df726..26c25e660e31 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
  * Copyright (C) 2006 Andrey Volkov, Varma Electronics
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
- * Copyright (C) 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (C) 2021-2025 Vincent Mailhol <mailhol@kernel.org>
  */
 
 #include <linux/can/dev.h>
 #include <net/rtnetlink.h>
 
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
@@ -68,11 +71,11 @@ static int can_validate_tdc(struct nlattr *data_tdc,
 		NL_SET_ERR_MSG(extack,
 			       "TDC manual and auto modes are mutually exclusive");
 		return -EOPNOTSUPP;
 	}
 
-	/* If one of the CAN_CTRLMODE_TDC_* flag is set then TDC
+	/* If one of the CAN_CTRLMODE_{,XL}_TDC_* flags is set then TDC
 	 * must be set and vice-versa
 	 */
 	if ((tdc_auto || tdc_manual) && !data_tdc) {
 		NL_SET_ERR_MSG(extack, "TDC parameters are missing");
 		return -EOPNOTSUPP;
@@ -80,12 +83,12 @@ static int can_validate_tdc(struct nlattr *data_tdc,
 	if (!(tdc_auto || tdc_manual) && data_tdc) {
 		NL_SET_ERR_MSG(extack, "TDC mode (auto or manual) is missing");
 		return -EOPNOTSUPP;
 	}
 
-	/* If providing TDC parameters, at least TDCO is needed. TDCV
-	 * is needed if and only if CAN_CTRLMODE_TDC_MANUAL is set
+	/* If providing TDC parameters, at least TDCO is needed. TDCV is
+	 * needed if and only if CAN_CTRLMODE_{,XL}_TDC_MANUAL is set
 	 */
 	if (data_tdc) {
 		struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
 
 		err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX,
@@ -124,24 +127,27 @@ static int can_validate_databittiming(struct nlattr *data[],
 	const char *type;
 	u32 tdc_flags;
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
 
 	if (ifla_can_data_bittiming == IFLA_CAN_DATA_BITTIMING) {
 		data_tdc = data[IFLA_CAN_TDC];
 		tdc_flags = flags & CAN_CTRLMODE_FD_TDC_MASK;
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
 		if (!data[IFLA_CAN_BITTIMING] || !data[ifla_can_data_bittiming]) {
 			NL_SET_ERR_MSG_FMT(extack,
@@ -204,10 +210,15 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	err = can_validate_databittiming(data, extack,
 					 IFLA_CAN_DATA_BITTIMING, flags);
 	if (err)
 		return err;
 
+	err = can_validate_databittiming(data, extack,
+					 IFLA_CAN_XL_DATA_BITTIMING, flags);
+	if (err)
+		return err;
+
 	return 0;
 }
 
 static int can_ctrlmode_changelink(struct net_device *dev,
 				   struct nlattr *data[],
@@ -249,22 +260,30 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 	}
 
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
 
 	return 0;
 }
@@ -335,11 +354,14 @@ static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
 		data_bittiming = data[IFLA_CAN_DATA_BITTIMING];
 		data_tdc = data[IFLA_CAN_TDC];
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
 		return 0;
 
@@ -386,11 +408,11 @@ static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
 		/* Neither of TDC parameters nor TDC flags are provided:
 		 * do calculation
 		 */
 		can_calc_tdco(&dbt_params->tdc, dbt_params->tdc_const, &dbt,
 			      tdc_mask, &priv->ctrlmode, priv->ctrlmode_supported);
-	} /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
+	} /* else: both CAN_CTRLMODE_{,XL}_TDC_{AUTO,MANUAL} are explicitly
 	   * turned off. TDC is disabled: do nothing
 	   */
 
 	memcpy(&dbt_params->data_bittiming, &dbt, sizeof(dbt));
 
@@ -491,10 +513,15 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	/* CAN FD */
 	err = can_dbt_changelink(dev, data, true, extack);
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
 		unsigned int i;
 
@@ -558,18 +585,18 @@ static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
 static size_t can_data_bittiming_get_size(struct data_bittiming_params *dbt_params,
 					  u32 tdc_flags)
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
 
 static size_t can_ctrlmode_ext_get_size(void)
@@ -605,10 +632,13 @@ static size_t can_get_size(const struct net_device *dev)
 	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
 
 	size += can_data_bittiming_get_size(&priv->fd,
 					    priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 
+	size += can_data_bittiming_get_size(&priv->xl,
+					    priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MASK);
+
 	return size;
 }
 
 static int can_bittiming_fill_info(struct sk_buff *skb, int ifla_can_bittiming,
 				   struct can_bittiming *bittiming)
@@ -649,11 +679,13 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev,
 	if (ifla_can_tdc == IFLA_CAN_TDC) {
 		dbt_params = &priv->fd;
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
 
 	if (!tdc_const)
@@ -771,11 +803,23 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		     sizeof(priv->bitrate_max),
 		     &priv->bitrate_max)) ||
 
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
 
 	return 0;
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 3926c78b2222..b6cd2476ffd7 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -14,14 +14,16 @@
 #define CAN_BITRATE_UNSET 0
 #define CAN_BITRATE_UNKNOWN (-1U)
 
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
  *
  * At high bit rates, the propagation delay from the TX pin to the RX
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index ab11c0e9111b..f15879bd818d 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -45,11 +45,11 @@ struct can_priv {
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
 
@@ -83,10 +83,15 @@ struct can_priv {
 static inline bool can_fd_tdc_is_enabled(const struct can_priv *priv)
 {
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
 }
 
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index fafd1cce4798..c2c96c5978a8 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -102,10 +102,13 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_FD_NON_ISO		0x80	/* CAN FD in non-ISO mode */
 #define CAN_CTRLMODE_CC_LEN8_DLC	0x100	/* Classic CAN DLC option */
 #define CAN_CTRLMODE_TDC_AUTO		0x200	/* FD transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
 #define CAN_CTRLMODE_RESTRICTED		0x800	/* Restricted operation mode */
+#define CAN_CTRLMODE_XL			0x1000	/* CAN XL mode */
+#define CAN_CTRLMODE_XL_TDC_AUTO	0x2000	/* XL transceiver automatically calculates TDCV */
+#define CAN_CTRLMODE_XL_TDC_MANUAL	0x4000	/* XL TDCV is manually set up by user */
 
 /*
  * CAN device statistics
  */
 struct can_device_stats {
@@ -137,10 +140,14 @@ enum {
 	IFLA_CAN_BITRATE_CONST,
 	IFLA_CAN_DATA_BITRATE_CONST, /* FD */
 	IFLA_CAN_BITRATE_MAX,
 	IFLA_CAN_TDC, /* FD */
 	IFLA_CAN_CTRLMODE_EXT,
+	IFLA_CAN_XL_DATA_BITTIMING,
+	IFLA_CAN_XL_DATA_BITTIMING_CONST,
+	IFLA_CAN_XL_DATA_BITRATE_CONST,
+	IFLA_CAN_XL_TDC,
 
 	/* add new constants above here */
 	__IFLA_CAN_MAX,
 	IFLA_CAN_MAX = __IFLA_CAN_MAX - 1
 };
-- 
2.47.3


