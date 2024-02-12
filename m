Return-Path: <linux-can+bounces-223-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71358517C5
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 16:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3879A1F22132
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F843C087;
	Mon, 12 Feb 2024 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Rngl2RQx";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="NF2wVs+H"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1D63BB34
	for <linux-can@vger.kernel.org>; Mon, 12 Feb 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751062; cv=pass; b=MZEPC6RZDEuGSvTSpQtKN/9qL4US305qRGVJFJ0tFSkAFB99Tyw8At6fzGgrVGZXaHCUovy4AIeTCuzmHqeF0NHqjrtl2QbLgv/Cd9tTVbDFMOl20Ft4yEkXmeGpf6zAe+VAXgr4kPXEuY8un0AaDJEby8Q1HOFmouRivEWVhVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751062; c=relaxed/simple;
	bh=pHb1RsqzsyTYsKEtlcszAf8n3pFNIqHSY052b1p/v1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FvdUqJbJ3G0hjGgjGAh59+AXnDNxzRXbSZhLfi7vd7NdYmHGzMANa0wG9ZHwGl3q29WYFFfaiSme70MyUjM3ZVxPCbret1rlWZhWvZfs2oYsOXU2Ir8wIzA16yHKLAAA8J8gEqlU91v3nwqxB/PV8qRIKuFnEVicJ8dZ5Qvi4nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Rngl2RQx; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=NF2wVs+H; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1707750868; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bxTXCEIWvueVwxLLgmO3bXMzlactn+V9xcD+9UTXtRYJeoORwjJs5iUR5ZBGbvWs+d
    TRtv1cWs8diIMZi8b6p3VSxqnSx0ShI8/wkPSp7onDsECbUJqFCnZot4OTIL9cK/IkR5
    Ei4s3X4FJbNY3YhBqGT1U0Lji3kOS//b4Q0cTYmiR7biPrDaMn+cdJjo7n4t/Jjcdpqb
    J0gN4i25AL7sp0eObl/qnvc6ANaTeYC8blbGzpM3DLgGhvNSupWhzQhDooyztaLrE+Hx
    hxiBB2H4ccyk2cZu7DF0CwmHaoJAu31kqZPAC1hhDNbEH65mxYuJ0HOq5bcZl7VC5eGX
    /juQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1707750868;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=148qzAgYSzJDnS5/ty5wqSzIi/Yj2VbpQR5aBRf7kHo=;
    b=PlPRogPKndgNh0x9aXzUr2gAit+NV+feDA9uIoLC0ORUfniZYdb/67p0NNuVDhBDmx
    ddPl15qBCIg0ShAzeI5tb1tzow0tCTS9HDJLodPFPMWXlw2xRwmFqlHzXVSk88isYO55
    SJEr0/Wyc6GP0x75dJTp614ObvGvihUssKJqcZyY/KSeSWUNhF46zrobhPaQcyRyWSb7
    AjA8eFRoDDHiF0KnaxJ2K0DYQWA5klTXZ5zemU94sfYCavgnui1BXIvgNcUKyB2PdGBb
    Ui3IKTB2s7+nLefSowh3E/LkvdJalYwIKQvi4XSOXzdW2+yRVO90du2m+YPl8uvTzPtd
    qUVw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1707750868;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=148qzAgYSzJDnS5/ty5wqSzIi/Yj2VbpQR5aBRf7kHo=;
    b=Rngl2RQxq80KGtnQyHUhZ1Uefk2hbdWM+8be/xJxQgPQ79JJJ7veEMZUiPrAos4waG
    nDigE4MvvW46WceIWv5ppE90FNDGWXE36IILDe8bKlqR60bUS8mH2GtBGVdgSTdDj7E9
    7rbIoTvFRMFAqsXC7lO8d748LRrb3crzolMS4s1aAhI5CWUoC33ig+EI9t6ba16XTVrs
    DI17j7ozfcxGOr7X4Gd72lfNTrwp+NYv+vNlcuPuIhFMP/Pci71oUqbY0U17Kq8XUCiA
    onysx1X8f1tVCxWG7+vpVfnr1YTk9dxSn8HNVLEd5vInb5+8L9X3xnujDAa46lGvDZs+
    mHVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1707750868;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=148qzAgYSzJDnS5/ty5wqSzIi/Yj2VbpQR5aBRf7kHo=;
    b=NF2wVs+Hy9u2jCqzNbU+th7XtGvzd0h1dHvlbpbn5HkjKjn3kvfrtfcybIgeeLX3FA
    /khHnGNE/IlHCs6BvABw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qVzYmRVK/ciX"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01CFESpcH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Feb 2024 16:14:28 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Guy Harris <gharris@sonic.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <vincent.mailhol@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH rework v1] canxl: add virtual CAN network identifier support
Date: Mon, 12 Feb 2024 16:14:04 +0100
Message-Id: <20240212151404.60828-1-socketcan@hartkopp.net>
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
override the VCID value in the struct canxl_frame.prio defined for
CAN_RAW_XL_VCID_TX_PASS when both flags are set.

With a rx_vcid_mask of zero all possible VCID values (0x00 - 0xFF) are passed
to the user space when the CAN_RAW_XL_VCID_RX_FILTER flag is set. Without this
flag only untagged CAN XL frames (VCID = 0x00, CANXL_VCID flag unset) are
delivered to the user space.

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
2.39.2


