Return-Path: <linux-can+bounces-5440-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4F0C608C8
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 17:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E00714E75D1
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 16:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6255A2F2610;
	Sat, 15 Nov 2025 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LBPcFPut";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="w5y5JAzT"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BA52FFF86
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224695; cv=pass; b=j0h9FZcwjBaUWEwhLBqxgdjbHE6xSix/jwSCgatTNmZ6fCQmz5huTBUUVQ1P5ILq6NkfW3/nCcTGYIJImLP6CQtPZINXgXpOSBN3aVazCZ7Vy39vOScZ3g+R+IOXALezDiFq7LbzNAYc9LxAq4gf4zS2cS87IV6hrpk4vjevFqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224695; c=relaxed/simple;
	bh=GhPvK0oTpsADrluTfPzzcdevo7ZTDwi+uKsOGxPM0Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAHS/Ec7Jso95AzLAIsZviLB3bT+wsLGhACgX3zQ7YGxHIPjhg0M+8ArQ/qFTSCIxFbuD01PZXXe//QZUG+JCgVfKfz80rbKb0UHlbn5gR0jiLLjX7vZeDBn8xV0Y56cgRq7ftNAKza3NKHLrW4c7XJJ66tUahNgKvvMFcdxeqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LBPcFPut; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=w5y5JAzT; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763224676; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pSkMxH5U0Tl+1uOGR9bG+uA9ZVzKiegbo6Vimfyb3Qw79XCfl6Xpay6jzadOPF1Cgg
    OcCR1t56AWhC0H/+TMsffcCMgNzt2e6ve+wSf+rFMHHGTGFKS89aPX0AmBgDqpa4ss2D
    eRyEPnXCpEu/FZ+sup7+QoTYuprBW+v1+xR4kAxOiqeEWvKAbMOlkasm4f5TeLIkIbfb
    xKyz3xWsyERgB1ww/Di7jCKiUDn5xEiIjwMsOFfvZ//07qx/iWfahuxc5j66lneHn7OC
    JzV0lOz01VG2YiYvnlS/mHAikDjA+LRjgpiiH0dWVKWMk8WvxtyFKOIKXOsU02mWKHBK
    nQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224676;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HxIiHsj0LbF365hfLXasvbc7kxtpGtfWFaE3FWri4ek=;
    b=BzRmW/CgtB5MIL/JoBUYVq3A9Md/x43ETIwWneubB3q2Iumzr4+BW6+vdn67rReuCk
    I2eIit9ngI+2aw6Z8cuNJKdfCvPtdk86EKVm4RxLyYh4RcMBxGQtb0IclKYYeYjXJyKv
    ouy3jtSVb+3zYpk+YXseSFBtmGbmhAunbD3JODIiv0CLumzxXV5FJLdGXOvR8JxUKbgn
    2QTm8c42HV3Qpmct7UlWuLi9mzHyr7GOvvHGzl2urtQEd22iljHywTkViFkNFeO5pDwB
    mA8XwklInJtbKx9nY5fjk8kpWloBG15AFHGP+savTrD9UxA/cFWY5iIvKjex59DHp8t+
    M0Ag==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224676;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HxIiHsj0LbF365hfLXasvbc7kxtpGtfWFaE3FWri4ek=;
    b=LBPcFPutkHosqEROI8CBmocqvM8XTYBb/DSJkNZveFMTcV30F8LkqoPL1WdiWC0yA3
    xvDQdIepot5BR79WD5Xx/m3f1VCjmXJyi1tZ12BGrKmrfI+F8M9fTIlk+XhaoIFW7Z0j
    taoJSbyeR0nykNWwKExJmtLX+sumC1YmmPBZRxmVvpEAWRwVKBmELKIrVVZg0P5NMeza
    6GR0hBEEQ1SHTcZj2SRvfmB8dPAQ1aasCl+yWKj0V5T56rnaHTOnoO2ckMg6wU4YkJHi
    fhlOfUIZVRx8TKbFn1BWDSSW2Y9vZkrJED67BhjjJw4CN2C6Os9uWdSQAixP9HVGOGxR
    Itew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763224676;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HxIiHsj0LbF365hfLXasvbc7kxtpGtfWFaE3FWri4ek=;
    b=w5y5JAzT5OVKtQusJl7zy8mNBtQ7FPmL8XyFpOVCFrZz3qM0ZIKNMxx6Yh8EhrHNBF
    +ho1Gs2qd27Yi4mJSsCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFGbteQu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 17:37:55 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl v2 11/15] can: calc_bittiming: get rid of the incorrect "nominal" word
Date: Sat, 15 Nov 2025 17:37:36 +0100
Message-ID: <20251115163740.7875-12-socketcan@hartkopp.net>
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

The functions can_update_sample_point() and can_calc_bittiming() are
generic and meant to be used for both the nominal and the data
bittiming calculation.

However, those functions use terminologies such as "bitrate nominal"
or "sample point nominal". This is a leftover from when only Classical
CAN was supported and now became incorrect.

