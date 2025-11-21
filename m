Return-Path: <linux-can+bounces-5536-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A15C77F39
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 49683332E0
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 08:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491F9277818;
	Fri, 21 Nov 2025 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KI+qL/Ei";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="AIrPaog9"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C702836B5
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714085; cv=pass; b=u2OVxRuCCPHtUzyug0HhB0vcQkq8Nbs5U6+xe4DnXuquoHyXaTs7toZTTDCdHZEetTdKdMt2Ut6KjOuLUFHGEKlxBRYESyYM+W8htN1KeW9aJdOkv1NWvz9ArgUNX23oI7ixKswymYqG9WfH8xI15/AYmQFpAFVMZRG1Mc5ODto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714085; c=relaxed/simple;
	bh=7TQOmpvACKM9dhv3EZGbrAA+qfytcUjxratiPnm89W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJYIzDZ9dcJAyzbCSR4hHigHbHjkXhw6x8Q7VR5XQo+rMGl0+hxKMbLgiR+eSHJmxnY2k/tyDsyMvS9txvwc+xC9zqOaiustXBd+txV/0PD8ayiy2DCcFTTumHp6mbxxWqMxD7RHrgFQhJ7QsqlvLHPzAC/6m1na20gMGg++huw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KI+qL/Ei; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=AIrPaog9; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763714070; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=srK3ZBsgr3H00JwFmqNXDaJsN2hLoB19CyZgkPNft5+X+qYwfgB8Rd8ts72fhRkotl
    x5V/cJWojXWdwQElsLoejoaxmEXUpgWoD4P6cLRsNmnE3DmbDruxkyFM0KxN6uUqMgYe
    OvmxCuojNc5vaCDTab6odolUKW+ipBDe6p9rjJEnnfLqOiFGWQ9h+/bsgHce1dv36tMw
    zSCWbpc3kaNlcSXmVwBZrojNnFwLsukCjSvd5ZNXwd87fbdyKVF+CAnrPv80dahOrvTI
    JFzvCcmg5RW62sHHR1eKcLXGbPgPOXY6OfhT9P5d0JcSv0xqb52E1tMhicZsoW8561oz
    O7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714070;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OecnmCr6VTW3Mcb+HgMmAnPusrZgoIdEFzXPGvhkA40=;
    b=GSwIpLpFmdJrt9lL0gn0B+FCLwyR0+CqTIkW7B04KjH5nrUoz9RWVd647jOU0pg9vt
    Wv5V7kGaYseg2Xbc6I/q9OeM5tfCUWQ3yKEeYSTSVhYIXuKyijjxz7KHpaVkI4rDzCOe
    BDUC3PbXKR4R8Dxvtf4R0YCP5IVpgILdmzu/Py8l80N8shlN1nEufx4YEpuLGOa6aNOF
    OwN1B82m/ggIFuBbdqrqJKNylzt6vuRFI8RTSHc+QLT3tDjH6ve7kg5GVu4WHRHy7f/9
    fkcSjPIhFkKNA9bj/q3v59yA1AJmfNL3G2EcuLfmuBChWfWlZy5Yi+xnG3noi7a0y431
    pQtg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714070;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OecnmCr6VTW3Mcb+HgMmAnPusrZgoIdEFzXPGvhkA40=;
    b=KI+qL/Ei3GGpQg/hNC+FqS8MJyjCqngeBiz2u43IesIfcROIZEn2hZ+ApfC0k8Ltju
    G+gZ+BsPPVjko6t6EwF+xXtcdR4Omt0+3dbM1sXNztmorwhmhQr9dpIWXz9lpMfqkxzZ
    2QOD3LqVmYO+2fvoOf27qSQiZ8UWoSC5U8FHwi7NfIMZOtJogHNAiIp5GfTtXhgJ3Wgw
    qmQtLv+BQvc15MOWSa52ViGL0sV9oYA3oI/OoKvnWKg1muyE8kWvxwWWMK8VuHajDbkp
    ka4PCkNqrMMKo8zb8mgcbfE3C/beZ8rjiUNyh4cPXNKT5qgefdDPgJK1f2wnyDbxrTg4
    SgLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763714070;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OecnmCr6VTW3Mcb+HgMmAnPusrZgoIdEFzXPGvhkA40=;
    b=AIrPaog97Pl6QWOS4M/cDil8pw7Cfbqe/iqlJCI6uu2WpGt1Q+4LAQst5ojXZCUdKl
    54GIlunvqNVzghM14pDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL8YTAfx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 09:34:29 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v4 09/17] can: calc_bittiming: add PWM calculation
Date: Fri, 21 Nov 2025 09:34:06 +0100
Message-ID: <20251121083414.3642-10-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121083414.3642-1-socketcan@hartkopp.net>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
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


