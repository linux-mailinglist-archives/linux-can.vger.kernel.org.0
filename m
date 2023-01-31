Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798D6682AE5
	for <lists+linux-can@lfdr.de>; Tue, 31 Jan 2023 11:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjAaK4X (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Jan 2023 05:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjAaK4W (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2023 05:56:22 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F63F753
        for <linux-can@vger.kernel.org>; Tue, 31 Jan 2023 02:56:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675162579; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rMMEy0+nRMde/RZv8UDYN3Cc7WM+FfFmrIIwurbl+qZvUgRyfm1IAcVrlwm+knD/b7
    TUvNusPfed6LyLdna2K3h4JUwQp8NP8XugwUj8teYBh092wffrknrd7S2/Y0R+dd4/Jw
    57eZ7nvOZGEJ+cAXfCg+iVaYkAL4rrVViL8ZyY4GZbHzzocVUIS4ybhZvn5gNULqCYU7
    euGOUDv6Qf0Bxokp7+Emw3rbQvlJyS3MrW/MyouJa3R/iVob4MH+yHte8/ukkGAXia9V
    vjmwQK1/LolPH4U5XRTNBY9t5jAG+BzZqHigrLW6T5WHIloAGVQY5Fmpb8QvAAR559Ac
    ePVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675162579;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Y+ln3ZxSHdg2+01xgOh9azftVdmWqEpj7NEduA8Y1ao=;
    b=jnj4F9E058Xlg/6sQ/sME23P0YJIaAlPvaCaeNaeIxU9C9YfLwtVUk4UkfCU3dhJVn
    41z48rd+Xxu5GFjFlum9fcUeRBxBysxTGpM112ODMChzTzJxCBQqgc6bvOy9b+WQuy8w
    dSncyLHSBPOwuq04h1PNVjJ2wjQuRGJTpM0fYR7lFqUddc1UU3ekr5e/Jd76O/DUI71T
    7IDv+Tb0XPRVJWaqRkeleW7HyK4wRoN3gCEPm6deCvwTqqxyfJ3/lYiqnHaS72IYJ3Dc
    wcBL69rNcmUmobx685meLRaSmD7pxeAobj3Maen1GA8ZqqYSoSIewe2hk31rY9+Xd8An
    J3pA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675162579;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Y+ln3ZxSHdg2+01xgOh9azftVdmWqEpj7NEduA8Y1ao=;
    b=g+4O4BjRI6Fz5RgsiO0UuRjQnbqUKX4g7rCHOsKFxLgRJ9A4sHTAcvdjW8jABVeCHH
    dkKNBLTSdfR9F7Yk4A6TV/q6f7CWD4GbwSF70Cm0sQFYotoPPJU4Yhia1iP1J1tITuz/
    cxX887+XRl5wKHTKzsLfMUvzFb4BgDEo5X6nrynShW33FhiNf3vyktLaqHU626Yd0o9l
    W7+oQkLU5O9i3mCuQZOuKlCcarGzR72CKOucO0eCkxECAddwwDFd7fz1gzIrBUsXubUL
    RTZrhld2V6H6zd8DbxQgCoa3Ob4mFZuO6FmARzi7fcTbaf32/jcJBo9vaOXSPE3y6+Cm
    RTGA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmQgR17+6Jkvj2j0lZGWSpaEyoLOt"
Received: from blue.lan
    by smtp.strato.de (RZmta 49.2.2 AUTH)
    with ESMTPSA id qa71b9z0VAuJJ05
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Jan 2023 11:56:19 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v3] can: raw: fix CAN FD frame transmissions over CAN XL devices
Date:   Tue, 31 Jan 2023 11:56:13 +0100
Message-Id: <20230131105613.55228-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
hot path in raw_rcv() and raw_sendmsg(). Some conditions are reordered to
handle simple checks first.

Fixes: 626332696d75 ("can: raw: add CAN XL support")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---

V2: fixed typo: devive -> device
V3: reorder checks in if statements to handle simple checks first

 net/can/raw.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 81071cdb0301..ba86782ba8bb 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -130,12 +130,12 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	/* check the received tx sock reference */
 	if (!ro->recv_own_msgs && oskb->sk == sk)
 		return;
 
 	/* make sure to not pass oversized frames to the socket */
-	if ((can_is_canfd_skb(oskb) && !ro->fd_frames && !ro->xl_frames) ||
-	    (can_is_canxl_skb(oskb) && !ro->xl_frames))
+	if ((!ro->fd_frames && can_is_canfd_skb(oskb)) ||
+	    (!ro->xl_frames && can_is_canxl_skb(oskb)))
 		return;
 
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
 	    this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
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
+	/* Classical CAN -> no checks for flags and device capabilities */
+	if (can_is_can_skb(skb))
+		return false;
+
+	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
+	if (ro->fd_frames && can_is_canfd_skb(skb) &&
+	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
+		return false;
+
+	/* CAN XL -> needs to be enabled and a CAN XL device */
+	if (ro->xl_frames && can_is_canxl_skb(skb) &&
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

