Return-Path: <linux-can+bounces-5258-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFE1BF77CB
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 17:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00CC9356550
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 15:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931DE347FEF;
	Tue, 21 Oct 2025 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6eBMCot"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533AF34679C;
	Tue, 21 Oct 2025 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061685; cv=none; b=bH5BlXRrLHoC/cYcQ+wf+UJWBqw5MzL9EavoHskdOpy1zDc2sGWVGUEIEZsJI2zPZmrnebITPpnQ4jUjtARNZqUAc6RzP/u90WBl9sIb0kTN1+TG4scWXDbM3s16F41aepS5MMF70eU6+M2d1oXmMZ2a4kV/gd+yiEImVf3pRMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061685; c=relaxed/simple;
	bh=mVFqzFxcb+boKPfg1i+RH9Yu/gUe3nKXtP+IWXh80W4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WKi2wlUvkKg6VSDomEgNt5eFUgIsZB80eeTYN4XoyVgYho+uh1WdSPTmcLd/lUpOZClxx/asp+6X3JmPrVF6ugcRpxRPVtbNHqk4ZQQ1xyQhbTNgwEb9gphTi4EPmacONNHhhxaekaP4/xSrwdxteOG8TNxakr6TkodZbAR6Qvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6eBMCot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EFDC4CEF5;
	Tue, 21 Oct 2025 15:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761061683;
	bh=mVFqzFxcb+boKPfg1i+RH9Yu/gUe3nKXtP+IWXh80W4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P6eBMCotcEEqj+2CnwMbes843BJksVZLP1qUVDCkrqbozxfHYy3lPEAwTzdPn/Rcx
	 lH18voE6l5nLS6Ss7qeL+aP+tK6KhoAIj6IPPiQ498ZOUgsq3SX86A3+L8KZViWK0e
	 mp177WhticlSY6r5sbZUvRdYONWzok45t7N0nDZ9+lgZeiwfoQZL7UMKZFptTIAWtF
	 nfiK+AxQ0ECI6jagjoU9Qki2wAcZWAjBZfOT8bJngBTMgDVHBxWOIJVysHvf9F9eFN
	 n6LN15I0R2UXe7Ed0Mt5tpGlHFSHLcadRo+xzUzGzgnvq1K4D+g30w2YB9TarZYkGM
	 fbKzwpAXKR4lQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 21 Oct 2025 17:47:09 +0200
Subject: [PATCH v2 09/10] can: calc_bittiming: add PWM calculation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-canxl-netlink-v2-9-8b8f58257ab6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4177; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=mVFqzFxcb+boKPfg1i+RH9Yu/gUe3nKXtP+IWXh80W4=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnfV8sYTBHr9JnGLxkWu+Ztip72gxlcV/n8VIs15W4xu
 fss8fnXUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCKXdzD805ZM3N935V72luji
 5ZMsDkZlMueIuhZMvpot0V355I3OTYa/EudT/NnvHIkuPSZvk1ypbHjInTcwd4qa1V5TRYGX5+4
 zAgA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

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
Changelog:

  v1 -> v2:

    - Add a return statement to can_calc_tdco() when
      CONFIG_CAN_CALC_BITTIMING is not set. This fixes a warning as
      reported by the kernel test robot:

        Link: https://lore.kernel.org/linux-can/202510140553.qo3f0I9s-lkp@intel.com/

      While at it, add an error message.
---
 drivers/net/can/dev/calc_bittiming.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/can/bittiming.h        | 10 ++++++++++
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


