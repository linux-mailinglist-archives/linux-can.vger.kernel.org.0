Return-Path: <linux-can+bounces-5570-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6CBC7B8C4
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6219352212
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AC8302CA6;
	Fri, 21 Nov 2025 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="VAjEE+bX";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="eMMlwEoA"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151C9301016
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753737; cv=pass; b=BUac3RDIv6DQ9fp1xHb97pVEGSNgSRRM+r76iflshZ1XEWQFHwNBLIUd+iq5wCzn/kDczmW8I3xzVcMOi/7aJYlODN4p2IkDy1QZONICEbQJO79QQ6zbP9tJVOX6SX9SWGZP2PXoHWdC8FeVbiZ7esEYC00nHNTdnUh2lWu6u1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753737; c=relaxed/simple;
	bh=pO6jymnsRjaRVwATJjlXjF/Ste3DKsRD+lFLlKsKXJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8dJVPUodEodA3EeajSz5KftyoB8wWFnGTumKdlz28TOzxe7e3Cmp98XZHEPEPjLih1sivdcPqts0KBY9Ycfx6mShvpOaHxW3SebbNfyN5QkRGOsRpdWyQyMD77fhWnisCDjIDB4g9NR8f0FKY6IJ81ubEk+5zaas4y74hHh90s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VAjEE+bX; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eMMlwEoA; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763753728; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HlLWqB5jUT4vs644ZHMUzqpjWA3TdVygo8AEZJ+t0VE4r4GB0pPXlJCPOPZbIlu+2s
    8caVLlSx6zEc5de2zRtU/yMeD5tYaR11SV3imP4YdUj7F4tDSDmqOdrKd7wgI+J4/Lu/
    T94dHrQ87BNF3qz1m0NbXmyz1mAZFnM7kbcCDHNmUo+GlKCeC9OdJebwuMU3XOSenB3v
    DMglZ4zHj/bgwFqZZeNC9WoPnS1qwSiv5f0XbiOuWhmNjoonBiSXujVO7xpotsQI32cq
    J7jbF62Z6//J8YQqt6x8HLB5JFu/dDs3jaBvVA+ZmP73AkyJ8SdILTJf/A9ru8GSWQX/
    Gz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753728;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Rdk/brVQz6/Mf3/ryPuE9QCcp0FNo1pVRP0mZsYQTdM=;
    b=F1BAZcJAdBEYwjcxmft40GX4WAGznGm+Q036obkJbs4x5GME7M3sFvVn4B1Hm/2CuZ
    lqmC3cxyQFRN3/+cm7ml2kIGlGXDuHh9arcOe1foRDbOi2m5vHrR+xctVApHOfgxVONk
    M6g5QAnjWhz4Xd0PJCSGFaO4nWG8VJxkDQP6ZFrlL2G6VhLp9bR9aqLMVMyXdZqJbybn
    UW4wAoWUYn06huKnNtSIOzCNC05LfUzN6Z/+gAUzfaHgWghG+YP72G65/SED686x2pjc
    HHoSS4as7cLoiRY8usnUrlI55oJqrN1Lzeln8n5kuX2C9jsXzlpp0zSiOFMWK12qZ5VM
    rYBg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753728;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Rdk/brVQz6/Mf3/ryPuE9QCcp0FNo1pVRP0mZsYQTdM=;
    b=VAjEE+bXxHWPxmkKM3jUeDuFJpbF/gXUntBZWxxQiw0mSGbIcB6Vr42RFhDZj0k2th
    DIA5XqwsYzXalIaMWO/EQx+amLXBx+mGtKM9cwG1BFW+xrZ95TKHtl6JPEW8nmIIg8JR
    LSIPghmbDDHj1TWWoLhjp56RYw9+3U5aKTdlAGDr60T1Vg1AYkGqprMvHObwatpUp3m+
    VFqBMDj/Uwy2iUQaYeJfICN+qzYCCSWc2hD7iztetrpR6RwWokF4YGnq5Fh+KrlE1JQk
    R7P5cQaQ8FS/7YZFq/Em1vmbWPFTJc8tEcE7Z0oEA6GgC6tnH/505JFFKCEejDg+VkM1
    mHUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763753728;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Rdk/brVQz6/Mf3/ryPuE9QCcp0FNo1pVRP0mZsYQTdM=;
    b=eMMlwEoAg7BEO2CGusb5Di8xvO768BLRbEoJuzkcBPj22s/tsvP+UwGBCshHVFr2Vb
    +17UNKc8A7robBNdzlDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALJZSEn9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 20:35:28 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v5 08/17] can: bittiming: add PWM parameters
Date: Fri, 21 Nov 2025 20:35:04 +0100
Message-ID: <20251121193513.2097-9-socketcan@hartkopp.net>
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


