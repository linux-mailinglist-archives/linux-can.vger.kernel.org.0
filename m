Return-Path: <linux-can+bounces-1414-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B755F96CC2E
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 03:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9EE288F95
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 01:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DAA1EBFEB;
	Thu,  5 Sep 2024 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gf7EziGq"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D789454;
	Thu,  5 Sep 2024 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725499376; cv=none; b=MD8qbR7+eYGnq8w/yt1swWy3fMqLgYjwBo9IQHJpPHo7n4X0/Yg3E7+05PgKHAkJmUvawNXKed/QR2J0pIPrv5lo9PUsHT7c8kaTsA5d0JzQhwWxComTucJQ+AXsX+ajA2aaG5Nn/anP4DgbFiKGZLxk1UJXgahrvtiLvDYrNd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725499376; c=relaxed/simple;
	bh=NQpMLka8MwKSWw1GOTTQ0uK9ntX6J8Htva9sFQy9L8k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l+MjZ8gVjYxbACoDjfB/CL13YC72b2BeNnRNJ8TYrUxafJZanmfNgdza6plL8hVNR9y2r4R66m3d9ZNhkAatRttjf0a7BgRfT2KlEDy6zk5oojIUb+9MasHDVbynlrMFDph7O/iVPPb8mVVfElitHslXlmZOtbXyQ7uBwIPgTj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gf7EziGq; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725499376; x=1757035376;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EN1q4vsB2/j/bA9nXRUAZOYbQ6gn7foJUcapYKoWOrQ=;
  b=gf7EziGqNKpA5uE1oqORVnW3dpXAR0xYn0emQDgEVIPpasSX2x3VY2Ov
   b9WDMwDdsWckntaNexo5YaWK1+qZJ7T4394q7w7GKTybVA28HJkjW308i
   nAtrU6Zs2k0gMA/Pw4k1ziERU3IQ1Lga8HIPPl16rAQ3zG3vvXZM+Xo8R
   s=;
X-IronPort-AV: E=Sophos;i="6.10,203,1719878400"; 
   d="scan'208";a="656869979"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:22:52 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:47493]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.128:2525] with esmtp (Farcaster)
 id 93aac158-b1e6-4a49-be0a-9ba30dc02910; Thu, 5 Sep 2024 01:22:51 +0000 (UTC)
X-Farcaster-Flow-ID: 93aac158-b1e6-4a49-be0a-9ba30dc02910
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 5 Sep 2024 01:22:50 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 5 Sep 2024 01:22:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
	<mkl@pengutronix.de>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>,
	<syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com>
Subject: [PATCH v1 can] can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().
Date: Wed, 4 Sep 2024 18:22:37 -0700
Message-ID: <20240905012237.79683-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzbot reported a warning in bcm_release(). [0]

The blamed change fixed another warning that is triggered when
connect() is issued again for a socket whose connect()ed device has
been unregistered.

However, if the socket is just close()d without the 2nd connect(), the
remaining bo->bcm_proc_read triggers unnecessary remove_proc_entry()
in bcm_release().

Let's clear bo->bcm_proc_read after remove_proc_entry() in bcm_notify().

[0]
name '4986'
WARNING: CPU: 0 PID: 5234 at fs/proc/generic.c:711 remove_proc_entry+0x2e7/0x5d0 fs/proc/generic.c:711
Modules linked in:
CPU: 0 UID: 0 PID: 5234 Comm: syz-executor606 Not tainted 6.11.0-rc5-syzkaller-00178-g5517ae241919 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:remove_proc_entry+0x2e7/0x5d0 fs/proc/generic.c:711
Code: ff eb 05 e8 cb 1e 5e ff 48 8b 5c 24 10 48 c7 c7 e0 f7 aa 8e e8 2a 38 8e 09 90 48 c7 c7 60 3a 1b 8c 48 89 de e8 da 42 20 ff 90 <0f> 0b 90 90 48 8b 44 24 18 48 c7 44 24 40 0e 36 e0 45 49 c7 04 07
RSP: 0018:ffffc9000345fa20 EFLAGS: 00010246
RAX: 2a2d0aee2eb64600 RBX: ffff888032f1f548 RCX: ffff888029431e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000345fb08 R08: ffffffff8155b2f2 R09: 1ffff1101710519a
R10: dffffc0000000000 R11: ffffed101710519b R12: ffff888011d38640
R13: 0000000000000004 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcfb52722f0 CR3: 000000000e734000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bcm_release+0x250/0x880 net/can/bcm.c:1578
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x27f0 kernel/exit.c:882
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcfb51ee969
Code: Unable to access opcode bytes at 0x7fcfb51ee93f.
RSP: 002b:00007ffce0109ca8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fcfb51ee969
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007fcfb526f3b0 R08: ffffffffffffffb8 R09: 0000555500000000
R10: 0000555500000000 R11: 0000000000000246 R12: 00007fcfb526f3b0
R13: 0000000000000000 R14: 00007fcfb5271ee0 R15: 00007fcfb51bf160
 </TASK>

Fixes: 76fe372ccb81 ("can: bcm: Remove proc entry when dev is unregistered.")
Reported-by: syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0532ac7a06fb1a03187e
Tested-by: syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/can/bcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

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
-- 
2.30.2


