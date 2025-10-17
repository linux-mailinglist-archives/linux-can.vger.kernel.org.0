Return-Path: <linux-can+bounces-5231-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 521ECBEBEDF
	for <lists+linux-can@lfdr.de>; Sat, 18 Oct 2025 00:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75CC1AA797B
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 22:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD302D97AB;
	Fri, 17 Oct 2025 22:35:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DE122DF99
	for <linux-can@vger.kernel.org>; Fri, 17 Oct 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760740530; cv=none; b=JnCuN28xOCgT2h2PEH7EBz0BKeN5uSk+2vZJ8U1L0eLsE9ODMbRu2z5htutZlLMQ9x433gKZDNdCQAPGe3+GJ23Dfdrl0+Ai78sMIYoe93JNXxRe9Y7C1D5rBYKDOueEPwoZHajXavY7NrAV2l2OTvo5zmHTDa/rXMqIyAuLjB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760740530; c=relaxed/simple;
	bh=PKv5bHN/3qCTKYaMRzD720nJxijAFGERs4zcYZwRP5U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HMQc/m3+OU7sXrPd72vpPB0txORcLURlTDqjrz7KbUrAcwqvt0Nu98LQ4b+AdNuMjciXlHM7G9OpReqC5HX7tSTJltoisB6WshwVAHSN7BvOBIGRRIcAox3QVEfLlxZsHJhYi3hdMDOuFC9RfKSEVR0b/0WrOTytMhPq7fLxVwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-430ce62d138so9585955ab.3
        for <linux-can@vger.kernel.org>; Fri, 17 Oct 2025 15:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760740528; x=1761345328;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ma2tyPSgOIy6o4oAc1xh2wdxokLE5qmVDJsVioLtCws=;
        b=cOVHgmfupMaZsp5VdxKoca0gQKU3AON1b8sT+GZP6rUuAkcqmjW9NGeWTFHG2zSAVu
         VhxBTXUDBTYqS4EgW3EG1Wpd4q6kW+iXE31iD/yK9PyfBzgqtgA+pEXLQVtvRTUEu1fj
         TtAIo2OahKyf79uLokhpBVpQ5YcMFlSZr5J4MgF9B8SKaz2SyX6em9jN0Cla5CoS/EgD
         ddkIu5miuYJShzGbbNHj4H9/nRc5QEwD51QNOlPRiEMxZ9CjGvdTB+SKgoFPDcrWDPWA
         udNSCmhpu1XiTxLowo0spUIZXSF/bPO24+cIQmhEC+JfuTTZNtazBv80YybBDnAazPKH
         KnZg==
X-Forwarded-Encrypted: i=1; AJvYcCVBKGHtH/2G40gCjsCycmR6hT0/2vennv45zdRzA+TRcprutlS8zaquSfhV8OJKYalmA1tI27K5Uvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5AtXB7Vk7zXDsrXCukvh2nqnWqS133it4ULWech3VIL51FQVH
	K47Yuv2LZW0zsVGSCE7Z5keuxxbKER7HyDbdKVBCHeY4Ogeoqdn/qJxGIpYeyO90iYM0NtiAzDt
	7Xd2fD/zMvQpffjmrIlHNw6HaL7IbLC1duQN3qAHDy7rt6b+eKlgJGMusTq4=
X-Google-Smtp-Source: AGHT+IH3DZ2NU6UZRw9U4zZaYJYKjFeinvNIbfLhLZvXm067ybibJLcCEJFxIO9Dr7rB1HsP10zKysdAY/O4LZdnV4aivD4F5iGJ
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2708:b0:430:adcb:b38d with SMTP id
 e9e14a558f8ab-430c528dbdbmr66174275ab.24.1760740527943; Fri, 17 Oct 2025
 15:35:27 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:35:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f2c4af.050a0220.91a22.0430.GAE@google.com>
Subject: [syzbot] [can?] kernel panic: kmsan.panic set ... (3)
From: syzbot <syzbot+adeb80b314a69f963c25@syzkaller.appspotmail.com>
To: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de, 
	robin@protonic.nl, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    98ac9cc4b445 Merge tag 'f2fs-fix-6.18-rc2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a7d52f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=adeb80b314a69f963c25
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd52c1c69e8d/disk-98ac9cc4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20aa9a5c71e1/vmlinux-98ac9cc4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3d3726631c9d/bzImage-98ac9cc4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+adeb80b314a69f963c25@syzkaller.appspotmail.com

Kernel panic - not syncing: kmsan.panic set ...
CPU: 1 UID: 0 PID: 8119 Comm: syz.4.12965 Tainted: G    B   W           syzkaller #0 PREEMPT(none) 
Tainted: [B]=BAD_PAGE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <IRQ>
 __dump_stack+0x26/0x30 lib/dump_stack.c:94
 dump_stack_lvl+0x53/0x270 lib/dump_stack.c:120
 dump_stack+0x1e/0x25 lib/dump_stack.c:129
 vpanic+0x435/0xd30 kernel/panic.c:489
 panic+0x15d/0x160 kernel/panic.c:626
 kmsan_report+0x31c/0x320 mm/kmsan/report.c:218
 __msan_warning+0x1b/0x30 mm/kmsan/instrumentation.c:315
 can_receive+0x12c/0x4a0 net/can/af_can.c:656
 can_rcv+0x1ff/0x3b0 net/can/af_can.c:690
 __netif_receive_skb_one_core net/core/dev.c:6079 [inline]
 __netif_receive_skb+0x477/0xac0 net/core/dev.c:6192
 process_backlog+0x485/0xa00 net/core/dev.c:6544
 __napi_poll+0xdd/0x8a0 net/core/dev.c:7594
 napi_poll net/core/dev.c:7657 [inline]
 net_rx_action+0xbc8/0x1c30 net/core/dev.c:7784
 handle_softirqs+0x169/0x6e0 kernel/softirq.c:622
 __do_softirq+0x14/0x1b kernel/softirq.c:656
 do_softirq+0x99/0x100 kernel/softirq.c:523
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xa1/0xb0 kernel/softirq.c:450
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
 _raw_spin_unlock_bh+0x2d/0x40 kernel/locking/spinlock.c:210
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 release_sock+0x21d/0x270 net/core/sock.c:3744
 j1939_sk_sendmsg+0xeb/0x2760 net/can/j1939/socket.c:1285
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x333/0x3d0 net/socket.c:742
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2630
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2684
 __sys_sendmsg+0x1aa/0x300 net/socket.c:2716
 __compat_sys_sendmsg net/compat.c:346 [inline]
 __do_compat_sys_sendmsg net/compat.c:353 [inline]
 __se_compat_sys_sendmsg net/compat.c:350 [inline]
 __ia32_compat_sys_sendmsg+0xa4/0x100 net/compat.c:350
 ia32_sys_call+0x3f6c/0x4310 arch/x86/include/generated/asm/syscalls_32.h:371
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb0/0x150 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:369
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf705d539
Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f544d55c EFLAGS: 00000206 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000080000140
RDX: 000000000404c881 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..
----------------
Code disassembly (best guess):
   0:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   4:	10 07                	adc    %al,(%rdi)
   6:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   a:	10 08                	adc    %cl,(%rax)
   c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

