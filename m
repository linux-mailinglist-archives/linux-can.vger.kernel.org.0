Return-Path: <linux-can+bounces-6108-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB27D13A45
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 16:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F17D2300661D
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 15:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9928E2DFA31;
	Mon, 12 Jan 2026 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="OSVtdul0";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="geMU9FXN"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D051EEA3C;
	Mon, 12 Jan 2026 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230780; cv=pass; b=Zm/oGdADNRJYLS3WKqt1IOSSwDkRk2YxBTpLN1Rx4ep3vl7ASN8xB8NfPQEC4CW0jGWonrl7AZoGbAw6exIPoElIlONkBcgJvqNT5Gh93wzrkjebtJxt2DhoZ9y/Gj0fcM3x/g2Y/rqJPMplV8uGeQ/Hzbgbe6LHglVNNp8RH6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230780; c=relaxed/simple;
	bh=vGnJZp2arPa7uRQ9dIh2Jos5YWP/t57/wx3ml2zaLyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAnQnLimqP8m0nlv8q9RZx6ZQM0SqRCBqdhUlpWgukGf7HutFfiawfskzDirHLh2f8jRNF3AmS+Z7rJ4H9RFmhg8D1qbnkUbETNdMXe9IPaE/WUernBND7Q+xvqBRqvI1U9GlBTlTeMaNxfjWXqLMOh2yL7nsFRBJRYIPCaLcb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OSVtdul0; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=geMU9FXN; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768230593; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Y528/tccQo9dcLCGk10xXcYGUODMQ7G43HOW7iPBP8f9AqiBmw+3gkd4gNKLMMcsyc
    LPJPzGeM83QFl7gYwg8J8pimuO53JwFa1sSJueewiood06Wh8gEvrNwrNERZEamkjISK
    AwNwH+Hf7gf1KVkWhge81uMq9PjduLeZcUMO74Ld/zbTmGD/BBsh8HWv1eTW2tCsE1Qk
    L49MS/I2NZ70iClDJBP0X1ABOY3uTWdeFP6sZDY+QXA+lR8Irw9TQqKz06fpu/72feRU
    /VbyAkZ5TmRxxuCQGeM1Ixu34/WI9Gupoy6wHK+NX1ve03LvAjGLIqvbG+s/8ESdpNgi
    MBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768230593;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HpURo70hBcHoFziepdrgp5zpqlPgtpsT/rs8iC0cQ5E=;
    b=HFUt6hJLbTL8ixEvLGUOIg/7M03cnVnapDLTIMTgl3d9QMUDJIquIBgiRfIM7n/M09
    mVJ8+SrV6CUvyWaXsDvAf2veT9cIZ8hMp9XOkxDvu1b5N9+hYzQYqKAbvMdpkdmQD3OG
    fjJLM1jgTq0Pp/6sIAzC4lL4umZfXCxaVvnEfaUp8eCEXhvQxHhfdJkP9WyJDNEjJMD7
    Y0tvucUbA0Ss1nFVjKNE7yrY6u8QBg/be7KFjPxhJvI+UJIhi/vKtGbg0HqENT5z/cBo
    8BXK03plsXkJ9GYD1OxyRpigTHXt3XQFhgfhK6yO0J3FAF6nrBk8QcfqQrw9eBqBNb75
    Bufw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768230593;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HpURo70hBcHoFziepdrgp5zpqlPgtpsT/rs8iC0cQ5E=;
    b=OSVtdul0j4kqFdqZVPhK7aBFV/VLseTb25mqRr+U2ZdmdM+HMgQRTQYEMNP0qeP6ek
    2xnDKE7+z9iMlJRvm1GyzyT8gnJaBg5Gzp/dOraxccXN/QejqlufDhAI5E8heyTojvIF
    McI4Vk6g3ZIUU2FdskivHVhUKvExVbhZiAFIq/kBSzQwzOMIZaHUfXJs6ohif3A0wYfN
    oyuiM+SWa4qT/tw87ZOEOTj2Ckaz55jIlFpXl0SWQoISzaUhZLFfZNek5b9cETHy/wVA
    2Q49JElyYIDTuqCRSXcv3fZg1r03qrehwLX6sV8+joIUtoJIk6TN9escnzgm5cmpNvye
    WbIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768230593;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HpURo70hBcHoFziepdrgp5zpqlPgtpsT/rs8iC0cQ5E=;
    b=geMU9FXN9orE+9bd/LgId6kjdFxkQdSd/sVjl96fxUt7wMDm5822ZKj7pl82P/r2Qr
    pzTUjbGtfPMwYVHy84Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20CF9rgmF
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Jan 2026 16:09:53 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [can-next 4/5] can: remove private skb headroom infrastructure
Date: Mon, 12 Jan 2026 16:09:07 +0100
Message-ID: <20260112150908.5815-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112150908.5815-1-socketcan@hartkopp.net>
References: <20260112150908.5815-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This patch removes the now-empty private CAN skb headroom infrastructure.

