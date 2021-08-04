Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CE83DFC98
	for <lists+linux-can@lfdr.de>; Wed,  4 Aug 2021 10:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhHDIQb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Aug 2021 04:16:31 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:41622 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbhHDIQb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Aug 2021 04:16:31 -0400
Received: by mail-io1-f70.google.com with SMTP id c18-20020a0566023352b0290523c137a6a4so1011453ioz.8
        for <linux-can@vger.kernel.org>; Wed, 04 Aug 2021 01:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oKFGrnqPpcOPV7wZiKJ6cPKB9Oi3nefvOJEtkwdIyG4=;
        b=U7YHHBqfuECOou8XdBp9GQ8ne+zFhx6SeMTABi2As3RYhQRyzt26s+0AzfOX68SJUI
         zm4hZPvv5LtqmFyiGgozt6SkU1oCx+q284wzvaYPzbri9YmlWqquymzU0crBJVBst6a3
         N6u2CUox6fw3LIDW5ml0NseG6x3nIJTkWZzRM69ogLX0Cy+/+DKikSPOqbEfZriKbuAT
         0wxDpdFiNtfl8OrSpSO4xSFxAHyMD1IX9Xt5Db5pz0YFDqc4PNgsDzVNv29qaPBkTDv8
         /5XeTKjTu+YW8ryuTD4V3TdX9TS26vUoozJa9iNsUbA3ul2GmobMvkn0b5H1pGOYku2R
         0KBw==
X-Gm-Message-State: AOAM530KUqmARHll3vw6RjX0t2xr4H/4KkjenM5f36cI1GXkeRzahL/k
        oMHdW9pk/gcg5Ee/VdBl+vkqtmlndbY3o6QFSi6TOSZWjgQh
X-Google-Smtp-Source: ABdhPJxWm9eHbu5NZ/QigOM9PqOGbgeIUqYHTyGBkWDzxpyQHt2ScxP4AaoT5sSsF9AsTyG1mj8HvIxGR+ygQHi4plbEQ0yLvAyK
MIME-Version: 1.0
X-Received: by 2002:a92:c549:: with SMTP id a9mr313514ilj.248.1628064978847;
 Wed, 04 Aug 2021 01:16:18 -0700 (PDT)
Date:   Wed, 04 Aug 2021 01:16:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc4eb305c8b76ab5@google.com>
Subject: [syzbot] WARNING in j1939_xtp_rx_abort_one
From:   syzbot <syzbot+9981a614060dcee6eeca@syzkaller.appspotmail.com>
To:     bst@pengutronix.de, davem@davemloft.net,
        dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com,
        kernel@pengutronix.de, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de,
        netdev@vger.kernel.org, o.rempel@pengutronix.de, robin@protonic.nl,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c7d102232649 Merge tag 'net-5.14-rc4' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1308610a300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6cc86e19161c9d37
dashboard link: https://syzkaller.appspot.com/bug?extid=9981a614060dcee6eeca
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15874fda300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a507b6300000

The issue was bisected to:

commit 9d71dd0c70099914fcd063135da3c580865e924c
Author: The j1939 authors <linux-can@vger.kernel.org>
Date:   Mon Oct 8 09:48:36 2018 +0000

    can: add support of SAE J1939 protocol

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a70c66300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14670c66300000
console output: https://syzkaller.appspot.com/x/log.txt?x=10670c66300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9981a614060dcee6eeca@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

vcan0: j1939_tp_rxtimer: 0xffff888012588c00: rx timeout, send abort
vcan0: j1939_xtp_rx_abort_one: 0xffff88802f335800: 0x00000: (3) A timeout occurred and this is the connection abort to close the session.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 19 at net/can/j1939/transport.c:1085 j1939_session_deactivate net/can/j1939/transport.c:1085 [inline]
WARNING: CPU: 1 PID: 19 at net/can/j1939/transport.c:1085 j1939_session_deactivate_activate_next net/can/j1939/transport.c:1095 [inline]
WARNING: CPU: 1 PID: 19 at net/can/j1939/transport.c:1085 j1939_xtp_rx_abort_one+0x666/0x790 net/can/j1939/transport.c:1329
Modules linked in:
CPU: 1 PID: 19 Comm: ksoftirqd/1 Not tainted 5.14.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:j1939_session_deactivate net/can/j1939/transport.c:1085 [inline]
RIP: 0010:j1939_session_deactivate_activate_next net/can/j1939/transport.c:1095 [inline]
RIP: 0010:j1939_xtp_rx_abort_one+0x666/0x790 net/can/j1939/transport.c:1329
Code: e9 88 fa ff ff e8 da 5f 8b f8 4c 89 f7 be 03 00 00 00 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d e9 af 1f 11 fb e8 ba 5f 8b f8 <0f> 0b e9 4b fd ff ff e8 ae 5f 8b f8 0f 0b e9 ca fd ff ff 89 e9 80
RSP: 0018:ffffc90000d975a0 EFLAGS: 00010246
RAX: ffffffff88f4c4f6 RBX: 0000000000000001 RCX: ffff8880124354c0
RDX: 0000000000000301 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 1ffff11005e66b00 R08: ffffffff88f4c23a R09: ffffed1005e66b06
R10: ffffed1005e66b06 R11: 0000000000000000 R12: ffff88802f335800
R13: 0000000000000009 R14: ffff8880221ad070 R15: ffff88802f335828
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004b8120 CR3: 00000000334c1000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 j1939_xtp_rx_abort net/can/j1939/transport.c:1340 [inline]
 j1939_tp_cmd_recv+0x374/0x1200 net/can/j1939/transport.c:2065
 j1939_tp_recv+0x1f7/0x540 net/can/j1939/transport.c:2098
 j1939_can_recv+0x652/0xa10 net/can/j1939/main.c:101
 deliver net/can/af_can.c:574 [inline]
 can_rcv_filter+0x35e/0x800 net/can/af_can.c:608
 can_receive+0x2e8/0x410 net/can/af_can.c:665
 can_rcv+0xda/0x1f0 net/can/af_can.c:696
 __netif_receive_skb_one_core net/core/dev.c:5498 [inline]
 __netif_receive_skb+0x1d1/0x500 net/core/dev.c:5612
 process_backlog+0x4d8/0x940 net/core/dev.c:6492
 __napi_poll+0xba/0x4f0 net/core/dev.c:7047
 napi_poll net/core/dev.c:7114 [inline]
 net_rx_action+0x62c/0xf30 net/core/dev.c:7201
 __do_softirq+0x372/0x783 kernel/softirq.c:558
 run_ksoftirqd+0xa2/0x100 kernel/softirq.c:920
 smpboot_thread_fn+0x533/0x9d0 kernel/smpboot.c:164
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
