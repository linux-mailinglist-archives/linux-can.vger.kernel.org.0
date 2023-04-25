Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE34F6EDE48
	for <lists+linux-can@lfdr.de>; Tue, 25 Apr 2023 10:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjDYIkb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Apr 2023 04:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbjDYIjx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Apr 2023 04:39:53 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5515AC168
        for <linux-can@vger.kernel.org>; Tue, 25 Apr 2023 01:38:00 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4edc63e066fso1007e87.1
        for <linux-can@vger.kernel.org>; Tue, 25 Apr 2023 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682411823; x=1685003823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XXW/aseN5mXuotIa/yEkh2bdTo682NvMfHu/VUn7fZ4=;
        b=XmgtDHUuBipVTZPUOiFntnaV3plFHTBEUMVX6ZzTveiI5RNHzhbJAS4owqd5Uf2wdn
         LjSPgp8P/AjOCVqQ4+KDy8PQz8x4RdUBEuE0+g57YZ6FHmT9UDb+GW1Lk1ufgDXCLvzQ
         qWUcl1Skk1nk80BbsQg0k+VxjT/IihbMtTcn5bIUVqybGx+D36N/C6ESx8tSWvRJLnoX
         HY1uEjN5nF4WDQwLN/BUDaZDLJdhL8q4gs+tbq9+2u2HweRVgD9MhhF7Fp8Z1NoM7OmQ
         wxlsn04NTFHfFINdrNryFOjrXFFOx00CtfMs0zXW5Mkf8UQuzpVEk7GH6Xb5wQikgDRz
         Qifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682411823; x=1685003823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXW/aseN5mXuotIa/yEkh2bdTo682NvMfHu/VUn7fZ4=;
        b=GL/zT1valeXbUtomHH7m4Kr7LR43t2Et/6DB6dPVGfpn0PEhQuMXSiIcltrxx77HLv
         53FVM/lEhIr52DB5SEu6hL6kBXQCJmBo7jMDV2mTSjMcB1zlw+855ziKXF72gnouH++G
         ULJsskm4t/QtxhR3cdcXfgA4QA+b+dQIbKcfVwf1EYwEQ1olKGmYExSIlztm3cqoEGKF
         eNKmCMr9Ah+Wh7lVqAVDMNfUlZElrS6A7cDtqwuT+hPl2UXHnZRc5ulenL1OyATvUgy0
         COOsfUO1GD54P4pQAubtXjss8c8u1KMAdCRwF+GxQ7VA6pbHU4aiKP/eKOnk+jnOMnwN
         xfkA==
X-Gm-Message-State: AC+VfDwXI/5CFn1rpBNPqWL0i9hGzFdbM/fK1gyig8vscfZTZJIPweQm
        AAr3R2wsopVOe8a8i1rePWlOxHQbyONz6IUEomB9MQ==
X-Google-Smtp-Source: ACHHUZ4ZQVitrq0MqOhQ4d7dv8Gnc3ryLTlv8xLgz1rnFURT2OfEFSn0WQ5z358EeBKQM+qPXMw0XCAFzTwwaiWgez8=
X-Received: by 2002:a05:6512:3e17:b0:4ed:af48:f8bb with SMTP id
 i23-20020a0565123e1700b004edaf48f8bbmr96406lfv.5.1682411823172; Tue, 25 Apr
 2023 01:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000059e1b705fa2494e4@google.com>
In-Reply-To: <00000000000059e1b705fa2494e4@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 25 Apr 2023 10:36:51 +0200
Message-ID: <CACT4Y+YDzXb6WoMtBu5O-dpWOkVYwhUNKM7szC5gJ9ewtMUPDQ@mail.gmail.com>
Subject: Re: [syzbot] [can?] KCSAN: data-race in bcm_can_tx / bcm_tx_setup (3)
To:     syzbot <syzbot+e1786f049e71693263bf@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        mkl@pengutronix.de, netdev@vger.kernel.org, pabeni@redhat.com,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 25 Apr 2023 at 10:05, syzbot
<syzbot+e1786f049e71693263bf@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    1a0beef98b58 Merge tag 'tpmdd-v6.4-rc1' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1485f1dbc80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=501f7c86f7a05a13
> dashboard link: https://syzkaller.appspot.com/bug?extid=e1786f049e71693263bf
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f06c11683242/disk-1a0beef9.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5c0a1cd5a059/vmlinux-1a0beef9.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e4c318183ce3/bzImage-1a0beef9.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e1786f049e71693263bf@syzkaller.appspotmail.com

