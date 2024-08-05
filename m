Return-Path: <linux-can+bounces-1125-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A0C9484DB
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 23:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52C32812A7
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 21:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A83D170A28;
	Mon,  5 Aug 2024 21:29:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A089A170A2D
	for <linux-can@vger.kernel.org>; Mon,  5 Aug 2024 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893379; cv=none; b=VUR1i+MBEe2O4LNUwF1mweHhT9TxOb6YNJyh2K5UpuiPY0xnp1XMG2OcLlGsLsNYAgRcAX5wgVGm5wdxk2LFT99kXSDKpaCDCkDpjGzWO9QPcMCok6mCWtSD6k2ZDH/S2RTBxbBmR+Y/asY3Ll+2HQrxx0rbjQw7mDkgf8a7gXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893379; c=relaxed/simple;
	bh=R5FH0585GLONubfqzvRxY1SYFTTpoc2SBHN3HVIAlk8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gN5VOnsqM0jyMX/NuxJQu7tUApvLKLaKomXeZQffwSKIiJdT1P1Nn40KZ511+pzpIP+tuh7ffvIkmQoQ/PzvkEEiIQQBoudGVJSZzbw78BcwQW5b+wDGNZBE10EoHKR4FyEvuikayBpYDq5fAGq3eMktNfMeg9O1LIXKkEpIf3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b3e750e48so26036885ab.2
        for <linux-can@vger.kernel.org>; Mon, 05 Aug 2024 14:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722893377; x=1723498177;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yPMsp4iAjFXmhGlUB5aK2jt2H3yu8iP9jPB6KmKxsZw=;
        b=cjIMMrdyeyuGhLx8f/SGP/cw4iVDrBRJNiHMoygQ6p8qj70gVgAfSekoCYfvQN3Dws
         TBh5hfAyexw8wwknTSYnklas0JM73zGLI4HkjkDgyvhLXsgg/IJj/XQbxCAgybCa13gc
         iVPLcE5nhTx0f0FsefD2Xsr+7by1fCl3dEjFsHnQZw+JHwNAZbvlwEgCIX/x1vUtf4hR
         U9RQOZnxGqQ7HMvLfILYmeRn7d9ROY7cscErJDfZnpMTxdRjO8NSY0LIQqX33jI/7uCC
         0rsp6fClTA9z8w+wGidmAPrasJn/g/AGC70IVk6oW5l24c2tGFHl1P7CFoieKPC/MG3F
         Q/0A==
X-Forwarded-Encrypted: i=1; AJvYcCX/F99XjXI3VC4r7VBrQEIF4yHIg3His660EXTfXDbOKXNX/lmP1JsuR+gK/637dABeDM7TcgAo08XMJBjNcSsrih7GeduticlR
X-Gm-Message-State: AOJu0YxPvj2G9MIdIHQFi/kXykpJceBPIQb9DYUM/b1uWIhdnNfqMTtP
	H2OAyJ9nXqY6Ea4UWozbF7GT1zQtbOrULilA1gPuTyf3VfFmOBbSFExy1xRsQsSqOvqsDBRej7b
	SKEUCI1nV6QH9D6JpqlEnqYIUWfYLkslYxperpw2rSWlApa9XpXpyIpg=
X-Google-Smtp-Source: AGHT+IEEkC62LVfM7geGN1HBRDfv7b7BTxF/9GGbTyQ5sZ3tWhTTDD34KkP9IY+WDU+JW1aYpH0hi7XTU0Q68xFfhT1oMb8S5QXL
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d03:b0:382:56bd:dfbc with SMTP id
 e9e14a558f8ab-39b1fb83a10mr7747185ab.2.1722893376792; Mon, 05 Aug 2024
 14:29:36 -0700 (PDT)
Date: Mon, 05 Aug 2024 14:29:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5bde0061ef65fc8@google.com>
Subject: [syzbot] [can?] WARNING: refcount bug in j1939_xtp_rx_cts
From: syzbot <syzbot+5a1281566cc25c9881e0@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, o.rempel@pengutronix.de, 
	pabeni@redhat.com, robin@protonic.nl, socketcan@hartkopp.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    743ff02152bc ethtool: Don't check for NULL info in prepare..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1058b26d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=5a1281566cc25c9881e0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15041155980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162bd19d980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/69cb8d5cd046/disk-743ff021.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8f52c95a23c5/vmlinux-743ff021.xz
kernel image: https://storage.googleapis.com/syzbot-assets/93f2f40e650b/bzImage-743ff021.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a1281566cc25c9881e0@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 8 at lib/refcount.c:28 refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
Modules linked in:
CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.10.0-syzkaller-12610-g743ff02152bc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
Code: 00 17 40 8c e8 67 97 a5 fc 90 0f 0b 90 90 eb 99 e8 1b 89 e3 fc c6 05 76 7d 31 0b 01 90 48 c7 c7 60 17 40 8c e8 47 97 a5 fc 90 <0f> 0b 90 90 e9 76 ff ff ff e8 f8 88 e3 fc c6 05 50 7d 31 0b 01 90
RSP: 0018:ffffc900000076e0 EFLAGS: 00010246
RAX: b72359b2da0c4a00 RBX: ffff8880213d1864 RCX: ffff8880176cda00
RDX: 0000000080000102 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffff81559432 R09: 1ffff1101724519a
R10: dffffc0000000000 R11: ffffed101724519b R12: ffff88802b3dac00
R13: ffff8880213d1864 R14: ffff88802b3dac00 R15: ffff888077daa118
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005626f04f7000 CR3: 000000007c7d2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 kfree_skb_reason include/linux/skbuff.h:1260 [inline]
 kfree_skb include/linux/skbuff.h:1269 [inline]
 j1939_session_skb_drop_old net/can/j1939/transport.c:347 [inline]
 j1939_xtp_rx_cts_one net/can/j1939/transport.c:1445 [inline]
 j1939_xtp_rx_cts+0x54f/0xc70 net/can/j1939/transport.c:1484
 j1939_tp_cmd_recv net/can/j1939/transport.c:2089 [inline]
 j1939_tp_recv+0x8ae/0x1050 net/can/j1939/transport.c:2161
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
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
 nsim_dev_trap_report_work+0x75d/0xaa0 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

