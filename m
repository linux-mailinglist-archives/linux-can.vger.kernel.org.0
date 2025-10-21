Return-Path: <linux-can+bounces-5248-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DA1BF6B62
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 15:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87A024E7F76
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E50B86347;
	Tue, 21 Oct 2025 13:16:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2716212546
	for <linux-can@vger.kernel.org>; Tue, 21 Oct 2025 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052596; cv=none; b=HQgVMV5s2WC+8NnXhN68mhHsqr8uR5Bb3FPzIgmV+ofHuFxCdcrw0gCcQBejUCFbMg7OCbY+5VNOD2AQN54CRRkJMFgfYu3lJclu5nlrcXTooeTBL/tS0RiPi3rI/cc8ywEtUpPVBFz7N5ysclNDG91TlQsuIMyUGily/ldlYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052596; c=relaxed/simple;
	bh=4lO37nzrIpBC423IxnKVQSeJkCQrkTfEy9wzC0YiE10=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=deaYJmeWuDcqQzp3Hvsm/TCaaQDVcn4f86BiCiXwenHjOrvGT+Tyi6efo2rhZPiwRxR/fnnSbj2p42o2aOUQ2unQknM7PFBxyZtI3+gob6IDTYIh0k78VnebTquplPQymhkByRR3/MbCXJc7yRQWcgGJsrhnt+AW3FWthYfApyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-430d789ee5aso33055665ab.2
        for <linux-can@vger.kernel.org>; Tue, 21 Oct 2025 06:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052594; x=1761657394;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QaEtq608qHIwmej6NQk9j0kRKo2k3QnrAL9CW0txtrM=;
        b=CceI7fBdUBzI+Ruuw3/5m7BIlgHmUtyHgdoVfSyYYDqvl5SPukJf/o5zmXxgkqsMcK
         6zjbmRP9zw7EnkABFUMihQPK+1jxaVptmJAIMUYbaCVqukUNUWCADi7cRbGqzP2Ui4DP
         UltmxvUphCqxwfsjkpkPCdXjYDKAMeSzlAvVs1ZGzT1TTNQJecJbOO/xxXs2Unz9BpVA
         w38NBsVR5H9JQOSJbz+qIAoRubyQSNjGpfqHcwvXmCUkZyoqJohU91TXyZKmHnY9kJ1M
         S4Avx1DIEDEh1eEvRdBKsX0jDHFjdgyjBlsXnaP8kZyvOwxcmEOV6LjYwj0p2ha+GdY7
         9/Ug==
X-Gm-Message-State: AOJu0YwlBty9wU1QoPT/qJcW3vmUGjOt+1JyYS7zQzAsBT9qD2ykr2W8
	GwmK88gB0PcOgdxCRqFpkoHhM4knkQFZBmUMFG/g3ZgiINpLLFWlFABnvZNAuEUiKsgmQwd5GnL
	j3Gsgd4SN+HJWHjlFGKw59YKKBQHEidP2CEDaynSJWeUdGvPysFhAi90ITeil/g==
X-Google-Smtp-Source: AGHT+IEJZ8XvlCYCgVR6vGEL2ByPS/F/dPCsyXntFCLM1/ojcI275IP5TD3P3NoKbuhxBfMSYs0elzRc39SD7RQktq6NpIM4VWVL
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2301:b0:430:ab2c:bd9f with SMTP id
 e9e14a558f8ab-430c5254fffmr247876525ab.10.1761052593942; Tue, 21 Oct 2025
 06:16:33 -0700 (PDT)
