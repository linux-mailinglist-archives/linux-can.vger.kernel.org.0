Return-Path: <linux-can+bounces-4696-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E028B574CE
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 11:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69D7200952
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27A62F6560;
	Mon, 15 Sep 2025 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DR0xNUnd"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6642F6190;
	Mon, 15 Sep 2025 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928254; cv=none; b=WjAmDFXziCGPOBF5rq/Sqhk4lnZBzWg66CLk948Rjg3FgOUW1/c0C/mieUUmiqFmuc8y6T4MK76EEskQT/w6yWwBumlMFrkF6Vwm64/WyVNA4DB1Ajn2whEItcy1hU0EPiNZTA/LarOlfm48MQnMq4TcqRp2Zd51Tfb9g+lLuCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928254; c=relaxed/simple;
	bh=d81UDQ9il8FU6Db3aUD1lTdKP3KeBctQ1wDuh2q3G4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sCErzJjIYwMreosfcVs3L+9XZVSYslBM5FtxkZ25VMCVVhAoUX/B3aM5CIGTMn1DHc/26gKwc7K4kO5y3QQOuOd9QU8BsVkmUUzrJ/rn5Yhe1I4dOLgYcGVrKEHaoK+wML9XvHOjxSKjiPnnFZHtU9+DbvhL0yrdJQhuR0Bwih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DR0xNUnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B33C4CEF7;
	Mon, 15 Sep 2025 09:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757928254;
	bh=d81UDQ9il8FU6Db3aUD1lTdKP3KeBctQ1wDuh2q3G4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DR0xNUndO4On9b+mIxPwq44blrk8wxDCt+JuVvumBXHZ45aN4h+IqEU52J/Fa6W5m
	 edgI5+CyQ6j5kM/CuOOw0oNR4hepso42fid0vUq5BbIv7X2eAQKhDuy5H+gYxzMMxF
	 Ao+sQEWoJVaQGplxgzrLqekdZOjuphoum3NWZUqQaUwnkxH1mSCcUqrhyw/UtwPzgj
	 sgLNQChemhheasVdTi9sPOicel5sfPcIYTVz7JzNuU+3C8iiWjZtY724yLofQ93cux
	 RdNI30emY2qqmQMH0NxpQHIcRKt766BGxUVzdLYSj0Tv7rl6Oli29F1ixNBCF+dFya
	 Jr1liBXayjoZw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 15 Sep 2025 18:23:15 +0900
Subject: [PATCH 3/3] can: raw: reorder struct raw_sock's members to
 optimise packing
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-can-raw-repack-v1-3-5ea293bc6d33@kernel.org>
References: <20250915-can-raw-repack-v1-0-5ea293bc6d33@kernel.org>
In-Reply-To: <20250915-can-raw-repack-v1-0-5ea293bc6d33@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5421; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=d81UDQ9il8FU6Db3aUD1lTdKP3KeBctQ1wDuh2q3G4Q=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnHb5uxOV07lXF7atCD+vPhxse0o6/el91YqhNUvunLn
 9+be88zdpSyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZjInL8M/x3O3Vz8/1fbnYX5
 6vsnv7YuiN6yY5fBa/b2IinpHSdME8UZGb4H6D/63rwt2M77x6vZZSpLmNd/qUqYGv/kV1/cBeH
 +C4wA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

struct raw_sock has several holes. Reorder the fields to save 8 bytes.

