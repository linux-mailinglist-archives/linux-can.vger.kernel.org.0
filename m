Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AA551E6BA
	for <lists+linux-can@lfdr.de>; Sat,  7 May 2022 13:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446299AbiEGMAC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 7 May 2022 08:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiEGMAB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 7 May 2022 08:00:01 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB94C165A7
        for <linux-can@vger.kernel.org>; Sat,  7 May 2022 04:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1651924570;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=1qpFcrHbeNhWJurZtplP4jBCgdsJAdad6OK11es09Os=;
    b=U+Rh+iSA78kbOubNHdyBABWFBYw2rM9nNTWKrYrots5kVSN+TBKyBulP3ktyuUioWr
    q5NuSAI/ZaEz3vaNcAFkd4cAQWLNkwNBuRlJ6+kRwWILFy7FnBf5PAIyUeImlZZ5mkco
    +tSuOJGQxzZUSjOPmvz/THBRkA5zAz2yFv9cn/6jhUUaS9VKSRB+VinqSbEGs/Sizgvn
    YxL4Spwi6x7YBs2oZNWsSfLFNI7G0h4jmtDZL1JiBtEMq6NKg+Wd/7YHGdtHz+q4R3f+
    tMJHbWn3TdCXfv+iZPYxlbn1yME11tms02huzwSPMR6qI6/6MNXoiaeANTWdS9TLmHdr
    p4Tw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JCKNKiWNaXpvraas"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.42.2 AUTH)
    with ESMTPSA id 4544c9y47BuAnGv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 7 May 2022 13:56:10 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next] can: isotp: add support for transmission without flow control
Date:   Sat,  7 May 2022 13:55:58 +0200
Message-Id: <20220507115558.19065-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Usually the ISO 15765-2 protocol is a point-to-point protocol to transfer
segmented PDUs to a dedicated receiver. This receiver sends a flow control
message to specify protocol options and timings (e.g. block size / STmin).

The so called functional addressing communication allows a 1:N
communication but is limited to a single frame length.

This new CAN_ISOTP_CF_BROADCAST allows an unconfirmed 1:N communication
with PDU length that would not fit into a single frame. This feature is
not covered by the ISO 15765-2 standard.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/isotp.h |  25 +++++----
 net/can/isotp.c                | 100 ++++++++++++++++++++++++++-------
 2 files changed, 92 insertions(+), 33 deletions(-)

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
index 35a1ae61744c..2caeeae8ec16 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -102,10 +102,11 @@ MODULE_ALIAS("can-proto-6");
 #define FF_PCI_SZ12 2	/* size of FirstFrame PCI including 12 bit FF_DL */
 #define FF_PCI_SZ32 6	/* size of FirstFrame PCI including 32 bit FF_DL */
 #define FC_CONTENT_SZ 3	/* flow control content size in byte (FS/BS/STmin) */
 
 #define ISOTP_CHECK_PADDING (CAN_ISOTP_CHK_PAD_LEN | CAN_ISOTP_CHK_PAD_DATA)
+#define ISOTP_ALL_BC_FLAGS (CAN_ISOTP_SF_BROADCAST | CAN_ISOTP_CF_BROADCAST)
 
 /* Flow Status given in FC frame */
 #define ISOTP_FC_CTS 0		/* clear to send */
 #define ISOTP_FC_WT 1		/* wait */
 #define ISOTP_FC_OVFLW 2	/* overflow */
@@ -157,10 +158,27 @@ static struct isotp_sock *isotp_busy_notifier;
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
+static bool isotp_register_txecho(struct isotp_sock *so)
+{
+	/* all modes but SF_BROADCAST register for tx echo skbs */
+	return (isotp_bc_flags(so) != CAN_ISOTP_SF_BROADCAST);
+}
+
 static enum hrtimer_restart isotp_rx_timer_handler(struct hrtimer *hrtimer)
 {
 	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
 					     rxtimer);
 	struct sock *sk = &so->sk;
@@ -801,11 +819,10 @@ static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
 	/* add first data bytes depending on ae */
 	for (i = ae + ff_pci_sz; i < so->tx.ll_dl; i++)
 		cf->data[i] = so->tx.buf[so->tx.idx++];
 
 	so->tx.sn = 1;