Remove or replace any occurrences of the word "nominal" with something
more accurate.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/calc_bittiming.c | 30 +++++++++++++---------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 268ec6fa7c49..222117596704 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -22,35 +22,34 @@
  * registers of the CAN controller. You can find more information
  * in the header file linux/can/netlink.h.
  */
 static int
 can_update_sample_point(const struct can_bittiming_const *btc,
-			const unsigned int sample_point_nominal, const unsigned int tseg,
+			unsigned int sp_origin, unsigned int tseg,
 			unsigned int *tseg1_ptr, unsigned int *tseg2_ptr,
 			unsigned int *sample_point_error_ptr)
 {
 	unsigned int sample_point_error, best_sample_point_error = UINT_MAX;
 	unsigned int sample_point, best_sample_point = 0;
 	unsigned int tseg1, tseg2;
 	int i;
 
 	for (i = 0; i <= 1; i++) {
 		tseg2 = tseg + CAN_SYNC_SEG -
-			(sample_point_nominal * (tseg + CAN_SYNC_SEG)) /
-			1000 - i;
+			(sp_origin * (tseg + CAN_SYNC_SEG)) / 1000 - i;
 		tseg2 = clamp(tseg2, btc->tseg2_min, btc->tseg2_max);
 		tseg1 = tseg - tseg2;
 		if (tseg1 > btc->tseg1_max) {
 			tseg1 = btc->tseg1_max;
 			tseg2 = tseg - tseg1;
 		}
 
 		sample_point = 1000 * (tseg + CAN_SYNC_SEG - tseg2) /
 			(tseg + CAN_SYNC_SEG);
-		sample_point_error = abs(sample_point_nominal - sample_point);
+		sample_point_error = abs(sp_origin - sample_point);
 
-		if (sample_point <= sample_point_nominal &&
+		if (sample_point <= sp_origin &&
 		    sample_point_error < best_sample_point_error) {
 			best_sample_point = sample_point;
 			best_sample_point_error = sample_point_error;
 			*tseg1_ptr = tseg1;
 			*tseg2_ptr = tseg2;
@@ -66,31 +65,31 @@ can_update_sample_point(const struct can_bittiming_const *btc,
 int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		       const struct can_bittiming_const *btc, struct netlink_ext_ack *extack)
 {
 	struct can_priv *priv = netdev_priv(dev);
 	unsigned int bitrate;			/* current bitrate */
-	unsigned int bitrate_error;		/* difference between current and nominal value */
+	unsigned int bitrate_error;		/* difference between current and calculated value */
 	unsigned int best_bitrate_error = UINT_MAX;
-	unsigned int sample_point_error;	/* difference between current and nominal value */
+	unsigned int sample_point_error;	/* difference between current and calculated value */
 	unsigned int best_sample_point_error = UINT_MAX;
-	unsigned int sample_point_nominal;	/* nominal sample point */
+	unsigned int sample_point;
 	unsigned int best_tseg = 0;		/* current best value for tseg */
 	unsigned int best_brp = 0;		/* current best value for brp */
 	unsigned int brp, tsegall, tseg, tseg1 = 0, tseg2 = 0;
 	u64 v64;
 	int err;
 
 	/* Use CiA recommended sample points */
 	if (bt->sample_point) {
-		sample_point_nominal = bt->sample_point;
+		sample_point = bt->sample_point;
 	} else {
 		if (bt->bitrate > 800 * KILO /* BPS */)
-			sample_point_nominal = 750;
+			sample_point = 750;
 		else if (bt->bitrate > 500 * KILO /* BPS */)
-			sample_point_nominal = 800;
+			sample_point = 800;
 		else
-			sample_point_nominal = 875;
+			sample_point = 875;
 	}
 
 	/* tseg even = round down, odd = round up */
 	for (tseg = (btc->tseg1_max + btc->tseg2_max) * 2 + 1;
 	     tseg >= (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {
@@ -113,11 +112,11 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 
 		/* reset sample point error if we have a better bitrate */
 		if (bitrate_error < best_bitrate_error)
 			best_sample_point_error = UINT_MAX;
 
-		can_update_sample_point(btc, sample_point_nominal, tseg / 2,
+		can_update_sample_point(btc, sample_point, tseg / 2,
 					&tseg1, &tseg2, &sample_point_error);
 		if (sample_point_error >= best_sample_point_error)
 			continue;
 
 		best_sample_point_error = sample_point_error;
@@ -144,13 +143,12 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 				   "bitrate error: %u.%u%%",
 				   bitrate_error / 10, bitrate_error % 10);
 	}
 
 	/* real sample point */
-	bt->sample_point = can_update_sample_point(btc, sample_point_nominal,
-						   best_tseg, &tseg1, &tseg2,
-						   NULL);
+	bt->sample_point = can_update_sample_point(btc, sample_point, best_tseg,
+						   &tseg1, &tseg2, NULL);
 
 	v64 = (u64)best_brp * 1000 * 1000 * 1000;
 	do_div(v64, priv->clock.freq);
 	bt->tq = (u32)v64;
 	bt->prop_seg = tseg1 / 2;
-- 
2.47.3


