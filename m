Return-Path: <linux-can+bounces-1591-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0C298F401
	for <lists+linux-can@lfdr.de>; Thu,  3 Oct 2024 18:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF2A1C2208B
	for <lists+linux-can@lfdr.de>; Thu,  3 Oct 2024 16:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E781A705E;
	Thu,  3 Oct 2024 16:14:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906D41A7060
	for <linux-can@vger.kernel.org>; Thu,  3 Oct 2024 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972069; cv=none; b=Mos33g2ZfNDtFGhwvXYodU04oa1zAayBGszqx/w/yA049q78dEgPkUtl+z+PjyKUs3Ns/Kj2lzka7Sw+5//13eaKRN8p/q+KlaZGEDArZeQo/6YenH/Ca4moUU94AUAC4cHdCKy3EHBQtfWXsYGNH8vXCpjMQjzLfYwrl/72D1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972069; c=relaxed/simple;
	bh=efJMc1OXG/1UiXCLpHl8gh/4GJ8hjW9/b5EVvQn/8tQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LHZH+kELg7ZFuGze0tQcBcr0dui8GnWHaAADTgnFev7AbHLNaf+GJIGpiwBLM9ZzspF9DMQPhAnGah0DxcvRbQ2cO9REsUc6lEKfveE9x7VpCsoCmBgfI+8Ti+MBKfE7s0z8x1l2bLNRc1FChBHSulQHB+XkP1fb5jAilb0OBwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a34205e146so12358905ab.3
        for <linux-can@vger.kernel.org>; Thu, 03 Oct 2024 09:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727972067; x=1728576867;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bm4yCE0DmqPZQLJy4qYy4v3ru7M4Fy778wvdHAENEhA=;
        b=UaajPmlR2nrhRxqYxhsf7cgS1rjS2PH23fgdj6Gi9Yv61aMaIbjWiwXjVtWtqgFGHs
         gmEr9wAo9l6g6aNpE5Gkegsdy3aH2UbwfuG0M45ehsS/fYQcFYH6w0c5wb2Zh3bGPBUi
         eLYK9noH1alqBhNO1t7kzn+JpFPUXljUdrFWePwB9Rq1zRQomTtTsxnOVh12wkmMoy5t
         QAUvldk960tXdqjsxCAmdTtTI68rrJMkPh5nj7e/lLYxpoeiNqtu5m9cjENC3Ps3PnN/
         cctFBi+mUPvPzB/4gbqIvgBJJc7ylYc8YFKaFNXzxgc2EusZPIcAWnMsu56jBGsmdTAz
         qPOA==
X-Forwarded-Encrypted: i=1; AJvYcCXsBzKzk9Yf2U4gfxca8gI3doJ7SgzlpOP7oaK66b/9tvyGKZ1rNzAeUuqrvyolVSjOR6FrvuetLig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP6H7v8/UAVFTVMtzRsoAHemLOlKW9dWcxVSXBmu3r+4Ui1Q9s
	3VMZ8d+uZ0qtVoGrAOpWuNc9XUR5Ibf4Jqq7AgqsP10YsmFqKzfcO7DuaaEbllDINH0OhPRYdWl
	DEa8uffLtMQAGNtLTJr3MkbvUDRDjOv2jnL+GE8yM8pjvdooGgO+jJ40=
X-Google-Smtp-Source: AGHT+IGGaB5X/JkqzVQCJRWhiiZpClI6/nvtg+oCe+B5yDGbqCEDBI9f6CdaQYcOd7QANrQtDQyXgFhVD2IauY5Ypy6Wrngtx4F8
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca1:b0:3a0:a3cd:f239 with SMTP id
 e9e14a558f8ab-3a36591fa85mr82241185ab.8.1727972066770; Thu, 03 Oct 2024
 09:14:26 -0700 (PDT)
Date: Thu, 03 Oct 2024 09:14:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fec2e2.050a0220.9ec68.0046.GAE@google.com>
Subject: [syzbot] [can?] WARNING: refcount bug in sk_skb_reason_drop
From: syzbot <syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de, 
	kuba@kernel.org, leitao@debian.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mkl@pengutronix.de, netdev@vger.kernel.org, 
	o.rempel@pengutronix.de, pabeni@redhat.com, robin@protonic.nl, 
	socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11260ca9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d85e1e571a820894
