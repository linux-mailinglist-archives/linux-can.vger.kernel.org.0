Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE76D64495C
	for <lists+linux-can@lfdr.de>; Tue,  6 Dec 2022 17:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbiLFQfm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Dec 2022 11:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbiLFQfX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Dec 2022 11:35:23 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF72E60C9
        for <linux-can@vger.kernel.org>; Tue,  6 Dec 2022 08:34:36 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id l13-20020a056e021c0d00b003034e24b866so7654189ilh.22
        for <linux-can@vger.kernel.org>; Tue, 06 Dec 2022 08:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otfmXiKq+WJz+dQQ9OybBgLY5KvpZDxz8oPgOmP5vXQ=;
        b=VrWWZptGQpURBmLhowC4yKHGG6swXRuVs4QE+qvpjhH/NQ32z6dIQ6Lw1oN5sNkCVu
         2FEeGuzg0h0oiECCsb15WliJfRuPVfQ/ZM4naAz9/969ipexqKOuyXdncRZNHjBVUX5d
         s3IcUFPWzwHaSgr7ZdWCG8YZ46UJQV6v+SFgLy3z0Iwp/hTgNg/zJofdXpINUArVvh0K
         pLjXEb3sg/Vx4i7kPiFkKyJz91Pr/QoO9cFezsaUnTpe2M7atIFTkZE7k/9nylIgCP1E
         NnLkgtDzK3vBuhJJy5bJ5B8FJxHe6Ry2aMTs17P7LkK2v48+n9X3/TItetXqFRAXa9UW
         /YJw==
X-Gm-Message-State: ANoB5pn2tKAHxcEytojDeTgf0C43JF8NFbgf4RdZeRkvLrwzb5C532e2
        DGNhK6CuRisIM+Rz/glJtrZLdkEGvKQlb2bzDVWn2p5Wh2xk
X-Google-Smtp-Source: AA0mqf4THhEJ9Z8aIvmyPCJLCSgn390v+YXHZFh5pDGGY6vRFfXxKnRJNobSM3dWobpWVWOBRtYrEbDp5bJCTp+Wg9DSYR+lH/As
MIME-Version: 1.0
X-Received: by 2002:a92:db11:0:b0:303:1648:f2b9 with SMTP id
 b17-20020a92db11000000b003031648f2b9mr18505072iln.56.1670344476142; Tue, 06
 Dec 2022 08:34:36 -0800 (PST)
Date:   Tue, 06 Dec 2022 08:34:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002733a805ef2b6133@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in can_rcv_filter
From:   syzbot <syzbot+2d7f58292cb5b29eb5ad@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        mkl@pengutronix.de, netdev@vger.kernel.org, pabeni@redhat.com,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e3cb714fb489 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16e55ae3880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec7118319bfb771e
dashboard link: https://syzkaller.appspot.com/bug?extid=2d7f58292cb5b29eb5ad
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1164b38d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f61223880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/832eb1866f2c/disk-e3cb714f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5fd572b7d96d/vmlinux-e3cb714f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/34c82908beda/Image-e3cb714f.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d7f58292cb5b29eb5ad@syzkaller.appspotmail.com

syz-executor414 uses obsolete (PF_INET,SOCK_PACKET)
Unable to handle kernel paging request at virtual address 0000000000006020
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000109d9e000
[0000000000006020] pgd=080000010bb80003, p4d=080000010bb80003, pud=080000010ba1f003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3072 Comm: syz-executor414 Not tainted 6.1.0-rc7-syzkaller-33097-ge3cb714fb489 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : can_rcv_filter+0x30/0x30c net/can/af_can.c:584
lr : can_rcv_filter+0x28/0x30c net/can/af_can.c:578
sp : ffff80000f77b970
x29: ffff80000f77b970 x28: ffff0000c9f2cc80 x27: ffff80000f77bcd0
x26: 0000000000000000 x25: ffff0000c9585300 x24: 0000000000000001
x23: ffff0000c7be3680 x22: 0000000000000000 x21: 0000000000000000
x20: ffff0000c9f2c000 x19: ffff0000c9585300 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80000dbe6158 x15: ffff0000c7c98000
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c7c98000
x11: ff8080000b96c6ac x10: 0000000000000000 x9 : 0000000000006020
x8 : ffff0000c7ab2240 x7 : ffff80000b96c9a0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000002
x2 : 0000000000000008 x1 : ffff0000c9585300 x0 : 0000000000000000
Call trace:
 can_rcv_filter+0x30/0x30c
 can_receive+0x194/0x26c net/can/af_can.c:664
 canfd_rcv+0x7c/0xf8 net/can/af_can.c:703
 __netif_receive_skb_one_core net/core/dev.c:5489 [inline]
 __netif_receive_skb+0x70/0x14c net/core/dev.c:5603
 netif_receive_skb_internal+0xb4/0x258 net/core/dev.c:5689
 netif_receive_skb+0x28/0x44 net/core/dev.c:5748
 tun_rx_batched+0x1e0/0x220
 tun_get_user+0xf94/0x1148 drivers/net/tun.c:2004
 tun_chr_write_iter+0xa4/0x144 drivers/net/tun.c:2034
 call_write_iter include/linux/fs.h:2199 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x2dc/0x46c fs/read_write.c:584
 ksys_write+0xb4/0x160 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __arm64_sys_write+0x24/0x34 fs/read_write.c:646
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: aa0003f6 9724e4b5 f9406e68 528c0409 (b8696ad4) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa0003f6 	mov	x22, x0
   4:	9724e4b5 	bl	0xfffffffffc9392d8
   8:	f9406e68 	ldr	x8, [x19, #216]
   c:	528c0409 	mov	w9, #0x6020                	// #24608
* 10:	b8696ad4 	ldr	w20, [x22, x9] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
