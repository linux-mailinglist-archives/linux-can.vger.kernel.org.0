Return-Path: <linux-can+bounces-5160-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FA2BD2B26
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 13:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA94189C685
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 11:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F46306B00;
	Mon, 13 Oct 2025 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKy4i61I"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF0E3064BB;
	Mon, 13 Oct 2025 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353347; cv=none; b=HsP+24WlKuQpyoY91vpApi5jZNzaaADfuFa0gDoggW4tZRPJS76WG/dR7miBbMs/Er0vTGaiRze1vYzwGQpJaR9f1c4QVOxfQ9Z9hrUa7h6IUkOzGP9Bp7t4PLeuo3aRDrBko+TmgFS71H5fkYv7VtluJtklpNkgdTNYNYD63Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353347; c=relaxed/simple;
	bh=VCnsJDWsm5D9WrzEysRb1OMusmtX+9CwcyZ1XTPf/as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CxwYxq5edGjnxMh47+0WktwMukftu6YeLbmxfG/R6eLJPTM8PsdHuqmVzQ/NfMNj5++9oOAE6ZB/PBxFthS9w557Na+qR3uShD0aAxmrGoB7oU5FoVmWtELd8OrvUBgSPon5FzC+bYVkG6k78Cy0M6ul/mqf2JoM3sHLKz61UIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKy4i61I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2BFC4CEFE;
	Mon, 13 Oct 2025 11:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760353346;
	bh=VCnsJDWsm5D9WrzEysRb1OMusmtX+9CwcyZ1XTPf/as=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bKy4i61IWZyhQ43wpkL49gvRgQ53fi2l3nzi2UV4iuFEN76FDBIKhy4JklWZAkco4
	 FmZ9qkD6X/FN5PZJYkKI438sOvdj4YA5gRgYwQSGQg5hSybH40996I9tLxOS/yKPVY
	 0GeeHZJ5d0/r6h7YtkoLb6Tf5oNvA3RYdzLDgrsDsmjeO1wd3JNJAEO89DqzdbAncs
	 0k0bKeWe8o7ejJ9GtqGhqap7LEKuEvzosCDUeuwC7cYe2CVKpq+mogPMioROn+NAO7
	 vJu0C2lMt+ukUUcUgyVxqThbXVIG8dM1S+6b0GJirgqHXig9/BIzUNmjXoYYJnqcj6
	 vYm0RQI5KL8ig==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 13 Oct 2025 20:01:28 +0900
Subject: [PATCH 6/9] can: bittiming: add PWM parameters
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-canxl-netlink-v1-6-f422b7e2729f@kernel.org>
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
In-Reply-To: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3173; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=VCnsJDWsm5D9WrzEysRb1OMusmtX+9CwcyZ1XTPf/as=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlv7mhPLd4sO+lJXQGPfK6JTLRqs/lCf+eHnLkRKSI9O
 VuEQhg7SlkYxLgYZMUUWZaVc3IrdBR6hx36awkzh5UJZAgDF6cATGRiHMP/5CtqYRvstT9X6VbO
 Pzq9UOst78aggh+e1ZMqNuVf0lV+wvDf4a3F0nXrXs24qLn51qwTxxb8v8gY3dfH0pvWb9rBGSP
 FBwA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

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
 include/linux/can/bittiming.h | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 68d533bb7856..14ad249aa8cd 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* Copyright (c) 2020 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
- * Copyright (c) 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2021-2025 Vincent Mailhol <mailhol@kernel.org>
  */
 
 #ifndef _CAN_BITTIMING_H
@@ -120,11 +120,48 @@ struct can_tdc_const {
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

-- 
2.49.1


