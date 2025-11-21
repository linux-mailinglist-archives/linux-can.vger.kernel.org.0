Return-Path: <linux-can+bounces-5532-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE97C77F36
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 496DD33278
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 08:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91611A9F82;
	Fri, 21 Nov 2025 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="VQksNPqf";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="C0uEn5YY"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A817B2F6934
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714079; cv=pass; b=NXoJLCL3YFVNGzCwB2i2g8d0RLvGYE5tGbAQfFm48vFwc+MTCm7k0gC0uh35g+IK8CPdlI+KpKd8Xn47PwP0cre3QlWLxPuZ6oTcbbxRMOi+Au8RLSF8eNzD1HvNOxZot5mOyMxmBs7H5MiQrBXlcrotZg4PBZNuUtGFYpdQAXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714079; c=relaxed/simple;
	bh=jXJqzBRLihuZafOKM4El5E7LQSm/LV0S3zNLCcHW8wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjwpTv6GxPLIU041FRmEqoIA1xh4CsxKkn2rO6n+fv/mlc9Dui37kEh8a9LIFBuJTwRrG2XKl3CJv76Oh2+GMIiSJzjjffllbpFccqf8w+SMdUD6VTDbee8KbSMJ2yEx0WFnWDBjhwZehL+v3TwhwTJuEJVWVC6C4BFEYAJxHLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VQksNPqf; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=C0uEn5YY; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763714071; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GOtaUnmh5kGgHp0hWgKEGJT3slj1Utc0g2m8+alwdSQABE7VsgGcLAEe6vwawTECtQ
    HHYsWTgAAXAXkuCTZcWE+11WCvRHiQdh5NPY+GVjwWoVQTYQ7+Unf+ur05S1+yQYbmiH
    EfAY4MMnwhHvAGZ1Oie2xDeP/UHOMxh//+g3y8KgXTkiwyfRR7HzdhhfEVukGcklS2qt
    5CQebOv3s6j4wUS/6WMItB4y3fEyiMrQyYbVtJLlX+dnfxqfPhdQD9hK3mhTAN7QGfvw
    cIOiwWFPI+KffZlmmDhgbhrOt4oASmomXGdAML89PkmTbAT58/hOXGz9znXz/TDNJ1N5
    fxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714071;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eKg94ulVJ5xRJdNwXo2VodRRUT9kgiUpSYPSOwDPCjU=;
    b=fgwIpxTRmhP08Mgp/hZYUMqz9N0YUhXLQr5UIslzrioO3Ku97zf9iOmtESCyUaE7aP
    pSC2WONA8yugSoGnUwBs1t1CR8kUMGLODOxsKbQ/zdIvYuXf/Cr50lZ/KfkXVpWPXh5D
    dfFINTOddKGzrR9vSKxYfOYNtV8F3FZT2h05ueN106wLJ4o3eptnBdYA4IJD7OId5MYN
    ofJ/MvSzbXVFf+kZ3WVBz9+PHAq5+f+RqhMDqJJbehJbJdhtw6hkRApCcOAV00Z3iPPh
    Qd9J6HRRXucmevfvMkJ0xjYAh/otocp/nqlN+iyW6mq6nBqKfE7QL1ZJMgfXJf2kn6Cs
    5n+Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714071;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eKg94ulVJ5xRJdNwXo2VodRRUT9kgiUpSYPSOwDPCjU=;
    b=VQksNPqfKYWAjKfb1zcVy/lKhp9k6FjDRcnyDtbYyb2fiFb/qpeRSfTsW++272pJ+T
    ITAf/llgwdxy7cXMuEJxkbng8CEyB0D5cwu/PUQq9Y2WMclTvCnxhAsEPGpVhGxmiczn
    2nE/BDchdnkTIDp7soiKVjfTNkVwExiLl2Mf+tbtHXpkm21/JToiQrTiZ4j2Agg3r1W/
    HP7PL44z5CQON6sqZ7qRM/pq1D5CXRIrRTB/TVcqd1A0/Y3EALMN8wFbZv8NWnVDm2Yg
    xUj0XtToFN0CkG8qq2fnTU4WmIr3UsbMGbfEnJDfLGT3XqXWOkj4tDChz3bT3PErpKe4
    adYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763714071;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eKg94ulVJ5xRJdNwXo2VodRRUT9kgiUpSYPSOwDPCjU=;
    b=C0uEn5YYN++vOr9jZPBpz2clutSnt47u9luidRLi9/pIGBi+mssRyOKN9C8kveYTay
    seHyjLFmEDAyxOejLjBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL8YVAg1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 09:34:31 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v4 13/17] can: calc_bittiming: add can_calc_sample_point_pwm()
