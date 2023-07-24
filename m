Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD1175F7D0
	for <lists+linux-can@lfdr.de>; Mon, 24 Jul 2023 15:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjGXNHl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 24 Jul 2023 09:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGXNHk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Jul 2023 09:07:40 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74857A1;
        Mon, 24 Jul 2023 06:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690202975; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=A6sv8Ota3r8O8Emel6Vf1E8BIoqPa7jSolHG+nADyffKyQzSZZOJNkcI/NLl1xnKog
    rp+IS4GnM2Erlj9RG0tBUiujlFNkOBYcDUtsfigo0pVD0zDlMxTX3PFbCvzmaadGqkAk
    lbuFm82/cMuGSxOc3jDbSrvPPgGSMhiSHY/N/YPyGSoFm6bQZ7GESsaX624N4yWTw3Lf
    B5Pir8hKnSStkeL+NtKTSBSQJlbHPjjtoGXMIj0lvcuMpumtICz8RMUDcsWExR1lw+l1
    KzmxopEXWQUkLB1fb3S2nN40kFzKXjqik3OUCFg+3+7xES5lO5TO7dxZqUw8zI8sTY2Y
    eDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690202975;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5/p8Gwj164g7ViZ92+oJe08m2FRlX46uTBb/CAy2e7I=;
    b=oYtfXOxdYjDiDTDWNo4NNRXNLC8kSr8v6A7s5Poz/PJOQK1w6/5mNY+X6ysgOHSEva
    qh6PCCg/yj3hWeKet49dE3jifxdOYXpgX0d6U3YUdEYgP6nanY3GTyoBxU0HxYpF3p9G
    PPZuJSqzEj2LEDncwN3Or0Oeui1usha87JCN+3NKgQuNrRduKrxA+TvIiFb2IQXnBpkf
    uoG+VRmTuvbtWIvh0IEUngovV9hOIwL0f76FG/0X+vin3KgkrAPZ282XYr/Uyg/uqEwi
    hgmIIGz84BM/pSVmCyG8fZjghlbeMUzkmdeZ1Arp5O6fC718ovfcyyKR+9R+3/r35Yto
    KN4A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690202975;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5/p8Gwj164g7ViZ92+oJe08m2FRlX46uTBb/CAy2e7I=;
    b=TNSYzcqw0bMfKIYdPNNIBopNr/GSktLX14LnkVis7aLuGm1zw4aILK9TPJ8vrrH465
    PRVfv6BbFWclX+97n89p5ikrjvFGB/eWXBD+GLa/hAWVvsqc8nvPfakR6bJhvZ/+TskU
    dGJCEYNGLDehT0yqoqF5TWsaNRgS3eaHWuyLkKjDZMAYC3wAiXDIEICHfPCViS9O9Hll
    Fhhd0FiMcOkQYaXbF4Z5cSGyEmlf5uv4wzguMhZjr9tVO8zqNpxiNjzcF3ISPV8bzCEg
    WM+gnWoqDAUl1e5eWhbIQzLicjluSLrydNFXlhl10ZIVObWXdZsYE45kKnViOPfivaxg
    4Opg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690202975;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5/p8Gwj164g7ViZ92+oJe08m2FRlX46uTBb/CAy2e7I=;
    b=+QQsYL/fkrxdU3HwTkMY58l5jAIU7FxBlHa0e6GmdGMo3uw5GsIQ3g6iGL7l8nJhIW
    tfKZtlSaLom1EB/M7fBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1q3jXdVqE32oRVrGn+2FyPw=="
Received: from [100.81.8.108]
    by smtp.strato.de (RZmta 49.6.4 AUTH)
    with ESMTPSA id K77cfez6OCnXCwt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 24 Jul 2023 14:49:33 +0200 (CEST)
Message-ID: <35c85eb5-24aa-d948-516a-72fa7db28c88@hartkopp.net>
Date:   Mon, 24 Jul 2023 14:49:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] can: raw: fix lockdep issue in raw_release()
To:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-can@vger.kernel.org,
        eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20230720114438.172434-1-edumazet@google.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230720114438.172434-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Eric, Jakub,

the patch that needs to be fixed here is currently already on its way 
into the stable trees:

 > Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")

Should this patch go through the linux-can tree or would somebody like 
to apply it directly to the net tree?

Many thanks,
Oliver

