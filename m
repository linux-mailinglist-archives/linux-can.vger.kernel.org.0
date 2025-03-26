Return-Path: <linux-can+bounces-3234-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912E4A72051
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 22:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E5F3BB02E
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 21:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C12A253337;
	Wed, 26 Mar 2025 21:00:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BEB49659
	for <linux-can@vger.kernel.org>; Wed, 26 Mar 2025 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022835; cv=none; b=ZXm6D8auDKcd8twir1Zy9bxyn5WTx6fmCY5k6vSHTS4GrzQ9QlsXjRujoIPgOUuGzhUSR3InwLwtoqUuPfxS5RP+JFPgx1HEuzHGYHobckC79uPMU8bWxkqWTcazrDPnXMTZZ+ulkoUNbwWvK0nOFfwDrIlsQyuW9L04wUV3jmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022835; c=relaxed/simple;
	bh=E0IkEfVisWGoQ1WZ8+CYWOL64hx1UwRHul6HFNIHgx4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SrwuumgPbHIwfn7rXdqIDsIOBVV2d6iRj/Lrf8vD322h3hy3qiXOFvWnaBxm+yFeYr7JcrEwj6i7qtyaHKRqczwr5vyKNDRc0yyppKi9Ap9tYLgtphEKX5Xdx+/qSSpv2MovbI9QuRbkYFGegCtREIKgaI2TaND8geHs/ch6odg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d4578fbaf4so5218435ab.0
        for <linux-can@vger.kernel.org>; Wed, 26 Mar 2025 14:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743022833; x=1743627633;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BLLzLUb7qILRPjQxfLkRYJ1D15qk9GUCshDqBYTc6eA=;
        b=v9xEV7+/lGMXwibV14J+B0gfSL2paRDdW4u/TDULEcQv+RS+h0WaPP2dyKXD34tSyp
         zSTA4f00nph074S9M0p+uUqjQ40i3qTv5AGgQAhTJKuVmF6Xr1w6hL9K8TKEiaseeWdc
         L3XpQg7h/rcYJSR4i681yPwbMLCeittG7u6QvkQp1VhIt7JijgcZa9o43bZ51duQJ6eF
         2224EXWfz/w/VCM3cdiTCvgC22yglOHpV5FkI+Pyv8IpxgJ6m5H4qcLA/YgqiENEbG9Z
         SCXcXSJsOtKNduYg9PmKrSsSGj14C8177Ix/ZO4rNs5I/ZVLz7zAje7MvhskZC2OYVmH
         tq/w==
X-Gm-Message-State: AOJu0Ywk6iYb//1UUo6wkIVBTmWoskFJcVt+4MSYs+fdja3PwUMAymBq
	7u3mvR1x+09G6O/5tOhWjvqCp17D3D7Q9L4xa+OTqcvZQZ5m8NxwBXnNzr77VKXiO1zyH1q3bcA
	QJgO2M2/a1mBx8cgQbF93cSV3K5bgGHX84+PzvoBy7lV6uXcuTMxMTIEZLA==
X-Google-Smtp-Source: AGHT+IGPJCFoOqOahWTOVIcJIlDOGOnWZDlwgusHMoNCxl2eewK4l+sSpT5ryYGA8mn3JKLc1dI+ZPRfJge87XtTNZIWjYUBWuya
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144a:b0:3d1:7835:1031 with SMTP id
 e9e14a558f8ab-3d5ccdd1b3bmr13954815ab.7.1743022832700; Wed, 26 Mar 2025
 14:00:32 -0700 (PDT)
Date: Wed, 26 Mar 2025 14:00:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e46af0.050a0220.2f068f.000e.GAE@google.com>
Subject: [syzbot] [can?] [usb?] KASAN: slab-out-of-bounds Read in ucan_probe
From: syzbot <syzbot+79340d79a8ed013a2313@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, mailhol.vincent@wanadoo.fr, mkl@pengutronix.de, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    245aece3750d MAINTAINERS: Add myself as a riscv reviewer
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=1241643f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef948fab17fe83a5
dashboard link: https://syzkaller.appspot.com/bug?extid=79340d79a8ed013a2313
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10de2804580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14bd4198580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-245aece3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1570230830d5/vmlinux-245aece3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a3c2191c4291/Image-245aece3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79340d79a8ed013a2313@syzkaller.appspotmail.com

usb 1-1: ucan: probing device on interface #0
==================================================================
BUG: KASAN: slab-out-of-bounds in sized_strscpy+0x2a2/0x2cc lib/string.c:182
Read of size 1 at addr ffffaf801ba334c0 by task kworker/0:1/9

CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.14.0-rc1-syzkaller-g245aece3750d #0
Hardware name: riscv-virtio,qemu (DT)
Workqueue: usb_hub_wq hub_event
Call Trace:
[<ffffffff80074518>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:132
[<ffffffff80003206>] show_stack+0x30/0x3c arch/riscv/kernel/stacktrace.c:138
[<ffffffff8005fa4c>] __dump_stack lib/dump_stack.c:94 [inline]
[<ffffffff8005fa4c>] dump_stack_lvl+0x12e/0x1a6 lib/dump_stack.c:120
[<ffffffff8000eac8>] print_address_description mm/kasan/report.c:378 [inline]
[<ffffffff8000eac8>] print_report+0x28e/0x5aa mm/kasan/report.c:489
[<ffffffff80a6e636>] kasan_report+0xf0/0x214 mm/kasan/report.c:602
[<ffffffff80a70424>] __asan_report_load1_noabort+0x12/0x1a mm/kasan/report_generic.c:378
[<ffffffff8621a08e>] sized_strscpy+0x2a2/0x2cc lib/string.c:182
[<ffffffff83308bf2>] ucan_probe+0x1682/0x178c drivers/net/can/usb/ucan.c:1535
[<ffffffff8368edaa>] usb_probe_interface+0x2d6/0x8c4 drivers/usb/core/driver.c:396
[<ffffffff82a4dd52>] call_driver_probe drivers/base/dd.c:579 [inline]
[<ffffffff82a4dd52>] really_probe+0x232/0x9be drivers/base/dd.c:658
[<ffffffff82a4e6b2>] __driver_probe_device+0x1d4/0x3f2 drivers/base/dd.c:800
[<ffffffff82a4eb18>] driver_probe_device+0x60/0x1ce drivers/base/dd.c:830
[<ffffffff82a4ee68>] __device_attach_driver+0x1e2/0x2fc drivers/base/dd.c:958
[<ffffffff82a48572>] bus_for_each_drv+0x142/0x1da drivers/base/bus.c:462
[<ffffffff82a4f8a2>] __device_attach+0x1c4/0x462 drivers/base/dd.c:1030
[<ffffffff82a4fe48>] device_initial_probe+0x1c/0x26 drivers/base/dd.c:1079
[<ffffffff82a4afdc>] bus_probe_device+0x15c/0x192 drivers/base/bus.c:537
[<ffffffff82a444b8>] device_add+0x10da/0x181c drivers/base/core.c:3665
[<ffffffff836885c8>] usb_set_configuration+0xf08/0x19dc drivers/usb/core/message.c:2210
[<ffffffff836b32ea>] usb_generic_driver_probe+0xae/0x128 drivers/usb/core/generic.c:250
[<ffffffff83689f0a>] usb_probe_device+0xd6/0x360 drivers/usb/core/driver.c:291
[<ffffffff82a4dd52>] call_driver_probe drivers/base/dd.c:579 [inline]
[<ffffffff82a4dd52>] really_probe+0x232/0x9be drivers/base/dd.c:658
[<ffffffff82a4e6b2>] __driver_probe_device+0x1d4/0x3f2 drivers/base/dd.c:800
[<ffffffff82a4eb18>] driver_probe_device+0x60/0x1ce drivers/base/dd.c:830
[<ffffffff82a4ee68>] __device_attach_driver+0x1e2/0x2fc drivers/base/dd.c:958
[<ffffffff82a48572>] bus_for_each_drv+0x142/0x1da drivers/base/bus.c:462
[<ffffffff82a4f8a2>] __device_attach+0x1c4/0x462 drivers/base/dd.c:1030
[<ffffffff82a4fe48>] device_initial_probe+0x1c/0x26 drivers/base/dd.c:1079
[<ffffffff82a4afdc>] bus_probe_device+0x15c/0x192 drivers/base/bus.c:537
[<ffffffff82a444b8>] device_add+0x10da/0x181c drivers/base/core.c:3665
[<ffffffff8366429e>] usb_new_device+0x964/0x1778 drivers/usb/core/hub.c:2652
[<ffffffff8366a616>] hub_port_connect drivers/usb/core/hub.c:5523 [inline]
[<ffffffff8366a616>] hub_port_connect_change drivers/usb/core/hub.c:5663 [inline]
[<ffffffff8366a616>] port_event drivers/usb/core/hub.c:5823 [inline]
[<ffffffff8366a616>] hub_event+0x2716/0x48de drivers/usb/core/hub.c:5905
[<ffffffff801b3668>] process_one_work+0x96a/0x1f3a kernel/workqueue.c:3236
[<ffffffff801b667a>] process_scheduled_works kernel/workqueue.c:3317 [inline]
[<ffffffff801b667a>] worker_thread+0x5be/0xdc6 kernel/workqueue.c:3398
[<ffffffff801d3b2e>] kthread+0x37e/0x7b6 kernel/kthread.c:464
[<ffffffff8626888e>] ret_from_fork+0xe/0x18 arch/riscv/kernel/entry.S:327

Allocated by task 9:
 stack_trace_save+0xa0/0xd2 kernel/stacktrace.c:122
 kasan_save_stack+0x3e/0x6a mm/kasan/common.c:47
 kasan_save_track+0x16/0x28 mm/kasan/common.c:68
 kasan_save_alloc_info+0x30/0x3e mm/kasan/generic.c:562
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xa0/0xa6 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4294 [inline]
 __kmalloc_node_track_caller_noprof+0x258/0x5ec mm/slub.c:4313
 alloc_dr drivers/base/devres.c:119 [inline]
 devm_kmalloc+0x9a/0x1fe drivers/base/devres.c:843
 devm_kzalloc include/linux/device.h:328 [inline]
 ucan_probe+0x57e/0x178c drivers/net/can/usb/ucan.c:1401
 usb_probe_interface+0x2d6/0x8c4 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x232/0x9be drivers/base/dd.c:658
 __driver_probe_device+0x1d4/0x3f2 drivers/base/dd.c:800
 driver_probe_device+0x60/0x1ce drivers/base/dd.c:830
 __device_attach_driver+0x1e2/0x2fc drivers/base/dd.c:958
 bus_for_each_drv+0x142/0x1da drivers/base/bus.c:462
 __device_attach+0x1c4/0x462 drivers/base/dd.c:1030
 device_initial_probe+0x1c/0x26 drivers/base/dd.c:1079
 bus_probe_device+0x15c/0x192 drivers/base/bus.c:537
 device_add+0x10da/0x181c drivers/base/core.c:3665
 usb_set_configuration+0xf08/0x19dc drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xae/0x128 drivers/usb/core/generic.c:250
 usb_probe_device+0xd6/0x360 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x232/0x9be drivers/base/dd.c:658
 __driver_probe_device+0x1d4/0x3f2 drivers/base/dd.c:800
 driver_probe_device+0x60/0x1ce drivers/base/dd.c:830
 __device_attach_driver+0x1e2/0x2fc drivers/base/dd.c:958
 bus_for_each_drv+0x142/0x1da drivers/base/bus.c:462
 __device_attach+0x1c4/0x462 drivers/base/dd.c:1030
 device_initial_probe+0x1c/0x26 drivers/base/dd.c:1079
 bus_probe_device+0x15c/0x192 drivers/base/bus.c:537
 device_add+0x10da/0x181c drivers/base/core.c:3665
 usb_new_device+0x964/0x1778 drivers/usb/core/hub.c:2652
 hub_port_connect drivers/usb/core/hub.c:5523 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5663 [inline]
 port_event drivers/usb/core/hub.c:5823 [inline]
 hub_event+0x2716/0x48de drivers/usb/core/hub.c:5905
 process_one_work+0x96a/0x1f3a kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x5be/0xdc6 kernel/workqueue.c:3398
 kthread+0x37e/0x7b6 kernel/kthread.c:464
 ret_from_fork+0xe/0x18 arch/riscv/kernel/entry.S:327

The buggy address belongs to the object at ffffaf801ba33400
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes to the right of
 allocated 192-byte region [ffffaf801ba33400, ffffaf801ba334c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9ba33
flags: 0xffe000000000000(node=0|zone=0|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 0ffe000000000000 ffffaf80114013c0 ffff8d80006dafc0 dead000000000002
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 49582585400, free_ts 0
 __set_page_owner+0xa2/0x710 mm/page_owner.c:320
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xea/0x1e2 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0xf78/0x2bd6 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x1e8/0x20fc mm/page_alloc.c:4739
 alloc_pages_mpol+0x1fa/0x5b8 mm/mempolicy.c:2270
 alloc_frozen_pages_noprof+0x174/0x2f0 mm/mempolicy.c:2341
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2587 [inline]
 new_slab+0x26a/0x340 mm/slub.c:2640
 ___slab_alloc+0xaf4/0x1290 mm/slub.c:3826
 __slab_alloc.constprop.0+0x60/0xb0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 __kmalloc_cache_noprof+0xd4/0x3f8 mm/slub.c:4320
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 kset_create lib/kobject.c:965 [inline]
 kset_create_and_add+0x56/0x182 lib/kobject.c:1008
 bus_register+0x29c/0x63c drivers/base/bus.c:894
 fw_core_init+0x74/0x24a drivers/firewire/core-transaction.c:1334
 do_one_initcall+0x1a2/0xae4 init/main.c:1257
 do_initcall_level init/main.c:1319 [inline]
 do_initcalls init/main.c:1335 [inline]
 do_basic_setup init/main.c:1354 [inline]
 kernel_init_freeable+0x6ec/0x792 init/main.c:1568
 kernel_init+0x28/0x24c init/main.c:1457
page_owner free stack trace missing

Memory state around the buggy address:
 ffffaf801ba33380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffffaf801ba33400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffaf801ba33480: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                           ^
 ffffaf801ba33500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffaf801ba33580: 00 00 00 00 00 00 00 06 fc fc fc fc fc fc fc fc
==================================================================


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

