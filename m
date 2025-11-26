Return-Path: <linux-can+bounces-5725-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7122C89AC2
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 13:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428CE3B71E0
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 12:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D232329C58;
	Wed, 26 Nov 2025 12:01:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1F0329C4B
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158498; cv=none; b=i+c8YtsnYFheDGNkqhtf/2hEnc6wBBYwdKwcK2/O0NN2wSo7rPEr82Ug8slGQNIx0Ebm2xL9w4VhV8idxkCWlP+BqVJykjYDQitdaUVTpWMbCQBWkYXqgu6tPwEVWyt8dTRbGUvw+SaLBrpnvI8O8FHACp07od6RZqH4C6yqGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158498; c=relaxed/simple;
	bh=Yw1omdo9Nl2hKsZq3AqZ+j+syJZ7RFCzXQofoHsYgPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ocpcpb9CmKMYPjbuZRpVUHLyKKLUIxiEruy62wp/W9eYdjj0r6UZTwmcLQNu7NF9jmtQo44uZQHr8luKZmUvl7FmQkeKpp4CtFkUdMXMjdpWV8yaj+0VoCqg/MSv0YzZkNJL8c30g6yUDl0jSM4Fvx8PGQFGPlB1vbjpxvRI57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOECs-0004T6-P7; Wed, 26 Nov 2025 13:01:10 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOECs-002bEa-1L;
	Wed, 26 Nov 2025 13:01:10 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1C22B4A8A96;
	Wed, 26 Nov 2025 12:01:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/27] can: netlink: add PWM netlink interface
Date: Wed, 26 Nov 2025 12:57:00 +0100
Message-ID: <20251126120106.154635-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126120106.154635-1-mkl@pengutronix.de>
References: <20251126120106.154635-1-mkl@pengutronix.de>
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

When the TMS is switched on, the node uses PWM (Pulse Width
Modulation) during the data phase instead of the classic NRZ (Non
Return to Zero) encoding.

PWM is configured by three parameters:

  - PWMS: Pulse Width Modulation Short phase
  - PWML: Pulse Width Modulation Long phase
  - PWMO: Pulse Width Modulation Offset time

For each of these parameters, define three IFLA symbols:

  - IFLA_CAN_PWM_PWM*_MIN: the minimum allowed value.
  - IFLA_CAN_PWM_PWM*_MAX: the maximum allowed value.
  - IFLA_CAN_PWM_PWM*: the runtime value.

This results in a total of nine IFLA symbols which are all nested in a
parent IFLA_CAN_XL_PWM symbol.

IFLA_CAN_PWM_PWM*_MIN and IFLA_CAN_PWM_PWM*_MAX define the range of
allowed values and will match the value statically configured by the
device in struct can_pwm_const.

IFLA_CAN_PWM_PWM* match the runtime values stored in struct can_pwm.
Those parameters may only be configured when the tms mode is on. If
the PWMS, PWML and PWMO parameters are provided, check that all the
needed parameters are present using can_validate_pwm(), then check
their value using can_validate_pwm_bittiming(). PWMO defaults to zero
if omitted. Otherwise, if CAN_CTRLMODE_XL_TMS is true but none of the
PWM parameters are provided, calculate them using can_calc_pwm().

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20251126-canxl-v8-11-e7e3eb74f889@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c    | 192 ++++++++++++++++++++++++++++++-
 include/uapi/linux/can/netlink.h |  25 ++++
 2 files changed, 215 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index b2c24439abba..d6b0e686fb11 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -25,6 +25,7 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 	[IFLA_CAN_XL_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
 	[IFLA_CAN_XL_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
 	[IFLA_CAN_XL_TDC] = { .type = NLA_NESTED },
+	[IFLA_CAN_XL_PWM] = { .type = NLA_NESTED },
 };
 
 static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
@@ -39,6 +40,18 @@ static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
 	[IFLA_CAN_TDC_TDCF] = { .type = NLA_U32 },
 };
 
