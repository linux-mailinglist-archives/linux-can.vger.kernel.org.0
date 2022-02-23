Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336444C05DA
	for <lists+linux-can@lfdr.de>; Wed, 23 Feb 2022 01:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiBWAUp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 19:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiBWAUo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 19:20:44 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D96D4D637
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 16:20:18 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id k10-20020a5d91ca000000b006414a00b160so3699284ior.18
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 16:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wRU776OmzZ+OTTIBzKoRp0avVUZMQfeUNoMvzJmnaxk=;
        b=fMUHOy76ZXWC/Ha8Pw8zRs8uRsK1THsRe0utFh0ZrK/2ScmwZBUfpz61ux07Lz5wqI
         n/ROtrWEfG4fkpfRuWkRd7ZsqTDKArdngvXtAYvGJ+GAsGe8DAU1Q3oyN1dawHZ2kBlO
         hqQ4QhRrrSM5KKHVIWjsm1APDSMiVCqVLsMfgDnyQsi3NZbASdIRYEiJTTSQM/HQ/b89
         QyRHUyOamMinmH5AvVkm6Q2ckYVqjh6v2J+Rm9RoFhBoypSXH6MNV+1f+TRRxP6Hhs20
         CyEnzqcecCdt475YO3TDQGlkyUPefx5oJJQojKWPqh4azqbBIjIHXlUmkpAEOnjmyJiA
         mr4Q==
X-Gm-Message-State: AOAM530p2XDf5KNNpHThC/jXuxDiZcmFG3PFMiW1ygwULz3/ZJIQrmF4
        W2EYa4/l4jlIVTBuCr7kpMHbRvbvmJfJXPrJq9PAYCa/kg96
X-Google-Smtp-Source: ABdhPJzGIsDc6Vucg6oKIUGQEPoE+q/JeCVpHaggM2tbRhzY9Q/O5Q7wYWPHDqt2Ci7dRmbViP2hAUMxw0dnblyFNTCsOQmcl1vR
MIME-Version: 1.0
X-Received: by 2002:a02:cf90:0:b0:314:8eca:9f8a with SMTP id
 w16-20020a02cf90000000b003148eca9f8amr21573824jar.302.1645575617833; Tue, 22
 Feb 2022 16:20:17 -0800 (PST)
Date:   Tue, 22 Feb 2022 16:20:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026eee005d8a46ed3@google.com>
Subject: [syzbot] KASAN: invalid-free in skb_release_data
From:   syzbot <syzbot+c8ccd8b11e8c55e931bc@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kernel@pengutronix.de, kuba@kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    038101e6b2cd Merge tag 'platform-drivers-x86-v5.17-3' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12fb1912700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15187fc11a461d83
dashboard link: https://syzkaller.appspot.com/bug?extid=c8ccd8b11e8c55e931bc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c29c8e700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c8ccd8b11e8c55e931bc@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free or invalid-free in slab_free mm/slub.c:3509 [inline]
BUG: KASAN: double-free or invalid-free in kfree+0xd0/0x390 mm/slub.c:4562

CPU: 1 PID: 19 Comm: ksoftirqd/1 Not tainted 5.17.0-rc5-syzkaller-00004-g038101e6b2cd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x336 mm/kasan/report.c:255
 kasan_report_invalid_free+0x51/0x80 mm/kasan/report.c:381
 ____kasan_slab_free+0x144/0x160 mm/kasan/common.c:346
 kasan_slab_free include/linux/kasan.h:236 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1754
 slab_free mm/slub.c:3509 [inline]
 kfree+0xd0/0x390 mm/slub.c:4562
 skb_free_head net/core/skbuff.c:655 [inline]
 skb_release_data+0x65d/0x790 net/core/skbuff.c:677
 skb_release_all net/core/skbuff.c:742 [inline]
 __kfree_skb net/core/skbuff.c:756 [inline]
 consume_skb net/core/skbuff.c:914 [inline]
 consume_skb+0xc2/0x160 net/core/skbuff.c:908
 j1939_xtp_rx_dat_one+0x5cc/0xee0 net/can/j1939/transport.c:1903
 j1939_xtp_rx_dat net/can/j1939/transport.c:1929 [inline]
 j1939_tp_recv+0x6de/0xcb0 net/can/j1939/transport.c:2123
 j1939_can_recv+0x6ff/0x9a0 net/can/j1939/main.c:108
 deliver net/can/af_can.c:574 [inline]
 can_rcv_filter+0x5d4/0x8d0 net/can/af_can.c:608
 can_receive+0x31d/0x580 net/can/af_can.c:665
 can_rcv+0x120/0x1c0 net/can/af_can.c:696
 __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5351
 __netif_receive_skb+0x24/0x1b0 net/core/dev.c:5465
 process_backlog+0x2a5/0x6c0 net/core/dev.c:5797
 __napi_poll+0xb3/0x6e0 net/core/dev.c:6365
 napi_poll net/core/dev.c:6432 [inline]
 net_rx_action+0x801/0xb40 net/core/dev.c:6519
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

