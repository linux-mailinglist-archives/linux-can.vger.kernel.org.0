Return-Path: <linux-can+bounces-1124-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C8D9483FD
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 23:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7C6281FEC
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 21:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F3616A395;
	Mon,  5 Aug 2024 21:18:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F2014A0AB
	for <linux-can@vger.kernel.org>; Mon,  5 Aug 2024 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722892707; cv=none; b=X85zCQiopRElt2EtrNElIlGKw87yRY3nuMugl6BPzbJNKuxbSZzXKYfibeaGuBpfYPT7hkZ4v+8Gm3K+oNyeHi5CLNUYdbV3E2GJ/hn8YyKzVkaXSuz+/3wWaFQPEBTViIpAmJ+d/JxmrAhB9Ol62tpkJ/dcweSoRGw1fWL9/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722892707; c=relaxed/simple;
	bh=Ug6FaoRd1uVVKcuV5Y3oTyiTBb1rMmAfNk+8mRk1Nws=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aO0E3e4AWsn6d8nltOz/CYWQiM+eOszn/cDsqWuH2YKNpybchyn0jjlmVP/7Fc+s9lGoTN/fJE2xaD7cB9HNvispMIRygA1Xnf6w6Lag0+Lie3kKotCHUtYOfA/3C141ZgoWqh12C2AGJlggW6Hfhs4APPFtLGmPXyBcuIqkAao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81fa44764bbso2398839f.3
        for <linux-can@vger.kernel.org>; Mon, 05 Aug 2024 14:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722892705; x=1723497505;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XV2MHzz7ZUZ/ujiLmFN67qyBq0+q1jtkQs1WR9aYyGc=;
        b=wGFbm1MiCu4SgDeCaAq7d8LAGl6RmSz1J6HeGSC6JU9xU9LtwmZ8lBdaOgBTpzyBmF
         8CU6wuJQ2gZEN7KELqb3AhWAeaOjD35W+m2tGi/CAu4O9cPJVoktEddQwBUVgfLbZKUD
         bdI6QHbRL1dD54l8JpAyTlNij+QS5H9qo5jonIcEWsgrSHPCSVMK2nYHCmMKuWdSvCtr
         tibJFH5Y7zy1zUuGBUWGHEIj5gzJNk/q8iMloZadojfiSagj5Z4q5L6ZyUS6kBODeatX
         FyUAtqabSf8Sv1qEAe+p94lR8Qd3jNsu1qg9fW9vmm+hy5bBLvvzL0gZCz4vS9ixH0+/
         d8nQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7EOeioGybN7+WFMhn6EL6SLad1I4n6m/kjmoYu1pBZGL543SSrtJ6NRXLlt2tpPez9fmIVjITcXPzD1ifTzZZ0t3ce2P2L4KB
X-Gm-Message-State: AOJu0Yy1fCXXummn2b7wUVv/8jof9yp0RFv5Hdm9mTKHv1aFQuA4OGwo
	vsEbhyqg7ffYp7BInHFgB0zXwvPqI6epx++xHJSZZuO9Zxir1Hqcr1tnOK9KwKJxBnl3XX46fex
	jVL+LIhupvObIZq0RBr1sj85mddhC0IdxgdivJR/7ZxxEsmDJhd3YOuk=
X-Google-Smtp-Source: AGHT+IEDuMqczrZgHPmUtDl4vUoyicAQZ6yt3rIFV42BelIcmnMHtwxfc12jJaU2IbtkeyJ6KbjDImmQFg54+Ib/xLBoA9RqWdcZ
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410b:b0:4c2:7945:5a32 with SMTP id
 8926c6da1cb9f-4c8d56c392amr821838173.5.1722892705302; Mon, 05 Aug 2024
 14:18:25 -0700 (PDT)
Date: Mon, 05 Aug 2024 14:18:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af9991061ef63774@google.com>
Subject: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
From: syzbot <syzbot+ad601904231505ad6617@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de, 
	kuba@kernel.org, leitao@debian.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mkl@pengutronix.de, netdev@vger.kernel.org, 
	o.rempel@pengutronix.de, pabeni@redhat.com, robin@protonic.nl, 
	socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    743ff02152bc ethtool: Don't check for NULL info in prepare..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=146ac8d3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131875c9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1741f94b980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/69cb8d5cd046/disk-743ff021.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8f52c95a23c5/vmlinux-743ff021.xz
kernel image: https://storage.googleapis.com/syzbot-assets/93f2f40e650b/bzImage-743ff021.xz

The issue was bisected to:

