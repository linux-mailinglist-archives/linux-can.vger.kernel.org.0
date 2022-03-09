Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960444D2EA8
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 13:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiCIMF2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 07:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiCIMF0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 07:05:26 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA90916F950
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 04:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646827462;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=BaRbmRrBazonyXmdQ7AJfqHD+ADmgCWo0KbZINyU3IA=;
    b=END5zBa5DabTZda/8s2JOU7w9ZVKd//9iZr/wdMjALq+XfSFngvB8Y62vPovX9+vsg
    DWkZP/JgW2grngdvCsgNbT84vccavRVlblD/dpgPIDp2aRB4V0ChrzRYDFyACLkhQORH
    ZHEibLiSUzenpxEZcTMdmtSVYAyusnNOQRGq6TAyaY08xPBlHH8SOLQEkrbC9ehSO4b/
    SKhRhCRTD539PlC9+59cr/DRKuVDwbBQ2ZkhF9WEv8J+dXkVwCd//mw4Stf8FpEHAAD6
    br9H9D0pdgbsE9wKSWtNQIGwCo/jxR0xASm/C4mCYtfh76CFc2RlLvEi68pmVMxBvMbU
    OSIA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9IyLecSWJafUvprl4"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.40.1 AUTH)
    with ESMTPSA id 6c57e6y29C4MEQ7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 9 Mar 2022 13:04:22 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [can-next v2 1/5] can: isotp: add local echo tx processing for consecutive frames
Date:   Wed,  9 Mar 2022 13:04:12 +0100
Message-Id: <20220309120416.83514-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Instead of dumping the CAN frames into the netdevice queue the process to
transmit consecutive frames (CF) now waits for the frame to be transmitted
and therefore echo'ed from the CAN interface.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 219 ++++++++++++++++++++++++++++++------------------
 1 file changed, 139 insertions(+), 80 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index d2a430b6a13b..d59f1758ac9c 100644
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
@@ -141,10 +140,11 @@ struct isotp_sock {
 	struct can_isotp_options opt;
 	struct can_isotp_fc_options rxfc, txfc;
 	struct can_isotp_ll_options ll;
 	u32 force_tx_stmin;
 	u32 force_rx_stmin;
+	u32 cfecho; /* consecutive frame echo tag */
 	struct tpcon rx, tx;
 	struct list_head notifier;
 	wait_queue_head_t wait;
 	spinlock_t rx_lock; /* protect single thread state machine */
 };
@@ -710,10 +710,67 @@ static void isotp_fill_dataframe(struct canfd_frame *cf, struct isotp_sock *so,
 
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
@@ -746,23 +803,78 @@ static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
 
 	so->tx.sn = 1;
 	so->tx.state = ISOTP_WAIT_FIRST_FC;
 }
 
+static void isotp_rcv_echo(struct sk_buff *skb, void *data)
+{
+	struct sock *sk = (struct sock *)data;
+	struct isotp_sock *so = isotp_sk(sk);
+	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+
+	/* only handle my own local echo skb's */
+	if (skb->sk != sk || so->cfecho != *(u32 *)cf->data)
+		return;
+
+	/* cancel local echo timeout */
+	hrtimer_cancel(&so->txtimer);
+
+	/* local echo skb with consecutive frame has been consumed */
+	so->cfecho = 0;
+
+	if (so->tx.idx >= so->tx.len) {
+		/* we are done */
+		so->tx.state = ISOTP_IDLE;
+		wake_up_interruptible(&so->wait);
+		return;
+	}
+
+	if (so->txfc.bs && so->tx.bs >= so->txfc.bs) {
+		/* stop and wait for FC with timeout */
+		so->tx.state = ISOTP_WAIT_FC;
+		hrtimer_start(&so->txtimer, ktime_set(1, 0),
+			      HRTIMER_MODE_REL_SOFT);
+		return;
+	}
+
+	/* no gap between data frames needed => use burst mode */
+	if (!so->tx_gap) {
+		isotp_send_cframe(so);
+		return;
+	}
+
+	/* start timer to send next consecutive frame with correct delay */
+	hrtimer_start(&so->txtimer, so->tx_gap, HRTIMER_MODE_REL_SOFT);
+}
+
 static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
 {
 	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
 					     txtimer);
 	struct sock *sk = &so->sk;
-	struct sk_buff *skb;
-	struct net_device *dev;
-	struct canfd_frame *cf;
 	enum hrtimer_restart restart = HRTIMER_NORESTART;
