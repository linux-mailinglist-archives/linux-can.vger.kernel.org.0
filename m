Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459DC76FF79
	for <lists+linux-can@lfdr.de>; Fri,  4 Aug 2023 13:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjHDL2p (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Aug 2023 07:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHDL2o (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 4 Aug 2023 07:28:44 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552D1E7
        for <linux-can@vger.kernel.org>; Fri,  4 Aug 2023 04:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1691148510; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WdbgucZN7gJjs9qTtOqYpYHeIGd+xlnLiuH4Ss/jPiJ84CrsD3SAzgXN56gA7ErKOA
    jIn9guhBAPHwPXL3EDwPd2tPBNF/44cHCqUolOZx85B8iupWkI7etL+9/u1G3/eZHtpx
    yxfAmdJchhJNd+o3IAj/2aznSyfI8CvhfabPEBY/RLPN15YtgCTXTcgCzNUvWK4LvuGQ
    1/H6TFjRf7swAggykKVmL9w/sMiH60BotmathviZHw3zrqw2AqRbl0665ezBCSQYPEjK
    YX26iv8TYP/UQTYjEhBF8VXd0eFZS+yexpiNHL8WvLQBjpPu8gjuSg8l23RmIgjqlwTB
    FLkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1691148510;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Cnnf+NocKQgyYgzGqCCIziaAg97RNZY6MeZ4SyOcGS8=;
    b=cDk0utbooPYl3a0A7VNFXKnuZKBGwfApmyGr6MP68SpgiKsQRpOxgoVjoVG8igZYmr
    4xUWy2akZ954gUMZHBYbWOh2t71Z+EOGfTPxRHn+sXl4u/TBQ85gKcrlo2PmU9vvjePD
    49Ys68ebNWssR1Up8VWJgva2ig2E8CFv+lJ9IOUvS1aOsza1E0AI95hunuyWnqPQCMgd
    pCXhD45TOWyo+7MHde1nABkDgtBxFY9Ws8KK956En2IabvHj82y5pDTM+zFbWljWgEL3
    mWn190iI7hXPDOk7uI34C1TS1x3LgQcMCX5M+XPGg4bKIm1fepaSxYCt+vuW1MmvGcIB
    hKWg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1691148510;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Cnnf+NocKQgyYgzGqCCIziaAg97RNZY6MeZ4SyOcGS8=;
    b=VDZAVmBHJ37cRyO4IR1EHKa7fEjgJwc+XDEXGv6S6/KmpMcQ/uyd4D2hTcZdmVQgFd
    OBsMTCYzhgyVArD7PtMWExGpedCC4q41D6p3mYe2+o+FD8d3ne3lpaHhQvOXVmiurwMN
    Bp9SF08GJWrRqheTrpg9xxg4LB6n/qu/fnxCOhnGG9q7JNTJoNcKJVHkXWJGeIObxh6Y
    55nnjmovIlZqH1rpA6/C5N8MJsGmh71wCV5TAAZg6mzoHk3FmxMNwdWIBh3qaswH48Ad
    76MDlKb/A16aKCe0/B8x+TVjyB30qIQbBFHTbSngIVGeiNxZysHzX6HzjS2NoUROJS2T
    heRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1691148509;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Cnnf+NocKQgyYgzGqCCIziaAg97RNZY6MeZ4SyOcGS8=;
    b=JA21DmQbVfgSkOkUSKOacS5V6PQ0Pmy37kCrOtwGsi4TaEw9HDf4nHbuyLFO2Y2wJP
    XYnkB53gca1IM3HLe/BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3cmcZPR3l4"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.6.6 AUTH)
    with ESMTPSA id 69691ez74BSTRLq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 4 Aug 2023 13:28:29 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Eric Dumazet <edumazet@google.com>,
        Ziyang Xuan <william.xuanziyang@huawei.com>
Subject: [RFC PATCH] can: raw: add missing refcount for memory leak fix
Date:   Fri,  4 Aug 2023 13:28:11 +0200
Message-Id: <20230804112811.42259-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Commit ee8b94c8510c ("can: raw: fix receiver memory leak") introduced
a new reference to the CAN netdevice that has assigned CAN filters.
But this new ro->dev reference did not maintain its own refcount which
lead to another KASAN use-after-free splat found by Eric Dumazet.

This patch ensures a proper refcount for the CAN nedevice.

Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
Reported-by: Eric Dumazet <edumazet@google.com>
Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index e10f59375659..a61c417fdd27 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -283,12 +283,14 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 		/* remove current filters & unregister */
-		if (ro->bound)
+		if (ro->bound) {
 			raw_disable_allfilters(dev_net(dev), dev, sk);
+			dev_put(dev);
+		}
 
 		if (ro->count > 1)
 			kfree(ro->filter);
 
 		ro->ifindex = 0;
@@ -389,14 +391,16 @@ static int raw_release(struct socket *sock)
 	rtnl_lock();
 	lock_sock(sk);
 
 	/* remove current filters & unregister */
 	if (ro->bound) {
-		if (ro->dev)
+		if (ro->dev) {
 			raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
-		else
+			dev_put(ro->dev);
+		} else {
 			raw_disable_allfilters(sock_net(sk), NULL, sk);
+		}
 	}
 
 	if (ro->count > 1)
 		kfree(ro->filter);
 
@@ -447,36 +451,43 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		if (dev->type != ARPHRD_CAN) {
 			dev_put(dev);
 			err = -ENODEV;
 			goto out;
 		}
-		if (!(dev->flags & IFF_UP))
-			notify_enetdown = 1;
-
-		ifindex = dev->ifindex;
 
 		/* filters set by default/setsockopt */
 		err = raw_enable_allfilters(sock_net(sk), dev, sk);
-		dev_put(dev);
+		if (err) {
+			dev_put(dev);
+			goto out;
+		}
+
+		ifindex = dev->ifindex;
+		if (!(dev->flags & IFF_UP))
+			notify_enetdown = 1;
 	} else {
 		ifindex = 0;
 
 		/* filters set by default/setsockopt */
 		err = raw_enable_allfilters(sock_net(sk), NULL, sk);
 	}
 
 	if (!err) {
 		if (ro->bound) {
 			/* unregister old filters */
-			if (ro->dev)
+			if (ro->dev) {
 				raw_disable_allfilters(dev_net(ro->dev),
 						       ro->dev, sk);
-			else
+				/* drop reference to old ro->dev */
+				dev_put(ro->dev);
+			} else {
 				raw_disable_allfilters(sock_net(sk), NULL, sk);
+			}
 		}
 		ro->ifindex = ifindex;
 		ro->bound = 1;
+		/* bind() ok -> holding a reference to new ro->dev */
 		ro->dev = dev;
 	}
 
  out:
 	release_sock(sk);
-- 
2.39.2

