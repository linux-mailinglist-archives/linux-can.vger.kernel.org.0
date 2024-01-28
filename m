Return-Path: <linux-can+bounces-166-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1617683F945
	for <lists+linux-can@lfdr.de>; Sun, 28 Jan 2024 20:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95C31C212F5
	for <lists+linux-can@lfdr.de>; Sun, 28 Jan 2024 19:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C95531A6B;
	Sun, 28 Jan 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="EhZKpK8f";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Vykpbxfx"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2012EB1D
	for <linux-can@vger.kernel.org>; Sun, 28 Jan 2024 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706468937; cv=pass; b=kWjQ0zXofwR2cKxEYhIyXEjEYwTA5FcD8a9D5syoqopUsvVPHEGk0KKv1vAs8E+VoqmOrhpgwSDF6eSN2RhwvI9VTm+LWM3QuU4gdwP+pArnyUFT/KE4Usbvj6x5P3T7c/L+8NZW5cIVuU88658LLlrtxnb095PYs+pkVq35naY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706468937; c=relaxed/simple;
	bh=vC1rVdSy9V1tO1xlFZu4rR7bnIKsMtlvlNtmkjxTjOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QUmOGyntYJ1UiGZ4MxD14BzPwDP7pgUPq5Z2cWjR9Gbo9YiijW3+FkxzEuDf+vKxqUeGcj5CPBzgNPPCKJzRx8rxawpP3+PsHTNcBJAeYF1GSLcgaRcfhLrEmnCC7sFS+tS1U0uz9EXew+9bCr1oneh2O5ldsiqkIJJ/GTDiMoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=EhZKpK8f; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Vykpbxfx; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1706467129; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UDQ7exgXbV8vum12DhEUEiLRLPgHupHNEye1QdsJ3azKZT0JlukZWX69tz4GBHoykg
    MC0bTsdHUl0r+G8ZcLfl/zfWmqqOAAaG1GuzdQdLVRe81mQKOOQd8BIm/X/vqEX1wYE9
    0blWfTA5Tfz+NvvZXq0MShTblxHx3ko568G4W5LExJX5yykPjB+uEdishaRr4rRrA7a8
    aRF8fWUZ/Fqv0yFpFWREfmxHx4NqeWRLFf2+cDSrF8R0rKDhbz3+0G8GQqBTsDCxQycm
    ZTzrG0ULgEqNTdu2A57DwUdrgjBxXpq3SbXSWzzBDfZZUv83VQwO16KdzWImU/GPJ6bc
    +WKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1706467129;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=iX0t1fIWDypP1XOGgOKdUU5aUsOKejKvQ2AwTFcYHUo=;
    b=hi4O733+GsYVKMOPjzyriE0UHCRiivywrZvdZDmbMhH9W/epnUNGF7oAqudDa2a23X
    iufCGorsWPEy7EURhTDfkT+0H6rUbCIFslJ4Dg2uomOPOIk+E/F5s6GS1HPULtpx/pXc
    uVSc2CCDyrNkvsiuNscjGU/2ohf2DI/Ip7KBoeqFtsVz27Ml0iknXj8frOhP4iPdt+36
    P0x8HkqYWy/0b0SQVDd6MXiEncXeUDdLQM8ZcXH9ulUMzEgm8/Wc7AilBEvjQ/pgGTO+
    wCZJxVTFxr3Gr7qDndsBJS0m0Onbr4wv1YDlYPUaTCIFf/l5a3lMJJrYrmdOEsBhgkev
    NrHg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1706467129;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=iX0t1fIWDypP1XOGgOKdUU5aUsOKejKvQ2AwTFcYHUo=;
    b=EhZKpK8fURo3KTGdkgPSO6NnaRDEqIPyr2CjCFiGXqLGiPAbVfQSjg1gEF4XIu/VSJ
    D1KNtPk03I3O8f0jUiyjyQ3Oo4R+16CTon/DqfvqFila91nfhMfIoqFuQKyG+Zq51Kym
    nL6pa2MATmmrE4R/ReqMQVdZQPdMmTaAopRkQbPchR8UerYJvNxwEoYTn4O/FMxzdDLA
    FaB+anXLLycQv7PZonOppDxX8Un1BtXnl+/qulJFTmHu4QnMCThACfQDwv/vMNYk/cFr
    aKa8ksIV4NK8rEVoOm66iUdDG5qrKxFQM8tbsDufHuQ0kqAV0ig7SL/KZVCAm18KYY5g
    wIZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1706467129;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=iX0t1fIWDypP1XOGgOKdUU5aUsOKejKvQ2AwTFcYHUo=;
    b=VykpbxfxIM/kHHEjTrUagjxiIcgrzyPEa8Rs2NtLGI7+xuidL6Wj1zJF88h8RGmFWY
    pGJp/Rqxq3MXjYOp4zDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfhbrd"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c00SIcnAVE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 28 Jan 2024 19:38:49 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v5] canxl: add virtual CAN network identifier support