-	int can_send_ret;
-	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 
 	switch (so->tx.state) {
+	case ISOTP_SENDING:
+
+		/* cfecho should be consumed by isotp_rcv_echo() here */
+		if (!so->cfecho) {
+			/* start timeout for unlikely lost echo skb */
+			hrtimer_set_expires(&so->txtimer,
+					    ktime_add(ktime_get(),
+						      ktime_set(2, 0)));
+			restart = HRTIMER_RESTART;
+
+			/* push out the next consecutive frame */
+			isotp_send_cframe(so);
+			break;
+		}
+
+		/* cfecho has not been cleared in isotp_rcv_echo() */
+		pr_notice_once("can-isotp: cfecho %08X timeout\n", so->cfecho);
+		fallthrough;
+
 	case ISOTP_WAIT_FC:
 	case ISOTP_WAIT_FIRST_FC:
 
 		/* we did not get any flow control frame in time */
 
@@ -774,82 +886,10 @@ static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
 		/* reset tx state */
 		so->tx.state = ISOTP_IDLE;
 		wake_up_interruptible(&so->wait);
 		break;
 
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
-
-		can_skb_reserve(skb);
-		can_skb_prv(skb)->ifindex = dev->ifindex;
-		can_skb_prv(skb)->skbcnt = 0;
-
-		cf = (struct canfd_frame *)skb->data;
-		skb_put_zero(skb, so->ll.mtu);
-
-		/* create consecutive frame */
-		isotp_fill_dataframe(cf, so, ae, 0);
-
-		/* place consecutive frame N_PCI in appropriate index */
-		cf->data[ae] = N_PCI_CF | so->tx.sn++;
-		so->tx.sn %= 16;
-		so->tx.bs++;
-
-		cf->flags = so->ll.tx_flags;
-
-		skb->dev = dev;
-		can_skb_set_owner(skb, sk);
-
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
-
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
-
-		/* no gap between data frames needed => use burst mode */
-		if (!so->tx_gap)
-			goto isotp_tx_burst;
-
-		/* start timer to send next data frame with correct delay */
-		dev_put(dev);
-		hrtimer_set_expires(&so->txtimer,
-				    ktime_add(ktime_get(), so->tx_gap));
-		restart = HRTIMER_RESTART;
-		break;
-
 	default:
 		WARN_ON_ONCE(1);
 	}
 
 	return restart;
@@ -1073,10 +1113,13 @@ static int isotp_release(struct socket *sock)
 			dev = dev_get_by_index(net, so->ifindex);
 			if (dev) {
 				can_rx_unregister(net, dev, so->rxid,
 						  SINGLE_MASK(so->rxid),
 						  isotp_rcv, sk);
+				can_rx_unregister(net, dev, so->txid,
+						  SINGLE_MASK(so->txid),
+						  isotp_rcv_echo, sk);
 				dev_put(dev);
 				synchronize_rcu();
 			}
 		}
 	}
@@ -1159,25 +1202,37 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (!(dev->flags & IFF_UP))
 		notify_enetdown = 1;
 
 	ifindex = dev->ifindex;
 
-	if (do_rx_reg)
+	if (do_rx_reg) {
 		can_rx_register(net, dev, addr->can_addr.tp.rx_id,
 				SINGLE_MASK(addr->can_addr.tp.rx_id),
 				isotp_rcv, sk, "isotp", sk);
 
+		/* no consecutive frame echo skb in flight */
+		so->cfecho = 0;
+
+		/* register for echo skb's */
+		can_rx_register(net, dev, addr->can_addr.tp.tx_id,
+				SINGLE_MASK(addr->can_addr.tp.tx_id),
+				isotp_rcv_echo, sk, "isotpe", sk);
+	}
+
 	dev_put(dev);
 
 	if (so->bound && do_rx_reg) {
 		/* unregister old filter */
 		if (so->ifindex) {
 			dev = dev_get_by_index(net, so->ifindex);
 			if (dev) {
 				can_rx_unregister(net, dev, so->rxid,
 						  SINGLE_MASK(so->rxid),
 						  isotp_rcv, sk);
+				can_rx_unregister(net, dev, so->txid,
+						  SINGLE_MASK(so->txid),
+						  isotp_rcv_echo, sk);
 				dev_put(dev);
 			}
 		}
 	}
 
@@ -1379,14 +1434,18 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 		/* remove current filters & unregister */
-		if (so->bound && (!(so->opt.flags & CAN_ISOTP_SF_BROADCAST)))
+		if (so->bound && (!(so->opt.flags & CAN_ISOTP_SF_BROADCAST))) {
 			can_rx_unregister(dev_net(dev), dev, so->rxid,
 					  SINGLE_MASK(so->rxid),
 					  isotp_rcv, sk);
+			can_rx_unregister(dev_net(dev), dev, so->txid,
+					  SINGLE_MASK(so->txid),
+					  isotp_rcv_echo, sk);
+		}
 
 		so->ifindex = 0;
 		so->bound  = 0;
 		release_sock(sk);
 
-- 
2.30.2

