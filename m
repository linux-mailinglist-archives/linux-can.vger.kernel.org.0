Return-Path: <linux-can+bounces-7466-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPJRAjCR92lhjAIAu9opvQ
	(envelope-from <linux-can+bounces-7466-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 03 May 2026 20:17:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 538844B6F0A
	for <lists+linux-can@lfdr.de>; Sun, 03 May 2026 20:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F9BB30087AF
	for <lists+linux-can@lfdr.de>; Sun,  3 May 2026 18:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2693337BE8C;
	Sun,  3 May 2026 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="rq9tBK+B";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="U8fINJou"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D55135A925;
	Sun,  3 May 2026 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777832226; cv=pass; b=XJwsXNeN7V7pAyz+hxab9GrSy1i2frHV3b3dRcE1M4hrNeg9VY5wyMKjWle7FYxAOnNPZD2ji8Pcg4Qa8V2ME8RPv8ZzeBLegPKwKkECSXomSX42vWTYBhka10bNdLxcN0mc8+yrQAzHenNmSVizBOvsvuLjgFIc/Gm+0LVnWrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777832226; c=relaxed/simple;
	bh=Mkh0xJlWoSO/hg+jM7YCo8wjWKcXEJ6KDOK7eC4R5zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQp+c1L0i5vmI99nI1LYZCH6VCbgMUi9y9abZ8WRo7KB8ZVx0Nxr0iFNWTZUAzuPNBP9Kq+k8vZ2TMaOiSUdvhOhuhWvuDTwyffioRPJorxWjXWmYN5GedBmg7udj/mj53L3ElRHaO5DHnuMLLdzKAu6MVSez0OYJDx37skcakM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=rq9tBK+B; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=U8fINJou; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1777831493; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eoN2kc3SrdmOmXQDehITHqUoAqj0BMeEi3qXPRzHnlcwyauqr2nZSAl36fVRxZbq/A
    Cdgn/Sysn8865XjBmKvPg9QrryCVWMTzlIRn/XqS/efzjBQiK2gUnYm5z2X/RZrsgw2v
    9wdIDcak2tVEi8fuwyoycYSKTYHE26/YViI/FoB04Zmo6XbneR5wOJ0h8md2GHY5WFkd
    Q9HPt+NavF26jN4QvHmHzLVWpPoKuYzfoyP76v2zCa+a6Xt4JPVlRrXw4twN28sQEaxS
    +8v5aJeGYUF5lZ+BoicsJ5U7hV85hut6o16vqb2HHzuQ4bnIh3OPVYtCrM1QUOpTPbWE
    I2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1777831493;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aJMK3rjc74j3D67iZDwMBl9nyb09FKwfWPgsUmnjKek=;
    b=qf79cw00h5KsJPNnINcwva0UbhqMo7ynYnm6aum6NLuQCYDihEr0IZU0YcDW9oyNKK
    MjFLTjR7D343BQh72/RhDnrsfFzj4k+ig+2FJkCApRzstRIYvRkzVs65g52unvdQLiT0
    /aCHORW94DblnCT+HOfDP21F1wPls663iAE8Ve4v0ODgmApZnIbWODTfIPEqsE1tCXxU
    YrjaLPXOFIeiKJ0arQILzpa04lOF28UiXnJCQKLbzHeIfI3k/3tL82Zw49R88nDobZgq
    3hnjkuiXD7xR8GPjATbcrbZvTx7qgIkjsy/WJU1c0pUqUeDyOrYidb7meQFJPOp/UvGn
    tSuw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777831493;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aJMK3rjc74j3D67iZDwMBl9nyb09FKwfWPgsUmnjKek=;
    b=rq9tBK+B9teD3lfXDki7g9azDKU506yq1mV6FF9tUKKTHo5CED4KrGmCEY/1IJbwZD
    4xMcDxGbcstYkbSLxQ1l56yy/MJ46RV3wxd7hjPzlJYGsdEkprKJeNeuN/jFIm0wxgL6
    oqhDV+3Z+PJ79nk4SVUQLaUf9wzUJ722hP2Xp/+NfaPcil/5vXXSbd2Ym5s3FHKfmXM0
    Uuh3pMYguERkuKsIfMGXiKBR9IKP9VT2HmY1cREo6s2MZ+FBAGg39bJZA8ZkROCBNOzr
    BbXiOOrKU0/YKZ4VYj4BFmbk0LDKj+85g5CTpr5zm2H0DYVidz/L6OSJOFf7VHzW3mme
    DRow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777831493;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aJMK3rjc74j3D67iZDwMBl9nyb09FKwfWPgsUmnjKek=;
    b=U8fINJoudwidwKU5dYhC2azLLZ479Ju8nCZnVBiBW6U/Xl+LlsMIYzsvCSPmmPRsiI
    LGemUw2hoPn7cLpXGBAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s1YTqptmo87qzm6sElmZEI+VN6rw=="
Received: from [IPV6:2a00:6020:4a38:6800:3499:34c0:1f42:76da]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d243I4qI3n
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 3 May 2026 20:04:52 +0200 (CEST)
Message-ID: <c744de46-14b3-4902-bf36-50492992007f@hartkopp.net>
Date: Sun, 3 May 2026 20:04:46 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] KASAN: slab-use-after-free Read in raw_rcv
To: Eulgyu Kim <eulgyukim@snu.ac.kr>, mkl@pengutronix.de,
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 byoungyoung@snu.ac.kr, jjy600901@snu.ac.kr
References: <20260503112200.22727-1-eulgyukim@snu.ac.kr>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260503112200.22727-1-eulgyukim@snu.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 538844B6F0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7466-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:dkim,hartkopp.net:mid]

