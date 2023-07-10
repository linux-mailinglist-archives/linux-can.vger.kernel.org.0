Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AFF74DDB2
	for <lists+linux-can@lfdr.de>; Mon, 10 Jul 2023 21:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjGJTBs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Jul 2023 15:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjGJTBr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Jul 2023 15:01:47 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C595100;
        Mon, 10 Jul 2023 12:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689015696; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JAtLBmuVQCnDk3gcmrHkCIrBMeLj60pFqY7FUgK2FVFdGdPzPiPozJMdVZGSD8fIzd
    74W5l9riX/uNY8NU0YkzHZ+vYgkIln0CvySj+Ds173bSmjctWOHXXPVg651jKdG1q1Q5
    mo6tNmiWtNWC1G+CH7PS1gf/BVzrEJ6HCEARpLQV8KI4GH02htS4YamyAdEfHcbmTnEn
    X6tPj0QCMa+UJr+wKNNjGtEgxDRpUpBs1em8tJUE+FoVjOgrKtZJxEH6x6MV61DdyLsK
    wRGzs+Fp0zU8uUXL0GHoGFezifmraWb5Qrc0t3km2bzdOOfSigspij3aS1Nztve6CRio
    lk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689015696;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=kznlLRnPjJrws5rNO41PuXrT6HZntvE6rHlDEHLbmsw=;
    b=taf/g+MDFMCqvBEqX2wVCRztY+YfIKkzRMqYyt0mtfshDxAw4PflJQyTmz8nAgyczs
    gxHM4rouRM9VskBz/HDGkO6Bq8ShTPPyH9Ph7f1N067Q8imFp5huwpR3Qi9MOgpMK4jJ
    bDZBTE11xGLy2BOrSjKq8RJ+mHUamJuvAvf01mvbQeY7fFfnzXsJS70nso44WbQa2TFh
    kq2ii54W4M41sq+IUatuOC1uitgaG23LPSdAtGKDEVfUwxcLpUkqAxOi61cNztu+TnvY
    7mYMnTWr960Yc/D/dHa2fRD8jnkbLJ2gQFlUab7OqzoxqluCdrvYJDkwtxbdO0geNozu
    rlJQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689015696;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=kznlLRnPjJrws5rNO41PuXrT6HZntvE6rHlDEHLbmsw=;
    b=LJumpV6AVV58rwwzcZ8l2l0V+VGQmSFjPzNXL6/HEc+4usLdW6+9KXG9PR81v0ng+3
    ptZIw6gjGldxg7LR0WTey5IBCM/CcVsry/BwQewg5HeHB354qC41wz3kusJ+jZMZHkHq
    5tjyXaJ6NWvVgt43XAo+myyc4z3NvXSisSVD5qxhD0utSpjrtjZ+KgDIA+YBJM2E3zmQ
    422VO0aGSnjDRRQgxtuYZq0LafiUReX9OHpAKPqVx3e9reGwTzaf4MnarcxFgQMrTp4D
    XYCOM6772vq6aiqsq9RP0aXxrlSGKCMhlFqAD41rdxvzCMMo96irDtfEcHZHyYYj/47t
    Pn1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689015696;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=kznlLRnPjJrws5rNO41PuXrT6HZntvE6rHlDEHLbmsw=;
    b=CU9wZzXuwWqZiuXVTl+41RfB9OVl6oaxulpKgKjIXeC0waXUGDE/Ce2pViS+rsT2xt
    9pesu5BsoqZ9ewUt5CDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id J16f43z6AJ1ZMK5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 10 Jul 2023 21:01:35 +0200 (CEST)
Message-ID: <5c396de6-afab-6af9-f9d9-a698b9367873@hartkopp.net>
Date:   Mon, 10 Jul 2023 21:01:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net v2] can: raw: fix receiver memory leak
To:     Ziyang Xuan <william.xuanziyang@huawei.com>, mkl@pengutronix.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
References: <20230707075342.2463015-1-william.xuanziyang@huawei.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230707075342.2463015-1-william.xuanziyang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello William,

On 07.07.23 09:53, Ziyang Xuan wrote:
> Got kmemleak errors with the following ltp can_filter testcase:
> 
> for ((i=1; i<=100; i++))
> do
>          ./can_filter &
>          sleep 0.1
> done
> 
> ==============================================================
> [<00000000db4a4943>] can_rx_register+0x147/0x360 [can]
> [<00000000a289549d>] raw_setsockopt+0x5ef/0x853 [can_raw]
> [<000000006d3d9ebd>] __sys_setsockopt+0x173/0x2c0
> [<00000000407dbfec>] __x64_sys_setsockopt+0x61/0x70
> [<00000000fd468496>] do_syscall_64+0x33/0x40
> [<00000000b7e47d51>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
> 
> It's a bug in the concurrent scenario of unregister_netdevice_many()
> and raw_release() as following:
> 
>               cpu0                                        cpu1
> unregister_netdevice_many(can_dev)
>    unlist_netdevice(can_dev) // dev_get_by_index() return NULL after this
>    net_set_todo(can_dev)
> 						raw_release(can_socket)
> 						  dev = dev_get_by_index(, ro->ifindex); // dev == NULL
> 						  if (dev) { // receivers in dev_rcv_lists not free because dev is NULL
> 						    raw_disable_allfilters(, dev, );
> 						    dev_put(dev);
> 						  }
> 						...
> 						ro->bound = 0;
> 						...
> 
> call_netdevice_notifiers(NETDEV_UNREGISTER, )
>    raw_notify(, NETDEV_UNREGISTER, )
>      if (ro->bound) // invalid because ro->bound has been set 0
>        raw_disable_allfilters(, dev, ); // receivers in dev_rcv_lists will never be freed
> 
> Add a net_device pointer member in struct raw_sock to record bound can_dev,
> and use rtnl_lock to serialize raw_socket members between raw_bind(), raw_release(),
> raw_setsockopt() and raw_notify(). Use ro->dev to decide whether to free receivers in
> dev_rcv_lists.
> 
> Fixes: 8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevice notifier")
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> ---
> v2:
>    - Fix the case for a bound socket for "all" CAN interfaces (ifindex == 0) in raw_bind().
> ---
>   net/can/raw.c | 61 ++++++++++++++++++++++-----------------------------
>   1 file changed, 26 insertions(+), 35 deletions(-)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 15c79b079184..7078821f35e0 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -84,6 +84,7 @@ struct raw_sock {
>   	struct sock sk;
>   	int bound;
>   	int ifindex;
> +	struct net_device *dev;
>   	struct list_head notifier;
>   	int loopback;
>   	int recv_own_msgs;
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
>   	if (ro->bound && addr->can_ifindex == ro->ifindex)
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

Please move this comment back as we only unregister old filters when the 
socket is bound.

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

Why did you add an additional empty line here?
Please remove.

>   		ro->bound = 1;
> +		ro->dev = dev;
>   	}
>   
>    out:
>   	release_sock(sk);
> +	rtnl_unlock();
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

And here you removed an empty line?

Please omit such mix of fixing a bug and change the coding style.

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

The rest looks fine now, many thanks!
It also reduces the code size.

When you send the v3 you can add these tags:

Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Best regards,
Oliver
