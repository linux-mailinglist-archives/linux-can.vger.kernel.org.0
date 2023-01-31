Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08A3682893
	for <lists+linux-can@lfdr.de>; Tue, 31 Jan 2023 10:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjAaJT2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Jan 2023 04:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjAaJTP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2023 04:19:15 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A03DCD
        for <linux-can@vger.kernel.org>; Tue, 31 Jan 2023 01:18:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675156710; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pSchHMZ2VZpS9TCFo1Gs/WM0PAy75rZMR5pPhtK0S57Gez73mAWqW8OQdk/QOW3+V4
    NzmN7SaxqbLZlC1EFDI4UisygltOh1464KND2QAtDloFNeOGFmeFQw+Bbgco1FMUL2pY
    H9dZWf2ci2Tkm9WImfM6pB5RNkwtKdQ5eRC7+F/9EDJawL85nzPtqsxvTwIzvCrlibCo
    Er9HByeVjZkOxkm4c1veyaX18cuug88Ox4yvInOdkJ3yD1diL8mafMHgJKcg3uX4dTrX
    8MBAJOpgdPgkaee7xhZDl3cnpn+OZ0HpKRBD9phQYJTUj+Ydf/EMIZTPy2aHNsCAokjJ
    4QFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675156710;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=g63u2Jweh/D4aQsfFDzfVgihSr28iVRNErhdUzc307I=;
    b=qlBsT/q4+3a9Iygt2kSgQImZPDomIFiinrtENv/xRcHE/RSKPLk+nVJcs1E4v3zPMI
    y4auR11oMgUB1/Ux7Q4OWzJS9vaxFCq+oKtxBpGrrqNBYT4sGZUoehQB2ZWIt+IQWuZv
    9BnnHwmUD64lzTp8u/oRe1qjhtO8dHaMEc59WXoTi7opi3yGfYILXDgkGYmKPpexiygY
    DjLS7WgwJtrd2ZQnuN5dz6KaNykiEbDTOFUI8qDaBqhhi95wWEO0EaPqbyMz5SqLi0w0
    msHDoaBbfgEw30I7sn2k88aNQlViXgG5TV7snSfwkxgr3wtRMRv1/Lo6PM3toOaEnES4
    IbdQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675156710;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=g63u2Jweh/D4aQsfFDzfVgihSr28iVRNErhdUzc307I=;
    b=eCm0pTg+D2dDnECfR+rAoHVa0GFvbQrf/2BOVXNFGjGjPSHNaib2KUgFKqQJyatobz
    9458spaB8/D/9VIbNtdVXCGi2Il8unV/H8EOqo17sLx8UrXPSA+l3T3g7XMNk5pHQ2Of
    595QMA9l+5VpCE1J3hbPj/uDCNkSLcF5IPGzwcb6riuKBV58PRMAWLwL1hQMC13EaD1+
    MtbIX7HygwR9MLoxWo1Kg1ai+Sz6BmC8paweHO0IXU9sukGrTiojvtpcXIVUOw9WpStd
    UxWjyAjBNDwRb1HpZkZoPHaMVnjs5RE+ko9d/buWYcjXAcNLY2ZschdyUU0rVETQfr35
    2H3g==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmQgR17+6Jkvj2j0lZGWSpaEyoLOt"
Received: from blue.lan
    by smtp.strato.de (RZmta 49.2.2 AUTH)
    with ESMTPSA id qa71b9z0V9IUIFf
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Jan 2023 10:18:30 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2] can: raw: fix CAN FD frame transmissions over CAN XL devices
Date:   Tue, 31 Jan 2023 10:18:24 +0100
Message-Id: <20230131091824.51026-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

V2: fixed typo: devive -> device

net/can/raw.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 81071cdb0301..c505d315a7a9 100644
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
+	/* Classical CAN -> no checks for flags and device capabilities */
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

