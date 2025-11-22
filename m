Return-Path: <linux-can+bounces-5600-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A001FC7CBDF
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 10:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4697D3A8652
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AFF2F1FFC;
	Sat, 22 Nov 2025 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="gYUjSVrv";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LLvcfXeT"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BF72F5478
	for <linux-can@vger.kernel.org>; Sat, 22 Nov 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763804187; cv=pass; b=ORrsUFHbIbjE9q86OhAehb69G6n50uVCyY8dX4AhXLZPAhHfr2gbcHD1F3FpT38e3ZXhybR/F80QRZqrlZw8LrVPtVgtCTh3G3lHI03hB+3oyrADYo2KiAi6MGwZbGLCYQfG4s2/gdK0LvI139GsOR2Rt5lMiEhKApg+MbjIBf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763804187; c=relaxed/simple;
	bh=jXJqzBRLihuZafOKM4El5E7LQSm/LV0S3zNLCcHW8wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0xvgFX6Hk6gG1WygHsNljYgj22jRTeEMfyPmZUEzzOxw5fWQPG6UeAehJrq50itGcjJiOGcQS4tuQxkcXy2+tXus+4J2vAYpPUFisP1J1OHisLRZM3Z9cqGIYH/Tdz20Sn5BMLuLBTyGFUXeOY7ggutEnAESV09NnlJyFolMWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=gYUjSVrv; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LLvcfXeT; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763804172; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Q9P5Pm72pLtON23RuvZxbxDwaLFxRvJONCrwdUPAGxZxy1mbvH0M0v7cYMoqC9q8rJ
    GyS8nkURO3ShV+p3at3VIt0mqFE2pk5/5Rs5NalP0NRF2H6WTDv55SahGBVdk0xVQ/kv
    nK2Cdy5HaQgImNAb9eBAuHlHV/GdkfQA+qLCBBrd/0PYliKot2kcqlYxP8Mcar/owm0N
    2/ORRAMTaxsjAM030n28TU6sof3pykigG2VPcAuba71d7Y2T/3w8zleFUWiyO0fbeFPy
    FE50LgU5wEp0dt6VSBUV8tHIi1EsKLZ4sFKu0V0vziR9WQBihR+94cnWCevc/hJJHA/u
    b8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804172;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eKg94ulVJ5xRJdNwXo2VodRRUT9kgiUpSYPSOwDPCjU=;
    b=WapxlBqykODcgTiMZlG8oLiooBo1fcGvVnR1iD0dqV8xLFBQuyyNCK4QXk4a/uBrKB
    YT2TYWAAm2Mk6rc9wrYUMTKWwZ4v5Y6SaW9nzRf9F7U5h9MYIPilWXvrWT30tIGylimV
    ZlcMo+c2YbxJbd3OT8u09VDZfkX+oKq4FsIjEFrObNMWN257Od5hLjKRA1ocCluMKXxb
    xbvLkoyxPJEavB57+eBa0hcJxF/yTpOfUv5Cm1IAPgVyvmPPLreGYvpMnaaZpo3Og32R
    MEDVGJptYymjP6h+DFZ5SEa87vWdcGBRF05ZxgQledOWZjDVjC9t+LgLeYKwKyWXOH7I
    ixKg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804172;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eKg94ulVJ5xRJdNwXo2VodRRUT9kgiUpSYPSOwDPCjU=;
    b=gYUjSVrvCaqTw/qH2CQu56V3PuWgP6D4vxzTTYfnGq90z70ll5wtOzlCcg4GXihkon
    DwBvdUHkjNt1IdX8Wwkbnh8jsiKv2/8BuhBFtfq1GSKzoKS8qES1Hqptc8XTFcCJu869
    N4BH5yVmNpAhnsoYaaAvaZrf11wTZxh58J8EO1W3ntuKojrsDoSaUXh4DJlFh0ZhiSZX
    ATsEoq1gHp/etwhdif1m8/eZ7vGwCK9he1+5b/rD7aJE51d2nY+UTudqKFfs1lMeGReN
    JF0AEiO120jd7Yt5aL+oUUc0mzzXJjIxymAc4HL0wXd7j0pEyaW+TCaqn28ZgA87//6f
    rFwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763804172;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=eKg94ulVJ5xRJdNwXo2VodRRUT9kgiUpSYPSOwDPCjU=;
    b=LLvcfXeTN9tX1kwZkKYvX4vYzHcPLHOeJeoaDLSZXCoVGlfo4O5IRa5KTDQL9fXzs+
    nZIP2LOYgypDOdS0e7AA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AM9aCFdy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 22 Nov 2025 10:36:12 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v6 14/17] can: calc_bittiming: add can_calc_sample_point_pwm()
Date: Sat, 22 Nov 2025 10:35:58 +0100
Message-ID: <20251122093602.1660-15-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251122093602.1660-1-socketcan@hartkopp.net>
References: <20251122093602.1660-1-socketcan@hartkopp.net>
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


