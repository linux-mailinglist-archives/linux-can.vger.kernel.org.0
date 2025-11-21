Return-Path: <linux-can+bounces-5581-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B872C7B8A1
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E539F4E77C1
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFEF302CB2;
	Fri, 21 Nov 2025 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dtrvl7C0";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="FxAcg4up"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1265927FD49
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753747; cv=pass; b=MmtFTSosv3+16hqsNtsK+jk3FY0EGUIX5G3LN1QxJeDHiXZS5TA3rTVCBVLei2xIku/mLVNS7NGsnQf4o4NBFbfJhKAkiFNypdQhwbLIt9jS1ypJ3f9YMp1WR8/6qot8HjNxYFxgeVTe2BblUWPFEs/Ab9cLFmheHntE8ZdLKlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753747; c=relaxed/simple;
	bh=7TQOmpvACKM9dhv3EZGbrAA+qfytcUjxratiPnm89W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUlpfVTgXCEm7puBYKNbb4gUSiA7crnd+4EuhID/q5vz499S4ynWgiNC7rbmaVeDD7jNFqR2SJKQ8psbxJkvoF048eUqw+S92HD6CUOgWpsBC+rYtPGVCG/sCykOIyGNi3ZrghZU5beGWabHOLKoPTemgqeX3k0ihVXCfUq3/As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dtrvl7C0; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=FxAcg4up; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763753729; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DBFGt+Qiwg9KqGEQvEslbP/5Ns+jKrF2ykDIAdrlPiImVjHG975dHQePO1u237X0de
    6Luz+0FROkCevcCunN0LNKw34CZoN/QbvCmn32jx2lKxaXl/aprZ2dV6Ao0xFsQGiVq9
    feJwK3SqdxGGjsy2DGnaVIGOc/mHcF7bGIOxwDuFCSdrkz2ihS2/QwlOt+P9y+Sq80Q4
    oBQMJQ7YDKYYivRgrDNlpYwLF84q/htHvFUnucJuqoTN/zfVrVZpxbQXcP3JCRdGpQil
    YkxZ0XB7/6V2igRP4X5nBPRXr9+Zt+KN5q/Rfsc56FcQzufvpSmjcmOtLJD9FjH5LrgJ
    /v8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753729;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OecnmCr6VTW3Mcb+HgMmAnPusrZgoIdEFzXPGvhkA40=;
    b=AktKtAcDYvA7qRjIQLh7Gx5fbqPZYIPJZXE9mrgg8UMizOcQ+ZPn6Tg4gdGlLpF5Av
    KMpgrBwgcnVOXXMvTS0Jv7Jide0ui2c3dgK45w7Ak2m5QQseF0Pnwd55/iiLsr7itJKr
    lw1At45RfC0LuiIDQ2HHYwJthho/pQsr+Id4nHsP8xYdrRF3WY08/AjAid7n1gAgb8W0
    BRrFyw+8x8LnATecc6LfdkKsYrK35YLhO5IhOcm205P2ybJDeiaD5zWYSRaT7qp31he+
    i1OwgYvFyVDWJ1NGWQbhvJXKwZchQau1hj1HNH0crmcKVvDmt1fydjejkA+VEqL0+Mrt
    pjIQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753729;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OecnmCr6VTW3Mcb+HgMmAnPusrZgoIdEFzXPGvhkA40=;
    b=dtrvl7C05MR5c/Hg48nyBV4y6fYi6KTuBxO7p1OZUSZFIiVfo4nlz0Y/l79A+97wxL
    1DPF2Jk/1a0hTPSvD7RWuCRhW+xFCj0S21KT+j+RRznFxfyMIIgb3YHtyfreKOjFhdun
    oajIMw2IqXCbckTk0pzELu9HTBSu0YdILTIClR0NbCYXCKmUzRU0SHRINg8QI5qJWP+V
    FuPt308pM3ywtMR4ZTsClKzCj1PBcI04TZ0PW31z5PQ34QWLwbv09lwugNLJ5fwuSS9l
    k0qXBt9PWbof89aUX/F85E3NRAzNesrkdC6wM1/oVa4XuAlprgksdD6mv/BNTinxyxfD
    95kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763753729;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OecnmCr6VTW3Mcb+HgMmAnPusrZgoIdEFzXPGvhkA40=;
    b=FxAcg4upMGppyzBxMfikVHu0/kT8WjvDbiiASNhPQdNPW9GUQAulhpYDTO4IUywsck
    dTjM1qyZ76noO6ESFlAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALJZTEnB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 20:35:29 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v5 10/17] can: calc_bittiming: add PWM calculation
Date: Fri, 21 Nov 2025 20:35:06 +0100
Message-ID: <20251121193513.2097-11-socketcan@hartkopp.net>
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


