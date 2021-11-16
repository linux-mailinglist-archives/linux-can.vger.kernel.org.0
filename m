Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E79B453749
	for <lists+linux-can@lfdr.de>; Tue, 16 Nov 2021 17:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhKPQ0W (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Nov 2021 11:26:22 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:52764 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhKPQ0R (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Nov 2021 11:26:17 -0500
Received: by mail-io1-f72.google.com with SMTP id k12-20020a0566022a4c00b005ebe737d989so7381871iov.19
        for <linux-can@vger.kernel.org>; Tue, 16 Nov 2021 08:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=yM1rbashInAzbYPtginvguLy4OxPR9nStSeyYPDLa2E=;
        b=gSHz71O6dwKDtnhNRrpwa8vnRYXciyQMcsvLUlnaV47aB/7y75UDk9rP1e3XSwCA7z
         IKwD8CR0jOlsylCQpFggFOypPeIJ07ZSqVM1yErdX1U4tvjuqVgGmEJcf499CMmLR6F/
         WgPrLc4FHtcIgBuXP+6CwAhHntOgFMNti7mx0KaZQotHQSnTb95rLq91t2di7GbYsQ7R
         SLK5fVqpnq2T8fb6OyDLdEMNe2cl2p7KQBHzKu4xscUajElHBQvQjKbeZ/fhIIEWbkEo
         2cZMeneHmfijVVgYWbhZv/7wTeEnRKkIHvIL1SFDC+6QkjZ4/F8SKwNzb2atdjYYWFBP
         ndrA==
X-Gm-Message-State: AOAM531aT3bCeivRRFG9hIzkTUqHCPvTVwdpXs+wCBTox6F4zUJgyIax
        ep2nKheLSUBB6M5FHIHjfTeFVgT1Ouh2PnfKNyGgi5zi1vwP
X-Google-Smtp-Source: ABdhPJwOt82N2RqFj9+f2J57Grw3LGDeTyX4wBrDg5wchcdKf9tHOGRYfIl098s/WfTdeKni8G5/WWw0MfnxdV+wTZXX4zw6brzF
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1134:: with SMTP id f20mr6680669jar.6.1637079800594;
 Tue, 16 Nov 2021 08:23:20 -0800 (PST)
Date:   Tue, 16 Nov 2021 08:23:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbc35e05d0ea57a3@google.com>
Subject: [syzbot] WARNING in j1939_tp_rxtimer
From:   syzbot <syzbot+23df5d97f6d7d7e8a71c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kernel@pengutronix.de, kuba@kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5833291ab6de Merge tag 'pci-v5.16-fixes-1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1125a676b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2897a869f0607967
dashboard link: https://syzkaller.appspot.com/bug?extid=23df5d97f6d7d7e8a71c
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+23df5d97f6d7d7e8a71c@syzkaller.appspotmail.com

vcan0: j1939_xtp_rx_dat: no rx connection found
vcan0: j1939_xtp_rx_dat_one: 0xffff8880261c9c00: last 00
vcan0: j1939_xtp_rx_dat: no rx connection found
vcan0: j1939_tp_rxtimer: 0xffff8880261cd800: abort rx timeout. Force session deactivation
------------[ cut here ]------------
WARNING: CPU: 1 PID: 20 at net/can/j1939/transport.c:1090 j1939_session_deactivate net/can/j1939/transport.c:1090 [inline]
WARNING: CPU: 1 PID: 20 at net/can/j1939/transport.c:1090 j1939_session_deactivate_activate_next net/can/j1939/transport.c:1100 [inline]
WARNING: CPU: 1 PID: 20 at net/can/j1939/transport.c:1090 j1939_tp_rxtimer+0x821/0xa20 net/can/j1939/transport.c:1228
Modules linked in:
CPU: 1 PID: 20 Comm: kworker/1:0 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_long defense_work_handler
RIP: 0010:j1939_session_deactivate net/can/j1939/transport.c:1090 [inline]
RIP: 0010:j1939_session_deactivate_activate_next net/can/j1939/transport.c:1100 [inline]
RIP: 0010:j1939_tp_rxtimer+0x821/0xa20 net/can/j1939/transport.c:1228
Code: e8 14 d1 6c f8 48 8b 3c 24 e9 0a f9 ff ff e8 06 d1 6c f8 4c 89 f7 be 03 00 00 00 e8 69 20 fe fa e9 52 f9 ff ff e8 ef d0 6c f8 <0f> 0b e9 fa f9 ff ff e8 e3 d0 6c f8 0f 0b e9 21 fb ff ff e8 d7 d0
RSP: 0018:ffffc90000dc0cb0 EFLAGS: 00010246
RAX: ffffffff89178381 RBX: 0000000000000001 RCX: ffff888012108000
RDX: 0000000000000302 RSI: 0000000000000001 RDI: 0000000000000002
RBP: dffffc0000000000 R08: ffffffff89177d74 R09: ffffed1004c39b06
R10: ffffed1004c39b06 R11: 0000000000000000 R12: 1ffff11004c39b00
R13: ffff8880261cd800 R14: 1ffff11004c39b1b R15: ffff8880261cd8d8
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f15f1427000 CR3: 00000000519fa000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x50b/0xa60 kernel/time/hrtimer.c:1749
 hrtimer_run_softirq+0x1b7/0x5d0 kernel/time/hrtimer.c:1766
 __do_softirq+0x392/0x7a3 kernel/softirq.c:558
 do_softirq+0x161/0x240 kernel/softirq.c:459
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1b0/0x1f0 kernel/softirq.c:383
 update_defense_level+0x878/0xc90 net/netfilter/ipvs/ip_vs_ctl.c:211
 defense_work_handler+0x1c/0xd0 net/netfilter/ipvs/ip_vs_ctl.c:236
 process_one_work+0x853/0x1140 kernel/workqueue.c:2298
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2445
 kthread+0x468/0x490 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
