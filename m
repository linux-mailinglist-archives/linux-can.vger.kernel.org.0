Return-Path: <linux-can+bounces-5831-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6388DCAF7D1
	for <lists+linux-can@lfdr.de>; Tue, 09 Dec 2025 10:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37E6B30384AC
	for <lists+linux-can@lfdr.de>; Tue,  9 Dec 2025 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B745A23AE87;
	Tue,  9 Dec 2025 09:43:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2DE25EFAE
	for <linux-can@vger.kernel.org>; Tue,  9 Dec 2025 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765273426; cv=none; b=PApEMktHQF8U9TMSkJ4PgjzVhQ7t5kOqVuWcxx4osVWkQ+yhu9qUb2hhLu+JqVsvClmYZqucHt3dnSDOgB1KMRPL68O7NZeGMHjHeYDSl3u7Sb7SL04BejfUyoswXDP2E2dWw1l8Ud4skmMJFez7ryPs2rrVIS/uBbkUIXOM0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765273426; c=relaxed/simple;
	bh=YL1Y/bMHPG9LLUwI/y90JdHPMqrmlp9JqBv5Yzlli1Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=GnyHKgU0DhAdR9Ii2JcBNqxYqp5EHpoLmFbpoiv2K4MjTUIYZonTcRtlRTsdRufApavtmHgi0kW5t8889Pg/9WMZRS3XdfLXAIama71xcC8Fu24DQZkIBZJ6RsH/lyCZ6MOKdYpXZkM9WMYiwxjkD6gfYGnnE+isM5XQPRbjXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5B99hCWw046465;
	Tue, 9 Dec 2025 18:43:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5B99hCoN046460
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 9 Dec 2025 18:43:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <33947a8d-18b2-4aa1-a4f5-5d90c4619b65@I-love.SAKURA.ne.jp>
Date: Tue, 9 Dec 2025 18:43:12 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: j1939: make j1939_session_activate() fail if device
 is no longer registered
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <b9653191-d479-4c8b-8536-1326d028db5c@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <b9653191-d479-4c8b-8536-1326d028db5c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav302.rs.sakura.ne.jp
X-Virus-Status: clean

Ping?

On 2025/11/25 22:39, Tetsuo Handa wrote:
> Should we also make j1939_sk_queue_activate_next_locked() and
> j1939_xtp_rx_rts_session_new() not to emit bogus warning message?
linux-next-20251208 has gotten a trace with
j1939_sk_queue_activate_next_locked() and j1939_xtp_rx_rts_session_new().
Do we want to make these functions not to emit bogus warning message?

> Is this error case rare enough to tolerate bogus warning message?



unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
Call trace for vcan0@ffff888086898000 +1 at
     j1939_priv_create net/can/j1939/main.c:148 [inline]
     j1939_netdev_start+0x1de/0xa30 net/can/j1939/main.c:280
     j1939_sk_bind+0x926/0xca0 net/can/j1939/socket.c:498
     __sys_bind_socket net/socket.c:1889 [inline]
     __sys_bind+0x2c6/0x3e0 net/socket.c:1920
Call trace for vcan0@ffff888086898000 +1 at
     j1939_priv_get net/can/j1939/main.c:189 [inline]
     j1939_can_rx_register net/can/j1939/main.c:197 [inline]
     j1939_netdev_start+0x615/0xa30 net/can/j1939/main.c:303
     j1939_sk_bind+0x926/0xca0 net/can/j1939/socket.c:498
     __sys_bind_socket net/socket.c:1889 [inline]
     __sys_bind+0x2c6/0x3e0 net/socket.c:1920
Call trace for vcan0@ffff888086898000 +1 at
     j1939_sk_bind+0xa02/0xca0 net/can/j1939/socket.c:510
     __sys_bind_socket net/socket.c:1889 [inline]
     __sys_bind+0x2c6/0x3e0 net/socket.c:1920
