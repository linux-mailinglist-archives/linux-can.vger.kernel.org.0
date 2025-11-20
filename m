Return-Path: <linux-can+bounces-5516-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EF2C75F5A
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 19:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1535F4E0545
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 18:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB6B2874E6;
	Thu, 20 Nov 2025 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="VVBv4gbi";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="oHilRuxg"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6189C1F8BD6
	for <linux-can@vger.kernel.org>; Thu, 20 Nov 2025 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664341; cv=pass; b=rzaH/jQArCcsvBpbVa5m15eE1QgWjwBo006CP5DriaS4A6Bl5uZHEGKOpGR0O06OSUacGy4QS/iVYUeucA/J6YrE8DrW8ioj0Wagb0cZLuoUXDcRd/S5qDzNzRJvW6Q8/04rEj0kV+1uyvlrsaC2rs594uu728H4zoFNNWPbkH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664341; c=relaxed/simple;
	bh=pO6jymnsRjaRVwATJjlXjF/Ste3DKsRD+lFLlKsKXJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g78tC1NTGtgPxNOEveWhNvhPWod33RQmbF1V5QJYhVBZBgQw5SGFm2fH+MsFl7nBz2WykFWp7W2xj5mupsO9cYUWWw+D05KbQEYXMOxTLqryUspDNDiSe33jyJwgmUYWaXbqKcGJ/SmwlChHtoFHTOHhFdkuedhB+IhGFjtOGc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VVBv4gbi; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=oHilRuxg; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763664322; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ObEhnBVIHOfeHfWiQlRkM+lvclpvM6paWq8yjpHQiMixWRGDUEik3JUCyMwRnIOJvl
    MO15+RiCIXhNV1roC6uAXQNOOetJqghLjQ0Xu1/6mY+wRIWqQZJLuO6nJ+75L8Wp3Jir
    UwzLGut+XdP8XvaF67B67nrjFN1OQO7710XZZXkA4znkILeedgWmdkSj4/807gRlx13D
    w2CNgJ+KJ6Ouws68iGfwqmtMXGhvZGPTpAwrUBRuHzf0UPXk8pF3WLckNQXvUEisYLty
    oeqDMvqFz2OOJ+Q4Zo6CWighPgUssmxo9S5s613Z5Cjo2wMeVQaDMHbPbUmdxkMEj2TN
    P2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664322;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Rdk/brVQz6/Mf3/ryPuE9QCcp0FNo1pVRP0mZsYQTdM=;
    b=EcHfX3ItSEWE4Z9K1NP9t9Gk21AgdnccvU5GAW3OJ2mWQau41B6DXhBhYr/n1euird
    aeed26EENB9ZGldn/mLK4B+aujXYrp2pGuK2yqNYDgszjPkyhlz7F0frLk112Vipcf+m
    iEu/VSmtp8psGRnJFIOQcbSvBDx1Vn+62hvG+sBFF3PT3T7L1j79II8VrFanw78wonEB
    ABd9mxndlecfLFKUf+ZG1z4MtjpH7FWA0yHB42xcyBFJ5EFOLb/F/HIvBYKXEvekXaQk
    698YX/8rFpZjQO3i7sLldpqsDQKBZOeHn6ZfiYCc2Fg/4+3hjqB+CGtrXU7YxKXSVPON
    d2rQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664322;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Rdk/brVQz6/Mf3/ryPuE9QCcp0FNo1pVRP0mZsYQTdM=;
    b=VVBv4gbiLtc3YL8Ja6ialMkbuZLIhS9hmM/m4+Z8/oLwE2HGo6NZYY9+LZBgoRVHVq
    bJMeUM4XfHV74reD05mI6O0ZLGDsDdM8loUbQR8/uSLEfxPtAkiG07mI3kPa4/usrWzf
    H444SBd49AeTxLd1wR2MbFiHvJl7XjSkrLPimaAbUSMFEXLWkdK3775ZGl0XvuUBrD1A
    iMLkgpuNZDs8gBsYCtyQKDiUwfR93GK2Rus8WCCdrRrpZNLRuHz1QX3MhE40TbTEgKSn
    B1JUG4jh/RXre+AuVKCr+vx+fE37CC8C7TKCluaB3eURWIRiQy4kmiYiYIW/6ztUJ00+
    QSmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763664322;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Rdk/brVQz6/Mf3/ryPuE9QCcp0FNo1pVRP0mZsYQTdM=;
    b=oHilRuxg373VQnWXBLjkemX4kFG3UCK28xWxsbsz57O48zkPWdKm0g9O2KEFNFcumD
    8DTTt/SvT834I90zP9Aw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AKIjM9DR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Nov 2025 19:45:22 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v3 07/17] can: bittiming: add PWM parameters
Date: Thu, 20 Nov 2025 19:44:51 +0100
Message-ID: <20251120184501.27597-8-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120184501.27597-1-socketcan@hartkopp.net>
References: <20251120184501.27597-1-socketcan@hartkopp.net>
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


