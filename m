Return-Path: <linux-can+bounces-5597-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D84E8C7CBD6
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 10:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBDF14E34EB
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 09:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0652BE7C0;
	Sat, 22 Nov 2025 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="j0XyoEwo";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YuCeKBIA"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E8F22A4CC
	for <linux-can@vger.kernel.org>; Sat, 22 Nov 2025 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763804185; cv=pass; b=VI/ZbEKmF2kgEOYafUcPpc/40opDJ1Y67gY/5Kk820pudbyHl+VY6zxnR0AJgOPg7u2BFDiDBEYqJPMfMxnsmwssr7DvdcJg7OdCwVazhQ4H1dhaWu4ldjcUgOD6Cg4+TvR/UmMo5Y5bJDJXJY5S7eMevmoMPJGPKmjkm3HKnp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763804185; c=relaxed/simple;
	bh=z3MkZh3km6VMazEQJ8VzJBSPTX2VBdzQd7l1oFUGp28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lN+8BdeMv6AzkUZaG+ewD7sBoa/7TDZIGQkEpF65Rbjw2uSkrtlvH4qgtEBcXgu/n/NTzKE+AGFUoIAXKBgsXcHAlf/aIMxBNr6DIk+VZ/xiMJe4hasVsv7WuwcDLv7fhI9bzlV7y7NaV6Cj5Sm1Ko4ygDMrN5W+XffshloImJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=j0XyoEwo; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YuCeKBIA; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763804172; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YcnytYXgN2ckRDVTNrZP9XqT+DxBVPj+G5AVQjqlJrHtVNen1BpwSwZZ3722917nkv
    puxFaX7cs7esd4Njj+iAualVqyw4jzOJvvVzGiufRHwpQeah0vVUkxmEIbSUPeGgDbTp
    7eZzYd84rnIp6RlTisY8uE0Jx7kemjvnWaVzssuWRJTmUKm2yAhlojvqNWfqKax2cidT
    sEk0n9tzcDHmIRMzfkN1GZiwfnlw9k+GohGk5AQHLoMGZONWRoV+OZEC9DdwbzzrMWX0
    wxmg9Wn3VDXolOoUKkKRAMduwLr7k6s/6/0TuMe37cSFfGsu/fz0tFw138WWaul7choi
    hZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804172;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jXxnQnzbXPA8M93ON7S2p/N4wqNDKwb9J+HxSXciy3A=;
    b=D3WS5XgeE/nidxX6zIDF4ZWRB1lkZMuzyxU2juNhE3nTuhLe9227bhsW183/FlM2M6
    +2H9EgqwJNrK4FOVkSOTLp3ZBglUAkjQTZA8LT2Uv+xZ65O7pA9bXz6uvkchxu3fup8O
    WfEm329JRg+KKOijsKrHv52gibY5q7oYGINi0LIWj5O7MhAkc3EKNemQtAlcL7ex51i+
    TpHTydmuk34BXRZw3aTUjYQGrGeU07a0p7XU6645i+XO+nSYVnVUTW+Ju6xBOI1Vkm+x
    Q11cVYAWB4SY8Mz0vjNmWqEi5DQvt578EXVFfcW53LvbyHb7h+mH9pyvQa8QAJfSSfPv
    wbeQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804172;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jXxnQnzbXPA8M93ON7S2p/N4wqNDKwb9J+HxSXciy3A=;
    b=j0XyoEwobxMtywfk7jlYDUN9rOS5wptwjVQt1ojzt/8zNDCf10TXDwG0GD80QuASXP
    thipBsa7d6kwhAMZh6j7A4dsyiOuoJPbgFMCU7ncpuiir8YLaPmbcHSWLiUYfQCa5HYN
    FHSw3VV9IKYGRm18lMTD5f1pNmBuiL1gLIUIURphmg4pb2Ivxsulu95S49Wr4kOh1Rcf
    znpBHxi5nrgjvfoT58jU3RSzv258seqHcXRPTp1aQUoDcH4L2v7YZGcshDESfMGSz6RS
    x1C+0GpKqnClKaCCEncM6R/1+Vk/Mh6WJpNJ0fNJspSTP3wGUyNPFKVWtpvq1W9mttUL
    PK+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763804172;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jXxnQnzbXPA8M93ON7S2p/N4wqNDKwb9J+HxSXciy3A=;
    b=YuCeKBIA0WG4eJfwVe9tbMC530B0uHGreUxL6pnkDr8/DgkLfjdVZKOdhKMPU9aGkO
    rZ9pq2N044s/i11eRPBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AM9aBFdw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 22 Nov 2025 10:36:11 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v6 12/17] can: calc_bittiming: get rid of the incorrect "nominal" word
Date: Sat, 22 Nov 2025 10:35:56 +0100
Message-ID: <20251122093602.1660-13-socketcan@hartkopp.net>
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

The functions can_update_sample_point() and can_calc_bittiming() are
generic and meant to be used for both the nominal and the data
bittiming calculation.

However, those functions use terminologies such as "bitrate nominal"
or "sample point nominal". This is a leftover from when only Classical
CAN was supported and now became incorrect.

Remove or replace any occurrences of the word "nominal" with something
more accurate.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/calc_bittiming.c | 30 +++++++++++++---------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 268ec6fa7c49..46f6f5942abb 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -22,35 +22,34 @@
  * registers of the CAN controller. You can find more information
  * in the header file linux/can/netlink.h.
  */
 static int
 can_update_sample_point(const struct can_bittiming_const *btc,
-			const unsigned int sample_point_nominal, const unsigned int tseg,
+			const unsigned int sp_origin, const unsigned int tseg,
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


