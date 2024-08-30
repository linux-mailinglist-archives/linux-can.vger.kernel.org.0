Return-Path: <linux-can+bounces-1281-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B90D966BCB
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 23:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C551E1F22BF2
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 21:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDA81C1AB6;
	Fri, 30 Aug 2024 21:59:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2B165EE0
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725055164; cv=none; b=tx6+D3wtn113/VnwCzgFX2N5HgfRPUelSGh8aWCI1JQbTgZQWUuXVOLpaKn4l7azladFzLT8YnVl+odEwvi55VSNHLSomjAXcyogwF6PcmcT/uiFFVQvl7zRakNZF5eH8TiJu1LyMsvSj48wfoOgaEgrFlydZ/UU09ZeEq4HKxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725055164; c=relaxed/simple;
	bh=KbDT/LcX4fjmRGPRNezQ6gWxEF3QGKDLk8z+siYCBuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFmt6UesMikNRnGjvTwSsUyp4engpYOKzwJC3Yoa4pSb//UUbBj3D2tvHjZLOTS4kbf72lHmo7OAX4XML6FMasFsduvsogCPglkNdB54lMZVXAqqxEUfPMgzIeRLQc5xjXF3QnbmK7LhdE+y3l2MgI7aqfrV1ghPJ2Owv3mMaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9eK-0004Bl-G0
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:59:20 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9eI-004FW1-Ur
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:59:18 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A0CB132E506
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:59:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id BFAC332E4D4;
	Fri, 30 Aug 2024 21:59:16 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5aae15a0;
	Fri, 30 Aug 2024 21:59:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Simon Horman <horms@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 01/13] can: bcm: Remove proc entry when dev is unregistered.
Date: Fri, 30 Aug 2024 23:53:36 +0200
Message-ID: <20240830215914.1610393-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830215914.1610393-1-mkl@pengutronix.de>
References: <20240830215914.1610393-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Kuniyuki Iwashima <kuniyu@amazon.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/all/20240722192842.37421-1-kuniyu@amazon.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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

base-commit: 92c4ee25208d0f35dafc3213cdf355fbe449e078
-- 
2.45.2



