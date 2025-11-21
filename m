Return-Path: <linux-can+bounces-5538-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41955C77EE2
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id F0A1931E51
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 08:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639B92F6934;
	Fri, 21 Nov 2025 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="c7ZV9xlj";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="d1nfxAae"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F1B33B6E6
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714086; cv=pass; b=mSYw6s2I9Lk/We5ba0YkmrDDrM0k/pLtl6xczJrJBSoJ1dSrjMNpT02IAwGnkvvpC8VOX45relh/GwAp77wa1wvsM0BONWoh6MtGUPQGi2nv7mC+Z8Jlhbbz7D1lLMdzY4xS1mRiCbENgPp5HWb3x0wdtnTZ9hiVCbYeCy+C29s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714086; c=relaxed/simple;
	bh=0AaIpZeLvXk4TmubDn+FdpydKuHP3+59DDLYTYxLW9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qar51h8Rh3R//bdi/c5wiciPqDAADYLqVUTwYOG4ZP45gK2hRJUKGySaV/PIVHqCh9d99bW4s96xqi4bhAgjzB1PCTeFegTGWBkwe+8hvIpoJLD9n37j176hVDOl6CG2+m7jiXganX2c5ZGyIRcvX18BRJ8NH6IYkaE+TEeubP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=c7ZV9xlj; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=d1nfxAae; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763714071; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aBD+i1SBRXaSRR+l995WgGptPuTjty8uxG9u4+4AGIDjKALu42E6WDhxZM6LnRFYXs
    4ZXt7R8rjVQDTcq58QBkHjLw+EijyuL/sU46rDrVktdQhCeeNCYvqwljxKisopaYjTgu
    B024HEhweSAlIcesJITQ4JBIAgEN+SMjt3XvBqhx3S4Wq/Pc7NkpwfTWhlPO+iGb6wzM
    Xueb8X38M6V4/OTTVGFjPRna+8B0GSBRtU8tgHF87WyaBN6ilF7Z3sBMsL7c+cqG+MO5
    sjcdoE+u+g+JOqjBmZFmXkd9UGStpt3PAqIYiKRDWAodu6KUvtHtBTyyMp54O1Ms7PGC
    y7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714071;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kjd+hHKGoaYbEP0miptzBTsChrI/eNkwTx1XU2+Zcs0=;
    b=cTY6q74oPivffkYo6BHeVlVvFLFHNjRr7VGRt4QCregm81kejwF/kcUFoJJlFbxTqC
    AWLgfC9gQkhltuDPchcMWCybLKMb40X8EXqWPIS3kD4vk22de7UflZyfR39B4tMvIvCe
    ACmsYcHOXaY8QYX89N1B1QN9mMFdeMxOloCu72YUvAyn1bvqqExnwxuseN8d/+36SMh0
    CKIWKWJ6rQ1T9LiaBlFYB6ohsexSIOHwwdltrK+G3l/zXw1mU0+/Ahx7FF+5KI58Gt7M
    L7LnylX45NnlSR3fqBOM/5XAoSdgQuwsScBdBm1Yr8vtEnd//qzzjXIjWEVke6OGwfc5
    HD9A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714071;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kjd+hHKGoaYbEP0miptzBTsChrI/eNkwTx1XU2+Zcs0=;
    b=c7ZV9xljb3OzOhnw8/OVJtxIUkmndpZZfZm8DJqxf0HsIcOVXi34O2RTLqH2nnb4Ys
    l0NQ3ZyQDq8RHcokY6rstFJociIEvEQVXI6RSq2rS0bGuiGsn462GFiPl9UBzFAUKxnl
    jIRTKygE52VzvDZIRQqiewNkZKg1fvPoZ8JzxBavlBufROtwgWWdclbLsFOgaZFhUoGY
    G2w5NNa4RnEf24zbVAn5iSfsRvC+6f9qRpbykL3h90QnBcb71+A5T8OEE8qYH/JtNTJF
    RJY0XLl9PmipUY4cc57gmX2bCTTnJqOh2JLuIXyZkZPlB6OsgA2/gbRN2/tweV39jhRj
    Ky3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763714071;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kjd+hHKGoaYbEP0miptzBTsChrI/eNkwTx1XU2+Zcs0=;
    b=d1nfxAaew4DVSKYvCW3++lfdVoSxKDo5NZkncAeuT8ksrRSBGLzGYSUwo7OWwTElei
    gJyCeRAUqZ2fLpKBSvAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL8YUAg0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 09:34:30 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v4 12/17] can: calc_bittiming: add can_calc_sample_point_nrz()
Date: Fri, 21 Nov 2025 09:34:09 +0100
Message-ID: <20251121083414.3642-13-socketcan@hartkopp.net>
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


