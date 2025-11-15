Return-Path: <linux-can+bounces-5415-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B65C6048D
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 13:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD483B7B08
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 12:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF0723817F;
	Sat, 15 Nov 2025 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="JOgVkxbL";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Pfc13AlR"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DCA224D6
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763208192; cv=pass; b=COX/Jwwn9xIee0wM1XZAdc/mSiWwy76KPZDvfTSSXswydr+CGQ1S2S/o+YMNMa+z0RsLCsJHpdPedi2riDlQvGObSQX8aXlR0PzpV21uMdS/yBRFPtI6MJ7gijpTy/gWPUvXoIQecWTBn+TikIZ9FXrorPH2TyTaCHLcCvnArFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763208192; c=relaxed/simple;
	bh=syFf8VCoqcGd0Yw3fZ5AH37xuLM2wGYzlZryyUna7o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjtA7l6HTHGSmq1jo/j/2tkKVde01gjusWmcypmziEq+75fPJS3ErUaEJW9L8a5EdToD/0MDeEMGjqqFBbZ7SlohioEpxpv4dEHh1avbogwx/8K2RLjqijGkM8+zDWcIeoNYEi2yJHcGD+trDSFZ6YK/LbXtHZjJZecUBhT9oRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=JOgVkxbL; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Pfc13AlR; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763207466; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nOShTNkkD8u+li7zH/4WRXyJs5PZRq39P2mZznb/px0WeMzWEppNQnC0jqPctDbEX4
    AGQBKNNwDBHrVanHpbKliOYCm4M4K8Warh0snkllLntrf/Khv59dNkQT6KGMef4+gcMO
    1llXMVndVcryMT9XaujnPuB7IDlxmR8Yty9PGLLirukbsw4+PWHEPDHzRfMVpSFhVnn5
    te2liwSJKctcmoWPeXftJKYulB1e9sUDr2xr8qhIUB2Fc02aNIQLmY9iO0vHz4h5CK+M
    7EWeSVo6rX9cL7ZYQH5o0ADkCGXnO944DRkwOAqBAiI6Wt1zcNWmK8ifXKmQEEeiWpl4
    Yc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207466;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NU2VqxN1n2ncNwYjMXw4a+ahm9v2ASmFrcgJH4MeDdU=;
    b=kUKjfO8ZFvpB+ST8J50byROZNmiy23YWTfN+KhyFvQeD0js+nYf5SOZp7AdRNs8Zg2
    7sa7BW9ZCt9sP2jYTaC9x4en4FJw33quUOLDLjfGl2uqdW8CuZ6t40xZEHEyZj0R6nnN
    Gu+4/TToJQrHBcqHvd5pqlitDb5/Wk+5bm1Dn8Wof2DOrLdeRKpzYWG/ZnChwFtDIXnI
    +/BzMMte61zunpzanH1kL64CmI4NA5Ga7m/wMgB4srisPyopfdlLl70C3p6bR13OBp+/
    0H7pYly1rkCVdFNvKmmPIfzKDIMJx8QwkuGzs7seGYGk/aIQMJ0rrp3/HNjSXsoDlR6F
    LdlQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207466;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NU2VqxN1n2ncNwYjMXw4a+ahm9v2ASmFrcgJH4MeDdU=;
    b=JOgVkxbLj8zsvvNsyrrP7p4xvL1ltk2gsoU+00QtpyGag6BNVap6oaxpVwqz4rYNHy
    03RRu8Bm1dt2tXnE6BBJtadG+ErgvhjB666/FXQiCtEmn6wenXYIXR7Mu+AbodznIi/g
    KfYFqYrS+aeMa2rbW+1xL2x3l2AFZ4mRBv06Va7O64AeVG5Tmyck5sfdH19R5+v8airZ
    D7oLiV1j0kcMgTC/jGxuP6gFjaRHRSZfVT/4Fg6MdxzT41F5vId5rFjwM0dzwUQSW0Bv
    bz1lWBJDgJiGSsogPOTLnA01n1IjbIL1HzNA3dIB+JomIgPYs2+4Y8Tjbg8xP49vpPOo
    st9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763207466;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NU2VqxN1n2ncNwYjMXw4a+ahm9v2ASmFrcgJH4MeDdU=;
    b=Pfc13AlRELdIlHTzKFNR+Mr6D6MOLvEN+9CNW/0R01nHwur4ikkTlzNV5Y1u2jRa09
    4eGRBnARwFnARumRRGAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFBp6dZp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 12:51:06 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl 10/10] can: netlink: add PWM netlink interface