Call trace for vcan0@ffff888086898000 +1 at
     j1939_jsk_add net/can/j1939/socket.c:81 [inline]
     j1939_sk_bind+0x769/0xca0 net/can/j1939/socket.c:530
     __sys_bind_socket net/socket.c:1889 [inline]
     __sys_bind+0x2c6/0x3e0 net/socket.c:1920
Call trace for vcan0@ffff888086898000 +2 at
     j1939_session_new+0x12c/0x460 net/can/j1939/transport.c:1504
     j1939_tp_send+0x338/0x8c0 net/can/j1939/transport.c:2021
     j1939_sk_send_loop net/can/j1939/socket.c:1159 [inline]
     j1939_sk_sendmsg+0xaf8/0x1350 net/can/j1939/socket.c:1282
     sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
Call trace for vcan0@ffff888086898000 +2 at
     j1939_session_new+0x134/0x460 net/can/j1939/transport.c:1506
     j1939_tp_send+0x338/0x8c0 net/can/j1939/transport.c:2021
     j1939_sk_send_loop net/can/j1939/socket.c:1159 [inline]
     j1939_sk_sendmsg+0xaf8/0x1350 net/can/j1939/socket.c:1282
     sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
Call trace for vcan0@ffff888086898000 +2 at
     j1939_sk_queue_session net/can/j1939/socket.c:105 [inline]
     j1939_sk_send_loop net/can/j1939/socket.c:1164 [inline]
     j1939_sk_sendmsg+0xb7a/0x1350 net/can/j1939/socket.c:1282
     sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
     __sock_sendmsg net/socket.c:752 [inline]
     ____sys_sendmsg+0x577/0x880 net/socket.c:2610
     ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2664
     __sys_sendmsg net/socket.c:2696 [inline]
     __do_sys_sendmsg net/socket.c:2701 [inline]
     __se_sys_sendmsg net/socket.c:2699 [inline]
     __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2699
     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
     do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
Call trace for vcan0@ffff888086898000 +1 at
     j1939_session_get net/can/j1939/transport.c:249 [inline]
     j1939_session_activate+0x254/0x3f0 net/can/j1939/transport.c:1577
     j1939_sk_send_loop net/can/j1939/socket.c:1168 [inline]
     j1939_sk_sendmsg+0xcc7/0x1350 net/can/j1939/socket.c:1282
     sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
     __sock_sendmsg net/socket.c:752 [inline]
     ____sys_sendmsg+0x577/0x880 net/socket.c:2610
     ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2664
     __sys_sendmsg net/socket.c:2696 [inline]
     __do_sys_sendmsg net/socket.c:2701 [inline]
     __se_sys_sendmsg net/socket.c:2699 [inline]
     __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2699
     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
     do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
Call trace for vcan0@ffff888086898000 +1 at
     j1939_session_get net/can/j1939/transport.c:249 [inline]
     j1939_tp_schedule_txtimer+0x87/0xd0 net/can/j1939/transport.c:704
     j1939_sk_send_loop net/can/j1939/socket.c:1169 [inline]
     j1939_sk_sendmsg+0xcf3/0x1350 net/can/j1939/socket.c:1282
     sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
