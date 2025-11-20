Return-Path: <linux-can+bounces-5519-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8126CC75F81
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 19:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 83C902BA79
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 18:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEEB283FFC;
	Thu, 20 Nov 2025 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="o7glXLU4";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tvGGED0D"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB023F40C
	for <linux-can@vger.kernel.org>; Thu, 20 Nov 2025 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664342; cv=pass; b=u78gvLOZQAiZW4xaSJl6vepjDFZxfyT4HqkVc6AYz1JfAO1nfjqSq+QUI5lKtjcFXKbC6S290a/lepl5FKc4hBaFj5ItWP7n5oHRf8pBTwmtmKxpWJJzqvCkIIC2qYa5s5H3pk+aU/EBsEe2Wb0zCSUzYizU5lQDcv5XERkXqvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664342; c=relaxed/simple;
	bh=j9iVrEuNvCAWRagM0mzU3ImFF0NvXFhGJvwswHZW8Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYgLyD4e69Bri9VRLcbvQYoKQrPlnLlIwJ4OyKpUkz1A1xt4W5ek2V7h3vzEpAo7tlpQiPG8/EuKCMBrYlt17fOScfNQxWH0tmOdtJTNwV7dUGikCJNOJ/Vz2P7o24C1A4uizq+1F9KkCUP3XckB2a0imlLoXjVULUGa9xnFIq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=o7glXLU4; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tvGGED0D; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763664324; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=llioDMnluR/Qm8FlRzUvY0QKIn0MpECD5UjX2FQRSt5m146o8my5hOdAJOUbpHI0mQ
    5Reu/dbMLE7v0zN4P9asZWst0Q6pGj6N6ktS8rqRA5JWiXkW+e3EKH4bwmkFSM7ZzMX3
    n2dOHJlrBlUEoMmuIaSb/r+wY1BBnLJgMBFW6f7Sspt7tjCYEux3Xuk++xMtnh5bM/1J
    TjdIyAcXtBElxn0YLFbbC0ipbvqqyVs2418H13bnKLxxdjnBVtD3ogtmRiRZ7FeN2SOt
    2IvY66MLa8YdPKxeCZPe9Y6Z1BRsWMQ2YXhH+QRUy/GPkeeOGkl/LbDPCsDrZo9lJ++T
    PteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664324;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=v+WleFIxZhCpRob3InKw1jiWKPKq9gwdIW5TkUd8Q/Q=;
    b=WZ9RJ6XqOya4xurOEq2yx6/FK8Ku0Yku0YgcYc1cb2lJtr8CCrjsBLX8vbASc+FnQP
    WqdoqC+trlQxUz2Ny9IHTtu4uj1Dewrr2UTA+kX7tEAVopYnWk6fCiFwHAaQwoktquhm
    6TmcT+CUG8n0+fTc34uJhP1ruvAZKLJ/2m2zFmbIvushDATeYsYc2DVhlaZqZRjSZGmq
    wFuyeMXPqM2Tf+bObQI7tbdtWmbQIoDf1vsxCuQoufHg/vOCD1AqYIbQ6XsAf9GeqJKH
    76tWYoQ1i+lIy4n13BT4zcu7mJhzelQb3yEwQAG0yN8L2BHCuC/AagUsOcNskV1e1K90
    HQ/g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664324;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=v+WleFIxZhCpRob3InKw1jiWKPKq9gwdIW5TkUd8Q/Q=;
    b=o7glXLU496wuXtcrKlMNLRXMtJhPezkeilCNuQvRLsZcp8xdhb9mqLsOssaaQrToxy
    sEpvkr5/B5gsdHxynPsrtLCPKDYRGtJIZ1/9P/JOOa2ymmtYyWt0kaAbFuynC9Zgu5er
    zsKPGx+1t3oCDXCIoop2B0vbfTx2I/AU1EHj1mOrzVh9XrLWhMD275rC+XZrYg7ux3ea
    wAahwrsHy2oI8Y43TVw1a2U1yELczf2k46HAYCQDLQT2ApJWfohZL2P1qcYtArtTKxx/
    Qr8MNJiBhIAA3EG3Au7U5GpERs/P38+6SIEVqLlKQD/OaTeFvL3fLoUpq+fgLwLTiHtb
    jTjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763664324;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=v+WleFIxZhCpRob3InKw1jiWKPKq9gwdIW5TkUd8Q/Q=;
    b=tvGGED0DE3TFNJw/ExlzT2/UuOQfrvMwHgwX0dO+gOjefhhSEnXvGyvjbScnvoH4Th
    QhBJFF8k/WfrcXu+wdAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AKIjO9DX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Nov 2025 19:45:24 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v3 13/17] can: calc_bittiming: add can_calc_sample_point_pwm()
Date: Thu, 20 Nov 2025 19:44:57 +0100
Message-ID: <20251120184501.27597-14-socketcan@hartkopp.net>
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
 drivers/net/can/dev/calc_bittiming.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 35db90be9c9a..dad49454df73 100644
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


