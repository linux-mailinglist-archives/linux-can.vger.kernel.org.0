Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DC64DB663
	for <lists+linux-can@lfdr.de>; Wed, 16 Mar 2022 17:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356287AbiCPQoh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Mar 2022 12:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357424AbiCPQog (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Mar 2022 12:44:36 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D86B1C935
        for <linux-can@vger.kernel.org>; Wed, 16 Mar 2022 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1647448994;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=axDHFfEbMHpZxryrjqBODgb8CpWw+JMELhoAyDs36uI=;
    b=mQgt5gV713sZiCoQIKHJ0WqETVaW9Fg83rhufGmC1bUlwYdJidq0L3lkhGCR1lVKoi
    ujqddHzOP6BG9WjuWBwYL4sRM8sINoQKHQVU6wqkSlpS4lgVEp3TmuDFwz/J1lBE0DKj
    pPYYZmAPeHR9ocHVOozrt0685ffpRV//faXnNIt0BcwY/LyrxLeBHOGMbNGOwfXJGmuS
    +r/P9UwQnULIAPlayAjVnqSctTLLAxFPI49jgPP6n2jdU0wTD9UkWUMXOZL+QHz82yqO
    7MNf6aycBQUb/mzYeL1hMzpNszptL2S6DVZeisyWrVh9yZvP+Dei3Qklojoj0d+OmbT1
    IOtQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9IyLecSWJafUv+rx4"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.41.0 AUTH)
    with ESMTPSA id a046a1y2GGhE4CI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 16 Mar 2022 17:43:14 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Derek Will <derekrobertwill@gmail.com>
Subject: [PATCH 2/3] can: isotp: return -EADDRNOTAVAIL when reading from unbound socket
Date:   Wed, 16 Mar 2022 17:42:57 +0100
Message-Id: <20220316164258.54155-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316164258.54155-1-socketcan@hartkopp.net>
References: <20220316164258.54155-1-socketcan@hartkopp.net>
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

When reading from an unbound can-isotp socket the syscall blocked
indefinitely. As unbound sockets (without given CAN address information)
do not make sense anyway we directly return -EADDRNOTAVAIL on read()
analogue to the known behavior from sendmsg().

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Link: https://github.com/linux-can/can-utils/issues/349
Suggested-by: Derek Will <derekrobertwill@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 1662103ce125..6b6c82206c30 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1044,16 +1044,20 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 			 int flags)
 {
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
+	struct isotp_sock *so = isotp_sk(sk);
 	int err = 0;
 	int noblock;
 
 	noblock = flags & MSG_DONTWAIT;
 	flags &= ~MSG_DONTWAIT;
 
+	if (!so->bound)
+		return -EADDRNOTAVAIL;
+
 	skb = skb_recv_datagram(sk, flags, noblock, &err);
 	if (!skb)
 		return err;
 
 	if (size < skb->len)
-- 
2.30.2

