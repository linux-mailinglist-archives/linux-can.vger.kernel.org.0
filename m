Return-Path: <linux-can+bounces-5432-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7505C6089F
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 17:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 98CFD241F5
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 16:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4F52FD68E;
	Sat, 15 Nov 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XALs30u9";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="OZrmHatS"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9323BF8F
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224687; cv=pass; b=GixOwzDVirSDjGUcq/NFZwUU/2KxM4ZBMoie8KHvH9/zBSHTSYpSPiMXsiI+ABPIrlp2z2MVwE5iDcxKMLHHAYMjm1T3qxtxjsNA58rY++3CXSvu0EwgAh8Dx7papYM//sXpcWlOklarVVy/wXu+KEw2Pf7E0H6AiFgNy0C2N/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224687; c=relaxed/simple;
	bh=VTHUfGMUaOBHDlQRl0TAvXgZu1gm3pR0r4nC4S6rQnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUbJ/kVo7ms15Vi6ACUz2KDB0GWiAvilBPf5vbR6BK8viOBdLoNjsoIPxTxCXN3zZpBHqCESvueSBKI9A6WD5ey839V5ns7JCJFtuRiJw1UBov92nJ49UTQN3jB0ZHEnfygXEQ3odn2rOQ9F/LoifKWJhblz+8MkK+6P/Uv646Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XALs30u9; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OZrmHatS; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763224674; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pdF4F1xnrsUBbo3sLY5TVFPwTR+xK2NC2tdYgR3/7PyJK+nFOgAJwgNzwBf1Oi9YRj
    coids00HCeGWBd8PMS2vFwx2h5emReSsgwDiVpOHRWKgdGjufs+aWfNxE8ni0yYt2SEP
    xiZyESnC3qdVO9nQsxrz6tIgGsgz8YdivhgchDBIhJek/QK37ij8OymQO1QkIQVH30zf
    s0EEKH+et3wt8VEt+XaCJ+LoZkyzl0O7szigAuJR1KW1wCFtt70CfrkO2N70a0TVjX8J
    +AUO7MwD9TlNCGLA7aj0Hspya1h1STeq1zcpirAxTttjFM704DLLNpTKhpRW0QZWD7ap
    C8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224674;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=hY/qglFqyV4LRHXbCwYtm9MwH1FI0iV10JzcoVJByXU=;
    b=VdvpnflI1Kfw2agqyggepqpO/+j4qsmF580w3HDHufmaZIjXCNgPpNmhhvhcpARCPa
    xhIr17ol9EgIbzDStaOjEiyh2J6HRw2J8tYS6fLkgIR062Innq00HHoAwRzMAJT34TXZ
    vIw8U/yPcxb+RoB/SFxrTie975Vv3JCtTuf9RUgujNT80LMLjj9A7P5g740VCiKM//nJ
    ZdsjESYoO0geU24sb9yKEEuGFQKbAeAo+/iZ8BY2wPhycNdNzr6Zw0pFf4bH0iFMvSur
    T3RwA4mHMA5zigPwAUL+oy59sCyRwitW4btkTaoN2QkCJyT4vdvx4c7opaf3N5paD6xe
    czlA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224674;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=hY/qglFqyV4LRHXbCwYtm9MwH1FI0iV10JzcoVJByXU=;
    b=XALs30u9W7Q0E1sL73XHt1PXYO7w+9HRGyI2VHMYPN3tJ9PUDc8BCUo0CjbFPYQndZ
    DvzD92MDNE3cuD8t8pz3fQCQC9F3YpCi1aKEWjxYKeaJSp1gksznUymsESHOcT86f+Eg
    7QZGbvSJS6mJnwY5ORP3ikINNgYPZj90yMuy8qlCJsFkdBHMdDLhr85A7BsuEgFskgfh
    SB4jLrUUpYzGM1bc0V0X6Q3c4KYzlcBNGLJsn+AdY1XLy+vMSXRn1AuFk6Clq+39w9Z5
    llU9vjuGVaZsmvwYE0UwsGoK/Et53EcKXrhPDygLFDiLdri0ZS10o9I+Szk7ZXPoXNAR
    Eq3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763224674;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=hY/qglFqyV4LRHXbCwYtm9MwH1FI0iV10JzcoVJByXU=;
    b=OZrmHatSc4ngBohu3srU++lDhThph2HeaACzhwZcRvK02Rfsa/2x3QX0eD54/vKiEp
    eKn1IRWgvnB4t0ZL7EDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFGbseQq
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 17:37:54 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl v2 07/15] can: bittiming: add PWM parameters
Date: Sat, 15 Nov 2025 17:37:32 +0100
Message-ID: <20251115163740.7875-8-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251115163740.7875-1-socketcan@hartkopp.net>
References: <20251115163740.7875-1-socketcan@hartkopp.net>
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


