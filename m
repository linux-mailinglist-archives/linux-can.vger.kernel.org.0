Return-Path: <linux-can+bounces-52-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40307F87E8
	for <lists+linux-can@lfdr.de>; Sat, 25 Nov 2023 03:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6822BB2160E
	for <lists+linux-can@lfdr.de>; Sat, 25 Nov 2023 02:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43DB17C7;
	Sat, 25 Nov 2023 02:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198E919A6
	for <linux-can@vger.kernel.org>; Fri, 24 Nov 2023 18:45:22 -0800 (PST)
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-1cf8ea601c8so25314625ad.3
        for <linux-can@vger.kernel.org>; Fri, 24 Nov 2023 18:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700880321; x=1701485121;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0vhGKlbf8um049+SfnQY02FwXu7vtzZ58JJDrZbPu1A=;
        b=CPvcobvzN6rCQnksApcq4Sy+ftm7O9eKnQ+FIFVwJGoK7MipVutwBrreXCmbwjbgC+
         a7f+5iKkJMwc5ZxOlHZ+fAwHm6cQ+9qaNEiwvH0IKalsAZjI66WExDx6EoDnNtjKTyuS
         le6NACZAIA0Lt5qefqOs1+6Z2FTr9on7hn8b3CKD7p5PFhSOfW8K+mdqOZouwP86eMxC
         4IJl/sge4B06Oo28NvmXWODxqd6dilfPojj6it5O3VSBdcbhrXTSWsLQZH+wSLn3Dquc
         Pa/IFLCZ4AdTs012HC0MBc6dZEgkVp8RQjMe9yWmTLa30wzkZDIFjCg7NIf/1Xg7xMeF
         AkAg==
X-Gm-Message-State: AOJu0YyZhBGyNH+SnOvtZlp82ZT8N/2fvu/cdMlVKM59zLAo1KzZoBO9
	1rpe2frlyYQQWFvUBkqfs8IPaT8JpPkIgBm6RCoqLKjVodge
X-Google-Smtp-Source: AGHT+IFF+tdQ0IvQ09sdtpSQX+cOiRWTsmvFyfF9lEU7+E0eKL76FjEDaxdvZVR5smmM51SF+4RFC0QLWDTXavvMp8UMiv84+4bO
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:d2d2:b0:1cf:9a43:d323 with SMTP id
 n18-20020a170902d2d200b001cf9a43d323mr972682plc.11.1700880321624; Fri, 24 Nov
 2023 18:45:21 -0800 (PST)
Date: Fri, 24 Nov 2023 18:45:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060446d060af10f08@google.com>
Subject: [syzbot] [can?] memory leak in j1939_netdev_start
From: syzbot <syzbot+1d37bef05da87b99c5a6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, o.rempel@pengutronix.de, 
	pabeni@redhat.com, robin@protonic.nl, socketcan@hartkopp.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    98b1cc82c4af Linux 6.7-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1286e3d4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1b9d95ada516af
