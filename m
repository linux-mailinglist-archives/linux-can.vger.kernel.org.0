Return-Path: <linux-can+bounces-5434-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E4BC608BF
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 17:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F4DD4E67BB
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7932FFDD2;
	Sat, 15 Nov 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="fI5rc4Am";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aREb8z2S"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF22FDC41
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224688; cv=pass; b=DouUv7+LtZgvuOW+2lqePO7z1ZigbeZXNl+xd/aL0dDIZhEGuuaQIsuccscqnlT8tTulsJHjqplkUeglW++CVjowVY4EYYp4iRaJQFBrY6ybacd6XkHKh4fEMUyUqw9raF9S1QssWrX7R9Bjbvwvld96kFEes6wdVajq2hb5iQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224688; c=relaxed/simple;
	bh=23wfDU8iNiFUQ2LlvLJdlmBm/XoRUdO84OrXjyNjEvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwhhdFoRsoXl0pUcu2J/YufSEABPJqVxpbqDGX2bNfkK3oSIsBt5MusP8fcviOxf/592j+J025iEH8hHfyWc5baOV8esjGUb3ObTy1kj6ryCi6ULTrqKT0Z2uzSC7hXaFCDnGwZX5/tVLNW33oqxE2kdKfdwSu0+GO7QMHpB3bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=fI5rc4Am; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aREb8z2S; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763224675; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aEe9cA6iKy6+RBQ2wRRP0ne02vMiKebEWam9PrgstbIO2KCTqWHZ6KSTe+nkfce0X8
    uPJmnFq6gno+QhidiMa/LZ36G1jYNdkA8P1KaaHeCgx85NNkXhBp3H5m26ysKvMP8tFq
    Xwo6Opm0+fhKXnv/U4xbJ39KxYlmW/7/LcPajiozaO8QWtff7CkLgPp8fnp82cxQatHm
    U3CU1m95Kebqov9IuGsYHkc5sVU+FT9Njh9nNGo76JPk6V2f3j/6y4sQW7Pf5/I/bNo2
    86UfhR2aJt7nLxX9OftRiZCd8RTqVg5Rcr3vjQi1uV0BT8kIgisXUF4fQ1RKQKtMtnUT
    j+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224675;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LsDAly1WY+roJtvEknfktQH0KGiIHh3NwNDFBADLwHE=;
    b=tWvtw6tNGYzoFX93iUJp6YQJJo0nk0MHzfZmeGRdMO08L9LJmVy2cHJgWO0C8Ty4wC
    rkgMtZ77CtyY0PLEhRr74t6LpIj8QN4SeQBaWWWhQ04kUhAtdVkLBXDMgDq16g70yLj/
    UMqNoZwYzNsRDV2/dnsIMZVLt91f2U6HBRv+nJAV/zcVsWVig9dm6ideEtruTIl3w/RS
    xgh/wJl/MKLLQOLQCFGG8h/x5WObVK68TmhBV4peyTonEmV2L+0l6lN4iGTQNXu09fe5
    /rsFP8D6p1XstBmDLDFKDvzmov/Eslcl2qgiEmD70BentoMoBLkMedhRkXvLyFcFRGIk
    dT5g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224675;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LsDAly1WY+roJtvEknfktQH0KGiIHh3NwNDFBADLwHE=;
    b=fI5rc4AmCMtixP2z4iJhK5tYoS1PAvEzfL1sh1OnZ4M1q1EJeCZ0jYEhTzj3Q6HjII
    6ZLD1YEVs6rPCA8olMYaM43RO/cAnkxPI6TfHn4k3jrZ8Hkl3Hxutlu8ZsK4ymSVf9CL
    3T/B7Gs6yFRlNMM5YM9nrkJIeW1TbqvDHhkzxsdGdZsnlBJseK+aZc+bQ9q9+v+qoeLV
    6PZHugHjKfCgYYvFwdDmNpQSDnfXT1ES3yarA1d17mYzNbjbabOGYpZZCW1qe242Hpqv
    2tH6bqSzVQ+LyJj9EDGf2gV5U5hBHS7x+SruFVSVtAg9eeEXB2E4nuh5v/6cLRb2ckUh
    ormA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763224675;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LsDAly1WY+roJtvEknfktQH0KGiIHh3NwNDFBADLwHE=;
    b=aREb8z2S37G+Ep1yhShAVUWq8y9SoKYZklIQMQH9dMPNClLGu0h73JnR8eprMVW+Hz
    xINJIHq/MvUMPwSNlNCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFGbseQr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 17:37:54 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl v2 08/15] can: bittiming: add PWM validation
Date: Sat, 15 Nov 2025 17:37:33 +0100
Message-ID: <20251115163740.7875-9-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251115163740.7875-1-socketcan@hartkopp.net>
References: <20251115163740.7875-1-socketcan@hartkopp.net>
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
---
 drivers/net/can/dev/bittiming.c | 63 +++++++++++++++++++++++++++++++++
 include/linux/can/bittiming.h   | 22 ++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
index 0b93900b1dfa..730b1b254460 100644
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
+				   "The PWM symbol duration: %u ns may no exceed %u ns",
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


