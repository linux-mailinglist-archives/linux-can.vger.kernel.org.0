Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1BE10EDC6
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2019 18:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfLBRFL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 2 Dec 2019 12:05:11 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:54149 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfLBRFL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 Dec 2019 12:05:11 -0500
Received: by mail-il1-f197.google.com with SMTP id d3so194618ilg.20
        for <linux-can@vger.kernel.org>; Mon, 02 Dec 2019 09:05:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2f8HtfQq4IK9cIhIvyj5C1mmc9kchy4GexxX8Jm5qow=;
        b=uLWv0/kxNI6wJFX3uH2QZ1+18wun/4m/EOUJB3/RWpiUf1zBSvuSCi4Jn9KL1bcR+c
         KsoMMOYj9ZMyTQ2h6bMH3FYGrngtiOfZCyTYZTlIUkQc41QeGSGm03UcQdAyuqPgUI49
         2btd75slKq8BUxABF43uvGBivqZFZjRDhveZ25iFH7awurVXnrTbBBX6KASbJTB7Hjah
         ZuXk17xhSui2+XxEJ5L83iBopaxnu5DN88gEXBZFYWvaE2+tjWUhcy/CW7Intr9rZY8m
         q9VWyS7YubHj3JjF2eoF3sIdmKbbneVYtSFTLqEwXC00AgNCvfpb+EfGQFaeiaH0+gxo
         PayQ==
X-Gm-Message-State: APjAAAVHmDpY39JghJSXn36rg23Ll66I9G8PrblnYTx9rjkSD2wnYaG1
        Kw0llGNu0ZBlI0smXL8vw9Cj2LPgnAS85i4QU5SXGsqx9nU8
X-Google-Smtp-Source: APXvYqwpG98Lsjm+MLH/KeR7s4+Wt1CjQooDZbumphbBU/JcL3Uj+ajYP3g92Tw5uzecd+/GVX82AqJUsyj9oQP5QACSA5YU+LgR
MIME-Version: 1.0
X-Received: by 2002:a6b:d912:: with SMTP id r18mr42792632ioc.306.1575306310599;
 Mon, 02 Dec 2019 09:05:10 -0800 (PST)
Date:   Mon, 02 Dec 2019 09:05:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e4f720598bb95f8@google.com>
Subject: KASAN: use-after-free Read in slcan_open
From:   syzbot <syzbot+b5ec6fd05ab552a78532@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, mkl@pengutronix.de,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wg@grandegger.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    32ef9553 Merge tag 'fsnotify_for_v5.5-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a48e9ce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
dashboard link: https://syzkaller.appspot.com/bug?extid=b5ec6fd05ab552a78532
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12943882e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10562f86e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b5ec6fd05ab552a78532@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in slc_sync drivers/net/can/slcan.c:504 [inline]
BUG: KASAN: use-after-free in slcan_open+0x8a1/0x9e0  
drivers/net/can/slcan.c:579
Read of size 8 at addr ffff88809a6e0b88 by task syz-executor961/9030

CPU: 1 PID: 9030 Comm: syz-executor961 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  slc_sync drivers/net/can/slcan.c:504 [inline]
  slcan_open+0x8a1/0x9e0 drivers/net/can/slcan.c:579
  tty_ldisc_open.isra.0+0xa3/0x110 drivers/tty/tty_ldisc.c:469
  tty_set_ldisc+0x30e/0x6b0 drivers/tty/tty_ldisc.c:596
  tiocsetd drivers/tty/tty_io.c:2334 [inline]
  tty_ioctl+0xe8d/0x14f0 drivers/tty/tty_io.c:2594
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4429e9
Code: e8 dc 02 03 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1b 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc7db87168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004429e9
RDX: 00000000200000c0 RSI: 0000000000005423 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000003031
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 00007ffc7db871dc R15: 0000000000000000

Allocated by task 9029:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:483
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:524
  __do_kmalloc_node mm/slab.c:3615 [inline]
  __kmalloc_node+0x4e/0x70 mm/slab.c:3622
  kmalloc_node include/linux/slab.h:599 [inline]
  kvmalloc_node+0xbd/0x100 mm/util.c:564
  kvmalloc include/linux/mm.h:670 [inline]
  kvzalloc include/linux/mm.h:678 [inline]
  alloc_netdev_mqs+0x98/0xde0 net/core/dev.c:9730
  slc_alloc drivers/net/can/slcan.c:533 [inline]
  slcan_open+0x32d/0x9e0 drivers/net/can/slcan.c:590
  tty_ldisc_open.isra.0+0xa3/0x110 drivers/tty/tty_ldisc.c:469
  tty_set_ldisc+0x30e/0x6b0 drivers/tty/tty_ldisc.c:596
  tiocsetd drivers/tty/tty_io.c:2334 [inline]
  tty_ioctl+0xe8d/0x14f0 drivers/tty/tty_io.c:2594
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9029:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:471
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3425 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3756
  kvfree+0x61/0x70 mm/util.c:593
  netdev_freemem net/core/dev.c:9684 [inline]
  free_netdev+0x3c0/0x470 net/core/dev.c:9839
  slcan_open+0x848/0x9e0 drivers/net/can/slcan.c:620
  tty_ldisc_open.isra.0+0xa3/0x110 drivers/tty/tty_ldisc.c:469
  tty_set_ldisc+0x30e/0x6b0 drivers/tty/tty_ldisc.c:596
  tiocsetd drivers/tty/tty_io.c:2334 [inline]
  tty_ioctl+0xe8d/0x14f0 drivers/tty/tty_io.c:2594
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88809a6e0000
  which belongs to the cache kmalloc-32k of size 32768
The buggy address is located 2952 bytes inside of
  32768-byte region [ffff88809a6e0000, ffff88809a6e8000)
The buggy address belongs to the page:
page:ffffea000269b800 refcount:1 mapcount:0 mapping:ffff8880aa402540  
index:0x0 compound_mapcount: 0
raw: 00fffe0000010200 ffffea000244d008 ffff8880aa401d48 ffff8880aa402540
raw: 0000000000000000 ffff88809a6e0000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809a6e0a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809a6e0b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88809a6e0b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                       ^
  ffff88809a6e0c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809a6e0c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
