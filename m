Return-Path: <linux-can+bounces-232-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2A8851FB9
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 22:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233DA1F230C1
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 21:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F824CB58;
	Mon, 12 Feb 2024 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YmUP3g5I";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="J3qbEwvN"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA8A481D7
	for <linux-can@vger.kernel.org>; Mon, 12 Feb 2024 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773781; cv=pass; b=bQWHSAawMrKL0d4NtEg6Vg5KQ8tmLk1GX1i5uSDWXSUecLijiUf8uaHHZifqqawaZFVyxuhOOlR3kcFRhTTOevhgfdis82W0ywNZ93bPGBG8QypXUQ2FktkpjAf8PJw2OLAY9aTaor5i0Ya1M8pd2e2AYIapY6GmMIbw8QwGirc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773781; c=relaxed/simple;
	bh=K4yIeULwe3lIc05+fnPiDgIeFKcniGbYXvlsbKAstto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UHV6it03LYMiwSN4Yr7kp5tUJXw9ED/adPxPVv55ZfZZiaYDO+X9OkV+aJqN6Xrx48BO0n7L+iwABxRLWjhJs+lw5x89Ryq5HiEcenZZW8YiWV49o2f9URd265jf/alF4CROdrK9kV/HRDedo+3xTCOqmViTMQZ1tQ90uad4UWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YmUP3g5I; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=J3qbEwvN; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1707773763; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cnNtUSRkKpphCCZNhQqB7SUANOL1L5bpxkk5PqRuCMoeTfdnR49KhKw1xN9ksKTbcD
    +yn1+Pj4CJhIO6iYnRNIsJb6yCfZDjaT8PIju0esUuUdZHTF97nFNCWLIxAeYYVnoFNx
    8MX6+TbDjECs/U0IQ5Xxz0vJm78tFPd/XUHXL838y9g+gOjswMjRg4F+SyUbFHhxjmM1
    KhbbrI2es2mop5vvtcTfF9xrwFFU/FNj8yjl/8QeWNY4k27RxOl40gEZhPrwvyhyQArh
    kngF4rmC6SsKJC34zIgiGVRbvoAGmRlIXE6SRKVPPCSwqqKtdwSn9Sb0qNfU0Qwpl/ar
    panw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1707773763;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=6sMOTs5xHfkasaUSZkl3buCbgD4j4gsQ0Cvm4qRhR1w=;
    b=dEMqo07Dolp4rmJ1PrzewFRwMaDJSZFgoeIB3Cj61gyHZhPxIwOKqktsyCCisvfEWg
    pqcIXaTfaYbaJzjT45QiggDDFnXA1Q/sLdaUjmEDS93R7l3PdDdkUHAn16O1ogTYk41R
    8UEgph46cDyLIiXokZZq/b5Q+oxHGPfitjWsOSqzxHM1ppUFeWpd5cwlLSFtt87QLiL9
    m0Lh0R16JPe9IAhH5tYbUNFZWhm92vhQgyA49ajK2vc5h6+geux0tizRiyTsXLVqzv5V
    CAQulJLiCh+NLu1Z8/Paog661RDAnBpjTzXwZdAvrVRcv5VCVc2TBoTztotGejvFu0h7
    Zr8A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1707773763;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=6sMOTs5xHfkasaUSZkl3buCbgD4j4gsQ0Cvm4qRhR1w=;
    b=YmUP3g5IC8Gbp3SQa2sz6vdXzMS8gdsh1UMPiyEkrUbLaEaRYK827fw4jrYqHCyUzk
    82U4l6G44JlvTqVeT51G64yrArWq+m1ADBcQiaaRZKhgyIsayd6Ja4+XkT+EqzeJBj6G
    fBhiRnyn5a2UGG5zjZa7TD6umMixOd5Q9urf02WtppUok0CKLTEBEU9OHLBNpxV8cjJE
    D2amyCDueXr5Y1ILu05hKScIWFCcRbiuvcREQEffY5gqRf05ydyC3Ix2CKJUlpnHJ8uT
    pPiE2hAaTfuuBrEluP8kSHUKqKsBQrXbt8/21x7ok34ly/5O6YHI+XxSuT3PUNxHhPHG
    LTgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1707773763;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=6sMOTs5xHfkasaUSZkl3buCbgD4j4gsQ0Cvm4qRhR1w=;
    b=J3qbEwvNyMxM8kvUkv77e9HHEEl934cAgZHzYIPHQC9koPGCwoYt6cC44IcRRK4OBp
    tGLLs5uCndIn+Omo4QAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qVzYmUxC+83w4ZYMgAZ6el5eyV+aLCcW"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01CLa2qBe
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Feb 2024 22:36:02 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Guy Harris <gharris@sonic.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <vincent.mailhol@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH rework v2] canxl: add virtual CAN network identifier support
Date: Mon, 12 Feb 2024 22:35:50 +0100
Message-ID: <20240212213550.18516-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.43.0
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
override the VCID value in the struct canxl_frame.prio defined for
CAN_RAW_XL_VCID_TX_PASS when both flags are set.

With a rx_vcid_mask of zero all possible VCID values (0x00 - 0xFF) are
passed to the user space when the CAN_RAW_XL_VCID_RX_FILTER flag is set.
Without this flag only untagged CAN XL frames (VCID = 0x00) are delivered
to the user space (default).

