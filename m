Return-Path: <linux-can+bounces-5646-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FC8C85008
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 13:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE453B23CE
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FCD301493;
	Tue, 25 Nov 2025 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="qwxaJMz4";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Nd6PvMoB"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8330CDAA
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074372; cv=pass; b=ugqS6hgDObuEDCuUNX3c8SB0XTiKmokGCBzmTHtZZbf8jTuHj5/QhjiJZzAVlT8Dwojqws3IclFZB0q6mo2l9w7xX6p5+pdrB2vOWEpU5IpOsISK8NSq4XuTPi+wUBktMm0mNzO8VBUXQSHyBSJ4d86ENnx6Cf2E4j+knGP/j0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074372; c=relaxed/simple;
	bh=0AaIpZeLvXk4TmubDn+FdpydKuHP3+59DDLYTYxLW9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPT+puokJWecdJ+jWOsyNSWKmUFzeQR/W7bqgpzI+u/mTIcdY3v2aELFvvzwDu2nTkz42zDYDqBscoCZ2ItTad8zGmbwhj7kYdREwG3Ef/vYrqtWWsmmuQN7m2JOEY2Nv1TcUkYKZIZium2crOGywG8fccR3JF5pQSaqhPMMlCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=qwxaJMz4; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Nd6PvMoB; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764074356; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=V/ycAx2XMWGnFekrzi2908TqhuT884ywENtgA+gPh/uJYcZxErdCC4ptb2VZ3Xzh7f
    d9yTet12kUFpE7xzrlBOWJkYKE2FKAgCA+7Bqm+S9d1i9U2bzXHaXRoccjZKwdSEsKQY
    sbMukeWa97yS28nhWJH5MT/ieJMi3JPE4sCdVmaf7uFfIhH9++utb1Kv+C+YA0MfYOYV
    x/uQUGm5IsBtJmZsG4fTCZebEqsHh/oIYHAyVRXrdc5CSn5Cd9mQ5S7XA/1oqYtNI9cD
    mUtPquRRcxJmsvkrcztdLDLQGoakbfQaIeTiP2Sd67aEtPNMZYVjQCCINJieF4SQWex4
    G8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074356;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kjd+hHKGoaYbEP0miptzBTsChrI/eNkwTx1XU2+Zcs0=;
    b=eMs3YeR05aqgnIZVU86CSGUOG2SUBp5xI/FZYfbh05dY8YFCMpvVK9LAhgkHu9H0jT
    RnEJ42L3S1Bqbp/RkZj8GV54SMzb2HenShlhoc79NAlZp5oEKOxeh+GIWxhrH+Yf8iUV
    RT0FGw1FEqVRRJfrwZYxz0sxliir9FxB6+1zstf85kbjHHgQNDqbb5xJSLBA3BjR4VJt
    VXhSb+MiokpqYTvJ9J6oFUMMKZPtqfb9wqSyo5oju56yUOLbdY0Rf8LRHJ+9SbwW/50r
    6oxl7QhyVAS+wCG8QpKCdbJaNMMITtenOdyjJXT+NAoAsKysvH+Lp7zTFtnJmACHWCnU
    ebxw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074356;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kjd+hHKGoaYbEP0miptzBTsChrI/eNkwTx1XU2+Zcs0=;
    b=qwxaJMz4DWbNjz16ujdYpFCdvSszzDUKReOsa8OXrT63UGhLd+NjFpZGv6rh4qgCC8
    Y0G/AgEnxZeUa2Uobe/b7BXqqSvJ05VJUcd5ljCs9CeDnM29mdNJFiI/ro38BhhTZUvx
    3bj86N1oY71NqHmdHLyT3Jb2mNt0//TWFa8CdO8Y9uURJ/Hpjv5JFW4JAA7TPVQJfBRs
    4kvu8KKTtKWWUZEXeIx2xBfKk8hVltCPq6W7k+hwplSH06Of+1wZI3a0OwMbqZ/zFCOH
    p0TvoG8FPFx+9EC+FsiQE95uD5/4bqaXqXxAKofmOAgUG/GCxxj2v0Xj7hh4wve8EIDE
    Iowg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764074356;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kjd+hHKGoaYbEP0miptzBTsChrI/eNkwTx1XU2+Zcs0=;
    b=Nd6PvMoBrKFPKndKpMqSjefKO4pu8o0WPnWOdssBMfP0zOi1qh8FGMLAtYe9U9XbrQ
    UNPJM0CQJwUDHsLmGxBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461APCdGT8X
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Nov 2025 13:39:16 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v7 13/17] can: calc_bittiming: add can_calc_sample_point_nrz()
Date: Tue, 25 Nov 2025 13:38:55 +0100
Message-ID: <20251125123859.3924-14-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251125123859.3924-1-socketcan@hartkopp.net>
References: <20251125123859.3924-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Vincent Mailhol <mailhol@kernel.org>

CAN XL optimal sample point for PWM encoding (when TMS is on) differs
from the NRZ optimal one. There is thus a need to calculate a
different sample point depending whether TMS is on or off.

This is a preparation change: move the sample point calculation from
can_calc_bittiming() into the new can_calc_sample_point_nrz()
function.

In an upcoming change, a function will be added to calculate the
sample point for PWM encoding.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/calc_bittiming.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 46f6f5942abb..35db90be9c9a 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -8,10 +8,22 @@
 #include <linux/units.h>
 #include <linux/can/dev.h>
 
 #define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
 
+/* CiA recommended sample points for Non Return to Zero encoding. */
+static int can_calc_sample_point_nrz(const struct can_bittiming *bt)
+{
+	if (bt->bitrate > 800 * KILO /* BPS */)
+		return 750;
+
+	if (bt->bitrate > 500 * KILO /* BPS */)
+		return 800;
+
+	return 875;
+}
+
 /* Bit-timing calculation derived from:
  *
  * Code based on LinCAN sources and H8S2638 project
  * Copyright 2004-2006 Pavel Pisa - DCE FELK CVUT cz
  * Copyright 2005      Stanislav Marek
@@ -76,21 +88,14 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 	unsigned int best_brp = 0;		/* current best value for brp */
 	unsigned int brp, tsegall, tseg, tseg1 = 0, tseg2 = 0;
 	u64 v64;
 	int err;
 
-	/* Use CiA recommended sample points */
-	if (bt->sample_point) {
+	if (bt->sample_point)
 		sample_point = bt->sample_point;
-	} else {
-		if (bt->bitrate > 800 * KILO /* BPS */)
-			sample_point = 750;
-		else if (bt->bitrate > 500 * KILO /* BPS */)
-			sample_point = 800;
-		else
-			sample_point = 875;
-	}
+	else
+		sample_point = can_calc_sample_point_nrz(bt);
 
 	/* tseg even = round down, odd = round up */
 	for (tseg = (btc->tseg1_max + btc->tseg2_max) * 2 + 1;
 	     tseg >= (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {
 		tsegall = CAN_SYNC_SEG + tseg / 2;
-- 
2.47.3


