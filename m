Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE87DB8FD
	for <lists+linux-can@lfdr.de>; Mon, 30 Oct 2023 12:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjJ3Lbe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 30 Oct 2023 07:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjJ3Lbe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 30 Oct 2023 07:31:34 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7BEA6
        for <linux-can@vger.kernel.org>; Mon, 30 Oct 2023 04:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698665462; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YdWdy1IJFIhtaQyPJobCBVIjBPKC0ruK9vqdNDF+VQ81YFIB+WAUBTq0CdSEXoeJf4
    vUdysy35k9vjuo/7KGzv/1A4EYO+DsYX17+0pzgCXB8aLUop4cVjl9VU1Qp4eD+c+C9O
    /0WipXo5FqjGZYEy2tO8Azv9FFu3KyX7XLtAasnSwsw8DoeGWuUrdxuwQjnFOUjn2dmZ
    9u2h9cNRz7j03hBfKjsPO1GiS7muMlQAzB86vEq3mbMCDt5m4eS+dxX+tDq+pPtKriMb
    MUWUOr5PzYtlLQJfAWYcxcCBf7/s2boPX1owvG1D+5Z5KIzcMqHHsESxWuRsCBYI+0W4
    /4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698665462;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aSrD28lmhj+RxARThzat964rxCSHCRAisNP1Dxcf7ZY=;
    b=Ci0ISk3JXEj8ye4m5bZKQBbXwn+tqth5lOX0vDUCt/iN4ZfcQOo9e75ilBY/6QkfSX
    7hkAZsRHBbXmgC1w0LPewzMb0zP87o0Kgi6LvJNtL1+u9XisuI/Y6KvVDcDCd59M7XUU
    vcR7WBzlcoZhasw1heCtMcYLyNjYIhzHdb73WGz3QLDcsR7Mlu5O8p9Q4WWjFuBcXrsU
    77ryU3QOZxjQoVMT+mNsWQX8ZNZytJHQRdEimVPK0IIXltgxB9Rg0FmWmKuNdtx4Z4zq
    taBH/sadGsZhij8ZnmteXsvYAU8a4PCapy9Zr1D0rmfJGUrfBMzBPHDv0/jpOXjAaObn
    XZvQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698665462;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aSrD28lmhj+RxARThzat964rxCSHCRAisNP1Dxcf7ZY=;
    b=cDIQmC85i2/SFvdzxrV1RtNXXDA/Ehm07tmhlCqVDF1TJCWkYWiubZ2DoTR4bg/q1c
    MN0bgOROISAZ5PCjTAnZz4m+I+VxOmgmUCH7Yd5LhlFUOvG0NLp5NxSSzymtvPVOAA8b
    Io9nfoT15Y5Rd2uwAbeQN0+5GmN4QHyLoE++eJgy2nMw5Mibr8AsssNMJBH0j42dly2L
    PzLDGq+bchexQ44wre7iCYqgTAr0RMIQGNLDLqJgxEHmbrnsWaMoJOvBrTWHzw6HXm/h
    B7RW4DYR0u7lYLyLQdIQ1AOJXwUfrq/tqGpv1PcV+ASaGAAhirhKfLDCOzC4EEAxZf+j
    +dJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698665462;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aSrD28lmhj+RxARThzat964rxCSHCRAisNP1Dxcf7ZY=;
    b=KA5AUNmNOkgb5BFwFUDsoqoYu81wrDeF9nmMxMntyv9Oxa2dkvQqS/m5ISwR/pMjio
    2bDG2NrXbif3JxKxGVCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVITM8sik0"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9UBV1DJ4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 30 Oct 2023 12:31:01 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Cc:     linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: isotp: upgrade 5.10 LTS to latest 6.6 mainline code base
