Return-Path: <linux-can+bounces-5506-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D148C73654
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 11:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C2F772A510
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 10:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4683176F2;
	Thu, 20 Nov 2025 10:11:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A02314A6F;
	Thu, 20 Nov 2025 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763633495; cv=none; b=I7X6kBN+5NLsLckhbpcEW9q7618t5bqhdMyISvr77LATvHa9OdL1o/jNYqNJPMaHRSZIk709EGzsEIhytKicgZkEUFSFS/TJ/FU5ehUObHClBfIaYvAv4F3TlieBjCJWFRCpo8TNG80IEAvGy2glqO34P2s+pffdR0eb15dbs1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763633495; c=relaxed/simple;
	bh=eWAadXHslEuh/Azwc+8IxNUGy6ZwhEzMJ9HpDHY0sZU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=JzfNC/7FZceAW7vChCBW/szyTQxJEzD7BtNcjr/WSxKWkTrxfU3NqMrKYNSlGSEnURzzHxviXE5MzNCsVr8a1DZdE4zxYuAeI2PrxG3orUvEWVqlF1zh0JDlgM0DEhUxmDgSnyAD6PVqArrAIOGuk3lKcyocvHpZOBmr7jibohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5AKABMMX062143;
	Thu, 20 Nov 2025 19:11:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5AKABM97062137
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 20 Nov 2025 19:11:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d2be2d6a-6cbb-4b13-9f86-a6b7fe94983a@I-love.SAKURA.ne.jp>
Date: Thu, 20 Nov 2025 19:11:22 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-can@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [can/j1939] unregister_netdevice: waiting for vcan0 to become free.
 Usage count = 2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav103.rs.sakura.ne.jp

Hello.

I am using a debug printk() patch for j1939_priv which records/counts where
refcount for j1939_priv has changed, and syzbot succeeded to record/count a
j1939_priv leak in next-20251119
( https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84 ).

The output from the debug printk() patch is shown below. I think that
understanding what actions have been taken on this j1939_priv object will
help you finding the cause of j1939_priv leak bug.

Regards.



unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
Call trace for vcan0@ffff888031c9c000 +1 at
     j1939_priv_create net/can/j1939/main.c:150 [inline]
     j1939_netdev_start+0x1de/0xa30 net/can/j1939/main.c:282
     j1939_sk_bind+0x926/0xca0 net/can/j1939/socket.c:498
     __sys_bind_socket net/socket.c:1878 [inline]
     __sys_bind+0x2c6/0x3e0 net/socket.c:1909
Call trace for vcan0@ffff888031c9c000 +1 at
     j1939_priv_get net/can/j1939/main.c:191 [inline]
     j1939_can_rx_register net/can/j1939/main.c:199 [inline]
     j1939_netdev_start+0x615/0xa30 net/can/j1939/main.c:305
     j1939_sk_bind+0x926/0xca0 net/can/j1939/socket.c:498
     __sys_bind_socket net/socket.c:1878 [inline]
     __sys_bind+0x2c6/0x3e0 net/socket.c:1909
Call trace for vcan0@ffff888031c9c000 +1 at
     j1939_sk_bind+0xa02/0xca0 net/can/j1939/socket.c:510
     __sys_bind_socket net/socket.c:1878 [inline]
     __sys_bind+0x2c6/0x3e0 net/socket.c:1909
Call trace for vcan0@ffff888031c9c000 +1 at
     j1939_jsk_add net/can/j1939/socket.c:81 [inline]
     j1939_sk_bind+0x769/0xca0 net/can/j1939/socket.c:530
     __sys_bind_socket net/socket.c:1878 [inline]
     __sys_bind+0x2c6/0x3e0 net/socket.c:1909
Call trace for vcan0@ffff888031c9c000 +2 at
     j1939_session_new+0x127/0x450 net/can/j1939/transport.c:1503
     j1939_tp_send+0x338/0x8c0 net/can/j1939/transport.c:2018
     j1939_sk_send_loop net/can/j1939/socket.c:1159 [inline]
     j1939_sk_sendmsg+0xaf8/0x1350 net/can/j1939/socket.c:1282
     sock_sendmsg_nosec net/socket.c:727 [inline]
     __sock_sendmsg+0x21c/0x270 net/socket.c:746
Call trace for vcan0@ffff888031c9c000 +2 at
     j1939_priv_get net/can/j1939/main.c:191 [inline]
     j1939_can_recv+0x17f/0xa30 net/can/j1939/main.c:54
     deliver net/can/af_can.c:575 [inline]
     can_rcv_filter+0x357/0x7d0 net/can/af_can.c:609
     can_receive+0x312/0x450 net/can/af_can.c:666
     can_rcv+0x145/0x270 net/can/af_can.c:690
     __netif_receive_skb_one_core net/core/dev.c:6130 [inline]
     __netif_receive_skb+0x164/0x380 net/core/dev.c:6243
     process_backlog+0x622/0x1530 net/core/dev.c:6595
     __napi_poll+0xae/0x320 net/core/dev.c:7659
     napi_poll net/core/dev.c:7722 [inline]
     net_rx_action+0x672/0xe50 net/core/dev.c:7874
     handle_softirqs+0x27d/0x880 kernel/softirq.c:626
