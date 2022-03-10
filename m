Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EAD4D4B73
	for <lists+linux-can@lfdr.de>; Thu, 10 Mar 2022 16:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244099AbiCJOcs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Mar 2022 09:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343947AbiCJOba (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Mar 2022 09:31:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0435B82EA
        for <linux-can@vger.kernel.org>; Thu, 10 Mar 2022 06:29:08 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nSJmt-0005ny-40
        for linux-can@vger.kernel.org; Thu, 10 Mar 2022 15:29:07 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 102A747D65
        for <linux-can@vger.kernel.org>; Thu, 10 Mar 2022 14:29:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 659D547D5A;
        Thu, 10 Mar 2022 14:29:05 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 93cb2fa4;
        Thu, 10 Mar 2022 14:29:04 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 01/29] can: isotp: add local echo tx processing for consecutive frames
Date:   Thu, 10 Mar 2022 15:28:35 +0100
Message-Id: <20220310142903.341658-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310142903.341658-1-mkl@pengutronix.de>
References: <20220310142903.341658-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

Instead of dumping the CAN frames into the netdevice queue the process to
transmit consecutive frames (CF) now waits for the frame to be transmitted
and therefore echo'ed from the CAN interface.

Link: https://lore.kernel.org/all/20220309120416.83514-1-socketcan@hartkopp.net
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 219 ++++++++++++++++++++++++++++++------------------
 1 file changed, 139 insertions(+), 80 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index d2a430b6a13b..d59f1758ac9c 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -14,7 +14,6 @@
  * - use CAN_ISOTP_WAIT_TX_DONE flag to block the caller until the PDU is sent
  * - as we have static buffers the check whether the PDU fits into the buffer
  *   is done at FF reception time (no support for sending 'wait frames')
- * - take care of the tx-queue-len as traffic shaping is still on the TODO list
  *
  * Copyright (c) 2020 Volkswagen Group Electronic Research
  * All rights reserved.
@@ -143,6 +142,7 @@ struct isotp_sock {
 	struct can_isotp_ll_options ll;
 	u32 force_tx_stmin;
 	u32 force_rx_stmin;
+	u32 cfecho; /* consecutive frame echo tag */
 	struct tpcon rx, tx;
 	struct list_head notifier;
 	wait_queue_head_t wait;
@@ -712,6 +712,63 @@ static void isotp_fill_dataframe(struct canfd_frame *cf, struct isotp_sock *so,
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
@@ -748,19 +805,74 @@ static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
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
 
@@ -776,78 +888,6 @@ static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
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
@@ -1075,6 +1115,9 @@ static int isotp_release(struct socket *sock)
 				can_rx_unregister(net, dev, so->rxid,
 						  SINGLE_MASK(so->rxid),
 						  isotp_rcv, sk);
+				can_rx_unregister(net, dev, so->txid,
+						  SINGLE_MASK(so->txid),
+						  isotp_rcv_echo, sk);
 				dev_put(dev);
 				synchronize_rcu();
 			}
@@ -1161,11 +1204,20 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 
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
@@ -1176,6 +1228,9 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 				can_rx_unregister(net, dev, so->rxid,
 						  SINGLE_MASK(so->rxid),
 						  isotp_rcv, sk);
+				can_rx_unregister(net, dev, so->txid,
+						  SINGLE_MASK(so->txid),
+						  isotp_rcv_echo, sk);
 				dev_put(dev);
 			}
 		}
@@ -1381,10 +1436,14 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
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

base-commit: 3126b731ceb168b3a780427873c417f2abdd5527
-- 
2.35.1


