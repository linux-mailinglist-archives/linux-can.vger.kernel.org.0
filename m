Return-Path: <linux-can+bounces-575-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 682DF8BC988
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 10:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90507B21394
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B19814198A;
	Mon,  6 May 2024 08:26:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3E31411CE
	for <linux-can@vger.kernel.org>; Mon,  6 May 2024 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983985; cv=none; b=ExhrZRP9z6O+vx6VrLp+22bCfMaPngdiSaABr/Uhn1/RKjo7C8C1KPd0VhK2c+hqIOOzF/e1BYoF7o29vko5BqpmFWM5VfkYlddP7DdQX6c9+t1UaSuxrX0kFvoNvP9KFxJLF1WjMjGD66lu3uWzB7+JSOABk9UAsvQP4ZJEjH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983985; c=relaxed/simple;
	bh=9DH8669XG/Ixy8wh+L2L+LtEHVqz9ke80uxBV0M0yyU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f2rbAUOSb97uyKR7DF/vFVhZOVolMCuKr2mgswtqogyxdsoDWIpJWUJ8//Kb5tL86W5/4iFc5kQBIxMADQsuVHE8vxtt7BDGQlqgMNjK+2Q97pzarNyW/IFN3qfHXb+GhNCL0oJbD9cpNZD+CZ9Psx/5hT3IorWYbFWgK/VUKK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7ddf0219685so222606839f.3
        for <linux-can@vger.kernel.org>; Mon, 06 May 2024 01:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714983983; x=1715588783;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L2xlgFBEnuKBvs1b/xq2ok0L7pUKU22p3gz9yez+dYI=;
        b=WCl8HEmu0QCDtLXjBtgtjnNneptAz9O9yJyjNrPEIHf9zJILIzgCps7xwx3YNDPAuz
         OLqyhhio0tJ1iDKO/eI3r79AQpCD5Y3AvVgs3I8tSK3hDGI7RFcwXD/vdZabm53XAbJN
         Y98l/FhX+aWlgwHoxl0uWO/Wy3PXAgfavmRJj544XvDHjYa6Hr2BIebvRDM9eWM0NjbT
         de7YMunyYc57z9h+hMI/Mfi/ozXSlIWcCqCJWqHkZLmpva7NulsccmCEngktdZ5ewkb6
         AVMQIA831CaQ6SzHnrWo9fznquCyoshMcBa8vW+WF8sC5rHZ9gS/RMIMLSQhqxdjG69v
         ROgg==
X-Forwarded-Encrypted: i=1; AJvYcCWeQxJWakiCRM4dlj8mRezhk2mH5ad11zsbAHi/yAldbAyn3KKuZMPOUIzFjtSFg9zpkxUJY/g3cOIwTVad/e6icybJmi0OooaN
X-Gm-Message-State: AOJu0YwdjWwU1r2r0eVq9DwDQ2CgotCfAUY1kRHJRgNsS+VfF+ofpvUm
	8TScF4p53DR4s3eU7npp3ybvYE9+XemwIfbVwmRdYimk9TNDVfzGUQoMNHuwXWS9PCOFbyKQ/AH
	Qlz/vCOemlaCYTZ8JvY//hfyULcwUWLCmzgzmo14SjJ5rpgnbV+78ByE=
X-Google-Smtp-Source: AGHT+IHQv0tSDZbVA33dBTBInuUMcIm0TDgZIdbPg037yGhhXbdcqEHJgGolzLQYL6h7JXmdlh7XCv6Kn7vbdpLB/ZPhFvS8cUuX
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4c85:b0:488:59cc:eb44 with SMTP id
 do5-20020a0566384c8500b0048859cceb44mr409193jab.3.1714983983353; Mon, 06 May
 2024 01:26:23 -0700 (PDT)
Date: Mon, 06 May 2024 01:26:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fa3ce0617c4d3c1@google.com>
Subject: [syzbot] [can?] WARNING in j1939_xtp_rx_rts (2)
From: syzbot <syzbot+ce5405b9159db688fa37@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, o.rempel@pengutronix.de, 
	pabeni@redhat.com, robin@protonic.nl, socketcan@hartkopp.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cdc74c9d06e7 Merge branch 'gve-queue-api'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17beea2f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c70a227bc928e1b
dashboard link: https://syzkaller.appspot.com/bug?extid=ce5405b9159db688fa37
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0df1462721b/disk-cdc74c9d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7e5c38fb35eb/vmlinux-cdc74c9d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8b7652427355/bzImage-cdc74c9d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ce5405b9159db688fa37@syzkaller.appspotmail.com

