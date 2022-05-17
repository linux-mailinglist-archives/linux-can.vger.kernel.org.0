Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A2B52A579
	for <lists+linux-can@lfdr.de>; Tue, 17 May 2022 16:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiEQO53 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 May 2022 10:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349572AbiEQO5N (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 May 2022 10:57:13 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2777837A16
        for <linux-can@vger.kernel.org>; Tue, 17 May 2022 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652799422;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=plyRQLRhsScH3NakYHHGF2iEh3+P/wfiJp4z3QCq5jo=;
    b=kzCS1J998AzrVS7kpdK2iKrUf7LCHSRH/MuyZQDJpt8n1UuH+1y+c064JQAOYidCsI
    q/RbWZ58WPpC2/+AP0qNq55JGlFTBBhnmRGSVwkSqXTlSb/S/sOMJ89U6/VOzFuCq+Gn
    CG27ucUeLpm1+MOy7a8Y4o/4PCmgsaQhgJLO1Nz6/jlMF2vFlAa2Oy5qT9pobsVtp4zU
    M02GkK7QNiBNDllFyO7699qV97ZiIf3GZENCL3cqEdqmp6NpaDdeyZX9y/uG1GYT8ZbA
    M+Day8f+By9lojxvRy6+uzNfTQrgvW2Yq9M9srO6yk7EkoPvjCMmwgjtqP01vKG+BXoa
    jcEg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JCKNKiWJaRDy1ex1"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id R0691fy4HEv2Eal
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 17 May 2022 16:57:02 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next] can: isotp: isotp_bind(): do not validate unused address information
Date:   Tue, 17 May 2022 16:56:53 +0200
Message-Id: <20220517145653.2556-1-socketcan@hartkopp.net>
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

With commit 2aa39889c463 ("can: isotp: isotp_bind(): return -EINVAL on
incorrect CAN ID formatting") the bind() syscall returns -EINVAL when
the given CAN ID needed to be sanitized. But in the case of an unconfirmed
broadcast mode the rx CAN ID is not needed and may be uninitialized from
the caller - which is ok.

This patch makes sure the result of an inproper CAN ID format is only
provided when the address information is needed.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 4a4007f10970..43a27d19cdac 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1210,35 +1210,40 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
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
 
 	if (len < ISOTP_MIN_NAMELEN)
 		return -EINVAL;
 
-	/* sanitize tx/rx CAN identifiers */
-	tx_id = addr->can_addr.tp.tx_id;
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
-
-	/* give feedback on wrong CAN-ID values */
-	if (tx_id != addr->can_addr.tp.tx_id ||
-	    rx_id != addr->can_addr.tp.rx_id)
+	/* give feedback on wrong CAN-ID value */
+	if (tx_id != addr->can_addr.tp.tx_id)
 		return -EINVAL;
 
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
+
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
 	lock_sock(sk);
 
-- 
2.30.2