The 8-bit VCID is stored inside the CAN XL prio element (only in CAN XL
frames!) to not interfere with other CAN content or the CAN filters
provided by the CAN_RAW sockets and kernel infrastruture.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can.h     |  9 +++-
 include/uapi/linux/can/raw.h | 16 +++++++
 net/can/af_can.c             |  2 +
 net/can/raw.c                | 93 ++++++++++++++++++++++++++++++++----
 4 files changed, 110 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 939db2388208..e78cbd85ce7c 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -191,23 +191,28 @@ struct canfd_frame {
  * Undefined bits in canxl_frame.flags are reserved and shall be set to zero.
  */
 #define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
 #define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
 
+/* the 8-bit VCID is optionally placed in the canxl_frame.prio element */
+#define CANXL_VCID_OFFSET 16 /* bit offset of VCID in prio element */
+#define CANXL_VCID_VAL_MASK 0xFFUL /* VCID is an 8-bit value */
+#define CANXL_VCID_MASK (CANXL_VCID_VAL_MASK << CANXL_VCID_OFFSET)
+
 /**
  * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame structure
- * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
+ * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags / VCID
  * @flags: additional flags for CAN XL
  * @sdt:   SDU (service data unit) type
  * @len:   frame payload length in byte (CANXL_MIN_DLEN .. CANXL_MAX_DLEN)
  * @af:    acceptance field
  * @data:  CAN XL frame payload (CANXL_MIN_DLEN .. CANXL_MAX_DLEN byte)
  *
  * @prio shares the same position as @can_id from struct can[fd]_frame.
  */
 struct canxl_frame {
-	canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
+	canid_t prio;  /* 11 bit priority for arbitration / 8 bit VCID */
 	__u8    flags; /* additional flags for CAN XL */
 	__u8    sdt;   /* SDU (service data unit) type */
 	__u16   len;   /* frame payload length in byte */
 	__u32   af;    /* acceptance field */
 	__u8    data[CANXL_MAX_DLEN];
diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
index 31622c9b7988..e024d896e278 100644
--- a/include/uapi/linux/can/raw.h
+++ b/include/uapi/linux/can/raw.h
@@ -63,8 +63,24 @@ enum {
 	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
 	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
 	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
 	CAN_RAW_JOIN_FILTERS,	/* all filters must match to trigger */
 	CAN_RAW_XL_FRAMES,	/* allow CAN XL frames (default:off) */
+	CAN_RAW_XL_VCID_OPTS,	/* CAN XL VCID configuration options */
 };
 
+/* configuration for CAN XL virtual CAN identifier (VCID) handling */
+struct can_raw_vcid_options {
+
+	__u8 flags;		/* flags for vcid (filter) behaviour */
+	__u8 tx_vcid;		/* VCID value set into canxl_frame.prio */
+	__u8 rx_vcid;		/* VCID value for VCID filter */
+	__u8 rx_vcid_mask;	/* VCID mask for VCID filter */
+
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
index e6b822624ba2..cb8e6f788af8 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -89,10 +89,14 @@ struct raw_sock {
 	struct list_head notifier;
 	int loopback;
 	int recv_own_msgs;
 	int fd_frames;
 	int xl_frames;
+	struct can_raw_vcid_options raw_vcid_opts;
+	canid_t tx_vcid_shifted;
+	canid_t rx_vcid_shifted;
+	canid_t rx_vcid_mask_shifted;
 	int join_filters;
 	int count;                 /* number of active filters */
 	struct can_filter dfilter; /* default/single filter */
 	struct can_filter *filter; /* pointer to filter(s) */
 	can_err_mask_t err_mask;
@@ -132,14 +136,33 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
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
+
+		/* make sure to not pass oversized frames to the socket */
+		if (!ro->xl_frames)
+			return;
+
+		/* filter CAN XL VCID content */
+		if (ro->raw_vcid_opts.flags & CAN_RAW_XL_VCID_RX_FILTER) {
+			/* apply VCID filter if user enabled the filter */
+			if ((cxl->prio & ro->rx_vcid_mask_shifted) !=
+			    (ro->rx_vcid_shifted & ro->rx_vcid_mask_shifted))
+				return;
+		} else {
+			/* no filter => do not forward VCID tagged frames */
+			if (cxl->prio & CANXL_VCID_MASK)
+				return;
+		}
+	}
+
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
 	    this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
 		if (!ro->join_filters)
 			return;
@@ -696,10 +719,23 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
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
+		/* prepare 32 bit values for handling in hot path */
+		ro->tx_vcid_shifted = ro->raw_vcid_opts.tx_vcid << CANXL_VCID_OFFSET;
+		ro->rx_vcid_shifted = ro->raw_vcid_opts.rx_vcid << CANXL_VCID_OFFSET;
+		ro->rx_vcid_mask_shifted = ro->raw_vcid_opts.rx_vcid_mask << CANXL_VCID_OFFSET;
+		break;
+
 	case CAN_RAW_JOIN_FILTERS:
 		if (optlen != sizeof(ro->join_filters))
 			return -EINVAL;
 
 		if (copy_from_sockptr(&ro->join_filters, optval, optlen))
@@ -784,10 +820,25 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
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
@@ -801,36 +852,55 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 	if (copy_to_user(optval, val, len))
 		return -EFAULT;
 	return 0;
 }
 
-static bool raw_bad_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
+static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
+{
+	struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
+
+	/* sanitize non CAN XL bits */
+	cxl->prio &= (CANXL_PRIO_MASK | CANXL_VCID_MASK);
+
+	/* clear VCID in CAN XL frame if pass through is disabled */
+	if (!(ro->raw_vcid_opts.flags & CAN_RAW_XL_VCID_TX_PASS))
+		cxl->prio &= CANXL_PRIO_MASK;
+
+	/* set VCID in CAN XL frame if enabled */
+	if (ro->raw_vcid_opts.flags & CAN_RAW_XL_VCID_TX_SET) {
+		cxl->prio &= CANXL_PRIO_MASK;
+		cxl->prio |= ro->tx_vcid_shifted;
+	}
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
@@ -867,13 +937,20 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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
2.43.0


