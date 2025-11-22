Return-Path: <linux-can+bounces-5606-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B7BC7CBF7
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 10:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54D3234A5E8
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 09:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F872BE7C0;
	Sat, 22 Nov 2025 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aBn+/YF8";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="wUFsKwpF"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63B2F616E
	for <linux-can@vger.kernel.org>; Sat, 22 Nov 2025 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763804191; cv=pass; b=bNQvI4ngcoIyAibAkiz14OCtZAt8ts+eUhASfdF0qZl2xMcevoRRApKHdIvqLY8/1z0MAPXX99TG/KSWY3BJ4GeNPRARB77mw+sHacDaD+OqnOXS6DqLt1lnHC+alMdDL1ZVXGICaWak3H327ooSWgP8nJMu4MXST4dhuSejbi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763804191; c=relaxed/simple;
	bh=7TQOmpvACKM9dhv3EZGbrAA+qfytcUjxratiPnm89W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lUhvP6zUCcIR5SE/b69vzQyX4fyJ3GkiRjjluTlLzJ1ZS8ZwDjvnewfyFWjSe/uMs8u5fiMui/VALv2HbHEOA0VlhXuHtVDa+I6HX5T/0MjgYCormoogP+821aiodIFFGDlzlXCtBKU9QECbPjEVDryKe6lpxIROE9FvO80dHKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aBn+/YF8; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=wUFsKwpF; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763804171; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IgXed3zFUdare1kbLiBCrSY/erLIaCvst1p+1MMu0z3za3NNhrkThkBlcqxe27WrGt
    QXlyWt9B8lU1HFFHwleQcAiB+EHmsszfNb6AxdgaNOgzODiwfQ73Uwnop4qWYWywqMUt
    Xu+JjCbWoGLfY68dLsMtB9lgEHkj229Fj3j44zpQ5iS4SftG3MC3Mt7spJhNfeboFc+d
    Z8PNwGlmCWWp7s0mtFJQKOSJnyMNv3mHelYqpVlRaJe7Z7ESc142CRpatffKmjtRPn8D
    7CZfw1jfK4qQ3xfL89LlE7AzEqkq/36A/jfYpVWaOnkByyQMJdG4naTeGdnjql6fmCWJ
    +8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804171;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OecnmCr6VTW3Mcb+HgMmAnPusrZgoIdEFzXPGvhkA40=;
    b=lkfKKfy9HHR5VztnA4zrJ4ffUGyiD5Hxwm624GdamkoxDobzk5IohqhlBaQYaR+oWe
    +CtcgbgGy0kw22tEVoFswptfuL9fa3qJyksBZCst3h5ixCeHqZaQf23fz4Xx98Nq0L7i
    DGMmeaDdo0wMArWQfBU2FxXnUpukHqwESNIQZ6erKI8meFRSp8PS7RQtyJ4ux6prPgeI
    Wo4g5VcYL5yVMdxiFwMVjmOqjbtZhgcPDFQriwGU4aX6PlaNq2uGJwA/l8QPH1Kx+JO0
    VWJuqIxuoNihAIkcG3o/NIDLRnFHGh/omlCL2JngD3JmBKkbVbkoCw0xf8NGDmbWCYsk
    +fYg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804171;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OecnmCr6VTW3Mcb+HgMmAnPusrZgoIdEFzXPGvhkA40=;
    b=aBn+/YF8EaZOVrT79xUkJCsOBECmgOR+8WO+7eGuScLlaF/0YzHp9x4TqRuS8DTAX+
    wZi5gDqWPsxckIRb4s5exRpylPJBLo2DDSdM147kdLS1s+nZdqF1yrShHhVO1STMckNu
    kH+i19FlioeKh+tpJCoFHSQZ0IMhZcnUxUqJY7EoKBUg6spOsemTMjvPbhT8RjvXUIV7
    PvAfXTZxbK/D/6qHurpsqJfhI7W1GQN+0LUdqNhID5fEsmqnl1ehMVUvaAh1ziyXm/UN
    dKL5JViuJLtXtm0/a3uZDuCOwOYnMUB8aFy3c0baLv1ncRVxNHcWLTkvSamgDrli4Bt5
    mKKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763804171;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OecnmCr6VTW3Mcb+HgMmAnPusrZgoIdEFzXPGvhkA40=;
    b=wUFsKwpFnBvTmSKBJE2LrisW/M5himnNJ1BXnxk25mCgmIojVIDjmKeKeNKKM967es
    4MkqIXt2Nd0enxx5tmDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AM9aBFdu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 22 Nov 2025 10:36:11 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v6 10/17] can: calc_bittiming: add PWM calculation
Date: Sat, 22 Nov 2025 10:35:54 +0100
Message-ID: <20251122093602.1660-11-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251122093602.1660-1-socketcan@hartkopp.net>
References: <20251122093602.1660-1-socketcan@hartkopp.net>
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


