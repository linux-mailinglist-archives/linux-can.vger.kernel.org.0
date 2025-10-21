Return-Path: <linux-can+bounces-5257-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A4CBF77D4
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 17:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF145188D645
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07E4347FC9;
	Tue, 21 Oct 2025 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4mtj3Wv"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1882347FC6;
	Tue, 21 Oct 2025 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061682; cv=none; b=JnE+3nmwKGJZcE1/6JFVu2Kahx8YdSlNIeegbGHlsR3cqBzROSEvvvJgt6VtqHsaDZY9pBaL0cvHRJlWKUf2KLGRtEvIJ+TrUK+r3LyI/L3tbJ1DrIWz4DmygIrSUgBVtr600dVzAQ2VQRFrb6eBK0y/ifn6GVfjTOHEbAP+j2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061682; c=relaxed/simple;
	bh=wgyZ2odVA967H9e2n7Zm+24TtnChkr4ICKvWxS8dJ4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h8JO1HeJmaXtlzqKsmQOarFj7lrs13bAjag8fcSnlURvwVa5YAXUq9G++JPZ42XSYd0yIzHs153z25FCnfMTEmy0VQxKh6Hz5Heo0QuDuD3ZOgVxuVg9TKln5/Gbws6cyVL1OccqrwDdAMaxh2o/5yBoADDQjD3ATGtwe4o9E0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4mtj3Wv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E4AC4CEF1;
	Tue, 21 Oct 2025 15:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761061682;
	bh=wgyZ2odVA967H9e2n7Zm+24TtnChkr4ICKvWxS8dJ4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A4mtj3WvdBPjLfHsF68+78UlIieSp5rcTAMo5stNwvfRxWnbpWPGCcAxmlM/+0wwo
	 muvJQ1iDa1ienju8XIGfn1o/z487fnZfrKdc362sc0nGHxWdPLlO2CQJrgmQ5Qel0c
	 0wUOBdCxpMmz2oAM2lS7qY4pf9qAdZsDvQFYE/LhR5eK7Ti62pUIL+RUCyPwogbziD
	 KBD9MOnYry5tPjsBb7T3WEMgx2eswlgvxh0Sc4hzq6bfpEZYDpzgv8cuQ7hj6vbG+K
	 dIG6kNkOmjfXC38dqmPpBj990VQcW+WvSQCkK2YZK0KbtS29irKvbKhxP1teTyRPOW
	 QsorVfOMYcyJQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 21 Oct 2025 17:47:08 +0200
Subject: [PATCH v2 08/10] can: bittiming: add PWM validation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-canxl-netlink-v2-8-8b8f58257ab6@kernel.org>
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
In-Reply-To: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5186; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=wgyZ2odVA967H9e2n7Zm+24TtnChkr4ICKvWxS8dJ4w=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnfV0tyB39KXbOKgTG/d4+wWHzSXY0nWlOkpgRVZrp1l
 5cvYWToKGVhEONikBVTZFlWzsmt0FHoHXboryXMHFYmkCEMXJwCMJEpsYwMb3I+LmDSa62UXm8p
 /TrkYtKP9Rm7WhNlDgofv7fEIsHkLyPDKzPvTQf2caddfDvB8vLmj2weuwOjlgfY6azf+HBNSPR
 CBgA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

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
 drivers/net/can/dev/bittiming.c | 63 +++++++++++++++++++++++++++++++++++++++++
 include/linux/can/bittiming.h   | 22 ++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
index 0b93900b1dfa..730b1b254460 100644
--- a/drivers/net/can/dev/bittiming.c
+++ b/drivers/net/can/dev/bittiming.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
  * Copyright (C) 2006 Andrey Volkov, Varma Electronics
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
+ * Copyright (c) 2025 Vincent Mailhol <mailhol@kernel.org>
  */
 
 #include <linux/can/dev.h>
@@ -151,3 +152,65 @@ int can_get_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 
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
@@ -87,6 +87,11 @@ struct can_tdc {
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
@@ -203,6 +208,10 @@ int can_get_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		      const unsigned int bitrate_const_cnt,
 		      struct netlink_ext_ack *extack);
 
+int can_validate_pwm_bittiming(const struct net_device *dev,
+			       const struct can_pwm *pwm,
+			       struct netlink_ext_ack *extack);
+
 /*
  * can_get_relative_tdco() - TDCO relative to the sample point
  *
@@ -245,4 +254,17 @@ static inline unsigned int can_bit_time(const struct can_bittiming *bt)
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
2.51.0


