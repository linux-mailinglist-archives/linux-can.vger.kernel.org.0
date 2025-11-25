Return-Path: <linux-can+bounces-5652-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC078C8501D
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 13:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597103B21A3
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E371F31DDAB;
	Tue, 25 Nov 2025 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="oJsroyNQ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="M0KhG9st"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA72531DD8A
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074375; cv=pass; b=t8TaPulXEKp4ih2LX7m6PyZcBemAwWXUoc2qRnrDlNAALDt7YU+AWGFY8nRFtywkncfpJZBsfzBveOvqbDPw1/srp8ME0sQn6dYea2eQ8yNihy2xAu5nyZOa08PlD9Z7L8iIXqPz81UDGGmDHYTIPQmmNmKNLIHfFAHYmvb8ooY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074375; c=relaxed/simple;
	bh=z3MkZh3km6VMazEQJ8VzJBSPTX2VBdzQd7l1oFUGp28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBPMoYRg3RGAY0BaO8CBkldixGLrDHyhbgHsm1QLvzH3RZBrqIck0kOGeLBxvobmPUNG0dP3HiQ0MmkJDrgyYO4GxFqsXOO/hdChxm+dI6ZOzljAERW3oi4H/OICiBCh4saz8p41sru3Am9p62vlPsZ4lgeaOndkLMycloKCL28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=oJsroyNQ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=M0KhG9st; arc=pass smtp.client-ip=81.169.146.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764074356; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DxGQRKWFdi7TwrmE986kpxAkYxgepKyGoqN1uewF98dOwdVkFT/E/uJ+Onk1e7KOXj
    +sXS0QGGEylyI177NFui1FnATywq1YSVAEPqbnwAhvjPkDLu0WO0yY1TX6S7Utr+ZoXJ
    3mCCcvR0hHo4Sm+hCirrdAXgIAKot5/363LexAvRYTC3jrmYWoLRrIwoSHURtm3BfI0Q
    JtSsv7bxrml11tgyHV/oGAtxzTaP6yAOp36paisQKvBpAAxRBc6XA48AhbjXYMh1JbX5
    MMeH4mEus8TGZZ61SxUfM6bXRqly7nT6MTT2sDlAzMwM+buAH67azZnV9PboG92HEhpM
    5E7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074356;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jXxnQnzbXPA8M93ON7S2p/N4wqNDKwb9J+HxSXciy3A=;
    b=PGhLCRl4l5SUrsz5yGVdzIKa516ypcVbiRNFPa0hxfrQNYDzLhAlyTqrOd16Hjly7Z
    0lF/N9LBgFalDdkFMYhRjy2BklZdfKilTabSu8wen5qAvFgJ1nIAtp98PiGbIut8vrz+
    0EBHPXYVh69PruKRVs0FFNdklGfdGVj7RoNcLghHzRa+Q/zFN6cFCFfa1HabjPJ9DOPo
    Gs7+w0pThfee7PXk6FqMkaVeaMtnIv0Hq8LWgpR9psIaiTP+6peeECxYo4Jf0r0rfevi
    4+WKcJB5RQ6IL3SBEBg9iszaprieNt2SgYl7xSjMlIph2MQC28IOVc7xXcY2N9JV4vrA
    mWFg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074356;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jXxnQnzbXPA8M93ON7S2p/N4wqNDKwb9J+HxSXciy3A=;
    b=oJsroyNQjI98RmWeF2R5+asosy3wLDWY3o8BQPJlYZhcI5g25O09yB62Ox9g4G4Lfe
    YRID2+TiR1nU4s5asPcHPcdlTl2eBcZ7ZPyzdfehy/vocAU03Mt4E9D2pqE3+Wbwhv3C
    qP+KbcRrGxqMlBC264opK0yiuU8lprtErAs5iMeMQrq7kjIjRrahLqGLEtREeFNzAII3
    zJhN9TlcvBhIfsnI0Y8D/YWqpPO/6JtZHqM1EMyehAx8bwXZMBimDcGLR/pHqt2Zlse1
    taCTdi/OOSmFMFG+trR+BKE4AFGHxIQz5utd3z3xzf6SXxBrbpJmG5yVySf4sAZFfNiH
    BqRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764074356;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jXxnQnzbXPA8M93ON7S2p/N4wqNDKwb9J+HxSXciy3A=;
    b=M0KhG9stImVeBgL8BkLp8lXdxOyXcaMB3jj5YHSGLS7YnGVYAxinIT7aV7qe0ynsm7
    C2rQYQrfkO3uG5HDn4Dg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461APCdFT8W
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Nov 2025 13:39:15 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v7 12/17] can: calc_bittiming: get rid of the incorrect "nominal" word
Date: Tue, 25 Nov 2025 13:38:54 +0100
Message-ID: <20251125123859.3924-13-socketcan@hartkopp.net>
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