dashboard link: https://syzkaller.appspot.com/bug?extid=1d37bef05da87b99c5a6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c8f8cce80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b6d520f592c/disk-98b1cc82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2cb6183fd56/vmlinux-98b1cc82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/de520cfc8b93/bzImage-98b1cc82.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d37bef05da87b99c5a6@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811f324000 (size 8192):
  comm "syz-executor.7", pid 5245, jiffies 4294947603 (age 10.860s)
  hex dump (first 32 bytes):
    00 40 32 1f 81 88 ff ff 00 40 32 1f 81 88 ff ff  .@2......@2.....
    00 00 00 00 00 00 00 00 00 80 0f 1b 81 88 ff ff  ................
  backtrace:
    [<ffffffff816339bd>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff816339bd>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff816339bd>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff816339bd>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157e845>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff8453e829>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff8453e829>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff8453e829>] j1939_priv_create net/can/j1939/main.c:135 [inline]
    [<ffffffff8453e829>] j1939_netdev_start+0x159/0x6f0 net/can/j1939/main.c:272
    [<ffffffff8454046e>] j1939_sk_bind+0x21e/0x550 net/can/j1939/socket.c:485
    [<ffffffff83ec4dac>] __sys_bind+0x11c/0x130 net/socket.c:1845
    [<ffffffff83ec4ddc>] __do_sys_bind net/socket.c:1856 [inline]
    [<ffffffff83ec4ddc>] __se_sys_bind net/socket.c:1854 [inline]
    [<ffffffff83ec4ddc>] __x64_sys_bind+0x1c/0x20 net/socket.c:1854
    [<ffffffff84b6bd8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6bd8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88811f0bf300 (size 240):
  comm "softirq", pid 0, jiffies 4294947604 (age 10.850s)
  hex dump (first 32 bytes):
    68 74 bb 1d 81 88 ff ff 68 74 bb 1d 81 88 ff ff  ht......ht......
    00 80 0f 1b 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81631427>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631427>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631427>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631427>] kmem_cache_alloc_node+0x2c7/0x450 mm/slub.c:3523
    [<ffffffff83ed869f>] __alloc_skb+0x1ef/0x230 net/core/skbuff.c:641
    [<ffffffff845473ef>] alloc_skb include/linux/skbuff.h:1286 [inline]
    [<ffffffff845473ef>] j1939_session_fresh_new net/can/j1939/transport.c:1535 [inline]
    [<ffffffff845473ef>] j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1631 [inline]
    [<ffffffff845473ef>] j1939_xtp_rx_rts+0x49f/0xa50 net/can/j1939/transport.c:1735
    [<ffffffff84547ea5>] j1939_tp_cmd_recv net/can/j1939/transport.c:2057 [inline]
    [<ffffffff84547ea5>] j1939_tp_recv+0x1b5/0x7f0 net/can/j1939/transport.c:2144
    [<ffffffff8453e3f9>] j1939_can_recv+0x349/0x4e0 net/can/j1939/main.c:112
    [<ffffffff8452eea4>] deliver net/can/af_can.c:572 [inline]
    [<ffffffff8452eea4>] can_rcv_filter+0xd4/0x290 net/can/af_can.c:606
    [<ffffffff8452f560>] can_receive+0xf0/0x140 net/can/af_can.c:663
    [<ffffffff8452f6a0>] can_rcv+0xf0/0x130 net/can/af_can.c:687
    [<ffffffff83f10bf6>] __netif_receive_skb_one_core+0x66/0x90 net/core/dev.c:5529
    [<ffffffff83f10c6d>] __netif_receive_skb+0x1d/0x90 net/core/dev.c:5643
    [<ffffffff83f10fcc>] process_backlog+0xbc/0x190 net/core/dev.c:5971
    [<ffffffff83f1215e>] __napi_poll+0x3e/0x310 net/core/dev.c:6533
    [<ffffffff83f12b78>] napi_poll net/core/dev.c:6602 [inline]
    [<ffffffff83f12b78>] net_rx_action+0x3d8/0x510 net/core/dev.c:6735
    [<ffffffff84b8974d>] __do_softirq+0xbd/0x2b0 kernel/softirq.c:553