Hello Eulgyu Kim,

many thanks for your report! Good catch!

With commit 890e5198a6e5 ("can: raw: use bitfields to store flags in 
struct raw_sock") the flags are now set in a bitfield which allows this 
kind of race condition.

Therefore adding a locking analogue to other sockopt settings and 
analogue to raw_bind() becomes necessary.

Can you confirm that the below patch fixes the issue?

Best regards,
Oliver

diff --git a/net/can/raw.c b/net/can/raw.c
index a26942e78e68..48d1bf297c2c 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -697,49 +697,68 @@ static int raw_setsockopt(struct socket *sock, int 
level, int optname,
  			return -EINVAL;

  		if (copy_from_sockptr(&flag, optval, optlen))
  			return -EFAULT;

+		rtnl_lock();
+		lock_sock(sk);
  		ro->loopback = !!flag;
+		release_sock(sk);
+		rtnl_unlock();
  		break;

  	case CAN_RAW_RECV_OWN_MSGS:
  		if (optlen != sizeof(flag))
  			return -EINVAL;

  		if (copy_from_sockptr(&flag, optval, optlen))
  			return -EFAULT;

+		rtnl_lock();
+		lock_sock(sk);
  		ro->recv_own_msgs = !!flag;
+		release_sock(sk);
+		rtnl_unlock();
  		break;

  	case CAN_RAW_FD_FRAMES:
  		if (optlen != sizeof(flag))
  			return -EINVAL;

  		if (copy_from_sockptr(&flag, optval, optlen))
  			return -EFAULT;

+		rtnl_lock();
+		lock_sock(sk);
  		/* Enabling CAN XL includes CAN FD */
-		if (ro->xl_frames && !flag)
+		if (ro->xl_frames && !flag) {
+			release_sock(sk);
+			rtnl_unlock();
  			return -EINVAL;
+		}

  		ro->fd_frames = !!flag;
+		release_sock(sk);
+		rtnl_unlock();
  		break;

  	case CAN_RAW_XL_FRAMES:
  		if (optlen != sizeof(flag))
  			return -EINVAL;

  		if (copy_from_sockptr(&flag, optval, optlen))
  			return -EFAULT;

+		rtnl_lock();
+		lock_sock(sk);
  		ro->xl_frames = !!flag;

  		/* Enabling CAN XL includes CAN FD */
  		if (ro->xl_frames)
  			ro->fd_frames = ro->xl_frames;
+		release_sock(sk);
+		rtnl_unlock();
  		break;

  	case CAN_RAW_XL_VCID_OPTS:
  		if (optlen != sizeof(ro->raw_vcid_opts))
  			return -EINVAL;
@@ -758,11 +777,15 @@ static int raw_setsockopt(struct socket *sock, int 
level, int optname,
  			return -EINVAL;

  		if (copy_from_sockptr(&flag, optval, optlen))
  			return -EFAULT;

+		rtnl_lock();
+		lock_sock(sk);
  		ro->join_filters = !!flag;
+		release_sock(sk);
+		rtnl_unlock();
  		break;

  	default:
  		return -ENOPROTOOPT;
  	}



On 03.05.26 13:22, Eulgyu Kim wrote:
> Hello,
> 
> We encountered a "KASAN: slab-use-after-free Read in raw_rcv"
> on kernel version v7.1.0-rc1.
> 
> Following is our raw guess of the harmful sequence:
> 1. `raw_bind()` registers a receiver with `can_rx_register(..., raw_rcv, sk, ...)`.
> 2. After the registration succeeds, `raw_bind()` sets `ro->bound = 1`.
> 3. Concurrently, setsockopt(CAN_RAW_JOIN_FILTERS) writes ro->join_filters
> without lock_sock(). Since ro->bound and ro->join_filters share the same
> bitfield storage word, this unlocked bitfield write can lose raw_bind()'s
> update and write the storage word back with bound == 0.
> 4. `close()` enters `raw_release()`, sees `ro->bound == 0`,
> and therefore skips `raw_disable_allfilters()`.
> 5. The CAN receiver registered in step 1 remains on the receive list with
> receiver->data == sk.
> 6. `raw_release()` drops the last socket reference and frees the `struct raw_sock`.
> 7. A later matching CAN frame reaches the stale receiver and calls
> raw_rcv(skb, sk), which dereferences the freed socket, causing the UAF.
> 
> We have included the following items below:
> - C reproducer (~80 lines)
> - KASAN crash log
> 
> The kernel config used is the same as the syzbot configuration,
> and it took less than 10 seconds to trigger the KASAN report
> in our QEMU environment.
> 
> We hope this report helps address the issue. Please let us know
> if any further information is needed.
> 
> Thank you.
> 
> Best Regards,
> Eulgyu Kim
> 
> 
> 
> C reproducer:
> ==================================================================
> #define _GNU_SOURCE
> 
> #include <linux/can.h>
> #include <linux/can/raw.h>
> #include <net/if.h>
> #include <pthread.h>
> #include <sched.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/socket.h>
> #include <unistd.h>
> 
> #ifndef CAN_RAW_JOIN_FILTERS
> #define CAN_RAW_JOIN_FILTERS 6
> #endif
> 
> static struct sockaddr_can vcan0 = {
> 	.can_family = AF_CAN,
> };
> 
> static void *sender(void *arg)
> {
> 	struct can_frame frame = {
> 		.can_dlc = 3,
> 		.data = { [2] = 0x10 },
> 	};
> 	int fd = socket(PF_CAN, SOCK_RAW, CAN_RAW);
> 
> 	for (;;)
> 		sendto(fd, &frame, sizeof(frame), 0, (struct sockaddr *)&vcan0, sizeof(vcan0));
> }
> 
> static void *bind_fd(void *arg)
> {
> 	bind((int)(long)arg, (struct sockaddr *)&vcan0, sizeof(vcan0));
> }
> 
> static void *racer(void *arg)
> {
> 	for (;;) {
> 		pthread_t th;
> 		int fd = socket(PF_CAN, SOCK_RAW, CAN_RAW);
> 		int one = 1;
> 
> 		pthread_create(&th, NULL, bind_fd, (void *)(long)fd);
> 		sched_yield();
> 		setsockopt(fd, SOL_CAN_RAW, CAN_RAW_JOIN_FILTERS, &one, sizeof(one));
> 		close(fd);
> 		pthread_join(th, NULL);
> 	}
> }
> 
> int main(void)
> {
> 	pthread_t th;
> 
> 	system("modprobe vcan >/dev/null 2>&1");
> 	system("ip link add dev vcan0 type vcan >/dev/null 2>&1");
> 	system("ip link set dev vcan0 up >/dev/null 2>&1");
> 
> 	vcan0.can_ifindex = if_nametoindex("vcan0");
> 	if (!vcan0.can_ifindex) {
> 		fprintf(stderr, "failed to set up vcan0\n");
> 		return 1;
> 	}
> 
> 	pthread_create(&th, NULL, sender, NULL);
> 	for (int i = 0; i < 8; i++)
> 		pthread_create(&th, NULL, racer, NULL);
> 
> 	pthread_join(th, NULL);
> 	return 0;
> }
> 
> ==================================================================
> 
> 
> 
> KASAN crash log:
> ==================================================================
> BUG: KASAN: slab-use-after-free in raw_rcv+0x9e6/0xd40 net/can/raw.c:139
> Read of size 1 at addr ff110001181f659c by task main/9522
> CPU: 2 UID: 0 PID: 9522 Comm: main Not tainted 7.1.0-rc1-gf1a5e78a55eb #8 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>   <IRQ>
>   dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>   print_address_description+0x55/0x1e0 mm/kasan/report.c:378
>   print_report+0x64/0x70 mm/kasan/report.c:482
>   kasan_report+0x118/0x150 mm/kasan/report.c:595
>   raw_rcv+0x9e6/0xd40 net/can/raw.c:139
>   deliver net/can/af_can.c:575 [inline]
>   can_rcv_filter+0x126/0x7a0 net/can/af_can.c:602
>   can_receive+0x2c6/0x440 net/can/af_can.c:674
>   can_rcv+0x1f9/0x330 net/can/af_can.c:699
>   __netif_receive_skb_one_core net/core/dev.c:6202 [inline]
>   __netif_receive_skb net/core/dev.c:6315 [inline]
>   process_backlog+0xc67/0x1960 net/core/dev.c:6666
>   __napi_poll+0xae/0x340 net/core/dev.c:7730
>   napi_poll net/core/dev.c:7793 [inline]
>   net_rx_action+0x5d7/0xf50 net/core/dev.c:7950
>   handle_softirqs+0x22b/0x850 kernel/softirq.c:622
>   do_softirq+0x76/0xd0 kernel/softirq.c:523
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
>   local_bh_enable include/linux/bottom_half.h:33 [inline]
>   netif_rx+0x83/0x90 net/core/dev.c:5775
>   can_send+0x978/0xd00 net/can/af_can.c:289
>   raw_sendmsg+0xbd7/0xfe0 net/can/raw.c:1008
>   sock_sendmsg_nosec net/socket.c:787 [inline]
>   __sock_sendmsg net/socket.c:802 [inline]
>   __sys_sendto+0x5dc/0x680 net/socket.c:2265
>   __do_sys_sendto net/socket.c:2272 [inline]
>   __se_sys_sendto net/socket.c:2268 [inline]
>   __x64_sys_sendto+0xde/0x100 net/socket.c:2268
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x16e/0xf80 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x44ee46
> Code: 9d 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 41 89 c4 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 3a 44 89 e7 48 89 44 24 08 e8 35 9d 02 00 48
> RSP: 002b:00007fc8252d7150 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 00007fc8252d7640 RCX: 000000000044ee46
> RDX: 0000000000000010 RSI: 00007fc8252d71b0 RDI: 0000000000000003
> RBP: 00007fc8252d71d0 R08: 00000000004e2110 R09: 0000000000000018
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000415170 R15: 00007fc824ad7000
>   </TASK>
> Allocated by task 9523:
>   kasan_save_stack mm/kasan/common.c:57 [inline]
>   kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>   poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
>   __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
>   kasan_kmalloc include/linux/kasan.h:263 [inline]
>   __do_kmalloc_node mm/slub.c:5295 [inline]
>   __kmalloc_noprof+0x361/0x770 mm/slub.c:5307
>   kmalloc_noprof include/linux/slab.h:954 [inline]
>   sk_prot_alloc+0xe7/0x220 net/core/sock.c:2247
>   sk_alloc+0x3a/0x390 net/core/sock.c:2303
>   can_create+0x1ca/0x5d0 net/can/af_can.c:158
>   __sock_create+0x4b3/0x9d0 net/socket.c:1664
>   sock_create net/socket.c:1722 [inline]
>   __sys_socket_create net/socket.c:1759 [inline]
>   __sys_socket+0xd7/0x1b0 net/socket.c:1806
>   __do_sys_socket net/socket.c:1820 [inline]
>   __se_sys_socket net/socket.c:1818 [inline]
>   __x64_sys_socket+0x7a/0x90 net/socket.c:1818
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x16e/0xf80 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Freed by task 27894:
>   kasan_save_stack mm/kasan/common.c:57 [inline]
>   kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>   kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
>   poison_slab_object mm/kasan/common.c:253 [inline]
>   __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
>   kasan_slab_free include/linux/kasan.h:235 [inline]
>   slab_free_hook mm/slub.c:2689 [inline]
>   slab_free mm/slub.c:6246 [inline]
>   kfree+0x1c7/0x650 mm/slub.c:6561
>   sk_prot_free net/core/sock.c:2286 [inline]
>   __sk_destruct+0x748/0x9d0 net/core/sock.c:2386
>   sock_put include/net/sock.h:2010 [inline]
>   raw_release+0x84c/0x9f0 net/can/raw.c:458
>   __sock_release net/socket.c:722 [inline]
>   sock_close+0xc3/0x240 net/socket.c:1514
>   __fput+0x44c/0xa60 fs/file_table.c:510
>   task_work_run+0x1d4/0x260 kernel/task_work.c:233
>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>   __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
>   exit_to_user_mode_loop+0xef/0x4e0 kernel/entry/common.c:98
>   __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
>   syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
>   syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
>   do_syscall_64+0x34d/0xf80 arch/x86/entry/syscall_64.c:100
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> The buggy address belongs to the object at ff110001181f6000
>   which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 1436 bytes inside of
>   freed 2048-byte region [ff110001181f6000, ff110001181f6800)
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1181f0
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0x17ff00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 017ff00000000040 ff11000100038f00 dead000000000100 dead000000000122
> raw: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
> head: 017ff00000000040 ff11000100038f00 dead000000000100 dead000000000122
> head: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
> head: 017ff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 9526, tgid 9511 (main), ts 138366918843, free_ts 137562029882
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x23d/0x2a0 mm/page_alloc.c:1858
>   prep_new_page mm/page_alloc.c:1866 [inline]
>   get_page_from_freelist+0x24be/0x2540 mm/page_alloc.c:3946
>   __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5226
>   alloc_slab_page mm/slub.c:3278 [inline]
>   allocate_slab+0x77/0x680 mm/slub.c:3467
>   new_slab mm/slub.c:3525 [inline]
>   refill_objects+0x342/0x3d0 mm/slub.c:7251
>   refill_sheaf mm/slub.c:2816 [inline]
>   __pcs_replace_empty_main+0x323/0x730 mm/slub.c:4651
>   alloc_from_pcs mm/slub.c:4749 [inline]
>   slab_alloc_node mm/slub.c:4883 [inline]
>   __do_kmalloc_node mm/slub.c:5294 [inline]
>   __kmalloc_noprof+0x473/0x770 mm/slub.c:5307
>   kmalloc_noprof include/linux/slab.h:954 [inline]
>   sk_prot_alloc+0xe7/0x220 net/core/sock.c:2247
>   sk_alloc+0x3a/0x390 net/core/sock.c:2303
>   can_create+0x1ca/0x5d0 net/can/af_can.c:158
>   __sock_create+0x4b3/0x9d0 net/socket.c:1664
>   sock_create net/socket.c:1722 [inline]
>   __sys_socket_create net/socket.c:1759 [inline]
>   __sys_socket+0xd7/0x1b0 net/socket.c:1806
>   __do_sys_socket net/socket.c:1820 [inline]
>   __se_sys_socket net/socket.c:1818 [inline]
>   __x64_sys_socket+0x7a/0x90 net/socket.c:1818
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x16e/0xf80 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 54 tgid 54 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   __free_pages_prepare mm/page_alloc.c:1402 [inline]
>   __free_frozen_pages+0xbdb/0xd50 mm/page_alloc.c:2943
>   vfree+0x1d1/0x2f0 mm/vmalloc.c:3472
>   delayed_vfree_work+0x55/0x80 mm/vmalloc.c:3392
>   process_one_work kernel/workqueue.c:3302 [inline]
>   process_scheduled_works+0xb4b/0x1840 kernel/workqueue.c:3385
>   worker_thread+0xa54/0xfc0 kernel/workqueue.c:3466
>   kthread+0x389/0x480 kernel/kthread.c:436
>   ret_from_fork+0x509/0xb70 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> Memory state around the buggy address:
>   ff110001181f6480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ff110001181f6500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ff110001181f6580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                              ^
>   ff110001181f6600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ff110001181f6680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================