Call trace for vcan0@ffff888086898000 +2 at
     j1939_session_get net/can/j1939/transport.c:249 [inline]
     j1939_tp_schedule_txtimer net/can/j1939/transport.c:704 [inline]
     j1939_session_tx_rts net/can/j1939/transport.c:754 [inline]
     j1939_xtp_txnext_transmiter net/can/j1939/transport.c:888 [inline]
     j1939_tp_txtimer+0xefb/0x28c0 net/can/j1939/transport.c:1163
     __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
     __hrtimer_run_queues+0x51c/0xc30 kernel/time/hrtimer.c:1841
     hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 +2 at
     j1939_session_get net/can/j1939/transport.c:249 [inline]
     j1939_tp_set_rxtimeout net/can/j1939/transport.c:713 [inline]
     j1939_session_tx_rts net/can/j1939/transport.c:755 [inline]
     j1939_xtp_txnext_transmiter net/can/j1939/transport.c:888 [inline]
     j1939_tp_txtimer+0x1e40/0x28c0 net/can/j1939/transport.c:1163
     __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
     __hrtimer_run_queues+0x51c/0xc30 kernel/time/hrtimer.c:1841
     hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 -4 at
     j1939_session_put+0x47/0x480 net/can/j1939/transport.c:300
     j1939_tp_txtimer+0x1a9f/0x28c0 net/can/j1939/transport.c:1209
     __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
     __hrtimer_run_queues+0x51c/0xc30 kernel/time/hrtimer.c:1841
     hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 +2 at
     j1939_priv_get net/can/j1939/main.c:189 [inline]
     j1939_can_recv+0x17f/0xa30 net/can/j1939/main.c:54
     deliver net/can/af_can.c:575 [inline]
     can_rcv_filter+0x357/0x7d0 net/can/af_can.c:609
     can_receive+0x312/0x450 net/can/af_can.c:666
     can_rcv+0x145/0x270 net/can/af_can.c:690
     __netif_receive_skb_one_core net/core/dev.c:6138 [inline]
     __netif_receive_skb+0x164/0x380 net/core/dev.c:6251
     process_backlog+0x622/0x1500 net/core/dev.c:6603
     __napi_poll+0xae/0x320 net/core/dev.c:7667
     napi_poll net/core/dev.c:7730 [inline]
     net_rx_action+0x672/0xe50 net/core/dev.c:7882
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 +2 at
     j1939_session_get net/can/j1939/transport.c:249 [inline]
     j1939_session_get_by_addr_locked+0x169/0x730 net/can/j1939/transport.c:526
     j1939_session_get_by_addr net/can/j1939/transport.c:565 [inline]
     j1939_xtp_rx_rts+0x120/0x1910 net/can/j1939/transport.c:1730
     j1939_tp_cmd_recv net/can/j1939/transport.c:2074 [inline]
     j1939_tp_recv+0xb24/0x1040 net/can/j1939/transport.c:2161
     j1939_can_recv+0x6a0/0xa30 net/can/j1939/main.c:108
     deliver net/can/af_can.c:575 [inline]
     can_rcv_filter+0x357/0x7d0 net/can/af_can.c:609
     can_receive+0x312/0x450 net/can/af_can.c:666
     can_rcv+0x145/0x270 net/can/af_can.c:690
     __netif_receive_skb_one_core net/core/dev.c:6138 [inline]
     __netif_receive_skb+0x164/0x380 net/core/dev.c:6251
     process_backlog+0x622/0x1500 net/core/dev.c:6603
     __napi_poll+0xae/0x320 net/core/dev.c:7667
     napi_poll net/core/dev.c:7730 [inline]
     net_rx_action+0x672/0xe50 net/core/dev.c:7882
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 -1 at
     j1939_session_put+0x47/0x480 net/can/j1939/transport.c:300
     j1939_session_get_by_addr_locked+0x23a/0x730 net/can/j1939/transport.c:530
     j1939_session_get_by_addr net/can/j1939/transport.c:565 [inline]
     j1939_xtp_rx_rts+0x120/0x1910 net/can/j1939/transport.c:1730
     j1939_tp_cmd_recv net/can/j1939/transport.c:2074 [inline]
     j1939_tp_recv+0xb24/0x1040 net/can/j1939/transport.c:2161
     j1939_can_recv+0x6a0/0xa30 net/can/j1939/main.c:108
     deliver net/can/af_can.c:575 [inline]
     can_rcv_filter+0x357/0x7d0 net/can/af_can.c:609
     can_receive+0x312/0x450 net/can/af_can.c:666
     can_rcv+0x145/0x270 net/can/af_can.c:690
     __netif_receive_skb_one_core net/core/dev.c:6138 [inline]
     __netif_receive_skb+0x164/0x380 net/core/dev.c:6251
     process_backlog+0x622/0x1500 net/core/dev.c:6603
     __napi_poll+0xae/0x320 net/core/dev.c:7667
     napi_poll net/core/dev.c:7730 [inline]
     net_rx_action+0x672/0xe50 net/core/dev.c:7882
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 +1 at
     j1939_session_new+0x12c/0x460 net/can/j1939/transport.c:1504
     j1939_session_fresh_new net/can/j1939/transport.c:1546 [inline]
     j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1631 [inline]
     j1939_xtp_rx_rts+0xd82/0x1910 net/can/j1939/transport.c:1752
     j1939_tp_cmd_recv net/can/j1939/transport.c:2074 [inline]
     j1939_tp_recv+0xb24/0x1040 net/can/j1939/transport.c:2161
     j1939_can_recv+0x6a0/0xa30 net/can/j1939/main.c:108
     deliver net/can/af_can.c:575 [inline]
     can_rcv_filter+0x357/0x7d0 net/can/af_can.c:609
     can_receive+0x312/0x450 net/can/af_can.c:666
     can_rcv+0x145/0x270 net/can/af_can.c:690
     __netif_receive_skb_one_core net/core/dev.c:6138 [inline]
     __netif_receive_skb+0x164/0x380 net/core/dev.c:6251
     process_backlog+0x622/0x1500 net/core/dev.c:6603
     __napi_poll+0xae/0x320 net/core/dev.c:7667
     napi_poll net/core/dev.c:7730 [inline]
     net_rx_action+0x672/0xe50 net/core/dev.c:7882
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 +1 at
     j1939_session_new+0x134/0x460 net/can/j1939/transport.c:1506
     j1939_session_fresh_new net/can/j1939/transport.c:1546 [inline]
     j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1631 [inline]
     j1939_xtp_rx_rts+0xd82/0x1910 net/can/j1939/transport.c:1752
     j1939_tp_cmd_recv net/can/j1939/transport.c:2074 [inline]
     j1939_tp_recv+0xb24/0x1040 net/can/j1939/transport.c:2161
     j1939_can_recv+0x6a0/0xa30 net/can/j1939/main.c:108
     deliver net/can/af_can.c:575 [inline]
     can_rcv_filter+0x357/0x7d0 net/can/af_can.c:609
     can_receive+0x312/0x450 net/can/af_can.c:666
     can_rcv+0x145/0x270 net/can/af_can.c:690
     __netif_receive_skb_one_core net/core/dev.c:6138 [inline]
     __netif_receive_skb+0x164/0x380 net/core/dev.c:6251
     process_backlog+0x622/0x1500 net/core/dev.c:6603
     __napi_poll+0xae/0x320 net/core/dev.c:7667
     napi_poll net/core/dev.c:7730 [inline]
     net_rx_action+0x672/0xe50 net/core/dev.c:7882
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 +1 at
     j1939_session_get net/can/j1939/transport.c:249 [inline]
     j1939_session_get_by_addr_locked+0x169/0x730 net/can/j1939/transport.c:526
     j1939_session_activate+0xb4/0x3f0 net/can/j1939/transport.c:1566
     j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1656 [inline]
     j1939_xtp_rx_rts+0x111e/0x1910 net/can/j1939/transport.c:1752
     j1939_tp_cmd_recv net/can/j1939/transport.c:2074 [inline]
     j1939_tp_recv+0xb24/0x1040 net/can/j1939/transport.c:2161
     j1939_can_recv+0x6a0/0xa30 net/can/j1939/main.c:108
     deliver net/can/af_can.c:575 [inline]
     can_rcv_filter+0x357/0x7d0 net/can/af_can.c:609
     can_receive+0x312/0x450 net/can/af_can.c:666
     can_rcv+0x145/0x270 net/can/af_can.c:690
     __netif_receive_skb_one_core net/core/dev.c:6138 [inline]
     __netif_receive_skb+0x164/0x380 net/core/dev.c:6251
     process_backlog+0x622/0x1500 net/core/dev.c:6603
     __napi_poll+0xae/0x320 net/core/dev.c:7667
     napi_poll net/core/dev.c:7730 [inline]
     net_rx_action+0x672/0xe50 net/core/dev.c:7882
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 -1 at
     j1939_session_put+0x47/0x480 net/can/j1939/transport.c:300
     j1939_session_get_by_addr_locked+0x23a/0x730 net/can/j1939/transport.c:530
     j1939_session_activate+0xb4/0x3f0 net/can/j1939/transport.c:1566
     j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1656 [inline]
     j1939_xtp_rx_rts+0x111e/0x1910 net/can/j1939/transport.c:1752
     j1939_tp_cmd_recv net/can/j1939/transport.c:2074 [inline]
     j1939_tp_recv+0xb24/0x1040 net/can/j1939/transport.c:2161
     j1939_can_recv+0x6a0/0xa30 net/can/j1939/main.c:108
     deliver net/can/af_can.c:575 [inline]
     can_rcv_filter+0x357/0x7d0 net/can/af_can.c:609
     can_receive+0x312/0x450 net/can/af_can.c:666
     can_rcv+0x145/0x270 net/can/af_can.c:690
     __netif_receive_skb_one_core net/core/dev.c:6138 [inline]
     __netif_receive_skb+0x164/0x380 net/core/dev.c:6251
     process_backlog+0x622/0x1500 net/core/dev.c:6603
     __napi_poll+0xae/0x320 net/core/dev.c:7667
     napi_poll net/core/dev.c:7730 [inline]
     net_rx_action+0x672/0xe50 net/core/dev.c:7882
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 +1 at
     j1939_session_get net/can/j1939/transport.c:249 [inline]
     j1939_session_activate+0x254/0x3f0 net/can/j1939/transport.c:1577
     j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1656 [inline]
     j1939_xtp_rx_rts+0x111e/0x1910 net/can/j1939/transport.c:1752
     j1939_tp_cmd_recv net/can/j1939/transport.c:2074 [inline]
     j1939_tp_recv+0xb24/0x1040 net/can/j1939/transport.c:2161
     j1939_can_recv+0x6a0/0xa30 net/can/j1939/main.c:108
     deliver net/can/af_can.c:575 [inline]
     can_rcv_filter+0x357/0x7d0 net/can/af_can.c:609
     can_receive+0x312/0x450 net/can/af_can.c:666
     can_rcv+0x145/0x270 net/can/af_can.c:690
     __netif_receive_skb_one_core net/core/dev.c:6138 [inline]
     __netif_receive_skb+0x164/0x380 net/core/dev.c:6251
     process_backlog+0x622/0x1500 net/core/dev.c:6603
     __napi_poll+0xae/0x320 net/core/dev.c:7667
     napi_poll net/core/dev.c:7730 [inline]
     net_rx_action+0x672/0xe50 net/core/dev.c:7882
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 +1 at
     j1939_session_get net/can/j1939/transport.c:249 [inline]
     j1939_tp_set_rxtimeout net/can/j1939/transport.c:713 [inline]
     j1939_xtp_rx_rts+0x75b/0x1910 net/can/j1939/transport.c:1769
     j1939_tp_cmd_recv net/can/j1939/transport.c:2074 [inline]
     j1939_tp_recv+0xb24/0x1040 net/can/j1939/transport.c:2161
     j1939_can_recv+0x6a0/0xa30 net/can/j1939/main.c:108
     deliver net/can/af_can.c:575 [inline]
     can_rcv_filter+0x357/0x7d0 net/can/af_can.c:609
     can_receive+0x312/0x450 net/can/af_can.c:666
     can_rcv+0x145/0x270 net/can/af_can.c:690
     __netif_receive_skb_one_core net/core/dev.c:6138 [inline]
     __netif_receive_skb+0x164/0x380 net/core/dev.c:6251
     process_backlog+0x622/0x1500 net/core/dev.c:6603
     __napi_poll+0xae/0x320 net/core/dev.c:7667
     napi_poll net/core/dev.c:7730 [inline]
     net_rx_action+0x672/0xe50 net/core/dev.c:7882
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 -2 at
     j1939_session_put+0x47/0x480 net/can/j1939/transport.c:300
     j1939_xtp_rx_rts+0x8bb/0x1910 include/linux/hrtimer.h:-1
     j1939_tp_cmd_recv net/can/j1939/transport.c:2074 [inline]
     j1939_tp_recv+0xb24/0x1040 net/can/j1939/transport.c:2161
     j1939_can_recv+0x6a0/0xa30 net/can/j1939/main.c:108
     deliver net/can/af_can.c:575 [inline]
     can_rcv_filter+0x357/0x7d0 net/can/af_can.c:609
     can_receive+0x312/0x450 net/can/af_can.c:666
     can_rcv+0x145/0x270 net/can/af_can.c:690
     __netif_receive_skb_one_core net/core/dev.c:6138 [inline]
     __netif_receive_skb+0x164/0x380 net/core/dev.c:6251
     process_backlog+0x622/0x1500 net/core/dev.c:6603
     __napi_poll+0xae/0x320 net/core/dev.c:7667
     napi_poll net/core/dev.c:7730 [inline]
     net_rx_action+0x672/0xe50 net/core/dev.c:7882
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 -2 at
     j1939_priv_put+0x23/0x370 net/can/j1939/main.c:182
     j1939_can_recv+0x6e0/0xa30 net/can/j1939/main.c:115
     deliver net/can/af_can.c:575 [inline]
     can_rcv_filter+0x357/0x7d0 net/can/af_can.c:609
     can_receive+0x312/0x450 net/can/af_can.c:666
     can_rcv+0x145/0x270 net/can/af_can.c:690
     __netif_receive_skb_one_core net/core/dev.c:6138 [inline]
     __netif_receive_skb+0x164/0x380 net/core/dev.c:6251
     process_backlog+0x622/0x1500 net/core/dev.c:6603
     __napi_poll+0xae/0x320 net/core/dev.c:7667
     napi_poll net/core/dev.c:7730 [inline]
     net_rx_action+0x672/0xe50 net/core/dev.c:7882
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 -2 at
     j1939_session_put+0x47/0x480 net/can/j1939/transport.c:300
     j1939_sk_send_loop net/can/j1939/socket.c:1207 [inline]
     j1939_sk_sendmsg+0x10a0/0x1350 net/can/j1939/socket.c:1282
     sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
