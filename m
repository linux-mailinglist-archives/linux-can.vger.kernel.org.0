Return-Path: <linux-can+bounces-118-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD39D827609
	for <lists+linux-can@lfdr.de>; Mon,  8 Jan 2024 18:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9D0282B40
	for <lists+linux-can@lfdr.de>; Mon,  8 Jan 2024 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B2054657;
	Mon,  8 Jan 2024 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ba1AhBMW";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KaF25BFU"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC551C36
	for <linux-can@vger.kernel.org>; Mon,  8 Jan 2024 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1704733611; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HPL+ALGVkkSH4m54aIPQqqtUtFpj4KeUA56fCUUCYKaOMgLU3RmME9ofH9XZ0YwKIq
    1/+KVuLfG+N7q8arsNUnz3nefWsZRSryevzIhOPBoTk/SNe2HE1YHNSWPT3uPoQIQuly
    g1L4lbGEb6VmTUbxQDfRhgSNJY4xgl+/xVefmTpyIYJhI2N4wDYRdlwZRrClWMxFWIEH
    rK9nJ2z8DU1FRwkxZ3mUzjYk/EmemkwxwJCSU3aFubaW+xbO1jMJSnLTCsrrKlPZY9zm
    uUQjiygZ0O8OY30KurNdZXziK/tkeTrPQQ1k7KwCRDvHPlsOKzAKYD/XfykSNbzCZWrf
    3lNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1704733611;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=8uMV2yluqNGM0cpZ0972JaZZtFN9SpY28vxL9Vo+5sk=;
    b=cPrfGCUFMqtNsKLzeZgtgEpaRfSy7hx1WYIWa0cVZLqs4g5L+6HrhBoVoSj9RQVmPD
    ad7SVkHMu3+cfIgPvsdGJ3nh3xLs1NDrP5+3128+Q3r3LG2LxKZFm+UJH0WKs89DO746
    af9nIr69sVkmgV49BqF/rOw74sPu7CvQV0b1WcHZx3SpXKNQ2eCXuPDTXRlVaXuXCs2V
    D1u0jhH6zeJgf0AXWJ9ifrioOU0WSdn3Ok5sXXZzc++rlb7jqnb/YpmeAWjsveEFRren
    e3M+dsNoubUhHGCOY0fZALcqAT9anEGQ0X9xGsyBwx1h763JY/17V2ZaeXMFfqMkXsMR
    2//Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1704733611;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=8uMV2yluqNGM0cpZ0972JaZZtFN9SpY28vxL9Vo+5sk=;
    b=ba1AhBMWR8KxoyuQ19kq2xFpeGDZNceeEcX9AK1oooK1kZRzLjXkhKyAFXXZcxtsuQ
    hf1BMttHrZWu99IILY7zY8andA/yhaDkCrXfQHxNoAjXr0069exTBQkMuk2eTG8Urh2x
    pdximmetRm9TXYTT2+LeYOpqWXZhwTOZLmZGGv4J3XfSoRib8xhQ6giyioL8tzKs+dk3
    x1JE2C70bN3gBi0v+0ALIBGtezt0X4Mbp12a6wMp6x0nuwCAsw3+aDsJFbV9kVQCIxch
    mwxm7k0pTdfs359yv+sDO04neOqHYw73tmjDIGrtWjHVeFo4LRqXlMshT5h5NUw5O+Dz
    +M7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1704733611;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=8uMV2yluqNGM0cpZ0972JaZZtFN9SpY28vxL9Vo+5sk=;
    b=KaF25BFUzKhE2zCv9Tvci6OSDxBZoFWuFz1/+LV9CLezeWeBH4d6ZTgGVbrKksgNaN
    z5zRj2T1eBGCatzpDVCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qVzYmR5G/53w4pZWvV8Jr3oWCaPuHNhy"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.10.2 AUTH)
    with ESMTPSA id K7b2c2008H6p0IV
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 8 Jan 2024 18:06:51 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v4] canxl: add virtual CAN network identifier support
Date: Mon,  8 Jan 2024 18:06:44 +0100
Message-Id: <20240108170644.1887-1-socketcan@hartkopp.net>
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
values can be sent, e.g. to replay full qualified CAN XL traffic.

The VCID value provided for the CAN_RAW_XL_VCID_TX_SET option will
override the VCID value in the struct canxl_frame.vcid element defined
for CAN_RAW_XL_VCID_TX_PASS when both flags are set.

With a rx_vcid_mask of zero all possible VCID values (0x00 - 0xFF) are
passed to the user space when the CAN_RAW_XL_VCID_RX_FILTER flag is set.
Without this flag only untagged CAN XL frames (VCID = 0x00) are delivered
to the user space (default).

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can.h     | 41 ++++++++++++++--------
 include/uapi/linux/can/raw.h | 14 ++++++++
 net/can/af_can.c             |  2 ++
 net/can/raw.c                | 66 ++++++++++++++++++++++++++++++++++--
 4 files changed, 106 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 939db2388208..8dcd8a9b5676 100644
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
+ *          functionality as is holds the @can_id flags CAN_xxx_FLAG
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
index e6b822624ba2..3083df64723c 100644
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
@@ -814,12 +859,27 @@ static bool raw_bad_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
 	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
 		return false;
 
 	/* CAN XL -> needs to be enabled and a CAN XL device */
 	if (ro->xl_frames && can_is_canxl_skb(skb) &&
-	    can_is_canxl_dev_mtu(mtu))
+	    can_is_canxl_dev_mtu(mtu)) {
+		struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
+		struct can_raw_vcid_options *ropts = &ro->raw_vcid_opts;
+
+		/* sanitize non CAN XL bits */
+		cxl->__res0 = 0;
+
+		/* clear VCID in CAN XL frame if pass through is disabled */
+		if (!(ropts->flags & CAN_RAW_XL_VCID_TX_PASS))
+			cxl->vcid = 0;
+
+		/* set VCID in CAN XL frame if enabled */
+		if (ropts->flags & CAN_RAW_XL_VCID_TX_SET)
+			cxl->vcid = ropts->tx_vcid;
+
 		return false;
+	}
 
 	return true;
 }
 
 static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
-- 
2.39.2


