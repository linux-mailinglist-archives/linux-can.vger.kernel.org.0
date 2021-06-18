Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7353AD146
	for <lists+linux-can@lfdr.de>; Fri, 18 Jun 2021 19:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhFRRje (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Jun 2021 13:39:34 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:34442 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbhFRRjd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Jun 2021 13:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624037843;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=81qybrTuh+8yTCyfNuJWxCj+bVJLUfqkoiJw1LbKKzI=;
    b=rIeMREbSO9CXQCWOCU3EJHdOez/YBPBU059lqTsfyS8bi1aa5qkUz5FLxMKDdXgNgr
    CkMp97y9JFxfK//nMdxXWvbmInxJpEoXN5S62kMEdJIePkm3LU0+ctPe347qrsxXuBHu
    hOzXYYjEKRb3tG8tUopMenxL35Dr2i1rPIzHke2Q6oelfR/Acw/KyEH0fdts7lUWkOYy
    idcrkSVB/5gvTt3g/kgFcEsfSeDxfw/jmYJoUz0OZrrAY9bzKrQX2/mfQ8wBKvMtw5kO
    jLX+yL4ygJDzppSeZMpk5czR4XD5AKhKs/nkGuSrG2uHZjXIKFSFbo1P+7mr8QKtSQm3
    lHKw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejudJywjsS7yVw=="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.27.3 DYNA|AUTH)
    with ESMTPSA id N0b2dax5IHbN2ut
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 18 Jun 2021 19:37:23 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: isotp: omit unintended hrtimer restart on socket release
Date:   Fri, 18 Jun 2021 19:37:13 +0200
Message-Id: <20210618173713.2296-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When closing the isotp socket the potentially running hrtimers are
canceled before removing the subscription for CAN idendifiers via
can_rx_unregister().

This may lead to an unintended (re)start of a hrtimer in isotp_rcv_cf()
and isotp_rcv_fc() in the case that a CAN frame is received by
isotp_rcv() while the subscription removal is processed.

However, isotp_rcv() is called under RCU protection, so after calling
can_rx_unregister, we may call synchronize_rcu in order to wait for any
RCU read-side critical sections to finish. This prevents the reception
of CAN frames after hrtimer_cancel() and therefore the unintended
(re)start of the hrtimers.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index be6183f8ca11..234cc4ad179a 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1026,13 +1026,10 @@ static int isotp_release(struct socket *sock)
 	list_del(&so->notifier);
 	spin_unlock(&isotp_notifier_lock);
 
 	lock_sock(sk);
 
-	hrtimer_cancel(&so->txtimer);
-	hrtimer_cancel(&so->rxtimer);
-
 	/* remove current filters & unregister */
 	if (so->bound && (!(so->opt.flags & CAN_ISOTP_SF_BROADCAST))) {
 		if (so->ifindex) {
 			struct net_device *dev;
 
@@ -1040,14 +1037,18 @@ static int isotp_release(struct socket *sock)
 			if (dev) {
 				can_rx_unregister(net, dev, so->rxid,
 						  SINGLE_MASK(so->rxid),
 						  isotp_rcv, sk);
 				dev_put(dev);
+				synchronize_rcu();
 			}
 		}
 	}
 
+	hrtimer_cancel(&so->txtimer);
+	hrtimer_cancel(&so->rxtimer);
+
 	so->ifindex = 0;
 	so->bound = 0;
 
 	sock_orphan(sk);
 	sock->sk = NULL;
-- 
2.30.2

