Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0704DB667
	for <lists+linux-can@lfdr.de>; Wed, 16 Mar 2022 17:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355976AbiCPQol (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Mar 2022 12:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357477AbiCPQoj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Mar 2022 12:44:39 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9F21C93B
        for <linux-can@vger.kernel.org>; Wed, 16 Mar 2022 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1647448994;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=KMDY+gLoV9k745Yqvlwn4CapRWlH0lMiANSIpNvkV7k=;
    b=b85hxo0K2qyzXYLq4ol5Msm1EzG6v7V8t4RzNVA7cW+ic/h8AMHLnhTZohg0S23wLb
    QJ1pnOHcpbfHEJrt3YWoqSgG4/fbgC+z4Tzk6a0+qTl/rx6tlCd3ZfR7Myg9sE6DNRfI
    tuw5azEBtKf3F0ObWSMGaPBUEbfTViN1WnyXscK1H3dCKIM98p1d/jmTmoSzCEiAweIk
    TBXPAeAoBodCn3ZskATVzxq6AAei7HRZH213TwVhQr6C2KDRtluRG1NRB2g265lUQTaJ
    tLchPs8gYToGhTJ+ixGYR2U/oQSQQ/DSi4R+WrdQEm6HQBTgq2WPOxsa+q7lNIPQccek
    PJbA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9IyLecSWJafUv+rx4"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.41.0 AUTH)
    with ESMTPSA id a046a1y2GGhE4CH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 16 Mar 2022 17:43:14 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        syzbot+2339c27f5c66c652843e@syzkaller.appspotmail.com
Subject: [PATCH 1/3] can: isotp: sanitize CAN ID checks in isotp_bind()
Date:   Wed, 16 Mar 2022 17:42:56 +0100
Message-Id: <20220316164258.54155-1-socketcan@hartkopp.net>
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

Syzbot created an environment that lead to a state machine status that
can not be reached with a compliant CAN ID address configuration.
The provided address information consisted of CAN ID 0x6000001 and 0xC28001
which both boil down to 11 bit CAN IDs 0x001 in sending and receiving.

Sanitize the SFF/EFF CAN ID values before performing the address checks.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Reported-by: syzbot+2339c27f5c66c652843e@syzkaller.appspotmail.com
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index d4c0b4704987..1662103ce125 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1146,19 +1146,30 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
 	struct net *net = sock_net(sk);
 	int ifindex;
 	struct net_device *dev;
+	canid_t tx_id, rx_id;
 	int err = 0;
 	int notify_enetdown = 0;
 	int do_rx_reg = 1;
 
 	if (len < ISOTP_MIN_NAMELEN)
 		return -EINVAL;
 
-	if (addr->can_addr.tp.tx_id & (CAN_ERR_FLAG | CAN_RTR_FLAG))
-		return -EADDRNOTAVAIL;
+	/* sanitize tx/rx CAN identifiers */
+	tx_id = addr->can_addr.tp.tx_id;
+	if (tx_id & CAN_EFF_FLAG)
+		tx_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
+	else
+		tx_id &= CAN_SFF_MASK;
+
+	rx_id = addr->can_addr.tp.rx_id;
+	if (rx_id & CAN_EFF_FLAG)
+		rx_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
+	else
+		rx_id &= CAN_SFF_MASK;
 
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
 	lock_sock(sk);
@@ -1166,25 +1177,17 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	/* do not register frame reception for functional addressing */
 	if (so->opt.flags & CAN_ISOTP_SF_BROADCAST)
 		do_rx_reg = 0;
 
 	/* do not validate rx address for functional addressing */
-	if (do_rx_reg) {
-		if (addr->can_addr.tp.rx_id == addr->can_addr.tp.tx_id) {
-			err = -EADDRNOTAVAIL;
-			goto out;
-		}
-
-		if (addr->can_addr.tp.rx_id & (CAN_ERR_FLAG | CAN_RTR_FLAG)) {
-			err = -EADDRNOTAVAIL;
-			goto out;
-		}
+	if (do_rx_reg && rx_id == tx_id) {
+		err = -EADDRNOTAVAIL;
+		goto out;
 	}
 
 	if (so->bound && addr->can_ifindex == so->ifindex &&
-	    addr->can_addr.tp.rx_id == so->rxid &&
-	    addr->can_addr.tp.tx_id == so->txid)
+	    rx_id == so->rxid && tx_id == so->txid)
 		goto out;
 
 	dev = dev_get_by_index(net, addr->can_ifindex);
 	if (!dev) {
 		err = -ENODEV;
@@ -1204,20 +1207,18 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		notify_enetdown = 1;
 
 	ifindex = dev->ifindex;
 
 	if (do_rx_reg) {
-		can_rx_register(net, dev, addr->can_addr.tp.rx_id,
-				SINGLE_MASK(addr->can_addr.tp.rx_id),
+		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
 				isotp_rcv, sk, "isotp", sk);
 
 		/* no consecutive frame echo skb in flight */
 		so->cfecho = 0;
 
 		/* register for echo skb's */
-		can_rx_register(net, dev, addr->can_addr.tp.tx_id,
-				SINGLE_MASK(addr->can_addr.tp.tx_id),
+		can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
 				isotp_rcv_echo, sk, "isotpe", sk);
 	}
 
 	dev_put(dev);
 
@@ -1237,12 +1238,12 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		}
 	}
 
 	/* switch to new settings */
 	so->ifindex = ifindex;
-	so->rxid = addr->can_addr.tp.rx_id;
-	so->txid = addr->can_addr.tp.tx_id;
+	so->rxid = rx_id;
+	so->txid = tx_id;
 	so->bound = 1;
 
 out:
 	release_sock(sk);
 
-- 
2.30.2

