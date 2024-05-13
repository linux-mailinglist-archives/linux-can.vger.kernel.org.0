Return-Path: <linux-can+bounces-634-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD048C3BC4
	for <lists+linux-can@lfdr.de>; Mon, 13 May 2024 09:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF6F1F2103D
	for <lists+linux-can@lfdr.de>; Mon, 13 May 2024 07:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097CD146A76;
	Mon, 13 May 2024 07:14:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CC11FA1
	for <linux-can@vger.kernel.org>; Mon, 13 May 2024 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715584479; cv=none; b=UylFzxbvLSGB9v4q4Vg8JWbfSxNHD0Mbbra/9m6jXGe3S+1GpjMXWOVZ0hOjckJ+eXH4zUZpmGwoPjQCT+Pr6Kt8akY7dFRaMGmXWoanUsKQxSplpMdPVUS3JjpSUO18NTsMOpnkxM0o/MRzawc16rK5a/Xd2D2WuGGXsrjWPuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715584479; c=relaxed/simple;
	bh=suY7gdj5WEzlYkeyc21b5k/5NgIk2dmm7ryt+mMo7mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQyAn6gjTUXRaXNfedf8qsxjo3D9YN65PSTnC37F67sMD1XWCEWov3L7V8Av5M8szSb+GrUacDFd6AOOghtvlxMwUUEOTJRQSG0yZViDyh2HC9H/i+Qz+EiQYoE/PLunX0ewthdnWlBtMRddWcGcCfgc2cFy/yRpMMeM+JiCuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s6Pt9-0001Jd-LQ; Mon, 13 May 2024 09:14:23 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s6Pt7-0017rX-OP; Mon, 13 May 2024 09:14:21 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s6Pt7-009OQ9-24;
	Mon, 13 May 2024 09:14:21 +0200
Date: Mon, 13 May 2024 09:14:21 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
	mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com
Subject: Re: [PATCH] can: j1939: Initialize unused data in j1939_send_one()
Message-ID: <ZkG9zbYwd0BL7B2r@pengutronix.de>
References: <20240512160307.2604215-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240512160307.2604215-1-syoshida@redhat.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hi,

On Mon, May 13, 2024 at 01:03:07AM +0900, Shigeru Yoshida wrote:
> syzbot reported kernel-infoleak in raw_recvmsg() [1]. j1939_send_one()
> creates full frame including unused data, but it doesn't initialize it.
> This causes the kernel-infoleak issue. Fix this by initializing unused
> data.
> 
> [1]
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
> BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
> BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:29 [inline]
> BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
> BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:271 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x366/0x2520 lib/iov_iter.c:185
>  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>  copy_to_user_iter lib/iov_iter.c:24 [inline]
>  iterate_ubuf include/linux/iov_iter.h:29 [inline]
>  iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
>  iterate_and_advance include/linux/iov_iter.h:271 [inline]
>  _copy_to_iter+0x366/0x2520 lib/iov_iter.c:185
>  copy_to_iter include/linux/uio.h:196 [inline]
>  memcpy_to_msg include/linux/skbuff.h:4113 [inline]
>  raw_recvmsg+0x2b8/0x9e0 net/can/raw.c:1008
>  sock_recvmsg_nosec net/socket.c:1046 [inline]
>  sock_recvmsg+0x2c4/0x340 net/socket.c:1068
>  ____sys_recvmsg+0x18a/0x620 net/socket.c:2803
>  ___sys_recvmsg+0x223/0x840 net/socket.c:2845
>  do_recvmmsg+0x4fc/0xfd0 net/socket.c:2939
>  __sys_recvmmsg net/socket.c:3018 [inline]
>  __do_sys_recvmmsg net/socket.c:3041 [inline]
>  __se_sys_recvmmsg net/socket.c:3034 [inline]
>  __x64_sys_recvmmsg+0x397/0x490 net/socket.c:3034
>  x64_sys_call+0xf6c/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:300
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:3804 [inline]
>  slab_alloc_node mm/slub.c:3845 [inline]
>  kmem_cache_alloc_node+0x613/0xc50 mm/slub.c:3888
>  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
>  __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
>  alloc_skb include/linux/skbuff.h:1313 [inline]
>  alloc_skb_with_frags+0xc8/0xbf0 net/core/skbuff.c:6504
>  sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2795
>  sock_alloc_send_skb include/net/sock.h:1842 [inline]
>  j1939_sk_alloc_skb net/can/j1939/socket.c:878 [inline]
>  j1939_sk_send_loop net/can/j1939/socket.c:1142 [inline]
>  j1939_sk_sendmsg+0xc0a/0x2730 net/can/j1939/socket.c:1277
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x30f/0x380 net/socket.c:745
>  ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
>  __sys_sendmsg net/socket.c:2667 [inline]
>  __do_sys_sendmsg net/socket.c:2676 [inline]
>  __se_sys_sendmsg net/socket.c:2674 [inline]
>  __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
>  x64_sys_call+0xc4b/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:47
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Bytes 12-15 of 16 are uninitialized
> Memory access of size 16 starts at ffff888120969690
> Data copied to user address 00000000200017c0
> 
> CPU: 1 PID: 5050 Comm: syz-executor198 Not tainted 6.9.0-rc5-syzkaller-00031-g71b1543c83d6 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> 
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Reported-and-tested-by: syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5681e40d297b30f5b513
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Thank you for your investigation!

> ---
>  net/can/j1939/main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index a6fb89fa6278..df01628c6509 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -344,6 +344,9 @@ int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb)
>  	/* make it a full can frame again */
>  	skb_put(skb, J1939_CAN_FTR + (8 - dlc));
>  
> +	/* initialize unused data  */
> +	memset(cf->data + dlc, 0, 8 - dlc);
> +
>  	canid = CAN_EFF_FLAG |
>  		(skcb->priority << 26) |
>  		(skcb->addr.pgn << 8) |
> -- 
> 2.44.0

Can you please change it to:

--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -30,10 +30,6 @@ MODULE_ALIAS("can-proto-" __stringify(CAN_J1939));
 /* CAN_HDR: #bytes before can_frame data part */
 #define J1939_CAN_HDR (offsetof(struct can_frame, data))
 
-/* CAN_FTR: #bytes beyond data part */
-#define J1939_CAN_FTR (sizeof(struct can_frame) - J1939_CAN_HDR - \
-		 sizeof(((struct can_frame *)0)->data))
-
 /* lowest layer */
 static void j1939_can_recv(struct sk_buff *iskb, void *data)
 {
@@ -342,7 +338,7 @@ int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb)
 	memset(cf, 0, J1939_CAN_HDR);
 
 	/* make it a full can frame again */
-	skb_put(skb, J1939_CAN_FTR + (8 - dlc));
+	skb_put_zero(skb, 8 - dlc);
 
 	canid = CAN_EFF_FLAG |
 		(skcb->priority << 26) |

With this change included, you can add my:
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

