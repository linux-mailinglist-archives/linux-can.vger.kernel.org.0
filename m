Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646CA749B3B
	for <lists+linux-can@lfdr.de>; Thu,  6 Jul 2023 13:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjGFL6h (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Jul 2023 07:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGFL6h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Jul 2023 07:58:37 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E680171A;
        Thu,  6 Jul 2023 04:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688644526; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eZhrc/z9BJpMdGrTd7kPlejrq6tthGEkwnJh1Jiq+BrrzfLl4TS92HaS8rshwHaLIH
    DLyS5VtRg/f3NKlOCr8L/eFO0tutHLrnxaWaJFc6s1AXyNc4ovzM5xIOQiGz8IjVSCMa
    qRMvaztpIZ1hu9kTv4erPK62wQuRMF9HXQEIC1VSHwtor1us6Ybi+66lPNmGZPe8NKcI
    fqtgAmd8mwuoexxGoViQZpKSbazVtmTMzjv9g5RdzI76B3xP92KHC68DoCEqXxKfz4dl
    4U+T2UgzDpmPoPGKKOomkkiVJT8yxgnzTJWE12mMExmTkHirrJQoPY42A6o5I6JO0f/Q
    Btgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688644526;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=AOXTzDi5h/B07lHAo7FOJdfVUIJvegXlfgKvUXFQp2Q=;
    b=qifp5cdBNcnKuNbAwuKBuQeAifw4yytIiJmMwaG0oOwZKuaVkoe3FcY/X3ys7yIX1A
    FOXullIygqulhjeywC3JpmExmTzlpZocxs5fK970sPHHmP8oPkRJbdm6QnqhyQVpMXJU
    2j331Bhcsysrz2U214k9NRFb3gVs9IEkKtX1F2cYREpGJxmQLLz1jdSQeIoJmw4Z8QVV
    Pm4qJfphSBN8rsA2NjNV33M+eagu2Qvm8Yv8REZ0ZHX2DG+n78l16UEFDlaLMHea/HfL
    CNC4wtiqmJNBfwvpWh8AuUbg8uDvU7TxDX/24YQ+CUGz6uwJN91KU3X6lQLaIGmurgVY
    bAqg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688644526;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=AOXTzDi5h/B07lHAo7FOJdfVUIJvegXlfgKvUXFQp2Q=;
    b=LIpDRSmCnFgSeRIbbOCD+deGQTuZLM6j5Lpj+eTy+mNP5JDRbpRmgfhDr7Sfi8Zdi2
    kfQqmV6bZMOIWq2AqrAEWqeSVp60vHO3CsLw9mZKBih9XIGo9ItzktrDWtYfxB0odQti
    7EEKLw3l0mELQQZxi6UUvtwY6R7NQBmNpHQG1joZwuKN2/BuI6U2APvgWUFVZdk4qSxj
    a9n3uyy8uhoJa6yDQha4FKDwVr8ANDYq/VXQ0p2wmNDD4q2UP1Xd6EjomUGel2JqfxI1
    HrojUU4fAwIWjS5wt8+5ztJlUGJAiCxL8YliTkn8NN6OZPY258iqxr4rH9NwbRpShASl
    Bq1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688644526;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=AOXTzDi5h/B07lHAo7FOJdfVUIJvegXlfgKvUXFQp2Q=;
    b=d9uo8+wS7PwMZbdYrpVhQ0g0UByjoFJicxg/tkWReXPpvTK3BvbzQtZUSI1ptT7qjO
    plopodpp5J1bwLryJpCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0UTfM49EU6zESG7Syney4Zyv6WKe"
Received: from [IPV6:2a00:6020:4a8e:5000:af1c:b276:f0e8:d21]
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id J16f43z66BtPCBa
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 6 Jul 2023 13:55:25 +0200 (CEST)
Message-ID: <2aa65b0c-2170-46c0-57a4-17b653e41f96@hartkopp.net>
Date:   Thu, 6 Jul 2023 13:55:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net] can: raw: fix receiver memory leak
To:     Ziyang Xuan <william.xuanziyang@huawei.com>, mkl@pengutronix.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
References: <20230705092543.648022-1-william.xuanziyang@huawei.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230705092543.648022-1-william.xuanziyang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Ziyang Xuan,

thanks for your patch and the found inconsistency!

The ro->ifindex value might be zero even on a bound CAN_RAW socket which 
results in the use of a common filter for all CAN interfaces, see below ...

On 2023-07-05 11:25, Ziyang Xuan wrote:

(..)

