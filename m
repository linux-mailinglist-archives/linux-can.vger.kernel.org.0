Return-Path: <linux-can+bounces-5653-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B0DC84FF6
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 13:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDC0134F44E
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE49301489;
	Tue, 25 Nov 2025 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="T0q06I6G";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Zyn7Jv/5"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92E18DB1E
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074377; cv=pass; b=V6b6PNxWHj7fv/3t3KSJemQ3n6nv3IuaJYF5fQMPHNkqCXJTwsXQX4uQcziHArv+88sgLbhl61im20qLpgBS0OekysCNOZwHgdcmBZOxzOKCljYuVze+xVYqikPaojONhRKJrcJkyeQLDK657vUURHfQMS23ymPGRJUeeuuoNSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074377; c=relaxed/simple;
	bh=nNB3rtZi54N58ssNZf8sHSKTveYP55DBOpxafoykIio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPlcYuj/9phQyqmDsLc+O/QkQuZ4jb4lJPHrHmZ6G8oaqpEy8m/lshtfKrkFssWOktZONs+WFIzOCb4qlmJsLfBihWY5rbOAymtuYnOkURLd2j0NXmcrITvPY1zDXgVYe7ljmYm+xLp3FSB/jYYsIpcsMRlIZioSL+Y9z/z3WL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=T0q06I6G; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Zyn7Jv/5; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764074355; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aKg6ELSag9T7ZmApi6lpmwhaSsrc6WmsjI5/eGjS5WZJrzXJGXOJxhfw2A4d65VlM3
    EEiq2S6gfsPDHJpP4CH4ulYgFqXFh3uJyO6ZYyOr7YOaQ7Kb1uAgwaLNpDndoV8uKBMF
    QumV1biroz7UqkQf2x1Wg2WC65lNz7okBREUAJNPG0Gu8fS+3QvlUgsR23R3xh++MIlX
    eNbcVp+s0xKprAoWj8qY+EgMhlPM746NCwbA4wUilsrPtbNdF69LUdpqi3yZeyc7Q6Tv
    2HNiAU/9PfVf4XMZuXs3H1J0uo7Bnx8ox/aE4ZIPj83xRL8Gzr18h+9VT90ulH3C5em9
    PbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074355;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=L5U+Rohfkgikup5nkc6jw8yTaiwj3tMxUzrQB6dHBoM=;
    b=UPo/gjbpHXFi5BTvKWYqwUyWwtkYWZn4xIE1w6S8w30F8noEG4f4Keh0gnBqNIK2DV
    8Y8Uf4UjjuoGTocrH6zISTjnWH8Itb6nZIhFezD7ENIs1RlyMFcq7YbJaiOP9XvNA9yS
    Rkk1dn/L7LNJ0M0nTowHG8NTE9f/0OdentUSjHGcdK4onptrmQl5Bbu8mZPP9c1yhtkY
    8Bd+2KECx1SrCy7ABCwMiM+RfBCb+03JOkXziz7KqJVEVl5zH1cKMLy4AeiizLeTucUP
    AG+HoEXJ/0+3x6G0puNfSmmDXRPyOjqFzTAGwoWzqxLX8YpjK/Gm3RhSf7ULPM083Oxq
    43Bw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074355;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=L5U+Rohfkgikup5nkc6jw8yTaiwj3tMxUzrQB6dHBoM=;
    b=T0q06I6G36mzwVD8ONDvmHPgZFuoy2a2TfeMA5wBvvoLiGvatqKG5f7RvA+PPelqa3
    rTNUIxIKdhr3B2v2tHGrbXv0Zy1U2k1XKwkmpyK4R0vMWecX7nU2NxCXOj5ubYf86YQZ
    mPdZBTkjKQRd1Rc5WsH7miuBJjw7ZqrGMkDOCL+JXBInyAGwkPZv0KzyH20LFqnln7JD
    FdxsYOgY+sXjU5bj0BLy9FeSFkTQtr814R5i1UMIvxedMfMbNXCPH0zjetO2mKJYoA9K
    GHKLnuKXPQZgWJutB2PVuuvVtM5ZRJK1A/B/Ojz9tsxxNfQz1jdEMUGBJQ0VDttYi41u
    2LyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764074355;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=L5U+Rohfkgikup5nkc6jw8yTaiwj3tMxUzrQB6dHBoM=;
    b=Zyn7Jv/5ZVmXSkAyg0NRTlYultNu2lCTs2ZGHph/QP1sTJIvj0tx/JxSC3FFsXzs1p
    my1aBzd12W8OoNqF31Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461APCdFT8T
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Nov 2025 13:39:15 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v7 09/17] can: bittiming: add PWM validation
Date: Tue, 25 Nov 2025 13:38:51 +0100
Message-ID: <20251125123859.3924-10-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251125123859.3924-1-socketcan@hartkopp.net>
References: <20251125123859.3924-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Vincent Mailhol <mailhol@kernel.org>

Add can_validate_pwm() to validate the values pwms, pwml and pwml.
Error messages are added to each of the checks to inform the user on
what went wrong. Refer to those error messages to understand the
validation logic.

The boundary values CAN_PWM_DECODE_NS (the transceiver minimum
decoding margin) and CAN_PWM_NS_MAX (the maximum PWM symbol duration)
are hardcoded for the moment. Note that a transceiver capable of
bitrates higher than 20 Mbps may be able to handle a CAN_PWM_DECODE_NS
below 5 ns. If such transceivers become commercially available, this
code could be revisited to make this parameter configurable. For now,
leave it static.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/bittiming.c | 63 +++++++++++++++++++++++++++++++++
 include/linux/can/bittiming.h   | 22 ++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
