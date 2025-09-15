Return-Path: <linux-can+bounces-4694-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4504AB574C9
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 11:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A990164C10
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 09:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEBB2F4A1F;
	Mon, 15 Sep 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i07hFFWS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AFE2F5319;
	Mon, 15 Sep 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928253; cv=none; b=e4b74LgVdkciPvm5PF4zzgyrequ+JxW1pPNdv9atXBR38vUT8XcvGZacur/R+lM6DmIjo5Jev8ap90vWGCCHHxrrTTC88+LsmKEcM0lxhbmmkOOqNnhRmBB+TBwYzMZ38QQQ+Dxj9ynmxhOn0rT1+bMYjXT5/9ct94s4AYeY1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928253; c=relaxed/simple;
	bh=kl5LGd3q/W2PEJa/Cy2qmQsaXVV1bS4pAPKflagEA5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NVPjLQSzHJjsGOW6dF2iXunEuS4hHjgN+0TThWYyrDiBH2kwIcUEGhAQbxEV6Z4wqXPgFrVZsZqrqBmlV/Q6vqlk+BiDJ3R3QKboqqYwUjtTYEDbBk3bDpwKhfI6zOomWnv3/WEOPPzL7BBrEfcX+1t4dfaCgVKZ1JET1SZ/rl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i07hFFWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B78AC4CEF9;
	Mon, 15 Sep 2025 09:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757928253;
	bh=kl5LGd3q/W2PEJa/Cy2qmQsaXVV1bS4pAPKflagEA5E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i07hFFWSSoRyrYucBkymcCI/4FF9Ne4X4c3DOpSsmOZDos5As6e+2px3SYSqT+MRK
	 6tlM4fHtBC1gSn0KA07nb0gIQrGHQUgMFv3n0fM3+CstX7UklhZn0EWmEu4Spn2Jg9
	 83LbwRBDYK8/SzG+uClPMblZhJ8kfYE+7IQAuP+l/zy0bJagNakOl9NMVPAN+x6G7c
	 WuotG3kGLJ5k8LUDtmZ99iDMJvL/FOBC6ekJB1ivNt1YZNGNQGHDCOhwnh8RgzDhBe
	 HDbrnmmQIr3MNV3mIavlehbmL4mqM23p9MIyqr6+0C62F7mOpY/be1WkrD38dtcDdT
	 RcCYMne3NNjgw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 15 Sep 2025 18:23:14 +0900
Subject: [PATCH 2/3] can: raw: use bitfields to store flags in struct
 raw_sock
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-can-raw-repack-v1-2-5ea293bc6d33@kernel.org>
References: <20250915-can-raw-repack-v1-0-5ea293bc6d33@kernel.org>
In-Reply-To: <20250915-can-raw-repack-v1-0-5ea293bc6d33@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8303; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=kl5LGd3q/W2PEJa/Cy2qmQsaXVV1bS4pAPKflagEA5E=;
 b=kA0DAAoW0WQ+QNd/fbMByyZiAGjH2zOgyQw38tHOi7BBt7QgqDFWEG25EJos2VwbFN/ry65TJ
 4h1BAAWCgAdFiEEpncJCyCIcUtWwv050WQ+QNd/fbMFAmjH2zMACgkQ0WQ+QNd/fbPIPgEAn2Gg
 1MptMvqXvKyPeT1mU5ikqq9AFXF3WBT87COCIXoBAO9SgTu4ypMWidU1lUslEvpfT53QjrNlgLM
 XDR6YjMkK
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The loopback, recv_own_msgs, fd_frames and xl_frames fields of struct
raw_sock just need to store one bit of information.

Declare all those members as a bitfields of type unsigned int and
width one bit.

Add a temporary variable to raw_setsockopt() and raw_getsockopt() to
make the conversion between the stored bits and the socket interface.

This reduces struct raw_sock by eight bytes.

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

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 net/can/raw.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index db21d8a8c54d1b6a25a72c7a9d11d5c94f3187b5..cec580ecd58e36931d1be05716e6beb9c93aa271 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -87,10 +87,10 @@ struct raw_sock {
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
 	struct list_head notifier;
-	int loopback;
-	int recv_own_msgs;
-	int fd_frames;
-	int xl_frames;
+	unsigned int loopback:1;
+	unsigned int recv_own_msgs:1;
+	unsigned int fd_frames:1;
+	unsigned int xl_frames:1;
 	struct can_raw_vcid_options raw_vcid_opts;
 	canid_t tx_vcid_shifted;
 	canid_t rx_vcid_shifted;
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
@@ -758,6 +762,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
+	int flag;
 	int len;
 	void *val;
 
@@ -806,25 +811,29 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
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

-- 
2.49.1


