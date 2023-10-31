Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A457DC9A7
	for <lists+linux-can@lfdr.de>; Tue, 31 Oct 2023 10:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343927AbjJaJbC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Oct 2023 05:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343922AbjJaJbA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Oct 2023 05:31:00 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF828B7;
        Tue, 31 Oct 2023 02:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698744633; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mK9ETHdm/PzgSVeeVzQxl7ijlDw7CmR01e7zVYpnLJQJ9qCwx24SElZ6Fd9sP7fUm7
    jN3jXhzyxb4Ng3KcB9OVjDJLc8Flqt60SHI4JnVv/vpfnGDmOkMMm0PyhPDY4NarHigx
    X3g08zQbsKNnZSZW/ZOeTdOmv3EAMMgCKbIeVIS+VbOyIm/xzl5kXimt3qpQnRQGwjTW
    jfjAmHnCXHw4c8UFpGmcLjh9nUFUjpkZpn4fmopmoIaPqg4HIce3IVkInmDShx7JfcCS
    e23jdOsV0m40GDmti1wZUyImQk2NukwSl6yrDx+w4jCtyDMPQWOATOmdMNPq3RzLut+c
    jGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744633;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZZWvSHvo6eUjDvjVVsVC1v6d6aWP5PHTEyOBbv0Qb0Q=;
    b=bO+7m+5uKdaEILtAoknOIY0D7X4hcVGNxuQ1GijDr7+k4E6O7047+fYRzzmYe9ibPa
    I9eelCtPbgjMxrpqLV1ttDSIJPaU1nNKCM4Nd4ySw7/M5lZLzW48T4AnQZ49l8EB53uw
    mFQrmx45nYCF3dwfuQ4TfUml7cCn2xAerfWghQ8LGSgvygsL/p8oNzJCGOSFKyX6SsYc
    HjMlxb1AC8bw0iNrbSfZ1eJvm3pevEZr+796SloCznQwn4PwPXFW1vhTLhByQHZJobY3
    DsyT7Ca7c/JY2QcNqQ34DgSVIKX+u05J2ftNnRZPenEr8fWoro89yW3It1uptbbKfva4
    /TBg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744633;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZZWvSHvo6eUjDvjVVsVC1v6d6aWP5PHTEyOBbv0Qb0Q=;
    b=Mmjp/GmrdYsSWAD8yWnvuOtUjKoNZuR2jtRVj+0uiZeHrbTDNMxqluQCpHjn5ADl0l
    95VC9iPOpcfc+rC+uyzkhuTw0fYHt2xll3rU77nM1Obp7Gkz5tat7Q9QCkFpQvEYww0m
    BI08jvvlD5wTIqVsv3g/gMF1SrrNRkVcbCfPQs6qOIW662h2w/hIviHq6BDltyEjKwoe
    A9/UP8d+mpyFbnh0lPpW9ZHwclAtoXW7lR0f22+qvFsoe6GWqqxlp9xFQwtUERxzdlIC
    tSsRozmIOPUjVohBu8Fc0sX5Ai9g2ARrnhNvH1+NPkTfLnohIwYfgidG+F1giI+YeIU9
    JwiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698744633;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZZWvSHvo6eUjDvjVVsVC1v6d6aWP5PHTEyOBbv0Qb0Q=;
    b=JugyRAXVYv/AlystoPC1Vz8+e8bDgVuIG+AYr2K3AOG+LyR1qtvkZ/sv8tCTOiIAxB
    A4aqIL+gZIb3r3fkwbBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVITM8sik0"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9V9UXFhc
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Oct 2023 10:30:33 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Cc:     linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH stable 5.15 5/7] can: isotp: add local echo tx processing and tx without FC
Date:   Tue, 31 Oct 2023 10:30:23 +0100
Message-Id: <20231031093025.2699-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031093025.2699-1-socketcan@hartkopp.net>
References: <20231031093025.2699-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