BUG: memory leak
unreferenced object 0xffff88811f340000 (size 131072):
  comm "softirq", pid 0, jiffies 4294947604 (age 10.850s)
  hex dump (first 32 bytes):
    0e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8157e703>] __kmalloc_large_node+0xe3/0x170 mm/slab_common.c:1157
    [<ffffffff8157ecbb>] __do_kmalloc_node mm/slab_common.c:995 [inline]
    [<ffffffff8157ecbb>] __kmalloc_node_track_caller+0xbb/0x150 mm/slab_common.c:1027
    [<ffffffff83ed49a6>] kmalloc_reserve+0x96/0x170 net/core/skbuff.c:582
    [<ffffffff83ed8585>] __alloc_skb+0xd5/0x230 net/core/skbuff.c:651
    [<ffffffff845473ef>] alloc_skb include/linux/skbuff.h:1286 [inline]
    [<ffffffff845473ef>] j1939_session_fresh_new net/can/j1939/transport.c:1535 [inline]
    [<ffffffff845473ef>] j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1631 [inline]
    [<ffffffff845473ef>] j1939_xtp_rx_rts+0x49f/0xa50 net/can/j1939/transport.c:1735
    [<ffffffff84547ea5>] j1939_tp_cmd_recv net/can/j1939/transport.c:2057 [inline]
    [<ffffffff84547ea5>] j1939_tp_recv+0x1b5/0x7f0 net/can/j1939/transport.c:2144
    [<ffffffff8453e3f9>] j1939_can_recv+0x349/0x4e0 net/can/j1939/main.c:112
    [<ffffffff8452eea4>] deliver net/can/af_can.c:572 [inline]
    [<ffffffff8452eea4>] can_rcv_filter+0xd4/0x290 net/can/af_can.c:606
    [<ffffffff8452f560>] can_receive+0xf0/0x140 net/can/af_can.c:663
    [<ffffffff8452f6a0>] can_rcv+0xf0/0x130 net/can/af_can.c:687
    [<ffffffff83f10bf6>] __netif_receive_skb_one_core+0x66/0x90 net/core/dev.c:5529
    [<ffffffff83f10c6d>] __netif_receive_skb+0x1d/0x90 net/core/dev.c:5643
    [<ffffffff83f10fcc>] process_backlog+0xbc/0x190 net/core/dev.c:5971
    [<ffffffff83f1215e>] __napi_poll+0x3e/0x310 net/core/dev.c:6533
    [<ffffffff83f12b78>] napi_poll net/core/dev.c:6602 [inline]
    [<ffffffff83f12b78>] net_rx_action+0x3d8/0x510 net/core/dev.c:6735
    [<ffffffff84b8974d>] __do_softirq+0xbd/0x2b0 kernel/softirq.c:553

BUG: memory leak
unreferenced object 0xffff88811dbb7400 (size 512):
  comm "softirq", pid 0, jiffies 4294947604 (age 10.850s)
  hex dump (first 32 bytes):
    00 40 32 1f 81 88 ff ff 28 50 32 1f 81 88 ff ff  .@2.....(P2.....
    28 50 32 1f 81 88 ff ff 18 74 bb 1d 81 88 ff ff  (P2......t......
  backtrace:
    [<ffffffff816339bd>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff816339bd>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff816339bd>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff816339bd>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157e845>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff84542463>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff84542463>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff84542463>] j1939_session_new+0x53/0x140 net/can/j1939/transport.c:1494
    [<ffffffff84547485>] j1939_session_fresh_new net/can/j1939/transport.c:1546 [inline]
    [<ffffffff84547485>] j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1631 [inline]
    [<ffffffff84547485>] j1939_xtp_rx_rts+0x535/0xa50 net/can/j1939/transport.c:1735
    [<ffffffff84547ea5>] j1939_tp_cmd_recv net/can/j1939/transport.c:2057 [inline]
    [<ffffffff84547ea5>] j1939_tp_recv+0x1b5/0x7f0 net/can/j1939/transport.c:2144
    [<ffffffff8453e3f9>] j1939_can_recv+0x349/0x4e0 net/can/j1939/main.c:112
    [<ffffffff8452eea4>] deliver net/can/af_can.c:572 [inline]
    [<ffffffff8452eea4>] can_rcv_filter+0xd4/0x290 net/can/af_can.c:606
    [<ffffffff8452f560>] can_receive+0xf0/0x140 net/can/af_can.c:663
    [<ffffffff8452f6a0>] can_rcv+0xf0/0x130 net/can/af_can.c:687
    [<ffffffff83f10bf6>] __netif_receive_skb_one_core+0x66/0x90 net/core/dev.c:5529
    [<ffffffff83f10c6d>] __netif_receive_skb+0x1d/0x90 net/core/dev.c:5643
    [<ffffffff83f10fcc>] process_backlog+0xbc/0x190 net/core/dev.c:5971
    [<ffffffff83f1215e>] __napi_poll+0x3e/0x310 net/core/dev.c:6533
    [<ffffffff83f12b78>] napi_poll net/core/dev.c:6602 [inline]
    [<ffffffff83f12b78>] net_rx_action+0x3d8/0x510 net/core/dev.c:6735
    [<ffffffff84b8974d>] __do_softirq+0xbd/0x2b0 kernel/softirq.c:553



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

