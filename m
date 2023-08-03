Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C229D76E0FB
	for <lists+linux-can@lfdr.de>; Thu,  3 Aug 2023 09:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjHCHL5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 3 Aug 2023 03:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjHCHL4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 3 Aug 2023 03:11:56 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DF6FF
        for <linux-can@vger.kernel.org>; Thu,  3 Aug 2023 00:11:53 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40a47e8e38dso148861cf.1
        for <linux-can@vger.kernel.org>; Thu, 03 Aug 2023 00:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691046712; x=1691651512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DudHD0ULQtWrQ8O0cysWIJYP5CnMRNpbTu8CyU4jgA4=;
        b=YYlf9rr+WDiw1O3QBY8ojENplmyJpzJH/tADALQOrx8UnIZ+WMoo/s/HEbZ5cSYqpm
         tlh2Zo4rEKeVmGaswghqKykYsvxV2zMU7qsFEyg6LmRa6HdyYroiUMThm1D76dag9shx
         9g6wOqbzz23ALhjut1wiNrrpH9KHwBUg4SRf1gHNdTV6zfIoxTIZRIgtavqux6590cdA
         DZ7CdTzqIrVKayigqh/lWssvxZ1CNL2W2ATsVtKr6QGTeuQcT/COM8d2sDSqSNBCfvx7
         pe77zYR/wyRORy7N09KG3QU+NicvntsfCJlVG/30TxPpoBlcoB3R4E/Vc42N6BJQ60ti
         uxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691046712; x=1691651512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DudHD0ULQtWrQ8O0cysWIJYP5CnMRNpbTu8CyU4jgA4=;
        b=XtVRC0GXLqnawMDhQd9oXKQ4Xe2VfoW/hxo9tBwRIM/NGu55SSNtyBMu1/1zed688L
         4d7sCUFAsZu6AZekuzmU1auyDTGPjjCizRVx+lx2FtuGWnV+/BEt4gkZuE9TcCP5TwV+
         J9/rMF1AmEo0/uqBqaWSujsvGjMEGqaVJxORU01M4qCyrCWdYu4IZkJ6P00h/YA50QGx
         IWcr6e8UmXP0fadk7XR5jvwgDtsYhGB6Lfx6NCjC2mjDJmOprNyKSLCxj+gjza/IVC2e
         39319Gc0Q77r3+Ob2JMAexBOGSjPUQ/ODMHks8c2yM+LpkPGZMyO+n1ZrCq59HZDUYNM
         Ku/w==
X-Gm-Message-State: ABy/qLZa6fuP0Kn0+S6Ou1e2MAHdEMQOuY4X9a5XmRT7kO3/D9ym23te
        3yc9CIOkO+wLS7IbAUZNERoWyty8HyZnC2tx63k8Lg==
X-Google-Smtp-Source: APBJJlGjL3geeGuE6TQ/m92OP9Ap3AZZgrOTRW8+FzUAPaE4Vlfr4hEsFSp2QSUVZYevzR3q6m8o4PX83HOUch7BoVw=
X-Received: by 2002:ac8:5c07:0:b0:403:b3ab:393e with SMTP id
 i7-20020ac85c07000000b00403b3ab393emr1215971qti.18.1691046711971; Thu, 03 Aug
 2023 00:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230711011737.1969582-1-william.xuanziyang@huawei.com>
 <20230717-clubhouse-swinger-8f0fa23b0628-mkl@pengutronix.de>
 <CANn89iJ47sVXAEEryvODoGv-iUpT-ACTCSWQTmdtJ9Fqs0s40Q@mail.gmail.com>
 <1e0e6539-412a-cc8d-b104-e2921a099e48@huawei.com> <CANn89iKoTWHBGgMW-RyJHHeM0QuiN9De=eNWMM8VRom++n_o_g@mail.gmail.com>
 <3566e594-a9e5-8ba4-0f5a-d50086cebd82@huawei.com> <CANn89iJ8jFxGo0d_8KnM2f=Xbh=iqb=+zcGn+U6PypuqNdWBUQ@mail.gmail.com>
 <df3afb62-061e-a40f-b872-c9eb414455bb@huawei.com>
