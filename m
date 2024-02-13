Return-Path: <linux-can+bounces-262-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D84B852F94
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 12:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B501F22247
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 11:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0125101E;
	Tue, 13 Feb 2024 11:34:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED433374C5
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824094; cv=none; b=jKEs3aMQ/bTGfeXGaAWUfV6MeupGPZS2Mn7P5EpkUvRHknG/TF3do9uU+bNS6HY2qqVV7Q8SBRjBd/0wT86A9xnL3Ne/pyZU7C2Ffjy5G+XFUuy5AY88Dtc74s18PSdTDuUx0+pXRmflMjzu5047T7rd5+F6SKzwyxWSs7Fxtl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824094; c=relaxed/simple;
	bh=686ltypCOPbQfZLBsCp/ZzmUhCEmnzV0BMLeX5UdT0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5NY/Mp6G53RPWeoxTzoYZ611Gm6PvPI5Pfmgs8v7HP1vDX3Ya1D5kLvf9IIYjntYy7/fYwiJ7FRkbIx5EMhxgyLTVCdGoDYfCCA/i6wkqiygtbzMTW6KTZG3iF28GAIbDbwQiyjTRq3cnrcdHRmkfcAAHy+FGyGcrMn/QksTPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3p-0001Dl-9z
	for linux-can@vger.kernel.org; Tue, 13 Feb 2024 12:34:49 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3m-000TZ7-6p
	for linux-can@vger.kernel.org; Tue, 13 Feb 2024 12:34:46 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D927E28D6F1
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 11:34:45 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id DB51C28D682;
	Tue, 13 Feb 2024 11:34:41 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4df71cae;
	Tue, 13 Feb 2024 11:34:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 22/23] can: canxl: add virtual CAN network identifier support
Date: Tue, 13 Feb 2024 12:25:25 +0100
Message-ID: <20240213113437.1884372-23-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213113437.1884372-1-mkl@pengutronix.de>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

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
Link: https://lore.kernel.org/all/20240212213550.18516-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
@@ -193,9 +193,14 @@ struct canfd_frame {
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
@@ -205,7 +210,7 @@ struct canfd_frame {
  * @prio shares the same position as @can_id from struct can[fd]_frame.
  */
 struct canxl_frame {
-	canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
+	canid_t prio;  /* 11 bit priority for arbitration / 8 bit VCID */
 	__u8    flags; /* additional flags for CAN XL */
 	__u8    sdt;   /* SDU (service data unit) type */
 	__u16   len;   /* frame payload length in byte */
diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
index 31622c9b7988..e024d896e278 100644
--- a/include/uapi/linux/can/raw.h
+++ b/include/uapi/linux/can/raw.h
@@ -65,6 +65,22 @@ enum {
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
@@ -865,6 +865,8 @@ static __init int can_init(void)
 	/* check for correct padding to be able to use the structs similarly */
 	BUILD_BUG_ON(offsetof(struct can_frame, len) !=
 		     offsetof(struct canfd_frame, len) ||
+		     offsetof(struct can_frame, len) !=
+		     offsetof(struct canxl_frame, flags) ||
 		     offsetof(struct can_frame, data) !=
 		     offsetof(struct canfd_frame, data));
 
diff --git a/net/can/raw.c b/net/can/raw.c
index e6b822624ba2..cb8e6f788af8 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -91,6 +91,10 @@ struct raw_sock {
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
@@ -134,10 +138,29 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
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
@@ -698,6 +721,19 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
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
@@ -786,6 +822,21 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
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
@@ -803,23 +854,41 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
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
@@ -829,6 +898,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	struct sockcm_cookie sockc;
 	struct sk_buff *skb;
 	struct net_device *dev;
+	unsigned int txmtu;
 	int ifindex;
 	int err = -EINVAL;
 
@@ -869,9 +939,16 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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
-- 
2.43.0