commit 4b7fe92c06901f4563af0e36d25223a5ab343782 upstream
commit 9f39d36530e5678d092d53c5c2c60d82b4dcc169 upstream
commit 051737439eaee5bdd03d3c2ef5510d54a478fd05 upstream

Due to the existing patch order applied to isotp.c in the stable kernel the
original order of depending patches the three original patches
4b7fe92c0690 ("can: isotp: add local echo tx processing for consecutive frames")
9f39d36530e5 ("can: isotp: add support for transmission without flow control")
051737439eae ("can: isotp: fix race between isotp_sendsmg() and isotp_release()")
can not be split into different patches that can be applied in working steps
to the stable tree.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/isotp.h |  25 ++-
 net/can/isotp.c                | 398 +++++++++++++++++++++------------
 2 files changed, 267 insertions(+), 156 deletions(-)

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
index 683010c71a8a..19fffa8676f9 100644
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
@@ -103,22 +102,27 @@ MODULE_ALIAS("can-proto-6");
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
 	unsigned int idx;
 	unsigned int len;
@@ -135,17 +139,18 @@ struct isotp_sock {
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
@@ -157,10 +162,21 @@ static struct isotp_sock *isotp_busy_notifier;
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
@@ -238,11 +254,12 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 
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
@@ -324,10 +341,12 @@ static int check_pad(struct isotp_sock *so, struct canfd_frame *cf,
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
@@ -378,18 +397,19 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 
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
@@ -580,11 +600,11 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
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
@@ -711,10 +731,67 @@ static void isotp_fill_dataframe(struct canfd_frame *cf, struct isotp_sock *so,
 
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
@@ -744,149 +821,127 @@ static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
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
-			sk_error_report(sk);
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
+		return;
+	}
 
-isotp_tx_burst:
-		skb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv),
-				GFP_ATOMIC);
-		if (!skb) {
-			dev_put(dev);
-			break;
-		}
+	if (so->txfc.bs && so->tx.bs >= so->txfc.bs) {
+		/* stop and wait for FC with timeout */
+		so->tx.state = ISOTP_WAIT_FC;
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+			      HRTIMER_MODE_REL_SOFT);
+		return;
+	}
 
-		can_skb_reserve(skb);
-		can_skb_prv(skb)->ifindex = dev->ifindex;
-		can_skb_prv(skb)->skbcnt = 0;
+	/* no gap between data frames needed => use burst mode */
+	if (!so->tx_gap) {
+		/* enable echo timeout handling */
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+			      HRTIMER_MODE_REL_SOFT);
+		isotp_send_cframe(so);
+		return;
+	}
 
-		cf = (struct canfd_frame *)skb->data;
-		skb_put_zero(skb, so->ll.mtu);
+	/* start timer to send next consecutive frame with correct delay */
+	hrtimer_start(&so->txfrtimer, so->tx_gap, HRTIMER_MODE_REL_SOFT);
+}
 
-		/* create consecutive frame */
-		isotp_fill_dataframe(cf, so, ae, 0);
+static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
+{
+	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
+					     txtimer);
+	struct sock *sk = &so->sk;
 
-		/* place consecutive frame N_PCI in appropriate index */
-		cf->data[ae] = N_PCI_CF | so->tx.sn++;
-		so->tx.sn %= 16;
-		so->tx.bs++;
+	/* don't handle timeouts in IDLE or SHUTDOWN state */
+	if (so->tx.state == ISOTP_IDLE || so->tx.state == ISOTP_SHUTDOWN)
+		return HRTIMER_NORESTART;
 
-		cf->flags = so->ll.tx_flags;
+	/* we did not get any flow control or echo frame in time */
 
-		skb->dev = dev;
-		can_skb_set_owner(skb, sk);
+	/* report 'communication error on send' */
+	sk->sk_err = ECOMM;
+	if (!sock_flag(sk, SOCK_DEAD))
+		sk_error_report(sk);
 
