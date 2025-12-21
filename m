Return-Path: <linux-can+bounces-5888-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A26CCD3C8B
	for <lists+linux-can@lfdr.de>; Sun, 21 Dec 2025 08:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29E72300B285
	for <lists+linux-can@lfdr.de>; Sun, 21 Dec 2025 07:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7821A23D7CA;
	Sun, 21 Dec 2025 07:58:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D523C8AE
	for <linux-can@vger.kernel.org>; Sun, 21 Dec 2025 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766303905; cv=none; b=nl+rBlUuOKked7WMVKw8GSeCihtZBIOuuINc+D/4hJomzYa7R4tPzg/SIbGKfsD5XHtsz22Vn6KkuRzRRF2QEt3wspEGGXRAzCYzQjNYUeLv9fL0BbvVk4j0rROZh4MM7gSvEVeMLZkcv6JY84e33/PEMjyZ8CHKIqiyf4PW6SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766303905; c=relaxed/simple;
	bh=SbIusgOI5pRRntlm+EoVtwvzVxBU9gR2VdOsbNO/QMM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OkNjWwyElseR8Rvmwq+Agwdlw/lnqjjDdl8t1b2ND6UcRTEejyv41VeKqLJOsYxpLMYPODgSzLcu+ni8BJHfsGW5YgkbLYK8i7jOsggVkCcLz8j2zYZLHRkhPI0XPEG7Y2i8z6oPpqftuBnV4xMf7OZmjcMeJR4pa+RMV5xavjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-65b37e173faso4444976eaf.0
        for <linux-can@vger.kernel.org>; Sat, 20 Dec 2025 23:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766303902; x=1766908702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAruRVPXr1EjccfFCABV7O3DDyN3ztR8ygjJsF2RwNc=;
        b=SJR5I7WBa2XaAwXcqLCyPRuCULIPPKLqth9YJbM1AwCDDOoUisExsMLQqIixLRE4ct
         udNBPOIgOPto12QrGBrcgykpmLK0zKfvIWXEnclzvEv3pV+yx6AySqObpiToRxqLC7ph
         zCtJvZ2ovKSV/FlO34Z7vxD/0fjLBWhDLsU5ig6dghB6wRnba/3TKfvnEGTrVNN8xR0C
         D9P8Psy8H3EgOpyvUf7M1vFXPJy/KcoeVqJLnqgjnb47MBsnePeeA6L0nTa9sRk++d+7
         nZaXplcba4CjDC6wCWqnRYayltR1FXE13jeDbPnL0WgTwq8DqBeMUzsWRVMA7Psvxhs1
         pVow==
X-Forwarded-Encrypted: i=1; AJvYcCXYKhWpc0KYZcZNLd0WylTnSzh1UTEtY1P3LAtFA/yys1Js7If9Vs4JblNhqCwGr6SqUcaeSqWSSGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTCbLGgpiT/dqDc47macS22XYg+zRLfTlr7XcslID3jQNQfopO
	XHtjOGlQOe6kTMCckuxkP/w/KAE9FUdTHTPYppugyPkK7dLeG73SaCgYBHKL+g1xlCcNOArkO4e
	12zIIaDX1r8mWJPT+6b6y9Z8AwhV0KFv2Ih13yxoZj9zZQU0gpsbVwHEgN6Y=
X-Google-Smtp-Source: AGHT+IE9sHwH/4Ex1o9zdWfJGhE7eallQLBhwBykS8FPmoMcbjnF7HHbt3COR2gH+H0UQZAtdupmLbd0R1jSVR+dGOPEbQQeKCQ6
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6283:b0:659:81f1:fec4 with SMTP id
 006d021491bc7-65d0e94dfbamr2455545eaf.6.1766303902591; Sat, 20 Dec 2025
 23:58:22 -0800 (PST)