Allocated by task 0:
(stack is not available)

Freed by task 13:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x126/0x160 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:236 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1754
 slab_free mm/slub.c:3509 [inline]
 kfree+0xd0/0x390 mm/slub.c:4562
 skb_free_head net/core/skbuff.c:655 [inline]
 skb_release_data+0x65d/0x790 net/core/skbuff.c:677
 skb_release_all net/core/skbuff.c:742 [inline]
 __kfree_skb net/core/skbuff.c:756 [inline]
 kfree_skb_reason net/core/skbuff.c:776 [inline]
 kfree_skb_reason+0x138/0x400 net/core/skbuff.c:770
 kfree_skb include/linux/skbuff.h:1114 [inline]
 j1939_session_skb_drop_old net/can/j1939/transport.c:340 [inline]
 j1939_xtp_rx_cts_one net/can/j1939/transport.c:1434 [inline]
 j1939_xtp_rx_cts+0xbd8/0x1170 net/can/j1939/transport.c:1473
 j1939_tp_cmd_recv net/can/j1939/transport.c:2061 [inline]
 j1939_tp_recv+0x83c/0xcb0 net/can/j1939/transport.c:2133
 j1939_can_recv+0x6ff/0x9a0 net/can/j1939/main.c:108
 deliver net/can/af_can.c:574 [inline]
 can_rcv_filter+0x5d4/0x8d0 net/can/af_can.c:608
 can_receive+0x31d/0x580 net/can/af_can.c:665
 can_rcv+0x120/0x1c0 net/can/af_can.c:696
 __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5351
 __netif_receive_skb+0x24/0x1b0 net/core/dev.c:5465
 process_backlog+0x2a5/0x6c0 net/core/dev.c:5797
 __napi_poll+0xb3/0x6e0 net/core/dev.c:6365
 napi_poll net/core/dev.c:6432 [inline]
 net_rx_action+0x801/0xb40 net/core/dev.c:6519
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558

The buggy address belongs to the object at ffff88801cde0000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 0 bytes inside of
 4096-byte region [ffff88801cde0000, ffff88801cde1000)
The buggy address belongs to the page:
page:ffffea0000737800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1cde0
head:ffffea0000737800 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888010c42140
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 4308, ts 1772442776024, free_ts 1771760013940
 prep_new_page mm/page_alloc.c:2434 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4165
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5389
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2271
 alloc_slab_page mm/slub.c:1799 [inline]
 allocate_slab+0x27f/0x3c0 mm/slub.c:1944
 new_slab mm/slub.c:2004 [inline]
 ___slab_alloc+0xbe1/0x12b0 mm/slub.c:3018
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3105
 slab_alloc_node mm/slub.c:3196 [inline]
 __kmalloc_node_track_caller+0x339/0x470 mm/slub.c:4957
 kmalloc_reserve net/core/skbuff.c:354 [inline]
 __alloc_skb+0xde/0x340 net/core/skbuff.c:426
 alloc_skb include/linux/skbuff.h:1158 [inline]
 alloc_skb_with_frags+0x93/0x620 net/core/skbuff.c:5956
 sock_alloc_send_pskb+0x793/0x920 net/core/sock.c:2586
 j1939_sk_alloc_skb net/can/j1939/socket.c:861 [inline]
 j1939_sk_send_loop net/can/j1939/socket.c:1118 [inline]
 j1939_sk_sendmsg+0x6eb/0x13e0 net/can/j1939/socket.c:1253
 sock_sendmsg_nosec net/socket.c:705 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:725
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2413
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2467
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2496
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1352 [inline]
 free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1404
 free_unref_page_prepare mm/page_alloc.c:3325 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3404
 __unfreeze_partials+0x320/0x340 mm/slub.c:2536
 qlink_free mm/kasan/quarantine.c:157 [inline]
 qlist_free_all+0x6d/0x160 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:260 [inline]
 slab_post_alloc_hook mm/slab.h:732 [inline]
 slab_alloc_node mm/slub.c:3230 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 __kmalloc+0x256/0x450 mm/slub.c:4420
 kmalloc include/linux/slab.h:586 [inline]
 kzalloc include/linux/slab.h:715 [inline]
 tomoyo_encode2.part.0+0xe9/0x3a0 security/tomoyo/realpath.c:45
 tomoyo_encode2 security/tomoyo/realpath.c:31 [inline]
 tomoyo_encode+0x28/0x50 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x186/0x620 security/tomoyo/realpath.c:288
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x21b/0x400 security/tomoyo/file.c:822
 security_inode_getattr+0xcf/0x140 security/security.c:1337
 vfs_getattr fs/stat.c:157 [inline]
 vfs_statx+0x164/0x390 fs/stat.c:225
 vfs_fstatat fs/stat.c:243 [inline]
 vfs_lstat include/linux/fs.h:3287 [inline]
 __do_sys_newlstat+0x91/0x110 fs/stat.c:398
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff88801cddff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88801cddff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88801cde0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88801cde0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801cde0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
