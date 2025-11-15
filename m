Return-Path: <linux-can+bounces-5428-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC55BC6089B
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 17:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D890D3B5775
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 16:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827AB2FE56B;
	Sat, 15 Nov 2025 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WgMduvhJ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="xYcCZW0j"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB782FDC41
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224683; cv=pass; b=BLzU48RHdHAqEYyfHhTRULmxNzHNRxN7S5I9Myrv11D2z8NxyWa/gjIqBGdR0wr9CPQIEiuED7WnUrH8czFjrmOKAJRNJ8tqpSCaxhB/430rixaqJl/FAQRVqzp/ZCReiiixnoIOItVaMvHdGvc0tU5EirNh8/lXbqWR22tYoqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224683; c=relaxed/simple;
	bh=QMdyW3zHmZKoiUI7ZBC/gDK98NJt6F86hHvhnD0p9Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSn3To0Ou6ORroddMU/apelTvI/uwHo6axZVNBfa0FJlfRmDa/3C2gk98aIQ1Tobd3e3T75l7m41KfQ4RkFskvem0/YPWDHImWlHdaLlCdqBXSdSsUyoPXDwx7vU9wLnnBXUE2OJiwRqD/SMC7nYbFNhfWGeLyXtWVDXxTCBPSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WgMduvhJ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=xYcCZW0j; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763224675; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QeHgqOAOXgROmozohHy/3X7DMa9WDQ0iHrIABsWqRprRM1CCZM+TP3Z1eRCG99mDD5
    Fo9wHeGfaiLoUpfL8lHemUIHfEQOKB/AwrDvmPNnmc76PfqGE1dn/A5LWfpG/Z9UhO7K
    2MINajsRkN41stQEQh70cxqP8uMPVNzx1Z68zIKzc6RL2b8l29+vSHYevBtbmf6y1Xut
    oUFyU1vto8bSkKm8AdB98vh+7Hvcg5OZS+Ph0VIMxMurbitXkugq4NCB73aOVSaFmyJf
    wNHbQYJxuQtlP/axoXKJ65gJRzT/+MOkUOxtcDuxf76QE8Egq2dqdKShwUWeWQurgxkJ
    OIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224675;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=gt+aLL46waunKdD8iIUU37EI0yTQKZKJb6VNrjK7geU=;
    b=ekjeQt6ZhOKyP/OaT6cm57FcpFD5VprwAnvJ2Nwh7X6m/lK7dNE0jU7x6SMAM4LGN+
    GtsgsasGIdjEvOm+7Wx2AeIwqDtCNodEJYQnkgdThqPygGsB/zurGg5KS1flO83a5aJt
    Lw9UylAQbLBYvhOBuKDPQM+o8tSTqAry5wXTvfRG12Vp+rTZOsI2BlCzjc3bbvjwPjcY
    YaxzvAHOijkn6JendI6wd7SpSmPWiWJqt8O2sgHfeoqwOWqlvLLQGFvsAUzPIqW6a1ZO
    VakdEhoG6aQVQ40ZdLNgOMYyvzw1+kjGemOvhphN4UcabIBMswN8E5vh/Szz9Vv4RvIZ
    DH4Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224675;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=gt+aLL46waunKdD8iIUU37EI0yTQKZKJb6VNrjK7geU=;
    b=WgMduvhJXYiF31vyD1qEsrcO0zlL/QnrUGJ87qvkjZiJ9jQDmwicc+yHcR/3EXzlKG
    VynELMefYJ2Rp/wcqTqusZDz6N3Y9vtjmsPH4gkPtVmJ11bTxFjTaR3gyES5IWfGrO36
    rYne8O5JTACHpRf3QMmlBggzchdGjeIa5tz0+HCl9Dgzzqwr7d+NP0XymPSAO48YZgvs
    kyC/Yl+OIGWp6Uyl5F54/OEnlsbiK6GbVh/PMDgWNqqYC8kRFI3veYec3Nc1J04ITM7J
    bwmmWtkK6H5pwrXcq/A3LCA6ca4IEGE+73mmDQXzvhgb2M73GB+4YBFiAhHZz28NFu9r
    oSZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763224675;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=gt+aLL46waunKdD8iIUU37EI0yTQKZKJb6VNrjK7geU=;
    b=xYcCZW0jZRM/k3KyW5W1S8gTP6SQRbrNideD5X7+OEO4jzjfGJIvgzgGpOau1iS+Fc
    ZT3mwNDzwNGcblfyfGBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFGbteQs
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 17:37:55 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl v2 09/15] can: calc_bittiming: add PWM calculation
Date: Sat, 15 Nov 2025 17:37:34 +0100
Message-ID: <20251115163740.7875-10-socketcan@hartkopp.net>
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


