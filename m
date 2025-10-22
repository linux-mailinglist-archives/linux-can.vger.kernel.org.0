Return-Path: <linux-can+bounces-5265-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCE7BFB35B
	for <lists+linux-can@lfdr.de>; Wed, 22 Oct 2025 11:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB0B19C274A
	for <lists+linux-can@lfdr.de>; Wed, 22 Oct 2025 09:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52248270ED9;
	Wed, 22 Oct 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WuqrxqK8"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535082882BE;
	Wed, 22 Oct 2025 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126454; cv=pass; b=XGH4qbW2URbk54Det9kdaRkL8UX0Qs+ZW+h5DgUmVmFYlqwqQrEi153P2594aTaQNWD4pCn0Wl2wYuq72GyIbiORNK3JjFhvrTwqzkPLHG3DXKn2G6oZREC6RtM71rcfNDuUMLVE0j8GPw/0ivdIqS42IDwr6xcA3OZlggkRS8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126454; c=relaxed/simple;
	bh=wlVIiUOazj0KFTj9fibzeWQtGXNIoTzyw/XWtRTlEJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PYtrPMsqm+xG/Zzn1KxF4/j0wESLzWAQ4/YC4O9HwEzGjQDea5m9jILKLgyt5tc62/wEeYZgcsGXQsNIRbaUpfpjy4xn+qLIuFYRbizQlOuokY8je7d9o5ersxNt49qahfknPGR0VDgOP+FLc32Cg3vBRbNUwvbaKXPUSwbrTVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WuqrxqK8; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1761125725; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OYD4t7rK+6heDLpnibhYvv57qXpeOEOI1LuQ/tOoyY8O5+EQWmvM/FHMV3G6eIoryu
    nKwLQHA14GX8dSteyLQAn4VXBkR0WkXFjM+ZhuEOOCkT4QwWzYnRy3CPLknYTuPU7P5P
    kN1lj+D9jPfEMeUNPFbyfzBuwonLmUMWMENcnfuedh7bdiz8hraYuMEFHU++6JGZW8yZ
    hx8iIzX8w0NFjkyWdrc+YjG+tH4DgyeuRbVLFgTo1ZUSYkWoR6gNMMRtXBYEFgsPF+n4
    yOz/GBiAqu/e0Cf276nquU7LlvmMWKZAvhW3lKnp7a78CJqd00XJDxm111EnUQSdJ1m6
    qKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1761125725;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=H207SBDWUp/0UUU8rgDa8hUzz93u5bS5FMDY0juM9qA=;
    b=I9lrqPb/HrFRoSaqVvzl7lOF8wgLvavv3aJ65RwdxypGVf1m8diMNq/Mq7AUMKSIHs
    y6HseNKLlutzqWL7NZ1ChUEhfX9k+uA0IinB6HEz6B5rc3k1gpOlMvIDvwRiQTyKLeVr
    nc73Dr+EOUEXiWYjii8QgJlPgj6SKuL7GLwO3sL2bcVF+ZNJbmCT2btGLnpnYAzPKgUV
    KL4jROPq9ccix5M5U4z7lHf/YMqyNYDnuIdiMwXEdhodIIcs90zjpflqzZ7g70ch2g26
    9zFwz2r2/YFA51GnYiTn6shF1DKlebHAmUaBsqI8X40z22+CYHnMR0WV/W0Igusxi3oD
    p66A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1761125725;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=H207SBDWUp/0UUU8rgDa8hUzz93u5bS5FMDY0juM9qA=;
    b=WuqrxqK8K2l6odv5AJKM3F9bzYPKjDLrJMFrtiDTC3DXaWsvRbgNtPPnFFgJo9nsgB
    3nyNFUxeV+tP0R9m/jQ0Y0U0NSiDBHvKyHnkM1uWFlloWpk0CDQLQ24u/GNj8XjEfQa4
    VZ533e7iNOuizZRBfvRcSfXUhIGlYd/xXlr3+up02FfH59QMvGeZZ8rxdzHCa2Po5njA
    PGMY4cXIhwg5KO4ZYV1ji7rXYFXIXuq6MfwojbXZUa5pt4+aitDaBSx56P2X6RMO8gGZ
    sIAqAMXutiy56JXI+0CjhdVYGDIEc+Zx8R4flILVSdEOXiX2ttqvj8bolqCHMVC5xquw
    9B6Q==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id Kf23d019M9ZPxSf
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 22 Oct 2025 11:35:25 +0200 (CEST)
Message-ID: <37482dba-a1e3-479d-a446-1b8d92fdbb01@hartkopp.net>
Date: Wed, 22 Oct 2025 11:35:20 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [can?] general protection fault in can_rx_unregister
To: syzbot <syzbot+7a52d4cc48fa6eae3c86@syzkaller.appspotmail.com>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, mkl@pengutronix.de,
 syzkaller-bugs@googlegroups.com
References: <68f787b1.a70a0220.3bf6c6.0006.GAE@google.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <68f787b1.a70a0220.3bf6c6.0006.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marc,

On 10/21/25 15:16, syzbot wrote:

This console output

> console output: https://syzkaller.appspot.com/x/log.txt?x=1732b67c580000

tells a bit more:

[ 2218.749383][ T4715]  ? __pfx_isotp_rcv+0x10/0x10
[ 2218.754128][ T4715]  ? __pfx_can_rx_unregister+0x10/0x10
[ 2218.759567][ T4715]  ? dev_get_by_index+0x17c/0x380
[ 2218.764583][ T4715]  isotp_release+0x937/0xb90
[ 2218.769152][ T4715]  ? __pfx_isotp_release+0x10/0x10
[ 2218.774243][ T4715]  ? down_write+0x14d/0x200
[ 2218.778727][ T4715]  ? __pfx_down_write+0x10/0x10
[ 2218.783561][ T4715]  ? __pfx_locks_remove_file+0x10/0x10
[ 2218.789009][ T4715]  __sock_release+0xb3/0x270
[ 2218.793591][ T4715]  ? __pfx_sock_close+0x10/0x10
[ 2218.798428][ T4715]  sock_close+0x1c/0x30