op->currframe and probably other op fields are concurrently
read/modified by both bcm_tx_setup() and bcm_can_tx().
If I am reading the code correctly, it can lead to a wide range of
misbehavior, e.g. sending wrong/uninit data, reading/writing data
out-of-bounds, etc.
I think these functions need to be somehow serialized (stopping timers
before doing any modifications to op?).

> ==================================================================
> BUG: KCSAN: data-race in bcm_can_tx / bcm_tx_setup
>
> write to 0xffff888137fcff10 of 4 bytes by task 10792 on cpu 0:
>  bcm_tx_setup+0x698/0xd30 net/can/bcm.c:995
>  bcm_sendmsg+0x38b/0x470 net/can/bcm.c:1355
>  sock_sendmsg_nosec net/socket.c:724 [inline]
>  sock_sendmsg net/socket.c:747 [inline]
>  ____sys_sendmsg+0x375/0x4c0 net/socket.c:2501
>  ___sys_sendmsg net/socket.c:2555 [inline]
>  __sys_sendmsg+0x1e3/0x270 net/socket.c:2584
>  __do_sys_sendmsg net/socket.c:2593 [inline]
>  __se_sys_sendmsg net/socket.c:2591 [inline]
>  __x64_sys_sendmsg+0x46/0x50 net/socket.c:2591
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> write to 0xffff888137fcff10 of 4 bytes by interrupt on cpu 1:
>  bcm_can_tx+0x38a/0x410
>  bcm_tx_timeout_handler+0xdb/0x260
>  __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
>  __hrtimer_run_queues+0x217/0x700 kernel/time/hrtimer.c:1749
>  hrtimer_run_softirq+0xd6/0x120 kernel/time/hrtimer.c:1766
>  __do_softirq+0xc1/0x265 kernel/softirq.c:571
>  invoke_softirq kernel/softirq.c:445 [inline]
>  __irq_exit_rcu+0x57/0xa0 kernel/softirq.c:650
>  sysvec_apic_timer_interrupt+0x6d/0x80 arch/x86/kernel/apic/apic.c:1107
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
>  kcsan_setup_watchpoint+0x3fe/0x410 kernel/kcsan/core.c:696
>  string_nocheck lib/vsprintf.c:648 [inline]
>  string+0x16c/0x200 lib/vsprintf.c:726
>  vsnprintf+0xa09/0xe20 lib/vsprintf.c:2796
>  add_uevent_var+0xf0/0x1c0 lib/kobject_uevent.c:665
>  kobject_uevent_env+0x225/0x5b0 lib/kobject_uevent.c:539
>  kobject_uevent+0x1c/0x20 lib/kobject_uevent.c:642
>  __loop_clr_fd+0x1e0/0x3b0 drivers/block/loop.c:1167
>  lo_release+0xe4/0xf0 drivers/block/loop.c:1745
>  blkdev_put+0x3fb/0x470
>  kill_block_super+0x83/0xa0 fs/super.c:1410
>  deactivate_locked_super+0x6b/0xd0 fs/super.c:331
>  deactivate_super+0x9b/0xb0 fs/super.c:362
>  cleanup_mnt+0x272/0x2e0 fs/namespace.c:1177
>  __cleanup_mnt+0x19/0x20 fs/namespace.c:1184
>  task_work_run+0x123/0x160 kernel/task_work.c:179
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  exit_to_user_mode_loop+0xd1/0xe0 kernel/entry/common.c:171
>  exit_to_user_mode_prepare+0x6c/0xb0 kernel/entry/common.c:204
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
>  syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:297
>  do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> value changed: 0x00000059 -> 0x00000000
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 3096 Comm: syz-executor.5 Not tainted 6.3.0-syzkaller-00113-g1a0beef98b58 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000059e1b705fa2494e4%40google.com.
