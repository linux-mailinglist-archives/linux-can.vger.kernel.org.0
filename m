Return-Path: <linux-can+bounces-5530-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B46C7C77F33
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C14F9331C5
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 08:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97342FD7A3;
	Fri, 21 Nov 2025 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="TmkKUImy";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="78pJvZkl"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDC227A469
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714077; cv=pass; b=C2S5Py9RqI4y2N77aJFql2peS600TewAvLRpL13LABsX2BXxfW601p+Kiv5h2yQJClJNm42gYu2v3g0tvmpg1V6GO1cw1sFtymxT63ZFL46dqJZq4HyhzDShiJ2Sy1gjw4H6/3zNUFHL/doG3hp7SRIypYDCdbCsjEM+ZiCPfJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714077; c=relaxed/simple;
	bh=pO6jymnsRjaRVwATJjlXjF/Ste3DKsRD+lFLlKsKXJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tH8O8tSPAtsDHBvR3lYuA9d7rytbrzfPEjuh0zgAEha3tCXDynRjzmwqvll0gBCGWq+bdvz4qyTe8U8dIPcG1uFvAE/VTrfQBD+lqhnZkhycDBX4saYnVe7PQb/z0wXfq32+9pbf14fGd6ISHLU6iFyYPpCP65rwdjke7Lr5qYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=TmkKUImy; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=78pJvZkl; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763714069; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=n8taDdbi6Tc4PuZqBUYc52lraM06so+nO7UjZrUqoOtfw+vaAk7f4cOqS95l5VaxHE
    MQDF58yr35JF5CiU5ycTG6/TBFB5ZnO45UcCMurOuLkY8+W0sytdsWChM4n1m/+55WLM
    Dhy6Hz1e4umMIopnRO+q4pIalBFjQD3/yNiPYlsl1mg/860bHfbrQyUCGQFPYHpBFBNs
    v+l/tHn5No15tH5ymKqzr7HrbiUtv+8pswtgNHxnEExaqZB26uAZLPC6wjsGPmwyjD1V
    5cUTm1awvUiSHskJfwlNDgxTqvvV42eDxgc5x3XhtojBQ1OHM7w9FJWCf4RR+WFHzKmW
    JfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714069;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Rdk/brVQz6/Mf3/ryPuE9QCcp0FNo1pVRP0mZsYQTdM=;
    b=k5o4Y6BoyHib9PvJ4Qft8MjJhcHWf/F9OfWw/9bU/ImBK/dYM9g8WW3/MNIWVne7L0
    RCVorkD1eXF/EGcJqI6ChPPMffg6gbgACqp19BLbsDZeMjC5pp0GloVX579y5s9+yE5n
    7kPcnY7Z5n00kv8Zp3wTqUtO5WyhZaKf6OeFVGDWqXP/pAodYF7p9dbLsreY8QEqQEmb
    YFZ7OZE9Z6M+mB3w7OhH++ZQFzvKd3ba1kfXPz0IjPdjfp+rvj+uNihG+04l2YW96Wd+
    JYv3vKGe37ukquGqWi/5TZMavMQr2Ro6TJq8AiMU2/C6ZqXKJ63NtrEga97n/Ju7HINM
    5OmA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714069;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Rdk/brVQz6/Mf3/ryPuE9QCcp0FNo1pVRP0mZsYQTdM=;
    b=TmkKUImyla/FFfsbok7YEVg3cfRvX62wMZDd6qZixXb9wJFxtBmCihko+wshjQPaQ8
    q1aUuXPX4yn04U0bJI9kIaY3h8HipML/xGkF1HG3T4zrqwEj5ZhfVNb+P6/wRD48rzkF
    6ddGa/M3eW//AW18jOKblpibQHJ3A8GzSoLREKXaw2HDYoBTxXYRfFQp7IjqrbQnF9iQ
    kFeyWD88/CfDaCU2vbnB2TzaMqcoMilsmYsmFhA9UrIkp24sPk6mL43zn5x9QtYNXGD2
    KGtzYOUfWwbO6SNfO1ALGNRLFVQ3TP2pzmaCx/iiQWxvQR4P3wEeJQzZCIfEnLYSlgWQ
    IpUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763714069;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Rdk/brVQz6/Mf3/ryPuE9QCcp0FNo1pVRP0mZsYQTdM=;
    b=78pJvZklfCxcoh2bFect9urICnNllZ/bIm9wqUkKsbPz/GBxEQBlvyy1Gr/eecdsBM
    HlDRqq2MrsvwwLixECBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL8YTAfu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 09:34:29 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v4 07/17] can: bittiming: add PWM parameters
