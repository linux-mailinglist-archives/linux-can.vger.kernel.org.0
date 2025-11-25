Return-Path: <linux-can+bounces-5651-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE837C85020
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 13:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E974E4EA005
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 12:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA4831D365;
	Tue, 25 Nov 2025 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iqamagPJ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ecBw7nsg"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE93195FF
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074375; cv=pass; b=UhA+OcVzfasrgMUCqyxKr+waZyVi8yhrV5/7SHsKQxQfl9BQgYIT46qj9YasxDpyUpopqfszposGm9+8tutJaoPKiKZHOa6ibs7aSAKAVpZ/jk+iv+nLaNKM9MWMnvejGd2qNuFGskKmKFbf5X4yBaxykp+nFY26UncpaAwc4sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074375; c=relaxed/simple;
	bh=pO6jymnsRjaRVwATJjlXjF/Ste3DKsRD+lFLlKsKXJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Asd/7FgutlOmLh/q+7hQXHujIby+3uaMfWdOKoRnWAL8eMfjLNrUv4uTQnYXkcggGhFGKR28+ervUGRUtvg6MXDjE13ry9j6Hqy/Gk0bzWPaJY4PiUlIZ4EsxmkstITbh8mFCroJ1YwZllZBTV3c2g9Ihp15KUpifzEgsOKCZOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iqamagPJ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ecBw7nsg; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764074355; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Bmo6OEGqgFQlF3wsSPhu8I9LbS6G6rXujLbCP5xgYCMVuERmhPdjTV38AIFsylsXVl
    bpuFb2kfCuSuniE7haaHiUY8ttu/of0LXn0CjqcuQnNN4esOUtIG5CoYRMKIjaq+o4xo
    hAXXMbTIH+wHUuoSVA+3RY60tZvUL144N8dGR9Uo8befAvgRGvvlyM9y2zml5mLb0W6o
    K3FM/+78DgGAeuzPBbMSpPN3Zx2K1Hlw+J/xQKZEPLcxbVtmbDVyibz7BnYd6k+RCxT8
    gzVjWSJB/KFgo1/EgYcnK7/D9zdLg/Pi7nuSKIkCyVcdfk+hcR9zQfWhM2vR11I35uW2
    5wDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074355;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Rdk/brVQz6/Mf3/ryPuE9QCcp0FNo1pVRP0mZsYQTdM=;
    b=T/Z35/Zz1irRSkvzAlA3RWCEhw/yuX1+DKBoKbCCRtronhStqq657v/y2wIeBHM/5K
    2LZ1W8MzJQ1EVOEXFBbljTyXYX2N2yy0wh0LMin4AmaSH45wnx6r1z1nAz5MfPuR2U6g
    aYklfLfuK+ypnE+Z+NEqkj8amAe/DxRngvC+eH4lCmfh17JGyCphF2QhLE5aJNTc7rKc
    gVqHyFRsosTWMYQyvWhOvTY3gPJaeSBi7wtC4oSu8latMX1/OPI7ZcpByJPTDbJdOBFf
    3aF2DKyN0f5bH9WotviVrrFJo+8fB9OH593Wg6tkgQwJWR/eREoKSjRWf1wZNRlevOxM
    splg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074355;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Rdk/brVQz6/Mf3/ryPuE9QCcp0FNo1pVRP0mZsYQTdM=;
    b=iqamagPJVTayHxzfXkoDGXZN1uwsOxOI67sp5jDJo+hHsY8ygJFR9dZF9J14s0vc8i
    eUb/ZWqsKcHN5hvE1K7VSvTEPoe7L1eAlBUhROAOsherGqzkqI47HOS0j8U8uIRyo8b4
    nt7VZOmGJixHMdUAUtggBehrMsOHhgc3ukcHI3JTPAZqtd5wQWp1HYReatdR9uLzpgyT
    1yktpuOPCUHh5D9Uah27oh9rwMOi2uBst0Psxn+y5cTHL0z0BLQBXUmPvBBjorUwoy/h
    KTKy6NpanfqQlbzziz0r+PwYxRfKLtBjMm6tgA3J6x6uRQq2UKNAbrtQl/yf7Clalj1y
    WRmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764074355;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Rdk/brVQz6/Mf3/ryPuE9QCcp0FNo1pVRP0mZsYQTdM=;
    b=ecBw7nsg1KunGZFVIyKWtP2Fuy5Tz5jituphLL2tBoYyrz1c2jna2xKNxfb9Y8LmZQ
    DRxv9mgrj9eZRHACu+BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461APCdET8S
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Nov 2025 13:39:14 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v7 08/17] can: bittiming: add PWM parameters
Date: Tue, 25 Nov 2025 13:38:50 +0100
Message-ID: <20251125123859.3924-9-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251125123859.3924-1-socketcan@hartkopp.net>
References: <20251125123859.3924-1-socketcan@hartkopp.net>
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


