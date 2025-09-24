Return-Path: <linux-can+bounces-4951-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEF2B98D4E
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3BA19C791A
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B29296BD4;
	Wed, 24 Sep 2025 08:21:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D1628935A
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702116; cv=none; b=P9J+GSZTk6chWcEVTDFFWb4ycSKTKIJ/S9pxoaoj+uegmu+WcYF+UHoBpsVehbHXCJew2SHKkHwvjQ7EL38iz2LlYFluzk94tNp1yMZXaqNn66SPUjWChTmnX91yDYINZhDpJaj930IVC5wxuFivUvK2AqlKz+JxF03RDxrlVpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702116; c=relaxed/simple;
	bh=Hlm6MvPcGaZGvcRNztXMXiuxZ89PCTOaxrP2DK5XKdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xass1ybzZTZEqDM0cOBdDTafixCwLOtdesIfDlRjmfmaShxBFQcaClme/r4mrM5WhdxOBDNL4O8lIAfiMhuzWZDJtiJEIeeg/tYS3U6baRiwFRDdXJWUp7dHEwTpjCUVt06wyMRzRMkIHo1+TTKpAwkfzdQXDbQK93AURVBi34g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-0001EV-S2; Wed, 24 Sep 2025 10:21:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkc-000Dvr-2e;
	Wed, 24 Sep 2025 10:21:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5953F478894;
	Wed, 24 Sep 2025 08:21:09 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 24/48] can: raw: reorder struct raw_sock's members to optimise packing
Date: Wed, 24 Sep 2025 10:06:41 +0200
Message-ID: <20250924082104.595459-25-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol@kernel.org>

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
Link: https://patch.msgid.link/20250917-can-raw-repack-v2-3-395e8b3a4437@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 5a5ded519cd1..bf65d67b5df0 100644
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
2.51.0


