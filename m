Return-Path: <linux-can+bounces-5413-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB7FC60466
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 12:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5050E35D615
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 11:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE3928D83D;
	Sat, 15 Nov 2025 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WKTtIcma";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="no01kAtw"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E26528A1CC
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763207649; cv=pass; b=Ea/my4cdWOHqv91VDvRFxIQxJVN6mjlkmUniMUbKXERcjquPTk95W3DcDjZfCIbphjYOAvsAfalHAQkq1cEzLmh9GbEsP34VndH2uOkxuMOsxC7vBSEfoyY4Rsbekgdx0orE2xHLzzdWoW+3cfaIhdzaLS0QoRWkRMm8mYiGnCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763207649; c=relaxed/simple;
	bh=VTHUfGMUaOBHDlQRl0TAvXgZu1gm3pR0r4nC4S6rQnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+wSUDf9+qN6garC2JFKme25MSUDYaA10n2WXK2NsdLGemW/f3wkymLg/eJcQ57CYI6peUeTIitC40XXyMRxYClNs6lqOftcHvNRi+V4pIEo9lx47a792sHTLibYKMf/EvuPbHsoRG/RsqQ92vBKhLOQU9ecjwkdZykVcTuydx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WKTtIcma; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=no01kAtw; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763207466; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EqRV5uNq7s0wHZ8iLw3/Hr+LZW5ef4ZHHldLwxOgmGGt0ErmZ4p0egfC5ezmMO+wSR
    lgjPiU/oJvfmcH8qPtGUq+nnToOTNNcw7Cbryw+zk8NJpnC6g0FxY5FwB3iEFBnSHYHi
    kGTv8MCyhcGe9yMGqTiYNvfthIq7h5FOcW5Je+nrbE5F+HiApkGPjl5O2YMmixDnW1Vw
    BIBRS5Em+LBMzagAmjUNCm/46myiU2Jrj33ZeyNSekl19ynoNHxPWVkWnywtuMqeP8Ox
    2xYm+9wBOmt6lpS5VbzFZMUlDutVel2GF8xcMtenYT8bubmTJMQBoz4T3Mo2E6uTKZ7H
    DPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207466;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=hY/qglFqyV4LRHXbCwYtm9MwH1FI0iV10JzcoVJByXU=;
    b=Ki0JwI0MsB9/e7aIpS/iq00UzMsoc9CkNPAAH4MROH+lJS9Fgl7pjlaSeUUtQg3hcj
    RwSon3r9D9eYWzONKavUp3ASJX49sj4YYdiBRv5KNKTuY7yWy/L6pgve24Ndchvf+NMu
    TyG0zce/+WnQlJeD0OPVSncRsaT/rPamIsuJJL5NAAJh1KkKHkF08K9mrlZHyuMVhT0q
    ijMNHo2iTN1e8+UUHubf/cze6klmKAymRmTd4C7RDBcXG43KL1nKARSYdUuPkXBAjN6c
    Y+kDQHJVgq/8MoaD9NYRyDMO4O/vYzlRpNeFYd+/uEEChRme7IYfIhZram+hzixXr+7o
    Hbiw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207466;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=hY/qglFqyV4LRHXbCwYtm9MwH1FI0iV10JzcoVJByXU=;
    b=WKTtIcmam5J/8ExkvG7kb2TQtqh2Ky+by6H9hx5QAv5wTzDou4RcC6nRPJMbqRnHes
    yTrRRBsiqfDo2L9Xv2UPZjz4SGZ1teskCEJcbgLMwl4rtjOnCrk4wEf/OfbYoLBnNaiA
    NaF/Y92mhTNtJxdKQVsKUMuQuw8BYesZJ6sRKqTPg+nWOP2CdauHYyKKv1U7aJDCuREz
    NDLwpUVGSC9DyHT4HypMb5dtkkOdz3R48j5aAc1fcRB6RmdV8K/KBm09/6jUgOi3Lf8C
    CIb21UE13OQdy22fJYBe/cAkF7dH8dL1pD24pDjNoer0+li18Ka0S7BQF6K20aJ2aguK
    VKxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763207466;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=hY/qglFqyV4LRHXbCwYtm9MwH1FI0iV10JzcoVJByXU=;
    b=no01kAtwAvOc5SKbCkumCwvydkSo3lO++z0+kqbTIcXBPB4a9iaDgEHaA4zGvSM2Pt
    V73UpjLXHQVK28hbewCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFBp5dZm
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 12:51:05 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl 07/10] can: bittiming: add PWM parameters
Date: Sat, 15 Nov 2025 12:50:50 +0100
Message-ID: <20251115115053.72673-7-socketcan@hartkopp.net>
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