Date: Fri, 21 Nov 2025 09:34:04 +0100
Message-ID: <20251121083414.3642-8-socketcan@hartkopp.net>
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

In CAN XL, higher data bit rates require the CAN transceiver to switch
its operation mode to use Pulse-Width Modulation (PWM) transmission
mode instead of the classic dominant/recessive transmission mode.

The PWM parameters are:

  - PWMS: pulse width modulation short phase
  - PWML: pulse width modulation long phase
  - PWMO: pulse width modulation offset

CiA 612-2 specifies PWMS and PWML to be at least 1 (arguably, PWML
shall be at least 2 to respect the PWMS < PWML rule). PWMO's minimum
is expected to always be zero. It is added more for consistency than
anything else.

Add struct can_pwm_const so that the different devices can provide
their minimum and maximum values.

When TMS is on, the runtime PWMS, PWML and PWMO are needed (either
calculated or provided by the user): add struct can_pwm to store
these.

TDC and PWM can not be used at the same time (TDC can only be used
when TMS is off and PWM only when TMS is on). struct can_pwm is thus
put together with struct can_tdc inside a union to save some space.

The netlink logic will be added in an upcoming change.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/bittiming.h | 41 +++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index b6cd2476ffd7..967d76689c4f 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* Copyright (c) 2020 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
- * Copyright (c) 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2021-2025 Vincent Mailhol <mailhol@kernel.org>
  */
 
 #ifndef _CAN_BITTIMING_H
 #define _CAN_BITTIMING_H
 
@@ -118,15 +118,52 @@ struct can_tdc_const {
 	u32 tdco_max;
 	u32 tdcf_min;
 	u32 tdcf_max;
 };
 
+/*
+ * struct can_pwm - CAN Pulse-Width Modulation (PWM) parameters
+ *
+ * @pwms: pulse width modulation short phase
+ * @pwml: pulse width modulation long phase
+ * @pwmo: pulse width modulation offset
+ */
+struct can_pwm {
+	u32 pwms;
+	u32 pwml;
+	u32 pwmo;
+};
+
+/*
+ * struct can_pwm - CAN hardware-dependent constants for Pulse-Width
+ *	Modulation (PWM)
+ *
+ * @pwms_min: PWM short phase minimum value. Must be at least 1.
+ * @pwms_max: PWM short phase maximum value
+ * @pwml_min: PWM long phase minimum value. Must be at least 1.
+ * @pwml_max: PWM long phase maximum value
+ * @pwmo_min: PWM offset phase minimum value
+ * @pwmo_max: PWM offset phase maximum value
+ */
+struct can_pwm_const {
+	u32 pwms_min;
+	u32 pwms_max;
+	u32 pwml_min;
+	u32 pwml_max;
+	u32 pwmo_min;
+	u32 pwmo_max;
+};
+
 struct data_bittiming_params {
 	const struct can_bittiming_const *data_bittiming_const;
 	struct can_bittiming data_bittiming;
 	const struct can_tdc_const *tdc_const;
-	struct can_tdc tdc;
+	const struct can_pwm_const *pwm_const;
+	union {
+		struct can_tdc tdc;
+		struct can_pwm pwm;
+	};
 	const u32 *data_bitrate_const;
 	unsigned int data_bitrate_const_cnt;
 	int (*do_set_data_bittiming)(struct net_device *dev);
 	int (*do_get_auto_tdcv)(const struct net_device *dev, u32 *tdcv);
 };
-- 
2.47.3


