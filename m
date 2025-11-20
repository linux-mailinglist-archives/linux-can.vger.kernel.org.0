Return-Path: <linux-can+bounces-5521-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C118C75F84
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 19:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 27CA42FD6B
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 18:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB6F19005E;
	Thu, 20 Nov 2025 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="cVMb6lJT";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="z61UFk2H"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741C229B38
	for <linux-can@vger.kernel.org>; Thu, 20 Nov 2025 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664342; cv=pass; b=hljK165vRqasDo3um/rQpUgcTdNgBdwVSoqL59d9yR1kTFvAQzLmDlHBC1oHlHaVHTt3eRcilSAXnQZG/fi50IJOYVSWTQE0qm4EbD0JUE5kGtzgSHnVUJzBKxHt/wpakBqy61Hu1KwCGx8ni5+g6zyCEamzGeEF4g6PZudq6AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664342; c=relaxed/simple;
	bh=7TQOmpvACKM9dhv3EZGbrAA+qfytcUjxratiPnm89W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWjKULhy7d3KtfteVCzClq2oJvoxe/Wkv8SJK13/3uR5GI6j8cAoopoMc86t22wFjvhGDE7ZW+81OWgruqou44h2jxpQXQkHGuWcccCkY77ML8bAXVgCZtg/MsTwgEC90if9DcrnTNuvM71OI5o9Q/cKY2e5S4yLRMLS9MOBTHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=cVMb6lJT; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=z61UFk2H; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763664323; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=erqdYA1aJSUIq+qJ/ULraDU3MiJK9+kPIiyH9xMZQszVTvzcgHP/pZrT7Y9sVKumF0
    aOM0jIeLpg3qIjzYvU+fS4zvznXxTvJYbyg3Qs+0Cv2GSLWlXWZwXB+2jeIHRY4yx3VX
    YyU5HPwIWC4pSZO1161IdQKJ3d+6jdYC+UswNyl/ZVTqjK5LQyL8eFxmtWAhkkFV/yWL
    ZxgmhFAz6SV/FYKhLtgWNgmdDA1RII15lpnP5uzFb3pW5j3FV6t1KbjYw8UJX0sz6dw+
    rOxKbQ48pNuat1BpDcsvEFtCIjFF25W4J0fp/rC1he85MXn5qXNXnsIncyWjm430Evhl
    oBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664323;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OecnmCr6VTW3Mcb+HgMmAnPusrZgoIdEFzXPGvhkA40=;
    b=WYklYN6wYNNcASWvhua2mrILOFuxqgEZIGgi/R/eIAERkf23Ftv43yPFWseUrcj/Nv
    1J7flpjvXyK3TeU1UfzfsN0Pr66Km1Gz+H/uYtFoJ3XbMacQTyYvvtYny0WxLlqEahEj
    53BS/nHo+gSFH8U7+U/Xjo4XyGYPko4lXPQqbE+nBN/TapMj00riZfZ4KQTLoC7Ew7z7
    YzwpX99eL6fpQ+H22pq+PTH+g1r8Iv7JRUf+MRuABbPkds2M3zc1vD+G3C7dX5wBECOU
    ipozbdEGtqXs99FeNI8LbKJXyZng8yNet9sZF+EBOUvHTUrVTwsq3/9eG9RrVA2zcMOW
    95aA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664323;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OecnmCr6VTW3Mcb+HgMmAnPusrZgoIdEFzXPGvhkA40=;
    b=cVMb6lJTOAcWUfqSh0m3ZvQdw6Bh0rgs9QKrQuGfUxiKWDFeksN0Vp7fq0S97q42Us
    QIlX6oVdDHMq8kRXlWLbIPK1JnWJDd3s2drC7l5C4iWltmSph+9Xqm/nskm2gW8Btypt
    Xm30wKlSUVRg0P8l4LlZicFrJUyn5oAXGYXZVlTawlTzfeYW/sSKgSolFUWP3unvfLtJ
    aYTHNVaPwtWGXkI7lxaooxhqqyQR2Pbe5JmupHo/hVFqt/EUnbNNzaI1mOeVJLPMlvoS
    KX7NopcqcKcJh9vq+0yAVN4H2z0tpmvTurMs8oMqOYZR8VelaxwE8ATr5Xk/sthyjgtw
    wk0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763664323;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OecnmCr6VTW3Mcb+HgMmAnPusrZgoIdEFzXPGvhkA40=;
    b=z61UFk2HoB6wLCdHPIMDbaCAZwswiMeiQg/2jkZqsDJGYltBPvCF5vUSxw3LdI3Iid
    m2ANbkVu3FFkjdLeUBAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AKIjN9DT
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Nov 2025 19:45:23 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v3 09/17] can: calc_bittiming: add PWM calculation
Date: Thu, 20 Nov 2025 19:44:53 +0100
Message-ID: <20251120184501.27597-10-socketcan@hartkopp.net>
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


