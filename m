Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19D26F0D40
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2019 04:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbfKFDqK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Nov 2019 22:46:10 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:44813 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfKFDqK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Nov 2019 22:46:10 -0500
Received: by mail-il1-f200.google.com with SMTP id 13so20502202iln.11
        for <linux-can@vger.kernel.org>; Tue, 05 Nov 2019 19:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VXg4Mq0SWPKWmRdwQW93Z51ZtCZqzCSQfSajmJNia7w=;
        b=JVMr8LnNg8SaVI5dmOYUp1zZouc7LRBm8M+skn+WoNKBfi/uZamVBUu9CG6WSI0nkZ
         PLYF8I4QEvHhq9WGUOfDIKTDVHwyjMdzdQRulA6iPtX9jz63l0HyuSruYJUjwOc6Td0R
         TFWcxqbTmdWL7wAZx+BKuVsGLL1CSDc/Lb3Lmfw35mAZLuuGXgi0D0v+gXvyv1OJnUla
         Q83vi2bAhiNBf6f+g/YChbDXZZEgssLrXmuMhy5AymLpGYeJhRJRdypCIFkXMmQEToqp
         i2sWeiK6yk5rJn2PTtArhyDvdBJVISAYzTu4eDnKVJXfxzocYiNm+C1c4GU5BahpoG+H
         hsrg==
X-Gm-Message-State: APjAAAWUPjCyvSNOogKlUXA3H2LBISFQfYejXnDn6MC2JZ8RikwyePM8
        gmya4IuqEBj/akogNbtOrrbr4Pq+fC0H6IWRRcQKsgJSg1Y7
X-Google-Smtp-Source: APXvYqz0exuhDAqf8OGKbULgDJ3QFG01eYS7lhaQg2N475G/AW27mI4xyzY1bu/1aPrqAouAnKS7BMCHBgn41UKC4+7ZbegNbmbR
MIME-Version: 1.0
X-Received: by 2002:a5e:c31a:: with SMTP id a26mr32781557iok.0.1573011969464;
 Tue, 05 Nov 2019 19:46:09 -0800 (PST)
Date:   Tue, 05 Nov 2019 19:46:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aae1480596a5632b@google.com>
Subject: WARNING: refcount bug in j1939_netdev_start
From:   syzbot <syzbot+afd421337a736d6c1ee6@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kernel@pengutronix.de,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a99d8080 Linux 5.4-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a7443ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5e2eca3f31f9bf
dashboard link: https://syzkaller.appspot.com/bug?extid=afd421337a736d6c1ee6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+afd421337a736d6c1ee6@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: increment on 0; use-after-free.
WARNING: CPU: 0 PID: 27509 at lib/refcount.c:156 refcount_inc_checked  
lib/refcount.c:156 [inline]
WARNING: CPU: 0 PID: 27509 at lib/refcount.c:156  
refcount_inc_checked+0x61/0x70 lib/refcount.c:154
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 27509 Comm: syz-executor.5 Not tainted 5.4.0-rc6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2e3/0x75c kernel/panic.c:221
  __warn.cold+0x2f/0x35 kernel/panic.c:582
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:refcount_inc_checked lib/refcount.c:156 [inline]
RIP: 0010:refcount_inc_checked+0x61/0x70 lib/refcount.c:154
Code: 1d ce 0c 7e 06 31 ff 89 de e8 bb a8 2e fe 84 db 75 dd e8 72 a7 2e fe  
48 c7 c7 c0 af e6 87 c6 05 ae 0c 7e 06 01 e8 57 dc ff fd <0f> 0b eb c1 90  
90 90 90 90 90 90 90 90 90 90 55 48 89 e5 41 57 41
RSP: 0018:ffff88805c33fce8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000016597 RSI: ffffffff815cc396 RDI: ffffed100b867f8f
RBP: ffff88805c33fcf8 R08: ffff8880921ae440 R09: ffffed1015d04101
R10: ffffed1015d04100 R11: ffff8880ae820807 R12: ffff8880604010f0
R13: ffff88805c33fe00 R14: ffff888045255580 R15: 0000000000000118
  kref_get include/linux/kref.h:45 [inline]
  j1939_netdev_start+0x53/0x550 net/can/j1939/main.c:247
  j1939_sk_bind+0x65a/0x8e0 net/can/j1939/socket.c:438
  __sys_bind+0x239/0x290 net/socket.c:1647
  __do_sys_bind net/socket.c:1658 [inline]
  __se_sys_bind net/socket.c:1656 [inline]
  __x64_sys_bind+0x73/0xb0 net/socket.c:1656
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a219
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2ba4d29c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a219
RDX: 0000000000000018 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2ba4d2a6d4
R13: 00000000004c057e R14: 00000000004d2c50 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