commit c9c0ee5f20c593faf289fa8850c3ed84031dd12a
Author: Breno Leitao <leitao@debian.org>
Date:   Mon Jul 29 10:47:40 2024 +0000

    net: skbuff: Skip early return in skb_unref when debugging

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16b7066d980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15b7066d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11b7066d980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Fixes: c9c0ee5f20c5 ("net: skbuff: Skip early return in skb_unref when debugging")

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 5233 at lib/refcount.c:28 refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
Modules linked in:
CPU: 0 UID: 0 PID: 5233 Comm: syz-executor339 Not tainted 6.10.0-syzkaller-12610-g743ff02152bc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
Code: 00 17 40 8c e8 67 97 a5 fc 90 0f 0b 90 90 eb 99 e8 1b 89 e3 fc c6 05 76 7d 31 0b 01 90 48 c7 c7 60 17 40 8c e8 47 97 a5 fc 90 <0f> 0b 90 90 e9 76 ff ff ff e8 f8 88 e3 fc c6 05 50 7d 31 0b 01 90
RSP: 0018:ffffc900000076a0 EFLAGS: 00010246
RAX: adacdd6de1fa9d00 RBX: ffff88802c47c224 RCX: ffff8880234fda00
RDX: 0000000080000101 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffff81559432 R09: 1ffff1101724519a
R10: dffffc0000000000 R11: ffffed101724519b R12: ffff88807d01a468
R13: ffff88802c47c224 R14: 1ffff1100fa03498 R15: ffff88807d01a400
FS:  0000555569709380(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 000000001eb56000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 kfree_skb_reason include/linux/skbuff.h:1260 [inline]
 kfree_skb include/linux/skbuff.h:1269 [inline]
 j1939_session_destroy net/can/j1939/transport.c:282 [inline]
 __j1939_session_release net/can/j1939/transport.c:294 [inline]
 kref_put include/linux/kref.h:65 [inline]
 j1939_session_put+0x1e7/0x440 net/can/j1939/transport.c:299
 j1939_tp_cmd_recv net/can/j1939/transport.c:2113 [inline]
 j1939_tp_recv+0x7fe/0x1050 net/can/j1939/transport.c:2161
 j1939_can_recv+0x732/0xb20 net/can/j1939/main.c:108
 deliver net/can/af_can.c:572 [inline]
 can_rcv_filter+0x359/0x7f0 net/can/af_can.c:606
 can_receive+0x31c/0x470 net/can/af_can.c:663
 can_rcv+0x144/0x260 net/can/af_can.c:687
 __netif_receive_skb_one_core net/core/dev.c:5660 [inline]
 __netif_receive_skb+0x2e0/0x650 net/core/dev.c:5774
 process_backlog+0x662/0x15b0 net/core/dev.c:6107
 __napi_poll+0xcb/0x490 net/core/dev.c:6771
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 0e 9c 3b f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 63 c1 a3 f5 65 8b 05 64 b7 44 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc900035378c0 EFLAGS: 00000206
RAX: adacdd6de1fa9d00 RBX: 1ffff920006a6f1c RCX: ffffffff81701f3a
RDX: dffffc0000000000 RSI: ffffffff8bead5a0 RDI: 0000000000000001
RBP: ffffc90003537950 R08: ffffffff9351e8e7 R09: 1ffffffff26a3d1c
R10: dffffc0000000000 R11: fffffbfff26a3d1d R12: dffffc0000000000
R13: 1ffff920006a6f18 R14: ffffc900035378e0 R15: 0000000000000246
 j1939_sk_send_loop net/can/j1939/socket.c:1164 [inline]
 j1939_sk_sendmsg+0xe01/0x14c0 net/can/j1939/socket.c:1277
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd558d90e09
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe518919c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd558d90e09
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe51891a20
R13: 00007fd558dde406 R14: 0000000000000003 R15: 00007ffe51891a00
 </TASK>
----------------
Code disassembly (best guess):
   0:	9c                   	pushf
   1:	8f 44 24 20          	pop    0x20(%rsp)
   5:	42 80 3c 23 00       	cmpb   $0x0,(%rbx,%r12,1)
   a:	74 08                	je     0x14
   c:	4c 89 f7             	mov    %r14,%rdi
   f:	e8 0e 9c 3b f6       	call   0xf63b9c22
  14:	f6 44 24 21 02       	testb  $0x2,0x21(%rsp)
  19:	75 52                	jne    0x6d
  1b:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 63 c1 a3 f5       	call   0xf5a3c192 <-- trapping instruction
  2f:	65 8b 05 64 b7 44 74 	mov    %gs:0x7444b764(%rip),%eax        # 0x7444b79a
  36:	85 c0                	test   %eax,%eax
  38:	74 43                	je     0x7d
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	04 24                	add    $0x24,%al
  3e:	0e                   	(bad)
  3f:	36                   	ss


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