Date: Sun, 28 Jan 2024 19:37:58 +0100
Message-Id: <20240128183758.68401-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

CAN XL data frames contain an 8-bit virtual CAN network identifier (VCID).
A VCID value of zero represents an 'untagged' CAN XL frame.

To receive and send these optional VCIDs via CAN_RAW sockets a new socket
option CAN_RAW_XL_VCID_OPTS is introduced to define/access VCID content:

- tx: set the outgoing VCID value by the kernel (one fixed 8-bit value)
- tx: pass through VCID values from the user space (e.g. for traffic replay)
- rx: apply VCID receive filter (value/mask) to be passed to the user space

With the 'tx pass through' option CAN_RAW_XL_VCID_TX_PASS all valid VCID
values can be sent, e.g. to replay full qualified CAN XL traffic.

The VCID value provided for the CAN_RAW_XL_VCID_TX_SET option will
override the VCID value in the struct canxl_frame.vcid element defined
for CAN_RAW_XL_VCID_TX_PASS when both flags are set.

With a rx_vcid_mask of zero all possible VCID values (0x00 - 0xFF) are
passed to the user space when the CAN_RAW_XL_VCID_RX_FILTER flag is set.
Without this flag only untagged CAN XL frames (VCID = 0x00) are delivered
to the user space (default).

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/uapi/linux/can.h     | 41 +++++++++++------
 include/uapi/linux/can/raw.h | 14 ++++++
 net/can/af_can.c             |  2 +
 net/can/raw.c                | 86 ++++++++++++++++++++++++++++++++----
 4 files changed, 121 insertions(+), 22 deletions(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 939db2388208..e55e98ab58dd 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -44,10 +44,11 @@
  */
 
 #ifndef _UAPI_CAN_H
 #define _UAPI_CAN_H
 
+#include <asm/byteorder.h>
 #include <linux/types.h>
 #include <linux/socket.h>
 #include <linux/stddef.h> /* for offsetof */
 
 /* controller area network (CAN) kernel definitions */
@@ -193,26 +194,38 @@ struct canfd_frame {
 #define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
 #define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
 
 /**
  * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame structure
- * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
- * @flags: additional flags for CAN XL
- * @sdt:   SDU (service data unit) type
- * @len:   frame payload length in byte (CANXL_MIN_DLEN .. CANXL_MAX_DLEN)
- * @af:    acceptance field
- * @data:  CAN XL frame payload (CANXL_MIN_DLEN .. CANXL_MAX_DLEN byte)
- *
- * @prio shares the same position as @can_id from struct can[fd]_frame.
+ * @prio:   11 bit arbitration priority (unused 5 bits must be set to zero)
+ *          Shares the lower 16 bits of @can_id from struct can[fd]_frame
+ * @vcid:   CAN XL virtual CAN network identifier
+ * @__res0: reserved / padding must be set to zero to maintain the CAN filter
+ *          functionality as it holds the @can_id flags CAN_xxx_FLAG
+ * @flags:  additional flags for CAN XL
+ * @sdt:    SDU (service data unit) type
+ * @len:    frame payload length in byte (CANXL_MIN_DLEN .. CANXL_MAX_DLEN)
+ * @af:     acceptance field
+ * @data:   CAN XL frame payload (CANXL_MIN_DLEN .. CANXL_MAX_DLEN byte)
  */
 struct canxl_frame {
-	canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
-	__u8    flags; /* additional flags for CAN XL */
-	__u8    sdt;   /* SDU (service data unit) type */
-	__u16   len;   /* frame payload length in byte */
-	__u32   af;    /* acceptance field */
-	__u8    data[CANXL_MAX_DLEN];
+#if defined(__LITTLE_ENDIAN)
+	__u16 prio;   /* 11 bit priority for arbitration */
+	__u8  vcid;   /* virtual CAN network identifier */
+	__u8  __res0; /* reserved / padding must be set to zero */
+#elif defined(__BIG_ENDIAN)
+	__u8  __res0; /* reserved / padding must be set to zero */
+	__u8  vcid;   /* virtual CAN network identifier */
+	__u16 prio;   /* 11 bit priority for arbitration */
+#else
+#error "Unknown endianness"
+#endif
+	__u8  flags;  /* additional flags for CAN XL */
+	__u8  sdt;    /* SDU (service data unit) type */
+	__u16 len;    /* frame payload length in byte */
+	__u32 af;     /* acceptance field */
+	__u8  data[CANXL_MAX_DLEN];
 };
 
 #define CAN_MTU		(sizeof(struct can_frame))
 #define CANFD_MTU	(sizeof(struct canfd_frame))
 #define CANXL_MTU	(sizeof(struct canxl_frame))
diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
index 31622c9b7988..88e4e8176b89 100644
--- a/include/uapi/linux/can/raw.h
+++ b/include/uapi/linux/can/raw.h
@@ -63,8 +63,22 @@ enum {
 	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
 	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
 	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
 	CAN_RAW_JOIN_FILTERS,	/* all filters must match to trigger */
 	CAN_RAW_XL_FRAMES,	/* allow CAN XL frames (default:off) */
+	CAN_RAW_XL_VCID_OPTS,	/* CAN XL VCID configuration options */
 };
 
+/* configuration for CAN XL virtual CAN identifier (VCID) handling */
+struct can_raw_vcid_options {
+	__u8 flags;		/* flags for vcid (filter) behaviour */
+	__u8 tx_vcid;		/* VCID value set into canxl_frame.vcid */
+	__u8 rx_vcid;		/* VCID value for VCID filter */
+	__u8 rx_vcid_mask;	/* VCID mask for VCID filter */
+};
+
+/* can_raw_vcid_options.flags for CAN XL virtual CAN identifier handling */
+#define CAN_RAW_XL_VCID_TX_SET		0x01
+#define CAN_RAW_XL_VCID_TX_PASS		0x02
+#define CAN_RAW_XL_VCID_RX_FILTER	0x04
+
 #endif /* !_UAPI_CAN_RAW_H */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 7343fd487dbe..707576eeeb58 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -863,10 +863,12 @@ static __init int can_init(void)
 	int err;
 
 	/* check for correct padding to be able to use the structs similarly */
 	BUILD_BUG_ON(offsetof(struct can_frame, len) !=
 		     offsetof(struct canfd_frame, len) ||
+		     offsetof(struct can_frame, len) !=
+		     offsetof(struct canxl_frame, flags) ||
 		     offsetof(struct can_frame, data) !=
 		     offsetof(struct canfd_frame, data));
 
 	pr_info("can: controller area network core\n");
 
diff --git a/net/can/raw.c b/net/can/raw.c
index e6b822624ba2..d379835d741d 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -89,10 +89,11 @@ struct raw_sock {
 	struct list_head notifier;
 	int loopback;
 	int recv_own_msgs;
 	int fd_frames;
 	int xl_frames;
+	struct can_raw_vcid_options raw_vcid_opts;
 	int join_filters;
 	int count;                 /* number of active filters */
 	struct can_filter dfilter; /* default/single filter */
 	struct can_filter *filter; /* pointer to filter(s) */
 	can_err_mask_t err_mask;
@@ -132,14 +133,34 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	/* check the received tx sock reference */
 	if (!ro->recv_own_msgs && oskb->sk == sk)
 		return;
 
 	/* make sure to not pass oversized frames to the socket */
-	if ((!ro->fd_frames && can_is_canfd_skb(oskb)) ||
-	    (!ro->xl_frames && can_is_canxl_skb(oskb)))
+	if (!ro->fd_frames && can_is_canfd_skb(oskb))
 		return;
 
+	if (can_is_canxl_skb(oskb)) {
+		struct canxl_frame *cxl = (struct canxl_frame *)oskb->data;
+		struct can_raw_vcid_options *ropts = &ro->raw_vcid_opts;
+
+		/* make sure to not pass oversized frames to the socket */
+		if (!ro->xl_frames)
+			return;
+
+		/* filter CAN XL VCID content */
+		if (ropts->flags & CAN_RAW_XL_VCID_RX_FILTER) {
+			/* apply VCID filter if user enabled the filter */
+			if ((cxl->vcid & ropts->rx_vcid_mask) !=
+			    (ropts->rx_vcid & ropts->rx_vcid_mask))
+				return;
+		} else {
+			/* no filter => do not forward VCID tagged frames */
+			if (cxl->vcid)
+				return;
+		}
+	}
+
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
 	    this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
 		if (!ro->join_filters)
 			return;
@@ -696,10 +717,19 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		/* Enabling CAN XL includes CAN FD */
 		if (ro->xl_frames)
 			ro->fd_frames = ro->xl_frames;
 		break;
 
+	case CAN_RAW_XL_VCID_OPTS:
+		if (optlen != sizeof(ro->raw_vcid_opts))
+			return -EINVAL;
+
+		if (copy_from_sockptr(&ro->raw_vcid_opts, optval, optlen))
+			return -EFAULT;
+
+		break;
+
 	case CAN_RAW_JOIN_FILTERS:
 		if (optlen != sizeof(ro->join_filters))
 			return -EINVAL;
 
 		if (copy_from_sockptr(&ro->join_filters, optval, optlen))
@@ -784,10 +814,25 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		if (len > sizeof(int))
 			len = sizeof(int);
 		val = &ro->xl_frames;
 		break;
 
+	case CAN_RAW_XL_VCID_OPTS:
+		/* user space buffer to small for VCID opts? */
+		if (len < sizeof(ro->raw_vcid_opts)) {
+			/* return -ERANGE and needed space in optlen */
+			err = -ERANGE;
+			if (put_user(sizeof(ro->raw_vcid_opts), optlen))
+				err = -EFAULT;
+		} else {
+			if (len > sizeof(ro->raw_vcid_opts))
+				len = sizeof(ro->raw_vcid_opts);
+			if (copy_to_user(optval, &ro->raw_vcid_opts, len))
+				err = -EFAULT;
+		}
+		break;
+
 	case CAN_RAW_JOIN_FILTERS:
 		if (len > sizeof(int))
 			len = sizeof(int);
 		val = &ro->join_filters;
 		break;
@@ -801,36 +846,54 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 	if (copy_to_user(optval, val, len))
 		return -EFAULT;
 	return 0;
 }
 
-static bool raw_bad_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
+static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
+{
+	struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
+	struct can_raw_vcid_options *ropts = &ro->raw_vcid_opts;
+
+	/* sanitize non CAN XL bits */
+	cxl->__res0 = 0;
+
+	/* clear VCID in CAN XL frame if pass through is disabled */
+	if (!(ropts->flags & CAN_RAW_XL_VCID_TX_PASS))
+		cxl->vcid = 0;
+
+	/* set VCID in CAN XL frame if enabled */
+	if (ropts->flags & CAN_RAW_XL_VCID_TX_SET)
+		cxl->vcid = ropts->tx_vcid;
+}
+
+static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
 {
 	/* Classical CAN -> no checks for flags and device capabilities */
 	if (can_is_can_skb(skb))
-		return false;
+		return CAN_MTU;
 
 	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
 	if (ro->fd_frames && can_is_canfd_skb(skb) &&
 	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
-		return false;
+		return CANFD_MTU;
 
 	/* CAN XL -> needs to be enabled and a CAN XL device */
 	if (ro->xl_frames && can_is_canxl_skb(skb) &&
 	    can_is_canxl_dev_mtu(mtu))
-		return false;
+		return CANXL_MTU;
 
-	return true;
+	return 0;
 }
 
 static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
 	struct sockcm_cookie sockc;
 	struct sk_buff *skb;
 	struct net_device *dev;
+	unsigned int txmtu;
 	int ifindex;
 	int err = -EINVAL;
 
 	/* check for valid CAN frame sizes */
 	if (size < CANXL_HDR_SIZE + CANXL_MIN_DLEN || size > CANXL_MTU)
@@ -867,13 +930,20 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)
 		goto free_skb;
 
 	err = -EINVAL;
-	if (raw_bad_txframe(ro, skb, dev->mtu))
+
+	/* check for valid CAN (CC/FD/XL) frame content */
+	txmtu = raw_check_txframe(ro, skb, dev->mtu);
+	if (!txmtu)
 		goto free_skb;
 
+	/* only CANXL: clear/forward/set VCID value */
+	if (txmtu == CANXL_MTU)
+		raw_put_canxl_vcid(ro, skb);
+
 	sockcm_init(&sockc, sk);
 	if (msg->msg_controllen) {
 		err = sock_cmsg_send(sk, msg, &sockc);
 		if (unlikely(err))
 			goto free_skb;
-- 
2.39.2


