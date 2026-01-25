Return-Path: <linux-can+bounces-6301-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNspMqJ6dmlLRAEAu9opvQ
	(envelope-from <linux-can+bounces-6301-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 21:18:42 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4AC825A4
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 21:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F4237301179A
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 20:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C920C30149F;
	Sun, 25 Jan 2026 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XZelSpQ7";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="L89ndZk+"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90612199E89;
	Sun, 25 Jan 2026 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769372278; cv=pass; b=REmwtxiZIkJPPtPV3I59+60Ci7cK0uMPDhsyFYFA8/pv/KtaLmcFK/dljR+cyEYA/+YsGX6F3FXOn4IsnY+QEgvUuSWIvRhNsOwwZ7aF1vv5xiIe/4gS+5bHIMoqyME4aEzMnFrm8IQfmzaN4AT+g+Qp5QXuNr75N/vIYFNQdMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769372278; c=relaxed/simple;
	bh=sv5wvpUMC0bsGTt05EL2s2Lq8sihmGC1MMxcIg4w0l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDsmcfET+4MRv8NmjCVuMSw2Mxo3yHyVKON750ybgkB9CztpvIGg60IYG38zY9BSp5qOJV9r4IBBcB5s7Xh5ZLp+U30zYHLJ0v3QC3NCGPH27efR989ZOl+razqc7Afyej5oeFX0WJAhDT/rW/6sjeNfN/5VkUVsYAziPZDYIFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XZelSpQ7; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=L89ndZk+; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769372268; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HLXW7Y6pHztlcjVsqJOGAxill1+q8Gd3jEMsdARhMLXQXFZeXTa7G98R1mJ3N5Vtgi
    gLfTkpi8b6ahf7Na1rM52XuUPctvu2qzxwWyiI8rs31m7oVekBuji+CMY+9oubXy1d2b
    gFIX2Z15b/cWlvvR+HKy9rURoMOKPmicZTCIoNkjaA3YMhHjsnKg/q62ElUSn5lq9JLd
    IWsIN/MV+vJIcfWFjDzymOcr38K5UI9LR19RqQvGidfpPejBwwneguo4DXerYny4qvjT
    8Ja1pyJqyqr2YkKw2qvCoVvYM6Af6uQ/9KAhVBGBueqCwGyT3g0XzC7FWH0AuPVMnd2U
    l4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769372268;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TYU/PutsEPnY0fWHpsz8SArK1d2gYcwMoow1MD9b8zU=;
    b=X3CqH+LZfhrsoSsp9dx1yjkXhutk4RTfWT2baYO2MGyErDSfETRPRnczI6a9igLjn3
    maP7C8sQ6URva1SHYyQeNHyWh8vFj4BYlKIjwjQSNXT0VjNTefBhlPKMuGBvzZ0erf+O
    bDPwIPFclrZuY1NXXPfDPK1qHJ4wtmC+maVv3sq5OSCM8esOR4UGA4gzEvsAT2JLUeHV
    ov+bpPP1pF6KXxf02tAhSW8G9mhv6BGOUS/K0FD5xYrAMK3cNZWQHrYBUn/oHbp1b3cU
    dh1/YmPiJL1V4kyg8Hz+Xiq/1ihb9rk79lKh+Rxnfmn/VYNGpr5WXLTjZvF4QleG6Bci
    3X/A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769372268;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TYU/PutsEPnY0fWHpsz8SArK1d2gYcwMoow1MD9b8zU=;
    b=XZelSpQ7XFIkM25Dt/6U3CzwI+quOt7CZjGMMzUKsvYT8Okg1dh+quAkB4X5arzeJs
    0P8wgJuQHUi7fM7adJkifBM6coscYFt6Alpumusj6SmNav+EB4puMDsxQ69uQi02bkIQ
    CnoLOS1yPQxqrPvfAMP1YsyIlfKcTE62NMqxZypFZ4xJg5eeBoftjyiHg5NBX7uJBDyr
    j3hlRdYwVHrTXAFhasFI0HyK4bhfYZeDedjuklEZL42qhhF7dgIHjjLJ9QfnU/XWLb/m
    lhYdFhMXs3NZjQIsyYv6H59TQ7/c0psxKdFUsRaLKqXjxYpJwFmjWGUuC+xU4WTGXje/
    lxqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769372268;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TYU/PutsEPnY0fWHpsz8SArK1d2gYcwMoow1MD9b8zU=;
    b=L89ndZk+cJ78lTdzdpEBxIOKBUw67ntp0bgQ9sPnv9sUbZ36OxeSrqYxw45sdeB6MO
    YZ3zR72qDr/qnG7jcbDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s1YTqptmo87qzm6sElmZEI+VN6rw=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20PKHmYsW
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 25 Jan 2026 21:17:48 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: netdev@vger.kernel.org,
	linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [net-next 5/6] can: remove private CAN skb headroom infrastructure
Date: Sun, 25 Jan 2026 21:16:00 +0100
Message-ID: <20260125201601.5018-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260125201601.5018-1-socketcan@hartkopp.net>
References: <20260125201601.5018-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_FROM(0.00)[bounces-6301-lists,linux-can=lfdr.de];
	TAGGED_RCPT(0.00)[linux-can];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[hartkopp.net:+]
X-Rspamd-Queue-Id: 3B4AC825A4
X-Rspamd-Action: no action

This patch removes struct can_skb_priv which was stored at skb->head and
the can_skb_reserve() helper which was used to shift skb->head.

Patch 5/6 to remove the private CAN bus skb headroom infrastructure.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/skb.c | 31 +++++++++----------------------
 include/linux/can/skb.h   | 31 -------------------------------
 net/can/bcm.c             |  7 ++-----
 net/can/isotp.c           | 12 ++++--------
 net/can/j1939/socket.c    |  4 +---
 net/can/j1939/transport.c |  7 ++-----
 net/can/raw.c             |  4 +---
 7 files changed, 19 insertions(+), 77 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 408ee49abce1..95fcdc1026f8 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -204,40 +204,33 @@ void can_free_echo_skb(struct net_device *dev, unsigned int idx,
 	}
 }
 EXPORT_SYMBOL_GPL(can_free_echo_skb);
 
 /* fill common values for CAN sk_buffs */