Patch 4/5 to remove the private CAN bus skb headroom infrastructure.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/skb.c | 27 +++++++++++----------------
 include/linux/can/skb.h   | 28 ----------------------------
 net/can/bcm.c             |  7 ++-----
 net/can/isotp.c           |  9 +++------
 net/can/j1939/socket.c    |  4 +---
 net/can/j1939/transport.c |  7 ++-----
 net/can/raw.c             |  5 ++---
 7 files changed, 21 insertions(+), 66 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index ffd71ad0252a..2445f6c9f9d4 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -188,36 +188,33 @@ void can_free_echo_skb(struct net_device *dev, unsigned int idx,
 	}
 }
 EXPORT_SYMBOL_GPL(can_free_echo_skb);
 
 /* fill common values for CAN sk_buffs */
-static void init_can_skb_reserve(struct sk_buff *skb)
+static void init_can_skb(struct sk_buff *skb)
 {
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 	skb_reset_mac_header(skb);
 	skb_reset_network_header(skb);
 	skb_reset_transport_header(skb);
-
-	can_skb_reserve(skb);
 }
 
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 {
 	struct sk_buff *skb;
 
-	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
-			       sizeof(struct can_frame));
+	skb = netdev_alloc_skb(dev, sizeof(struct can_frame));
 	if (unlikely(!skb)) {
 		*cf = NULL;
 
 		return NULL;
 	}
 
 	skb->protocol = htons(ETH_P_CAN);
-	init_can_skb_reserve(skb);
+	init_can_skb(skb);
 	skb->can_iif = dev->ifindex;
 
 	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
 	return skb;
@@ -227,20 +224,19 @@ EXPORT_SYMBOL_GPL(alloc_can_skb);
 struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 				struct canfd_frame **cfd)
 {
 	struct sk_buff *skb;
 
-	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
-			       sizeof(struct canfd_frame));
+	skb = netdev_alloc_skb(dev, sizeof(struct canfd_frame));
 	if (unlikely(!skb)) {
 		*cfd = NULL;
 
 		return NULL;
 	}
 
 	skb->protocol = htons(ETH_P_CANFD);
-	init_can_skb_reserve(skb);
+	init_can_skb(skb);
 	skb->can_iif = dev->ifindex;
 
 	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
 
 	/* set CAN FD flag by default */
@@ -257,17 +253,16 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 	struct sk_buff *skb;
 
 	if (data_len < CANXL_MIN_DLEN || data_len > CANXL_MAX_DLEN)
 		goto out_error;
 
-	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
-			       CANXL_HDR_SIZE + data_len);
+	skb = netdev_alloc_skb(dev, CANXL_HDR_SIZE + data_len);
 	if (unlikely(!skb))
 		goto out_error;
 
 	skb->protocol = htons(ETH_P_CANXL);
-	init_can_skb_reserve(skb);
+	init_can_skb(skb);
 	skb->can_iif = dev->ifindex;
 
 	*cxl = skb_put_zero(skb, CANXL_HDR_SIZE + data_len);
 
 	/* set CAN XL flag and length information by default */
@@ -297,14 +292,14 @@ struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
 	return skb;
 }
 EXPORT_SYMBOL_GPL(alloc_can_err_skb);
 
 /* Check for outgoing skbs that have not been created by the CAN subsystem */
