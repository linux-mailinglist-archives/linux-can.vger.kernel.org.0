Return-Path: <linux-can+bounces-4721-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF7FB80401
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 16:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8181C01706
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 04:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F066A2877D8;
	Wed, 17 Sep 2025 04:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWCmQsFn"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83FB2853ED;
	Wed, 17 Sep 2025 04:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084538; cv=none; b=Hi6yV2Ef1xxBAnVQVzQc0Ny3Yg9UoJq0VV0c6S1ZFYzbfiVNyem8niJp4s6ZCjAIWyJ2bV6gHnUjyp17uYIkL+gbHnlh3RGk2oW+tGep6p7omt5953wk7XxWhZer+irE2apnEUNSUUFq5L3yF4NxuuT7NBp/+o8BaolqgEkvpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084538; c=relaxed/simple;
	bh=PqBU4lww/+186uiwZ0u17g3aZEZ98fu4Q3fznlo6ETw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uuHm5L/Eyq22ZSnkPh+Ge2DOPOwX1sQQvIId1+naj0/PhopSmZEOCbaSsyoKjIt3NcgQ3Rj7ht2olc7rmsPJ+aeY7hp40FMbNhbiycSKphiFRBPaYqPL7+jSZLwqf8NChFaeFgEwEXjUw43jrtO+PheWmuIebBf0sw5XmYXZVuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWCmQsFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91ECEC4CEF0;
	Wed, 17 Sep 2025 04:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758084538;
	bh=PqBU4lww/+186uiwZ0u17g3aZEZ98fu4Q3fznlo6ETw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AWCmQsFnk7zrtgRqzbuzPE4wBTI33NUziSghiv/um0+Qw6n2BhUQkxwuAOBAoTYoq
	 gABl7a3TSSyVcPnDpMeHcdRUnMoP+Sgro8Xo0aVj9Udvi3J1wmdxZZW3LJeCvlZKbe
	 /uKGlfNH/w+qJQ5violzgo6MknrnlkW+EdRA67a2hEDCAJTxQZn0nxG+BRLH1ta/7u
	 JvcvXbwrb70kcBOy3rGBMqL098eD4YKsPh0hvCNrCzZ8GN9g9iF56fwSfZIoOlrQrQ
	 RDYCjQK3DKLdnmFGSpe/eT0lacFdl5ruNqfQoY7I1TVtJsQpDSW8X0JBTCMKKb3c5q
	 2hBf+HIByXlNw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 17 Sep 2025 13:48:26 +0900
Subject: [PATCH v2 3/3] can: raw: reorder struct raw_sock's members to
 optimise packing
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-can-raw-repack-v2-3-395e8b3a4437@kernel.org>
References: <20250917-can-raw-repack-v2-0-395e8b3a4437@kernel.org>
In-Reply-To: <20250917-can-raw-repack-v2-0-395e8b3a4437@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5552; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=PqBU4lww/+186uiwZ0u17g3aZEZ98fu4Q3fznlo6ETw=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmnbDf7NBwOz9n869FB5jIpW2HlbU8PNQnfkdh8zbaqK
 1NqW+KUjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABM58ZaR4VGx5GsZE4ubXB7y
 e5U7mfaYXPYP0VN6sXP1zD2ddqFCGowMDQu+tV+v0r0WJMipqvX7P/ej7H2CPb+sqz04IxhZRJw
 YAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

struct raw_sock has several holes. Reorder the fields to save 8 bytes.

