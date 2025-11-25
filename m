Return-Path: <linux-can+bounces-5643-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457A7C84FFC
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 13:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEFE3B26A7
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48153019BE;
	Tue, 25 Nov 2025 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="JFbBJv5J";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BJ8ODHf+"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB49C30CDAA
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074369; cv=pass; b=lmZoJH7Md4bI6Em8XKwdMttyPE4W9dHW/EuCp6imdA2nDMbw/t3037u9pq8Rk5rfIcBR7C3LZyFdM6XUMYYx1RC7jvSFrhrXa9Sb2RgF/4BNOmubh9OAC8g4KjxPqIjHkydYQLivYoft3AGWHLge5XJrYlYNrqzAisi/KKitcc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074369; c=relaxed/simple;
	bh=7TQOmpvACKM9dhv3EZGbrAA+qfytcUjxratiPnm89W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5wXS+Y55Hgm/C28wuqghMdKwpFMzMieTl5Aoxg9yN+CVoYtjdY/pYRsuDt60hf+gKPJ0wi69xVnmVMQV6kSNWVQv6I+y5HoR2hqGf24jgfDWllbNvzT+YIJhV7O+jUYoK8ITwWPuk0Se03WPkiL+VJXIqOs0HICcEsk9pYVPeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=JFbBJv5J; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BJ8ODHf+; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764074355; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Gidg+zYqVjG6+fhJCtKq2QHgkMaaZOgi7HMKXdc9ivpuaF1ihE5RkCigweh1d5O2Kz
    SF5MGmaRfLL1uEfoWzpTb8imHwsqb3zfhcZIbaMbw1bMq3qoWhm/QUgvBYcmiTo9OKSo
    fIVu6sYickZU/OdYSUj1jR2K+oOl7odNvT/M8bXajhml4z67EA8Ut8Z/EtR8Rdk4E6eM
    x0e0GqZmLXRW8WfoESsD4SYpL7Q2P4DqTsnbBtct7rNUXQFqmCtPZse8zzcVt3QFE1Da
    tAIVKgH/lyckF9wL8VQPn+ctiLtRYQSjv+c0i/mt42ZonWZO2zgNgQ8yvc+rjGsmfUeS
    XhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074355;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OecnmCr6VTW3Mcb+HgMmAnPusrZgoIdEFzXPGvhkA40=;
    b=b0RaT04PcGRDlh+dMxCWA7PdlBppL0KQw7ZaWtjPTdhziO3DpmRMV/gvqKeRAsu++F
    vqxz7lzBxOqCsTuPxM+DmTa69tt8/9V3pPM6nzF6ozrAHgbPr27Vin6FLDpbEW5ylQva
    aDzhC2UOkDHojYbyZK5On6ScqAlXNlhzVaKR6fDfXlyFUd4SXYMEblCsz1IUDZUYFK/X
    qYf6bnnU1/E7thfkCp323GBJcpMIkIy08KC19Yoanzabt45Wbjar5ME3kDodp3YOXEhQ
    MXoB+jpRss0N1bOiI5lvY3TGlYIC8mTKoD/6c9lJLERAO89m/svLzP3FTAgG3BSqa6Ap
    G0ww==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074355;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OecnmCr6VTW3Mcb+HgMmAnPusrZgoIdEFzXPGvhkA40=;
    b=JFbBJv5JcLl3iRFIkSSwqtAtKKqttxtqeDPESk4Z1KyBBm96uD/SBo0rELBK6A0UNL
    VH8WEXYjl/MAFr3KaOnsQgPpN0VhivLuIkiC91DHNWxw+aTmoN8Q+zs1DFqmpWC+iT/M
    I3A+gWmxW2QBPJgK+0P6G+HOHxwVgkLnaUCXK0ELZR8Vi+7V5cBaHMV5xgm8StYknVF3
    WFpFZldAGKt7GQozwExvTxj3PmuXr4ZJSu8rn11JuJkqChN90WqxZjDcZch2r3VU/J3K
    Zpgg2esxVKsIbq98jdvlkgtq5EQsY6CBJ6r+8VrZ8zz9YUXA9lm0XrAQKcMxBE5UZCL+
    yBsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764074355;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OecnmCr6VTW3Mcb+HgMmAnPusrZgoIdEFzXPGvhkA40=;
    b=BJ8ODHf+DmhNDn3ZXLSmh71A45K1+jXZ1P1+mYDrIKZGStBsx3i2Jovau1UA/x27Hs
    vKorhybosVmLYcgqBjDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461APCdFT8U
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Nov 2025 13:39:15 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v7 10/17] can: calc_bittiming: add PWM calculation
Date: Tue, 25 Nov 2025 13:38:52 +0100
Message-ID: <20251125123859.3924-11-socketcan@hartkopp.net>
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