-static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
+static bool can_skb_init_valid(struct net_device *dev, struct sk_buff *skb)
 {
-	/* af_packet creates a headroom of HH_DATA_MOD bytes which is fine */
-	if (WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct can_skb_priv)))
+	/* skb with inner protocols do not contain CAN content */
+	if (skb->encapsulation)
 		return false;
 
 	/* af_packet does not apply CAN skb specific settings */
 	if (skb->ip_summed == CHECKSUM_NONE) {
 		/* init headroom */
@@ -355,11 +350,11 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 
 	default:
 		goto inval_skb;
 	}
 
-	if (!can_skb_headroom_valid(dev, skb))
+	if (!can_skb_init_valid(dev, skb))
 		goto inval_skb;
 
 	return false;
 
 inval_skb:
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index eba9557e2c1e..c5d617a0f9be 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -35,38 +35,10 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 				unsigned int data_len);
 struct sk_buff *alloc_can_err_skb(struct net_device *dev,
 				  struct can_frame **cf);
 bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb);
 
-/*
- * The struct can_skb_priv is used to transport additional information along
- * with the stored struct can(fd)_frame that can not be contained in existing
- * struct sk_buff elements.
- * N.B. that this information must not be modified in cloned CAN sk_buffs.
- * To modify the CAN frame content or the struct can_skb_priv content
- * skb_copy() needs to be used instead of skb_clone().
- */
-
-/**
- * struct can_skb_priv - private additional data inside CAN sk_buffs
- * @cf:		align to the following CAN frame at skb->data
- */
-struct can_skb_priv {
-	unsigned int frame_len_to_be_removed;
-	struct can_frame cf[];
-};
-
-static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
-{
-	return (struct can_skb_priv *)(skb->head);
-}
-
-static inline void can_skb_reserve(struct sk_buff *skb)
-{
-	skb_reserve(skb, sizeof(struct can_skb_priv));
-}
-
 static inline void can_skb_set_owner(struct sk_buff *skb, struct sock *sk)
 {
 	/* If the socket has already been closed by user space, the
 	 * refcount may already be 0 (and the socket will be freed
 	 * after the last TX skb has been freed). So only increase
diff --git a/net/can/bcm.c b/net/can/bcm.c
index a8867e7b77d2..99dac9af2b86 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -308,15 +308,14 @@ static void bcm_can_tx(struct bcm_op *op)
 	if (!dev) {
 		/* RFC: should this bcm_op remove itself here? */
 		return;
 	}
 
-	skb = alloc_skb(op->cfsiz + sizeof(struct can_skb_priv), gfp_any());
+	skb = alloc_skb(op->cfsiz, gfp_any());
 	if (!skb)
 		goto out;
 
-	can_skb_reserve(skb);
 	skb->can_iif = dev->ifindex;
 
 	skb_put_data(skb, cf, op->cfsiz);
 
 	/* send with loopback */
@@ -1322,16 +1321,14 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 
 	/* we need a real device to send frames */
 	if (!ifindex)
 		return -ENODEV;
 
-	skb = alloc_skb(cfsiz + sizeof(struct can_skb_priv), GFP_KERNEL);
+	skb = alloc_skb(cfsiz, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
-	can_skb_reserve(skb);
-
 	err = memcpy_from_msg(skb_put(skb, cfsiz), msg, cfsiz);
 	if (err < 0) {
 		kfree_skb(skb);
 		return err;
 	}
diff --git a/net/can/isotp.c b/net/can/isotp.c
index e7623e5736ca..3486d558b3c0 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -216,21 +216,20 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 	struct sk_buff *nskb;
 	struct canfd_frame *ncf;
 	struct isotp_sock *so = isotp_sk(sk);
 	int can_send_ret;
 
-	nskb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv), gfp_any());
+	nskb = alloc_skb(so->ll.mtu, gfp_any());
 	if (!nskb)
 		return 1;
 
 	dev = dev_get_by_index(sock_net(sk), so->ifindex);
 	if (!dev) {
 		kfree_skb(nskb);
 		return 1;
 	}
 