Date:   Mon, 30 Oct 2023 12:30:27 +0100
Message-Id: <20231030113027.3387-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The backport of commit 9c5df2f14ee3 ("can: isotp: isotp_ops: fix poll() to
not report false EPOLLOUT events") introduced a new regression where the
fix could potentially introduce new side effects.

To reduce the risk of other unmet dependencies and missing fixes and checks
the latest mainline code base is ported back to the 5.10 LTS tree.

To meet the former Linux 5.10 API these commits have been reverted:
e3ae2365efc1 ("net: sock: introduce sk_error_report")
f4b41f062c42 ("net: remove noblock parameter from skb_recv_datagram()")
96a7457a14d9 ("can: skb: unify skb CAN frame identification helpers")
dc97391e6610 ("sock: Remove ->sendpage*() in favour of sendmsg(MSG_SPLICE_PAGES)")
0145462fc802 ("can: isotp: isotp_recvmsg(): use sock_recv_cmsgs() to get SOCK_RXQ_OVFL infos")

New features and communication stability measures:
9f39d36530e5 ("can: isotp: add support for transmission without flow control")
96d1c81e6a04 ("can: isotp: add module parameter for maximum pdu size")
4b7fe92c0690 ("can: isotp: add local echo tx processing for consecutive frames")
530e0d46c613 ("can: isotp: set default value for N_As to 50 micro seconds")

And various sanity checks, fixes and improved return values.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/isotp.h |  25 +-
 net/can/isotp.c                | 495 ++++++++++++++++++++++-----------
 2 files changed, 347 insertions(+), 173 deletions(-)

diff --git a/include/uapi/linux/can/isotp.h b/include/uapi/linux/can/isotp.h
index 590f8aea2b6d..439c982f7e81 100644
--- a/include/uapi/linux/can/isotp.h
+++ b/include/uapi/linux/can/isotp.h
@@ -122,22 +122,23 @@ struct can_isotp_ll_options {
 				/* by the CAN netdriver configuration	*/
 };
 
 /* flags for isotp behaviour */
 
-#define CAN_ISOTP_LISTEN_MODE	0x001	/* listen only (do not send FC) */
-#define CAN_ISOTP_EXTEND_ADDR	0x002	/* enable extended addressing */
-#define CAN_ISOTP_TX_PADDING	0x004	/* enable CAN frame padding tx path */
-#define CAN_ISOTP_RX_PADDING	0x008	/* enable CAN frame padding rx path */
-#define CAN_ISOTP_CHK_PAD_LEN	0x010	/* check received CAN frame padding */
-#define CAN_ISOTP_CHK_PAD_DATA	0x020	/* check received CAN frame padding */
-#define CAN_ISOTP_HALF_DUPLEX	0x040	/* half duplex error state handling */
-#define CAN_ISOTP_FORCE_TXSTMIN	0x080	/* ignore stmin from received FC */
-#define CAN_ISOTP_FORCE_RXSTMIN	0x100	/* ignore CFs depending on rx stmin */
-#define CAN_ISOTP_RX_EXT_ADDR	0x200	/* different rx extended addressing */
-#define CAN_ISOTP_WAIT_TX_DONE	0x400	/* wait for tx completion */
-#define CAN_ISOTP_SF_BROADCAST	0x800	/* 1-to-N functional addressing */
+#define CAN_ISOTP_LISTEN_MODE	0x0001	/* listen only (do not send FC) */
+#define CAN_ISOTP_EXTEND_ADDR	0x0002	/* enable extended addressing */
+#define CAN_ISOTP_TX_PADDING	0x0004	/* enable CAN frame padding tx path */
+#define CAN_ISOTP_RX_PADDING	0x0008	/* enable CAN frame padding rx path */
+#define CAN_ISOTP_CHK_PAD_LEN	0x0010	/* check received CAN frame padding */
+#define CAN_ISOTP_CHK_PAD_DATA	0x0020	/* check received CAN frame padding */
+#define CAN_ISOTP_HALF_DUPLEX	0x0040	/* half duplex error state handling */
+#define CAN_ISOTP_FORCE_TXSTMIN	0x0080	/* ignore stmin from received FC */
+#define CAN_ISOTP_FORCE_RXSTMIN	0x0100	/* ignore CFs depending on rx stmin */
+#define CAN_ISOTP_RX_EXT_ADDR	0x0200	/* different rx extended addressing */
+#define CAN_ISOTP_WAIT_TX_DONE	0x0400	/* wait for tx completion */
+#define CAN_ISOTP_SF_BROADCAST	0x0800	/* 1-to-N functional addressing */
+#define CAN_ISOTP_CF_BROADCAST	0x1000	/* 1-to-N transmission w/o FC */
 
 /* protocol machine default values */
 
 #define CAN_ISOTP_DEFAULT_FLAGS		0
 #define CAN_ISOTP_DEFAULT_EXT_ADDRESS	0x00
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 16ebc187af1c..f30eb5ca307e 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -12,11 +12,10 @@
  * - TX path flowcontrol reception with wrong layout/padding leads to -EBADMSG
  * - when a transfer (tx) is on the run the next write() blocks until it's done
  * - use CAN_ISOTP_WAIT_TX_DONE flag to block the caller until the PDU is sent
  * - as we have static buffers the check whether the PDU fits into the buffer
  *   is done at FF reception time (no support for sending 'wait frames')
- * - take care of the tx-queue-len as traffic shaping is still on the TODO list
  *
  * Copyright (c) 2020 Volkswagen Group Electronic Research
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -84,14 +83,25 @@ MODULE_ALIAS("can-proto-6");
 			 (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG) : \
 			 (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
 
 /* ISO 15765-2:2016 supports more than 4095 byte per ISO PDU as the FF_DL can
  * take full 32 bit values (4 Gbyte). We would need some good concept to handle
- * this between user space and kernel space. For now increase the static buffer
- * to something about 8 kbyte to be able to test this new functionality.
+ * this between user space and kernel space. For now set the static buffer to
+ * something about 8 kbyte to be able to test this new functionality.
  */
-#define MAX_MSG_LENGTH 8200
+#define DEFAULT_MAX_PDU_SIZE 8300
+
+/* maximum PDU size before ISO 15765-2:2016 extension was 4095 */
+#define MAX_12BIT_PDU_SIZE 4095
+
+/* limit the isotp pdu size from the optional module parameter to 1MByte */
+#define MAX_PDU_SIZE (1025 * 1024U)
+
+static unsigned int max_pdu_size __read_mostly = DEFAULT_MAX_PDU_SIZE;
+module_param(max_pdu_size, uint, 0444);
+MODULE_PARM_DESC(max_pdu_size, "maximum isotp pdu size (default "
+		 __stringify(DEFAULT_MAX_PDU_SIZE) ")");
 
 /* N_PCI type values in bits 7-4 of N_PCI bytes */
 #define N_PCI_SF 0x00	/* single frame */
 #define N_PCI_FF 0x10	/* first frame */
 #define N_PCI_CF 0x20	/* consecutive frame */
@@ -103,49 +113,57 @@ MODULE_ALIAS("can-proto-6");
 #define FF_PCI_SZ12 2	/* size of FirstFrame PCI including 12 bit FF_DL */
 #define FF_PCI_SZ32 6	/* size of FirstFrame PCI including 32 bit FF_DL */
 #define FC_CONTENT_SZ 3	/* flow control content size in byte (FS/BS/STmin) */
 
 #define ISOTP_CHECK_PADDING (CAN_ISOTP_CHK_PAD_LEN | CAN_ISOTP_CHK_PAD_DATA)
+#define ISOTP_ALL_BC_FLAGS (CAN_ISOTP_SF_BROADCAST | CAN_ISOTP_CF_BROADCAST)
 
 /* Flow Status given in FC frame */
 #define ISOTP_FC_CTS 0		/* clear to send */
 #define ISOTP_FC_WT 1		/* wait */
 #define ISOTP_FC_OVFLW 2	/* overflow */
 
+#define ISOTP_FC_TIMEOUT 1	/* 1 sec */
+#define ISOTP_ECHO_TIMEOUT 2	/* 2 secs */
+
 enum {
 	ISOTP_IDLE = 0,
 	ISOTP_WAIT_FIRST_FC,
 	ISOTP_WAIT_FC,
 	ISOTP_WAIT_DATA,
-	ISOTP_SENDING
+	ISOTP_SENDING,
+	ISOTP_SHUTDOWN,
 };
 
 struct tpcon {
-	unsigned int idx;
+	u8 *buf;
+	unsigned int buflen;
 	unsigned int len;
+	unsigned int idx;
 	u32 state;
 	u8 bs;
 	u8 sn;
 	u8 ll_dl;
-	u8 buf[MAX_MSG_LENGTH + 1];
+	u8 sbuf[DEFAULT_MAX_PDU_SIZE];
 };
 
 struct isotp_sock {
 	struct sock sk;
 	int bound;
 	int ifindex;
 	canid_t txid;
 	canid_t rxid;
 	ktime_t tx_gap;
 	ktime_t lastrxcf_tstamp;
-	struct hrtimer rxtimer, txtimer;
+	struct hrtimer rxtimer, txtimer, txfrtimer;
 	struct can_isotp_options opt;
 	struct can_isotp_fc_options rxfc, txfc;
 	struct can_isotp_ll_options ll;
 	u32 frame_txtime;
 	u32 force_tx_stmin;
 	u32 force_rx_stmin;
+	u32 cfecho; /* consecutive frame echo tag */
 	struct tpcon rx, tx;
 	struct list_head notifier;
 	wait_queue_head_t wait;
 	spinlock_t rx_lock; /* protect single thread state machine */
 };
@@ -157,10 +175,21 @@ static struct isotp_sock *isotp_busy_notifier;
 static inline struct isotp_sock *isotp_sk(const struct sock *sk)
 {
 	return (struct isotp_sock *)sk;
 }
 
+static u32 isotp_bc_flags(struct isotp_sock *so)
+{
+	return so->opt.flags & ISOTP_ALL_BC_FLAGS;
+}
+
+static bool isotp_register_rxid(struct isotp_sock *so)
+{
+	/* no broadcast modes => register rx_id for FC frame reception */
+	return (isotp_bc_flags(so) == 0);
+}
+
 static enum hrtimer_restart isotp_rx_timer_handler(struct hrtimer *hrtimer)
 {
 	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
 					     rxtimer);
 	struct sock *sk = &so->sk;
@@ -226,23 +255,24 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 
 	ncf->flags = so->ll.tx_flags;
 
 	can_send_ret = can_send(nskb, 1);
 	if (can_send_ret)
-		pr_notice_once("can-isotp: %s: can_send_ret %d\n",
-			       __func__, can_send_ret);
+		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
+			       __func__, ERR_PTR(can_send_ret));
 
 	dev_put(dev);
 
 	/* reset blocksize counter */
 	so->rx.bs = 0;
 
 	/* reset last CF frame rx timestamp for rx stmin enforcement */
 	so->lastrxcf_tstamp = ktime_set(0, 0);
 
 	/* start rx timeout watchdog */
-	hrtimer_start(&so->rxtimer, ktime_set(1, 0), HRTIMER_MODE_REL_SOFT);
+	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+		      HRTIMER_MODE_REL_SOFT);
 	return 0;
 }
 
 static void isotp_rcv_skb(struct sk_buff *skb, struct sock *sk)
 {
@@ -324,10 +354,12 @@ static int check_pad(struct isotp_sock *so, struct canfd_frame *cf,
 				return 1;
 	}
 	return 0;
 }
 
