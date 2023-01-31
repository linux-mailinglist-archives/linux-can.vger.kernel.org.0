Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0C4682860
	for <lists+linux-can@lfdr.de>; Tue, 31 Jan 2023 10:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjAaJNe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Jan 2023 04:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjAaJNS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2023 04:13:18 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC96146AB
        for <linux-can@vger.kernel.org>; Tue, 31 Jan 2023 01:11:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675156227; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AqSybcuUetrOmJiL6lY0H/XrNLKkEATq6vMdUGjK5srZe8hD1P0qrdj7CvpyaTPNe2
    g5bAjgqP2cAYDV85/dNrgNnGZ0U++80AvEDg2wqWRBYBDOOZDKn8GZYRvdLyTElgwo/K
    bW4avij+Ft2bZQ3AJDLrheImmp7nldsUhO6TOLHjaheilm92AzKcZkb60CMtE9LwZTUz
    adaO5728kqjslDGuryJ5Z7oQQz3Wp9vPmzxOIqO+eWZOLEms9frcHmd8wx965mfaAiAb
    3Xzhav7xQFFHT7yskB/3nw8Opqp8UrSv5lG3CVTY+xbn+vyIxJurTK3DsAZoNQnCDfGC
    yNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675156227;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=mbHJXleudLn5BxOCSqsaLbF4hnnvGhPeinBajIzGCyQ=;
    b=Su0JaVsZJd3i5BAIRIe4Vp8C88163x2Q8ypvPt6HK5VZU9tG6Itqejz7rPgfxadlIm
    VCs8yzQrFJLKAVNtCqeb6CypYsN1BjdCv2HB+uZGGe4KtMKASWGFrxZmpFm+owFEpvOn
    X+bzA1LhawmESEgNva5Z0ITjeozaa1+EAddnPhPxJiZZ1siaZSipu6LnKicAUdKEX/wd
    107PVQiGUZsJ+5qUI4I82/9N60jARcimHOOTZ7gOTCQDpEQynKeq4zREAJZdZjnmiwJE
    jAV+QGKfWBFOboxu3Gahma3XfCqhzNF4OdxvrO68na5SSL5Q0+YV3ey4dUsr2mKF+h7Z
    vpcA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675156227;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=mbHJXleudLn5BxOCSqsaLbF4hnnvGhPeinBajIzGCyQ=;
    b=MgK7kC4RXlB8adCu3XTqW+zMWkSeFVBninB2lyMSgrnY8et15UYFA+lncNpZFbWRrm
    XbYaJfk8vfZdr5B2VFPoArAxPFtsKQNCIcmVUwqyUAMPEp3P5hjvZ/7jNCY43jh3Y+0b
    HdYXf2g1HLPLjHkjg1KCaSZTVa2QH0k7O41K8fffQefkDKmSJALGeEo+ubQ+2fWcQDox
    ihHhUlee6WTA8QYfySJRobyBToSyUKqyL2D+dEgh4jhbzBAjxuCGHu9CJD0NN/zhG8xm
    B4KEJNPyZFQkxPRRTTqUhjRkbHsJwT3hZ05AfeRuP8NmtbfZluEqH7kDiT+8vHSJgCU2
    g2BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmQgR17+6Jkvj2j0lZGWSpaEyoLOt"
Received: from blue.lan
    by smtp.strato.de (RZmta 49.2.2 AUTH)
    with ESMTPSA id qa71b9z0V9ARIDI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Jan 2023 10:10:27 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: raw: fix CAN FD frame transmissions over CAN XL devices
Date:   Tue, 31 Jan 2023 10:10:12 +0100
Message-Id: <20230131091012.50553-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

A CAN XL device is always capable to process CAN FD frames. The former
check when sending CAN FD frames relied on the existence of a CAN FD
device and did not check for a CAN XL device that would be correct too.

With this patch the CAN FD feature is enabled automatically when CAN XL
is switched on - and CAN FD cannot be switch off while CAN XL is enabled.

This precondition also leads to a clean up and reduction of checks in the
hot path in raw_rcv() and raw_sendmsg().

Fixes: 626332696d75 ("can: raw: add CAN XL support")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 81071cdb0301..74fdcec08f48 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -130,11 +130,11 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	/* check the received tx sock reference */
 	if (!ro->recv_own_msgs && oskb->sk == sk)
 		return;
 
 	/* make sure to not pass oversized frames to the socket */
-	if ((can_is_canfd_skb(oskb) && !ro->fd_frames && !ro->xl_frames) ||
+	if ((can_is_canfd_skb(oskb) && !ro->fd_frames) ||
 	    (can_is_canxl_skb(oskb) && !ro->xl_frames))
 		return;
 
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
@@ -668,19 +668,27 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 			return -EINVAL;
 
 		if (copy_from_sockptr(&ro->fd_frames, optval, optlen))
 			return -EFAULT;
 
+		/* Enabling CAN XL includes CAN FD */
+		if (ro->xl_frames && !ro->fd_frames) {
+			ro->fd_frames = ro->xl_frames;
+			return -EINVAL;
+		}
 		break;
 
 	case CAN_RAW_XL_FRAMES:
 		if (optlen != sizeof(ro->xl_frames))
 			return -EINVAL;
 
 		if (copy_from_sockptr(&ro->xl_frames, optval, optlen))
 			return -EFAULT;
 
+		/* Enabling CAN XL includes CAN FD */
+		if (ro->xl_frames)
+			ro->fd_frames = ro->xl_frames;
 		break;
 
 	case CAN_RAW_JOIN_FILTERS:
 		if (optlen != sizeof(ro->join_filters))
 			return -EINVAL;
@@ -784,10 +792,29 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 	if (copy_to_user(optval, val, len))
 		return -EFAULT;
 	return 0;
 }
 
+static bool raw_bad_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
+{
+	/* Classical CAN -> no checks for flags and devive capabilities */
+	if (can_is_can_skb(skb))
+		return false;
+
+	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
+	if (can_is_canfd_skb(skb) && ro->fd_frames &&
+	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
+		return false;
+
+	/* CAN XL -> needs to be enabled and a CAN XL device */
+	if (can_is_canxl_skb(skb) && ro->xl_frames &&
+	    can_is_canxl_dev_mtu(mtu))
+		return false;
+
+	return true;
+}
+
 static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
 	struct sockcm_cookie sockc;
@@ -831,24 +858,12 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)
 		goto free_skb;
 
 	err = -EINVAL;
-	if (ro->xl_frames && can_is_canxl_dev_mtu(dev->mtu)) {
-		/* CAN XL, CAN FD and Classical CAN */
-		if (!can_is_canxl_skb(skb) && !can_is_canfd_skb(skb) &&
-		    !can_is_can_skb(skb))
-			goto free_skb;
-	} else if (ro->fd_frames && dev->mtu == CANFD_MTU) {
-		/* CAN FD and Classical CAN */
-		if (!can_is_canfd_skb(skb) && !can_is_can_skb(skb))
-			goto free_skb;
-	} else {
-		/* Classical CAN */
-		if (!can_is_can_skb(skb))
-			goto free_skb;
-	}
+	if (raw_bad_txframe(ro, skb, dev->mtu))
+		goto free_skb;
 
 	sockcm_init(&sockc, sk);
 	if (msg->msg_controllen) {
 		err = sock_cmsg_send(sk, msg, &sockc);
 		if (unlikely(err))
-- 
2.39.0

