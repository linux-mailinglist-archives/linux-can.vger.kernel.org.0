Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A87721EAC
	for <lists+linux-can@lfdr.de>; Mon,  5 Jun 2023 09:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjFEHBO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 5 Jun 2023 03:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjFEHBC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Jun 2023 03:01:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30754FD
        for <linux-can@vger.kernel.org>; Mon,  5 Jun 2023 00:00:52 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1q64Cw-0007mb-Ja
        for linux-can@vger.kernel.org; Mon, 05 Jun 2023 09:00:50 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4DC0C1D20F5
        for <linux-can@vger.kernel.org>; Mon,  5 Jun 2023 06:59:56 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 77C691D20C7;
        Mon,  5 Jun 2023 06:59:54 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 581126c1;
        Mon, 5 Jun 2023 06:59:53 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>,
        David Jander <david@protonic.nl>, stable@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 1/3] can: j1939: j1939_sk_send_loop_abort(): improved error queue handling in J1939 Socket
Date:   Mon,  5 Jun 2023 08:59:50 +0200
Message-Id: <20230605065952.1074928-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230605065952.1074928-1-mkl@pengutronix.de>
References: <20230605065952.1074928-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
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

From: Oleksij Rempel <o.rempel@pengutronix.de>

This patch addresses an issue within the j1939_sk_send_loop_abort()
function in the j1939/socket.c file, specifically in the context of
Transport Protocol (TP) sessions.

Without this patch, when a TP session is initiated and a Clear To Send
(CTS) frame is received from the remote side requesting one data packet,
the kernel dispatches the first Data Transport (DT) frame and then waits
for the next CTS. If the remote side doesn't respond with another CTS,
the kernel aborts due to a timeout. This leads to the user-space
receiving an EPOLLERR on the socket, and the socket becomes active.

However, when trying to read the error queue from the socket with
sock.recvmsg(, , socket.MSG_ERRQUEUE), it returns -EAGAIN,
given that the socket is non-blocking. This situation results in an
infinite loop: the user-space repeatedly calls epoll(), epoll() returns
the socket file descriptor with EPOLLERR, but the socket then blocks on
the recv() of ERRQUEUE.

This patch introduces an additional check for the J1939_SOCK_ERRQUEUE
flag within the j1939_sk_send_loop_abort() function. If the flag is set,
it indicates that the application has subscribed to receive error queue
messages. In such cases, the kernel can communicate the current transfer
state via the error queue. This allows for the function to return early,
preventing the unnecessary setting of the socket into an error state,
and breaking the infinite loop. It is crucial to note that a socket
error is only needed if the application isn't using the error queue, as,
without it, the application wouldn't be aware of transfer issues.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Reported-by: David Jander <david@protonic.nl>
Tested-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20230526081946.715190-1-o.rempel@pengutronix.de
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/socket.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 1790469b2580..35970c25496a 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1088,6 +1088,11 @@ void j1939_sk_errqueue(struct j1939_session *session,
 
 void j1939_sk_send_loop_abort(struct sock *sk, int err)
 {
+	struct j1939_sock *jsk = j1939_sk(sk);
+
+	if (jsk->state & J1939_SOCK_ERRQUEUE)
+		return;
+
 	sk->sk_err = err;
 
 	sk_error_report(sk);

base-commit: 8cde87b007dad2e461015ff70352af56ceb02c75
-- 
2.39.2