+static void isotp_send_cframe(struct isotp_sock *so);
+
 static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 {
 	struct sock *sk = &so->sk;
 
 	if (so->tx.state != ISOTP_WAIT_FC &&
@@ -378,18 +410,19 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 
 	switch (cf->data[ae] & 0x0F) {
 	case ISOTP_FC_CTS:
 		so->tx.bs = 0;
 		so->tx.state = ISOTP_SENDING;
-		/* start cyclic timer for sending CF frame */
-		hrtimer_start(&so->txtimer, so->tx_gap,
+		/* send CF frame and enable echo timeout handling */
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
+		isotp_send_cframe(so);
 		break;
 
 	case ISOTP_FC_WT:
 		/* start timer to wait for next FC frame */
-		hrtimer_start(&so->txtimer, ktime_set(1, 0),
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		break;
 
 	case ISOTP_FC_OVFLW:
 		/* overflow on receiver side - report 'message too long' */
@@ -476,11 +509,21 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 	off = (so->rx.ll_dl > CAN_MAX_DLEN) ? 1 : 0;
 
 	if (so->rx.len + ae + off + ff_pci_sz < so->rx.ll_dl)
 		return 1;
 
-	if (so->rx.len > MAX_MSG_LENGTH) {
+	/* PDU size > default => try max_pdu_size */
+	if (so->rx.len > so->rx.buflen && so->rx.buflen < max_pdu_size) {
+		u8 *newbuf = kmalloc(max_pdu_size, GFP_ATOMIC);
+
+		if (newbuf) {
+			so->rx.buf = newbuf;
+			so->rx.buflen = max_pdu_size;
+		}
+	}
+
+	if (so->rx.len > so->rx.buflen) {
 		/* send FC frame with overflow status */
 		isotp_send_fc(sk, ae, ISOTP_FC_OVFLW);
 		return 1;
 	}
 
@@ -580,11 +623,11 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 	}
 
 	/* perform blocksize handling, if enabled */
 	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs) {
 		/* start rx timeout watchdog */
-		hrtimer_start(&so->rxtimer, ktime_set(1, 0),
+		hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		return 0;
 	}
 
 	/* no creation of flow control frames */
@@ -711,10 +754,67 @@ static void isotp_fill_dataframe(struct canfd_frame *cf, struct isotp_sock *so,
 
 	if (ae)
 		cf->data[0] = so->opt.ext_address;
 }
 
+static void isotp_send_cframe(struct isotp_sock *so)
+{
+	struct sock *sk = &so->sk;
+	struct sk_buff *skb;
+	struct net_device *dev;
+	struct canfd_frame *cf;
+	int can_send_ret;
+	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
+
+	dev = dev_get_by_index(sock_net(sk), so->ifindex);
+	if (!dev)
+		return;
+
+	skb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv), GFP_ATOMIC);
+	if (!skb) {
+		dev_put(dev);
+		return;
+	}
+
+	can_skb_reserve(skb);
+	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
+
+	cf = (struct canfd_frame *)skb->data;
+	skb_put_zero(skb, so->ll.mtu);
+
+	/* create consecutive frame */
+	isotp_fill_dataframe(cf, so, ae, 0);
+
+	/* place consecutive frame N_PCI in appropriate index */
+	cf->data[ae] = N_PCI_CF | so->tx.sn++;
+	so->tx.sn %= 16;
+	so->tx.bs++;
+
+	cf->flags = so->ll.tx_flags;
+
+	skb->dev = dev;
+	can_skb_set_owner(skb, sk);
+
+	/* cfecho should have been zero'ed by init/isotp_rcv_echo() */
+	if (so->cfecho)
+		pr_notice_once("can-isotp: cfecho is %08X != 0\n", so->cfecho);
+
+	/* set consecutive frame echo tag */
+	so->cfecho = *(u32 *)cf->data;
+
+	/* send frame with local echo enabled */
+	can_send_ret = can_send(skb, 1);
+	if (can_send_ret) {
+		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
+			       __func__, ERR_PTR(can_send_ret));
+		if (can_send_ret == -ENOBUFS)
+			pr_notice_once("can-isotp: tx queue is full\n");
+	}
+	dev_put(dev);
+}
+
 static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
 				int ae)
 {
 	int i;
 	int ff_pci_sz;
@@ -723,11 +823,11 @@ static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
 	cf->len = so->tx.ll_dl;
 	if (ae)
 		cf->data[0] = so->opt.ext_address;
 
 	/* create N_PCI bytes with 12/32 bit FF_DL data length */
-	if (so->tx.len > 4095) {
+	if (so->tx.len > MAX_12BIT_PDU_SIZE) {
 		/* use 32 bit FF_DL notation */
 		cf->data[ae] = N_PCI_FF;
 		cf->data[ae + 1] = 0;
 		cf->data[ae + 2] = (u8)(so->tx.len >> 24) & 0xFFU;
 		cf->data[ae + 3] = (u8)(so->tx.len >> 16) & 0xFFU;
@@ -744,159 +844,146 @@ static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
 	/* add first data bytes depending on ae */
 	for (i = ae + ff_pci_sz; i < so->tx.ll_dl; i++)
 		cf->data[i] = so->tx.buf[so->tx.idx++];
 
 	so->tx.sn = 1;
-	so->tx.state = ISOTP_WAIT_FIRST_FC;
 }
 
-static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
+static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 {
-	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
-					     txtimer);
-	struct sock *sk = &so->sk;
-	struct sk_buff *skb;
-	struct net_device *dev;
-	struct canfd_frame *cf;
-	enum hrtimer_restart restart = HRTIMER_NORESTART;
-	int can_send_ret;
-	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
+	struct sock *sk = (struct sock *)data;
+	struct isotp_sock *so = isotp_sk(sk);
+	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 
-	switch (so->tx.state) {
-	case ISOTP_WAIT_FC:
-	case ISOTP_WAIT_FIRST_FC:
+	/* only handle my own local echo CF/SF skb's (no FF!) */
+	if (skb->sk != sk || so->cfecho != *(u32 *)cf->data)
+		return;
 
-		/* we did not get any flow control frame in time */
+	/* cancel local echo timeout */
+	hrtimer_cancel(&so->txtimer);
 
-		/* report 'communication error on send' */
-		sk->sk_err = ECOMM;
-		if (!sock_flag(sk, SOCK_DEAD))
-			sk->sk_error_report(sk);
+	/* local echo skb with consecutive frame has been consumed */
+	so->cfecho = 0;
 
-		/* reset tx state */
+	if (so->tx.idx >= so->tx.len) {
+		/* we are done */
 		so->tx.state = ISOTP_IDLE;
 		wake_up_interruptible(&so->wait);
-		break;
-
-	case ISOTP_SENDING:
-
-		/* push out the next segmented pdu */
-		dev = dev_get_by_index(sock_net(sk), so->ifindex);
-		if (!dev)
-			break;
-
-isotp_tx_burst:
-		skb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv),
-				GFP_ATOMIC);
-		if (!skb) {
-			dev_put(dev);
-			break;
-		}
+		return;
+	}
 
-		can_skb_reserve(skb);
-		can_skb_prv(skb)->ifindex = dev->ifindex;
-		can_skb_prv(skb)->skbcnt = 0;
+	if (so->txfc.bs && so->tx.bs >= so->txfc.bs) {
+		/* stop and wait for FC with timeout */
+		so->tx.state = ISOTP_WAIT_FC;
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+			      HRTIMER_MODE_REL_SOFT);
+		return;
+	}
 
-		cf = (struct canfd_frame *)skb->data;
-		skb_put_zero(skb, so->ll.mtu);
+	/* no gap between data frames needed => use burst mode */
+	if (!so->tx_gap) {
+		/* enable echo timeout handling */
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+			      HRTIMER_MODE_REL_SOFT);
+		isotp_send_cframe(so);
+		return;
+	}
 
