Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BC877D0B5
	for <lists+linux-can@lfdr.de>; Tue, 15 Aug 2023 19:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbjHORPu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Aug 2023 13:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbjHORPX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Aug 2023 13:15:23 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1D819BF
        for <linux-can@vger.kernel.org>; Tue, 15 Aug 2023 10:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692119704; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tJmwIimui+p0HVGOlc7CDEtox1wc60hR838rUnPFdCLFKOUEMYubP7/kApmB8drdy7
    oBAxULonqU9Ide5YorOW2L4Xph7XkZ9fpOxPLwePkzfn63XOgrI7lWPZLP6kBhtY/tJ2
    1P8z7dwv3QzcSBy28shGgqBTGFUx5V0jvQK8FDOqnDs6LBKjyx2lwNKSe7/1qvZAkUJV
    tInAs+Ss9pHu0J5vxpfIVyzpa5ErWF0X/4Ho0dv8L60dmpnkMNybOHvlf1167/x9fvPs
    gHrZrQAVQ0mkwmFSBm/ULMFreMYhc0bNoxmg6sKemHw/7iciDqgfUtwFgZJpgMe5TgP6
    b0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692119704;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=TOZWLA4hvvYY6SCL4NWlwxYl/OkEsC4lztwb1CXM6WY=;
    b=YrvDNHgJdO5qu75UWu7zNlJjxN3LV6Ra4RcqHAwi+vWRmLQT2/EstARGxQLz81mnfG
    HFlGKfxo11FRq1UuH6JDH4SM1SbejCwkWbBdQ+n0q+5jKN/YYeZAeV4uKz0NgIQLJjbQ
    13pTwOT7eCUdeAW/xeGhkYcx3eYQo67FLUxd3DAzCZtZZdPau9JbJy8OmzUpJuGBEpz2
    G4VyPw//95RKSEqivA/QohTayy5H25OCsFBcrfgpogPd10zVDoeTqDWoimXjLI8h3FU/
    eGTErha4fzh3TzT8jj2OFrO7PgftY29zPnI+dPIP55ohusKxrKWixWMV3iKkd0aa4bWm
    L5rg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692119704;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=TOZWLA4hvvYY6SCL4NWlwxYl/OkEsC4lztwb1CXM6WY=;
    b=Kr4LzyPmiP5GTYFsvR+MMaK3gK34woAxmyU7ujlmbKsdbTDlnHKRocGTdID0L6zh4I
    KPQklxsT7GDKOaCNtixxeiEjzs+IVuA2aWIv7kqa76e5mWFGGSjJ9iqbYqFA+QpSAg7h
    d704KMXHzx0/0Jll0DbZyvyPnzqyG7EKqiRWZgS7PCYPNub8pDYHiuspFHIy3BgjOh17
    uAN2kKxYvAG1WvCud/wJ07NbeBqY9EPxqe158UjQpQq7RjdEDbRnZkMSimP6hZI7rmhi
    ZYj6YosH01d8jw3XO9D0dfTNn0vL6bGNn0ZeG/c4TDalRbqB9zwr1xguGJiQSBuVrIu2
    ECtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692119704;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=TOZWLA4hvvYY6SCL4NWlwxYl/OkEsC4lztwb1CXM6WY=;
    b=iGqrsQUivATvmaY/qcdgQn7YPcMuULUGe+6SYufcwLtqbktj1Km54Pe9uTJEhwg968
    ZhBfAzvTCHNiJAK/O8AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3cmcZPR3l4"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.8.0 AUTH)
    with ESMTPSA id D79666z7FHF309h
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 15 Aug 2023 19:15:03 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Eric Dumazet <edumazet@google.com>,
        Ziyang Xuan <william.xuanziyang@huawei.com>
Subject: [PATCH] can: raw: add missing refcount for memory leak fix
Date:   Tue, 15 Aug 2023 19:14:47 +0200
Message-Id: <20230815171447.10879-1-socketcan@hartkopp.net>
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

