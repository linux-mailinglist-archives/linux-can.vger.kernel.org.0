Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B10A138C09
	for <lists+linux-can@lfdr.de>; Mon, 13 Jan 2020 07:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgAMGvJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Jan 2020 01:51:09 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:50626 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbgAMGvJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2020 01:51:09 -0500
Received: by mail-io1-f72.google.com with SMTP id e13so5274549iob.17
        for <linux-can@vger.kernel.org>; Sun, 12 Jan 2020 22:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ycj0awElW1hWnnKMNTaanNWIbCD1FSZip4i2JBGkPVA=;
        b=R6zJV4q7YYAfDDiKlAMlZfsCZFpMgiqMw5g8kKxpuLMAum5NwDFAWJX8H9SLbiVHCS
         CShCuuCgGOqCby1oP0rrBIXdQ3dy//aJRDwX3t1YwWsUqq45a3l91TCjjsjQVfIUD3ZT
         KBvj3S2OxrgPMhvYAIWmcDp+t4qGrn4EuqQGSVCnn49Qas8X/WKmqyUMZQdJpi8L9k29
         DoOHlnz7BPnNSiPwKkULaBfg5ViWSnL2f4rt4Be6W17IirIggBUVpXlIhj+qg+Sopcrv
         QVpzhpIRpdoc+t2gJFe9A8Fblu3/XMrapPnQHlWnpRLxcp2TZjcPB1D6qIG6eEVHoiF5
         S8XQ==
X-Gm-Message-State: APjAAAVrkXtmklMjuyeqGUEhqW03J8jcsC3DApISXzB0UvI+MsidEpKf
        HsLpW6t11LZaWkbuBs6tqU2kwu5HKLJFTFik5y7j6iw0G0Uo
X-Google-Smtp-Source: APXvYqxccUNa6DXjS1lJQt9z+UwHdt/rDmithf+xkwkwyToXyN47QgtPSLOYybeOMjCdkMhlHkCh1nrBfJsXuN7rEBA6LzyLZ0wD
MIME-Version: 1.0
X-Received: by 2002:a02:3946:: with SMTP id w6mr13289460jae.9.1578898268776;
 Sun, 12 Jan 2020 22:51:08 -0800 (PST)
Date:   Sun, 12 Jan 2020 22:51:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007272b9059bffe6cc@google.com>
Subject: WARNING: refcount bug in j1939_netdev_start (2)
From:   syzbot <syzbot+85d9878b19c94f9019ad@syzkaller.appspotmail.com>
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

HEAD commit:    6327edce Merge branch 'i2c/for-current' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1608b349e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e89bd00623fe71e
dashboard link: https://syzkaller.appspot.com/bug?extid=85d9878b19c94f9019ad
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+85d9878b19c94f9019ad@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 1 PID: 26973 at lib/refcount.c:25  
refcount_warn_saturate+0x174/0x1f0 lib/refcount.c:25
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 26973 Comm: syz-executor.2 Not tainted 5.5.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  panic+0x2e3/0x75c kernel/panic.c:221
  __warn.cold+0x2f/0x3e kernel/panic.c:582
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  fixup_bug arch/x86/kernel/traps.c:169 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:refcount_warn_saturate+0x174/0x1f0 lib/refcount.c:25
Code: 06 31 ff 89 de e8 6c 18 d9 fd 84 db 0f 85 33 ff ff ff e8 1f 17 d9 fd  
48 c7 c7 c0 27 71 88 c6 05 7b d8 da 06 01 e8 9b c6 a9 fd <0f> 0b e9 14 ff  
ff ff e8 00 17 d9 fd 0f b6 1d 60 d8 da 06 31 ff 89
RSP: 0018:ffffc90008e77ce0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000009ee4 RSI: ffffffff815e53a6 RDI: fffff520011cef8e
RBP: ffffc90008e77cf0 R08: ffff888093580600 R09: ffffed1015d26621
R10: ffffed1015d26620 R11: ffff8880ae933107 R12: 0000000000000002
R13: ffff888047150000 R14: ffff8880a725b000 R15: 0000000000000118
  refcount_add include/linux/refcount.h:191 [inline]
  refcount_inc include/linux/refcount.h:228 [inline]
  kref_get include/linux/kref.h:45 [inline]
  j1939_netdev_start+0x534/0x650 net/can/j1939/main.c:277
  j1939_sk_bind+0x68d/0x980 net/can/j1939/socket.c:469
  __sys_bind+0x239/0x290 net/socket.c:1649
  __do_sys_bind net/socket.c:1660 [inline]
  __se_sys_bind net/socket.c:1658 [inline]
  __x64_sys_bind+0x73/0xb0 net/socket.c:1658
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45af49
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0a1184dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045af49
RDX: 0000000000000018 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 000000000075c070 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0a1184e6d4
R13: 00000000004c1358 R14: 00000000004d6080 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
