Return-Path: <linux-can+bounces-5297-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C00C29811
	for <lists+linux-can@lfdr.de>; Sun, 02 Nov 2025 23:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25456347003
	for <lists+linux-can@lfdr.de>; Sun,  2 Nov 2025 22:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40246244668;
	Sun,  2 Nov 2025 22:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTvDUASZ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A1D23F429;
	Sun,  2 Nov 2025 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762120946; cv=none; b=LMgAsffocNyM/Qx2pAJSMfxZpyk7me40P7ObFzO//uli65x4GtI6Arr6WAvfNojPTqxGOEg/SyISYfEeLeunZcebplvHc6w5EgVBfE87aXiP9KqNUGnTb5b8e2INbgk5b6zkFblHbJ/bYdIfKbT40WkZyQRPhb3aDYzYOKFcBc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762120946; c=relaxed/simple;
	bh=M14/3I7hSyMX036rXWnLcD8g9ZFAnXjcWe1rvZIgbYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J1AUViqXtmsB210t9jXJVW3NlzuXiQsY15Of5r/o8vs5gTiOOcdHAy9tBQBQg3ACwvumVsdThHTsu+QeQ8SBQKslT9RAFUdYJPF9QpuDcob3uyOB/9ds2qDqiqAvUkbIA8sRaG5EQVjwSc4kkAumo+3Bwh+7Fvi3URblm3xITC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTvDUASZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D1FC4CEFD;
	Sun,  2 Nov 2025 22:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762120945;
	bh=M14/3I7hSyMX036rXWnLcD8g9ZFAnXjcWe1rvZIgbYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PTvDUASZymm30mwd++kitNXTx+pe96WoPw+CgZ6bpQjFrjDAifGgNIa4x7vEDfjad
	 Fd1B/d9Fu/XTh/ykUZvrpYNonyWuAEyeLohxZ1DIC6fS/+/howFCBPJBweSRa7H0Iy
	 JCJW5mtTCHmpwtcdNPWU4TJyr2ZBYlE16fGFE9D0Be7GbrXZvbBA22ah2slW0b/HEB
	 XPUATZ4+qhzJhbM43t0WjyucmA1ZjfalDii5ppN/3A5BDpLVnPzzKtfJFwCoozhqkC
	 KYZWJI8k0nE1vwY9b0fENAbO1n6gxfR4YkSk/OZJq1604Tl7g3sV5nQ+bnP/HnsazG
	 iO7p3nCjkOxvQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Sun, 02 Nov 2025 23:01:22 +0100
Subject: [PATCH RFC 1/3] can: calc_bittiming: get rid of the incorrect
 "nominal" word
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-pwm_sample_point-v1-1-3bbea180f59e@kernel.org>
References: <20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org>
In-Reply-To: <20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4507; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=M14/3I7hSyMX036rXWnLcD8g9ZFAnXjcWe1rvZIgbYE=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJnsV566Llm2SumRbZqtacnfncer/rUaLPX9ftTffeG0a
 6YN7nnaHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACZy6znD//ib0iJSc7T8D3tl
 TH8dW5dx6PnKLLZvEzcxXv/9Y7qhy3OGvwJcz/72XLmeHn2lN/nzi+sfPn4VMNfq2tcm+J1D+ee
 mnewA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

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
 drivers/net/can/dev/calc_bittiming.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 268ec6fa7c49..222117596704 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -24,7 +24,7 @@
  */
 static int
 can_update_sample_point(const struct can_bittiming_const *btc,
-			const unsigned int sample_point_nominal, const unsigned int tseg,
+			unsigned int sp_origin, unsigned int tseg,
 			unsigned int *tseg1_ptr, unsigned int *tseg2_ptr,
 			unsigned int *sample_point_error_ptr)
 {
@@ -35,8 +35,7 @@ can_update_sample_point(const struct can_bittiming_const *btc,
 
 	for (i = 0; i <= 1; i++) {
 		tseg2 = tseg + CAN_SYNC_SEG -
-			(sample_point_nominal * (tseg + CAN_SYNC_SEG)) /
-			1000 - i;
+			(sp_origin * (tseg + CAN_SYNC_SEG)) / 1000 - i;
 		tseg2 = clamp(tseg2, btc->tseg2_min, btc->tseg2_max);
 		tseg1 = tseg - tseg2;
 		if (tseg1 > btc->tseg1_max) {
@@ -46,9 +45,9 @@ can_update_sample_point(const struct can_bittiming_const *btc,
 
 		sample_point = 1000 * (tseg + CAN_SYNC_SEG - tseg2) /
 			(tseg + CAN_SYNC_SEG);
-		sample_point_error = abs(sample_point_nominal - sample_point);
+		sample_point_error = abs(sp_origin - sample_point);
 
-		if (sample_point <= sample_point_nominal &&
+		if (sample_point <= sp_origin &&
 		    sample_point_error < best_sample_point_error) {
 			best_sample_point = sample_point;
 			best_sample_point_error = sample_point_error;
@@ -68,11 +67,11 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
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
@@ -81,14 +80,14 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 
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
@@ -115,7 +114,7 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		if (bitrate_error < best_bitrate_error)
 			best_sample_point_error = UINT_MAX;
 
-		can_update_sample_point(btc, sample_point_nominal, tseg / 2,
+		can_update_sample_point(btc, sample_point, tseg / 2,
 					&tseg1, &tseg2, &sample_point_error);
 		if (sample_point_error >= best_sample_point_error)
 			continue;
@@ -146,9 +145,8 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 	}
 
 	/* real sample point */
-	bt->sample_point = can_update_sample_point(btc, sample_point_nominal,
-						   best_tseg, &tseg1, &tseg2,
-						   NULL);
+	bt->sample_point = can_update_sample_point(btc, sample_point, best_tseg,
+						   &tseg1, &tseg2, NULL);
 
 	v64 = (u64)best_brp * 1000 * 1000 * 1000;
 	do_div(v64, priv->clock.freq);

-- 
2.51.0