On 20.07.23 13:44, Eric Dumazet wrote:
> syzbot complained about a lockdep issue [1]
> 
> Since raw_bind() and raw_setsockopt() first get RTNL
> before locking the socket, we must adopt the same order in raw_release()
> 
> [1]
> WARNING: possible circular locking dependency detected
> 6.5.0-rc1-syzkaller-00192-g78adb4bcf99e #0 Not tainted
> ------------------------------------------------------
> syz-executor.0/14110 is trying to acquire lock:
> ffff88804e4b6130 (sk_lock-AF_CAN){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1708 [inline]
> ffff88804e4b6130 (sk_lock-AF_CAN){+.+.}-{0:0}, at: raw_bind+0xb1/0xab0 net/can/raw.c:435
> 
> but task is already holding lock:
> ffffffff8e3df368 (rtnl_mutex){+.+.}-{3:3}, at: raw_bind+0xa7/0xab0 net/can/raw.c:434
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (rtnl_mutex){+.+.}-{3:3}:
> __mutex_lock_common kernel/locking/mutex.c:603 [inline]
> __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
> raw_release+0x1c6/0x9b0 net/can/raw.c:391
> __sock_release+0xcd/0x290 net/socket.c:654
> sock_close+0x1c/0x20 net/socket.c:1386
> __fput+0x3fd/0xac0 fs/file_table.c:384
> task_work_run+0x14d/0x240 kernel/task_work.c:179
> resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
> exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
> exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
> __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
> syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
> do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> -> #0 (sk_lock-AF_CAN){+.+.}-{0:0}:
> check_prev_add kernel/locking/lockdep.c:3142 [inline]
> check_prevs_add kernel/locking/lockdep.c:3261 [inline]
> validate_chain kernel/locking/lockdep.c:3876 [inline]
> __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
> lock_acquire kernel/locking/lockdep.c:5761 [inline]
> lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
> lock_sock_nested+0x3a/0xf0 net/core/sock.c:3492
> lock_sock include/net/sock.h:1708 [inline]
> raw_bind+0xb1/0xab0 net/can/raw.c:435
> __sys_bind+0x1ec/0x220 net/socket.c:1792
> __do_sys_bind net/socket.c:1803 [inline]
> __se_sys_bind net/socket.c:1801 [inline]
> __x64_sys_bind+0x72/0xb0 net/socket.c:1801
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> other info that might help us debug this:
> 
> Possible unsafe locking scenario:
> 
> CPU0 CPU1
> ---- ----
> lock(rtnl_mutex);
>          lock(sk_lock-AF_CAN);
>          lock(rtnl_mutex);
> lock(sk_lock-AF_CAN);
> 
> *** DEADLOCK ***
> 
> 1 lock held by syz-executor.0/14110:
> 
> stack backtrace:
> CPU: 0 PID: 14110 Comm: syz-executor.0 Not tainted 6.5.0-rc1-syzkaller-00192-g78adb4bcf99e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
> check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2195
> check_prev_add kernel/locking/lockdep.c:3142 [inline]
> check_prevs_add kernel/locking/lockdep.c:3261 [inline]
> validate_chain kernel/locking/lockdep.c:3876 [inline]
> __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
> lock_acquire kernel/locking/lockdep.c:5761 [inline]
> lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
> lock_sock_nested+0x3a/0xf0 net/core/sock.c:3492
> lock_sock include/net/sock.h:1708 [inline]
> raw_bind+0xb1/0xab0 net/can/raw.c:435
> __sys_bind+0x1ec/0x220 net/socket.c:1792
> __do_sys_bind net/socket.c:1803 [inline]
> __se_sys_bind net/socket.c:1801 [inline]
> __x64_sys_bind+0x72/0xb0 net/socket.c:1801
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fd89007cb29
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fd890d2a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
> RAX: ffffffffffffffda RBX: 00007fd89019bf80 RCX: 00007fd89007cb29
> RDX: 0000000000000010 RSI: 0000000020000040 RDI: 0000000000000003
> RBP: 00007fd8900c847a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007fd89019bf80 R15: 00007ffebf8124f8
> </TASK>
> 
> Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: stable@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   net/can/raw.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 2302e48829677334f8b2d74a479e5a9cbb5ce03c..ba6b52b1d7767fdd7b57d1b8e5519495340c572c 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -386,9 +386,9 @@ static int raw_release(struct socket *sock)
>   	list_del(&ro->notifier);
>   	spin_unlock(&raw_notifier_lock);
>   
> +	rtnl_lock();
>   	lock_sock(sk);
>   
> -	rtnl_lock();
>   	/* remove current filters & unregister */
>   	if (ro->bound) {
>   		if (ro->dev)
> @@ -405,12 +405,13 @@ static int raw_release(struct socket *sock)
>   	ro->dev = NULL;
>   	ro->count = 0;
>   	free_percpu(ro->uniq);
> -	rtnl_unlock();
>   
>   	sock_orphan(sk);
>   	sock->sk = NULL;
>   
>   	release_sock(sk);
> +	rtnl_unlock();
> +
>   	sock_put(sk);
>   
>   	return 0;
