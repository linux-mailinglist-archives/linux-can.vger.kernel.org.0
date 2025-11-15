Return-Path: <linux-can+bounces-5439-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A17C608AD
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 17:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 92B6724249
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 16:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B66423BF8F;
	Sat, 15 Nov 2025 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="I/D67xrz";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="cVGFXDtn"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65002FFDCF
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224695; cv=pass; b=X4n5W1Tt3QKtkiFQopZEur4cL177VjHTe66ogDEl4vBSFZay0YujQAqUDDqoFQ+mPzA9GpYRmUpLXcu38+8QXZMVFxMPzybVvKGMkwurBAbB0htoziqEKlILZHaiXA0sdNyshCcHyfz2+gjXfYqRVy+tZ7PQK1vmiM/UMuzQsNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224695; c=relaxed/simple;
	bh=wAr+fLSDcO2QflqqvQMNueEhZKhzeKGW0heCn9OLDN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2Y+mFySyZanAl+u7vZ6bvASXwPAy0sl3d0IvcudRTdRxqY2DzVLDu9Yu96wWFDdLkb00VAmRCmeQ+KFKwYhjrQYvIuKT3Z6oX4m25vZN/e3b0g8Xi1rsysn3Vxg9KKh7Jq+TeOzRszuAkaK6wYhhSnKE8Lcd9cTBUJmtZAgaDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=I/D67xrz; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=cVGFXDtn; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763224676; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JXwyDzRGNgPTaTQhP1LteOZUcSc2pxaJa6x1NLN+vhHnLuLzVi0PD8Tpwj83BmbiB+
    UkqnYHp7PmrxHKO2lOgFsT8xPzu4IpKiqvjUs991qtRJgKqqREGua4XiUpTjbnmBGk5Q
    knBGubxyOHweXDvKliQbTc5KvQPdVNWnI+pj7pkzmvHW9Qy4O1cYzYSB6HGje1urFeVg
    oCMNLowagHTdin6dpJ+y/2Hvp8NPs00jtFO11wSxI7vjUj0Vam0roqKPc6gN29Ghr+B0
    ZFWHc3EdVw7ExNvtEychkwGyWOq5jQokpYYXgNJUZeHwG+CYpTxIkRXDDXdBFp3c0jmi
    GGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224676;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=I2PH8IiCxVzRuXTCwWnBsKIgtmaw64qhWwWYJhgKlJ8=;
    b=CbwpLc31EGidUn8qCi8YVnV8uhtTgVYXrfEJ8QRHEZuFYmG96I6d+XaL8ZPhD2bnKH
    nBnhomjhVFX9yHcTEXjX0xYFGIi1YpynUr/WWLm4cLSe0nrckXA/02yVmMsOlvpRoe7G
    izcloUkqG6kEXYY238oHbtI5735SOhM6wc2tsYB8h4Cik8KziVPGT0GARLL8Kmp2/9lG
    p1xmPVci/qd31h5VuCG5F+X2h7XbZq6i4ffiKPfWiFIEWGeUZR62yvEeQh/QoEdB+HJJ
    E29QhO5vFLbjfvguAz9iF9pMbtdeHdPp4YykTRLzKElmzMbm9DAOrxEkMkh6H2BNMjmr
    3wgw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224676;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=I2PH8IiCxVzRuXTCwWnBsKIgtmaw64qhWwWYJhgKlJ8=;
    b=I/D67xrz9T0pWxFL1nu/3mUnxH6vZkvJK40iSg92RDnjyI6KKRkwIBlPBlp2m+QUxe
    OrYc7AzDIjPTHEkJezKcUe/JwU56dZMrpFiCw7JWDaYi3Y7gGV7xrrafLfjh8xqeHrS+
    KTkXorScLiAlBPMdz8EnK1nK8mShmKwspNjWENs1sCJAuvfU6WhctuUmPx2Y8sdFuetH
    bR220Qrcj4l7h0yVlFwwWgYXs4RHFGkClt9xhmwoleVsAjU1TOHXNDCjJjRvJnPh9d8C
    fO59gu0lW6WlIBG1ZkMHtWKKOquOIXEqUjHB/0hOJhlP65pWH1M5zQRvtviAoObcwbv9
    aEUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763224676;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=I2PH8IiCxVzRuXTCwWnBsKIgtmaw64qhWwWYJhgKlJ8=;
    b=cVGFXDtnltYgeQUuziqhDGxescYR+d+jQGlWEaehqRy2+qxyU6xOwtr+XDKkPlTIaO
    sTGrXQtOArg9zhoS4ZCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFGbueQv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 17:37:56 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl v2 12/15] can: calc_bittiming: add can_calc_sample_point_nrz()
Date: Sat, 15 Nov 2025 17:37:37 +0100
Message-ID: <20251115163740.7875-13-socketcan@hartkopp.net>
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

CAN XL optimal sample point for PWM encoding (when TMS is on) differs
from the NRZ optimal one. There is thus a need to calculate a
different sample point depending whether TMS is on or off.

This is a preparation change: move the sample point calculation from
can_calc_bittiming() into the new can_calc_sample_point_nrz()
function.

In an upcoming change, a function will be added to calculate the
sample point for PWM encoding.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/calc_bittiming.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 222117596704..9b2d0e458518 100644
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