dashboard link: https://syzkaller.appspot.com/bug?extid=d4e8dc385d9258220c31
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11903177980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b9a607980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4faaa939b3a4/disk-a430d95c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/83c722076440/vmlinux-a430d95c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/24c938d49c40/bzImage-a430d95c.xz

The issue was bisected to:

commit c9c0ee5f20c593faf289fa8850c3ed84031dd12a
Author: Breno Leitao <leitao@debian.org>
Date:   Mon Jul 29 10:47:40 2024 +0000

    net: skbuff: Skip early return in skb_unref when debugging

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e6f69f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17e6f69f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e6f69f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Fixes: c9c0ee5f20c5 ("net: skbuff: Skip early return in skb_unref when debugging")

vxcan1: j1939_tp_rxtimer: 0xffff8880326cb400: rx timeout, send abort
vxcan1: j1939_xtp_rx_abort_one: 0xffff8880326cb400: 0x00000: (3) A timeout occurred and this is the connection abort to close the session.
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 16 at lib/refcount.c:28 refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.11.0-syzkaller-02574-ga430d95c5efa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 58 80 04 fd 84 db 0f 85 66 ff ff ff e8 6b 7e 04 fd c6 05 59 3d 7f 0b 01 90 48 c7 c7 00 ba b0 8b e8 67 d1 c6 fc 90 <0f> 0b 90 90 e9 43 ff ff ff e8 48 7e 04 fd 0f b6 1d 34 3d 7f 0b 31
RSP: 0018:ffffc900001577c8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff814e2c79
RDX: ffff88801cadda00 RSI: ffffffff814e2c86 RDI: 0000000000000001
RBP: ffff88802e405224 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000000000 R14: ffff88802e405224 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055772d12ee40 CR3: 000000002853a000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:275 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 refcount_dec_and_test include/linux/refcount.h:325 [inline]
 skb_unref include/linux/skbuff.h:1232 [inline]
 __sk_skb_reason_drop net/core/skbuff.c:1213 [inline]
 sk_skb_reason_drop+0x183/0x1a0 net/core/skbuff.c:1241
 kfree_skb_reason include/linux/skbuff.h:1262 [inline]
 kfree_skb include/linux/skbuff.h:1271 [inline]
 j1939_session_destroy+0x163/0x460 net/can/j1939/transport.c:282
 __j1939_session_release net/can/j1939/transport.c:294 [inline]
 kref_put include/linux/kref.h:65 [inline]
 j1939_session_put net/can/j1939/transport.c:299 [inline]
 j1939_xtp_rx_abort_one+0x3f9/0x560 net/can/j1939/transport.c:1354
 j1939_xtp_rx_abort net/can/j1939/transport.c:1362 [inline]
 j1939_tp_cmd_recv net/can/j1939/transport.c:2128 [inline]
 j1939_tp_recv+0xcf8/0xf50 net/can/j1939/transport.c:2161
 j1939_can_recv+0x78f/0xa50 net/can/j1939/main.c:108
 deliver net/can/af_can.c:572 [inline]
 can_rcv_filter+0x2ab/0x900 net/can/af_can.c:606
 can_receive+0x320/0x5c0 net/can/af_can.c:663
 can_rcv+0x1e2/0x280 net/can/af_can.c:687
 __netif_receive_skb_one_core+0x1b4/0x1e0 net/core/dev.c:5662
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:5775
 process_backlog+0x443/0x15f0 net/core/dev.c:6107
 __napi_poll.constprop.0+0xba/0x550 net/core/dev.c:6771
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0xa92/0x1010 net/core/dev.c:6962
 handle_softirqs+0x219/0x8f0 kernel/softirq.c:554
 run_ksoftirqd kernel/softirq.c:928 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:920
 smpboot_thread_fn+0x664/0xa10 kernel/smpboot.c:164
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