-static void init_can_skb_reserve(struct sk_buff *skb)
+static void init_can_skb(struct sk_buff *skb)
 {
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
-
-	skb_reset_mac_header(skb);
-	skb_reset_network_header(skb);
-	skb_reset_transport_header(skb);
-
-	can_skb_reserve(skb);
 }
 
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 {
 	struct sk_buff *skb;
 	struct can_skb_ext *csx;
 
-	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
-			       sizeof(struct can_frame));
+	skb = netdev_alloc_skb(dev, sizeof(struct can_frame));
 	if (unlikely(!skb))
 		goto out_error_cc;
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		goto out_error_cc;
 	}
 
 	skb->protocol = htons(ETH_P_CAN);
-	init_can_skb_reserve(skb);
+	init_can_skb(skb);
 	csx->can_iif = dev->ifindex;
 
 	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
 	return skb;
@@ -253,23 +246,22 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 				struct canfd_frame **cfd)
 {
 	struct sk_buff *skb;
 	struct can_skb_ext *csx;
 
-	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
-			       sizeof(struct canfd_frame));
+	skb = netdev_alloc_skb(dev, sizeof(struct canfd_frame));
 	if (unlikely(!skb))
 		goto out_error_fd;
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		goto out_error_fd;
 	}
 
 	skb->protocol = htons(ETH_P_CANFD);
-	init_can_skb_reserve(skb);
+	init_can_skb(skb);
 	csx->can_iif = dev->ifindex;
 
 	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
 
 	/* set CAN FD flag by default */
@@ -292,23 +284,22 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 	struct can_skb_ext *csx;
 
 	if (data_len < CANXL_MIN_DLEN || data_len > CANXL_MAX_DLEN)
 		goto out_error_xl;
 
-	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
-			       CANXL_HDR_SIZE + data_len);
+	skb = netdev_alloc_skb(dev, CANXL_HDR_SIZE + data_len);
 	if (unlikely(!skb))
 		goto out_error_xl;
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		goto out_error_xl;
 	}
 
 	skb->protocol = htons(ETH_P_CANXL);
