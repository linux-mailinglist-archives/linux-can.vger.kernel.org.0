Return-Path: <linux-can+bounces-5582-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D06C7B8D3
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 705D3355908
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EBE3019C4;
	Fri, 21 Nov 2025 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="oapCOR31";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="FmNwKZDd"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C42F2848AA
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753748; cv=pass; b=ZfWRETiRm4PxYvLMyT/QCFx8dq+L4u5YCyQj2E+gSAYfyOhoSINokuB2CfkOapGhh2muowY7ggR2BalMArJVrLrhuPUysnsIW64gE3RjNkdAaxWf06BDVHHMkrvJHv7zhYDV8vS4Dxncqw313UVDsFBlRKBG9xmsrNsW0JyhOCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753748; c=relaxed/simple;
	bh=jXJqzBRLihuZafOKM4El5E7LQSm/LV0S3zNLCcHW8wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wu6OALE7XofV0UrX9CtzFjkEl/pMGJWyzfN7NVem4qpnKpPd4bGje7Lmec/BPyjHz7JFMUy87BeDR29x6syaB42vSodEe0tkrc8eaUmLBjHVbCFp9aFxmvuk9rrBnH2aN7FJG7w7T80jzGeniNScbBabLGSazeFkyk1CVtGyuu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=oapCOR31; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=FmNwKZDd; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763753730; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HGmmepBAmikAmcCcwCqu7bSFkSDgVBpBZv6I7JLge30pyQpgbYwsquSexVvjop6h8Y
    mqxW5d3KB9Mhj6Nd3CIhTC7oq8i813Dijw+9ktBlWn37SG4J0Wh5rk8URG4TJ+uDpz+v
    5A+J48zfCkAPqS43UjvpqWswhc2tmkpQXIXQdCqcgLnnJL9+Zu8OPJgtfWeS8yf8SuGp
    fiWe5xzKnIquArUBbBMZTcxqUyUsQFYvodLN7Zm9eqURmsaSiSbf8II0AmdSFGFOntOW
    5ZMT4dGYVqWoneM6Vu0lgm/ILJZH81WTcT/fo1dDRa7hbmOZw1vGkQBPx43iPT3jDrOn
    6VEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753730;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eKg94ulVJ5xRJdNwXo2VodRRUT9kgiUpSYPSOwDPCjU=;
    b=pH1nJi5MKaBYwv3aWmUxwMFKidEn4LZKnYv4bX5oaWH5Gd6Mq/Z7K963V9qtvT/4bi
    pqD9NgXdDf9G6o6E8udLIFQZSUDYjCUWPZAqmnyjnyHY25822obVINVBCWx/Du7BUevr
    NpqRSOz5AG0P2DqInO1JN3Gr/a35W5jcL/TJ4eDeGQzSefmSLQRlC/ZrqAlm8lTac/gX
    Dc9gaUN3MDieoI8rIluJia2Xl7uv5p6kLJp+3VOEy1JtiO7yr/4MEmcF5bhotAQyhe0T
    DYcmF3UCmtIH89JqF6/Gi6hp8zwKjqYAMZtPE+gvXlF1/J+ahsojmkl263i7OV1Hk4EN
    lpDQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753730;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eKg94ulVJ5xRJdNwXo2VodRRUT9kgiUpSYPSOwDPCjU=;
    b=oapCOR31NqkXja1msg8AQAsYkP1xyXClppZZWhzxQjtDZre/omSLLy/8jF8r/yxnEC
    zkMQJeLQJvCEMI4ThUNWrjC4W7WUmHAKv4YdJZRVR0npqvLIAjNjxhqB0kOYHAk/25f5
    mscpjOpZMDRb6pmLFBEeidHv4Qec5x63p+0vZPP75XHf2oKg1iNwlYhT5sF+4Frqb3Fa
    56WzwfeBRTg9VrcnNcgaHt/uSG2lfuVrjyuD+hv51DPvuCx/1kXUQH7lzVgJWlUWKIXq
    WQ1IRQjfxUT1ihsg5ucSHK02LvBg4aLS6OJgTvFa6lcL4CNJsDCy5XxApCk8bBahZy5n
    pU+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763753730;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eKg94ulVJ5xRJdNwXo2VodRRUT9kgiUpSYPSOwDPCjU=;
    b=FmNwKZDdKcf4DMc4YAyfddOWt9F1XvReCQYRYI4fldomo0AqfZakZTkbyY8FcZqrVp
    XQVzASnjIU8Re5XrNJBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALJZUEnF
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 20:35:30 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v5 14/17] can: calc_bittiming: add can_calc_sample_point_pwm()
Date: Fri, 21 Nov 2025 20:35:10 +0100
Message-ID: <20251121193513.2097-15-socketcan@hartkopp.net>
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


