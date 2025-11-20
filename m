Return-Path: <linux-can+bounces-5523-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB35C75F75
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 19:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6196D35B899
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 18:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C44B229B38;
	Thu, 20 Nov 2025 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Wa5jzxs8";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LjAXyPl7"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557341EB5FD
	for <linux-can@vger.kernel.org>; Thu, 20 Nov 2025 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664343; cv=pass; b=t/twTSF/8VXbM4ZDKvGXNuWYXNpLF7h2Nr2ua4Qef7IrdcfS7HJbgiljeA1OOgo+IUg+ZwcCmBnj2kQTpmZRIl55+cp2MgDkLGcQLwqNuVfqBYX14snoFhXlv4sAmMTmenxgLy3p22Arq1nkeX9Vom8kCiKS7BMbq+I9KVHLbzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664343; c=relaxed/simple;
	bh=z3MkZh3km6VMazEQJ8VzJBSPTX2VBdzQd7l1oFUGp28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5w/jmHfpYFaLH6OcyjvQPlG76cCJ6R1RA6bv+TWqKzmINM03+U4gG0cZVf3uubpSB2OT+To9ruIkIHuU/fU/TJLlYGWim6CpC9LR3cTGnPy9hnh08z1alX74iVzqU87cYNfRlyXEjIcGgIAecEhaTlLyYOsCyz2hnYWsD7WN2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Wa5jzxs8; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LjAXyPl7; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763664323; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LJNyvippszhsIvYhGoFhEvWdUXIVru9wduDti6xntuMquN91NmuN5qQ6mcfA9gjWQd
    +doP/TPluLdYhI/fAKr1Vx0MSlG+HhvSxnlW7UtlOu1LjL8ykUbhw0jjmtQ0eJxjWhL8
    GZiNvO4M0rQz1eGYqpahnb484X3qccTki6ecZqlLd0OiBEQsbIXzvBxe4frTUA846VNJ
    lQGgtjFPx93I1wye20NqSdKBs3JnNaKLN7pYXhf8eXdeY5lcekg9lgszvIoDWC8muvKg
    gqHSab0kQX3HkVvGCmfOV9Ak2Suitwhkd+k/ErvriiMmOsdR5DIL10UXdxV//isZG9Rl
    3RlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664323;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jXxnQnzbXPA8M93ON7S2p/N4wqNDKwb9J+HxSXciy3A=;
    b=pV/sCkPUkCtk1NQ0NPUUuDS1QyOgCjgWyi6x3lqz1OQYAQ+AlPK6D1UoviKXJwdPqy
    HaCtsJWZ1/dW0/FW0R8TOBMAWNao++3vmNPqkWkDGfEII3I9Pfp4DLsnO8Os49lMGbzI
    fWH0dHZjJHAH0o+Xp3RbbEWYCw/OxfU+d9FfsJ2wc+f7n05eEU2J96bxvvDak2cZbfRw
    ZFoN69NKWPHyqP5U9kOowExOVE2HL8a4NxIoia188Jnejcn4oo5gft9lkhtzAq6tds53
    kJ6wDViJn27POkZkQCXaJ1vh570H9ts0RCIZWCu9RnJSBH/T+L6NFu5dn9q4tnPmggog
    hqkg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664323;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jXxnQnzbXPA8M93ON7S2p/N4wqNDKwb9J+HxSXciy3A=;
    b=Wa5jzxs8cApaRDUwWxibUlh/+8sVjAFM6sxuY292x7Pk3obV7KlUruRNewiYUAj+E3
    1W7NXO2pXAOXCwhR/izChjZUlneOtutTo4tfH6BAE7d+v7DSQEKKvfCU0YwNi2oiPrMe
    PHrabGWNSWB0plO4J8SO9VnP9th44r5SfgDiWTDlRpUm+E4zI7szRdlYQiFzW2dPbfug
    YNILW0Yi9aK0CJ4gV7TOrNr1RNNB8exHKP/WeRIV9EVFx8xLYJs9GOORrUvpCLZ42YY1
    NXjgUU8wfok9XJGq+LI0LbM8DkiJrkCk1324gifDDmWbhaamqOqiJqq3WIXXOer13qXL
    XGOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763664323;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jXxnQnzbXPA8M93ON7S2p/N4wqNDKwb9J+HxSXciy3A=;
    b=LjAXyPl7quh7dgKASxHYVPdR00NvSplx0ngTTeak8RQ6JEvNwB4lYEx2cw5wIOuUJ7
    g437ZwWcoEcuYZo9WNCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AKIjN9DV
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Nov 2025 19:45:23 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v3 11/17] can: calc_bittiming: get rid of the incorrect "nominal" word
Date: Thu, 20 Nov 2025 19:44:55 +0100
Message-ID: <20251120184501.27597-12-socketcan@hartkopp.net>
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


