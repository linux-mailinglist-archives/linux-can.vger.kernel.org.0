Return-Path: <linux-can+bounces-566-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5268BC645
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 05:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A052B1F2200D
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 03:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8D142062;
	Mon,  6 May 2024 03:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="FzA3AYl0";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="3WmBurrx"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07A1C3D;
	Mon,  6 May 2024 03:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714967190; cv=pass; b=tt9/qp5xdB7IT7RxQAmq5Uqv2snaUKCEoMWK6P1kSO1K1Wz+EbcPWYBih2+qhNAiEPDKDlvQARcwLdWoVMtaciRukGvGBuYaDuD9mwTZUOjCDqUYiFDjQvgYVagBqeVDd849/hHSWGvFSG1zh2AKJGQxKGD7vjOgOet6oiKUCmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714967190; c=relaxed/simple;
	bh=j+apBh2N438frLoKBOmn0eDGI6AF8wQuiePC67TO9Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=XGGBsZnnI2oMiFwDnZtA/Rh5YJk55r8fQcFX92O6jTeYEDNpshMogmKRuaEzvEA2tQUO/u6Ae0OUbXb3cyrVVmRyoB8UGl4jpFjV+fNAxA/DTApYBG3FDHbrpU2RVry4+VxXwaCXJgiimmoHAiOTORBLbhoFNK/B1E5Pd/4sQbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=FzA3AYl0; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=3WmBurrx; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1714966457; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SZ6SdaMPpAM42cY+/3EtR5+ZJxq6Sof6T9mixOOpSzW3+fe42D1Kc9eZrtV0vq3/dt
    qpm6SgAyRD7aRXsrgF6nZOqzCeXKzzBcCd39MW0r2tukOSThOVW6DccgXgh8pD3MVzI9
    Fr7iNSM918EK77rrc2yIMIjF00tTH3S3ABU6uQ81pEDomV+FqTtsj6slbxs7VKA/lrS0
    EikZ/6d3e6qiZB3o4OiE72oSZaVBPQBy+ItdY8mu8admWPNNc03XF/vxqpnQN2VSlfSR
    azsLS0VjG6ooa/uEMrQ8UfN8MGtcW7IE36uRADOpaKAWukA+bp93oo8ICgaVLwbZ+HJk
    zIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1714966457;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Pk97Vo5EVDzQM5Rmi3qC8BLRNsL+4ytAOz0I3pFS7bk=;
    b=oSfv/vaGvwaT/VPb+iqAzQM5MYg7OMHDX7FCbKcGVbxHU2iBpMJTV5QtjsbPC794Y+
    l4GCeus3uzleSSvoYaTHI/Tyr6q2ee6/p5X1kYaIH0mz85lbO60xz4B6XjMz4kCP8OTZ
    uQGi+xod2QHFx7WY9BuBCcUbl9aIk9EgNmsedkB1OX3Ok9A27hSxdYPxGKerUMh5X8Y+
    6D7uHQq27LQ3WCqyF7iTlppG+dw3Z7VPgQy+41Yb9kOpYXKxvvdOtjSBe8ciKEKSJ5k2
    ii4Yvzn8N/BwQcpxl+1neYSZJaz2w7ttcwLoHObNvLNW+agu3O4hh/MUVh9wMJ/Yl0zH
    swyA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1714966457;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Pk97Vo5EVDzQM5Rmi3qC8BLRNsL+4ytAOz0I3pFS7bk=;
    b=FzA3AYl0XVONCQedQtVe+dtn9ckLJBWbSgL8J34G6xGxcevKECdqO9CewV986BYA5w
    F76aYf4vePt4wzEEwq7PF218CfM395kKbvsAn53X7AiMhG/GO5xMwG1poL1IXPc/eT75
    iRcd9K3lpixZCzOujfOV/j7EOKm8HwhsONUws/VkKK+ry/ssRkCiHU2DszbBuPK0ScFj
    UX+Re96/bsh0ULB9lXiRVD6ztZ/IMQuq35+GutKUMykfBit5FXSnJ0JfPR74yI6Ypvq9
    /+bjWnkqlZTJbDaA3LtVfyy0azFP8OIilLYaSprDYUiyy/UQuBm9zaDdbzXcm2Xlq2Dk
    jh9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1714966457;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Pk97Vo5EVDzQM5Rmi3qC8BLRNsL+4ytAOz0I3pFS7bk=;
    b=3WmBurrxUrytiSzU9s2BbYVT8wlnmNQleMMq0mOJJCjUMCQMjY9r/qU3j2XpCxj7PY
    Y8/0gtQQu6hMFf8HmFBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTF1ViO8sG"
