Return-Path: <linux-can+bounces-5576-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D73C7B892
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C54C84E73DD
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5AA30102F;
	Fri, 21 Nov 2025 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pxNL0cNB";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YoUruvM+"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F426F2A1
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753744; cv=pass; b=R2vNRAxOvI3iHym91YuhSE4zDVjy938zIDRTBs5y22XeMpw3+7WtVYN4PdfwMWPJDmTJlIv5YAcjaA2S632vkzTHbeakeQ45sa5z+lDaujC4BYR4hYiETUX9RLutGVdkujbUwzdLc/7d+pEZc7cu9OJhm9Eo74kfYzj5o9D4Hl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753744; c=relaxed/simple;
	bh=iojakrZg3rdgvQjV9RXi6el/On+89R+A77ftal0Cli0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGi/WEAkEekZKdTg/NMjdrKRD48DtS2itSdRN64lBA0ZhPiBprA8JSEJ+onUcMzNebqSVK4SeHXyC61g7hNCu9+3kwd0q9L+qXYK7jvUup7m1QtKbrYMzbkkJAu5ibfbm6sSwgKWfkDr2EKv06yeLAGM4Pjbwhmj1/KFBA6ctZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pxNL0cNB; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YoUruvM+; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763753729; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jTaLya4ULLWbWWeHGqExpC2sfVZ3VpqaGc9TZP94DkrkFb5LLHW6x1/PI8M22XktQM
    k34Sv96YK9NfOVfOL2ozObmGd4HW+njYZUjcqAH5ZEJEYEYAwNDDusKBg22LUuQvfP0r
    HhmU7cPZaM31SK6FNMWLP+aqSD7y531juuCJAO+LwPGW7biJ9YdQSxsmVTwZ8sC3xzQv
    4xaLdVKF7SMTtmJCC8v8sAy+ceVsR7cPGWcsChhwN8K3XFrwHKoh/Y8oDLLDWpPTG+4/
    n27V81fyg+mqeE3nRz9ytWl0EHQ8DehOdarxt8q0JSIs2ZuZX48l0h6CLFGa6pp1nXSm
    yHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753729;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Pm2DLJIeLIvMMcV7pkgkHK6Zsy5gH4NPigAHAF5LC1g=;
    b=AliSxkYiOR1KvpNi4zDJ5HWJ1HEDasfzLBt4pFA7P9WX86IBX6p06ZJIagpge1ZwUq
    NsE3JmBD1VrcCvX5R1jpQLpLxQ01jaU3JlF6m58DcDPJKWUO5sKZRq0FB8nEPvl1Zn1J
    /LOY15+VFnTjvxKh7T/AK+tEjtN0I/ydaKrxWr69Eo/+/B0JFNCnIEaCIv0Ezoizz6FR
    n4ikx0khpwjvT3yJ+sdIXols80Ws9aIqw/HnU5jLbKF8e+P36e6Dj3dy+FVV4SCv915u
    yFcxteRjPCbQN3oy/OZjrCZZWt8Bra45fFnvZGs/79RJvz9gnH0NgA+aWYJiCXL584jx
    LJ7Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753729;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Pm2DLJIeLIvMMcV7pkgkHK6Zsy5gH4NPigAHAF5LC1g=;
    b=pxNL0cNBvcNGn4d/jNBG9D0FXgL1DYZBanmqzaEbC2B1VHpkLEwUxRjx4Y1ieH/5ny
    mfPngHDvmUBvrBdq5cBMzKU90tWyA6gK9bWhLZb1GTvrYIXyS9hNUdpTrkizfSV2oywI
    ph/UPJ027DL7qrtKrfVHxRwyf4QxdBYF/inEOmPvLlIqtQa7YQ5obkUUyLFD4X9TuczI
    lZbnnxxM0PoHzaXHcYZ+NNrHLF7cgCoVQHyI/Gnx1gkxUbWsLtg1J3qNWyRbzAJd64+T
    atR8AwGN5RHRJ0arxgj5wQ69rIiBpwMk3TgBsEuP9egu70VTm0lrRcd4nJtnMhEpAUKP
    BGvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763753729;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Pm2DLJIeLIvMMcV7pkgkHK6Zsy5gH4NPigAHAF5LC1g=;
    b=YoUruvM+H1uf5KbtbCMWQtR3HjZe9u90eUUvveYM4uYnrySKdnyELcobtqjTOpwMA3
    +jm7AnqL3dbnXk1WP3CA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALJZTEnC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 20:35:29 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v5 11/17] can: netlink: add PWM netlink interface
Date: Fri, 21 Nov 2025 20:35:07 +0100
Message-ID: <20251121193513.2097-12-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121193513.2097-1-socketcan@hartkopp.net>
References: <20251121193513.2097-1-socketcan@hartkopp.net>
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
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/netlink.c    | 192 ++++++++++++++++++++++++++++++-
 include/uapi/linux/can/netlink.h |  25 ++++
 2 files changed, 215 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index b2c24439abba..d6b0e686fb11 100644
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