Date: Fri, 21 Nov 2025 09:34:10 +0100
Message-ID: <20251121083414.3642-14-socketcan@hartkopp.net>
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

The optimum sample point value depends on the bit symmetry. The more
asymmetric the bit is, the more the sample point would be located
towards the end of the bit. On the contrary, if the transceiver only
has a small asymmetry, the optimal sample point would be slightly
after the centre of the bit.

For NRZ encoding (used by Classical CAN, CAN FD and CAN XL with TMS
off), the optimum sample points values are above 70% as implemented in
can_calc_sample_point_nrz().

When TMS is on, CAN XL optimum sample points are near to 50% or
60% [1]. Add can_calc_sample_point_pwm() which returns a sample point
which is suitable for PWM encoding. We crafted the formula to make it
return the same values as below table (source: table 3 of [1]).

       Bit rate (Mbits/s)	Sample point
       -------------------------------------
         2.0			 51.3%
         5.0			 53.1%
         8.0			 55.0%
        10.0			 56.3%
        12.3			 53.8%
        13.3			 58.3%
        14.5			 54.5%
        16.0			 60.0%
        17.7			 55.6%
        20.0			 62.5%

The calculation simply consists of setting a slightly too high sample
point and then letting can_update_sample_point() correct the values.

For now, it is just a formula up our sleeves which matches the
empirical observations of [1]. Once CiA recommendations become
available, can_calc_sample_point_pwm() should be updated accordingly.

[1] CAN XL system design: Clock tolerances and edge deviations edge
    deviations
Link: https://www.can-cia.org/fileadmin/cia/documents/publications/cnlm/december_2024/cnlm_24-4_p18_can_xl_system_design_clock_tolerances_and_edge_deviations_dr_arthur_mutter_bosch.pdf

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/calc_bittiming.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 35db90be9c9a..0b11c4e98172 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -20,10 +20,25 @@ static int can_calc_sample_point_nrz(const struct can_bittiming *bt)
 		return 800;
 
 	return 875;
 }
 
+/* Sample points for Pulse-Width Modulation encoding. */
+static int can_calc_sample_point_pwm(const struct can_bittiming *bt)
+{
+	if (bt->bitrate > 15 * MEGA /* BPS */)
+		return 625;
+
+	if (bt->bitrate > 9 * MEGA /* BPS */)
+		return 600;
+
+	if (bt->bitrate > 4 * MEGA /* BPS */)
+		return 560;
+
+	return 520;
+}
+
 /* Bit-timing calculation derived from:
  *
  * Code based on LinCAN sources and H8S2638 project
  * Copyright 2004-2006 Pavel Pisa - DCE FELK CVUT cz
  * Copyright 2005      Stanislav Marek
@@ -90,10 +105,13 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 	u64 v64;
 	int err;
 
 	if (bt->sample_point)
 		sample_point = bt->sample_point;
+	else if (btc == priv->xl.data_bittiming_const &&
+		 (priv->ctrlmode & CAN_CTRLMODE_XL_TMS))
+		sample_point = can_calc_sample_point_pwm(bt);
 	else
 		sample_point = can_calc_sample_point_nrz(bt);
 
 	/* tseg even = round down, odd = round up */
 	for (tseg = (btc->tseg1_max + btc->tseg2_max) * 2 + 1;
-- 
2.47.3


