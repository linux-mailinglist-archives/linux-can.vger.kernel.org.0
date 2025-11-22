Return-Path: <linux-can+bounces-5598-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 079CDC7CBD9
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 10:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36A13A8AAF
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D761E8826;
	Sat, 22 Nov 2025 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="PxeqhBPS";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="U6NQLnaT"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA0284663
	for <linux-can@vger.kernel.org>; Sat, 22 Nov 2025 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763804186; cv=pass; b=jpMcuvPC7cR4m7+uLJUJsNT/2zjCyPT4JSM6PDiiSqjKDO7e7P1fA2ZGo8ZIlR65VgwR5PSMRBdbDgwYCBBPwhIClTzAllFT1L6v7oouq4WiF9T23ctAikBEX73dELk06QF0tUypDHiUFGR9rmjZLAlJcBuNh/2m5iReRF00twU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763804186; c=relaxed/simple;
	bh=0AaIpZeLvXk4TmubDn+FdpydKuHP3+59DDLYTYxLW9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5D8+M0+3G+1tMXmc/3R5VWgQPO5+YaO8id4q1tLFVaQ3gB0105PCYbmxlXruquu5PnOnq7H+JeBOABjMiMtFF2RLErkdW4X54GdTwO7PX37IiG9lmWR5i0f6WGXyAokSv13wnmgATgtwe/r/IxoB/b8ndoMEaGarQigVcb8FNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=PxeqhBPS; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=U6NQLnaT; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763804172; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KxDAmywrlKjV9FX6bLzvXf8DE/FJpS6jZeATTW07PqZOEJauACt20cs3U//jQ22zjs
    qf/Uts/K8CYlxiS1zefjKAOyceYZTP5jLl46uIcIDn8Z28Q9KAvVprxYGIQj52Sd6Hh9
    rwpYnWvOSNnVM7WY+UFv8ef1LgQWm/4N5TEvaKPWvRI+30Xew/3Qf0WtbTNn32uLrXAq
    tu1PNBKJhpwa3dSBmHmJ9lO1ZK4IpbCoXgf3b6qnJvwGPD0+geHAMqzlyRX02NQ24tpG
    5EuAVvRxuZZEhLsxMAayYXMu0zyej1RE76PFnpuJ9KREi0xRA+pdM1zQC7+Pz1DPl5bV
    lK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804172;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kjd+hHKGoaYbEP0miptzBTsChrI/eNkwTx1XU2+Zcs0=;
    b=gZaL6c1/GqERuVKyQIeFI7ZYCYBGJroq7LasE4iaYJrqTZGR0X/ZDQ02SKrEqa2Gpf
    Mp0jlfJ42zeMTKUXazCvFrrRcNCLJa1sZLvYrl5wc1bVWX4jjxrorXEPWLcY+CktJFCU
    FKXXMFiGKMPuPs5keUNfgCT2QRUBRcDD/X9h55cV8+CaAmtOJQCZiHGBQsC7/ng/yrdJ
    gHyvnV/UYQDU8FOc+uIc1AvjfZFMxhrLANmrHd7C59tVbLQq/ot4emwayH56ovu4V5Tl
    6ZAg4gZf5N5da8iGDOqqL4bht7XaGxnlVEHQAu8FcjhOox8c1yenBhJxKTNouXRxdOty
    STdg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804172;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kjd+hHKGoaYbEP0miptzBTsChrI/eNkwTx1XU2+Zcs0=;
    b=PxeqhBPS/O9nLE48LZ/EF9D7OYmCwOi51hCxmYB0US2PDIpl1MSMCyPn1M05ESHw89
    wekoglqfxkYOEsgElUuig54620+UYquxTu43pmBCv4YhOBcox/UR5vgpXxLujJhk2ctW
    LPCo9rOgClnmyseAlLWpDdTWIBjvtuzX4BEQU2LipyxiEYKtLDCKJLMY4WazNBrwoFyL
    0KNuAHl942FA0XN7hyxMWzr+Wx5HoFVM7ipLf5VFq5lkUs9FEDBVQy2z6jY27OZkqtad
    KGLw/45gXKl8jGqTpTZB4BMxB4cHnbRhRuQmo0mPxdpVEOVNhWRjp9w9yoINBeF+3DZz
    fNoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763804172;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kjd+hHKGoaYbEP0miptzBTsChrI/eNkwTx1XU2+Zcs0=;
    b=U6NQLnaTPnJ0ncFl0IPTfztQh+cwLnNCbbyoszl/n4AXDDp17F+6BZFNq4+5XuuCXg
    EXaapIEcccWBKUY7mGCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AM9aCFdx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 22 Nov 2025 10:36:12 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v6 13/17] can: calc_bittiming: add can_calc_sample_point_nrz()
Date: Sat, 22 Nov 2025 10:35:57 +0100
Message-ID: <20251122093602.1660-14-socketcan@hartkopp.net>
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


