Return-Path: <linux-can+bounces-3699-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D178FAC5B0E
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 21:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925A54A5524
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 19:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D0620297C;
	Tue, 27 May 2025 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iGknDToE";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="gwJ20vP3"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D511E32B7
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375812; cv=pass; b=C0vSOJqylYWTDRv4q6Dop/w+0viN4bKSqx42YtcuZXvIq9mxFxFqVpzuv+vc8R6NNQNhhuhI9f8+5pO4GGtUCTB8kMxPX0DZ9ShAf/qIZMysDO7EQKkxw15uwEM5rXs4elxkOkTrd8EOQJAyER4VZfO/1T3fmQfKmhHniVc4Dpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375812; c=relaxed/simple;
	bh=oRcLwkrPEAfCEB2M1X33L4d0r7aH5PiZS8PWs5RhWh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dizSBJa0dQtfOU++TZI0y7WXrzejOBXiXvcaHUSXJXwCS83JvQZ/fMzpiO609zgw8vgdYbFmdPmPU3KWcAtqi9MVOzGLNftgYNKaBtno5NlBFUxm5PVuYDfcqZxwkcywVJhoYuKigKQyM4en+FExtBV1AXs5msUto09S32GEoe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iGknDToE; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=gwJ20vP3; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1748375802; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ogZDuA4Aky4rhMZ7Avh4UkJmg1RX5yQygbr+eTJ7HN+S7MmmOP4Et8AN3Xt0B1+Pc6
    0BZ1rR5dBbSnvx7Z1ZPetcPGFAtVyWF1ef7tnI0iPOZDYlrpK3K6q5cEV0e7gQkVsCOF
    ShnLn8f02y5L59gT2u8erbzpRq/kIkapHKC0JjYWCre8I8QK6eLf6RAM2qqrmXWrH8MM
    MQSX3JPr73SP1SPNg6j8jCTIV6uH6vWdyUQgKUOS34N5KzMvYAuMgiWC/P9KvzhVp13F
    DX0cDSW5itKbR7zPIdNcuawMSbaAuF+Uarf/+9xhslRV5jyBViKEmE66ZX99eTxLli4C
    hcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375802;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=bZ/Ld27CE76fTuMxjTYqneyluz2RAxGIuedWn+oQZuA=;
    b=HtEWH8WqjWpMJFNRI+F/fOHeOJoeP1a6OraEpC9o1TUKhCaQy26KzT8Lg/HYvX7piG
    mcXy9RjyvRDwd0QVi+W6pKpNtn16NqVcTquWPB0PV8nPAL6xt6AlZ6CuwRo1DWAkVXLX
    ziLlzHZsGKNzD28yOpq9iGUpZ4cFlRfM390DB/2Env0fpSajjLVJdFTJtUtH+BwIYDUj
    YkdJaFRe3Q+qfN+0e18Y3aEDypoAAwaawFrn8MkRLHaVOivzl5Kf4ZfvCEt9KYmQFT5k
    IvBC2YOhr5kTPK/Vemg2jP6xWQJXN8N+QiQ4YTLA8z4eN1/cEwZfUKt8PRSZ8FTqQSBY
    U+cg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375802;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=bZ/Ld27CE76fTuMxjTYqneyluz2RAxGIuedWn+oQZuA=;
    b=iGknDToE2eBcDPFSIh4xJaNbTgUyJ7VHcDEsKqfa4QeEhXVAr0dd8ZZU0Kf3vAwtVI
    Ck84Nie8ut4L3j02NyuHz23lSW8Iiws/AuWKK6l+igXp6DdGPsN65M64h/Drau3FOapq
    HihbG7/tfUfLPBKhO7XVxzxxxpUjkYI/sS/QVjPqV3vn3rjcIs2kNmVo9E1FbwlIaKlA
    rHqcnx1mdg+xjkWF8dK55MZQMCzBVjT0KL2+An62MdjKFK/OkvEvNUwGeXvE6rMioedW
    Fj6nU7D/gL/nZI+Niv+OX4bmZurFj2TrcLsam/Elw3GoPd9LvYNqlSphGAYd6Vll0tAE
    /+lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748375802;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=bZ/Ld27CE76fTuMxjTYqneyluz2RAxGIuedWn+oQZuA=;
    b=gwJ20vP3WMT8H0QEJ1RwFsqiPLfAtWGEL/Yrsvh/jlBsHNhrMidr4KDDdPmxQTB3Y/
    QS4SGKv8xM7gpOrisLDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514RJugiWC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 May 2025 21:56:42 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 10/11] can: canxl: add PWM config support
