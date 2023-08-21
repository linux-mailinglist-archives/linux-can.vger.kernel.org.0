Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1F0782C6A
	for <lists+linux-can@lfdr.de>; Mon, 21 Aug 2023 16:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbjHUOqq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Aug 2023 10:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjHUOqq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Aug 2023 10:46:46 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154ACE8;
        Mon, 21 Aug 2023 07:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692629175; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aQCsGcbRfmfGl/q+7g/wiE3yu2ZOGOFEVInQsXO9r6FMTkJKfOUtJq+UAO17jPVNpW
    3hzLQelvILzXckVToJgk3XwaUk7Wr6i2SeO7laZvqtfFrICy1s483Kv+rg7XiHQ2elln
    iyqHkdJ4j4bkPT92lHR8OEQpJunUeIZl6mTvgIaIiJA1TCVdDLt/Wcn0LkOVOJoef8nh
    04e9+Dwv4P8gXpsu7I+FWkcUTQ3uzzlWkGvelyPXiuReSd/CFzOPLI0TYp33zKKIhmDc
    w1J493+xITBwM50nlgA7Pkp3yxlvRJRz+wo64csjwt0RfiHtwkSmgbHJwOY8R2Bjslkb
    uizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692629175;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TOZWLA4hvvYY6SCL4NWlwxYl/OkEsC4lztwb1CXM6WY=;
    b=IfQ6/8pLx6fGv9YnZ0T/XUaROlpvoNURZk3I71r2RtF6NvOSyVZb9hZTaB83hIHLcQ
    +FZQGS0OTSat/QGrDy9LromM1f22BiUqv/VIzIjby4FVWCjJjvoaGcQRahzyFf6hYjMo
    24P10BO75PX5mXb+IJGCUMkFslo8EaYK6+xZDsliDOF3CG31W4EG900jq/EKi550HBcR
    GiUcBmImyhUB0yu1HkN86ANnnmofSiSYZuc9vQT7kAxQzwGHSRdqugZuXASrZHZjcJRT
    6DZVo/Nay8DGI/6mPNCxC1WgYj1/z43rYxcPZBm2EEleuM8HhFnnzQdIOEQmAXye+hGp
    +WTQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692629175;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TOZWLA4hvvYY6SCL4NWlwxYl/OkEsC4lztwb1CXM6WY=;
    b=WmPY7xK2R2H0huC4K0Rf4f1O7WuCuXIs4T0SakviJ6szLCLcA50DUj5jTpOyknEvT5
    aStSjGH5ZYyX31ILUDk8lX0Csf6AztaAXYNkLchDCHVnnjyYn43J73AVomWtJa8cTIil
    oKbhySum0J7Tl3WeX6OOjN5CYZFCQVL380LvfpgE2Pyq8O20AgBwpcwuGWzrEPkGxafe
    cBadKiOb55OzxCYM2KPibC/Fmit1CaM5k8ufnPFG/+KhSXuOSNhUZSUss7pm3I2lLsgL
    4f21eGl6y9s20rlxlHiqtXo5EHr+ypP3064md7/swKdtHxV4Gr3kq0CIhwu3XMteaWV4
    eSig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692629175;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TOZWLA4hvvYY6SCL4NWlwxYl/OkEsC4lztwb1CXM6WY=;
    b=l247Gq9qYmr8QE1AkRo5IeCaeeVPAesYLY/E0FizI0xez8YRrOr7CkVzRrbe7MM4My
    00NTYv7Dl3iSpsvJj2Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3cmcZPR3l4"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.8.1 AUTH)
    with ESMTPSA id K723f1z7LEkE0hO
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 21 Aug 2023 16:46:14 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
        edumazet@google.com, mkl@pengutronix.de
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Ziyang Xuan <william.xuanziyang@huawei.com>
Subject: [NET 2/2] can: raw: add missing refcount for memory leak fix
Date:   Mon, 21 Aug 2023 16:45:47 +0200
Message-Id: <20230821144547.6658-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230821144547.6658-1-socketcan@hartkopp.net>
References: <20230821144547.6658-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 net/can/raw.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index e10f59375659..d50c3f3d892f 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -83,10 +83,11 @@ struct uniqframe {
 struct raw_sock {
 	struct sock sk;
 	int bound;
 	int ifindex;
 	struct net_device *dev;
+	netdevice_tracker dev_tracker;
 	struct list_head notifier;
 	int loopback;
 	int recv_own_msgs;
 	int fd_frames;
 	int xl_frames;
@@ -283,12 +284,14 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 		/* remove current filters & unregister */
-		if (ro->bound)
+		if (ro->bound) {
 			raw_disable_allfilters(dev_net(dev), dev, sk);
+			netdev_put(dev, &ro->dev_tracker);
+		}
 
 		if (ro->count > 1)
 			kfree(ro->filter);
 
 		ro->ifindex = 0;
@@ -389,14 +392,16 @@ static int raw_release(struct socket *sock)
 	rtnl_lock();
 	lock_sock(sk);
 
 	/* remove current filters & unregister */
 	if (ro->bound) {
-		if (ro->dev)
+		if (ro->dev) {
 			raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
-		else
+			netdev_put(ro->dev, &ro->dev_tracker);
+		} else {
 			raw_disable_allfilters(sock_net(sk), NULL, sk);
+		}
 	}
 
 	if (ro->count > 1)
 		kfree(ro->filter);
 
@@ -443,44 +448,56 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		if (!dev) {
 			err = -ENODEV;
 			goto out;
 		}
 		if (dev->type != ARPHRD_CAN) {
-			dev_put(dev);
 			err = -ENODEV;
-			goto out;
+			goto out_put_dev;
 		}
+
 		if (!(dev->flags & IFF_UP))
 			notify_enetdown = 1;
 
 		ifindex = dev->ifindex;
 
 		/* filters set by default/setsockopt */
 		err = raw_enable_allfilters(sock_net(sk), dev, sk);
-		dev_put(dev);
+		if (err)
+			goto out_put_dev;
+
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
+				netdev_put(ro->dev, &ro->dev_tracker);
+			} else {
 				raw_disable_allfilters(sock_net(sk), NULL, sk);
+			}
 		}
 		ro->ifindex = ifindex;
 		ro->bound = 1;
+		/* bind() ok -> hold a reference for new ro->dev */
 		ro->dev = dev;
+		if (ro->dev)
+			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
 	}
 
- out:
+out_put_dev:
+	/* remove potential reference from dev_get_by_index() */
+	if (dev)
+		dev_put(dev);
+out:
 	release_sock(sk);
 	rtnl_unlock();
 
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
-- 
2.39.2

