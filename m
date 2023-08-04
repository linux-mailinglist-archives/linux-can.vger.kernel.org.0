Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CAE76FF9F
	for <lists+linux-can@lfdr.de>; Fri,  4 Aug 2023 13:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjHDLrr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Aug 2023 07:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjHDLrp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 4 Aug 2023 07:47:45 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA24128;
        Fri,  4 Aug 2023 04:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1691149650; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VC+e7b+56goznh1B0953uCopDfrzRsfRXvWELeLBVthGBA3C4byXAydqLuCglMf6xP
    tDysfB8FrfwAN5OTZYL0UBp1mxO9giUQv9KWzr2zdjd9+ZzVJPIKI65upkl4wZJ/lLPl
    5TJf6ucmIrUg/TbBjKgAg3+xEC9IRjJIfxIHM+Q799mrAgED4WopdCxKsPoNLf2lm/4b
    2si0mFnRoBOXoLH5AJTQhvrrOtZ2LYptvCJjJCog2ZHlD9/FFcNvTE1TQ6H+2+0Pn+D8
    +flxlA+wxbKFFzaE3WsAacVXl+xAPO28cieXU8QTsLgpSk4xKl/OsvmS5laxilc/oufX
    h7Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1691149650;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4rdNX/dRBrW3TLi6P+nuxqFw0H2gf0hUqcXh71bACNU=;
    b=FZMBGKUPZ8upXeqwvDLSB6L0zlcauymug8E28syGyneTpz6CIxJH5KL7R5HQLVHsCn
    Iem1cjKgfaz9jOAa+suQRyWezklsFY4T+hAG5HR2mQf7hqgg24Jv/mI8Y+ubtcJBCS2q
    8j4qPKpfAPbO6luXzmYObvhizG6fY5vdW4y17XUUbNqJoRvQFAST+B1Y88qn2VOBFLic
    Zyo101ACWDpB2jTxmhC7Qn5/Tw2NL+0XBivmZtSegp7LnWAht3E3c3uwuj4dkcNHBzee
    S5gfi7snFJM8MxMqJkHpyi0YT48V43mFOy16PpgsbAKtDodD5Etguk9Lea5hWbvQ1aLM
    NdMg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1691149650;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4rdNX/dRBrW3TLi6P+nuxqFw0H2gf0hUqcXh71bACNU=;
    b=nz//SDyv9TQObSMkQJqPAdEyLin4iKLgJZU7lUHRq/b7AutiITQNOQ18P51v4CsG+4
    aCJKM2VFpuXRBMs0zUFchO6JWdl7CV11d/fPoFBQbtyXeRG/uiIokRo6HTyLb26F8K95
    GXX1yjSMc1Js13hJDLuliLqEA9ldC4trAeY5bZCSMqUIbhwDYeXPL9OaK2uAU8rKkYtg
    9nuceaBt9Pd8+DIw1z5zOcv6Gx6B5KHAVxhb9EL/ZDfCRRsAQsvlzibRGCuZemnh2s8m
    DgAharPmmcUSOLH2C94tyIPSx0v8KJzBMxMDy0ufv2FSLZEGnngNqjXGtTW/+wlU0Sz9
    fnoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1691149650;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4rdNX/dRBrW3TLi6P+nuxqFw0H2gf0hUqcXh71bACNU=;
    b=M4dMsR3x42P+gPwQrxWk2A7y5Fv312S6fRkoWMNplAJ0kH2dWsledAiNdO59hSzNxf
    YV5p3MAsifbxjPTLH0Bg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq1USEbMhpqw=="
Received: from [IPV6:2a00:6020:4a8e:5004::923]
    by smtp.strato.de (RZmta 49.6.6 AUTH)
    with ESMTPSA id 69691ez74BlTRPP
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 4 Aug 2023 13:47:29 +0200 (CEST)
Message-ID: <e421e2ad-c070-9e6a-2c2c-a2af92e1a6eb@hartkopp.net>
Date:   Fri, 4 Aug 2023 13:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH net v3] can: raw: fix receiver memory leak
To:     Eric Dumazet <edumazet@google.com>,
        "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp
References: <20230711011737.1969582-1-william.xuanziyang@huawei.com>
 <20230717-clubhouse-swinger-8f0fa23b0628-mkl@pengutronix.de>
 <CANn89iJ47sVXAEEryvODoGv-iUpT-ACTCSWQTmdtJ9Fqs0s40Q@mail.gmail.com>
 <1e0e6539-412a-cc8d-b104-e2921a099e48@huawei.com>
 <CANn89iKoTWHBGgMW-RyJHHeM0QuiN9De=eNWMM8VRom++n_o_g@mail.gmail.com>
 <3566e594-a9e5-8ba4-0f5a-d50086cebd82@huawei.com>
 <CANn89iJ8jFxGo0d_8KnM2f=Xbh=iqb=+zcGn+U6PypuqNdWBUQ@mail.gmail.com>
 <df3afb62-061e-a40f-b872-c9eb414455bb@huawei.com>
 <CANn89iLXk-=Zh9va4eKM+35vx4=sn8p_Jvu5xAkHphOyh07B7w@mail.gmail.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CANn89iLXk-=Zh9va4eKM+35vx4=sn8p_Jvu5xAkHphOyh07B7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 03.08.23 09:11, Eric Dumazet wrote:
> On Thu, Aug 3, 2023 at 2:44 AM Ziyang Xuan (William)
> <william.xuanziyang@huawei.com> wrote:
>>
>>>>> On Wed, Jul 19, 2023 at 6:41 AM Ziyang Xuan (William)
>>>>> <william.xuanziyang@huawei.com> wrote:
>>>>>>
>>>>>>> On Mon, Jul 17, 2023 at 9:27 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>>>>>>>
>>>>>>>> On 11.07.2023 09:17:37, Ziyang Xuan wrote:
>>>>>>>>> Got kmemleak errors with the following ltp can_filter testcase:
>>>>>>>>>
>>>>>>>>> for ((i=1; i<=100; i++))
>>>>>>>>> do
>>>>>>>>>          ./can_filter &
>>>>>>>>>          sleep 0.1
>>>>>>>>> done
>>>>>>>>>
>>>>>>>>> ==============================================================
>>>>>>>>> [<00000000db4a4943>] can_rx_register+0x147/0x360 [can]
>>>>>>>>> [<00000000a289549d>] raw_setsockopt+0x5ef/0x853 [can_raw]
>>>>>>>>> [<000000006d3d9ebd>] __sys_setsockopt+0x173/0x2c0
>>>>>>>>> [<00000000407dbfec>] __x64_sys_setsockopt+0x61/0x70
>>>>>>>>> [<00000000fd468496>] do_syscall_64+0x33/0x40
>>>>>>>>> [<00000000b7e47d51>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
>>>>>>>>>
>>>>>>>>> It's a bug in the concurrent scenario of unregister_netdevice_many()
>>>>>>>>> and raw_release() as following:
>>>>>>>>>
>>>>>>>>>               cpu0                                        cpu1
>>>>>>>>> unregister_netdevice_many(can_dev)
>>>>>>>>>    unlist_netdevice(can_dev) // dev_get_by_index() return NULL after this
>>>>>>>>>    net_set_todo(can_dev)
>>>>>>>>>                                                raw_release(can_socket)
>>>>>>>>>                                                  dev = dev_get_by_index(, ro->ifindex); // dev == NULL
>>>>>>>>>                                                  if (dev) { // receivers in dev_rcv_lists not free because dev is NULL
>>>>>>>>>                                                    raw_disable_allfilters(, dev, );
>>>>>>>>>                                                    dev_put(dev);
>>>>>>>>>                                                  }
>>>>>>>>>                                                  ...
>>>>>>>>>                                                  ro->bound = 0;
>>>>>>>>>                                                  ...
>>>>>>>>>
>>>>>>>>> call_netdevice_notifiers(NETDEV_UNREGISTER, )
>>>>>>>>>    raw_notify(, NETDEV_UNREGISTER, )
>>>>>>>>>      if (ro->bound) // invalid because ro->bound has been set 0
>>>>>>>>>        raw_disable_allfilters(, dev, ); // receivers in dev_rcv_lists will never be freed
>>>>>>>>>
>>>>>>>>> Add a net_device pointer member in struct raw_sock to record bound can_dev,
>>>>>>>>> and use rtnl_lock to serialize raw_socket members between raw_bind(), raw_release(),
>>>>>>>>> raw_setsockopt() and raw_notify(). Use ro->dev to decide whether to free receivers in
>>>>>>>>> dev_rcv_lists.
>>>>>>>>>
>>>>>>>>> Fixes: 8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevice notifier")
>>>>>>>>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
>>>>>>>>> Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>>>>>>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>>>>>>
>>>>>>>> Added to linux-can/testing.
>>>>>>>>
>>>>>>>
>>>>>>> This patch causes three syzbot LOCKDEP reports so far.
>>>>>>
>>>>>> Hello Eric,
>>>>>>
>>>>>> Is there reproducer? I want to understand the specific root cause.
>>>>>>
>>>>>
>>>>> No repro yet, but simply look at other functions in net/can/raw.c
>>>>>
>>>>> You must always take locks in the same order.
>>>>>
>>>>> raw_bind(), raw_setsockopt() use:
>>>>>
>>>>> rtnl_lock();
>>>>> lock_sock(sk);
>>>>>
>>>>> Therefore, raw_release() must _also_ use the same order, or risk deadlock.
>>>>>
>>>>> Please build a LOCKDEP enabled kernel, and run your tests ?
>>>>
>>>> I know now. This needs raw_bind() and raw_setsockopt() concurrent with raw_release().
>>>> And there is not the scenario in my current testcase. I did not get it. I will try to
>>>> reproduce it and add the testcase.
>>>>
>>>> Thank you for your patient explanation.
>>>
>>> Another syzbot report is firing because of your patch
>>>
>>> Apparently we store in ro->dev a pointer to a netdev without holding a
>>> refcount on it.
>>> .

I've sent a patch addressing this issue by holding the dev refcount as 
long as it is needed.

https://lore.kernel.org/linux-can/20230804112811.42259-1-socketcan@hartkopp.net/T/#u

Another review is appreciated.

Many thanks,
Oliver

>> Hello Eric,
>>
>> Is there a syzbot link or reproducer can be provided?
>>
> 
> Not yet, but really we should not cache a dev pointer without making
> sure it does not disappear later.
> 
> Caching the ifindex is fine though.
> 
> BUG: KASAN: use-after-free in read_pnet include/net/net_namespace.h:383 [inline]
> BUG: KASAN: use-after-free in dev_net include/linux/netdevice.h:2590 [inline]
> BUG: KASAN: use-after-free in raw_release+0x960/0x9b0 net/can/raw.c:395
> Read of size 8 at addr ffff88802b9b8670 by task syz-executor.1/7705
> 
> CPU: 0 PID: 7705 Comm: syz-executor.1 Not tainted
> 6.5.0-rc3-syzkaller-00176-g13d2618b48f1 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 07/12/2023
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
> print_address_description mm/kasan/report.c:364 [inline]
> print_report+0xc4/0x620 mm/kasan/report.c:475
> kasan_report+0xda/0x110 mm/kasan/report.c:588
> read_pnet include/net/net_namespace.h:383 [inline]
> dev_net include/linux/netdevice.h:2590 [inline]
> raw_release+0x960/0x9b0 net/can/raw.c:395
> __sock_release+0xcd/0x290 net/socket.c:654
> sock_close+0x1c/0x20 net/socket.c:1386
> __fput+0x3fd/0xac0 fs/file_table.c:384
> task_work_run+0x14d/0x240 kernel/task_work.c:179
> resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
> exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
> exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
> __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
> syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
> do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fb7e927b9da
> Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89
> 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
> RSP: 002b:00007ffd15e54c90 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 000000000000000a RCX: 00007fb7e927b9da
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000009
> RBP: 00007fb7e939d980 R08: 0000001b2fb20000 R09: 000000000000040e
> R10: 000000008190df57 R11: 0000000000000293 R12: 000000000011244a
> R13: ffffffffffffffff R14: 00007fb7e8e00000 R15: 0000000000112109
> </TASK>
> 
> The buggy address belongs to the physical page:
> page:ffffea0000ae6e00 refcount:0 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x2b9b8
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> page_type: 0xffffffff()
> raw: 00fff00000000000 ffffea0001e32208 ffffea0000ae7c08 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as freed
> page last allocated via order 3, migratetype Unmovable, gfp_mask
> 0x446dc0(GFP_KERNEL_ACCOUNT|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP|__GFP_ZERO),
> pid 5067, tgid 5067 (syz-executor.1), ts 153775196806, free_ts
> 1123753306319
> set_page_owner include/linux/page_owner.h:31 [inline]
> post_alloc_hook+0x2d2/0x350 mm/page_alloc.c:1570
> prep_new_page mm/page_alloc.c:1577 [inline]
> get_page_from_freelist+0x10a9/0x31e0 mm/page_alloc.c:3221
> __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4477
> __alloc_pages_node include/linux/gfp.h:237 [inline]
> alloc_pages_node include/linux/gfp.h:260 [inline]
> __kmalloc_large_node+0x87/0x1c0 mm/slab_common.c:1126
> __do_kmalloc_node mm/slab_common.c:973 [inline]
> __kmalloc_node.cold+0x5/0xdd mm/slab_common.c:992
> kmalloc_node include/linux/slab.h:602 [inline]
> kvmalloc_node+0x6f/0x1a0 mm/util.c:604
> kvmalloc include/linux/slab.h:720 [inline]
> kvzalloc include/linux/slab.h:728 [inline]
> alloc_netdev_mqs+0x9b/0x1240 net/core/dev.c:10594
> rtnl_create_link+0xc9c/0xfd0 net/core/rtnetlink.c:3336
> rtnl_newlink_create net/core/rtnetlink.c:3462 [inline]
> __rtnl_newlink+0x1075/0x18c0 net/core/rtnetlink.c:3689
> rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3702
> rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6428
> netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
> netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
> netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
> netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
> sock_sendmsg_nosec net/socket.c:725 [inline]
> sock_sendmsg+0xd9/0x180 net/socket.c:748
> __sys_sendto+0x255/0x340 net/socket.c:2134
> page last free stack trace:
> reset_page_owner include/linux/page_owner.h:24 [inline]
> free_pages_prepare mm/page_alloc.c:1161 [inline]
> free_unref_page_prepare+0x508/0xb90 mm/page_alloc.c:2348
> free_unref_page+0x33/0x3b0 mm/page_alloc.c:2443
> kvfree+0x47/0x50 mm/util.c:650
> device_release+0xa1/0x240 drivers/base/core.c:2484
> kobject_cleanup lib/kobject.c:682 [inline]
> kobject_release lib/kobject.c:713 [inline]
> kref_put include/linux/kref.h:65 [inline]
> kobject_put+0x1f7/0x5b0 lib/kobject.c:730
> netdev_run_todo+0x7dd/0x11d0 net/core/dev.c:10366
> rtnl_unlock net/core/rtnetlink.c:151 [inline]
> rtnetlink_rcv_msg+0x446/0xd30 net/core/rtnetlink.c:6429
> netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
> netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
> netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
> netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
> sock_sendmsg_nosec net/socket.c:725 [inline]
> sock_sendmsg+0xd9/0x180 net/socket.c:748
> ____sys_sendmsg+0x6ac/0x940 net/socket.c:2494
> ___sys_sendmsg+0x135/0x1d0 net/socket.c:2548
> __sys_sendmsg+0x117/0x1e0 net/socket.c:2577
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Memory state around the buggy address:
> ffff88802b9b8500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff88802b9b8580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> ffff88802b9b8600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ^
> ffff88802b9b8680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff88802b9b8700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ==================================================================