Statistics before:

  $ pahole --class_name=raw_sock net/can/raw.o
  struct raw_sock {
  	struct sock                sk __attribute__((__aligned__(8))); /*     0   776 */

  	/* XXX last struct has 1 bit hole */

  	/* --- cacheline 12 boundary (768 bytes) was 8 bytes ago --- */
  	int                        bound;                /*   776     4 */
  	int                        ifindex;              /*   780     4 */
  	struct net_device *        dev;                  /*   784     8 */
  	netdevice_tracker          dev_tracker;          /*   792     0 */
  	struct list_head           notifier;             /*   792    16 */
  	unsigned int               loopback:1;           /*   808: 0  4 */
  	unsigned int               recv_own_msgs:1;      /*   808: 1  4 */
  	unsigned int               fd_frames:1;          /*   808: 2  4 */
  	unsigned int               xl_frames:1;          /*   808: 3  4 */

  	/* XXX 4 bits hole, try to pack */
  	/* Bitfield combined with next fields */

  	struct can_raw_vcid_options raw_vcid_opts;       /*   809     4 */

  	/* XXX 3 bytes hole, try to pack */

  	canid_t                    tx_vcid_shifted;      /*   816     4 */
  	canid_t                    rx_vcid_shifted;      /*   820     4 */
  	canid_t                    rx_vcid_mask_shifted; /*   824     4 */
  	int                        join_filters;         /*   828     4 */
  	/* --- cacheline 13 boundary (832 bytes) --- */
  	int                        count;                /*   832     4 */
  	struct can_filter          dfilter;              /*   836     8 */

  	/* XXX 4 bytes hole, try to pack */

  	struct can_filter *        filter;               /*   848     8 */
  	can_err_mask_t             err_mask;             /*   856     4 */

  	/* XXX 4 bytes hole, try to pack */

  	struct uniqframe *         uniq;                 /*   864     8 */

  	/* size: 872, cachelines: 14, members: 20 */
  	/* sum members: 860, holes: 3, sum holes: 11 */
  	/* sum bitfield members: 4 bits, bit holes: 1, sum bit holes: 4 bits */
  	/* member types with bit holes: 1, total: 1 */
  	/* forced alignments: 1 */
  	/* last cacheline: 40 bytes */
  } __attribute__((__aligned__(8)));

...and after:

  $ pahole --class_name=raw_sock net/can/raw.o
  struct raw_sock {
  	struct sock                sk __attribute__((__aligned__(8))); /*     0   776 */

  	/* XXX last struct has 1 bit hole */

  	/* --- cacheline 12 boundary (768 bytes) was 8 bytes ago --- */
  	int                        bound;                /*   776     4 */
  	int                        ifindex;              /*   780     4 */
  	struct net_device *        dev;                  /*   784     8 */
  	netdevice_tracker          dev_tracker;          /*   792     0 */
  	struct list_head           notifier;             /*   792    16 */
  	struct can_raw_vcid_options raw_vcid_opts;       /*   808     4 */
  	unsigned int               loopback:1;           /*   812: 0  4 */
  	unsigned int               recv_own_msgs:1;      /*   812: 1  4 */
  	unsigned int               fd_frames:1;          /*   812: 2  4 */
  	unsigned int               xl_frames:1;          /*   812: 3  4 */

  	/* XXX 28 bits hole, try to pack */

  	canid_t                    tx_vcid_shifted;      /*   816     4 */
  	canid_t                    rx_vcid_shifted;      /*   820     4 */
  	canid_t                    rx_vcid_mask_shifted; /*   824     4 */
  	can_err_mask_t             err_mask;             /*   828     4 */
  	/* --- cacheline 13 boundary (832 bytes) --- */
  	int                        join_filters;         /*   832     4 */
  	int                        count;                /*   836     4 */
  	struct can_filter          dfilter;              /*   840     8 */
  	struct can_filter *        filter;               /*   848     8 */
  	struct uniqframe *         uniq;                 /*   856     8 */

  	/* size: 864, cachelines: 14, members: 20 */
  	/* sum members: 860 */
  	/* sum bitfield members: 4 bits, bit holes: 1, sum bit holes: 28 bits */
  	/* member types with bit holes: 1, total: 1 */
  	/* forced alignments: 1 */
  	/* last cacheline: 32 bytes */
  } __attribute__((__aligned__(8)));

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 net/can/raw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index cec580ecd58e36931d1be05716e6beb9c93aa271..81f5de63bcfaacf3f51670159fb3d1d7d1fc6020 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -87,19 +87,19 @@ struct raw_sock {
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
 	struct list_head notifier;
+	struct can_raw_vcid_options raw_vcid_opts;
 	unsigned int loopback:1;
 	unsigned int recv_own_msgs:1;
 	unsigned int fd_frames:1;
 	unsigned int xl_frames:1;
-	struct can_raw_vcid_options raw_vcid_opts;
 	canid_t tx_vcid_shifted;
 	canid_t rx_vcid_shifted;
 	canid_t rx_vcid_mask_shifted;
+	can_err_mask_t err_mask;
 	int join_filters;
 	int count;                 /* number of active filters */
 	struct can_filter dfilter; /* default/single filter */
 	struct can_filter *filter; /* pointer to filter(s) */
-	can_err_mask_t err_mask;
 	struct uniqframe __percpu *uniq;
 };
 

-- 
2.49.1


