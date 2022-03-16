Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917334DB664
	for <lists+linux-can@lfdr.de>; Wed, 16 Mar 2022 17:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357424AbiCPQoh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Mar 2022 12:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355976AbiCPQog (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Mar 2022 12:44:36 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A94715A06
        for <linux-can@vger.kernel.org>; Wed, 16 Mar 2022 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1647448994;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=2u7Gud42Y+x/I1L8jYVL7BPOnWyINx4uiT2WavJMIs0=;
    b=WHF7XjSXm1sf7X6OGrhU4udbu8Ei/jqrh1aXGS0OoJMoNz+2tTc2VlJRz42QwavZfk
    8gLuX7SmD2I9v+y+jXDGC5Usm4bjGMh9jLzkgPdGcFiNV8JlLaTzVPAP/voDyALtVcdp
    GRIWBv/YtPtf1Q9rviIFVYuB+TBA16AC6hFMyMeFjuyU7Rfmbn4cuGhHCb/ohePFOSDD
    av2ttRCqCu6VX+aPgIf6ANV6NVE5tsEJNt/9gm5npVLgGEAIC75X6SH/ensse7rMUD63
    cr85sorxCBtFmxwzjrtup98iaxmsQ9yR8eqEh8gwBYEE3eQ0PajZoYAyXZqWcPhMCNU3
    kTqQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9IyLecSWJafUv+rx4"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.41.0 AUTH)
    with ESMTPSA id a046a1y2GGhE4CJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 16 Mar 2022 17:43:14 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Derek Will <derekrobertwill@gmail.com>
Subject: [PATCH 3/3] can: isotp: support MSG_TRUNC flag when reading from socket
Date:   Wed, 16 Mar 2022 17:42:58 +0100
Message-Id: <20220316164258.54155-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316164258.54155-1-socketcan@hartkopp.net>
References: <20220316164258.54155-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When providing the MSG_TRUNC flag via recvmsg() syscall the return value
provides the real length of the packet or datagram, even when it was longer
than the passed buffer.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Link: https://github.com/linux-can/can-utils/issues/347#issuecomment-1065932671
Suggested-by: Derek Will <derekrobertwill@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 6b6c82206c30..f6f8ba1f816d 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1045,45 +1045,48 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 			 int flags)
 {
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
 	struct isotp_sock *so = isotp_sk(sk);
-	int err = 0;
-	int noblock;
+	int noblock = flags & MSG_DONTWAIT;
+	int ret = 0;
 
-	noblock = flags & MSG_DONTWAIT;
-	flags &= ~MSG_DONTWAIT;
+	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC))
+		return -EINVAL;
 
 	if (!so->bound)
 		return -EADDRNOTAVAIL;
 
-	skb = skb_recv_datagram(sk, flags, noblock, &err);
+	flags &= ~MSG_DONTWAIT;
+	skb = skb_recv_datagram(sk, flags, noblock, &ret);
 	if (!skb)
-		return err;
+		return ret;
 
 	if (size < skb->len)
 		msg->msg_flags |= MSG_TRUNC;
 	else
 		size = skb->len;
 
-	err = memcpy_to_msg(msg, skb->data, size);
-	if (err < 0) {
-		skb_free_datagram(sk, skb);
-		return err;
-	}
+	ret = memcpy_to_msg(msg, skb->data, size);
+	if (ret < 0)
+		goto out_err;
 
 	sock_recv_timestamp(msg, sk, skb);
 
 	if (msg->msg_name) {
 		__sockaddr_check_size(ISOTP_MIN_NAMELEN);
 		msg->msg_namelen = ISOTP_MIN_NAMELEN;
 		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
 	}
 
+	/* set length of return value */
+	ret = (flags & MSG_TRUNC) ? skb->len : size;
+
+out_err:
 	skb_free_datagram(sk, skb);
 
-	return size;
+	return ret;
 }
 
 static int isotp_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
-- 
2.30.2