Date: Tue, 27 May 2025 21:56:24 +0200
Message-ID: <20250527195625.65252-10-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250527195625.65252-1-socketcan@hartkopp.net>
References: <20250527195625.65252-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/netlink.c    | 31 ++++++++++++++++++++++++++++++-
 include/linux/can/bittiming.h    | 25 +++++++++++++++++++++++++
 include/linux/can/dev.h          |  1 +
 include/uapi/linux/can/netlink.h | 15 +++++++++++++++
 4 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 1b798a7dcd64..685cceb74048 100644
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
@@ -37,10 +38,16 @@ static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
 	[IFLA_CAN_TDC_TDCV] = { .type = NLA_U32 },
 	[IFLA_CAN_TDC_TDCO] = { .type = NLA_U32 },
 	[IFLA_CAN_TDC_TDCF] = { .type = NLA_U32 },
 };
 
+static const struct nla_policy can_pwm_policy[IFLA_CAN_PWM_MAX + 1] = {
+	[IFLA_CAN_PWM_OFFSET] = { .type = NLA_U8 },
+	[IFLA_CAN_PWM_LONG] = { .type = NLA_U8 },
+	[IFLA_CAN_PWM_SHORT] = { .type = NLA_U8 },
+};
+
 static int can_validate_bittiming(const struct can_bittiming *bt,
 				  struct netlink_ext_ack *extack)
 {
 	/* sample point is in one-tenth of a percent */
 	if (bt->sample_point >= 1000) {
@@ -464,10 +471,29 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 				 can_xl_tdc_is_enabled(priv),
 				 CAN_CTRLMODE_XL_TDC_MASK, extack);
 	if (err)
 		return err;
 
+	/* CAN XL transceiver PWM configuration */
+	if (data[IFLA_CAN_XL_PWM]) {
+		struct nlattr *tb_pwm[IFLA_CAN_PWM_MAX + 1];
+
+		err = nla_parse_nested(tb_pwm, IFLA_CAN_PWM_MAX, data[IFLA_CAN_XL_PWM],
+				       can_pwm_policy, extack);
+		if (err)
+			return err;
+
+		if (tb_pwm[IFLA_CAN_PWM_OFFSET])
+			priv->pwm.pwm_offset = nla_get_u8(tb_pwm[IFLA_CAN_PWM_OFFSET]) & 0x3F;
+
+		if (tb_pwm[IFLA_CAN_PWM_LONG])
+			priv->pwm.pwm_phase_long = nla_get_u8(tb_pwm[IFLA_CAN_PWM_LONG]) & 0x3F;
+
+		if (tb_pwm[IFLA_CAN_PWM_SHORT])
+			priv->pwm.pwm_phase_short = nla_get_u8(tb_pwm[IFLA_CAN_PWM_SHORT]) & 0x3F;
+	}
+
 	if (data[IFLA_CAN_TERMINATION]) {
 		const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
 		const unsigned int num_term = priv->termination_const_cnt;
 		unsigned int i;
 
@@ -573,10 +599,11 @@ static size_t can_get_size(const struct net_device *dev)
 		size += nla_total_size(sizeof(*priv->xl.data_bitrate_const) *
 				       priv->xl.data_bitrate_const_cnt);
 	size += can_tdc_get_size(&priv->xl,			/* IFLA_CAN_XL_TDC */
 				 can_xl_tdc_is_enabled(priv),
 				 priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MANUAL);
+	size += nla_total_size(sizeof(struct can_pwm));
 
 	return size;
 }
 
 static int can_tdc_fill_info(struct sk_buff *skb,  const struct net_device *dev,
@@ -734,11 +761,13 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		     priv->xl.data_bitrate_const_cnt,
 		     priv->xl.data_bitrate_const)) ||
 
 	    can_tdc_fill_info(skb, dev, &priv->xl, can_xl_tdc_is_enabled(priv),
 			      priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MANUAL,
-			      IFLA_CAN_XL_TDC)
+			      IFLA_CAN_XL_TDC) ||
+
+	    nla_put(skb, IFLA_CAN_XL_PWM, sizeof(priv->pwm), &priv->pwm)
 	    )
 
 		return -EMSGSIZE;
 
 	return 0;
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 2053b9dff0ad..47e266ab7486 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -114,10 +114,35 @@ struct can_tdc_const {
 	u32 tdco_max;
 	u32 tdcf_min;
 	u32 tdcf_max;
 };
 