-		/* create consecutive frame */
-		isotp_fill_dataframe(cf, so, ae, 0);
+	/* start timer to send next consecutive frame with correct delay */
+	hrtimer_start(&so->txfrtimer, so->tx_gap, HRTIMER_MODE_REL_SOFT);
+}
 
-		/* place consecutive frame N_PCI in appropriate index */
-		cf->data[ae] = N_PCI_CF | so->tx.sn++;
-		so->tx.sn %= 16;
-		so->tx.bs++;
+static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
+{
+	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
+					     txtimer);
+	struct sock *sk = &so->sk;
 
-		cf->flags = so->ll.tx_flags;
+	/* don't handle timeouts in IDLE or SHUTDOWN state */
+	if (so->tx.state == ISOTP_IDLE || so->tx.state == ISOTP_SHUTDOWN)
+		return HRTIMER_NORESTART;
 
-		skb->dev = dev;
-		can_skb_set_owner(skb, sk);
+	/* we did not get any flow control or echo frame in time */
 
-		can_send_ret = can_send(skb, 1);
-		if (can_send_ret)
-			pr_notice_once("can-isotp: %s: can_send_ret %d\n",
-				       __func__, can_send_ret);
+	/* report 'communication error on send' */
+	sk->sk_err = ECOMM;
+	if (!sock_flag(sk, SOCK_DEAD))
+		sk->sk_error_report(sk);
 
