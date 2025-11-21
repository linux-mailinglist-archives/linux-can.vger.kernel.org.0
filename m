Return-Path: <linux-can+bounces-5578-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15095C7B89B
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D613A4E85
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCA521578D;
	Fri, 21 Nov 2025 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="c8QKgs5z";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="wfmSlVlP"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B42848AA
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753745; cv=pass; b=dZODBFN3pWvQNh/OeRIVMgjzU3H9O1DOBGixijQ/tyaTjOv/V8vlxQkk523Qw7yk0jmp5fM3ruFp7jMP2tknEVFfxnB7s1JISzrQk5Q1qEdztbLINNrFkQMC4nDjjU2nR1ndToCypVkzd4MOD356aRj7wydRzyhgqPJXOr9r5m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753745; c=relaxed/simple;
	bh=0AaIpZeLvXk4TmubDn+FdpydKuHP3+59DDLYTYxLW9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uu8ZpDoNNND4pFG+d6I9hawqUHsenqzclWEUYgKP/f88vk449p7pbr3KI5vrcUg2Z5ZvFZ9C2AB8L+fOIRCSXUOZLrz6YrHeqhzBN4qOPda5JZ1lH577SmB6kxSQAggv0VLezq5mfjZpFkwKrnX6caG1sO60VDoSrDMTScMvwQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=c8QKgs5z; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=wfmSlVlP; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763753730; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=snbuJCxgtghCcdO6e6pGNaFJu+tUOrEkosBypGgYGtAHeWQb/8J2jjoQJxZJkzUwHq
    PwLSKNWjMzZ+Q1kYa2eRtOBY+15gjq1FC6iLHLiJub+7V1r8JRKy529uowPPcKtMChDA
    ODPeUEC8muqa7NH6vrmylEJ7KSSzn0EC+417L9pzIsLHCX71WH5cpJ0TOSXDZYX40Tiv
    Fy6yii3hjaEundhUUFwZrXFf1uZzsKsKXYrE2u5VH3bFbb6jewNlca+cQxkGxaC2mgdb
    EkuWk+dt6HLjq1zBQNo8pn62Hfo/Q/aHlIS/ovDn4yT/QUSRoHcF0Hxn4cvBqB/IhbtZ
    D2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753730;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kjd+hHKGoaYbEP0miptzBTsChrI/eNkwTx1XU2+Zcs0=;
    b=WsGP94JcJb6OsIUmg6WWIvqy7SJUnRvikvsS8vJjc+y4MDkFvXJwEj+UbHpQuTxoNr
    M+Ec7SdY1VbLVTn9Yklg4GNiYmrgBn9BOYG70soCuHlGzwfgbf2qXcLKNPnpcZ2rhzWb
    2hYKBXZG8phZWXgAiYg7Mbj/Z5KJ464GBTF6PlnYg5+zSOwO3isvRHEA9/48tdNdCpgX
    w4YOol4d4Kd+Xc6uPrvfpNr+fMkQyvC7rZ3Egesal2Ztulon6Jur62us/CapXwOqX+Hd
    VOOgPrOLqnDNf32mzZuMjdeeVSFkdTJs3y15XadSNtfkfl5Ob4Frh/8MQ0BQzNpUjbE0
    STyg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753730;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kjd+hHKGoaYbEP0miptzBTsChrI/eNkwTx1XU2+Zcs0=;
    b=c8QKgs5zpy4HE/wDh+V3Xx88Ijf4xYWYnUqcmEHfoTOgLqykrasL0whgGiYi9vqTpG
    tfIBzP1NJ6Xu0GiBAijYPWhygtwtw/QJLLiCKEzQv+lUGuP7WpZYzy5a0Ms31LqjLEu+
    WiFkESeEQgE1adt0cJR+f7TzWNT8M1VrCJv+7dYM1fGCnh8mxDH9GUq05286TtKkrZSA
    pwuDs3jHM88z0v4E1qVnNoGpysnuTgh9ySPHm3imSYHnfABix1erejxmCBjYRKu4BaQL
    2UgKOa1TXxLbfmFsDxIKZ73cvBQxhRTu10F5yy9R4YlRxs2HUeRsMq8MEsLUnpYkfmIm
    2L/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763753730;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kjd+hHKGoaYbEP0miptzBTsChrI/eNkwTx1XU2+Zcs0=;
    b=wfmSlVlP9m47eYHbkVEw9axLmYeAAAQB1Y4Ka62utjXhU5xl0apAyn2ZuRV4cdciU8
    VEgMeWdWyUtJqsR0UhDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALJZUEnE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 20:35:30 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v5 13/17] can: calc_bittiming: add can_calc_sample_point_nrz()
Date: Fri, 21 Nov 2025 20:35:09 +0100
Message-ID: <20251121193513.2097-14-socketcan@hartkopp.net>
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


