Return-Path: <linux-can+bounces-5522-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C69C75F87
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 19:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4C14B2BD94
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 18:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD836D4E5;
	Thu, 20 Nov 2025 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="oB7wJedO";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="rAIs1oXX"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5478D1A0BF3
	for <linux-can@vger.kernel.org>; Thu, 20 Nov 2025 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664343; cv=pass; b=hy8srIdzR5UoPReWcqR4AzXqt9NhRDbb8ytOpO8utH/SUSwKRYHnyoNPdWgAGAKeJo8lPRgJ6Rbx2RQ6RyklbI6XXfWBDmrfQUisBAv2CBv11y9/AGgpCd636Jmm78Iyqcfo1QUDAf6LJhX1J/g9dZRPINAd7pVcc/OOJjzpc+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664343; c=relaxed/simple;
	bh=0AaIpZeLvXk4TmubDn+FdpydKuHP3+59DDLYTYxLW9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrOCuD2JoITZrmWs9VEdTAq5x+Ie8oVyR+8S/4jIeIWfaUgqM5eaWeE3WdngPXjFKn3vpHbOKIGCYBhPYV4IH0hhdbl0ngJ0Dh/ITwl2HoygvxB4DiukzXaejBEUgdOaiBQtvag74KFQCB951lR85vrmOk0EV+MkOuyMj5VVlJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=oB7wJedO; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=rAIs1oXX; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763664324; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=W8auCoGYZTTolcyUeFUn1oDeZgH662ptE6o4ShRGS0lZgiX+UrGM6yt1CQbrP3//Q7
    etxJS6GyA2r3scTJoEe4GmOJd1ub/Ge1FZIdCR4Wu5xFqw82VVqYVBwUPvFfSdiEzTvu
    bJPXqnh56Zb3P/lVGFU6AMbKwQzXFq8286n5qQfxYO3QoQ9l5BsiKkMZJqmu+KpybwIz
    2H7V5R6rI0qwS25u2ixdlmtwt9+dC6rOHR3jLx0byiBcujyM51OynHl43g8bz6M3OCSl
    OUqu8o7NM8K0w9Qk5/bNtBvalOJJlzzyXwcyw6ViYKNPmymuvIb0O9dsR0eF53WIpuaR
    W3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664324;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kjd+hHKGoaYbEP0miptzBTsChrI/eNkwTx1XU2+Zcs0=;
    b=jj8sfsf2E527C2nmD9MyJdSfGWBMNgdGaKU7sF054RldbUolp7Xi7k8dHZ9jMFuTHf
    lAuOy0Azm6/ZG9nObW++FIMhbUWYdHrIQwHo7voRgkxsBOp3SDaRGGcZvZ46zgLZmu5F
    vzkgz6GOX3QOzbudSBZ672xYNSNIaMRhynefKpwICm6zyAghLBUP9/AbsZS6Y9Q3EVOI
    yyzQU+h/gQCJJbAGjHHqSH8EiJ8k0rLO97L0MC1gO0QyMR7LxxzEsh1jEKQ3FGAYK6pT
    Wxhymdcb0GA35N25x4YMxjI6elo4B6Af+hXskEwPNIQouRzZPX87vGN86greDbVeHNCq
    2UnA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664324;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kjd+hHKGoaYbEP0miptzBTsChrI/eNkwTx1XU2+Zcs0=;
    b=oB7wJedOcYTIEcBvjeu9pEZfWVaTJs2ahYbLI8Pm893+5meoT3SRxT37lhaDDr1q1N
    YdaMlAv61JQds8xat/xe3Ugb9XNNhohBiqT0CFZTioMIWrp8yRlDR1BCsaEa5Xidc6du
    o27RjY/zW7fL7KqCLrAQRdMDOna7Vw9BgARlCcFCuZm1RQTwWtMKzCC2PR8E0BkI/nO8
    JXFgG6XMHWNhdol4OLJaUm2dDaav985F7sPwWYmhi+tnvdQ9YhW5brfDm2aPWNQkJMvk
    KJGBDTKAarNQ5Goit+bVX/24euqqDbfPa7TAHwUEtKUfhSX79Z0CAYb7dcFRZdRPnEMo
    U+eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763664324;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kjd+hHKGoaYbEP0miptzBTsChrI/eNkwTx1XU2+Zcs0=;
    b=rAIs1oXXTNMX7NpVNodrenxAL/cghajaXk+GKnCR6mzSVRhjsrvD1DsCuOC008XpOt
    mTF7yvZczboSrR4gamBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AKIjN9DW
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Nov 2025 19:45:23 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v3 12/17] can: calc_bittiming: add can_calc_sample_point_nrz()
Date: Thu, 20 Nov 2025 19:44:56 +0100
Message-ID: <20251120184501.27597-13-socketcan@hartkopp.net>
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


