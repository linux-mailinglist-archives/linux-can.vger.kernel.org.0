Return-Path: <linux-can+bounces-107-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A05826155
	for <lists+linux-can@lfdr.de>; Sat,  6 Jan 2024 20:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EAA2B2131D
	for <lists+linux-can@lfdr.de>; Sat,  6 Jan 2024 19:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11774E573;
	Sat,  6 Jan 2024 19:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="O1nTu274";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LGPYI4FT"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F58E575
	for <linux-can@vger.kernel.org>; Sat,  6 Jan 2024 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1704569335; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=n4JNhMIulIH1V6IFuIak70h9OUgBwZkWgSZNKaXMzimjdbNq++qeMGdgtXT/pMmfC4
    ZdF8fbQ/PYOcTNbQEQaqJaD/8k5bzIM0ulPdktuZV4mbSq6zFChkPfgbtcNKBx+IwdAi
    swno/a3QMxh+nh6j7iQUR6K+V3DMg4cJ+RgAD++TAHHbYGBMLhH5W+4o9DQb9G4PTG7G
    SBVly005lrK9YBkGvi8WjEuPwNdJ49ioAGBMxyFirLGWArQEYtSRUcghOsQmFshYT1to
    AfvJ0E3sTFiKdUrz0AN6665x6AtTYq5VPE4loWOyIFCqNWdmc8xYRKC+z1a3n8HBXOor
    Cn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1704569335;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=gilKgIU2DMSrVWPxsWAseg1siLLkgZ7ommM5NTcMH0s=;
    b=HN2X3iNccYl7waWs/CaTKGxdjCVFoRH6sxceoeKtuQBuj2BsRNZk1kLY0M1IMvTeK4
    U4twu9OdsnRFurv3GdivtYmErn6taLNZw9zzDwNcg8NkYAjrg8xCfCPXHgHm4lt1gxBn
    e/4hEIHl+0OXeoUAIbjAMUeBS7H5a1UHfTQ0rQ8zzwJHRa1xy82iLThKD2pteQpw+YtC
    qcw3RmRft0UpO/OOiTjjJy9Spn6KbRUy9vzkXOJ5Oo+05XMOApgIrOB8nsL2FfQEQFad
    4XxawbGzL9LV5IUt5k00CQFpPl9b41TGNG21YOh1QOOWjjHyw6CmOhuR86hvwrWlAW7+
    mhdQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1704569335;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=gilKgIU2DMSrVWPxsWAseg1siLLkgZ7ommM5NTcMH0s=;
    b=O1nTu274CuoIvg8uF+UUm94NWepVQcplrMsNLJfmBmhAXhfLg7X/wQerkf7UIKQ91m
    ZUrDCUe99j58LwnAQVxE3UHPINtIFr6ESqgS2v3jctUFOQzK+B0gsSuF6tdWxruYzXTO
    gJTYWmayl7B/rFJ9rEMKGd8BAIcxjsOs7XVg+62oAAnxxGX2HN+7xb6G92BKLxuYfCL2
    AKMD2kphXHmAJVYrESzIS6jDblveoDivfgoIJEeo1eguX3vcz0xn1OTvpXnSIShBV9Jn
    WJzSnH2Ub2dLuXLWcG82LEc99n3NLkVjcGrFWLvkJkrEk2QcubcayaW9VNWT83pxjrcj
    VZQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1704569335;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=gilKgIU2DMSrVWPxsWAseg1siLLkgZ7ommM5NTcMH0s=;
    b=LGPYI4FT8U0ystFBzRqEPoP1S22XtFgz8Je/pvmlNdGQOV92UlrZ6oZu9+14vcqV51
    0ThfAltpM/+TmqjBv3DQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qVzYmRlFqc7wvJJXEoyBUR8qVmzsldI+"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id Kf147a006JSt9RQ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 6 Jan 2024 20:28:55 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] canxl: add virtual CAN network identifier support
