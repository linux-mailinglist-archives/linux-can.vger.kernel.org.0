Return-Path: <linux-can+bounces-5256-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F133BF77B3
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 17:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25DB64EE0EA
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C593446DF;
	Tue, 21 Oct 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJpUFmW0"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A01D34679C;
	Tue, 21 Oct 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061681; cv=none; b=hds0tIjsS7VXL7O6yom5RVbikkGeY+f5iQnF0gbYsAsdJES5HYwpHfdiTd5Guk2RcdRbmHX4opoize3d/ZKcphFJgZ02lcGvoNn7M6a6ZMtZuMVcmVg7TpPXAssklA4HOO0Vr7v40sbpYkYEzTu1RDSN7c1vCATBXmgGtQ9r58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061681; c=relaxed/simple;
	bh=jqPIZ4JH4079BiKqtXFd7rgeu/2WGWT6odzHltrlX/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fTjgLPN0JAwUa9YUK1sQ3hbzQt17Db3Yd1o0QRL4YBIa11ZD+W7dn7HA6WQl26KFILHfzMlOtFB6uMvXq/qYI4xQxA0Gztvw0D1nsPiQc3GIKO2lJZzoKQG8qUAioNMylCNzL3mM/LodbG3Bc1+eb/HxMAIhE/vg/y8gXNJeVtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJpUFmW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC0DC116D0;
	Tue, 21 Oct 2025 15:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761061680;
	bh=jqPIZ4JH4079BiKqtXFd7rgeu/2WGWT6odzHltrlX/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pJpUFmW0SFdbVFEa0RuMhPM6JN0LgatD5u0bvcYNagfYMVpjvVSQt1LPU66YDGrhd
	 aZ2vwg//vSbdsYOrurB+JPUj/6VHwE/oBMH87IeqjOpVapBGObVEDdAWxb/QFw3FTJ
	 EqqvzmwO0UxGNlcqP5EnrAC8/y4S7xcWctrlf9TaeHfPjrWUFkq8vcyODO5l4KpkiE
	 iPNukQaCsN34bJp/vaBeLUwP6+b67sBjvvYqkFSIEMYaHrGLLu/tjdccB57sI6/eex
	 VwnAba9Ko+WPDexGsJC13JKHbSIVDBPo/KLNiPDKX9KNWW22FkyxK57/Z0JRyYhs/R
	 CVoCWrzAcDNjA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 21 Oct 2025 17:47:07 +0200
Subject: [PATCH v2 07/10] can: bittiming: add PWM parameters
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-canxl-netlink-v2-7-8b8f58257ab6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3173; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=jqPIZ4JH4079BiKqtXFd7rgeu/2WGWT6odzHltrlX/4=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnfV4vO8mZa7LRmYyjrUd+zBu4Pjrbc6hRfazk1OnSVx
 +fsgm/POkpZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAEyEaw7D/5istqCytKn5sxoO
 nZuYt8PsvZtmm0bJzwYjhflvzC5Ib2P4Z3PV+7zcCdOgOeumbF6z98hync504RKzhZUb52o7fAl
 v4wAA
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
index b6cd2476ffd7..967d76689c4f 100644
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
2.51.0