Date: Tue, 21 Oct 2025 06:16:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f787b1.a70a0220.3bf6c6.0006.GAE@google.com>
Subject: [syzbot] [can?] general protection fault in can_rx_unregister
From: syzbot <syzbot+7a52d4cc48fa6eae3c86@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    98ac9cc4b445 Merge tag 'f2fs-fix-6.18-rc2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1732b67c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
dashboard link: https://syzkaller.appspot.com/bug?extid=7a52d4cc48fa6eae3c86
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1c3d2e04d272/disk-98ac9cc4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eccd74106a6c/vmlinux-98ac9cc4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f6ac0e43209c/bzImage-98ac9cc4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7a52d4cc48fa6eae3c86@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 0 UID: 0 PID: 4715 Comm: syz.0.9421 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:can_rx_unregister+0x250/0x730 net/can/af_can.c:537
Code: 54 24 20 48 8d 84 24 b8 00 00 00 48 8d 74 24 78 48 8d 78 b0 e8 11 dc ff ff 48 ba 00 00 00 00 00 fc ff df 48 89 c1 48 c1 e9 03 <80> 3c 11 00 0f 85 7a 04 00 00 48 8b 18 44 8b 64 24 68 44 8b 74 24
RSP: 0018:ffffc9000584fba8 EFLAGS: 00010206
RAX: 0000000000000030 RBX: 0000000000000000 RCX: 0000000000000006
RDX: dffffc0000000000 RSI: ffffffff8a56c94b RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 00000000c00007ff
R10: 00000000c00007ff R11: 0000000000000001 R12: ffff88808f3a8568
R13: ffff88807c774000 R14: 0000000000000002 R15: 1ffff92000b09f7c
FS:  000055558d910500(0000) GS:ffff8881249d6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b327dfff8 CR3: 000000005b42d000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 isotp_release+0x937/0xb90 net/can/isotp.c:1213
 __sock_release+0xb3/0x270 net/socket.c:662
 sock_close+0x1c/0x30 net/socket.c:1455
 __fput+0x402/0xb70 fs/file_table.c:468
 task_work_run+0x150/0x240 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x426/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc323b8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdf923ea98 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fc323de7da0 RCX: 00007fc323b8efc9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fc323de7da0 R08: 00000000000427cc R09: 0000000ff923ed8f
R10: 00007fc323de7cb0 R11: 0000000000000246 R12: 000000000021db0a
R13: 00007fc323de6270 R14: ffffffffffffffff R15: 00007ffdf923ebb0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:can_rx_unregister+0x250/0x730 net/can/af_can.c:537
Code: 54 24 20 48 8d 84 24 b8 00 00 00 48 8d 74 24 78 48 8d 78 b0 e8 11 dc ff ff 48 ba 00 00 00 00 00 fc ff df 48 89 c1 48 c1 e9 03 <80> 3c 11 00 0f 85 7a 04 00 00 48 8b 18 44 8b 64 24 68 44 8b 74 24
RSP: 0018:ffffc9000584fba8 EFLAGS: 00010206
RAX: 0000000000000030 RBX: 0000000000000000 RCX: 0000000000000006
RDX: dffffc0000000000 RSI: ffffffff8a56c94b RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 00000000c00007ff
R10: 00000000c00007ff R11: 0000000000000001 R12: ffff88808f3a8568
R13: ffff88807c774000 R14: 0000000000000002 R15: 1ffff92000b09f7c
FS:  000055558d910500(0000) GS:ffff8881249d6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b327dfff8 CR3: 000000005b42d000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	54                   	push   %rsp
   1:	24 20                	and    $0x20,%al
   3:	48 8d 84 24 b8 00 00 	lea    0xb8(%rsp),%rax
   a:	00
   b:	48 8d 74 24 78       	lea    0x78(%rsp),%rsi
  10:	48 8d 78 b0          	lea    -0x50(%rax),%rdi
  14:	e8 11 dc ff ff       	call   0xffffdc2a
  19:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  20:	fc ff df
  23:	48 89 c1             	mov    %rax,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
* 2a:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1) <-- trapping instruction
  2e:	0f 85 7a 04 00 00    	jne    0x4ae
  34:	48 8b 18             	mov    (%rax),%rbx
  37:	44 8b 64 24 68       	mov    0x68(%rsp),%r12d
  3c:	44                   	rex.R
  3d:	8b                   	.byte 0x8b
  3e:	74 24                	je     0x64


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