Call trace for vcan0@ffff888031c9c000 +1 at
     j1939_session_new+0x127/0x450 net/can/j1939/transport.c:1503
     j1939_session_fresh_new net/can/j1939/transport.c:1543 [inline]
     j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1628 [inline]
     j1939_xtp_rx_rts+0xd16/0x18b0 net/can/j1939/transport.c:1749
     j1939_tp_cmd_recv net/can/j1939/transport.c:2071 [inline]
     j1939_tp_recv+0xb24/0x1040 net/can/j1939/transport.c:2158
     j1939_can_recv+0x6a0/0xa30 net/can/j1939/main.c:108
     deliver net/can/af_can.c:575 [inline]
     can_rcv_filter+0x357/0x7d0 net/can/af_can.c:609
     can_receive+0x312/0x450 net/can/af_can.c:666
     can_rcv+0x145/0x270 net/can/af_can.c:690
     __netif_receive_skb_one_core net/core/dev.c:6130 [inline]
     __netif_receive_skb+0x164/0x380 net/core/dev.c:6243
     process_backlog+0x622/0x1530 net/core/dev.c:6595
     __napi_poll+0xae/0x320 net/core/dev.c:7659
     napi_poll net/core/dev.c:7722 [inline]
     net_rx_action+0x672/0xe50 net/core/dev.c:7874
     handle_softirqs+0x27d/0x880 kernel/softirq.c:626
Call trace for vcan0@ffff888031c9c000 -2 at
     j1939_priv_put+0x23/0x370 net/can/j1939/main.c:184
     j1939_can_recv+0x6e0/0xa30 net/can/j1939/main.c:115
     deliver net/can/af_can.c:575 [inline]
     can_rcv_filter+0x357/0x7d0 net/can/af_can.c:609
     can_receive+0x312/0x450 net/can/af_can.c:666
     can_rcv+0x145/0x270 net/can/af_can.c:690
     __netif_receive_skb_one_core net/core/dev.c:6130 [inline]
     __netif_receive_skb+0x164/0x380 net/core/dev.c:6243
     process_backlog+0x622/0x1530 net/core/dev.c:6595
     __napi_poll+0xae/0x320 net/core/dev.c:7659
     napi_poll net/core/dev.c:7722 [inline]
     net_rx_action+0x672/0xe50 net/core/dev.c:7874
     handle_softirqs+0x27d/0x880 kernel/softirq.c:626
Call trace for vcan0@ffff888031c9c000 -2 at
     j1939_priv_put+0x23/0x370 net/can/j1939/main.c:184
     j1939_session_destroy net/can/j1939/transport.c:285 [inline]
     __j1939_session_release net/can/j1939/transport.c:294 [inline]
     kref_put include/linux/kref.h:65 [inline]
     j1939_session_put+0x2f0/0x460 net/can/j1939/transport.c:299
     j1939_tp_rxtimer+0x177/0x3d0 net/can/j1939/transport.c:1266
     __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
     __hrtimer_run_queues+0x51c/0xc70 kernel/time/hrtimer.c:1841
     hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
     handle_softirqs+0x27d/0x880 kernel/softirq.c:626
Call trace for vcan0@ffff888031c9c000 -1 at
     j1939_priv_put+0x23/0x370 net/can/j1939/main.c:184
     j1939_jsk_del net/can/j1939/socket.c:94 [inline]
     j1939_sk_release+0x408/0x7c0 net/can/j1939/socket.c:649
     __sock_release net/socket.c:662 [inline]
     sock_close+0xc3/0x240 net/socket.c:1459
     __fput+0x44c/0xa70 fs/file_table.c:468
     task_work_run+0x1d4/0x260 kernel/task_work.c:233
     resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
     __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
     exit_to_user_mode_loop+0xff/0x4f0 kernel/entry/common.c:75
     __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
     syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
     syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
     syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
     do_syscall_64+0x2e9/0xfa0 arch/x86/entry/syscall_64.c:100
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
Call trace for vcan0@ffff888031c9c000 -1 at
     j1939_priv_put+0x23/0x370 net/can/j1939/main.c:184
     j1939_can_rx_unregister net/can/j1939/main.c:221 [inline]
     __j1939_rx_release net/can/j1939/main.c:230 [inline]
     kref_put_mutex include/linux/kref.h:86 [inline]
     j1939_netdev_stop+0xa6/0x190 net/can/j1939/main.c:325
     j1939_sk_release+0x471/0x7c0 net/can/j1939/socket.c:654
     __sock_release net/socket.c:662 [inline]
     sock_close+0xc3/0x240 net/socket.c:1459
     __fput+0x44c/0xa70 fs/file_table.c:468
     task_work_run+0x1d4/0x260 kernel/task_work.c:233
     resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
     __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
     exit_to_user_mode_loop+0xff/0x4f0 kernel/entry/common.c:75
     __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
     syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
     syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
     syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
     do_syscall_64+0x2e9/0xfa0 arch/x86/entry/syscall_64.c:100
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
Call trace for vcan0@ffff888031c9c000 -1 at
     j1939_priv_put+0x23/0x370 net/can/j1939/main.c:184
     j1939_sk_release+0x471/0x7c0 net/can/j1939/socket.c:654
     __sock_release net/socket.c:662 [inline]
     sock_close+0xc3/0x240 net/socket.c:1459
     __fput+0x44c/0xa70 fs/file_table.c:468
     task_work_run+0x1d4/0x260 kernel/task_work.c:233
     resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
     __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
     exit_to_user_mode_loop+0xff/0x4f0 kernel/entry/common.c:75
     __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
     syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
     syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
     syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
     do_syscall_64+0x2e9/0xfa0 arch/x86/entry/syscall_64.c:100
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
Call trace for vcan0@ffff888031c9c000 -1 at
     j1939_priv_put+0x23/0x370 net/can/j1939/main.c:184
     j1939_sk_sock_destruct+0x52/0x90 net/can/j1939/socket.c:386
     __sk_destruct+0x85/0x880 net/core/sock.c:2350
     rcu_do_batch kernel/rcu/tree.c:2605 [inline]
     rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
     handle_softirqs+0x27d/0x880 kernel/softirq.c:626
balance for vcan0@j1939_priv is 1