-		if (so->tx.idx >= so->tx.len) {
-			/* we are done */
-			so->tx.state = ISOTP_IDLE;
-			dev_put(dev);
-			wake_up_interruptible(&so->wait);
-			break;
-		}
+	/* reset tx state */
+	so->tx.state = ISOTP_IDLE;
+	wake_up_interruptible(&so->wait);
 
-		if (so->txfc.bs && so->tx.bs >= so->txfc.bs) {
-			/* stop and wait for FC */
-			so->tx.state = ISOTP_WAIT_FC;
-			dev_put(dev);
-			hrtimer_set_expires(&so->txtimer,
-					    ktime_add(ktime_get(),
-						      ktime_set(1, 0)));
-			restart = HRTIMER_RESTART;
-			break;
-		}
+	return HRTIMER_NORESTART;
+}
 
-		/* no gap between data frames needed => use burst mode */
-		if (!so->tx_gap)
-			goto isotp_tx_burst;
+static enum hrtimer_restart isotp_txfr_timer_handler(struct hrtimer *hrtimer)
+{
+	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
+					     txfrtimer);
 
-		/* start timer to send next data frame with correct delay */
-		dev_put(dev);
-		hrtimer_set_expires(&so->txtimer,
-				    ktime_add(ktime_get(), so->tx_gap));
-		restart = HRTIMER_RESTART;
-		break;
+	/* start echo timeout handling and cover below protocol error */
+	hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+		      HRTIMER_MODE_REL_SOFT);
 
