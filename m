Return-Path: <linux-can+bounces-5583-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF45C7B8D6
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D1EB356419
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D143C30217E;
	Fri, 21 Nov 2025 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LhGNzH/d";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="r2jw6euI"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0162C21C4
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753749; cv=pass; b=XBhPc8nxMKm0Y7i8++o+nQC803luXU3deBKnnRKn8V3ZbDQ1cCpshrUD16lSTeemk/KZVLGv/Cy2zVgLH8TTkz1nWReSTQ4Znx0ROBA71Ppf9WrjkjYd8PlRcJjxhxP1RYkAbyB7Da9Ci1dOfXYvhldRzsWwc+zrJtGMzCauvCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753749; c=relaxed/simple;
	bh=nNB3rtZi54N58ssNZf8sHSKTveYP55DBOpxafoykIio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7t0sgbCAybCRdI6KbEEIhfH5UCeVJRLUBkdgmvfrajkIy7Ufk7oh2gobkb0OKpKzMYEzqgEIMt1uV0cOdPYi6/alyO9ywFmdez4/iqLx53Lb/z6uz7UCZdc2dSdehvoMKudj4Ushop/cHvnLZP/3ADT2s9VwWfF1oV29EQ6DfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LhGNzH/d; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=r2jw6euI; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763753729; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UuhPJPNcHjltKz470HtT/VB5uym7T/KuE8Zsc7s+EHVbrbK1mneWjEtBzzsG3wshsw
    TGcyZIyU8sINVF+rmInIvyULCRDUjtnMESGXJ6K3CR3sJzWgPSTUUzIoPNG1FN0bBpC5
    XWpU8SgoiYJWv5JW8BE6pxbdMYlO4VKxbNhtnd7i5WvrXiThIEshe49kgiCgY2CBtg+O
    vx9eSDj6p9XhNAGcqKl6OJAcMGKCyuYOnweQ//W0kTrA/kacvTRF+uxp6tviGPgfJuCR
    60XCX1wvc8ekHHICSFAx7ImW/ZXoSp808J/7CgeBTkskzbFA5pVrHdVsC3jHolPmUPXY
    0g1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753729;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=L5U+Rohfkgikup5nkc6jw8yTaiwj3tMxUzrQB6dHBoM=;
    b=VMDB4nKrtMr2KjOXABrsLkLYFO2xqqR+deGd+iJ2g+MDDPxqgIs8PnL8dkTDZMXauC
    ofgCxld5TLH3oIpKIZEzvAk3rp5UdQunheMGFGQkicetZZTO/QQPCEERBtqvDh3LUQwR
    6h+kmi+Tm/HAp/V2ODJowLcGSzF56aGJKNem7rUTRkHET7lAMd/BUt55qmnHC9IpnpIA
    XnS9rbHiMjuap8V0wjsRXBI6G7fEmgFd6BjrE9XIxbpeMOg5q66Q2saBU7DLv8yX/PHj
    HZ5b7C73iYxuAxFRBXhPeWEhpMrY2M9LBJIaNW9cGTJyAWkCfOYH6swleKbCb0R0F62j
    MlbA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753729;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=L5U+Rohfkgikup5nkc6jw8yTaiwj3tMxUzrQB6dHBoM=;
    b=LhGNzH/dWeAp8v3/rB1atqkCOT/H8R1ZSoiYOgVXL8RyYKwrm6opdQyeXU3gny+6Uv
    xEBU9+xuzt2Wz+xx+FovDXhy/95HhMJHLRFPKYNisOrFbCzgin4lgpB60axl4+wTNqdr
    mWeKR1v2q2vh+cBiTPvW8a/P/rkxKgV2FPQtjxOykkHKfeZf3XORfcWpn0Dv9YA9hHN7
    TRFJI5WnMq61fh79fHimJhu4wMQEl3jCylRwIDs5t8CBUb4EYj/HdPvyhud2NHLHzHSd
    sbhmOTfJDPdTKgQ8GZOHX0IEtBABauruV+m+QE0z0epDxk+DQyunDMMlF356+15Kqa6N
    rvkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763753729;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=L5U+Rohfkgikup5nkc6jw8yTaiwj3tMxUzrQB6dHBoM=;
    b=r2jw6euISVGhwDnYYiBPnpTq6sT4lXUiMvjJ4lD1XjdgR7nslGSbkckOe0H/kRvGC1
    vkSXmErHRp1fg5tnUZAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALJZSEnA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 20:35:28 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v5 09/17] can: bittiming: add PWM validation
Date: Fri, 21 Nov 2025 20:35:05 +0100
Message-ID: <20251121193513.2097-10-socketcan@hartkopp.net>
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


