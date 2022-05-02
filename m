Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229CF516D3C
	for <lists+linux-can@lfdr.de>; Mon,  2 May 2022 11:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384156AbiEBJXY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 2 May 2022 05:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384166AbiEBJXU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 May 2022 05:23:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420633BBDB
        for <linux-can@vger.kernel.org>; Mon,  2 May 2022 02:19:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nlSDd-00062c-Jr
        for linux-can@vger.kernel.org; Mon, 02 May 2022 11:19:49 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7739D72FE1
        for <linux-can@vger.kernel.org>; Mon,  2 May 2022 09:19:48 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 512D772FD8;
        Mon,  2 May 2022 09:19:48 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 44edb325;
        Mon, 2 May 2022 09:19:48 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [can-next-rfc 2/2] can: raw: add support for SO_TXTIME/SCM_TXTIME
Date:   Mon,  2 May 2022 11:19:46 +0200
Message-Id: <20220502091946.1916211-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502091946.1916211-1-mkl@pengutronix.de>
References: <20220502091946.1916211-1-mkl@pengutronix.de>
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

This patch calls into sock_cmsg_send() to parse the user supplied
control information into a struct sockcm_cookie. Then assign the
requested transmit time to the skb.

This makes it possible to use the Earliest TXTIME First (ETF) packet
scheduler with the CAN_RAW protocol. The user can send a CAN_RAW frame
with a TXTIME and the kernel (with the ETF scheduler) will take care
of sending it to the network interface.

Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 1a68efae43c2..d1bd9cc51ebe 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -772,6 +772,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
+	struct sockcm_cookie sockc;
 	struct sk_buff *skb;
 	struct net_device *dev;
 	int ifindex;
@@ -817,10 +818,18 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (err < 0)
 		goto free_skb;
 
-	skb_setup_tx_timestamp(skb, sk->sk_tsflags);
+	sockcm_init(&sockc, sk);
+	if (msg->msg_controllen) {
+		err = sock_cmsg_send(sk, msg, &sockc);
+		if (unlikely(err))
+			goto free_skb;
+	}
 
 	skb->dev = dev;
 	skb->priority = sk->sk_priority;
+	skb->tstamp = sockc.transmit_time;
+
+	skb_setup_tx_timestamp(skb, sockc.tsflags);
 
 	err = can_send(skb, ro->loopback);
 
-- 
2.35.1