+static const struct nla_policy can_pwm_policy[IFLA_CAN_PWM_MAX + 1] = {
+	[IFLA_CAN_PWM_PWMS_MIN] = { .type = NLA_U32 },
+	[IFLA_CAN_PWM_PWMS_MAX] = { .type = NLA_U32 },
+	[IFLA_CAN_PWM_PWML_MIN] = { .type = NLA_U32 },
+	[IFLA_CAN_PWM_PWML_MAX] = { .type = NLA_U32 },
+	[IFLA_CAN_PWM_PWMO_MIN] = { .type = NLA_U32 },
+	[IFLA_CAN_PWM_PWMO_MAX] = { .type = NLA_U32 },
+	[IFLA_CAN_PWM_PWMS] = { .type = NLA_U32 },
+	[IFLA_CAN_PWM_PWML] = { .type = NLA_U32 },
+	[IFLA_CAN_PWM_PWMO] = { .type = NLA_U32 },
+};
+
 static int can_validate_bittiming(struct nlattr *data[],
 				  struct netlink_ext_ack *extack,
 				  int ifla_can_bittiming)
@@ -119,6 +132,40 @@ static int can_validate_tdc(struct nlattr *data_tdc,
 	return 0;
 }
 
+static int can_validate_pwm(struct nlattr *data[],
+			    struct netlink_ext_ack *extack, u32 flags)
+{
+	struct nlattr *tb_pwm[IFLA_CAN_PWM_MAX + 1];
+	int err;
+
+	if (!data[IFLA_CAN_XL_PWM])
+		return 0;
+
+	if (!(flags & CAN_CTRLMODE_XL_TMS)) {
+		NL_SET_ERR_MSG(extack, "PWM requires TMS");
+		return -EOPNOTSUPP;
+	}
+
+	err = nla_parse_nested(tb_pwm, IFLA_CAN_PWM_MAX, data[IFLA_CAN_XL_PWM],
+			       can_pwm_policy, extack);
+	if (err)
+		return err;
+
+	if (!tb_pwm[IFLA_CAN_PWM_PWMS] != !tb_pwm[IFLA_CAN_PWM_PWML]) {
+		NL_SET_ERR_MSG(extack,
+			       "Provide either both PWMS and PWML, or none for automatic calculation");
+		return -EOPNOTSUPP;
+	}
+
+	if (tb_pwm[IFLA_CAN_PWM_PWMO] &&
+	    (!tb_pwm[IFLA_CAN_PWM_PWMS] || !tb_pwm[IFLA_CAN_PWM_PWML])) {
+		NL_SET_ERR_MSG(extack, "PWMO requires both PWMS and PWML");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int can_validate_databittiming(struct nlattr *data[],
 				      struct netlink_ext_ack *extack,
 				      int ifla_can_data_bittiming, u32 flags)
@@ -247,6 +294,10 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	if (err)
 		return err;
 
+	err = can_validate_pwm(data, extack, flags);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -322,6 +373,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 		       sizeof(priv->fd.data_bittiming));
 		priv->ctrlmode &= ~CAN_CTRLMODE_XL_TDC_MASK;
 		memset(&priv->xl.tdc, 0, sizeof(priv->xl.tdc));
+		memset(&priv->xl.pwm, 0, sizeof(priv->xl.pwm));
 	}
 
 	can_set_default_mtu(dev);
@@ -468,6 +520,76 @@ static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
 	return 0;
 }
 