vxcan0: j1939_xtp_rx_abort_one: 0xffff888042069c00: 0x00000: (8) Duplicate sequence number (and software is not able to recover)
vxcan0: j1939_xtp_rx_abort_one: 0xffff88804206a000: 0x00000: (8) Duplicate sequence number (and software is not able to recover)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 11 at net/can/j1939/transport.c:1656 j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1656 [inline]
WARNING: CPU: 1 PID: 11 at net/can/j1939/transport.c:1656 j1939_xtp_rx_rts+0x13db/0x1930 net/can/j1939/transport.c:1735
Modules linked in:
CPU: 1 PID: 11 Comm: kworker/u8:1 Not tainted 6.9.0-rc6-syzkaller-01478-gcdc74c9d06e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: krdsd rds_connect_worker
RIP: 0010:j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1656 [inline]
RIP: 0010:j1939_xtp_rx_rts+0x13db/0x1930 net/can/j1939/transport.c:1735
Code: e8 7a f6 8a f7 e9 d6 f1 ff ff 89 d9 80 e1 07 38 c1 0f 8c ea f1 ff ff 48 89 df e8 60 f6 8a f7 e9 dd f1 ff ff e8 06 fd 25 f7 90 <0f> 0b 90 e9 6d f2 ff ff 89 f9 80 e1 07 38 c1 0f 8c 51 ee ff ff 48
RSP: 0018:ffffc90000a08640 EFLAGS: 00010246
RAX: ffffffff8a702d7a RBX: 00000000fffffff5 RCX: ffff8880172abc00
RDX: 0000000080000100 RSI: 00000000fffffff5 RDI: 0000000000000000
RBP: ffffc90000a087a8 R08: ffffffff8a702aec R09: 1ffffffff25e80c6
R10: dffffc0000000000 R11: fffffbfff25e80c7 R12: dffffc0000000000
R13: ffff888042fab000 R14: 0000000000000014 R15: 00000000000007c6
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c000461144 CR3: 000000007cc42000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 j1939_tp_cmd_recv net/can/j1939/transport.c:2057 [inline]
 j1939_tp_recv+0xb84/0x1050 net/can/j1939/transport.c:2144
 j1939_can_recv+0x732/0xb20 net/can/j1939/main.c:112
 deliver net/can/af_can.c:572 [inline]
 can_rcv_filter+0x359/0x7f0 net/can/af_can.c:606
 can_receive+0x327/0x480 net/can/af_can.c:663
 can_rcv+0x144/0x260 net/can/af_can.c:687
 __netif_receive_skb_one_core net/core/dev.c:5625 [inline]
 __netif_receive_skb+0x2e0/0x650 net/core/dev.c:5739
 process_backlog+0x391/0x7d0 net/core/dev.c:6068
 __napi_poll+0xcb/0x490 net/core/dev.c:6722
 napi_poll net/core/dev.c:6791 [inline]
 net_rx_action+0x7bb/0x10a0 net/core/dev.c:6907
 __do_softirq+0x2c6/0x980 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:security_socket_create+0x6e/0xb0 security/security.c:4374
Code: 78 b8 97 fd 48 8b 1b 48 85 db 74 3b 48 8d 6b 18 48 89 e8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 ef e8 56 b8 97 fd 4c 8b 5d 00 <44> 89 ef 44 89 e6 44 89 fa 8b 4c 24 04 41 ff d3 66 90 85 c0 75 10
RSP: 0018:ffffc90000107948 EFLAGS: 00000246
RAX: 1ffffffff1bab1b8 RBX: ffffffff8dd58da8 RCX: ffff8880172abc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffffffff8dd58dc0 R08: ffffffff8948d77b R09: 0000000000000001
R10: dffffc0000000000 R11: ffffffff846c8900 R12: 0000000000000001
R13: 0000000000000002 R14: dffffc0000000000 R15: 0000000000000006
 __sock_create+0xc9/0x920 net/socket.c:1526
 rds_tcp_conn_path_connect+0x2bb/0xbc0
 rds_connect_worker+0x1dd/0x2a0 net/rds/threads.c:176
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3348
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3429
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
----------------
Code disassembly (best guess):
   0:	78 b8                	js     0xffffffba
   2:	97                   	xchg   %eax,%edi
   3:	fd                   	std
   4:	48 8b 1b             	mov    (%rbx),%rbx
   7:	48 85 db             	test   %rbx,%rbx
   a:	74 3b                	je     0x47
   c:	48 8d 6b 18          	lea    0x18(%rbx),%rbp
  10:	48 89 e8             	mov    %rbp,%rax
  13:	48 c1 e8 03          	shr    $0x3,%rax
  17:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
  1c:	74 08                	je     0x26
  1e:	48 89 ef             	mov    %rbp,%rdi
  21:	e8 56 b8 97 fd       	call   0xfd97b87c
  26:	4c 8b 5d 00          	mov    0x0(%rbp),%r11
* 2a:	44 89 ef             	mov    %r13d,%edi <-- trapping instruction
  2d:	44 89 e6             	mov    %r12d,%esi
  30:	44 89 fa             	mov    %r15d,%edx
  33:	8b 4c 24 04          	mov    0x4(%rsp),%ecx
  37:	41 ff d3             	call   *%r11
  3a:	66 90                	xchg   %ax,%ax
  3c:	85 c0                	test   %eax,%eax
  3e:	75 10                	jne    0x50


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

