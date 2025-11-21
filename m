Return-Path: <linux-can+bounces-5584-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC4CC7B8A4
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D4F3A4C61
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EC42FF15F;
	Fri, 21 Nov 2025 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="EHDGUCEk";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="9cKDJT3K"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0393016F0
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753749; cv=pass; b=V3SV4kn3dp4QmcIZzXcuIuH+s3o9Xq9ApZw4Epks1M3G6tfjLylq+DrZYGQl+2FjWm7/1XHcVmXi8zDEgnln2fo0ExV9veJGVB4hr+rJSpboW5cntfoIC97Jq+SqsmVD4n6FzpvK8xr9OCA2jHiLnElsdsuZhmsKhr7WXqO6M3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753749; c=relaxed/simple;
	bh=z3MkZh3km6VMazEQJ8VzJBSPTX2VBdzQd7l1oFUGp28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrWclWm+FqP1NDc1hmhtQiGw5aOsQe0DkHo8nczavHLUKD7dlc6wxydTxFrY48dwspUveR2S+kx5oAZ8nDfr6EHgUiuxvbgwCuEeCVEb5s4z9bMiXjLb5FUdI4CgrWY68y0lhAs3NZoGD9GsmFPOnWSsMHoIDEtSU0/DNM406Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=EHDGUCEk; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=9cKDJT3K; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763753729; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=puTr3dnf+cM2Rm3vQpJTHisnNNrWyNu6aK8oZQptsdYpgR/HWeqpuQjd4b4Vx+vCbw
    aEKFolNRrWKYf5NN8E8TbDNqekviQcuNsrg0OdVSbPXTZ49U8dm6L1+8kq7nNLQ1NFDH
    dTWXd1dLHcIsvHfHUW2HZJbieZvDkjHKq4irs3dNFiQB5i/3sHISQIhKwzjpOEY6o+MA
    mp1Vv91C5JR0cUV6vZrOZPh/dtXFSxjnfaHDDBwPN1OhRAnZZ4WcsY8P7vpCZCXPyRLU
    9UYWjgZlv+egKyunK+MrgRxPfaxROdGr9sDSEGmALKM5JjSyTPJNAXkcz8icnnCqvV1t
    GrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753729;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jXxnQnzbXPA8M93ON7S2p/N4wqNDKwb9J+HxSXciy3A=;
    b=m4402tXkxybHvp5RD2sd+8H4YMBESXbQqGpPwEh3D4yNviLd3UBah2zdChqc2BRvV6
    RSrY3nHYxUqXdOnZvaPIk3cN0xwrlD42jVoh/FcbkFzh34zXmcS/hTs4/ERg9Vw7x45H
    m24B2jV0TSScIQ75z1JRfctiTTV63zHLEF0dm8/vrHA7cVy6myD5FgBHmt3rPb0ahH4j
    r1aA+uGzfuZlsGDUx/VT5Iu4QJcpS5ekgjf6/VnlRELLRlTOU4bsSoM7DShObScYs/If
    K9JP6ITjC7AJ/zta5wyMqYgQUlm1c1Ut6CN9KBfjL9mc4gYWklLoryuGY6jsCYMruIef
    xd1g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753729;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jXxnQnzbXPA8M93ON7S2p/N4wqNDKwb9J+HxSXciy3A=;
    b=EHDGUCEk1Pn+Bu/Z036RYtVjOeRuxYp+zrRrg31t7TLjPWZ2DgoUXXCSzHuJ2E0XGo
    2kAzcUYdUQGs46i9FtALLxIuDGK2jGoeKfU/nXIE/difImkPynZccmaVGj3WJtf5wqqV
    0Png7MyQBvGQ6iLFJp8NDZiHdOaLkZ+WL87CfEFixDERqAT1zDFbacYulMjmJOqEf9mF
    gTNNLecUAT2qsua5TbEXo11X+gY1ZRtGMs/NjpsezpXS2L0pAbNgAyD0NYT0hx+aHNx1
    E033n7Xe47NgCpc65CAKScxQXmNuL0+wNVm0fYguzYQSnseC0ILXtHixOmU58WmtZ4lS
    pXmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763753729;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jXxnQnzbXPA8M93ON7S2p/N4wqNDKwb9J+HxSXciy3A=;
    b=9cKDJT3KUJH5V0hZVGe10wI5E3r0ALWdwh1IoOt0fMcZrPC0TPkCb+8lm3ywy9Ua3M
    7DMx0mpT+0PVzHsfe8Ag==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALJZTEnD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 20:35:29 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v5 12/17] can: calc_bittiming: get rid of the incorrect "nominal" word
Date: Fri, 21 Nov 2025 20:35:08 +0100
Message-ID: <20251121193513.2097-13-socketcan@hartkopp.net>
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