index 0b93900b1dfa..8f82418230ce 100644
--- a/drivers/net/can/dev/bittiming.c
+++ b/drivers/net/can/dev/bittiming.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
  * Copyright (C) 2006 Andrey Volkov, Varma Electronics
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
+ * Copyright (c) 2025 Vincent Mailhol <mailhol@kernel.org>
  */
 
 #include <linux/can/dev.h>
 
 void can_sjw_set_default(struct can_bittiming *bt)
@@ -149,5 +150,67 @@ int can_get_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		return can_validate_bitrate(dev, bt, bitrate_const,
 					    bitrate_const_cnt, extack);
 
 	return -EINVAL;
 }
+
+int can_validate_pwm_bittiming(const struct net_device *dev,
+			       const struct can_pwm *pwm,
+			       struct netlink_ext_ack *extack)
+{
+	const struct can_priv *priv = netdev_priv(dev);
+	u32 xl_bit_time_tqmin = can_bit_time_tqmin(&priv->xl.data_bittiming);
+	u32 nom_bit_time_tqmin = can_bit_time_tqmin(&priv->bittiming);
+	u32 pwms_ns = can_tqmin_to_ns(pwm->pwms, priv->clock.freq);
+	u32 pwml_ns = can_tqmin_to_ns(pwm->pwml, priv->clock.freq);
+
+	if (pwms_ns + pwml_ns > CAN_PWM_NS_MAX) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "The PWM symbol duration: %u ns may not exceed %u ns",
+				   pwms_ns + pwml_ns, CAN_PWM_NS_MAX);
+		return -EINVAL;
+	}
+
+	if (pwms_ns < CAN_PWM_DECODE_NS) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "PWMS: %u ns shall be at least %u ns",
+				   pwms_ns, CAN_PWM_DECODE_NS);
+		return -EINVAL;
+	}
+
+	if (pwm->pwms >= pwm->pwml) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "PWMS: %u tqmin shall be smaller than PWML: %u tqmin",
+				   pwm->pwms, pwm->pwml);
+		return -EINVAL;
+	}
+
+	if (pwml_ns - pwms_ns < 2 * CAN_PWM_DECODE_NS) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "At least %u ns shall separate PWMS: %u ns from PMWL: %u ns",
+				   2 * CAN_PWM_DECODE_NS, pwms_ns, pwml_ns);
+		return -EINVAL;
+	}
+
+	if (xl_bit_time_tqmin % (pwm->pwms + pwm->pwml) != 0) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "PWM duration: %u tqmin does not divide XL's bit time: %u tqmin",
+				   pwm->pwms + pwm->pwml, xl_bit_time_tqmin);
+		return -EINVAL;
+	}
+
+	if (pwm->pwmo >= pwm->pwms + pwm->pwml) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "PWMO: %u tqmin can not be greater than PWMS + PWML: %u tqmin",
+				   pwm->pwmo, pwm->pwms + pwm->pwml);
+		return -EINVAL;
+	}
+
+	if (nom_bit_time_tqmin % (pwm->pwms + pwm->pwml) != pwm->pwmo) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Can not assemble nominal bit time: %u tqmin out of PWMS + PMWL and PWMO",
+				   nom_bit_time_tqmin);
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 967d76689c4f..2504fafc72e4 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -85,10 +85,15 @@ struct can_tdc {
 	u32 tdcv;
 	u32 tdco;
 	u32 tdcf;
 };
 
+/* The transceiver decoding margin corresponds to t_Decode in ISO 11898-2 */
+#define CAN_PWM_DECODE_NS 5
+/* Maximum PWM symbol duration. Corresponds to t_SymbolNom_MAX - t_Decode */
+#define CAN_PWM_NS_MAX (205 - CAN_PWM_DECODE_NS)
+
 /*
  * struct can_tdc_const - CAN hardware-dependent constant for
  *	Transmission Delay Compensation
  *
  * @tdcv_min: Transmitter Delay Compensation Value minimum value. If
@@ -201,10 +206,14 @@ int can_get_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		      const struct can_bittiming_const *btc,
 		      const u32 *bitrate_const,
 		      const unsigned int bitrate_const_cnt,
 		      struct netlink_ext_ack *extack);
 
+int can_validate_pwm_bittiming(const struct net_device *dev,
+			       const struct can_pwm *pwm,
+			       struct netlink_ext_ack *extack);
+
 /*
  * can_get_relative_tdco() - TDCO relative to the sample point
  *
  * struct can_tdc::tdco represents the absolute offset from TDCV. Some
  * controllers use instead an offset relative to the Sample Point (SP)
@@ -243,6 +252,19 @@ static inline s32 can_get_relative_tdco(const struct data_bittiming_params *dbt_
 static inline unsigned int can_bit_time(const struct can_bittiming *bt)
 {
 	return CAN_SYNC_SEG + bt->prop_seg + bt->phase_seg1 + bt->phase_seg2;
 }
 
+/* Duration of one bit in minimum time quantum */
+static inline unsigned int can_bit_time_tqmin(const struct can_bittiming *bt)
+{
+	return can_bit_time(bt) * bt->brp;
+}
+
+/* Convert a duration from minimum a minimum time quantum to nano seconds */
+static inline u32 can_tqmin_to_ns(u32 tqmin, u32 clock_freq)
+{
+	return DIV_U64_ROUND_CLOSEST(mul_u32_u32(tqmin, NSEC_PER_SEC),
+				     clock_freq);
+}
+
 #endif /* !_CAN_BITTIMING_H */
-- 
2.47.3


