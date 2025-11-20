Return-Path: <linux-can+bounces-5517-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 785E1C75F5B
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 19:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56D564E07DC
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 18:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C59288C0A;
	Thu, 20 Nov 2025 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ijnzQgHU";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DTUEqRV9"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B12222D0
	for <linux-can@vger.kernel.org>; Thu, 20 Nov 2025 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664341; cv=pass; b=jw3CfUDxAOyY8F8GZ3i45PoPGxEsPAVZoUhP+iPlOia8Kfs5NuFTniYBd7BLcuwNMGLO6wR51z5af8U35rpG/BqNqlNP07b5sAXOiw+WIivxIg7DWzrLU74IOI1RelIVixM/oVz6z5wPyaf5qe6grju3SqYoSIAC4tBAq9Orb/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664341; c=relaxed/simple;
	bh=7j2xEeTk/m2+DN5Iykj0qhGG9OmkqarO8FALorOnKBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbZlTW2Slq0V2f9vjBUAMjziQvGBQh/oMx6QcyDN7Z/Htj+5yRUYKmkhbd0WYajd2uxSM6oA4ZVIXflx5KSjB2ODdC1OqB92KN7Y1RyucD440SGA9yKbK/vyZ64uQ5PljfG60+Wt8HXKaqIln4w9C769pU6HGGB/JBxaDlHQIVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ijnzQgHU; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DTUEqRV9; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763664322; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=POuG/jluOoBXKlAFkPAlyIj+rAf8uFXLJ80Pcu2SGLdJ/YoLdRc4NcIQUpMVMZ70lV
    7eLPLdUdxzWqwYO1xgkHNy9yfH07x4j+bwHiele+NEuWsMtZr/acJ7CrRvQEgVkoRP+9
    KQW7VyvKd0xXuBclncF54YjWKLqhFrN/SDJ/OT4WUpLTYCKOHTQb84OsqYB3pGHvWPZC
    M2WlvtNHzj0m5KHVz8G7zdmHNWln2pyxpjLoYFILOH4QU9ZgZQDjbXgbwxrZPUeaGsuV
    LrI/ZhKDqP5giZmFX9gCGHoQMXEmGAGu7isQNyzNbbwyg+1wQiWu3dMvrn6V2OfMi6Nx
    mggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664322;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=fxr+ivK0BfmFpozMhJ8Tq8YhIwTZXVRH8YT8IdpO5UM=;
    b=LJZleeEZcXXWmUq4GXM8b7fUCGvW+vxWhA9dPrT6WikWkoZEhE2ye5GeNR8+5op84K
    4/pBFC/Noc7m1KbLshniTZrJEv/2rYId4v45Yue8u+3QP+LRDPn9xVp1x9Snnd0RO6wg
    Q9Z9mkcmAIg2TUPw5FkTzce8eimHJ2lpCcJT5Lq3ZlM4P5wuRvW0n0fJZHVbRsk0Efly
    KYDtP3UedcgVoSyGwZB+MqpaVTWWTWJ0eudtN3aoBuBMbZ8xT4hHpCU6YDlzsEnAYoWl
    nHAm810d4dMzt+w0R1APA0c9D4sTyzSvRXGwDTK9Io8HOy6C7ve5movEonZymCa6gO+U
    Sv8g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664322;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=fxr+ivK0BfmFpozMhJ8Tq8YhIwTZXVRH8YT8IdpO5UM=;
    b=ijnzQgHUrY67/6UZ9YmptAdn1xNkptrXh1O9D/pYFo8PtwXZIg+fE37tB1IMTxY1rO
    o6ZonXsLgTX22WVn2XywvhlzsAkNeg++8gD0U9QWT9hkNSqNDZ7znioKpyh7aitla7iW
    Z0vdfcliX6OlsIPjtt4akX597BIC93CCMF87KY7rkssDgmrMzSSd38ZDzWIKnJ2XirFe
    wcgj7537ORYZqd1F6k/RMNZ3WdKqut395wIdV9e85HBk6Ln6ATaLW9fSTBFxLLyoIzaa
    StQuSpeqdJQYCXBC2PdNw3bb3xEbwUDtSbyvw3udqRTZysP18cyGM+yOn9ixY66s8P1l
    vqVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763664322;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=fxr+ivK0BfmFpozMhJ8Tq8YhIwTZXVRH8YT8IdpO5UM=;
    b=DTUEqRV9hNvwPe4VKZIaXTP0SvJi8kygW39rHzP6xJ3tNr0qOiU/a30xyfbArlV53N
    VGfUde5+HNxcwjSk9tDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AKIjM9DS
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Nov 2025 19:45:22 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v3 08/17] can: bittiming: add PWM validation
Date: Thu, 20 Nov 2025 19:44:52 +0100
Message-ID: <20251120184501.27597-9-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120184501.27597-1-socketcan@hartkopp.net>
References: <20251120184501.27597-1-socketcan@hartkopp.net>
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