Date: Sat,  6 Jan 2024 20:28:36 +0100
Message-Id: <20240106192836.4716-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.34.1
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
values can be send, e.g. to replay full qualified CAN XL traffic.

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
 include/uapi/linux/can.h     | 14 +++++--
 include/uapi/linux/can/raw.h | 14 +++++++
 net/can/raw.c                | 79 ++++++++++++++++++++++++++++++++++--
 3 files changed, 100 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 939db2388208..30453905fbd2 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -180,34 +180,40 @@ struct canfd_frame {
 };
 
 /*
  * defined bits for canxl_frame.flags
  *
- * The canxl_frame.flags element contains two bits CANXL_XLF and CANXL_SEC
- * and shares the relative position of the struct can[fd]_frame.len element.
+ * The canxl_frame.flags element contains CAN XL frame specific bits and
+ * shares the relative position of the struct can[fd]_frame.len element.
  * The CANXL_XLF bit ALWAYS needs to be set to indicate a valid CAN XL frame.
  * As a side effect setting this bit intentionally breaks the length checks
  * for Classical CAN and CAN FD frames.
  *
  * Undefined bits in canxl_frame.flags are reserved and shall be set to zero.
  */
 #define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
 #define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
+#define CANXL_VCID 0x02 /* prio contains the virtual CAN network identifier */
+
+/* the 8-bit VCID is optionally placed in the canxl_frame.prio element */
+#define CANXL_VCID_OFFSET 16 /* bit offset of VCID in prio element */
+#define CANXL_VCID_VAL_MASK 0xFFUL /* VCID is an 8-bit value */
+#define CANXL_VCID_MASK (CANXL_VCID_VAL_MASK << CANXL_VCID_OFFSET)
 
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
index 31622c9b7988..8890b0d2fd48 100644
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
 
+struct can_raw_vcid_options {
+
+	__u8 flags;		/* flags for vcid (filter) behaviour */
+	__u8 tx_vcid;		/* VCID value set into canxl_frame.prio */
+	__u8 rx_vcid;		/* VCID value for VCID filter */
+	__u8 rx_vcid_mask;	/* VCID mask for VCID filter */
+
+};
+
+#define CAN_RAW_XL_VCID_TX_SET		0x01
+#define CAN_RAW_XL_VCID_TX_PASS		0x02
+#define CAN_RAW_XL_VCID_RX_FILTER	0x04
+
 #endif /* !_UAPI_CAN_RAW_H */
diff --git a/net/can/raw.c b/net/can/raw.c
index e6b822624ba2..a6f0b6a0a934 100644
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
@@ -814,12 +865,34 @@ static bool raw_bad_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
 	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
 		return false;
 
 	/* CAN XL -> needs to be enabled and a CAN XL device */
 	if (ro->xl_frames && can_is_canxl_skb(skb) &&
-	    can_is_canxl_dev_mtu(mtu))
+	    can_is_canxl_dev_mtu(mtu)) {
+		struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
+
+		/* sanitize non CAN XL bits */
+		cxl->prio &= (CANXL_PRIO_MASK | CANXL_VCID_MASK);
+
+		/* clear VCID in CAN XL frame if pass through is disabled */
+		if (!(ro->raw_vcid_opts.flags & CAN_RAW_XL_VCID_TX_PASS))
+			cxl->prio &= CANXL_PRIO_MASK;
+
+		/* set VCID in CAN XL frame if enabled */
+		if (ro->raw_vcid_opts.flags & CAN_RAW_XL_VCID_TX_SET) {
+			cxl->prio &= CANXL_PRIO_MASK;
+			cxl->prio |= ro->tx_vcid_shifted;
+		}
+
+		/* set flag only for 'tagged' VCID values */
+		if (cxl->prio & CANXL_VCID_MASK)
+			cxl->flags |= CANXL_VCID;
+		else
+			cxl->flags &= ~CANXL_VCID;
+
 		return false;
+	}
 
 	return true;
 }
 
 static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
-- 
2.34.1


