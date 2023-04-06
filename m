Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05D26D94B5
	for <lists+linux-can@lfdr.de>; Thu,  6 Apr 2023 13:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbjDFLJA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Apr 2023 07:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDFLI7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Apr 2023 07:08:59 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E56D61BF
        for <linux-can@vger.kernel.org>; Thu,  6 Apr 2023 04:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680779332; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZQAj+doKt9uClHiiT4X0tky2HW54SqgOjS/kPw5AgMm8ZZBpwA3vjdMs9SY2v//Tp/
    Bhg/pPCYz7k512trv0v9IxKTgEVvWktNSdbUW5BSUYyUQx8eYeqAjrD2Eh3Abh1CNby1
    sQaddUbNvHHRpywizEpUTx3EjgSN8C9K+TgF2Z6aDSR/bWrBe4rl7+j49u8coZYX1lhU
    OKSICbuERL+x4hPT6JX5Z+MjCVsmo8VLs8vE4yXHNyGb/3tczfHIdggEpEg5/Eo9oTFv
    0xf+M3iN+nIk7pLmOnJ33YUDg0fE7+XbLQ7LefeEjEbxs4+GRDeVw0Q/qxWpRGN41/jR
    /tGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680779332;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0yjOcZjBPLPnDhJTc/mfwSN5ZD3461T7JrDYboL1LlY=;
    b=S2ZVqhvrOJqt6vy6RKo5WzCyiKVS4dy/5Pp2vQF0yFly2b4TlDsettMvYYRN/WEl8x
    Nt72OgELy71sUnPP0pS9+y2Xe6inxZA5pUlO3ZdJ4V5iT8kDfPTViwhpwbFvU2dknlBf
    Bn9wsDArxAYX8wsxOyJnbGxPsF5PKhwAn7rsscxCaZIT2bNru/cWIEHvRjjg70RglDji
    yRoaWoUfvPBgTcE3IGOrU4Q3D13M8xRt7TNxbFTGUQbNz4Swo4VDwzjYIogfK3YBBXGq
    L9+0PJZ6PR0x85LEk54KmAeJzoEo+07av9CckXK515ZOZhP0ZglAjm+TWIaDbHSg8vdJ
    blEQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680779332;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0yjOcZjBPLPnDhJTc/mfwSN5ZD3461T7JrDYboL1LlY=;
    b=dw7paH1JhhBsTAPHdxjxYq2nIoJkvqzzCq+TJvwj52lbGs83coU+DEvjocQ5exQOkf
    sroFNGjASlChp5lKlGrkb+4lz60XeJmXC/5Am8bCUDYbT9nvSo/9q2H7aq5xjOQ+EfP0
    f1JinTZkbkaTpXGxtqolMUCGaDQYvJAey8HB5pWyJ+JpXwE1YOn5FQ53BjCXO7FQXJ5R
    rgT6OIJXyagZomGfZ8XXfnjVl14zcK5sIhhAC8F5tM1V2OsVwYjUwfXgpqUvOWu9jBz3
    bGeBznSJDJy1Mr49NtzeRFJiZauvvYyqK2JB/vwaPQfd9nsMjH/Kx0V95JrQLarw8jeX
    unug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1680779332;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0yjOcZjBPLPnDhJTc/mfwSN5ZD3461T7JrDYboL1LlY=;
    b=ZTM9rg0A9+FDATSJLZdlf9o3H6WsbMO30+banRJ4B/HjK9N+CIONcIPoY1QjaLD69p
    EYWWI4XeQ+32cswQ+/Bw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfh+rd"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.4.0 AUTH)
    with ESMTPSA id x06214z36B8q8ne
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 6 Apr 2023 13:08:52 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: allow MSG_CMSG_COMPAT flag in recvmsg() syscalls
Date:   Thu,  6 Apr 2023 13:08:45 +0200
Message-Id: <20230406110845.5180-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The control messages provided by j1939 and isotp support MSG_CMSG_COMPAT
but blocked recvmsg() syscalls that have set this flag, e.g. on 32bit
ARM systems.

Link: https://github.com/hartkopp/can-isotp/issues/59
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c        | 2 +-
 net/can/j1939/socket.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 9bc344851704..fd0e297a8584 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1099,11 +1099,11 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
 	struct isotp_sock *so = isotp_sk(sk);
 	int ret = 0;
 
-	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK))
+	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK | MSG_CMSG_COMPAT))
 		return -EINVAL;
 
 	if (!so->bound)
 		return -EADDRNOTAVAIL;
 
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 7e90f9e61d9b..1790469b2580 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -796,11 +796,11 @@ static int j1939_sk_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
 	struct j1939_sk_buff_cb *skcb;
 	int ret = 0;
 
-	if (flags & ~(MSG_DONTWAIT | MSG_ERRQUEUE))
+	if (flags & ~(MSG_DONTWAIT | MSG_ERRQUEUE | MSG_CMSG_COMPAT))
 		return -EINVAL;
 
 	if (flags & MSG_ERRQUEUE)
 		return sock_recv_errqueue(sock->sk, msg, size, SOL_CAN_J1939,
 					  SCM_J1939_ERRQUEUE);
-- 
2.30.2

