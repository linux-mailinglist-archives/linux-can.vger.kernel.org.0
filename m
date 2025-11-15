Return-Path: <linux-can+bounces-5408-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82375C6044B
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 12:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00ED835DC20
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 11:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC31B28D83D;
	Sat, 15 Nov 2025 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="geQvXwsV";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hf5z7WXp"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1637298CC7
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763207482; cv=pass; b=uMcBwqHFzS4ypoVuY5QxXIr0+yyTTbng1GjhEILm9GSvWxrGuBHnzd2+vPba6IDdN5xwKXQzpc+BBikO4UAwVvdbwJMsMELV9ukPG77ylxl+j1FLcgtXBRKLPzML9SgM58L/N2wvQ7x7kXUVPzJDLvZdZNZak9NdBbvzJysYG1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763207482; c=relaxed/simple;
	bh=QMdyW3zHmZKoiUI7ZBC/gDK98NJt6F86hHvhnD0p9Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5A43wTgmlmsU0mhMos+4/6pZDsAzqrplXTACdplCNpRSsOXZacn3rJkLyjdP8hR1ubYUN8b4WBFgyvlpZmXH6RWJgdlbQs/H84Wt9Gw0+EIlIZ0xFOicfY4z/NFtwoL077Sz4eA9rRkhAcH3VZyllvfXdGCEnMoo3enQqxfXQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=geQvXwsV; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hf5z7WXp; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763207466; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=r+j5VDM0N8+ud92+fPI4l6WKC5F9E4G/x898HFD4Wtspr8k3mtyzcvRXK4dZt9tXaj
    GNVDT3laG86Ekzuuk7Huq85ag2NbyTCG3ELpnVOVIPwzFW9G0G8t3LpjjtpnrhU7UfKk
    sN3x+vfa/ndVoYpYcVmp6XKFNWdyUgSQAU2b+jNR8lAC8ixOBUm48hW59WHJRPqDbvqN
    XuPptgeno+sIz7x+glIhEXV192aWTFeN4vgkdk/RESr821JlBnHQhUVYT7u6uG91A6gG
    VcbVwvROIXz2QzgGaUZRJZ2uULUAWQy+cXpjLDAzMkzzPnoiLfbGNGpesf5clntjY68y
    rPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207466;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=gt+aLL46waunKdD8iIUU37EI0yTQKZKJb6VNrjK7geU=;
    b=DZ1EYz1TE2B7+FM26VG5L7Kus6H+FBrN5U8VyItX8aIutRTs8aRhhxeOwuUqDE/NEB
    klgQzj6ocvsBwXRpcdetltEInRaPkAPJTmy7bVA9ionuuNe9qdl7+z+DTEtNvE9icbev
    JdKKlT4nZ1wK4puEpVVKuE4QQaHncD2A+pP9jO9dJ+yEHLEJlgbymkxW+fo/cG8/3fK2
    Wq2Hhj3kbOHKansswqkw9emJaaHRhR/j00HzFZNuXV+F9tWDHx5yDG/mwV3lQhXip7pg
    GkA/d5CanGPg2aSgwnZT7h6z/Q8LFu7UZGxAPj3K2KFR/I536olpUjiXtlAcKTPDydWi
    lbug==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207466;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=gt+aLL46waunKdD8iIUU37EI0yTQKZKJb6VNrjK7geU=;
    b=geQvXwsVbRDbg6U3JCKdzIrQMGCsUh09oorksqfTf4JdGIwb90HEtfgK/ptIv9tj0K
    brSV9rjwcQgXaz2DuRJtawS4Kxvu4xkfPtxCCqAErwI9bWs44gcxOLVpfqWiGOTPLFbR
    g8vGGlo2PNeclVram3BOIucG0ZuvcZWsJ8cXz6K8jcBPgGlaaUqFxjsz4jmt9N1rlIsK
    iAnzLNEnYlKjy8a/C2vD+hRdMyKiJhhSp9t1TBre+h56/Viul41B0qgr76Hsgi1bsedA
    9ao3M7yCLglk+TFOl/mQjnVKP5LtHPYUl+pMjx5H3+GbcaJeXRj9ZMJEiF5nv6wLOXqd
    v4IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763207466;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=gt+aLL46waunKdD8iIUU37EI0yTQKZKJb6VNrjK7geU=;
    b=hf5z7WXpIwhTC0zYO7NLyLfy/weslhuIhPe1tT466BxqPOZQEnobyD9VzbHq1cprzC
    HOmY+XtiI3e/YPFTgfBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFBp6dZo
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 12:51:06 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl 09/10] can: calc_bittiming: add PWM calculation
Date: Sat, 15 Nov 2025 12:50:52 +0100
Message-ID: <20251115115053.72673-9-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251115115053.72673-1-socketcan@hartkopp.net>
References: <20251115115053.72673-1-socketcan@hartkopp.net>
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