-	init_can_skb_reserve(skb);
+	init_can_skb(skb);
 	csx->can_iif = dev->ifindex;
 
 	*cxl = skb_put_zero(skb, CANXL_HDR_SIZE + data_len);
 
 	/* set CAN XL flag and length information by default */
@@ -338,18 +329,14 @@ struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
 	return skb;
 }
 EXPORT_SYMBOL_GPL(alloc_can_err_skb);
 
 /* Check for outgoing skbs that have not been created by the CAN subsystem */
-static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
+static bool can_skb_init_valid(struct net_device *dev, struct sk_buff *skb)
 {
 	struct can_skb_ext *csx = can_skb_ext_find(skb);
 
-	/* af_packet creates a headroom of HH_DATA_MOD bytes which is fine */
-	if (WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct can_skb_priv)))
-		return false;
-
 	/* af_packet does not apply CAN skb specific settings */
 	if (skb->ip_summed == CHECKSUM_NONE || !csx) {
 		/* init CAN skb content */
 		if (!csx) {
 			csx = can_skb_ext_add(skb);
@@ -403,11 +390,11 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 
 	default:
 		goto inval_skb;
 	}
 
-	if (!can_skb_headroom_valid(dev, skb))
+	if (!can_skb_init_valid(dev, skb))
 		goto inval_skb;
 
 	return false;
 
 inval_skb:
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index aeb08f47de48..cacbbb185bb9 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -36,41 +36,10 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
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
- * @ifindex:	ifindex of the first interface the CAN frame appeared on
- * @frame_len:	length of CAN frame in data link layer
- * @cf:		align to the following CAN frame at skb->data
- */
-struct can_skb_priv {
-	int ifindex;
-	unsigned int frame_len;
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
 static inline struct can_skb_ext *can_skb_ext_add(struct sk_buff *skb)
 {
 	return skb_ext_add(skb, SKB_EXT_CAN);
 }
 
diff --git a/net/can/bcm.c b/net/can/bcm.c
index f102d17e8619..b7324e9c955b 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -310,21 +310,20 @@ static void bcm_can_tx(struct bcm_op *op)
 	if (!dev) {
 		/* RFC: should this bcm_op remove itself here? */
 		return;
 	}
 
-	skb = alloc_skb(op->cfsiz + sizeof(struct can_skb_priv), gfp_any());
+	skb = alloc_skb(op->cfsiz, gfp_any());
 	if (!skb)
 		goto out;
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		goto out;
 	}
 
-	can_skb_reserve(skb);
 	csx->can_iif = dev->ifindex;
 
 	skb_put_data(skb, cf, op->cfsiz);
 
 	/* send with loopback */
@@ -1331,22 +1330,20 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 
 	/* we need a real device to send frames */
 	if (!ifindex)
 		return -ENODEV;
 
-	skb = alloc_skb(cfsiz + sizeof(struct can_skb_priv), GFP_KERNEL);
+	skb = alloc_skb(cfsiz, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		return -ENOMEM;
 	}
 
-	can_skb_reserve(skb);
-
 	err = memcpy_from_msg(skb_put(skb, cfsiz), msg, cfsiz);
 	if (err < 0) {
 		kfree_skb(skb);
 		return err;
 	}
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 01ceb3febbb7..434986cc8fe5 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -218,11 +218,11 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 	struct can_skb_ext *csx;
 	struct canfd_frame *ncf;
 	struct isotp_sock *so = isotp_sk(sk);
 	int can_send_ret;
 
-	nskb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv), gfp_any());
+	nskb = alloc_skb(so->ll.mtu, gfp_any());
 	if (!nskb)
 		return 1;
 
 	csx = can_skb_ext_add(nskb);
 	if (!csx) {
@@ -234,13 +234,11 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 	if (!dev) {
 		kfree_skb(nskb);
 		return 1;
 	}
 
-	can_skb_reserve(nskb);
 	csx->can_iif = dev->ifindex;
-
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
 	ncf = (struct canfd_frame *)nskb->data;
 	skb_put_zero(nskb, so->ll.mtu);
 
@@ -778,11 +776,11 @@ static void isotp_send_cframe(struct isotp_sock *so)
 
 	dev = dev_get_by_index(sock_net(sk), so->ifindex);
 	if (!dev)
 		return;
 
-	skb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv), GFP_ATOMIC);
+	skb = alloc_skb(so->ll.mtu, GFP_ATOMIC);
 	if (!skb) {
 		dev_put(dev);
 		return;
 	}
 