Call trace for vcan0@ffff888086898000 +3 at
     j1939_session_get net/can/j1939/transport.c:249 [inline]
     j1939_tp_rxtimer+0x313/0x3f0 net/can/j1939/transport.c:1256
     __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
     __hrtimer_run_queues+0x51c/0xc30 kernel/time/hrtimer.c:1841
     hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 -5 at
     j1939_session_put+0x47/0x480 net/can/j1939/transport.c:300
     j1939_tp_rxtimer+0x177/0x3f0 net/can/j1939/transport.c:1268
     __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
     __hrtimer_run_queues+0x51c/0xc30 kernel/time/hrtimer.c:1841
     hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 -2 at
     j1939_session_put+0x47/0x480 net/can/j1939/transport.c:300
     j1939_session_deactivate_locked net/can/j1939/transport.c:1089 [inline]
     j1939_session_deactivate+0x212/0x2b0 net/can/j1939/transport.c:1101
     j1939_session_deactivate_activate_next net/can/j1939/transport.c:1110 [inline]
     j1939_tp_rxtimer+0x1d5/0x3f0 net/can/j1939/transport.c:1239
     __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
     __hrtimer_run_queues+0x51c/0xc30 kernel/time/hrtimer.c:1841
     hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 -2 at
     j1939_session_put+0x47/0x480 net/can/j1939/transport.c:300
     j1939_sk_queue_activate_next_locked net/can/j1939/socket.c:174 [inline]
     j1939_sk_queue_activate_next+0x24d/0x400 net/can/j1939/socket.c:208
     j1939_session_deactivate_activate_next net/can/j1939/transport.c:1111 [inline]
     j1939_tp_rxtimer+0x1ea/0x3f0 net/can/j1939/transport.c:1239
     __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
     __hrtimer_run_queues+0x51c/0xc30 kernel/time/hrtimer.c:1841
     hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 +1 at
     j1939_session_get net/can/j1939/transport.c:249 [inline]
     j1939_session_get_by_addr_locked+0x169/0x730 net/can/j1939/transport.c:526
     j1939_session_activate+0xb4/0x3f0 net/can/j1939/transport.c:1566
     j1939_sk_queue_activate_next_locked net/can/j1939/socket.c:181 [inline]
     j1939_sk_queue_activate_next+0x27e/0x400 net/can/j1939/socket.c:208
     j1939_session_deactivate_activate_next net/can/j1939/transport.c:1111 [inline]
     j1939_tp_rxtimer+0x1ea/0x3f0 net/can/j1939/transport.c:1239
     __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
     __hrtimer_run_queues+0x51c/0xc30 kernel/time/hrtimer.c:1841
     hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 -1 at
     j1939_session_put+0x47/0x480 net/can/j1939/transport.c:300
     j1939_session_get_by_addr_locked+0x23a/0x730 net/can/j1939/transport.c:530
     j1939_session_activate+0xb4/0x3f0 net/can/j1939/transport.c:1566
     j1939_sk_queue_activate_next_locked net/can/j1939/socket.c:181 [inline]
     j1939_sk_queue_activate_next+0x27e/0x400 net/can/j1939/socket.c:208
     j1939_session_deactivate_activate_next net/can/j1939/transport.c:1111 [inline]
     j1939_tp_rxtimer+0x1ea/0x3f0 net/can/j1939/transport.c:1239
     __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
     __hrtimer_run_queues+0x51c/0xc30 kernel/time/hrtimer.c:1841
     hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 +1 at
     j1939_session_get net/can/j1939/transport.c:249 [inline]
     j1939_session_activate+0x254/0x3f0 net/can/j1939/transport.c:1577
     j1939_sk_queue_activate_next_locked net/can/j1939/socket.c:181 [inline]
     j1939_sk_queue_activate_next+0x27e/0x400 net/can/j1939/socket.c:208
     j1939_session_deactivate_activate_next net/can/j1939/transport.c:1111 [inline]
     j1939_tp_rxtimer+0x1ea/0x3f0 net/can/j1939/transport.c:1239
     __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
     __hrtimer_run_queues+0x51c/0xc30 kernel/time/hrtimer.c:1841
     hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 +1 at
     j1939_session_get net/can/j1939/transport.c:249 [inline]
     j1939_tp_schedule_txtimer+0x87/0xd0 net/can/j1939/transport.c:704
     j1939_sk_queue_activate_next_locked net/can/j1939/socket.c:194 [inline]
     j1939_sk_queue_activate_next+0x388/0x400 net/can/j1939/socket.c:208
     j1939_session_deactivate_activate_next net/can/j1939/transport.c:1111 [inline]
     j1939_tp_rxtimer+0x1ea/0x3f0 net/can/j1939/transport.c:1239
     __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
     __hrtimer_run_queues+0x51c/0xc30 kernel/time/hrtimer.c:1841
     hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 -2 at
     j1939_priv_put+0x23/0x370 net/can/j1939/main.c:182
     j1939_session_destroy net/can/j1939/transport.c:286 [inline]
     __j1939_session_release net/can/j1939/transport.c:295 [inline]
     kref_put include/linux/kref.h:65 [inline]
     j1939_session_put+0x31c/0x480 net/can/j1939/transport.c:301
     j1939_tp_rxtimer+0x177/0x3f0 net/can/j1939/transport.c:1268
     __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
     __hrtimer_run_queues+0x51c/0xc30 kernel/time/hrtimer.c:1841
     hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 -1 at
     j1939_session_put+0x47/0x480 net/can/j1939/transport.c:300
     j1939_session_rxtimer_cancel net/can/j1939/transport.c:313 [inline]
     j1939_session_timers_cancel net/can/j1939/transport.c:319 [inline]
     j1939_xtp_rx_rts_session_active net/can/j1939/transport.c:1687 [inline]
     j1939_xtp_rx_rts+0x3cb/0x1910 net/can/j1939/transport.c:1760
     j1939_tp_cmd_recv net/can/j1939/transport.c:2074 [inline]
     j1939_tp_recv+0xb24/0x1040 net/can/j1939/transport.c:2161
     j1939_can_recv+0x6a0/0xa30 net/can/j1939/main.c:108
     deliver net/can/af_can.c:575 [inline]
     can_rcv_filter+0x357/0x7d0 net/can/af_can.c:609
     can_receive+0x312/0x450 net/can/af_can.c:666
     can_rcv+0x145/0x270 net/can/af_can.c:690
     __netif_receive_skb_one_core net/core/dev.c:6138 [inline]
     __netif_receive_skb+0x164/0x380 net/core/dev.c:6251
     process_backlog+0x622/0x1500 net/core/dev.c:6603
     __napi_poll+0xae/0x320 net/core/dev.c:7667
     napi_poll net/core/dev.c:7730 [inline]
     net_rx_action+0x672/0xe50 net/core/dev.c:7882
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
Call trace for vcan0@ffff888086898000 -1 at
     j1939_priv_put+0x23/0x370 net/can/j1939/main.c:182
     j1939_jsk_del net/can/j1939/socket.c:94 [inline]
     j1939_sk_release+0x408/0x7c0 net/can/j1939/socket.c:649
     __sock_release+0xb9/0x250 net/socket.c:666
