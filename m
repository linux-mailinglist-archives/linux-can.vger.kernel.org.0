Return-Path: <linux-can+bounces-5430-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B0C6089E
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 17:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D759B3B6DE9
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 16:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873FA2FF659;
	Sat, 15 Nov 2025 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Yd4CPqW4";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="T5AC+Y6u"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A32F2610
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224684; cv=pass; b=l/Lky3QTE6lN07f6ekWlLLWLY1hfDobDsU7AaMhkhjOzzu+KP6gpoGSUpPe/N4qD+DDoPVPyWDWlpH/jnsc5YOO1/SK+ycObBupr5E6RsAtdFCLZIvLfrkQ9wjct7w2mfDHrX5q4Gf4IxGOZwCGxLGfvVFryrehABoQY1fgD8i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224684; c=relaxed/simple;
	bh=L78qhuU23KCpMFd1QEszq4KJRacqrVFwRVDnqxk+huw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otYbunJX4DL3LwAnb3/lkhenVbt0i4y2OvT3ZJkNvUah84bezOWLh+uwC5D3zq543bPrQFKwVLhMM1PThU8+46z8TebP6mAo8OsHeRTMQyVYMxFYE8e9DkC5WKoWe+AqIPVrFGStZ7S7xzPBTp98TkK/Wd+MbndVIgqsfi1i0vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Yd4CPqW4; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=T5AC+Y6u; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763224676; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UrPj6qKMTJlFF6na9YhV13aDAs91iopCHtsPk8zkNfaWgWpnDM0Os+LEih0iP/g8YR
    7tl3enKGBlMyvKcX2r2Lyc+m+n/r0du3N3P8+e4YLK+stdbyWMRyvwfEQWjx4kT5G47o
    9yRSEheAS6KMsc/jMjx0oiNavHDFYzNFyf96b6Eskslwaf18cLb565VNvIBZsKqGhMdQ
    NKH/RoOSgISKoo96KMpSWCHhpplsPCtMzLrjQ2OzVnvsvyFJnTAVNriaZhTkrkGCHK7i
    NdVQNp2qgvdHQcSI5j3I3+cXyo6vQ9qi70OAN/DaIC0sY9lh1dlVrCA3uRwFejXPwu0M
    ldBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224676;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=YJuxFBw88keegOCH87idgfDbzF0yOiJ5oQlW6cWIWsw=;
    b=WLWEJXCz7737j4I0yKUQmAa9PwwhmkY10JCixkxEvbzqhxB1XbJKWNc5wgwvSx9quB
    9g1DrgUd2MZjp8LZoJiuigjwFF4gabeQV/DQWWXPSe0grA1HWzyRSCsBDaMxq3eUaKZ5
    rJL/4zkEXJMFPxhvRundqekPh4wQcN04lLRHdK6I0TJU+2xETqDUT1FJGsfzfBHS8sEa
    wvYSBj29AQ7tBmArUVx6BPv+aXeficDKR+LNXYbLXr8S0MRLJsht/KZTNS39cj5jqb5A
    7u4/NA1SZTFyafKGr+Dr3ddbvCiLGF0IlZ5iet8BGn6Zv+ZdvOH/f3wOqMxNWXvg8pkr
    FceQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224676;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=YJuxFBw88keegOCH87idgfDbzF0yOiJ5oQlW6cWIWsw=;
    b=Yd4CPqW4Rskcp0QRKz3MrCbmEazkGqmIF12fpCmEStA+ijHGRhC8+pUdTnCNplcTpO
    XYxEzF2Mt2Uebm+UdvgHyOXVWMOCa4px3O2ziUfWoh3jZ8J6WqXa83Yn3G3kDTSwqbQS
    iy9dTiOx8K36qECbJPoAb7cwNO9fKPlom7yTInV0T8MIOP3iywlW5oOTDw6D1tZeC2Lr
    PTIPsFMjYzXEoMESaAoxFfOnW8JVRwDboH8NjBqkdWdt9McJO6wEhHFNLuIVFMQeJiLM
    pd1nxRyVO10of97e/PsYcurxoRaNm0XOgif12eauIU0EhcwBzQxwnekT9X/dDYTdP19R
    ViRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763224676;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=YJuxFBw88keegOCH87idgfDbzF0yOiJ5oQlW6cWIWsw=;
    b=T5AC+Y6uQ5x2R0pmc6AOkJS1DivSMcYHWKavlK3MfkZ+0h4d+L/akpkWYDwiBs+SoJ
    OycWugFDwf7mLr7t83Dg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFGbueQw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 17:37:56 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl v2 13/15] can: calc_bittiming: add can_calc_sample_point_pwm()
Date: Sat, 15 Nov 2025 17:37:38 +0100
Message-ID: <20251115163740.7875-14-socketcan@hartkopp.net>
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
---
 drivers/net/can/dev/calc_bittiming.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 9b2d0e458518..be6726dcd7e7 100644
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
@@ -90,10 +105,14 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 	u64 v64;
 	int err;
 
 	if (bt->sample_point)
 		sample_point = bt->sample_point;
+
+	else if (btc == priv->xl.data_bittiming_const &&
+		 (priv->ctrlmode & CAN_CTRLMODE_XL_TMS))
+		sample_point = can_calc_sample_point_pwm(bt);
 	else
 		sample_point = can_calc_sample_point_nrz(bt);
 
 	/* tseg even = round down, odd = round up */
 	for (tseg = (btc->tseg1_max + btc->tseg2_max) * 2 + 1;
-- 
2.47.3


