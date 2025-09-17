Return-Path: <linux-can+bounces-4720-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6608BB7F6A3
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 15:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF1D189EC06
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 04:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65B727E076;
	Wed, 17 Sep 2025 04:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cY2MPQ6Y"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF1E27A462;
	Wed, 17 Sep 2025 04:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084537; cv=none; b=IEDYmpgyRUcyKI+6JoJCTPIM9UhQLz9h5cg8Onx9oqH8UF/2+/irZt8DJSUQyuDnPkfQX1DVhxS4mye3Xqbuprll7T8iz0BYa4yWN89Q7WTRM5VCucoBOIipfrkIAfZ5EcMoakMwDxP4mDoUqrTw0AzVxphQpI9AB1ZzfKjYwkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084537; c=relaxed/simple;
	bh=9ZBz1hou7lESaLLepNjDGCXjO60B3Vu0/SzVAJ/MWZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=knz4eE4QdRdiAU+dCK9390QT/5SURb1iXTyz5PMB5Z/WZVn2n8+uIwHGRjmYqriYX6SbxTmAl/FQemvpcvmQnHsLBfoRulR57aVWYR/2CwtdMBbGFSf7J1sT79NSOcKh2/pj3j4NJvIj9VZ8RW8kltY4QPDQlzuGCOi5oStaT38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY2MPQ6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6939DC4CEF9;
	Wed, 17 Sep 2025 04:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758084537;
	bh=9ZBz1hou7lESaLLepNjDGCXjO60B3Vu0/SzVAJ/MWZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cY2MPQ6YTBV92fY3l5C5Vtuhn9uopfENvDbXfsgMaWCP/YcReOA+bp9y9wijhHafY
	 c1JwJ905J1Svx432pznw4PHg1ozOIDDVOE2NGYqb4NO8fEpnP3FacnQLs0bs4vIx5Z
	 an8qKbx9cogEhDDGB5HIiDbo/R52Kbk9jB0c7Phm78mNpMw9h7nBiTgiPSbkcYuFZF
	 k6pEI0Jx8P/CZru2OIQF94DQPBaMwvOr6Z7wWlsdqRMffjiOiyK+N3qYJuoDSU4LjR
	 iwJI0lJgsUMPgnTdJIN+6S4qhzD8ouyF+YwIFJcTBCH+22Ideekkn2cOr/9VzPf9sD
	 fQlQnhxD1FIgw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 17 Sep 2025 13:48:25 +0900
Subject: [PATCH v2 2/3] can: raw: use bitfields to store flags in struct
 raw_sock
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-can-raw-repack-v2-2-395e8b3a4437@kernel.org>
References: <20250917-can-raw-repack-v2-0-395e8b3a4437@kernel.org>
In-Reply-To: <20250917-can-raw-repack-v2-0-395e8b3a4437@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9578; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=9ZBz1hou7lESaLLepNjDGCXjO60B3Vu0/SzVAJ/MWZw=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmnbDd2hDeI9t81KDoQPTnaaonlzEjHzYnzdbZ+r/ut+
 79gJWdBRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgImIpzH8D2XJ3llXyPH07pJN
 xkUzlK7smFSgu+r3w71fpiStdjnoupzhf5mf9rSPd5dc2DyBc9Jvy5rcli6TH/+6I9cq/uOeXWA
 UxQ0A
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

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
---
Changelog:

v1 -> v2:

  - also add raw_sock->bound and raw_sock->join_filters to the
    bitfield
---
 net/can/raw.c | 59 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index db21d8a8c54d1b6a25a72c7a9d11d5c94f3187b5..5a5ded519cd1768456c234c42dc4e865f7350dab 100644
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
2.49.1