-	default:
-		WARN_ON_ONCE(1);
-	}
+	/* cfecho should be consumed by isotp_rcv_echo() here */
+	if (so->tx.state == ISOTP_SENDING && !so->cfecho)
+		isotp_send_cframe(so);
 
-	return restart;
+	return HRTIMER_NORESTART;
 }
 
 static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
-	u32 old_state = so->tx.state;
 	struct sk_buff *skb;
 	struct net_device *dev;
 	struct canfd_frame *cf;
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
-	s64 hrtimer_sec = 0;
+	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
 	int off;
 	int err;
 
-	if (!so->bound)
+	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
-	/* we do not support multiple buffers - for now */
-	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE ||
-	    wq_has_sleeper(&so->wait)) {
-		if (msg->msg_flags & MSG_DONTWAIT) {
-			err = -EAGAIN;
-			goto err_out;
-		}
+	while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
+		/* we do not support multiple buffers - for now */
+		if (msg->msg_flags & MSG_DONTWAIT)
+			return -EAGAIN;
+
+		if (so->tx.state == ISOTP_SHUTDOWN)
+			return -EADDRNOTAVAIL;
 
 		/* wait for complete transmission of current pdu */
 		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
 		if (err)
-			goto err_out;
+			goto err_event_drop;
+	}
+
+	/* PDU size > default => try max_pdu_size */
+	if (size > so->tx.buflen && so->tx.buflen < max_pdu_size) {
+		u8 *newbuf = kmalloc(max_pdu_size, GFP_KERNEL);
+
+		if (newbuf) {
+			so->tx.buf = newbuf;
+			so->tx.buflen = max_pdu_size;
+		}
 	}
 
-	if (!size || size > MAX_MSG_LENGTH) {
+	if (!size || size > so->tx.buflen) {
 		err = -EINVAL;
 		goto err_out_drop;
 	}
 
 	/* take care of a potential SF_DL ESC offset for TX_DL > 8 */
 	off = (so->tx.ll_dl > CAN_MAX_DLEN) ? 1 : 0;
 
 	/* does the given data fit into a single frame for SF_BROADCAST? */
-	if ((so->opt.flags & CAN_ISOTP_SF_BROADCAST) &&
+	if ((isotp_bc_flags(so) == CAN_ISOTP_SF_BROADCAST) &&
 	    (size > so->tx.ll_dl - SF_PCI_SZ4 - ae - off)) {
 		err = -EINVAL;
 		goto err_out_drop;
 	}
 
@@ -925,10 +1012,14 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	so->tx.idx = 0;
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
+	/* cfecho should have been zero'ed by init / former isotp_rcv_echo() */
+	if (so->cfecho)
+		pr_notice_once("can-isotp: uninit cfecho %08X\n", so->cfecho);
+
 	/* check for single frame transmission depending on TX_DL */
 	if (size <= so->tx.ll_dl - SF_PCI_SZ4 - ae - off) {
 		/* The message size generally fits into a SingleFrame - good.
 		 *
 		 * SF_DL ESC offset optimization:
@@ -950,62 +1041,86 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		if (off)
 			cf->data[SF_PCI_SZ4 + ae] = size;
 		else
 			cf->data[ae] |= size;
 
-		so->tx.state = ISOTP_IDLE;
-		wake_up_interruptible(&so->wait);
-
-		/* don't enable wait queue for a single frame transmission */
-		wait_tx_done = 0;
+		/* set CF echo tag for isotp_rcv_echo() (SF-mode) */
+		so->cfecho = *(u32 *)cf->data;
 	} else {
-		/* send first frame and wait for FC */
+		/* send first frame */
 
 		isotp_create_fframe(cf, so, ae);
 
-		/* start timeout for FC */
-		hrtimer_sec = 1;
-		hrtimer_start(&so->txtimer, ktime_set(hrtimer_sec, 0),
-			      HRTIMER_MODE_REL_SOFT);
+		if (isotp_bc_flags(so) == CAN_ISOTP_CF_BROADCAST) {
+			/* set timer for FC-less operation (STmin = 0) */
+			if (so->opt.flags & CAN_ISOTP_FORCE_TXSTMIN)
+				so->tx_gap = ktime_set(0, so->force_tx_stmin);
+			else
+				so->tx_gap = ktime_set(0, so->frame_txtime);
+
+			/* disable wait for FCs due to activated block size */
+			so->txfc.bs = 0;
+
+			/* set CF echo tag for isotp_rcv_echo() (CF-mode) */
+			so->cfecho = *(u32 *)cf->data;
+		} else {
+			/* standard flow control check */
+			so->tx.state = ISOTP_WAIT_FIRST_FC;
+
+			/* start timeout for FC */
+			hrtimer_sec = ISOTP_FC_TIMEOUT;
+
+			/* no CF echo tag for isotp_rcv_echo() (FF-mode) */
+			so->cfecho = 0;
+		}
 	}
 
+	hrtimer_start(&so->txtimer, ktime_set(hrtimer_sec, 0),
+		      HRTIMER_MODE_REL_SOFT);
+
 	/* send the first or only CAN frame */
 	cf->flags = so->ll.tx_flags;
 
 	skb->dev = dev;
 	skb->sk = sk;
 	err = can_send(skb, 1);
 	dev_put(dev);
 	if (err) {
-		pr_notice_once("can-isotp: %s: can_send_ret %d\n",
-			       __func__, err);
+		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
+			       __func__, ERR_PTR(err));
 
 		/* no transmission -> no timeout monitoring */
-		if (hrtimer_sec)
-			hrtimer_cancel(&so->txtimer);
+		hrtimer_cancel(&so->txtimer);
+
+		/* reset consecutive frame echo tag */
+		so->cfecho = 0;
 
 		goto err_out_drop;
 	}
 
 	if (wait_tx_done) {
 		/* wait for complete transmission of current pdu */
-		wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		if (err)
+			goto err_event_drop;
 
 		err = sock_error(sk);
 		if (err)
 			return err;
 	}
 
 	return size;
 
+err_event_drop:
+	/* got signal: force tx state machine to be idle */
+	so->tx.state = ISOTP_IDLE;
+	hrtimer_cancel(&so->txfrtimer);
+	hrtimer_cancel(&so->txtimer);
 err_out_drop:
 	/* drop this PDU and unlock a potential wait queue */
-	old_state = ISOTP_IDLE;
-err_out:
-	so->tx.state = old_state;
-	if (so->tx.state == ISOTP_IDLE)
-		wake_up_interruptible(&so->wait);
+	so->tx.state = ISOTP_IDLE;
+	wake_up_interruptible(&so->wait);
 
 	return err;
 }
 
 static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