-	so->tx.state = ISOTP_WAIT_FIRST_FC;
 }
 
 static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 {
 	struct sock *sk = (struct sock *)data;
@@ -934,11 +951,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	/* take care of a potential SF_DL ESC offset for TX_DL > 8 */
 	off = (so->tx.ll_dl > CAN_MAX_DLEN) ? 1 : 0;
 
 	/* does the given data fit into a single frame for SF_BROADCAST? */
-	if ((so->opt.flags & CAN_ISOTP_SF_BROADCAST) &&
+	if ((isotp_bc_flags(so) == CAN_ISOTP_SF_BROADCAST) &&
 	    (size > so->tx.ll_dl - SF_PCI_SZ4 - ae - off)) {
 		err = -EINVAL;
 		goto err_out_drop;
 	}
 
@@ -998,16 +1015,45 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		wake_up_interruptible(&so->wait);
 
 		/* don't enable wait queue for a single frame transmission */
 		wait_tx_done = 0;
 	} else {
-		/* send first frame and wait for FC */
+		/* send first frame */
 
 		isotp_create_fframe(cf, so, ae);
 
-		/* start timeout for FC */
-		hrtimer_sec = 1;
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
+			/* cfecho should have been zero'ed by init */
+			if (so->cfecho)
+				pr_notice_once("can-isotp: no fc cfecho %08X\n",
+					       so->cfecho);
+
+			/* set consecutive frame echo tag */
+			so->cfecho = *(u32 *)cf->data;
+
+			/* switch directly to ISOTP_SENDING state */
+			so->tx.state = ISOTP_SENDING;
+
+			/* start timeout for unlikely lost echo skb */
+			hrtimer_sec = 2;
+		} else {
+			/* standard flow control check */
+			so->tx.state = ISOTP_WAIT_FIRST_FC;
+
+			/* start timeout for FC */
+			hrtimer_sec = 1;
+		}
+
 		hrtimer_start(&so->txtimer, ktime_set(hrtimer_sec, 0),
 			      HRTIMER_MODE_REL_SOFT);
 	}
 
 	/* send the first or only CAN frame */
@@ -1023,10 +1069,13 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 		/* no transmission -> no timeout monitoring */
 		if (hrtimer_sec)
 			hrtimer_cancel(&so->txtimer);
 
+		/* reset consecutive frame echo tag */
+		so->cfecho = 0;
+
 		goto err_out_drop;
 	}
 
 	if (wait_tx_done) {
 		/* wait for complete transmission of current pdu */
@@ -1118,19 +1167,21 @@ static int isotp_release(struct socket *sock)
 	spin_unlock(&isotp_notifier_lock);
 
 	lock_sock(sk);
 
 	/* remove current filters & unregister */
-	if (so->bound && (!(so->opt.flags & CAN_ISOTP_SF_BROADCAST))) {
+	if (so->bound && isotp_register_txecho(so)) {
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
 				can_rx_unregister(net, dev, so->txid,
 						  SINGLE_MASK(so->txid),
 						  isotp_rcv_echo, sk);
 				dev_put(dev);
 				synchronize_rcu();
@@ -1162,11 +1213,10 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	int ifindex;
 	struct net_device *dev;
 	canid_t tx_id, rx_id;
 	int err = 0;
 	int notify_enetdown = 0;
-	int do_rx_reg = 1;
 
 	if (len < ISOTP_MIN_NAMELEN)
 		return -EINVAL;
 
 	/* sanitize tx/rx CAN identifiers */
@@ -1190,16 +1240,12 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
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
@@ -1220,14 +1266,15 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (!(dev->flags & IFF_UP))
 		notify_enetdown = 1;
 
 	ifindex = dev->ifindex;
 
-	if (do_rx_reg) {
+	if (isotp_register_rxid(so))
 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
 				isotp_rcv, sk, "isotp", sk);
 
+	if (isotp_register_txecho(so)) {
 		/* no consecutive frame echo skb in flight */
 		so->cfecho = 0;
 
 		/* register for echo skb's */
 		can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
@@ -1292,10 +1339,19 @@ static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
 
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
@@ -1442,14 +1498,16 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 		/* remove current filters & unregister */
-		if (so->bound && (!(so->opt.flags & CAN_ISOTP_SF_BROADCAST))) {
-			can_rx_unregister(dev_net(dev), dev, so->rxid,
-					  SINGLE_MASK(so->rxid),
-					  isotp_rcv, sk);
+		if (so->bound && isotp_register_txecho(so)) {
+			if (isotp_register_rxid(so))
+				can_rx_unregister(dev_net(dev), dev, so->rxid,
+						  SINGLE_MASK(so->rxid),
+						  isotp_rcv, sk);
+
 			can_rx_unregister(dev_net(dev), dev, so->txid,
 					  SINGLE_MASK(so->txid),
 					  isotp_rcv_echo, sk);
 		}
 
-- 
2.30.2