Statistics before:

  $ pahole --class_name=raw_sock net/can/raw.o
  struct raw_sock {
  	struct sock                sk __attribute__((__aligned__(8))); /*     0   776 */

  	/* XXX last struct has 1 bit hole */

  	/* --- cacheline 12 boundary (768 bytes) was 8 bytes ago --- */
  	int                        ifindex;              /*   776     4 */

  	/* XXX 4 bytes hole, try to pack */

  	struct net_device *        dev;                  /*   784     8 */
  	netdevice_tracker          dev_tracker;          /*   792     0 */
  	struct list_head           notifier;             /*   792    16 */
  	unsigned int               bound:1;              /*   808: 0  4 */
  	unsigned int               loopback:1;           /*   808: 1  4 */
  	unsigned int               recv_own_msgs:1;      /*   808: 2  4 */
  	unsigned int               fd_frames:1;          /*   808: 3  4 */
  	unsigned int               xl_frames:1;          /*   808: 4  4 */
  	unsigned int               join_filters:1;       /*   808: 5  4 */

  	/* XXX 2 bits hole, try to pack */
  	/* Bitfield combined with next fields */

  	struct can_raw_vcid_options raw_vcid_opts;       /*   809     4 */

  	/* XXX 3 bytes hole, try to pack */

  	canid_t                    tx_vcid_shifted;      /*   816     4 */
  	canid_t                    rx_vcid_shifted;      /*   820     4 */
  	canid_t                    rx_vcid_mask_shifted; /*   824     4 */
  	int                        count;                /*   828     4 */
  	/* --- cacheline 13 boundary (832 bytes) --- */
  	struct can_filter          dfilter;              /*   832     8 */
  	struct can_filter *        filter;               /*   840     8 */
  	can_err_mask_t             err_mask;             /*   848     4 */

  	/* XXX 4 bytes hole, try to pack */

  	struct uniqframe *         uniq;                 /*   856     8 */

  	/* size: 864, cachelines: 14, members: 20 */
  	/* sum members: 852, holes: 3, sum holes: 11 */
  	/* sum bitfield members: 6 bits, bit holes: 1, sum bit holes: 2 bits */
  	/* member types with bit holes: 1, total: 1 */
  	/* forced alignments: 1 */
  	/* last cacheline: 32 bytes */
  } __attribute__((__aligned__(8)));

...and after:

  $ pahole --class_name=raw_sock net/can/raw.o
  struct raw_sock {
  	struct sock                sk __attribute__((__aligned__(8))); /*     0   776 */

  	/* XXX last struct has 1 bit hole */

  	/* --- cacheline 12 boundary (768 bytes) was 8 bytes ago --- */
  	struct net_device *        dev;                  /*   776     8 */
  	netdevice_tracker          dev_tracker;          /*   784     0 */
  	struct list_head           notifier;             /*   784    16 */
  	int                        ifindex;              /*   800     4 */
  	unsigned int               bound:1;              /*   804: 0  4 */
  	unsigned int               loopback:1;           /*   804: 1  4 */
  	unsigned int               recv_own_msgs:1;      /*   804: 2  4 */
  	unsigned int               fd_frames:1;          /*   804: 3  4 */
  	unsigned int               xl_frames:1;          /*   804: 4  4 */
  	unsigned int               join_filters:1;       /*   804: 5  4 */

  	/* XXX 2 bits hole, try to pack */
  	/* Bitfield combined with next fields */

  	struct can_raw_vcid_options raw_vcid_opts;       /*   805     4 */

  	/* XXX 3 bytes hole, try to pack */

  	canid_t                    tx_vcid_shifted;      /*   812     4 */
  	canid_t                    rx_vcid_shifted;      /*   816     4 */
  	canid_t                    rx_vcid_mask_shifted; /*   820     4 */
  	can_err_mask_t             err_mask;             /*   824     4 */
  	int                        count;                /*   828     4 */
  	/* --- cacheline 13 boundary (832 bytes) --- */
  	struct can_filter          dfilter;              /*   832     8 */
  	struct can_filter *        filter;               /*   840     8 */
  	struct uniqframe *         uniq;                 /*   848     8 */

  	/* size: 856, cachelines: 14, members: 20 */
  	/* sum members: 852, holes: 1, sum holes: 3 */
  	/* sum bitfield members: 6 bits, bit holes: 1, sum bit holes: 2 bits */
  	/* member types with bit holes: 1, total: 1 */
  	/* forced alignments: 1 */
  	/* last cacheline: 24 bytes */
  } __attribute__((__aligned__(8)));

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 net/can/raw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 5a5ded519cd1768456c234c42dc4e865f7350dab..bf65d67b5df0135bf02d90c5e1070898a4f5592e 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -82,10 +82,10 @@ struct uniqframe {
 
 struct raw_sock {
 	struct sock sk;
-	int ifindex;
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
 	struct list_head notifier;
+	int ifindex;
 	unsigned int bound:1;
 	unsigned int loopback:1;
 	unsigned int recv_own_msgs:1;
@@ -96,10 +96,10 @@ struct raw_sock {
 	canid_t tx_vcid_shifted;
 	canid_t rx_vcid_shifted;
 	canid_t rx_vcid_mask_shifted;
+	can_err_mask_t err_mask;
 	int count;                 /* number of active filters */
 	struct can_filter dfilter; /* default/single filter */
 	struct can_filter *filter; /* pointer to filter(s) */
-	can_err_mask_t err_mask;
 	struct uniqframe __percpu *uniq;
 };
 

-- 
2.49.1


