Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71460682B68
	for <lists+linux-can@lfdr.de>; Tue, 31 Jan 2023 12:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjAaL10 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Jan 2023 06:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjAaL1Z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2023 06:27:25 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D0E49953
        for <linux-can@vger.kernel.org>; Tue, 31 Jan 2023 03:27:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675164433; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XkdKMiUYEbSyD3tuL/viYk6IFsReODOMSLdgISgTc9Rv9zXyYOp0VT8ln3/M96PfBc
    cQaHjQ8hg3MVBoIRbFKJLcu/RcKgztIeEM34W9eHAei55mcVIFIP/cYIekdtwFICuAok
    Bt0m9r5gPuhnLNxcjQ6pzmLAxBFd6CD9CY65n4j5MjO5aTDvL/szZsNpxxeffP8bSHy0
    s+gAAvI6Avei/y18nApBveJoVCNwRIrhRoSzAs/+F3o2lTQbLS07M7rbvwvPaGJ/PyhV
    RTc1iWmUNGTkPzH/aKD0plNf/Ft37hNUAGWde18aycchRqURvpDQe6hXQ+StcfjSHjRp
    T+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675164433;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=FphUiQOJ27CqHQaN9pasoclUDtKk/fYczLFJNRnJdzA=;
    b=NfIMSDH0A1XEMA/Fg7nNG8fCGxbSHhOzSnr17jPl6V6OtlaRVQY0x/MSoGvWCtDIxW
    3x6z83YM+cw9BDbjh2WyDQsxSsWzGL4AKbc1HcGEoAbm5pg6y6rPjm3/esoINmMYT1hk
    KvdBu7PWOU/7KT5IvFssHQDLogYJkbJg33I3eKc2Yv0UHaoWTwIRC/QREas6lm9V1d13
    YyC/9AaOJ6WYvoF3KdgL6L3LdrsbQoNP0kC6MEgoW9dLEPQZHnNa4zyEv014smkDnrvX
    7b/nRfgWU2MOoGmNfx8ofvjqr8pi2yQm7pdD4mywP3IB2egA0pp2WF4MHwJ6wwit6mBt
    l5VA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675164433;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=FphUiQOJ27CqHQaN9pasoclUDtKk/fYczLFJNRnJdzA=;
    b=gxTJc5bcfkqZ3jAm4dbNoFsKa0LKpMQmu2OScbLbrDvCDzQcifK8dsjfyK5pK6QoZ9
    CX4n7Gu6c3Q5DguveNXoJe2Uvailla1gQ9+Kn8Wg7xSLDOPfQcRFf4Jp4jZ2M3+UEW6K
    SCwcU/7KbEtt7m+/vghI2BdoO6iRp+NBea7CMEMR+jGVGIoPTK7eonjqccgLGNI6tnT2
    RAJoaoiBjLXlcB8iI/IOR7Xodfb8QeCvYL5CO6M1XhaQY0RymbFO4I0IHU9goe5s++Tp
    XhsKqckoKs7PQbDcdhI3ZyIUQC5tj25G4IRRUzeBGA5pQDPFBCtRm+EnUv0gjTMa7Ivb
    vvOA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmQgR17+6Jkvj2j0lZGWSpaEyoLOt"
Received: from blue.lan
    by smtp.strato.de (RZmta 49.2.2 AUTH)
    with ESMTPSA id qa71b9z0VBRDJ9S
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Jan 2023 12:27:13 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v4] can: raw: fix CAN FD frame transmissions over CAN XL devices
Date:   Tue, 31 Jan 2023 12:26:57 +0100
Message-Id: <20230131112657.59247-1-socketcan@hartkopp.net>
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
V4: use separate fd_frames variable instead of rolling back the value (mkl)

 net/can/raw.c | 52 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 81071cdb0301..f64469b98260 100644
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
@@ -521,10 +521,11 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 	struct raw_sock *ro = raw_sk(sk);
 	struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
 	struct can_filter sfilter;         /* single filter */
 	struct net_device *dev = NULL;
 	can_err_mask_t err_mask = 0;
+	int fd_frames;
 	int count = 0;
 	int err = 0;
 
 	if (level != SOL_CAN_RAW)
 		return -EINVAL;
@@ -662,25 +663,33 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 			return -EFAULT;
 
 		break;
 
 	case CAN_RAW_FD_FRAMES:
-		if (optlen != sizeof(ro->fd_frames))
+		if (optlen != sizeof(fd_frames))
 			return -EINVAL;
 
-		if (copy_from_sockptr(&ro->fd_frames, optval, optlen))
+		if (copy_from_sockptr(&fd_frames, optval, optlen))
 			return -EFAULT;
 
+		/* Enabling CAN XL includes CAN FD */
+		if (ro->xl_frames && !fd_frames)
+			return -EINVAL;
+
+		ro->fd_frames = fd_frames;
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
@@ -784,10 +793,29 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
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
@@ -831,24 +859,12 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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