+static int can_pwm_changelink(struct net_device *dev,
+			      const struct nlattr *pwm_nla,
+			      struct netlink_ext_ack *extack)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	const struct can_pwm_const *pwm_const = priv->xl.pwm_const;
+	struct nlattr *tb_pwm[IFLA_CAN_PWM_MAX + 1];
+	struct can_pwm pwm = { 0 };
+	int err;
+
+	if (!(priv->ctrlmode & CAN_CTRLMODE_XL_TMS))
+		return 0;
+
+	if (!pwm_const) {
+		NL_SET_ERR_MSG(extack, "The device does not support PWM");
+		return -EOPNOTSUPP;
+	}
+
+	if (!pwm_nla)
+		return can_calc_pwm(dev, extack);
+
+	err = nla_parse_nested(tb_pwm, IFLA_CAN_PWM_MAX, pwm_nla,
+			       can_pwm_policy, extack);
+	if (err)
+		return err;
+
+	if (tb_pwm[IFLA_CAN_PWM_PWMS]) {
+		pwm.pwms = nla_get_u32(tb_pwm[IFLA_CAN_PWM_PWMS]);
+		if (pwm.pwms < pwm_const->pwms_min ||
+		    pwm.pwms > pwm_const->pwms_max) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "PWMS: %u tqmin is out of range: %u...%u",
+					   pwm.pwms, pwm_const->pwms_min,
+					   pwm_const->pwms_max);
+			return -EINVAL;
+		}
+	}
+
+	if (tb_pwm[IFLA_CAN_PWM_PWML]) {
+		pwm.pwml = nla_get_u32(tb_pwm[IFLA_CAN_PWM_PWML]);
+		if (pwm.pwml < pwm_const->pwml_min ||
+		    pwm.pwml > pwm_const->pwml_max) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "PWML: %u tqmin is out of range: %u...%u",
+					   pwm.pwml, pwm_const->pwml_min,
+					   pwm_const->pwml_max);
+			return -EINVAL;
+		}
+	}
+
+	if (tb_pwm[IFLA_CAN_PWM_PWMO]) {
+		pwm.pwmo = nla_get_u32(tb_pwm[IFLA_CAN_PWM_PWMO]);
+		if (pwm.pwmo < pwm_const->pwmo_min ||
+		    pwm.pwmo > pwm_const->pwmo_max) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "PWMO: %u tqmin is out of range: %u...%u",
+					   pwm.pwmo, pwm_const->pwmo_min,
+					   pwm_const->pwmo_max);
+			return -EINVAL;
+		}
+	}
+
+	err = can_validate_pwm_bittiming(dev, &pwm, extack);
+	if (err)
+		return err;
+
+	priv->xl.pwm = pwm;
+	return 0;
+}
+
 static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			  struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
@@ -559,6 +681,9 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 
 	/* CAN XL */
 	err = can_dbt_changelink(dev, data, false, extack);
+	if (err)
+		return err;
+	err = can_pwm_changelink(dev, data[IFLA_CAN_XL_PWM], extack);
 	if (err)
 		return err;
 
@@ -647,6 +772,30 @@ static size_t can_ctrlmode_ext_get_size(void)
 		nla_total_size(sizeof(u32));	/* IFLA_CAN_CTRLMODE_SUPPORTED */
 }
 
+static size_t can_pwm_get_size(const struct can_pwm_const *pwm_const,
+			       bool pwm_on)
+{
+	size_t size;
+
+	if (!pwm_const || !pwm_on)
+		return 0;
+
+	size = nla_total_size(0);			/* nest IFLA_CAN_PWM */
+
+	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMS_MIN */
+	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMS_MAX */
+	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWML_MIN */
+	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWML_MAX */
+	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMO_MIN */
+	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMO_MAX */
+
+	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMS */
+	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWML */
+	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMO */
+
+	return size;
+}
+
 static size_t can_get_size(const struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
@@ -678,6 +827,8 @@ static size_t can_get_size(const struct net_device *dev)
 
 	size += can_data_bittiming_get_size(&priv->xl,
 					    priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MASK);
+	size += can_pwm_get_size(priv->xl.pwm_const,		/* IFLA_CAN_XL_PWM */
+				 priv->ctrlmode & CAN_CTRLMODE_XL_TMS);
 
 	return size;
 }
@@ -776,6 +927,42 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev,
 	return -EMSGSIZE;
 }
 
