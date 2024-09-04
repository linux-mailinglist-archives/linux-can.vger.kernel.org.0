Return-Path: <linux-can+bounces-1409-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA35796C59D
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 19:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2961C22064
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 17:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDD41E132F;
	Wed,  4 Sep 2024 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="H6r00sz1"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595801DFE09;
	Wed,  4 Sep 2024 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471838; cv=none; b=kYfpgksOnv6u30cqK9kuRNu+gxsHxT2jVJ0XzEdLQzmzNZ2JrZG0idQYkl8W5kRy4s14vADgaYzsqM2LyGKmH1AybFMk9YTFqamkcsBB96tVRvxoVpolTopP9gOIsIsEbzB/pDMyMRH8siB9hdPiOn/OX1mTE6xXzLXe5Grl2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471838; c=relaxed/simple;
	bh=jgFNIwh7TmMFpsYn60zkFlkwVBo27ZTfVXurrph+ZmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKhrc+ION6p3VbQE9FxImx3b9MGvFmEERUdSpOlJZceqqtoyBYvLWcc482gLt4UgSNmxgUeClBi3NyFfkEinqQvhf9pkE10VDlwF1gYUlq0IZ5hv2Xy7eoF3MUaqa4LB7BxNLQ8VMhi6VwuIOM/LQGqdg1XIkpWZFNqmNtPpBkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=H6r00sz1; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725471836; x=1757007836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VaztKR8g+ioe+vJICHmS9w2/jXfJ3nv9bois1lIiiks=;
  b=H6r00sz1zT0khERlkdyDHoGD03+oPiZBwJ8FlCrt64byLyramzhydoBp
   U8ZEHjarsk8wcJrYPYiB9Grlz32q1v+haoOv+1ZOm+7ggiPmHBwp3O25a
   +6yrC9SV61igNmJV+z2x2VhHLV69T8YCGyLhOYywQ+eheU6tSuuhIGy7w
   A=;
X-IronPort-AV: E=Sophos;i="6.10,202,1719878400"; 
   d="scan'208";a="122555610"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 17:43:53 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:2416]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.127:2525] with esmtp (Farcaster)
 id c6a4ffff-fca8-4c65-a7e4-851a334983bc; Wed, 4 Sep 2024 17:43:53 +0000 (UTC)
X-Farcaster-Flow-ID: c6a4ffff-fca8-4c65-a7e4-851a334983bc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 4 Sep 2024 17:43:52 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 4 Sep 2024 17:43:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-can@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mkl@pengutronix.de>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <socketcan@hartkopp.net>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [can?] WARNING in remove_proc_entry (6)
Date: Wed, 4 Sep 2024 10:43:39 -0700
Message-ID: <20240904174339.7790-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0000000000001934d306214b8aa9@google.com>
References: <0000000000001934d306214b8aa9@google.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com>
Date: Wed, 04 Sep 2024 06:56:23 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5517ae241919 Merge tag 'for-net-2024-08-30' of git://git.k..
> git tree:       net
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=111adcfb980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
> dashboard link: https://syzkaller.appspot.com/bug?extid=0532ac7a06fb1a03187e
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138d43db980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11fe3d43980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ddded5c54678/disk-5517ae24.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ce0dfe9dbb55/vmlinux-5517ae24.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ca81d6e3361d/bzImage-5517ae24.xz
> 
> The issue was bisected to:
> 
> commit 76fe372ccb81b0c89b6cd2fec26e2f38c958be85
> Author: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date:   Mon Jul 22 19:28:42 2024 +0000
> 
>     can: bcm: Remove proc entry when dev is unregistered.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116f8e8f980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=136f8e8f980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=156f8e8f980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com
> Fixes: 76fe372ccb81 ("can: bcm: Remove proc entry when dev is unregistered.")
> 
> ------------[ cut here ]------------
> name '4986'
> WARNING: CPU: 0 PID: 5234 at fs/proc/generic.c:711 remove_proc_entry+0x2e7/0x5d0 fs/proc/generic.c:711
> Modules linked in:
> CPU: 0 UID: 0 PID: 5234 Comm: syz-executor606 Not tainted 6.11.0-rc5-syzkaller-00178-g5517ae241919 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> RIP: 0010:remove_proc_entry+0x2e7/0x5d0 fs/proc/generic.c:711
> Code: ff eb 05 e8 cb 1e 5e ff 48 8b 5c 24 10 48 c7 c7 e0 f7 aa 8e e8 2a 38 8e 09 90 48 c7 c7 60 3a 1b 8c 48 89 de e8 da 42 20 ff 90 <0f> 0b 90 90 48 8b 44 24 18 48 c7 44 24 40 0e 36 e0 45 49 c7 04 07
> RSP: 0018:ffffc9000345fa20 EFLAGS: 00010246
> RAX: 2a2d0aee2eb64600 RBX: ffff888032f1f548 RCX: ffff888029431e00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000345fb08 R08: ffffffff8155b2f2 R09: 1ffff1101710519a
> R10: dffffc0000000000 R11: ffffed101710519b R12: ffff888011d38640
> R13: 0000000000000004 R14: 0000000000000000 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcfb52722f0 CR3: 000000000e734000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  bcm_release+0x250/0x880 net/can/bcm.c:1578
>  __sock_release net/socket.c:659 [inline]
>  sock_close+0xbc/0x240 net/socket.c:1421
>  __fput+0x24a/0x8a0 fs/file_table.c:422
>  task_work_run+0x24f/0x310 kernel/task_work.c:228
>  exit_task_work include/linux/task_work.h:40 [inline]
>  do_exit+0xa2f/0x27f0 kernel/exit.c:882
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1031
>  __do_sys_exit_group kernel/exit.c:1042 [inline]
>  __se_sys_exit_group kernel/exit.c:1040 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
>  x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fcfb51ee969
> Code: Unable to access opcode bytes at 0x7fcfb51ee93f.
> RSP: 002b:00007ffce0109ca8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fcfb51ee969
> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
> RBP: 00007fcfb526f3b0 R08: ffffffffffffffb8 R09: 0000555500000000
> R10: 0000555500000000 R11: 0000000000000246 R12: 00007fcfb526f3b0
> R13: 0000000000000000 R14: 00007fcfb5271ee0 R15: 00007fcfb51bf160
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash

Ugh, I forgot to clear bo->bcm_proc_read.

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git HEAD

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 46d3ec3aa44b..217049fa496e 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1471,8 +1471,10 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 		/* remove device reference, if this is our bound device */
 		if (bo->bound && bo->ifindex == dev->ifindex) {
 #if IS_ENABLED(CONFIG_PROC_FS)
-			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read)
+			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read) {
 				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
+				bo->bcm_proc_read = NULL;
+			}
 #endif
 			bo->bound   = 0;
 			bo->ifindex = 0;