is it possible that there is still a CAN frame in flight for isotp_rcv() 
while we are removing the registered filter in can_rx_ungegister()?

The receiver removal in the reported can_rx_unregister() line 537

https://elixir.bootlin.com/linux/v6.18-rc2/source/net/can/af_can.c#L537

is under spin_lock_bh() protection.

Not sure how the hlist_for_each_entry_rcu() statement could ever create 
a null-ptr-deref as we have this entire list manipulation under 
spin_lock_bh(&net->can.rcvlists_lock) ?!?

Do you have any idea?

Best regards,
Oliver


> kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
> dashboard link: https://syzkaller.appspot.com/bug?extid=7a52d4cc48fa6eae3c86
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1c3d2e04d272/disk-98ac9cc4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/eccd74106a6c/vmlinux-98ac9cc4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f6ac0e43209c/bzImage-98ac9cc4.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7a52d4cc48fa6eae3c86@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> CPU: 0 UID: 0 PID: 4715 Comm: syz.0.9421 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
> RIP: 0010:can_rx_unregister+0x250/0x730 net/can/af_can.c:537
> Code: 54 24 20 48 8d 84 24 b8 00 00 00 48 8d 74 24 78 48 8d 78 b0 e8 11 dc ff ff 48 ba 00 00 00 00 00 fc ff df 48 89 c1 48 c1 e9 03 <80> 3c 11 00 0f 85 7a 04 00 00 48 8b 18 44 8b 64 24 68 44 8b 74 24
> RSP: 0018:ffffc9000584fba8 EFLAGS: 00010206
> RAX: 0000000000000030 RBX: 0000000000000000 RCX: 0000000000000006
> RDX: dffffc0000000000 RSI: ffffffff8a56c94b RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000000005 R09: 00000000c00007ff
> R10: 00000000c00007ff R11: 0000000000000001 R12: ffff88808f3a8568
> R13: ffff88807c774000 R14: 0000000000000002 R15: 1ffff92000b09f7c
> FS:  000055558d910500(0000) GS:ffff8881249d6000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b327dfff8 CR3: 000000005b42d000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   isotp_release+0x937/0xb90 net/can/isotp.c:1213
>   __sock_release+0xb3/0x270 net/socket.c:662
>   sock_close+0x1c/0x30 net/socket.c:1455
>   __fput+0x402/0xb70 fs/file_table.c:468
>   task_work_run+0x150/0x240 kernel/task_work.c:227
>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>   exit_to_user_mode_loop+0xec/0x130 kernel/entry/common.c:43
>   exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
>   syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>   syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>   do_syscall_64+0x426/0xfa0 arch/x86/entry/syscall_64.c:100
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc323b8efc9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdf923ea98 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
> RAX: 0000000000000000 RBX: 00007fc323de7da0 RCX: 00007fc323b8efc9
> RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
> RBP: 00007fc323de7da0 R08: 00000000000427cc R09: 0000000ff923ed8f
> R10: 00007fc323de7cb0 R11: 0000000000000246 R12: 000000000021db0a
> R13: 00007fc323de6270 R14: ffffffffffffffff R15: 00007ffdf923ebb0
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:can_rx_unregister+0x250/0x730 net/can/af_can.c:537
> Code: 54 24 20 48 8d 84 24 b8 00 00 00 48 8d 74 24 78 48 8d 78 b0 e8 11 dc ff ff 48 ba 00 00 00 00 00 fc ff df 48 89 c1 48 c1 e9 03 <80> 3c 11 00 0f 85 7a 04 00 00 48 8b 18 44 8b 64 24 68 44 8b 74 24
> RSP: 0018:ffffc9000584fba8 EFLAGS: 00010206
> RAX: 0000000000000030 RBX: 0000000000000000 RCX: 0000000000000006
> RDX: dffffc0000000000 RSI: ffffffff8a56c94b RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000000005 R09: 00000000c00007ff
> R10: 00000000c00007ff R11: 0000000000000001 R12: ffff88808f3a8568
> R13: ffff88807c774000 R14: 0000000000000002 R15: 1ffff92000b09f7c
> FS:  000055558d910500(0000) GS:ffff8881249d6000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b327dfff8 CR3: 000000005b42d000 CR4: 00000000003526f0
> ----------------
> Code disassembly (best guess):
>     0:	54                   	push   %rsp
>     1:	24 20                	and    $0x20,%al
>     3:	48 8d 84 24 b8 00 00 	lea    0xb8(%rsp),%rax
>     a:	00
>     b:	48 8d 74 24 78       	lea    0x78(%rsp),%rsi
>    10:	48 8d 78 b0          	lea    -0x50(%rax),%rdi
>    14:	e8 11 dc ff ff       	call   0xffffdc2a
>    19:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
>    20:	fc ff df
>    23:	48 89 c1             	mov    %rax,%rcx
>    26:	48 c1 e9 03          	shr    $0x3,%rcx
> * 2a:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1) <-- trapping instruction
>    2e:	0f 85 7a 04 00 00    	jne    0x4ae
>    34:	48 8b 18             	mov    (%rax),%rbx
>    37:	44 8b 64 24 68       	mov    0x68(%rsp),%r12d
>    3c:	44                   	rex.R
>    3d:	8b                   	.byte 0x8b
>    3e:	74 24                	je     0x64
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
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


