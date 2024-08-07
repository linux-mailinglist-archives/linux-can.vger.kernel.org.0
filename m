Return-Path: <linux-can+bounces-1156-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D5949D8D
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 04:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92AED1F242C4
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 02:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6350618FDC0;
	Wed,  7 Aug 2024 02:00:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B024618FC9B
	for <linux-can@vger.kernel.org>; Wed,  7 Aug 2024 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722996004; cv=none; b=M2NEFX4ljK6XSBhzq3xRaDtH5XweTRGrOKx0gT2LcMd0lhMYy6CSZklYemfB4O4ihxEpPo4EFAF1Cb/1w0XASsUGTkPup1dsNXIjYFZIcSSa0fxsYfDN0Hkd78k+zSKMDw1Hx4THQ945at1mylfQQUtPfhGEbEIxKMG8wj52n34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722996004; c=relaxed/simple;
	bh=J7rRMouWrePqOervRgih/+EQJ5PJrooW7iamK8b9FGg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AM+MMIQi4wLmESDkzZO3x9e90WoMvg/T4HFxPTSfI8afLqNXK3iDluPoXgRjuQ+IitMO5qKV2HX7/i2LgZYlNiHAeE8Bl+xtJv/nr496Ofa+tooeQSvPmhDS0SovT1xikYUb+I3Pa/4Zpja90mPYbcC8gXODEmPmc3U6+CU/SgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f87635cc1so172378139f.0
        for <linux-can@vger.kernel.org>; Tue, 06 Aug 2024 19:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722996002; x=1723600802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrOZg764SdtsMGIvD+ue+9XnkvrN64rtR0LcLi4DmOE=;
        b=YeH70/XYzL+BKB8KWaUGxRB0MEdB2Flo9iGfHww1MLrtf47A9kzQKu72NNqU0v/uuY
         EY513mR4D5OmCZNyRyD+6LlBWMc/TdL+/ptuY88fYoKYlFHfwY9ulsEgiOND4PNgpBqv
         F+yy7GaHfrdleO+2NF62pbnsE3YN5zCVs8NeOKh8O4tD4pZCDKEs27x9JwOYybx5UIOL
         ayU6z5hSk8wrNgybqr0WvDMyg1YHI/U0BzIadHwg1tKkLY1tL1cLwhlDzOsWGLLa1XqG
         r53I5xwAmwWeIaqvEC0Jsl9GpWXJvZjSMJpbDx+HB9w2//muTn0cjWZ0ZTheZUetbP9V
         e8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUzigklGVsDbg7apVsG/P5x25O4X/ZIbcUGo2Nahsk9zNV2uM169LmFNZDW2qoAK6F1EpApq1fT85g5U/CDV4ius55e2BCU7hhX
X-Gm-Message-State: AOJu0YzOdYCdSxFoyeOM6BAaO25ubQJeRv8hpACxmR1CrVoFmc8/Yhno
	zNLBURNkTxyq3GZLajHsrDVV8CFIBSmBUHTLBR3BJnYm9NUPGbmtpqBTEMkfWUspTqy5D3cBMU8
	ePuBAw9dH6cz7Et0D1g8LRqw8eaAy96mSx07S6LE7jLlOGu+hfUgqq90=
X-Google-Smtp-Source: AGHT+IGR9AJoTC3hDzs/J5/ik0pqUmAST469llb7BOqf8/Xeywz4QPB5gPhwmInUTsorLAamKdLv5v37M99gXP0e+l7HSdcfoJKe
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8306:b0:4b7:ca39:5869 with SMTP id
 8926c6da1cb9f-4c8d5731b71mr600065173.6.1722996001886; Tue, 06 Aug 2024
 19:00:01 -0700 (PDT)
Date: Tue, 06 Aug 2024 19:00:01 -0700
In-Reply-To: <tencent_2878E872ED62CC507B1A6F702C096FD8960A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a46235061f0e4485@google.com>
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
From: syzbot <syzbot+ad601904231505ad6617@syzkaller.appspotmail.com>
To: davem@davemloft.net, eadavis@qq.com, edumazet@google.com, 
	kernel@pengutronix.de, kuba@kernel.org, leitao@debian.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, mkl@pengutronix.de, 
	netdev@vger.kernel.org, o.rempel@pengutronix.de, pabeni@redhat.com, 
	robin@protonic.nl, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: refcount bug in j1939_session_put

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 6069 at lib/refcount.c:25 refcount_warn_saturate+0x13a/0x1d0 lib/refcount.c:25
Modules linked in:
CPU: 0 UID: 0 PID: 6069 Comm: syz.0.15 Not tainted 6.10.0-syzkaller-12610-g743ff02152bc-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:refcount_warn_saturate+0x13a/0x1d0 lib/refcount.c:25
Code: a0 16 40 8c e8 87 97 a5 fc 90 0f 0b 90 90 eb b9 e8 3b 89 e3 fc c6 05 95 7d 31 0b 01 90 48 c7 c7 00 17 40 8c e8 67 97 a5 fc 90 <0f> 0b 90 90 eb 99 e8 1b 89 e3 fc c6 05 76 7d 31 0b 01 90 48 c7 c7
RSP: 0018:ffffc90000007698 EFLAGS: 00010246
RAX: f96573282d1dbd00 RBX: ffff88801d361864 RCX: ffff88802c26bc00
RDX: 0000000000000101 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffffff81559432 R09: fffffbfff1cb9f88
R10: dffffc0000000000 R11: fffffbfff1cb9f88 R12: ffff88802afb7468
R13: ffff88801d361864 R14: ffff888066d74000 R15: ffff88802afb7400
FS:  00007fa08b7526c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0010e6000 CR3: 000000006730e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __j1939_session_release net/can/j1939/transport.c:295 [inline]
 kref_put include/linux/kref.h:65 [inline]
 j1939_session_put+0x26f/0x4a0 net/can/j1939/transport.c:300
 j1939_tp_cmd_recv net/can/j1939/transport.c:2114 [inline]
 j1939_tp_recv+0x7fe/0x1050 net/can/j1939/transport.c:2162
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
RSP: 0018:ffffc900033cf8c0 EFLAGS: 00000206
RAX: f96573282d1dbd00 RBX: 1ffff92000679f1c RCX: ffffffff81701f3a
RDX: dffffc0000000000 RSI: ffffffff8bead5a0 RDI: 0000000000000001
RBP: ffffc900033cf950 R08: ffffffff9351e917 R09: 1ffffffff26a3d22
R10: dffffc0000000000 R11: fffffbfff26a3d23 R12: dffffc0000000000
R13: 1ffff92000679f18 R14: ffffc900033cf8e0 R15: 0000000000000246
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
RIP: 0033:0x7fa08a9773b9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa08b752048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fa08ab05f80 RCX: 00007fa08a9773b9
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00007fa08a9e48e6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fa08ab05f80 R15: 00007fff3eaa0cf8
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


Tested on:

commit:         743ff021 ethtool: Don't check for NULL info in prepare..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11568613980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1386c28d980000