> @@ -277,7 +278,7 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
>   	if (!net_eq(dev_net(dev), sock_net(sk)))
>   		return;
>   
> -	if (ro->ifindex != dev->ifindex)
> +	if (ro->dev != dev)
>   		return;
>   
>   	switch (msg) {
> @@ -292,6 +293,7 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
>   
>   		ro->ifindex = 0;
>   		ro->bound = 0;
> +		ro->dev = NULL;
>   		ro->count = 0;
>   		release_sock(sk);
>   

This would be ok for raw_notify().

> @@ -337,6 +339,7 @@ static int raw_init(struct sock *sk)
>   
>   	ro->bound            = 0;
>   	ro->ifindex          = 0;
> +	ro->dev              = NULL;
>   
>   	/* set default filter to single entry dfilter */
>   	ro->dfilter.can_id   = 0;
> @@ -385,19 +388,13 @@ static int raw_release(struct socket *sock)
>   
>   	lock_sock(sk);
>   
> +	rtnl_lock();
>   	/* remove current filters & unregister */
>   	if (ro->bound) {
> -		if (ro->ifindex) {
> -			struct net_device *dev;
> -
> -			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
> -			if (dev) {
> -				raw_disable_allfilters(dev_net(dev), dev, sk);
> -				dev_put(dev);
> -			}
> -		} else {
> +		if (ro->dev)
> +			raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
> +		else
>   			raw_disable_allfilters(sock_net(sk), NULL, sk);
> -		}
>   	}
>   
>   	if (ro->count > 1)
> @@ -405,8 +402,10 @@ static int raw_release(struct socket *sock)
>   
>   	ro->ifindex = 0;
>   	ro->bound = 0;
> +	ro->dev = NULL;
>   	ro->count = 0;
>   	free_percpu(ro->uniq);
> +	rtnl_unlock();
>   
>   	sock_orphan(sk);
>   	sock->sk = NULL;

This would be ok too.

> @@ -422,6 +421,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>   	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
>   	struct sock *sk = sock->sk;
>   	struct raw_sock *ro = raw_sk(sk);
> +	struct net_device *dev = NULL;
>   	int ifindex;
>   	int err = 0;
>   	int notify_enetdown = 0;
> @@ -431,14 +431,13 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>   	if (addr->can_family != AF_CAN)
>   		return -EINVAL;
>   
> +	rtnl_lock();
>   	lock_sock(sk);
>   
> -	if (ro->bound && addr->can_ifindex == ro->ifindex)
> +	if (ro->bound && ro->dev && addr->can_ifindex == ro->dev->ifindex)

But this is wrong as the case for a bound socket for "all" CAN 
interfaces (ifindex == 0) is not considered.

>   		goto out;
>   
>   	if (addr->can_ifindex) {
> -		struct net_device *dev;
> -
>   		dev = dev_get_by_index(sock_net(sk), addr->can_ifindex);
>   		if (!dev) {
>   			err = -ENODEV;
> @@ -465,28 +464,23 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>   	}
>   
>   	if (!err) {
> +		/* unregister old filters */
>   		if (ro->bound) {
> -			/* unregister old filters */
> -			if (ro->ifindex) {
> -				struct net_device *dev;
> -
> -				dev = dev_get_by_index(sock_net(sk),
> -						       ro->ifindex);
> -				if (dev) {
> -					raw_disable_allfilters(dev_net(dev),
> -							       dev, sk);
> -					dev_put(dev);
> -				}
> -			} else {
> +			if (ro->dev)
> +				raw_disable_allfilters(dev_net(ro->dev),
> +						       ro->dev, sk);
> +			else
>   				raw_disable_allfilters(sock_net(sk), NULL, sk);
> -			}
>   		}
>   		ro->ifindex = ifindex;
> +
>   		ro->bound = 1;
> +		ro->dev = dev;
>   	}
>   
>    out:
>   	release_sock(sk);
> +	rtnl_unlock();

Would it also fix the issue when just adding the rtnl_locks to 
raw_bind() and raw_release() as suggested by you?

Many thanks,
Oliver

>   
>   	if (notify_enetdown) {
>   		sk->sk_err = ENETDOWN;
> @@ -553,9 +547,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   		rtnl_lock();
>   		lock_sock(sk);
>   
> -		if (ro->bound && ro->ifindex) {
> -			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
> -			if (!dev) {
> +		dev = ro->dev;
> +		if (ro->bound && dev) {
> +			if (dev->reg_state != NETREG_REGISTERED) {
>   				if (count > 1)
>   					kfree(filter);
>   				err = -ENODEV;
> @@ -596,7 +590,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   		ro->count  = count;
>   
>    out_fil:
> -		dev_put(dev);
>   		release_sock(sk);
>   		rtnl_unlock();
>   
> @@ -614,9 +607,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   		rtnl_lock();
>   		lock_sock(sk);
>   
> -		if (ro->bound && ro->ifindex) {
> -			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
> -			if (!dev) {
> +		dev = ro->dev;
> +		if (ro->bound && dev) {
> +			if (dev->reg_state != NETREG_REGISTERED) {
>   				err = -ENODEV;
>   				goto out_err;
>   			}
> @@ -627,7 +620,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   			/* (try to) register the new err_mask */
>   			err = raw_enable_errfilter(sock_net(sk), dev, sk,
>   						   err_mask);
> -
>   			if (err)
>   				goto out_err;
>   
> @@ -640,7 +632,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   		ro->err_mask = err_mask;
>   
>    out_err:
> -		dev_put(dev);
>   		release_sock(sk);
>   		rtnl_unlock();
>   