-		can_send_ret = can_send(skb, 1);
-		if (can_send_ret) {
-			pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
-				       __func__, ERR_PTR(can_send_ret));
-			if (can_send_ret == -ENOBUFS)
-				pr_notice_once("can-isotp: tx queue is full, increasing txqueuelen may prevent this error\n");
-		}
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
 
+wait_free_buffer:
 	/* we do not support multiple buffers - for now */
-	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE ||
-	    wq_has_sleeper(&so->wait)) {
-		if (msg->msg_flags & MSG_DONTWAIT) {
-			err = -EAGAIN;
-			goto err_out;
-		}
+	if (wq_has_sleeper(&so->wait) && (msg->msg_flags & MSG_DONTWAIT))
+		return -EAGAIN;
 
-		/* wait for complete transmission of current pdu */
-		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
-		if (err)
-			goto err_out;
+	/* wait for complete transmission of current pdu */
+	err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+	if (err)
+		goto err_event_drop;
+
+	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
+		if (so->tx.state == ISOTP_SHUTDOWN)
+			return -EADDRNOTAVAIL;
+
+		goto wait_free_buffer;
 	}
 
 	if (!size || size > MAX_MSG_LENGTH) {
 		err = -EINVAL;
 		goto err_out_drop;
@@ -894,11 +949,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	/* take care of a potential SF_DL ESC offset for TX_DL > 8 */
 	off = (so->tx.ll_dl > CAN_MAX_DLEN) ? 1 : 0;
 
 	/* does the given data fit into a single frame for SF_BROADCAST? */
-	if ((so->opt.flags & CAN_ISOTP_SF_BROADCAST) &&
+	if ((isotp_bc_flags(so) == CAN_ISOTP_SF_BROADCAST) &&
 	    (size > so->tx.ll_dl - SF_PCI_SZ4 - ae - off)) {
 		err = -EINVAL;
 		goto err_out_drop;
 	}
 
@@ -927,10 +982,14 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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
@@ -952,26 +1011,44 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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
@@ -980,34 +1057,40 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (err) {
 		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
 			       __func__, ERR_PTR(err));
 
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
@@ -1067,14 +1150,16 @@ static int isotp_release(struct socket *sock)
 
 	so = isotp_sk(sk);
 	net = sock_net(sk);
 
 	/* wait for complete transmission of current pdu */
-	wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+	while (wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 0 &&
+	       cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SHUTDOWN) != ISOTP_IDLE)
+		;
 
 	/* force state machines to be idle also when a signal occurred */
-	so->tx.state = ISOTP_IDLE;
+	so->tx.state = ISOTP_SHUTDOWN;
 	so->rx.state = ISOTP_IDLE;
 
 	spin_lock(&isotp_notifier_lock);
 	while (isotp_busy_notifier == so) {
 		spin_unlock(&isotp_notifier_lock);
@@ -1085,25 +1170,31 @@ static int isotp_release(struct socket *sock)
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
@@ -1126,11 +1217,10 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	int ifindex;
 	struct net_device *dev;
 	canid_t tx_id, rx_id;
 	int err = 0;
 	int notify_enetdown = 0;
-	int do_rx_reg = 1;
 
 	if (len < ISOTP_MIN_NAMELEN)
 		return -EINVAL;
 
 	if (addr->can_family != AF_CAN)
@@ -1162,16 +1252,12 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
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
@@ -1192,14 +1278,21 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
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
@@ -1256,10 +1349,19 @@ static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
 
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
@@ -1406,14 +1508,20 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 
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
 
@@ -1482,10 +1590,12 @@ static int isotp_init(struct sock *sk)
 
 	hrtimer_init(&so->rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	so->rxtimer.function = isotp_rx_timer_handler;
 	hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	so->txtimer.function = isotp_tx_timer_handler;
+	hrtimer_init(&so->txfrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	so->txfrtimer.function = isotp_txfr_timer_handler;
 
 	init_waitqueue_head(&so->wait);
 	spin_lock_init(&so->rx_lock);
 
 	spin_lock(&isotp_notifier_lock);
-- 
2.34.1

