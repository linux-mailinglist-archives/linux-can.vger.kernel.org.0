Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414DA75AD44
	for <lists+linux-can@lfdr.de>; Thu, 20 Jul 2023 13:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjGTLoq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 20 Jul 2023 07:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjGTLop (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 20 Jul 2023 07:44:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4CF189
        for <linux-can@vger.kernel.org>; Thu, 20 Jul 2023 04:44:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-cfc77042aeaso611408276.0
        for <linux-can@vger.kernel.org>; Thu, 20 Jul 2023 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689853483; x=1690458283;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DuXvykG6hdNeayWwL/tNxVS8PZdAVcLPAGOTgBK6Q4g=;
        b=tjTPN7s9epPx68xvpLymIPVUs5sKW/57acYN6zkCykbYRXXcNuBcYkxXyut0KmMk7r
         Sd91i3rbokSPMKv4KtE61krl4tqMb322aAtO1Zn3I+8+TRh60cyrxZvpOJS8TosX3g8J
         N3XjnSroDPTHVvZ4XOOD8I1Rj5dQpnkiyt9vk6lH/eJuKXwMx45MrFy2sQjem8vYjIxI
         k/wwqLer3CMSERVdrxSYKgXlOBBoQqC9p9ejnA+uQYiw1Hrd3Xvcr/oIQpkTYhyjTD7U
         nRb47kYBpMqTwF1oiSkz68B/aymmZwQLWgjP5kLFpAWMhrZ2B7Qc57izVsf6L7NYHeT2
         +Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689853483; x=1690458283;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DuXvykG6hdNeayWwL/tNxVS8PZdAVcLPAGOTgBK6Q4g=;
        b=QAfaWz5wKjVxRuQ75tg7qFzWpPKNJ16mvs4cbOJnWogz83YsK8RW0TsD2gF2qp/IMa
         2g8ezSJSgygDntTq1e8CWrhwaxM7flmxr58HwaZjisq8Dh1q9xLL6NDOn2HHpNZrhJ9Q
         DnAxjL8oCfK764QJ0lfJPRl7YnZxdD28e/0IzbQf/oS8SNIQJ0qW5gojabozsOxz5F6o
         P2Oj/5FN9XxPRdWptGrr4dUpHQ8DJeDC3RfBrX8FPr3Ko2cKM3wEDc/Z4kEMdeDnMSXx
         US+xkW7mDkUdj+LafDzDAoCsbto4EH0iO1p3hD9dVhxrUk/LqK1CzKs8gV9FFmpmTXbd
         YY7Q==
X-Gm-Message-State: ABy/qLaLlKaHbvDLHoMNiSu1W90NM0TbGupx7qwmPny+Vr6eLxd9/rXV
        Uf0bLTkxFsj6AvDNagag9TdFZQToWfP4WQ==
X-Google-Smtp-Source: APBJJlGilmpMxlKLdzyWk7evEnfDWhYpi0O2OMBNDT79id0tR7viT0yXJjdLNZbbibmxfa8faMXX6i6gFpcaOg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1024:b0:c67:975c:74ab with SMTP
 id x4-20020a056902102400b00c67975c74abmr50332ybt.4.1689853483088; Thu, 20 Jul
 2023 04:44:43 -0700 (PDT)
Date:   Thu, 20 Jul 2023 11:44:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720114438.172434-1-edumazet@google.com>
Subject: [PATCH net] can: raw: fix lockdep issue in raw_release()
From:   Eric Dumazet <edumazet@google.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-can@vger.kernel.org,
        eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

syzbot complained about a lockdep issue [1]

Since raw_bind() and raw_setsockopt() first get RTNL
before locking the socket, we must adopt the same order in raw_release()

[1]
WARNING: possible circular locking dependency detected
6.5.0-rc1-syzkaller-00192-g78adb4bcf99e #0 Not tainted
------------------------------------------------------
syz-executor.0/14110 is trying to acquire lock:
ffff88804e4b6130 (sk_lock-AF_CAN){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1708 [inline]
ffff88804e4b6130 (sk_lock-AF_CAN){+.+.}-{0:0}, at: raw_bind+0xb1/0xab0 net/can/raw.c:435

but task is already holding lock:
ffffffff8e3df368 (rtnl_mutex){+.+.}-{3:3}, at: raw_bind+0xa7/0xab0 net/can/raw.c:434

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (rtnl_mutex){+.+.}-{3:3}:
__mutex_lock_common kernel/locking/mutex.c:603 [inline]
__mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
raw_release+0x1c6/0x9b0 net/can/raw.c:391
__sock_release+0xcd/0x290 net/socket.c:654
sock_close+0x1c/0x20 net/socket.c:1386
__fput+0x3fd/0xac0 fs/file_table.c:384
task_work_run+0x14d/0x240 kernel/task_work.c:179
resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
__syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (sk_lock-AF_CAN){+.+.}-{0:0}:
check_prev_add kernel/locking/lockdep.c:3142 [inline]
check_prevs_add kernel/locking/lockdep.c:3261 [inline]
validate_chain kernel/locking/lockdep.c:3876 [inline]
__lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
lock_acquire kernel/locking/lockdep.c:5761 [inline]
lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
lock_sock_nested+0x3a/0xf0 net/core/sock.c:3492
lock_sock include/net/sock.h:1708 [inline]
raw_bind+0xb1/0xab0 net/can/raw.c:435
__sys_bind+0x1ec/0x220 net/socket.c:1792
__do_sys_bind net/socket.c:1803 [inline]
__se_sys_bind net/socket.c:1801 [inline]
__x64_sys_bind+0x72/0xb0 net/socket.c:1801
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Possible unsafe locking scenario:

CPU0 CPU1
---- ----
lock(rtnl_mutex);
        lock(sk_lock-AF_CAN);
        lock(rtnl_mutex);
lock(sk_lock-AF_CAN);

*** DEADLOCK ***

1 lock held by syz-executor.0/14110:

stack backtrace:
CPU: 0 PID: 14110 Comm: syz-executor.0 Not tainted 6.5.0-rc1-syzkaller-00192-g78adb4bcf99e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2195
check_prev_add kernel/locking/lockdep.c:3142 [inline]
check_prevs_add kernel/locking/lockdep.c:3261 [inline]
validate_chain kernel/locking/lockdep.c:3876 [inline]
__lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
lock_acquire kernel/locking/lockdep.c:5761 [inline]
lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
lock_sock_nested+0x3a/0xf0 net/core/sock.c:3492
lock_sock include/net/sock.h:1708 [inline]
raw_bind+0xb1/0xab0 net/can/raw.c:435
__sys_bind+0x1ec/0x220 net/socket.c:1792
__do_sys_bind net/socket.c:1803 [inline]
__se_sys_bind net/socket.c:1801 [inline]
__x64_sys_bind+0x72/0xb0 net/socket.c:1801
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd89007cb29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd890d2a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00007fd89019bf80 RCX: 00007fd89007cb29
RDX: 0000000000000010 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007fd8900c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fd89019bf80 R15: 00007ffebf8124f8
</TASK>

Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 2302e48829677334f8b2d74a479e5a9cbb5ce03c..ba6b52b1d7767fdd7b57d1b8e5519495340c572c 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -386,9 +386,9 @@ static int raw_release(struct socket *sock)
 	list_del(&ro->notifier);
 	spin_unlock(&raw_notifier_lock);
 
+	rtnl_lock();
 	lock_sock(sk);
 
-	rtnl_lock();
 	/* remove current filters & unregister */
 	if (ro->bound) {
 		if (ro->dev)
@@ -405,12 +405,13 @@ static int raw_release(struct socket *sock)
 	ro->dev = NULL;
 	ro->count = 0;
 	free_percpu(ro->uniq);
-	rtnl_unlock();
 
 	sock_orphan(sk);
 	sock->sk = NULL;
 
 	release_sock(sk);
+	rtnl_unlock();
+
 	sock_put(sk);
 
 	return 0;
-- 
2.41.0.255.g8b1d071c50-goog