@@ -1065,11 +1180,17 @@ static int isotp_release(struct socket *sock)
 
 	so = isotp_sk(sk);
 	net = sock_net(sk);
 
 	/* wait for complete transmission of current pdu */
-	wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+	while (wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 0 &&
+	       cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SHUTDOWN) != ISOTP_IDLE)
+		;
+
+	/* force state machines to be idle also when a signal occurred */
+	so->tx.state = ISOTP_SHUTDOWN;
+	so->rx.state = ISOTP_IDLE;
 
 	spin_lock(&isotp_notifier_lock);
 	while (isotp_busy_notifier == so) {
 		spin_unlock(&isotp_notifier_lock);
 		schedule_timeout_uninterruptible(1);
@@ -1079,31 +1200,43 @@ static int isotp_release(struct socket *sock)
 	spin_unlock(&isotp_notifier_lock);
 
 	lock_sock(sk);
 
 	/* remove current filters & unregister */
-	if (so->bound && (!(so->opt.flags & CAN_ISOTP_SF_BROADCAST))) {
+	if (so->bound) {
 		if (so->ifindex) {
 			struct net_device *dev;
 
 			dev = dev_get_by_index(net, so->ifindex);
 			if (dev) {
-				can_rx_unregister(net, dev, so->rxid,
-						  SINGLE_MASK(so->rxid),
-						  isotp_rcv, sk);
+				if (isotp_register_rxid(so))
+					can_rx_unregister(net, dev, so->rxid,
+							  SINGLE_MASK(so->rxid),
+							  isotp_rcv, sk);
+
+				can_rx_unregister(net, dev, so->txid,
+						  SINGLE_MASK(so->txid),
+						  isotp_rcv_echo, sk);
 				dev_put(dev);
 				synchronize_rcu();
 			}
 		}
 	}
 
+	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 	hrtimer_cancel(&so->rxtimer);
 
 	so->ifindex = 0;
 	so->bound = 0;
 
+	if (so->rx.buf != so->rx.sbuf)
+		kfree(so->rx.buf);
+
+	if (so->tx.buf != so->tx.sbuf)
+		kfree(so->tx.buf);
+
 	sock_orphan(sk);
 	sock->sk = NULL;
 
 	release_sock(sk);
 	sock_put(sk);
@@ -1117,30 +1250,42 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
 	struct net *net = sock_net(sk);
 	int ifindex;
 	struct net_device *dev;
-	canid_t tx_id, rx_id;
+	canid_t tx_id = addr->can_addr.tp.tx_id;
+	canid_t rx_id = addr->can_addr.tp.rx_id;
 	int err = 0;
 	int notify_enetdown = 0;
-	int do_rx_reg = 1;
 
 	if (len < ISOTP_MIN_NAMELEN)
 		return -EINVAL;
 
-	/* sanitize tx/rx CAN identifiers */
-	tx_id = addr->can_addr.tp.tx_id;
+	if (addr->can_family != AF_CAN)
+		return -EINVAL;
+
+	/* sanitize tx CAN identifier */
 	if (tx_id & CAN_EFF_FLAG)
 		tx_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
 	else
 		tx_id &= CAN_SFF_MASK;
 
-	rx_id = addr->can_addr.tp.rx_id;
-	if (rx_id & CAN_EFF_FLAG)
-		rx_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
-	else
-		rx_id &= CAN_SFF_MASK;
+	/* give feedback on wrong CAN-ID value */
+	if (tx_id != addr->can_addr.tp.tx_id)
+		return -EINVAL;
+
+	/* sanitize rx CAN identifier (if needed) */
+	if (isotp_register_rxid(so)) {
+		if (rx_id & CAN_EFF_FLAG)
+			rx_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
+		else
+			rx_id &= CAN_SFF_MASK;
+
+		/* give feedback on wrong CAN-ID value */
+		if (rx_id != addr->can_addr.tp.rx_id)
+			return -EINVAL;
+	}
 
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
 	lock_sock(sk);
@@ -1148,16 +1293,12 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (so->bound) {
 		err = -EINVAL;
 		goto out;
 	}
 
-	/* do not register frame reception for functional addressing */
-	if (so->opt.flags & CAN_ISOTP_SF_BROADCAST)
-		do_rx_reg = 0;
-
-	/* do not validate rx address for functional addressing */
-	if (do_rx_reg && rx_id == tx_id) {
+	/* ensure different CAN IDs when the rx_id is to be registered */
+	if (isotp_register_rxid(so) && rx_id == tx_id) {
 		err = -EADDRNOTAVAIL;
 		goto out;
 	}
 
 	dev = dev_get_by_index(net, addr->can_ifindex);
@@ -1178,14 +1319,21 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (!(dev->flags & IFF_UP))
 		notify_enetdown = 1;
 
 	ifindex = dev->ifindex;
 
-	if (do_rx_reg)
+	if (isotp_register_rxid(so))
 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
 				isotp_rcv, sk, "isotp", sk);
 
+	/* no consecutive frame echo skb in flight */
+	so->cfecho = 0;
+
+	/* register for echo skb's */
+	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
+			isotp_rcv_echo, sk, "isotpe", sk);
+
 	dev_put(dev);
 
 	/* switch to new settings */
 	so->ifindex = ifindex;
 	so->rxid = rx_id;
@@ -1242,10 +1390,19 @@ static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
 
 		/* no separate rx_ext_address is given => use ext_address */
 		if (!(so->opt.flags & CAN_ISOTP_RX_EXT_ADDR))
 			so->opt.rx_ext_address = so->opt.ext_address;
 
+		/* these broadcast flags are not allowed together */
+		if (isotp_bc_flags(so) == ISOTP_ALL_BC_FLAGS) {
+			/* CAN_ISOTP_SF_BROADCAST is prioritized */
+			so->opt.flags &= ~CAN_ISOTP_CF_BROADCAST;
+
+			/* give user feedback on wrong config attempt */
+			ret = -EINVAL;
+		}
+
 		/* check for frame_txtime changes (0 => no changes) */
 		if (so->opt.frame_txtime) {
 			if (so->opt.frame_txtime == CAN_ISOTP_FRAME_TXTIME_ZERO)
 				so->frame_txtime = 0;
 			else
@@ -1392,14 +1549,20 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 		/* remove current filters & unregister */
-		if (so->bound && (!(so->opt.flags & CAN_ISOTP_SF_BROADCAST)))
-			can_rx_unregister(dev_net(dev), dev, so->rxid,
-					  SINGLE_MASK(so->rxid),
-					  isotp_rcv, sk);
+		if (so->bound) {
+			if (isotp_register_rxid(so))
+				can_rx_unregister(dev_net(dev), dev, so->rxid,
+						  SINGLE_MASK(so->rxid),
+						  isotp_rcv, sk);
+
+			can_rx_unregister(dev_net(dev), dev, so->txid,
+					  SINGLE_MASK(so->txid),
+					  isotp_rcv_echo, sk);
+		}
 
 		so->ifindex = 0;
 		so->bound  = 0;
 		release_sock(sk);
 
@@ -1464,14 +1627,21 @@ static int isotp_init(struct sock *sk)
 	so->tx.ll_dl = so->ll.tx_dl;
 
 	so->rx.state = ISOTP_IDLE;
 	so->tx.state = ISOTP_IDLE;
 
+	so->rx.buf = so->rx.sbuf;
+	so->tx.buf = so->tx.sbuf;
+	so->rx.buflen = ARRAY_SIZE(so->rx.sbuf);
+	so->tx.buflen = ARRAY_SIZE(so->tx.sbuf);
+
 	hrtimer_init(&so->rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	so->rxtimer.function = isotp_rx_timer_handler;
 	hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	so->txtimer.function = isotp_tx_timer_handler;
+	hrtimer_init(&so->txfrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	so->txfrtimer.function = isotp_txfr_timer_handler;
 
 	init_waitqueue_head(&so->wait);
 	spin_lock_init(&so->rx_lock);
 
 	spin_lock(&isotp_notifier_lock);
@@ -1544,15 +1714,18 @@ static struct notifier_block canisotp_notifier = {
 
 static __init int isotp_module_init(void)
 {
 	int err;
 
-	pr_info("can: isotp protocol\n");
+	max_pdu_size = max_t(unsigned int, max_pdu_size, MAX_12BIT_PDU_SIZE);
+	max_pdu_size = min_t(unsigned int, max_pdu_size, MAX_PDU_SIZE);
+
+	pr_info("can: isotp protocol (max_pdu_size %d)\n", max_pdu_size);
 
 	err = can_proto_register(&isotp_can_proto);
 	if (err < 0)
-		pr_err("can: registration of isotp protocol failed\n");
+		pr_err("can: registration of isotp protocol failed %pe\n", ERR_PTR(err));
 	else
 		register_netdevice_notifier(&canisotp_notifier);
 
 	return err;
 }
-- 
2.34.1