Received: from [192.168.20.87]
    by smtp.strato.de (RZmta 50.5.0 DYNA|AUTH)
    with ESMTPSA id Ke140e0463YGeR6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 6 May 2024 05:34:16 +0200 (CEST)
Message-ID: <504913b1-8da4-403e-9ccc-d3eb41595806@hartkopp.net>
Date: Mon, 6 May 2024 05:34:10 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [can?] KMSAN: kernel-infoleak in raw_recvmsg
To: o.rempel@pengutronix.de
References: <0000000000007e4a2e0616fdde23@google.com>
Content-Language: en-US
Cc: syzbot <syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de,
 kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 mkl@pengutronix.de, netdev@vger.kernel.org, pabeni@redhat.com,
 robin@protonic.nl, syzkaller-bugs@googlegroups.com
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <0000000000007e4a2e0616fdde23@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Oleksij,

can this probably be caused by a missing initialization of unused data 
in j1939_sk_alloc_skb()?

Best regards,
Oliver

On 26.04.24 13:04, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    71b1543c83d6 Merge tag '6.9-rc5-ksmbd-fixes' of git://git...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1784bdd7180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=776c05250f36d55c
> dashboard link: https://syzkaller.appspot.com/bug?extid=5681e40d297b30f5b513
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b440d3180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b00907180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/14813ccfbcb3/disk-71b1543c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e7b88b42cf07/vmlinux-71b1543c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3a64a5abfbba/bzImage-71b1543c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
> BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
> BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:29 [inline]
> BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
> BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:271 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x366/0x2520 lib/iov_iter.c:185
>   instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>   copy_to_user_iter lib/iov_iter.c:24 [inline]
>   iterate_ubuf include/linux/iov_iter.h:29 [inline]
>   iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
>   iterate_and_advance include/linux/iov_iter.h:271 [inline]
>   _copy_to_iter+0x366/0x2520 lib/iov_iter.c:185
>   copy_to_iter include/linux/uio.h:196 [inline]
>   memcpy_to_msg include/linux/skbuff.h:4113 [inline]
>   raw_recvmsg+0x2b8/0x9e0 net/can/raw.c:1008
>   sock_recvmsg_nosec net/socket.c:1046 [inline]
>   sock_recvmsg+0x2c4/0x340 net/socket.c:1068
>   ____sys_recvmsg+0x18a/0x620 net/socket.c:2803
>   ___sys_recvmsg+0x223/0x840 net/socket.c:2845
>   do_recvmmsg+0x4fc/0xfd0 net/socket.c:2939
>   __sys_recvmmsg net/socket.c:3018 [inline]
>   __do_sys_recvmmsg net/socket.c:3041 [inline]
>   __se_sys_recvmmsg net/socket.c:3034 [inline]
>   __x64_sys_recvmmsg+0x397/0x490 net/socket.c:3034
>   x64_sys_call+0xf6c/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:300
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>   slab_post_alloc_hook mm/slub.c:3804 [inline]
>   slab_alloc_node mm/slub.c:3845 [inline]
>   kmem_cache_alloc_node+0x613/0xc50 mm/slub.c:3888
>   kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
>   __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
>   alloc_skb include/linux/skbuff.h:1313 [inline]
>   alloc_skb_with_frags+0xc8/0xbf0 net/core/skbuff.c:6504
>   sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2795
>   sock_alloc_send_skb include/net/sock.h:1842 [inline]
>   j1939_sk_alloc_skb net/can/j1939/socket.c:878 [inline]
>   j1939_sk_send_loop net/can/j1939/socket.c:1142 [inline]
>   j1939_sk_sendmsg+0xc0a/0x2730 net/can/j1939/socket.c:1277
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg+0x30f/0x380 net/socket.c:745
>   ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
>   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
>   __sys_sendmsg net/socket.c:2667 [inline]
>   __do_sys_sendmsg net/socket.c:2676 [inline]
>   __se_sys_sendmsg net/socket.c:2674 [inline]
>   __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
>   x64_sys_call+0xc4b/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:47
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Bytes 12-15 of 16 are uninitialized
> Memory access of size 16 starts at ffff888120969690
> Data copied to user address 00000000200017c0
> 
> CPU: 1 PID: 5050 Comm: syz-executor198 Not tainted 6.9.0-rc5-syzkaller-00031-g71b1543c83d6 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> =====================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