Date: Sat, 20 Dec 2025 23:58:22 -0800
In-Reply-To: <00000000000060446d060af10f08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6947a89e.a70a0220.25eec0.006f.GAE@google.com>
Subject: Re: [syzbot] [can?] memory leak in j1939_netdev_start
From: syzbot <syzbot+1d37bef05da87b99c5a6@syzkaller.appspotmail.com>
To: davem@davemloft.net, eadavis@qq.com, edumazet@google.com, 
	kernel@pengutronix.de, kuba@kernel.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mkl@pengutronix.de, n.zhandarovich@fintech.ru, 
	netdev@vger.kernel.org, o.rempel@pengutronix.de, pabeni@redhat.com, 
	robin@protonic.nl, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d8ba32c5a460 Merge tag 'block-6.19-20251218' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13989392580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d60836e327fd6756
dashboard link: https://syzkaller.appspot.com/bug?extid=1d37bef05da87b99c5a6
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155c4358580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d1777c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/075f0ee95918/disk-d8ba32c5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8219d2472799/vmlinux-d8ba32c5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5d07c95aef4d/bzImage-d8ba32c5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2fd2ba265dd2/mount_9.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=105f562a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d37bef05da87b99c5a6@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88812437e000 (size 8192):
  comm "syz.3.27", pid 6191, jiffies 4294942739
  hex dump (first 32 bytes):
    00 e0 37 24 81 88 ff ff 00 e0 37 24 81 88 ff ff  ..7$......7$....
    00 00 00 00 00 00 00 00 00 80 67 14 81 88 ff ff  ..........g.....
  backtrace (crc 9710eadb):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __kmalloc_cache_noprof+0x3b2/0x570 mm/slub.c:5771
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    j1939_priv_create net/can/j1939/main.c:131 [inline]
    j1939_netdev_start+0x160/0x6f0 net/can/j1939/main.c:268
    j1939_sk_bind+0x247/0x590 net/can/j1939/socket.c:504
    __sys_bind_socket net/socket.c:1874 [inline]
    __sys_bind_socket net/socket.c:1866 [inline]
    __sys_bind+0x132/0x160 net/socket.c:1905
    __do_sys_bind net/socket.c:1910 [inline]
    __se_sys_bind net/socket.c:1908 [inline]
    __x64_sys_bind+0x1c/0x30 net/socket.c:1908
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810cc00e00 (size 240):
  comm "softirq", pid 0, jiffies 4294942739
  hex dump (first 32 bytes):
    68 8a 63 24 81 88 ff ff 68 8a 63 24 81 88 ff ff  h.c$....h.c$....
    00 80 67 14 81 88 ff ff 00 00 00 00 00 00 00 00  ..g.............
  backtrace (crc 467a0d54):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_node_noprof+0x384/0x5a0 mm/slub.c:5315
    __alloc_skb+0xe8/0x2b0 net/core/skbuff.c:679
    alloc_skb include/linux/skbuff.h:1383 [inline]
    j1939_session_fresh_new net/can/j1939/transport.c:1532 [inline]
    j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1630 [inline]
    j1939_xtp_rx_rts+0x3e4/0xb30 net/can/j1939/transport.c:1751
    j1939_tp_cmd_recv net/can/j1939/transport.c:2073 [inline]
    j1939_tp_recv+0x1b9/0x800 net/can/j1939/transport.c:2160
    j1939_can_recv+0x35f/0x4d0 net/can/j1939/main.c:108
    deliver net/can/af_can.c:575 [inline]
    can_rcv_filter+0xdd/0x2c0 net/can/af_can.c:609
    can_receive+0xf0/0x140 net/can/af_can.c:666
    can_rcv+0xf6/0x130 net/can/af_can.c:690
    __netif_receive_skb_one_core+0xeb/0x100 net/core/dev.c:6137
    __netif_receive_skb+0x1d/0x80 net/core/dev.c:6250
    process_backlog+0xd5/0x1e0 net/core/dev.c:6602
    __napi_poll+0x44/0x3a0 net/core/dev.c:7666
    napi_poll net/core/dev.c:7729 [inline]
    net_rx_action+0x492/0x560 net/core/dev.c:7881
    handle_softirqs+0xe1/0x2e0 kernel/softirq.c:622
    __do_softirq kernel/softirq.c:656 [inline]
    invoke_softirq kernel/softirq.c:496 [inline]
    __irq_exit_rcu+0x98/0xc0 kernel/softirq.c:723
    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
    sysvec_apic_timer_interrupt+0x73/0x80 arch/x86/kernel/apic/apic.c:1056

