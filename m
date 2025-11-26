Return-Path: <linux-can+bounces-5705-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 975EEC89A2B
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 13:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB25B3562FC
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3EA32572D;
	Wed, 26 Nov 2025 12:01:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902E227B8E
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158487; cv=none; b=IWyQFyu9C6H84BGxUa8/2YfK4NsW4iRPvJFdmJ/hD62HIZetv5YKBOfOmCBVNOkaBY5xoSk+/7vvqavvL70YIpAXnIHrMp9QVkUVNgbuyUYvAhQ3tP1AHp+xkWFNRXeF2BzP9OjPg9VnkzK2uYa8ymHemiwpvoQlXOdp6WLGnL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158487; c=relaxed/simple;
	bh=DmuICAKfNXBBGS4vjwRovv/DDEJIY5eR/xw/IIN44AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXyKcCgdigJdfxDAKKPRZhk7SK+vA+uxugvZr9V0V+nLMXynsoRoH9+JXpTqMFUUw8XTVjxNhCE2KXv7ow6Jy0Wnebjn5HFY5Uy3kxpI1RMo2NjZjnGmqHdU07C2Mq7EXcBbNpbpiKsfC4DvdhCRfrBUQlAVU7iTl7VQWHJqpFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOECs-0004T3-IG; Wed, 26 Nov 2025 13:01:10 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOECs-002bEV-0y;
	Wed, 26 Nov 2025 13:01:10 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0BAC04A8A95;
	Wed, 26 Nov 2025 12:01:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 10/27] can: calc_bittiming: add PWM calculation
Date: Wed, 26 Nov 2025 12:56:59 +0100
Message-ID: <20251126120106.154635-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126120106.154635-1-mkl@pengutronix.de>
References: <20251126120106.154635-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

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
Link: https://patch.msgid.link/20251126-canxl-v8-10-e7e3eb74f889@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/calc_bittiming.c | 36 ++++++++++++++++++++++++++++
 include/linux/can/bittiming.h        | 10 ++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 394d6974f481..268ec6fa7c49 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
  * Copyright (C) 2006 Andrey Volkov, Varma Electronics
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
+ * Copyright (C) 2021-2025 Vincent Mailhol <mailhol@kernel.org>
  */
 
 #include <linux/units.h>
@@ -198,3 +199,38 @@ void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
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
@@ -180,6 +180,8 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
 		   const struct can_bittiming *dbt,
 		   u32 tdc_mask, u32 *ctrlmode, u32 ctrlmode_supported);
+
+int can_calc_pwm(struct net_device *dev, struct netlink_ext_ack *extack);
 #else /* !CONFIG_CAN_CALC_BITTIMING */
 static inline int
 can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
@@ -195,6 +197,14 @@ can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
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
-- 
2.51.0


