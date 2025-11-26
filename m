Return-Path: <linux-can+bounces-5681-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 112CCC89399
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319383B5658
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5462BEC41;
	Wed, 26 Nov 2025 10:17:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BDD2D23BC
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152223; cv=none; b=HryfSUVtxlJtWfkprByUy1zAJqflXfHCJ8RcbRFSyQcO8l3fme6q61p+hem1B+nzWIZaQRi8tDtq8PY8MccbfzV981dGThDXrgjP0xdq6hq7j5Hm23QZsAJVr3Cu4XFHedJYk1TS/GfKlfWScNzOUosXElLZyL2yyBgAJUG4Zv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152223; c=relaxed/simple;
	bh=chJqDi5LNRD1ZQF7VK3RPjMxg7Lxg1i0rVyWyftNFxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FSzYaB3nJKxMIAw3RC+KztJ0oek2LmR4KRJcq7K6f7U4Y1BM230/d5itCrqUQ69Rmr/WRNWOjXkjRaSI2Yd16ifzl1BdZOH4sfqFhTaDINQ+D01466YU9CG0Q4R0OidGxGG1KL+CuLUPOp+CfxMnG9Pz2ITPDy8CKts8rdMRpKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZv-0000Qz-S0; Wed, 26 Nov 2025 11:16:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZv-002aSn-0a;
	Wed, 26 Nov 2025 11:16:51 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E414F4A88D9;
	Wed, 26 Nov 2025 10:16:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 26 Nov 2025 11:16:09 +0100
Subject: [PATCH can-next v8 08/17] can: bittiming: add PWM parameters
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-canxl-v8-8-e7e3eb74f889@pengutronix.de>
References: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
In-Reply-To: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3285; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=8daY6wvWgSakeygHZy4qqebx3N9P6l57fEJmO9+nzEE=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpJtOAtjWgw3EQ1X1DWwwhGpgBv+TvMcIUOuDNn
 TWQfSBg9M6JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaSbTgAAKCRAMdGXf+ZCR
 nDlUCACyvKk3SqZOYebxNZvsl0OJPaaUN95mHuM5OKpYJY1yWrQikYioy1y1mpaU11SIULETdv7
 OMRo+0/YW95UnLkJpiT3c46QncpUKBITxuip5fIBTTvXL1N9JAT27M0N2SrSXcpYcqvGsxnz9Cp
 ObgzFrFKIHguD44S5dSYjh8cjOkaH6Z8TK3d4VXpR1TmuQRr4DHqxNGdXVgA3LbCHiwWEREOhGl
 lmOJRzYdlLFv/8bQqw7ZgiJZphwgucdI+Pw3tFizGQ/ALYD0Pa5wIMkeog9mMorHA7VCFxSTtXl
 eWChDvOTd2C00Mi5v5RINalaYmfTD/ucjOATzTAGBSIpI/u2
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

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
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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


