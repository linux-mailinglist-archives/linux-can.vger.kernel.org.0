Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3703D104954
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2019 04:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfKUDZM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Nov 2019 22:25:12 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:53825 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKUDZL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Nov 2019 22:25:11 -0500
Received: by mail-il1-f198.google.com with SMTP id y17so1665856ila.20
        for <linux-can@vger.kernel.org>; Wed, 20 Nov 2019 19:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tTMBJza7I+CNlM4ltV11PewawOOCN3wvlJFFx+joNqM=;
        b=FLAcS2s/x7PfFzDcnxgvj+cEyfQkdOUD4y0eszA22hRB6BiU1v9cKfkWkUyS9vv1Rz
         XE1tfTP8/uuqWkXn913dDXp9ero6OVS8tmwsauKyfiDfOr0JGZtASWa1XFs9o+7FnGXk
         vg4uuHUPBVL8etxuhNlrmkZ6ncwm1feetKhQJukhCqUEA11QdmQsdn9XMtFcB30/P4a5
         GniVexfIgzJxNYH1l8niwO/US/jNDr3GEMBO4dNJlzyqqDZqboq6d1u2QRpiWgJt7GRN
         p6NOCH84Mbm99rm6zUt65NCfUcb05y3aYmqi2L6WJncoAQQPpe8WG+PmuRSr/05LAvO4
         hf+Q==
X-Gm-Message-State: APjAAAXV5Jfw4qE1OoN0kS84PaksvWbWRxr+RilS0uJnNJyD+MqdWoup
        OWZFXsUatx+w0B+o6eKZwXGr9QUr5BhfJ6NXp33dlHgVUJDZ
X-Google-Smtp-Source: APXvYqwD2pIardansrgjP3LnHaQttGRCTOnZldnYzP3s94Fh1+Un8226PhVEKKjwmoGDMMNOiKFEH1JWUfNLlRdS1MyLXbWYqpyd
MIME-Version: 1.0
X-Received: by 2002:a02:878b:: with SMTP id t11mr6699673jai.20.1574306709039;
 Wed, 20 Nov 2019 19:25:09 -0800 (PST)
Date:   Wed, 20 Nov 2019 19:25:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028f3c20597d2d8ee@google.com>
Subject: WARNING in j1939_sk_queue_activate_next
From:   syzbot <syzbot+49595536c57ef38095ed@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kernel@pengutronix.de,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1f12177b Merge branch 'cpsw-switchdev'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16cd57f6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce691bc139ec9632
dashboard link: https://syzkaller.appspot.com/bug?extid=49595536c57ef38095ed
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14685836e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f8b2f2e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+49595536c57ef38095ed@syzkaller.appspotmail.com

vcan0: j1939_tp_rxtimer: 0x00000000bc4b6db0: rx timeout, send abort
vcan0: j1939_xtp_rx_abort_one: 0x00000000bc4b6db0: 0x00000: (3) A timeout  
occurred and this is the connection abort to close the session.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 9 at net/can/j1939/socket.c:180  
j1939_sk_queue_activate_next_locked net/can/j1939/socket.c:180 [inline]
WARNING: CPU: 0 PID: 9 at net/can/j1939/socket.c:180  
j1939_sk_queue_activate_next+0x359/0x460 net/can/j1939/socket.c:204
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 5.4.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  panic+0x2e3/0x75c kernel/panic.c:221
  __warn.cold+0x2f/0x35 kernel/panic.c:582
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:j1939_sk_queue_activate_next_locked net/can/j1939/socket.c:180  
[inline]
RIP: 0010:j1939_sk_queue_activate_next+0x359/0x460  
net/can/j1939/socket.c:204
Code: e8 1c 83 c0 0a 89 45 cc eb 9f 48 c7 c7 b4 1a c7 89 e8 cb b1 2d fb e9  
6a fd ff ff e8 c1 b1 2d fb e9 19 fe ff ff e8 17 f9 f1 fa <0f> 0b 48 8b 45  
c0 48 8d b8 b0 00 00 00 48 89 f8 48 c1 e8 03 42 0f
RSP: 0018:ffff8880a98af918 EFLAGS: 00010206
RAX: ffff8880a98a2240 RBX: ffff888099561000 RCX: ffffffff86816668
RDX: 0000000000000100 RSI: ffffffff86816709 RDI: 0000000000000005
RBP: ffff8880a98af970 R08: ffff8880a98a2240 R09: fffffbfff14f0f4c
R10: fffffbfff14f0f4b R11: ffffffff8a787a5f R12: ffff888099561510
R13: ffff88809175cc00 R14: ffff888099561548 R15: dffffc0000000000
  j1939_session_deactivate_activate_next+0x3d/0x50  
net/can/j1939/transport.c:1046
  j1939_xtp_rx_abort_one.cold+0x21a/0x35e net/can/j1939/transport.c:1275
  j1939_xtp_rx_abort net/can/j1939/transport.c:1286 [inline]
  j1939_tp_cmd_recv net/can/j1939/transport.c:1972 [inline]
  j1939_tp_recv+0x783/0x9b0 net/can/j1939/transport.c:2005
  j1939_can_recv+0x502/0x610 net/can/j1939/main.c:101
  deliver net/can/af_can.c:569 [inline]
  can_rcv_filter+0x292/0x8e0 net/can/af_can.c:603
  can_receive+0x2e7/0x530 net/can/af_can.c:660
  can_rcv+0x133/0x1b0 net/can/af_can.c:686
  __netif_receive_skb_one_core+0x113/0x1a0 net/core/dev.c:5150
  __netif_receive_skb+0x2c/0x1d0 net/core/dev.c:5264
  process_backlog+0x206/0x750 net/core/dev.c:6095
  napi_poll net/core/dev.c:6532 [inline]
  net_rx_action+0x508/0x1120 net/core/dev.c:6600
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  run_ksoftirqd kernel/softirq.c:603 [inline]
  run_ksoftirqd+0x8e/0x110 kernel/softirq.c:595
  smpboot_thread_fn+0x6a3/0xa40 kernel/smpboot.c:165
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
