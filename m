Return-Path: <linux-can+bounces-4957-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DC3B98D94
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 732CC7A7921
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F66F2D0C68;
	Wed, 24 Sep 2025 08:22:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0E296BB0
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702120; cv=none; b=EplvDYCuB7z1qKtbRUE7VSSlwQ1OOlZil/QYwd8hbm3rbkP3+5bP+uzPpI/2o7U0Mqtaoj1GBJFHlDVwH/WyqZmtEeTJesvjFuQYQnrluvpQaA0dNaiw6aOgQP12LAq7+QE5uhYeIsG7URnAWM5rwazk/7E+/CamrGmC7h+mT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702120; c=relaxed/simple;
	bh=iH5KzvOv7o3ZOYjLFyCMelOKmNSVOW+JV24gPzCeZ8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vE1KEU9mJcQkn143OFEIo15wvaUmCOtegMI3yl/i2FwgHN/sk1sCHBdQnAnmTXqZy0Pl9RBIXJg2diLZCXIIbbYUfwHTCJntgVJI8mi74XLOCPm47F1gaX/mGX14ngPZQHA027KvWfcVmDoixJaGVAHIQHx13PZaQBTBe1wS6Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-0001E5-8j; Wed, 24 Sep 2025 10:21:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkc-000DvT-1M;
	Wed, 24 Sep 2025 10:21:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2E56B478892;
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
Subject: [PATCH net-next 23/48] can: raw: use bitfields to store flags in struct raw_sock
Date: Wed, 24 Sep 2025 10:06:40 +0200
Message-ID: <20250924082104.595459-24-mkl@pengutronix.de>
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

The bound, loopback, recv_own_msgs, fd_frames, xl_frames and
join_filters fields of struct raw_sock just need to store one bit of
information.

Declare all those members as a bitfields of type unsigned int and
width one bit.

Add a temporary variable to raw_setsockopt() and raw_getsockopt() to
make the conversion between the stored bits and the socket interface.

This reduces the size of struct raw_sock by sixteen bytes.

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
  	int                        loopback;             /*   808     4 */
  	int                        recv_own_msgs;        /*   812     4 */
  	int                        fd_frames;            /*   816     4 */
  	int                        xl_frames;            /*   820     4 */
  	struct can_raw_vcid_options raw_vcid_opts;       /*   824     4 */
  	canid_t                    tx_vcid_shifted;      /*   828     4 */
  	/* --- cacheline 13 boundary (832 bytes) --- */
  	canid_t                    rx_vcid_shifted;      /*   832     4 */
  	canid_t                    rx_vcid_mask_shifted; /*   836     4 */
  	int                        join_filters;         /*   840     4 */
  	int                        count;                /*   844     4 */
  	struct can_filter          dfilter;              /*   848     8 */
  	struct can_filter *        filter;               /*   856     8 */
  	can_err_mask_t             err_mask;             /*   864     4 */

  	/* XXX 4 bytes hole, try to pack */

  	struct uniqframe *         uniq;                 /*   872     8 */

  	/* size: 880, cachelines: 14, members: 20 */
  	/* sum members: 876, holes: 1, sum holes: 4 */
  	/* member types with bit holes: 1, total: 1 */
  	/* forced alignments: 1 */
  	/* last cacheline: 48 bytes */
  } __attribute__((__aligned__(8)));

