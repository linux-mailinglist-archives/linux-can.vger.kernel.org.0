Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1F4758CBA
	for <lists+linux-can@lfdr.de>; Wed, 19 Jul 2023 06:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjGSElc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Jul 2023 00:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSElb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Jul 2023 00:41:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91FF1BDC;
        Tue, 18 Jul 2023 21:41:29 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R5NRb3nT4zrRnh;
        Wed, 19 Jul 2023 12:40:43 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 12:41:27 +0800
Subject: Re: [PATCH net v3] can: raw: fix receiver memory leak
To:     Eric Dumazet <edumazet@google.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <socketcan@hartkopp.net>, <davem@davemloft.net>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-can@vger.kernel.org>,
        <netdev@vger.kernel.org>, <penguin-kernel@i-love.sakura.ne.jp>
References: <20230711011737.1969582-1-william.xuanziyang@huawei.com>
 <20230717-clubhouse-swinger-8f0fa23b0628-mkl@pengutronix.de>
 <CANn89iJ47sVXAEEryvODoGv-iUpT-ACTCSWQTmdtJ9Fqs0s40Q@mail.gmail.com>
From:   "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <1e0e6539-412a-cc8d-b104-e2921a099e48@huawei.com>
Date:   Wed, 19 Jul 2023 12:41:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CANn89iJ47sVXAEEryvODoGv-iUpT-ACTCSWQTmdtJ9Fqs0s40Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> On Mon, Jul 17, 2023 at 9:27 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>
>> On 11.07.2023 09:17:37, Ziyang Xuan wrote:
>>> Got kmemleak errors with the following ltp can_filter testcase:
>>>
>>> for ((i=1; i<=100; i++))
>>> do
>>>         ./can_filter &
>>>         sleep 0.1
>>> done
>>>
>>> ==============================================================
>>> [<00000000db4a4943>] can_rx_register+0x147/0x360 [can]
>>> [<00000000a289549d>] raw_setsockopt+0x5ef/0x853 [can_raw]
>>> [<000000006d3d9ebd>] __sys_setsockopt+0x173/0x2c0
>>> [<00000000407dbfec>] __x64_sys_setsockopt+0x61/0x70
>>> [<00000000fd468496>] do_syscall_64+0x33/0x40
>>> [<00000000b7e47d51>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
>>>
>>> It's a bug in the concurrent scenario of unregister_netdevice_many()
>>> and raw_release() as following:
>>>
>>>              cpu0                                        cpu1
>>> unregister_netdevice_many(can_dev)
>>>   unlist_netdevice(can_dev) // dev_get_by_index() return NULL after this
>>>   net_set_todo(can_dev)
>>>                                               raw_release(can_socket)
>>>                                                 dev = dev_get_by_index(, ro->ifindex); // dev == NULL
>>>                                                 if (dev) { // receivers in dev_rcv_lists not free because dev is NULL
>>>                                                   raw_disable_allfilters(, dev, );
>>>                                                   dev_put(dev);
>>>                                                 }
>>>                                                 ...
>>>                                                 ro->bound = 0;
>>>                                                 ...
>>>
>>> call_netdevice_notifiers(NETDEV_UNREGISTER, )
>>>   raw_notify(, NETDEV_UNREGISTER, )
>>>     if (ro->bound) // invalid because ro->bound has been set 0
>>>       raw_disable_allfilters(, dev, ); // receivers in dev_rcv_lists will never be freed
>>>
>>> Add a net_device pointer member in struct raw_sock to record bound can_dev,
>>> and use rtnl_lock to serialize raw_socket members between raw_bind(), raw_release(),
>>> raw_setsockopt() and raw_notify(). Use ro->dev to decide whether to free receivers in
>>> dev_rcv_lists.
>>>
>>> Fixes: 8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevice notifier")
>>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
>>> Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> Added to linux-can/testing.
>>
> 
> This patch causes three syzbot LOCKDEP reports so far.

Hello Eric,

Is there reproducer? I want to understand the specific root cause.

Thanks,
William Xuan

> 
> I suspect we need something like the following patch.
> 
> If nobody objects, I will submit this formally soon.
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 2302e48829677334f8b2d74a479e5a9cbb5ce03c..ba6b52b1d7767fdd7b57d1b8e5519495340c572c
> 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -386,9 +386,9 @@ static int raw_release(struct socket *sock)
>         list_del(&ro->notifier);
>         spin_unlock(&raw_notifier_lock);
> 
> +       rtnl_lock();
>         lock_sock(sk);
> 
> -       rtnl_lock();
>         /* remove current filters & unregister */
>         if (ro->bound) {
>                 if (ro->dev)
> @@ -405,12 +405,13 @@ static int raw_release(struct socket *sock)
>         ro->dev = NULL;
>         ro->count = 0;
>         free_percpu(ro->uniq);
> -       rtnl_unlock();
> 
>         sock_orphan(sk);
>         sock->sk = NULL;
> 
>         release_sock(sk);
> +       rtnl_unlock();
> +
>         sock_put(sk);
> 
>         return 0;
> .
> 
