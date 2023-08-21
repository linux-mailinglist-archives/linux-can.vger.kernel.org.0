Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0DD782C66
	for <lists+linux-can@lfdr.de>; Mon, 21 Aug 2023 16:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjHUOq3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Aug 2023 10:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbjHUOq3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Aug 2023 10:46:29 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DABE7;
        Mon, 21 Aug 2023 07:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692629174; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=I1TpIIGr91ipPaWCXE8ultNor9nPzv+Qx2qo60ESMEmZxnb6QlGD1t9MCAmBUVkWsU
    da277VGixedQsmVhq7F1C1sW7H9KpsTPIJSBKRNyCZUmg6OWy5U8YdqoluQGUO3GeSsX
    NLqZfedIRy/U16ntGMgT/HUOWx+qvtSwP+br94it4hJt0R++oGfmtAJ7MuMBphHXTHRO
    Aa3qZW7VsfHrd11mn9tgQUpyQkRV9MI8R0Z8LfXfmc8wwLPfTLPHoTkf55IfjIqdmw0G
    m52bfN+oEKBDwRcP8qD1rWSn58cEjEW303cyzOTfUQDbH8RHuiFMkWh0m5KSN1FdDiBe
    C//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692629174;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ex9cVWZ2rWOuhDT3R/h8fa2ohi4PGlTH7ZxVbD9iUzU=;
    b=CNxHr3vb5YJd90fIMG7bJxnlNO3UlcsPmS7LSPF+JUWC3vJu89BJ4fyHO5teoCCNzg
    P77bto738xca/BzldmgZYyhUVidHTXiFyc0fjCXQ6/0FvOQ0SrruW+wdAocoH6kEd1+T
    BxYQMS6C/cEPOU8t9EAvsG3WyCgCE0lGjGOrbg/Sz1Tpe1KV6ClREJ5P4Tqym2iX5tH9
    2GarSQUoSYXcwnhJZLbHmJRFfhOXSD5+kkq/LpcuDrPvD/lrdYcumfTkjROPvTFbWBlN
    mSYE9ePcOliCbHn9q8+E3UyN+uR8gXrj9jOYVf9o4vTnOrds3idDTQsMFwEFrOIZIsgO
    8q6g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692629174;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ex9cVWZ2rWOuhDT3R/h8fa2ohi4PGlTH7ZxVbD9iUzU=;
    b=kcPyz0RBj53p/7r11RFJfyykvahS5/TuopppYNUXiShZnH+SkkcpBys57CmkmUSCwQ
    B8PMg/Cvm7suhT5II9KAvegqg15NLqNiCmuUlNPOmjsUiyl+kCy67gMQ6PLj/a+SU4Do
    VRLmhYGVeNNYU7U4aXO2eeN6f/FGXXVw/FOVmoiCgR/+PYrnn7DgvOhtZZ7x0cpNPnN/
    bDHFgI7oFZvZ0rkO9tmalpb+eIR/Kvs94uxVdYR8Q5kqgYDw7s/4yXbCe3SL3IS4AsSR
    VYCai+FZqocVMDRJyDJcWZWEteileNUw7XMhnOL+jGAd0vaeT34n2tMZccaxUz86cflB
    lhMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692629174;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ex9cVWZ2rWOuhDT3R/h8fa2ohi4PGlTH7ZxVbD9iUzU=;
    b=YIt/1Q1LkBJOVNcCbywiRLKlbM6zZWqQOs8OSwDeq5YjkuBuNnwrVU3X7Xr4Vh7TZy
    36s90Ytn/cwix2QqpTBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3cmcZPR3l4"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.8.1 AUTH)
    with ESMTPSA id K723f1z7LEkE0hN
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 21 Aug 2023 16:46:14 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
        edumazet@google.com, mkl@pengutronix.de
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [NET 1/2] can: isotp: fix support for transmission of SF without flow control
Date:   Mon, 21 Aug 2023 16:45:46 +0200
Message-Id: <20230821144547.6658-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230821144547.6658-1-socketcan@hartkopp.net>
References: <20230821144547.6658-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The original implementation had a very simple handling for single frame
transmissions as it just sent the single frame without a timeout handling.

With the new echo frame handling the echo frame was also introduced for
single frames but the former exception ('simple without timers') has been
maintained by accident. This leads to a 1 second timeout when closing the
socket and to an -ECOMM error when CAN_ISOTP_WAIT_TX_DONE is selected.

As the echo handling is always active (also for single frames) remove the
wrong extra condition for single frames.

Fixes: 9f39d36530e5 ("can: isotp: add support for transmission without flow control")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 99770ed28531..f02b5d3e4733 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -186,16 +186,10 @@ static bool isotp_register_rxid(struct isotp_sock *so)
 {
 	/* no broadcast modes => register rx_id for FC frame reception */
 	return (isotp_bc_flags(so) == 0);
 }
 
-static bool isotp_register_txecho(struct isotp_sock *so)
-{
-	/* all modes but SF_BROADCAST register for tx echo skbs */
-	return (isotp_bc_flags(so) != CAN_ISOTP_SF_BROADCAST);
-}
-
 static enum hrtimer_restart isotp_rx_timer_handler(struct hrtimer *hrtimer)
 {
 	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
 					     rxtimer);
 	struct sock *sk = &so->sk;
@@ -1207,11 +1201,11 @@ static int isotp_release(struct socket *sock)
 	spin_unlock(&isotp_notifier_lock);
 
 	lock_sock(sk);
 
 	/* remove current filters & unregister */
-	if (so->bound && isotp_register_txecho(so)) {
+	if (so->bound) {
 		if (so->ifindex) {
 			struct net_device *dev;
 
 			dev = dev_get_by_index(net, so->ifindex);
 			if (dev) {
@@ -1330,18 +1324,16 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 
 	if (isotp_register_rxid(so))
 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
 				isotp_rcv, sk, "isotp", sk);
 
-	if (isotp_register_txecho(so)) {
-		/* no consecutive frame echo skb in flight */
-		so->cfecho = 0;
+	/* no consecutive frame echo skb in flight */
+	so->cfecho = 0;
 
-		/* register for echo skb's */
-		can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
-				isotp_rcv_echo, sk, "isotpe", sk);
-	}
+	/* register for echo skb's */
+	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
+			isotp_rcv_echo, sk, "isotpe", sk);
 
 	dev_put(dev);
 
 	/* switch to new settings */
 	so->ifindex = ifindex;
@@ -1558,11 +1550,11 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 		/* remove current filters & unregister */
-		if (so->bound && isotp_register_txecho(so)) {
+		if (so->bound) {
 			if (isotp_register_rxid(so))
 				can_rx_unregister(dev_net(dev), dev, so->rxid,
 						  SINGLE_MASK(so->rxid),
 						  isotp_rcv, sk);
 
-- 
2.39.2