@@ -791,11 +789,10 @@ static void isotp_send_cframe(struct isotp_sock *so)
 		kfree_skb(skb);
 		dev_put(dev);
 		return;
 	}
 
-	can_skb_reserve(skb);
 	csx->can_iif = dev->ifindex;
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
@@ -1013,12 +1010,12 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (!dev) {
 		err = -ENXIO;
 		goto err_out_drop;
 	}
 
-	skb = sock_alloc_send_skb(sk, so->ll.mtu + sizeof(struct can_skb_priv),
-				  msg->msg_flags & MSG_DONTWAIT, &err);
+	skb = sock_alloc_send_skb(sk, so->ll.mtu, msg->msg_flags & MSG_DONTWAIT,
+				  &err);
 	if (!skb) {
 		dev_put(dev);
 		goto err_out_drop;
 	}
 
@@ -1027,11 +1024,10 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		kfree_skb(skb);
 		dev_put(dev);
 		goto err_out_drop;
 	}
 
-	can_skb_reserve(skb);
 	csx->can_iif = dev->ifindex;
 
 	so->tx.len = size;
 	so->tx.idx = 0;
 
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index f03bae79354e..10014d95c319 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -889,23 +889,21 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
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
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		goto failure;
 	}
 
-	can_skb_reserve(skb);
 	csx->can_iif = ndev->ifindex;
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (ret < 0)
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 96e02ad4a726..e63cf79af1c4 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -593,23 +593,21 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 {
 	struct sk_buff *skb;
 	struct can_skb_ext *csx;
 	struct j1939_sk_buff_cb *skcb;
 
-	skb = alloc_skb(sizeof(struct can_frame) + sizeof(struct can_skb_priv),
-			GFP_ATOMIC);
+	skb = alloc_skb(sizeof(struct can_frame), GFP_ATOMIC);
 	if (unlikely(!skb))
 		return ERR_PTR(-ENOMEM);
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		return ERR_PTR(-ENOMEM);
 	}
 
 	skb->dev = priv->ndev;
-	can_skb_reserve(skb);
 	csx->can_iif = priv->ndev->ifindex;
 	/* reserve CAN header */
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	/* skb->cb must be large enough to hold a j1939_sk_buff_cb structure */
@@ -1535,22 +1533,21 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	struct sk_buff *skb;
 	struct can_skb_ext *csx;
 	struct j1939_sk_buff_cb *skcb;
 	struct j1939_session *session;
 
-	skb = alloc_skb(size + sizeof(struct can_skb_priv), GFP_ATOMIC);
+	skb = alloc_skb(size, GFP_ATOMIC);
 	if (unlikely(!skb))
 		return NULL;
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		return NULL;
 	}
 
 	skb->dev = priv->ndev;
-	can_skb_reserve(skb);
 	csx->can_iif = priv->ndev->ifindex;
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
 
 	session = j1939_session_new(priv, skb, size);
diff --git a/net/can/raw.c b/net/can/raw.c
index e26cda398e22..2b4a238d2590 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -951,22 +951,20 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (can_cap_enabled(dev, CAN_CAP_RO)) {
 		err = -EACCES;
 		goto put_dev;
 	}
 
-	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
-				  msg->msg_flags & MSG_DONTWAIT, &err);
+	skb = sock_alloc_send_skb(sk, size, msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		goto put_dev;
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		goto put_dev;
 	}
 
-	can_skb_reserve(skb);
 	csx->can_iif = dev->ifindex;
 
 	/* fill the skb before testing for valid CAN frames */
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)
-- 
2.47.3