...and after:

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

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250917-can-raw-repack-v2-2-395e8b3a4437@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 59 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index db21d8a8c54d..5a5ded519cd1 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -82,20 +82,20 @@ struct uniqframe {
 
 struct raw_sock {
 	struct sock sk;
-	int bound;
 	int ifindex;
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
 	struct list_head notifier;
-	int loopback;
-	int recv_own_msgs;
-	int fd_frames;
-	int xl_frames;
+	unsigned int bound:1;
+	unsigned int loopback:1;
+	unsigned int recv_own_msgs:1;
+	unsigned int fd_frames:1;
+	unsigned int xl_frames:1;
+	unsigned int join_filters:1;
 	struct can_raw_vcid_options raw_vcid_opts;
 	canid_t tx_vcid_shifted;
 	canid_t rx_vcid_shifted;
 	canid_t rx_vcid_mask_shifted;
-	int join_filters;
 	int count;                 /* number of active filters */
 	struct can_filter dfilter; /* default/single filter */
 	struct can_filter *filter; /* pointer to filter(s) */
@@ -560,8 +560,8 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 	struct can_filter sfilter;         /* single filter */
 	struct net_device *dev = NULL;
 	can_err_mask_t err_mask = 0;
-	int fd_frames;
 	int count = 0;
+	int flag;
 	int err = 0;
 
 	if (level != SOL_CAN_RAW)
@@ -682,44 +682,48 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case CAN_RAW_LOOPBACK:
-		if (optlen != sizeof(ro->loopback))
+		if (optlen != sizeof(flag))
 			return -EINVAL;
 
-		if (copy_from_sockptr(&ro->loopback, optval, optlen))
+		if (copy_from_sockptr(&flag, optval, optlen))
 			return -EFAULT;
 
+		ro->loopback = !!flag;
 		break;
 
 	case CAN_RAW_RECV_OWN_MSGS:
-		if (optlen != sizeof(ro->recv_own_msgs))
+		if (optlen != sizeof(flag))
 			return -EINVAL;
 
-		if (copy_from_sockptr(&ro->recv_own_msgs, optval, optlen))
+		if (copy_from_sockptr(&flag, optval, optlen))
 			return -EFAULT;
 
+		ro->recv_own_msgs = !!flag;
 		break;
 
 	case CAN_RAW_FD_FRAMES:
-		if (optlen != sizeof(fd_frames))
+		if (optlen != sizeof(flag))
 			return -EINVAL;
 
-		if (copy_from_sockptr(&fd_frames, optval, optlen))
+		if (copy_from_sockptr(&flag, optval, optlen))
 			return -EFAULT;
 
 		/* Enabling CAN XL includes CAN FD */
-		if (ro->xl_frames && !fd_frames)
+		if (ro->xl_frames && !flag)
 			return -EINVAL;
 
-		ro->fd_frames = fd_frames;
+		ro->fd_frames = !!flag;
 		break;
 
 	case CAN_RAW_XL_FRAMES:
-		if (optlen != sizeof(ro->xl_frames))
+		if (optlen != sizeof(flag))
 			return -EINVAL;
 
-		if (copy_from_sockptr(&ro->xl_frames, optval, optlen))
+		if (copy_from_sockptr(&flag, optval, optlen))
 			return -EFAULT;
 
+		ro->xl_frames = !!flag;
+
 		/* Enabling CAN XL includes CAN FD */
 		if (ro->xl_frames)
 			ro->fd_frames = ro->xl_frames;
@@ -739,12 +743,13 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case CAN_RAW_JOIN_FILTERS:
-		if (optlen != sizeof(ro->join_filters))
+		if (optlen != sizeof(flag))
 			return -EINVAL;
 
-		if (copy_from_sockptr(&ro->join_filters, optval, optlen))
+		if (copy_from_sockptr(&flag, optval, optlen))
 			return -EFAULT;
 
+		ro->join_filters = !!flag;
 		break;
 
 	default:
@@ -758,6 +763,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
+	int flag;
 	int len;
 	void *val;
 
@@ -806,25 +812,29 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 	case CAN_RAW_LOOPBACK:
 		if (len > sizeof(int))
 			len = sizeof(int);
-		val = &ro->loopback;
+		flag = ro->loopback;
+		val = &flag;
 		break;
 
 	case CAN_RAW_RECV_OWN_MSGS:
 		if (len > sizeof(int))
 			len = sizeof(int);
-		val = &ro->recv_own_msgs;
+		flag = ro->recv_own_msgs;
+		val = &flag;
 		break;
 
 	case CAN_RAW_FD_FRAMES:
 		if (len > sizeof(int))
 			len = sizeof(int);
-		val = &ro->fd_frames;
+		flag = ro->fd_frames;
+		val = &flag;
 		break;
 
 	case CAN_RAW_XL_FRAMES:
 		if (len > sizeof(int))
 			len = sizeof(int);
-		val = &ro->xl_frames;
+		flag = ro->xl_frames;
+		val = &flag;
 		break;
 
 	case CAN_RAW_XL_VCID_OPTS: {
@@ -849,7 +859,8 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 	case CAN_RAW_JOIN_FILTERS:
 		if (len > sizeof(int))
 			len = sizeof(int);
-		val = &ro->join_filters;
+		flag = ro->join_filters;
+		val = &flag;
 		break;
 
 	default:
-- 
2.51.0


