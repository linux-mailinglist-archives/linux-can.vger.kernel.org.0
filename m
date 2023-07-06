Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAC0749C77
	for <lists+linux-can@lfdr.de>; Thu,  6 Jul 2023 14:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjGFMt0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Jul 2023 08:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjGFMtJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Jul 2023 08:49:09 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABED212E;
        Thu,  6 Jul 2023 05:48:45 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qxbsp57XWz1HCtt;
        Thu,  6 Jul 2023 20:47:58 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 20:48:25 +0800
Subject: Re: [PATCH net] can: raw: fix receiver memory leak
To:     Oliver Hartkopp <socketcan@hartkopp.net>, <mkl@pengutronix.de>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-can@vger.kernel.org>,
        <netdev@vger.kernel.org>, <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20230705092543.648022-1-william.xuanziyang@huawei.com>
 <2aa65b0c-2170-46c0-57a4-17b653e41f96@hartkopp.net>
From:   "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <4880eff5-1009-add8-8c58-ac31ab6771db@huawei.com>
Date:   Thu, 6 Jul 2023 20:48:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2aa65b0c-2170-46c0-57a4-17b653e41f96@hartkopp.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> Hello Ziyang Xuan,
> 
> thanks for your patch and the found inconsistency!
> 
> The ro->ifindex value might be zero even on a bound CAN_RAW socket which results in the use of a common filter for all CAN interfaces, see below ...
> 
> On 2023-07-05 11:25, Ziyang Xuan wrote:
> 
> (..)
> 
>> @@ -277,7 +278,7 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
>>       if (!net_eq(dev_net(dev), sock_net(sk)))
>>           return;
>>   -    if (ro->ifindex != dev->ifindex)
>> +    if (ro->dev != dev)
>>           return;
>>         switch (msg) {
>> @@ -292,6 +293,7 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
>>             ro->ifindex = 0;
>>           ro->bound = 0;
>> +        ro->dev = NULL;
>>           ro->count = 0;
>>           release_sock(sk);
>>   
> 
> This would be ok for raw_notify().
> 
>> @@ -337,6 +339,7 @@ static int raw_init(struct sock *sk)
>>         ro->bound            = 0;
>>       ro->ifindex          = 0;
>> +    ro->dev              = NULL;
>>         /* set default filter to single entry dfilter */
>>       ro->dfilter.can_id   = 0;
>> @@ -385,19 +388,13 @@ static int raw_release(struct socket *sock)
>>         lock_sock(sk);
>>   +    rtnl_lock();
>>       /* remove current filters & unregister */
>>       if (ro->bound) {
>> -        if (ro->ifindex) {
>> -            struct net_device *dev;
>> -
>> -            dev = dev_get_by_index(sock_net(sk), ro->ifindex);
>> -            if (dev) {
>> -                raw_disable_allfilters(dev_net(dev), dev, sk);
>> -                dev_put(dev);
>> -            }
>> -        } else {
>> +        if (ro->dev)
>> +            raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
>> +        else
>>               raw_disable_allfilters(sock_net(sk), NULL, sk);
>> -        }
>>       }
>>         if (ro->count > 1)
>> @@ -405,8 +402,10 @@ static int raw_release(struct socket *sock)
>>         ro->ifindex = 0;
>>       ro->bound = 0;
>> +    ro->dev = NULL;
>>       ro->count = 0;
>>       free_percpu(ro->uniq);
>> +    rtnl_unlock();
>>         sock_orphan(sk);
>>       sock->sk = NULL;
> 
> This would be ok too.
> 
>> @@ -422,6 +421,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>>       struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
>>       struct sock *sk = sock->sk;
>>       struct raw_sock *ro = raw_sk(sk);
>> +    struct net_device *dev = NULL;
>>       int ifindex;
>>       int err = 0;
>>       int notify_enetdown = 0;
>> @@ -431,14 +431,13 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>>       if (addr->can_family != AF_CAN)
>>           return -EINVAL;
>>   +    rtnl_lock();
>>       lock_sock(sk);
>>   -    if (ro->bound && addr->can_ifindex == ro->ifindex)
>> +    if (ro->bound && ro->dev && addr->can_ifindex == ro->dev->ifindex)
> 
> But this is wrong as the case for a bound socket for "all" CAN interfaces (ifindex == 0) is not considered.

Yes, here need not modification. I will fix it in v2. Thanks!

> 
>>           goto out;
>>         if (addr->can_ifindex) {
>> -        struct net_device *dev;
>> -
>>           dev = dev_get_by_index(sock_net(sk), addr->can_ifindex);
>>           if (!dev) {
>>               err = -ENODEV;
>> @@ -465,28 +464,23 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>>       }
>>         if (!err) {
>> +        /* unregister old filters */
>>           if (ro->bound) {
>> -            /* unregister old filters */
>> -            if (ro->ifindex) {
>> -                struct net_device *dev;
>> -
>> -                dev = dev_get_by_index(sock_net(sk),
>> -                               ro->ifindex);
>> -                if (dev) {
>> -                    raw_disable_allfilters(dev_net(dev),
>> -                                   dev, sk);
>> -                    dev_put(dev);
>> -                }
>> -            } else {
>> +            if (ro->dev)
>> +                raw_disable_allfilters(dev_net(ro->dev),
>> +                               ro->dev, sk);
>> +            else
>>                   raw_disable_allfilters(sock_net(sk), NULL, sk);
>> -            }
>>           }
>>           ro->ifindex = ifindex;
>> +
>>           ro->bound = 1;
>> +        ro->dev = dev;
>>       }
>>      out:
>>       release_sock(sk);
>> +    rtnl_unlock();
> 
> Would it also fix the issue when just adding the rtnl_locks to raw_bind() and raw_release() as suggested by you?

This patch just add rtnl_lock in raw_bind() and raw_release(). raw_setsockopt() has rtnl_lock before this. raw_notify()
is under rtnl_lock. My patch has been tested and solved the issue before send. I don't know if it answered your doubts.

Thanks.
William Xuan

> 
> Many thanks,
> Oliver
> 
>>         if (notify_enetdown) {
>>           sk->sk_err = ENETDOWN;
>> @@ -553,9 +547,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>>           rtnl_lock();
>>           lock_sock(sk);
>>   -        if (ro->bound && ro->ifindex) {
>> -            dev = dev_get_by_index(sock_net(sk), ro->ifindex);
>> -            if (!dev) {
>> +        dev = ro->dev;
>> +        if (ro->bound && dev) {
>> +            if (dev->reg_state != NETREG_REGISTERED) {
>>                   if (count > 1)
>>                       kfree(filter);
>>                   err = -ENODEV;
>> @@ -596,7 +590,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>>           ro->count  = count;
>>      out_fil:
>> -        dev_put(dev);
>>           release_sock(sk);
>>           rtnl_unlock();
>>   @@ -614,9 +607,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>>           rtnl_lock();
>>           lock_sock(sk);
>>   -        if (ro->bound && ro->ifindex) {
>> -            dev = dev_get_by_index(sock_net(sk), ro->ifindex);
>> -            if (!dev) {
>> +        dev = ro->dev;
>> +        if (ro->bound && dev) {
>> +            if (dev->reg_state != NETREG_REGISTERED) {
>>                   err = -ENODEV;
>>                   goto out_err;
>>               }
>> @@ -627,7 +620,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>>               /* (try to) register the new err_mask */
>>               err = raw_enable_errfilter(sock_net(sk), dev, sk,
>>                              err_mask);
>> -
>>               if (err)
>>                   goto out_err;
>>   @@ -640,7 +632,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>>           ro->err_mask = err_mask;
>>      out_err:
>> -        dev_put(dev);
>>           release_sock(sk);
>>           rtnl_unlock();
>>   
> .