Date: Sat, 15 Nov 2025 12:50:53 +0100
Message-ID: <20251115115053.72673-10-socketcan@hartkopp.net>
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
---
 drivers/net/can/dev/netlink.c    | 192 ++++++++++++++++++++++++++++++-
 include/uapi/linux/can/netlink.h |  25 ++++
 2 files changed, 215 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 5a628c629109..72b9a094ea83 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -23,10 +23,11 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 	[IFLA_CAN_TDC] = { .type = NLA_NESTED },
 	[IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
 	[IFLA_CAN_XL_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
 	[IFLA_CAN_XL_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
 	[IFLA_CAN_XL_TDC] = { .type = NLA_NESTED },
+	[IFLA_CAN_XL_PWM] = { .type = NLA_NESTED },
 };
 
 static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
 	[IFLA_CAN_TDC_TDCV_MIN] = { .type = NLA_U32 },
 	[IFLA_CAN_TDC_TDCV_MAX] = { .type = NLA_U32 },
@@ -37,10 +38,22 @@ static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
 	[IFLA_CAN_TDC_TDCV] = { .type = NLA_U32 },
 	[IFLA_CAN_TDC_TDCO] = { .type = NLA_U32 },
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
 {
 	struct can_bittiming *bt;
@@ -117,10 +130,44 @@ static int can_validate_tdc(struct nlattr *data_tdc,
 	}
 
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
+			       "Provide either both PWMS and PWML, or none for automic calculation");
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
 {
 	struct nlattr *data_tdc;
@@ -245,10 +292,14 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	err = can_validate_databittiming(data, extack,
 					 IFLA_CAN_XL_DATA_BITTIMING, flags);
 	if (err)
 		return err;
 
+	err = can_validate_pwm(data, extack, flags);
+	if (err)
+		return err;
+
 	return 0;
 }
 
 static int can_ctrlmode_changelink(struct net_device *dev,
 				   struct nlattr *data[],
@@ -320,10 +371,11 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 	if (!(priv->ctrlmode & CAN_CTRLMODE_XL)) {
 		memset(&priv->xl.data_bittiming, 0,
 		       sizeof(priv->fd.data_bittiming));
 		priv->ctrlmode &= ~CAN_CTRLMODE_XL_TDC_MASK;
 		memset(&priv->xl.tdc, 0, sizeof(priv->xl.tdc));
+		memset(&priv->xl.pwm, 0, sizeof(priv->xl.pwm));
 	}
 
 	can_set_default_mtu(dev);
 
 	return 0;
@@ -466,10 +518,80 @@ static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
 	}
 
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
 {
 	struct can_priv *priv = netdev_priv(dev);
@@ -557,10 +679,13 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (err)
 		return err;
 
 	/* CAN XL */
 	err = can_dbt_changelink(dev, data, false, extack);
+	if (err)
+		return err;
+	err = can_pwm_changelink(dev, data[IFLA_CAN_XL_PWM], extack);
 	if (err)
 		return err;
 
 	if (data[IFLA_CAN_TERMINATION]) {
 		const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
@@ -645,10 +770,34 @@ static size_t can_ctrlmode_ext_get_size(void)
 {
 	return nla_total_size(0) +		/* nest IFLA_CAN_CTRLMODE_EXT */
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
 	size_t size = 0;
 
@@ -676,10 +825,12 @@ static size_t can_get_size(const struct net_device *dev)
 	size += can_data_bittiming_get_size(&priv->fd,
 					    priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 
 	size += can_data_bittiming_get_size(&priv->xl,
 					    priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MASK);
+	size += can_pwm_get_size(priv->xl.pwm_const,		/* IFLA_CAN_XL_PWM */
+				 priv->ctrlmode & CAN_CTRLMODE_XL_TMS);
 
 	return size;
 }
 
 static int can_bittiming_fill_info(struct sk_buff *skb, int ifla_can_bittiming,
@@ -774,10 +925,46 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev,
 err_cancel:
 	nla_nest_cancel(skb, nest);
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
 	struct nlattr *nest;
 
@@ -857,13 +1044,14 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	    can_bitrate_const_fill_info(skb, IFLA_CAN_XL_DATA_BITRATE_CONST,
 					priv->xl.data_bitrate_const,
 					priv->xl.data_bitrate_const_cnt) ||
 
-	    can_tdc_fill_info(skb, dev, IFLA_CAN_XL_TDC)
-	    )
+	    can_tdc_fill_info(skb, dev, IFLA_CAN_XL_TDC) ||
 
+	    can_pwm_fill_info(skb, priv)
+	    )
 		return -EMSGSIZE;
 
 	return 0;
 }
 
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index ebafb091d80f..c30d16746159 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -3,10 +3,11 @@
  * linux/can/netlink.h
  *
  * Definitions for the CAN netlink interface
  *
  * Copyright (c) 2009 Wolfgang Grandegger <wg@grandegger.com>
+ * Copyright (c) 2021-2025 Vincent Mailhol <mailhol@kernel.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the version 2 of the GNU General Public License
  * as published by the Free Software Foundation
  *
@@ -145,10 +146,11 @@ enum {
 	IFLA_CAN_CTRLMODE_EXT,
 	IFLA_CAN_XL_DATA_BITTIMING,
 	IFLA_CAN_XL_DATA_BITTIMING_CONST,
 	IFLA_CAN_XL_DATA_BITRATE_CONST,
 	IFLA_CAN_XL_TDC,
+	IFLA_CAN_XL_PWM,
 
 	/* add new constants above here */
 	__IFLA_CAN_MAX,
 	IFLA_CAN_MAX = __IFLA_CAN_MAX - 1
 };
@@ -186,9 +188,32 @@ enum {
 	/* add new constants above here */
 	__IFLA_CAN_CTRLMODE,
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
 
 #endif /* !_UAPI_CAN_NETLINK_H */
-- 
2.47.3


