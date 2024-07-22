Return-Path: <linux-can+bounces-993-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F4D939437
	for <lists+linux-can@lfdr.de>; Mon, 22 Jul 2024 21:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444FB1C21641
	for <lists+linux-can@lfdr.de>; Mon, 22 Jul 2024 19:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82717170826;
	Mon, 22 Jul 2024 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="h09fBmw4"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C223C17C74;
	Mon, 22 Jul 2024 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676546; cv=none; b=dN432o36WjEMMUFGDgvBWz3MyMqKAL1gmZtyZ7Au/h99x+Va0vzjhyQRN3JCKfaYZanK889glAQ1BBSueXdAd2slpGzK7MPVtXWy1j8gNhnbvwqwnIJ/+U+9tfpiiQTlLgmYyG8u3cFDzbE9CkbVZw/3ofgPRmL9G7n3EzuCxA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676546; c=relaxed/simple;
	bh=oSmX5xJuwf54iUSLuorC292+UWcTOgbDrExA8tyJTO0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=APIZ3EcOyjL4jClq3D0AJbXn1XGnpq4eAIQzVvyBqWoQuD4CYL/qb6xtTxGBubs//bFSmSpy4AezV121jCgXZvCgKwsMjBz41G9nynS8pk9FQv1JFfmwjf5Q9ZyiopC43m4J72zq4RNyiPANLRByx9HZtOHPcrpAicbr9RAuO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=h09fBmw4; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1721676545; x=1753212545;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OIjq83foyG1fe52fstL/HBclsUhSHuISfTogC73NVhg=;
  b=h09fBmw4YH+eZIksd/wQ9TpdgiK/ad5dW2lEZY5wK7azlaUB31//c59R
   RiH2F/1OXYBYfxHLI3lgbfNJksMCSMx/YRtBZBKvBVlez+bz427eSKXZH
   kLoIxwWekMUJzom4pMlKKqH6jzSq2gjo+q28OBw0zk9J2XlwrPchmWrME
   0=;
X-IronPort-AV: E=Sophos;i="6.09,228,1716249600"; 
   d="scan'208";a="744416417"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 19:29:00 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:2145]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.113:2525] with esmtp (Farcaster)
 id a716c307-610d-41de-9196-53afd578e1e1; Mon, 22 Jul 2024 19:28:58 +0000 (UTC)
X-Farcaster-Flow-ID: a716c307-610d-41de-9196-53afd578e1e1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 22 Jul 2024 19:28:58 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 22 Jul 2024 19:28:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
	<mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>,
	syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH v1 net] can: bcm: Remove proc entry when dev is unregistered.
Date: Mon, 22 Jul 2024 12:28:42 -0700
Message-ID: <20240722192842.37421-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported a warning in bcm_connect() below. [0]

The repro calls connect() to vxcan1, removes vxcan1, and calls
connect() with ifindex == 0.

Calling connect() for a BCM socket allocates a proc entry.
Then, bcm_sk(sk)->bound is set to 1 to prevent further connect().

However, removing the bound device resets bcm_sk(sk)->bound to 0
in bcm_notify().

The 2nd connect() tries to allocate a proc entry with the same
name and sets NULL to bcm_sk(sk)->bcm_proc_read, leaking the
original proc entry.

Since the proc entry is available only for connect()ed sockets,
let's clean up the entry when the bound netdev is unregistered.

[0]:
proc_dir_entry 'can-bcm/2456' already registered
WARNING: CPU: 1 PID: 394 at fs/proc/generic.c:376 proc_register+0x645/0x8f0 fs/proc/generic.c:375
Modules linked in:
CPU: 1 PID: 394 Comm: syz-executor403 Not tainted 6.10.0-rc7-g852e42cc2dd4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:proc_register+0x645/0x8f0 fs/proc/generic.c:375
Code: 00 00 00 00 00 48 85 ed 0f 85 97 02 00 00 4d 85 f6 0f 85 9f 02 00 00 48 c7 c7 9b cb cf 87 48 89 de 4c 89 fa e8 1c 6f eb fe 90 <0f> 0b 90 90 48 c7 c7 98 37 99 89 e8 cb 7e 22 05 bb 00 00 00 10 48
RSP: 0018:ffa0000000cd7c30 EFLAGS: 00010246
RAX: 9e129be1950f0200 RBX: ff1100011b51582c RCX: ff1100011857cd80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 0000000000000000 R08: ffd400000000000f R09: ff1100013e78cac0
R10: ffac800000cd7980 R11: ff1100013e12b1f0 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ff1100011a99a2ec
FS:  00007fbd7086f740(0000) GS:ff1100013fd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200071c0 CR3: 0000000118556004 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 proc_create_net_single+0x144/0x210 fs/proc/proc_net.c:220
 bcm_connect+0x472/0x840 net/can/bcm.c:1673
 __sys_connect_file net/socket.c:2049 [inline]
 __sys_connect+0x5d2/0x690 net/socket.c:2066
 __do_sys_connect net/socket.c:2076 [inline]
 __se_sys_connect net/socket.c:2073 [inline]
 __x64_sys_connect+0x8f/0x100 net/socket.c:2073
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7fbd708b0e5d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 9f 1b 00 f7 d8 64 89 01 48
RSP: 002b:00007fff8cd33f08 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fbd708b0e5d
RDX: 0000000000000010 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000040 R09: 0000000000000040
R10: 0000000000000040 R11: 0000000000000246 R12: 00007fff8cd34098
R13: 0000000000401280 R14: 0000000000406de8 R15: 00007fbd70ab9000
 </TASK>
remove_proc_entry: removing non-empty directory 'net/can-bcm', leaking at least '2456'

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/can/bcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 27d5fcf0eac9..46d3ec3aa44b 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1470,6 +1470,10 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 
 		/* remove device reference, if this is our bound device */
 		if (bo->bound && bo->ifindex == dev->ifindex) {
+#if IS_ENABLED(CONFIG_PROC_FS)
+			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read)
+				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
+#endif
 			bo->bound   = 0;
 			bo->ifindex = 0;
 			notify_enodev = 1;
-- 
2.30.2