Call trace for vcan0@ffff888086898000 -1 at
     j1939_priv_put+0x23/0x370 net/can/j1939/main.c:182
     j1939_can_rx_unregister net/can/j1939/main.c:219 [inline]
     __j1939_rx_release net/can/j1939/main.c:228 [inline]
     kref_put_mutex include/linux/kref.h:86 [inline]
     j1939_netdev_stop+0xa6/0x190 net/can/j1939/main.c:323
     j1939_sk_release+0x471/0x7c0 net/can/j1939/socket.c:654
     __sock_release+0xb9/0x250 net/socket.c:666
Call trace for vcan0@ffff888086898000 -1 at
     j1939_priv_put+0x23/0x370 net/can/j1939/main.c:182
     j1939_sk_release+0x471/0x7c0 net/can/j1939/socket.c:654
     __sock_release+0xb9/0x250 net/socket.c:666
Call trace for vcan0@ffff888086898000 -1 at
     j1939_priv_put+0x23/0x370 net/can/j1939/main.c:182
     j1939_sk_sock_destruct+0x52/0x90 net/can/j1939/socket.c:386
     __sk_destruct+0x85/0x880 net/core/sock.c:2350
     rcu_do_batch kernel/rcu/tree.c:2605 [inline]
     rcu_core+0xd70/0x1870 kernel/rcu/tree.c:2857
     handle_softirqs+0x27d/0x850 kernel/softirq.c:626
balance for vcan0@j1939_priv is 2