In-Reply-To: <df3afb62-061e-a40f-b872-c9eb414455bb@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 3 Aug 2023 09:11:40 +0200
Message-ID: <CANn89iLXk-=Zh9va4eKM+35vx4=sn8p_Jvu5xAkHphOyh07B7w@mail.gmail.com>
Subject: Re: [PATCH net v3] can: raw: fix receiver memory leak
To:     "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, socketcan@hartkopp.net,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Aug 3, 2023 at 2:44=E2=80=AFAM Ziyang Xuan (William)
<william.xuanziyang@huawei.com> wrote:
>
> >>> On Wed, Jul 19, 2023 at 6:41=E2=80=AFAM Ziyang Xuan (William)
> >>> <william.xuanziyang@huawei.com> wrote:
> >>>>
> >>>>> On Mon, Jul 17, 2023 at 9:27=E2=80=AFAM Marc Kleine-Budde <mkl@peng=
utronix.de> wrote:
> >>>>>>
> >>>>>> On 11.07.2023 09:17:37, Ziyang Xuan wrote:
> >>>>>>> Got kmemleak errors with the following ltp can_filter testcase:
> >>>>>>>
> >>>>>>> for ((i=3D1; i<=3D100; i++))
> >>>>>>> do
> >>>>>>>         ./can_filter &
> >>>>>>>         sleep 0.1
> >>>>>>> done
> >>>>>>>
> >>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>> [<00000000db4a4943>] can_rx_register+0x147/0x360 [can]
> >>>>>>> [<00000000a289549d>] raw_setsockopt+0x5ef/0x853 [can_raw]
> >>>>>>> [<000000006d3d9ebd>] __sys_setsockopt+0x173/0x2c0
> >>>>>>> [<00000000407dbfec>] __x64_sys_setsockopt+0x61/0x70
> >>>>>>> [<00000000fd468496>] do_syscall_64+0x33/0x40
> >>>>>>> [<00000000b7e47d51>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >>>>>>>
> >>>>>>> It's a bug in the concurrent scenario of unregister_netdevice_man=
y()
> >>>>>>> and raw_release() as following:
> >>>>>>>
> >>>>>>>              cpu0                                        cpu1
> >>>>>>> unregister_netdevice_many(can_dev)
> >>>>>>>   unlist_netdevice(can_dev) // dev_get_by_index() return NULL aft=
er this
> >>>>>>>   net_set_todo(can_dev)
> >>>>>>>                                               raw_release(can_soc=
ket)
> >>>>>>>                                                 dev =3D dev_get_b=
y_index(, ro->ifindex); // dev =3D=3D NULL
> >>>>>>>                                                 if (dev) { // rec=
eivers in dev_rcv_lists not free because dev is NULL
> >>>>>>>                                                   raw_disable_all=
filters(, dev, );
> >>>>>>>                                                   dev_put(dev);
> >>>>>>>                                                 }
> >>>>>>>                                                 ...
> >>>>>>>                                                 ro->bound =3D 0;
> >>>>>>>                                                 ...
> >>>>>>>
> >>>>>>> call_netdevice_notifiers(NETDEV_UNREGISTER, )
> >>>>>>>   raw_notify(, NETDEV_UNREGISTER, )
> >>>>>>>     if (ro->bound) // invalid because ro->bound has been set 0
> >>>>>>>       raw_disable_allfilters(, dev, ); // receivers in dev_rcv_li=
sts will never be freed
> >>>>>>>
> >>>>>>> Add a net_device pointer member in struct raw_sock to record boun=
d can_dev,
> >>>>>>> and use rtnl_lock to serialize raw_socket members between raw_bin=
d(), raw_release(),
> >>>>>>> raw_setsockopt() and raw_notify(). Use ro->dev to decide whether =
to free receivers in
> >>>>>>> dev_rcv_lists.
> >>>>>>>
> >>>>>>> Fixes: 8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevic=
e notifier")
> >>>>>>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> >>>>>>> Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >>>>>>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >>>>>>
> >>>>>> Added to linux-can/testing.
> >>>>>>
> >>>>>
> >>>>> This patch causes three syzbot LOCKDEP reports so far.
> >>>>
> >>>> Hello Eric,
> >>>>
> >>>> Is there reproducer? I want to understand the specific root cause.
> >>>>
> >>>
> >>> No repro yet, but simply look at other functions in net/can/raw.c
> >>>
> >>> You must always take locks in the same order.
> >>>
> >>> raw_bind(), raw_setsockopt() use:
> >>>
> >>> rtnl_lock();
> >>> lock_sock(sk);
> >>>
> >>> Therefore, raw_release() must _also_ use the same order, or risk dead=
lock.
> >>>
> >>> Please build a LOCKDEP enabled kernel, and run your tests ?
> >>
> >> I know now. This needs raw_bind() and raw_setsockopt() concurrent with=
 raw_release().
> >> And there is not the scenario in my current testcase. I did not get it=
. I will try to
> >> reproduce it and add the testcase.
> >>
> >> Thank you for your patient explanation.
> >
> > Another syzbot report is firing because of your patch
> >
> > Apparently we store in ro->dev a pointer to a netdev without holding a
> > refcount on it.
> > .
> Hello Eric,
>
> Is there a syzbot link or reproducer can be provided?
>

Not yet, but really we should not cache a dev pointer without making
sure it does not disappear later.

Caching the ifindex is fine though.

BUG: KASAN: use-after-free in read_pnet include/net/net_namespace.h:383 [in=
line]
BUG: KASAN: use-after-free in dev_net include/linux/netdevice.h:2590 [inlin=
e]
BUG: KASAN: use-after-free in raw_release+0x960/0x9b0 net/can/raw.c:395
Read of size 8 at addr ffff88802b9b8670 by task syz-executor.1/7705

CPU: 0 PID: 7705 Comm: syz-executor.1 Not tainted
6.5.0-rc3-syzkaller-00176-g13d2618b48f1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 07/12/2023
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:364 [inline]
print_report+0xc4/0x620 mm/kasan/report.c:475
kasan_report+0xda/0x110 mm/kasan/report.c:588
read_pnet include/net/net_namespace.h:383 [inline]
dev_net include/linux/netdevice.h:2590 [inline]
raw_release+0x960/0x9b0 net/can/raw.c:395
__sock_release+0xcd/0x290 net/socket.c:654
sock_close+0x1c/0x20 net/socket.c:1386
__fput+0x3fd/0xac0 fs/file_table.c:384
task_work_run+0x14d/0x240 kernel/task_work.c:179
resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
__syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb7e927b9da
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89
7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffd15e54c90 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 000000000000000a RCX: 00007fb7e927b9da
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000009
RBP: 00007fb7e939d980 R08: 0000001b2fb20000 R09: 000000000000040e
R10: 000000008190df57 R11: 0000000000000293 R12: 000000000011244a
R13: ffffffffffffffff R14: 00007fb7e8e00000 R15: 0000000000112109
</TASK>

The buggy address belongs to the physical page:
page:ffffea0000ae6e00 refcount:0 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x2b9b8
flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 ffffea0001e32208 ffffea0000ae7c08 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 3, migratetype Unmovable, gfp_mask
0x446dc0(GFP_KERNEL_ACCOUNT|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP|__G=
FP_ZERO),
pid 5067, tgid 5067 (syz-executor.1), ts 153775196806, free_ts
1123753306319
set_page_owner include/linux/page_owner.h:31 [inline]
post_alloc_hook+0x2d2/0x350 mm/page_alloc.c:1570
prep_new_page mm/page_alloc.c:1577 [inline]
get_page_from_freelist+0x10a9/0x31e0 mm/page_alloc.c:3221
__alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4477
__alloc_pages_node include/linux/gfp.h:237 [inline]
alloc_pages_node include/linux/gfp.h:260 [inline]
__kmalloc_large_node+0x87/0x1c0 mm/slab_common.c:1126
__do_kmalloc_node mm/slab_common.c:973 [inline]
__kmalloc_node.cold+0x5/0xdd mm/slab_common.c:992
kmalloc_node include/linux/slab.h:602 [inline]
kvmalloc_node+0x6f/0x1a0 mm/util.c:604
kvmalloc include/linux/slab.h:720 [inline]
kvzalloc include/linux/slab.h:728 [inline]
alloc_netdev_mqs+0x9b/0x1240 net/core/dev.c:10594
rtnl_create_link+0xc9c/0xfd0 net/core/rtnetlink.c:3336
rtnl_newlink_create net/core/rtnetlink.c:3462 [inline]
__rtnl_newlink+0x1075/0x18c0 net/core/rtnetlink.c:3689
rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3702
rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6428
netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
sock_sendmsg_nosec net/socket.c:725 [inline]
sock_sendmsg+0xd9/0x180 net/socket.c:748
__sys_sendto+0x255/0x340 net/socket.c:2134
page last free stack trace:
reset_page_owner include/linux/page_owner.h:24 [inline]
free_pages_prepare mm/page_alloc.c:1161 [inline]
free_unref_page_prepare+0x508/0xb90 mm/page_alloc.c:2348
free_unref_page+0x33/0x3b0 mm/page_alloc.c:2443
kvfree+0x47/0x50 mm/util.c:650
device_release+0xa1/0x240 drivers/base/core.c:2484
kobject_cleanup lib/kobject.c:682 [inline]
kobject_release lib/kobject.c:713 [inline]
kref_put include/linux/kref.h:65 [inline]
kobject_put+0x1f7/0x5b0 lib/kobject.c:730
netdev_run_todo+0x7dd/0x11d0 net/core/dev.c:10366
rtnl_unlock net/core/rtnetlink.c:151 [inline]
rtnetlink_rcv_msg+0x446/0xd30 net/core/rtnetlink.c:6429
netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
sock_sendmsg_nosec net/socket.c:725 [inline]
sock_sendmsg+0xd9/0x180 net/socket.c:748
____sys_sendmsg+0x6ac/0x940 net/socket.c:2494
___sys_sendmsg+0x135/0x1d0 net/socket.c:2548
__sys_sendmsg+0x117/0x1e0 net/socket.c:2577
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
ffff88802b9b8500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ffff88802b9b8580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88802b9b8600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
^
ffff88802b9b8680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ffff88802b9b8700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