+/*
+ * struct can_pwm - PWM configuration for switchable CAN XL transceivers
+ *
+ * -+-- init-offset -+------- one bit in CAN XL data mode --------+- TX pin
+ *  |<--- Offset --->|
+ *                   |<-------- Long 1 -------->|<--- Short 0 --->|  level_1
+ *                   |<--- Short 1 --->|<-------- Long 0 -------->|  level_0
+ *                                          |
+ *                                 (50/50 sample point)
+ *
+ * The duration of a complete PWM bit representation has to be < 200ns to
+ * reliably switch the CAN XL transceiver into the CAN XL data mode.
+ *
+ * @pwm_offset: Offset before first PWM bit trasmmission to fill the ADH bit
+ *
+ * @pwm_phase_long: PWM Phase Long (ideally 75% of PWM bit representation)
+ *
+ * @pwm_phase_short: PWM Phase Short (ideally 25% of PWM bit representation)
+ */
+struct can_pwm {
+	u8 pwm_offset;
+	u8 pwm_phase_long;
+	u8 pwm_phase_short;
+};
+
 #ifdef CONFIG_CAN_CALC_BITTIMING
 int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		       const struct can_bittiming_const *btc, struct netlink_ext_ack *extack);
 
 void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 1ac98914f351..6b65b3fccfd2 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -60,10 +60,11 @@ struct can_priv {
 	struct can_bittiming bittiming;
 	struct data_bittiming_params fd, xl;
 	unsigned int bitrate_const_cnt;
 	const u32 *bitrate_const;
 	u32 bitrate_max;
+	struct can_pwm pwm;
 	struct can_clock clock;
 
 	unsigned int termination_const_cnt;
 	const u16 *termination_const;
 	u16 termination;
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 163a6167264e..bd3706b37e04 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -146,16 +146,31 @@ enum {
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
 
+/*
+ * CAN XL Transceiver data mode switching PWM configuration
+ */
+enum {
+	IFLA_CAN_PWM_UNSPEC,
+	IFLA_CAN_PWM_OFFSET,	/* u8 */
+	IFLA_CAN_PWM_LONG,	/* u8 */
+	IFLA_CAN_PWM_SHORT,	/* u8 */
+
+	/* add new constants above here */
+	__IFLA_CAN_PWM,
+	IFLA_CAN_PWM_MAX = __IFLA_CAN_PWM - 1
+};
+
 /*
  * CAN FD/XL Transmitter Delay Compensation (TDC)
  *
  * Please refer to struct can_tdc_const and can_tdc in
  * include/linux/can/bittiming.h for further details.
-- 
2.47.2