+static int can_pwm_fill_info(struct sk_buff *skb, const struct can_priv *priv)
+{
+	const struct can_pwm_const *pwm_const = priv->xl.pwm_const;
+	const struct can_pwm *pwm = &priv->xl.pwm;
+	struct nlattr *nest;
+
+	if (!pwm_const)
+		return 0;
+
+	nest = nla_nest_start(skb, IFLA_CAN_XL_PWM);
+	if (!nest)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(skb, IFLA_CAN_PWM_PWMS_MIN, pwm_const->pwms_min) ||
+	    nla_put_u32(skb, IFLA_CAN_PWM_PWMS_MAX, pwm_const->pwms_max) ||
+	    nla_put_u32(skb, IFLA_CAN_PWM_PWML_MIN, pwm_const->pwml_min) ||
+	    nla_put_u32(skb, IFLA_CAN_PWM_PWML_MAX, pwm_const->pwml_max) ||
+	    nla_put_u32(skb, IFLA_CAN_PWM_PWMO_MIN, pwm_const->pwmo_min) ||
+	    nla_put_u32(skb, IFLA_CAN_PWM_PWMO_MAX, pwm_const->pwmo_max))
+		goto err_cancel;
+
+	if (priv->ctrlmode & CAN_CTRLMODE_XL_TMS) {
+		if (nla_put_u32(skb, IFLA_CAN_PWM_PWMS, pwm->pwms) ||
+		    nla_put_u32(skb, IFLA_CAN_PWM_PWML, pwm->pwml) ||
+		    nla_put_u32(skb, IFLA_CAN_PWM_PWMO, pwm->pwmo))
+			goto err_cancel;
+	}
+
+	nla_nest_end(skb, nest);
+	return 0;
+
+err_cancel:
+	nla_nest_cancel(skb, nest);
+	return -EMSGSIZE;
+}
+
 static int can_ctrlmode_ext_fill_info(struct sk_buff *skb,
 				      const struct can_priv *priv)
 {
@@ -859,9 +1046,10 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 					priv->xl.data_bitrate_const,
 					priv->xl.data_bitrate_const_cnt) ||
 
-	    can_tdc_fill_info(skb, dev, IFLA_CAN_XL_TDC)
-	    )
+	    can_tdc_fill_info(skb, dev, IFLA_CAN_XL_TDC) ||
 
+	    can_pwm_fill_info(skb, priv)
+	    )
 		return -EMSGSIZE;
 
 	return 0;
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index ebafb091d80f..c30d16746159 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -5,6 +5,7 @@
  * Definitions for the CAN netlink interface
  *
  * Copyright (c) 2009 Wolfgang Grandegger <wg@grandegger.com>
+ * Copyright (c) 2021-2025 Vincent Mailhol <mailhol@kernel.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the version 2 of the GNU General Public License
@@ -147,6 +148,7 @@ enum {
 	IFLA_CAN_XL_DATA_BITTIMING_CONST,
 	IFLA_CAN_XL_DATA_BITRATE_CONST,
 	IFLA_CAN_XL_TDC,
+	IFLA_CAN_XL_PWM,
 
 	/* add new constants above here */
 	__IFLA_CAN_MAX,
@@ -188,6 +190,29 @@ enum {
 	IFLA_CAN_CTRLMODE_MAX = __IFLA_CAN_CTRLMODE - 1
 };
 
+/*
+ * CAN FD/XL Pulse-Width Modulation (PWM)
+ *
+ * Please refer to struct can_pwm_const and can_pwm in
+ * include/linux/can/bittiming.h for further details.
+ */
+enum {
+	IFLA_CAN_PWM_UNSPEC,
+	IFLA_CAN_PWM_PWMS_MIN,	/* u32 */
+	IFLA_CAN_PWM_PWMS_MAX,	/* u32 */
+	IFLA_CAN_PWM_PWML_MIN,	/* u32 */
+	IFLA_CAN_PWM_PWML_MAX,	/* u32 */
+	IFLA_CAN_PWM_PWMO_MIN,	/* u32 */
+	IFLA_CAN_PWM_PWMO_MAX,	/* u32 */
+	IFLA_CAN_PWM_PWMS,	/* u32 */
+	IFLA_CAN_PWM_PWML,	/* u32 */
+	IFLA_CAN_PWM_PWMO,	/* u32 */
+
+	/* add new constants above here */
+	__IFLA_CAN_PWM,
+	IFLA_CAN_PWM_MAX = __IFLA_CAN_PWM - 1
+};
+
 /* u16 termination range: 1..65535 Ohms */
 #define CAN_TERMINATION_DISABLED 0
 
-- 
2.51.0