-	can_skb_reserve(nskb);
 	nskb->can_iif = dev->ifindex;
 
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
 	ncf = (struct canfd_frame *)nskb->data;
@@ -769,17 +768,16 @@ static void isotp_send_cframe(struct isotp_sock *so)
 
 	dev = dev_get_by_index(sock_net(sk), so->ifindex);
 	if (!dev)
 		return;
 
-	skb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv), GFP_ATOMIC);
+	skb = alloc_skb(so->ll.mtu, GFP_ATOMIC);
 	if (!skb) {
 		dev_put(dev);
 		return;
 	}
 
-	can_skb_reserve(skb);
 	skb->can_iif = dev->ifindex;
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
@@ -996,18 +994,17 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (!dev) {
 		err = -ENXIO;
 		goto err_out_drop;
 	}
 
-	skb = sock_alloc_send_skb(sk, so->ll.mtu + sizeof(struct can_skb_priv),
+	skb = sock_alloc_send_skb(sk, so->ll.mtu,
 				  msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb) {
 		dev_put(dev);
 		goto err_out_drop;
 	}
 
-	can_skb_reserve(skb);
 	skb->can_iif = dev->ifindex;
 
 	so->tx.len = size;
 	so->tx.idx = 0;
 
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index d2642d86b4a9..f7d0b3c4aeb4 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -887,17 +887,15 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 	int ret;
 
 	skb = sock_alloc_send_skb(sk,
 				  size +
 				  sizeof(struct can_frame) -
-				  sizeof(((struct can_frame *)NULL)->data) +
-				  sizeof(struct can_skb_priv),
+				  sizeof(((struct can_frame *)NULL)->data),
 				  msg->msg_flags & MSG_DONTWAIT, &ret);
 	if (!skb)
 		goto failure;
 
-	can_skb_reserve(skb);
 	skb->can_iif = ndev->ifindex;
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (ret < 0)
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8a767b75194f..53308755a0c2 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -591,17 +591,15 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 			     bool swap_src_dst)
 {
 	struct sk_buff *skb;
 	struct j1939_sk_buff_cb *skcb;
 
-	skb = alloc_skb(sizeof(struct can_frame) + sizeof(struct can_skb_priv),
-			GFP_ATOMIC);
+	skb = alloc_skb(sizeof(struct can_frame), GFP_ATOMIC);
 	if (unlikely(!skb))
 		return ERR_PTR(-ENOMEM);
 
 	skb->dev = priv->ndev;
-	can_skb_reserve(skb);
 	skb->can_iif = priv->ndev->ifindex;
 	/* reserve CAN header */
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	/* skb->cb must be large enough to hold a j1939_sk_buff_cb structure */
@@ -1526,16 +1524,15 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 {
 	struct sk_buff *skb;
 	struct j1939_sk_buff_cb *skcb;
 	struct j1939_session *session;
 
-	skb = alloc_skb(size + sizeof(struct can_skb_priv), GFP_ATOMIC);
+	skb = alloc_skb(size, GFP_ATOMIC);
 	if (unlikely(!skb))
 		return NULL;
 
 	skb->dev = priv->ndev;
-	can_skb_reserve(skb);
 	skb->can_iif = priv->ndev->ifindex;
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
 
 	session = j1939_session_new(priv, skb, size);
diff --git a/net/can/raw.c b/net/can/raw.c
index 21432e5567fa..c8cbbcecbfed 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -947,16 +947,15 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	/* no sending on a CAN device in read-only mode */
 	if (can_cap_enabled(dev, CAN_CAP_RO))
 		return -EACCES;
 
-	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
-				  msg->msg_flags & MSG_DONTWAIT, &err);
+	skb = sock_alloc_send_skb(sk, size, msg->msg_flags & MSG_DONTWAIT,
+				  &err);
 	if (!skb)
 		goto put_dev;
 
-	can_skb_reserve(skb);
 	skb->can_iif = dev->ifindex;
 
 	/* fill the skb before testing for valid CAN frames */
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)
-- 
2.47.3