Perform the PWM calculation according to CiA recommendations.

Note that for databitrates greater than 5 MBPS, tqmin is less than
CAN_PWM_NS_MAX (which is defined to 200 nano seconds), consequently,
the result of the division:

  DIV_ROUND_UP(xl_ns, CAN_PWM_NS_MAX)

is one and thus the for loop automatically stops on the first
iteration giving a single PWM symbol per bit as expected. Because of
that, there is no actual need for a separate conditional branch for
when the databitrate is greater than 5 MBPS.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/calc_bittiming.c | 36 ++++++++++++++++++++++++++++
 include/linux/can/bittiming.h        | 10 ++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 394d6974f481..268ec6fa7c49 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
  * Copyright (C) 2006 Andrey Volkov, Varma Electronics
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
+ * Copyright (C) 2021-2025 Vincent Mailhol <mailhol@kernel.org>
  */
 
 #include <linux/units.h>
 #include <linux/can/dev.h>
 
@@ -196,5 +197,40 @@ void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
 			return;
 		tdc->tdco = min(sample_point_in_tc, tdc_const->tdco_max);
 		*ctrlmode |= tdc_auto;
 	}
 }
+
+int can_calc_pwm(struct net_device *dev, struct netlink_ext_ack *extack)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	const struct can_pwm_const *pwm_const = priv->xl.pwm_const;
+	struct can_pwm *pwm = &priv->xl.pwm;
+	u32 xl_tqmin = can_bit_time_tqmin(&priv->xl.data_bittiming);
+	u32 xl_ns = can_tqmin_to_ns(xl_tqmin, priv->clock.freq);
+	u32 nom_tqmin = can_bit_time_tqmin(&priv->bittiming);
+	int pwm_per_bit_max = xl_tqmin / (pwm_const->pwms_min + pwm_const->pwml_min);
+	int pwm_per_bit;
+	u32 pwm_tqmin;
+
+	/* For 5 MB/s databitrate or greater, xl_ns < CAN_PWM_NS_MAX
+	 * giving us a pwm_per_bit of 1 and the loop immediately breaks
+	 */
+	for (pwm_per_bit = DIV_ROUND_UP(xl_ns, CAN_PWM_NS_MAX);
+	     pwm_per_bit <= pwm_per_bit_max; pwm_per_bit++)
+		if (xl_tqmin % pwm_per_bit == 0)
+			break;
+
+	if (pwm_per_bit > pwm_per_bit_max) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Can not divide the XL data phase's bit time: %u tqmin into multiple PWM symbols",
+				   xl_tqmin);
+		return -EINVAL;
+	}
+
+	pwm_tqmin = xl_tqmin / pwm_per_bit;
+	pwm->pwms = DIV_ROUND_UP_POW2(pwm_tqmin, 4);
+	pwm->pwml = pwm_tqmin - pwm->pwms;
+	pwm->pwmo = nom_tqmin % pwm_tqmin;
+
+	return 0;
+}
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 2504fafc72e4..726d909e87ce 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -178,10 +178,12 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		       const struct can_bittiming_const *btc, struct netlink_ext_ack *extack);
 
 void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
 		   const struct can_bittiming *dbt,
 		   u32 tdc_mask, u32 *ctrlmode, u32 ctrlmode_supported);
+
+int can_calc_pwm(struct net_device *dev, struct netlink_ext_ack *extack);
 #else /* !CONFIG_CAN_CALC_BITTIMING */
 static inline int
 can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		   const struct can_bittiming_const *btc, struct netlink_ext_ack *extack)
 {
@@ -193,10 +195,18 @@ static inline void
 can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
 	      const struct can_bittiming *dbt,
 	      u32 tdc_mask, u32 *ctrlmode, u32 ctrlmode_supported)
 {
 }
+
+static inline int
+can_calc_pwm(struct net_device *dev, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG(extack,
+		       "bit-timing calculation not available: manually provide PWML and PWMS\n");
+	return -EINVAL;
+}
 #endif /* CONFIG_CAN_CALC_BITTIMING */
 
 void can_sjw_set_default(struct can_bittiming *bt);
 
 int can_sjw_check(const struct net_device *dev, const struct can_bittiming *bt,
-- 
2.47.3


