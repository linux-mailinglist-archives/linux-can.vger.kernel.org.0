Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF02C4667
	for <lists+linux-can@lfdr.de>; Wed, 25 Nov 2020 18:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgKYRFR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Nov 2020 12:05:17 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:52861 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730647AbgKYRFR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Nov 2020 12:05:17 -0500
Received: by mail-io1-f71.google.com with SMTP id i19so1938829ioa.19
        for <linux-can@vger.kernel.org>; Wed, 25 Nov 2020 09:05:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4egMIs+9RjkoWxvqY8Ly2lD2Sy7rWatLrP2K7PTB5sQ=;
        b=R4bWlDRbhojalupzIdVgKWTep7k1c6YtsfXV+HsGtI36aam/DlETrCc0Rys3uv4KUx
         5lVeTi7el5d0gs+5rrVwRIs2+Br2l+1avEnxYL7HYfCuF0xG1rfQ0bgHoHxkh0Y2P7f6
         OPrXUKa+hHH6csgVWhs9SeY9DDEBv+e7ufjeqdFqRNrOa1lB4Q09SPBgieleU0USdUQO
         dEwIEm1wgK1c/TUNo6Hmmn9RXg1Bs0z0PRJ3HB72maMrzE779E7woeLfgoStmpb7r2iE
         F0H/Z8/hdPVZAJHgsBTXtNJuWMTCCvJeadAb+YyZUyAGpdzDogypm6tEbzr1wUApCNCH
         4Q+Q==
X-Gm-Message-State: AOAM530PLeRtI9GNrgJEKYMwoAUwrRyRa0caQA3Fm+whfmkI8gpc91zf
        sWiSLhiI2ogCOu2HQK/t6V9aar8lEufK9DAy+d4oR5dxh8Qq
X-Google-Smtp-Source: ABdhPJxUYd54X4S7tbnyvh+HKXvkHdcZqFdPFnJhqsYXBV+gWMNWAihmr8SV8ek8cUTPctiTd3Vq5WYkgSjh0SX8P38B04dzF1i9
MIME-Version: 1.0
X-Received: by 2002:a5e:c10a:: with SMTP id v10mr3390892iol.54.1606323916136;
 Wed, 25 Nov 2020 09:05:16 -0800 (PST)
Date:   Wed, 25 Nov 2020 09:05:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a69d505b4f16e83@google.com>
Subject: BUG: receive list entry not found for dev vxcan1, id 003, mask C00007FF
From:   syzbot <syzbot+76d62d3b8162883c7d11@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, mkl@pengutronix.de,
        netdev@vger.kernel.org, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    470dfd80 lan743x: replace polling loop by wait_event_timeo..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13f46c65500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df65150a33f23d8c
dashboard link: https://syzkaller.appspot.com/bug?extid=76d62d3b8162883c7d11
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1164f8fd500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148ae72b500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76d62d3b8162883c7d11@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: 00007ffc766d7540 RCX: 0000000000443729
RDX: 0000000000000018 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000001bbbbbb
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
------------[ cut here ]------------
BUG: receive list entry not found for dev vxcan1, id 003, mask C00007FF
WARNING: CPU: 1 PID: 8479 at net/can/af_can.c:546 can_rx_unregister+0x5a4/0x700 net/can/af_can.c:546
Modules linked in:
CPU: 1 PID: 8479 Comm: syz-executor218 Not tainted 5.10.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:can_rx_unregister+0x5a4/0x700 net/can/af_can.c:546
Code: 8b 7c 24 78 44 8b 64 24 68 49 c7 c5 e0 de 56 8a e8 51 d3 95 f9 44 89 f9 44 89 e2 4c 89 ee 48 c7 c7 20 df 56 8a e8 a6 76 d3 00 <0f> 0b 48 8b 7c 24 28 e8 40 e9 0e 01 e9 54 fb ff ff e8 66 db d7 f9
RSP: 0018:ffffc900016ff9f0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888020251a40 RSI: ffffffff8158f3c5 RDI: fffff520002dff30
RBP: 0000000000000118 R08: 0000000000000001 R09: ffff8880b9f30627
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
R13: ffff88802c1c0000 R14: 1ffff920002dff45 R15: 00000000c00007ff
FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c8908 CR3: 000000000b08e000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 isotp_notifier+0x2a7/0x540 net/can/isotp.c:1303
 call_netdevice_notifier net/core/dev.c:1735 [inline]
 call_netdevice_unregister_notifiers+0x156/0x1c0 net/core/dev.c:1763
 call_netdevice_unregister_net_notifiers net/core/dev.c:1791 [inline]
 unregister_netdevice_notifier+0xcd/0x170 net/core/dev.c:1870
 isotp_release+0x136/0x600 net/can/isotp.c:1011
 __sock_release+0xcd/0x280 net/socket.c:596
 sock_close+0x18/0x20 net/socket.c:1255
 __fput+0x285/0x920 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:151
 exit_task_work include/linux/task_work.h:30 [inline]
 do_exit+0xb64/0x29b0 kernel/exit.c:809
 do_group_exit+0x125/0x310 kernel/exit.c:906
 __do_sys_exit_group kernel/exit.c:917 [inline]
 __se_sys_exit_group kernel/exit.c:915 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:915
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x442368
Code: Unable to access opcode bytes at RIP 0x44233e.
RSP: 002b:00007ffc766d74a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000442368
RDX: 0000000000000001 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00000000004c88d0 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006dd240 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