BUG: memory leak
unreferenced object 0xffff88810a549e40 (size 704):
  comm "softirq", pid 0, jiffies 4294942739
  hex dump (first 32 bytes):
    0e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc fd324075):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_node_noprof+0x384/0x5a0 mm/slub.c:5315
    kmalloc_reserve+0xe6/0x180 net/core/skbuff.c:586
    __alloc_skb+0x111/0x2b0 net/core/skbuff.c:690
    alloc_skb include/linux/skbuff.h:1383 [inline]
    j1939_session_fresh_new net/can/j1939/transport.c:1532 [inline]
    j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1630 [inline]
    j1939_xtp_rx_rts+0x3e4/0xb30 net/can/j1939/transport.c:1751
    j1939_tp_cmd_recv net/can/j1939/transport.c:2073 [inline]
    j1939_tp_recv+0x1b9/0x800 net/can/j1939/transport.c:2160
    j1939_can_recv+0x35f/0x4d0 net/can/j1939/main.c:108
    deliver net/can/af_can.c:575 [inline]
    can_rcv_filter+0xdd/0x2c0 net/can/af_can.c:609
    can_receive+0xf0/0x140 net/can/af_can.c:666
    can_rcv+0xf6/0x130 net/can/af_can.c:690
    __netif_receive_skb_one_core+0xeb/0x100 net/core/dev.c:6137
    __netif_receive_skb+0x1d/0x80 net/core/dev.c:6250
    process_backlog+0xd5/0x1e0 net/core/dev.c:6602
    __napi_poll+0x44/0x3a0 net/core/dev.c:7666
    napi_poll net/core/dev.c:7729 [inline]
    net_rx_action+0x492/0x560 net/core/dev.c:7881
    handle_softirqs+0xe1/0x2e0 kernel/softirq.c:622
    __do_softirq kernel/softirq.c:656 [inline]
    invoke_softirq kernel/softirq.c:496 [inline]
    __irq_exit_rcu+0x98/0xc0 kernel/softirq.c:723

BUG: memory leak
unreferenced object 0xffff888124638a00 (size 512):
  comm "softirq", pid 0, jiffies 4294942739
  hex dump (first 32 bytes):
    00 e0 37 24 81 88 ff ff 28 f0 37 24 81 88 ff ff  ..7$....(.7$....
    28 f0 37 24 81 88 ff ff 18 8a 63 24 81 88 ff ff  (.7$......c$....
  backtrace (crc 965e5f06):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __kmalloc_cache_noprof+0x3b2/0x570 mm/slub.c:5771
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    j1939_session_new+0x55/0x1d0 net/can/j1939/transport.c:1495
    j1939_session_fresh_new net/can/j1939/transport.c:1543 [inline]
    j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1630 [inline]
    j1939_xtp_rx_rts+0x47a/0xb30 net/can/j1939/transport.c:1751
    j1939_tp_cmd_recv net/can/j1939/transport.c:2073 [inline]
    j1939_tp_recv+0x1b9/0x800 net/can/j1939/transport.c:2160
    j1939_can_recv+0x35f/0x4d0 net/can/j1939/main.c:108
    deliver net/can/af_can.c:575 [inline]
    can_rcv_filter+0xdd/0x2c0 net/can/af_can.c:609
    can_receive+0xf0/0x140 net/can/af_can.c:666
    can_rcv+0xf6/0x130 net/can/af_can.c:690
    __netif_receive_skb_one_core+0xeb/0x100 net/core/dev.c:6137
    __netif_receive_skb+0x1d/0x80 net/core/dev.c:6250
    process_backlog+0xd5/0x1e0 net/core/dev.c:6602
    __napi_poll+0x44/0x3a0 net/core/dev.c:7666
    napi_poll net/core/dev.c:7729 [inline]
    net_rx_action+0x492/0x560 net/core/dev.c:7881
    handle_softirqs+0xe1/0x2e0 kernel/softirq.c:622
    __do_softirq kernel/softirq.c:656 [inline]
    invoke_softirq kernel/softirq.c:496 [inline]
    __irq_exit_rcu+0x98/0xc0 kernel/softirq.c:723
    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
    sysvec_apic_timer_interrupt+0x73/0x80 arch/x86/kernel/apic/apic.c:1056

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

