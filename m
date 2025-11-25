Return-Path: <linux-can+bounces-5661-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2740C86DD4
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 20:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A5C34E073F
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 19:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE8B33A70E;
	Tue, 25 Nov 2025 19:50:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C9433AD8B
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100229; cv=none; b=JG3lCOLb5hr0ju8/sJqsqEsHoZVW20CRJNzuBhQm5cPcHY/G35I8OlDyBSISoYscUfoM3jb6HiNrrmppP0tX94flMuQPHWLiE0jf1+2oKEUPut3J0IbWBo0bEw6Pk60heWjDn7UnX0M3bif73+RQn4C12jFDciibUBNC0RsqqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100229; c=relaxed/simple;
	bh=kcHfv/w1thHUu+kM28yyVnV7qJuVu+8vXz5EmX5dU0c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qvYogXIHjhjXzDkLd3RhuGkid/d7Sb7qoq/nYY6A/KU8fIVBV2bAV4+iDBXvcpo0t57J43g0wG1eb2Gh5FqU0n++5Up1R72JcXNepmf4JLjuW7nS93VqM/5usBbLR61qOIOmlV4p6Ux36SDj39zX8+phYgx14TeTv0dP/O0SrqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-433312ee468so1673525ab.1
        for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 11:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764100227; x=1764705027;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTq1C08jxLq0mjK/fkl1LEJjL3jX06dpWDp2JZxDY9Y=;
        b=T5dVRm5revXl83xkOPNzoAN1DpbDV7o177pjK8ZqhWvc2vXNhGke8pboUAtAMqKlDU
         yfGIM206wo7OHXAB4DGeTp0VpYhXsgT8a8RsE8s1JBbgTVIJGfEo/HqpfWZGWWSy3lMb
         daEfalw2UQ3n/sjn5XMSNT2y0RruDyKtJJFRDilfo26Y4lBt8t1/88tgA/R0vgoNRh9y
         CC6z9wslt6d7n/L6ymQQdyodk0ZoqmIEaNwzEVvaeNYTp99uCW9wFrc0mdPs7yBIabkI
         +j/DaAp1ZyOgJ0oq6QHtrk+LBjpjmsypxrlbXgatw57hiCz6Xj53NrRqcsW0MFoy0vKf
         31QQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/wRmQxvRgMsMg1fZFE7jXaE0CJr1qCiYm55PaPgvNlLbvICplAvlUdflHCWNrORSF//H10vxhCCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzAb8tMMsuwSgCHLd4JtrX+mIZ/mU91VibhpikM1QRgZSX/J2s
	+XDeH/PQFp4SdDf6okr/c3WND2Oy8VfDeq1DGNr0MRBgkVtzaxQzvkJldM9VVwKGjCeCFUHbzOW
	2bl7FtK9EDcyV/Gyz1J0W0f50ysMGpY44bBYZWCkRMgVe2FFPD02nLE7OcNs=
X-Google-Smtp-Source: AGHT+IFCRAfw28e98qC/9ugvEMowkcuK8yggxpTve8KozzLys5D6kuQDwQvvWthTuc0dKuCHWiDon8FCqdVF3WHFHA8px5N7LapV
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178a:b0:434:96ea:ca19 with SMTP id
 e9e14a558f8ab-435b913657cmr136188375ab.17.1764100227216; Tue, 25 Nov 2025
 11:50:27 -0800 (PST)
Date: Tue, 25 Nov 2025 11:50:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69260883.a70a0220.d98e3.00b5.GAE@google.com>
Subject: [syzbot] [net?] [can?] KMSAN: uninit-value in em_canid_match
From: syzbot <syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, mkl@pengutronix.de, 
	netdev@vger.kernel.org, pabeni@redhat.com, socketcan@hartkopp.net, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ac3fd01e4c1e Linux 6.18-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1703e612580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61a9bf3cc5d17a01
dashboard link: https://syzkaller.appspot.com/bug?extid=5d8269a1e099279152bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12040e58580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117d797c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/227434a45737/disk-ac3fd01e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d8117003dbb5/vmlinux-ac3fd01e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a13125fb7a7d/bzImage-ac3fd01e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com

syzkaller0: entered promiscuous mode
syzkaller0: entered allmulticast mode
=====================================================
BUG: KMSAN: uninit-value in em_canid_match+0x2f0/0x360 net/sched/em_canid.c:104
 em_canid_match+0x2f0/0x360 net/sched/em_canid.c:104
 tcf_em_match net/sched/ematch.c:494 [inline]
 __tcf_em_tree_match+0x215/0xc70 net/sched/ematch.c:520
 tcf_em_tree_match include/net/pkt_cls.h:512 [inline]
 basic_classify+0x154/0x480 net/sched/cls_basic.c:50
 tc_classify include/net/tc_wrapper.h:197 [inline]
 __tcf_classify net/sched/cls_api.c:1764 [inline]
 tcf_classify+0x855/0x1cb0 net/sched/cls_api.c:1860
 multiq_classify net/sched/sch_multiq.c:39 [inline]
 multiq_enqueue+0x82/0x590 net/sched/sch_multiq.c:66
 dev_qdisc_enqueue net/core/dev.c:4118 [inline]
 __dev_xmit_skb net/core/dev.c:4214 [inline]
 __dev_queue_xmit+0x1d91/0x5e60 net/core/dev.c:4729
 dev_queue_xmit include/linux/netdevice.h:3365 [inline]
 packet_xmit+0x8f/0x710 net/packet/af_packet.c:275
 packet_snd net/packet/af_packet.c:3076 [inline]
 packet_sendmsg+0x9173/0xa2a0 net/packet/af_packet.c:3108
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x333/0x3d0 net/socket.c:742
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2630
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2719
 x64_sys_call+0x1dfd/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4985 [inline]
 slab_alloc_node mm/slub.c:5288 [inline]
 kmem_cache_alloc_node_noprof+0x989/0x16b0 mm/slub.c:5340
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1383 [inline]
 alloc_skb_with_frags+0xc5/0xa60 net/core/skbuff.c:6671
 sock_alloc_send_pskb+0xacc/0xc60 net/core/sock.c:2965
 packet_alloc_skb net/packet/af_packet.c:2926 [inline]
 packet_snd net/packet/af_packet.c:3019 [inline]
 packet_sendmsg+0x743d/0xa2a0 net/packet/af_packet.c:3108
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x333/0x3d0 net/socket.c:742
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2630
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2719
 x64_sys_call+0x1dfd/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 6067 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

