Return-Path: <linux-can+bounces-4963-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A18F6B9A027
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 15:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2A32A444D
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 13:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF1F303C88;
	Wed, 24 Sep 2025 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="N6+Dq86r"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B53002C6;
	Wed, 24 Sep 2025 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719972; cv=pass; b=Aki7WWA3e62pgdeuHR/HA/oSha562BsZfA4NjM4N38BJaRX0dr94PYRfCh7sX0gjTJFPVgNdHHdF4DsNOk64817tRv2FAvrqsIguNlnmvcc1pFbF6G0kvvNlskrbZvlf9319ki26qN6cnCGPTSoVQTzjwIM/NSLDi3KTfRJxTX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719972; c=relaxed/simple;
	bh=9S78/B22ljzUGtxGVn27goWanupKljCXX2U0Os7tJPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oj2leW83dYCpGytutK8x93euCpGBz7GWXn+rRlJgWyk24vZJDuo2APERXDczOypLxntGZeqitEP5JgWfe50sFDTWrtP8aoWp8NQSSfsPGpospUpPAJrNIbiHoJzp+Pl0QmdA3ukYYjP9gjw3zK9tfqqc7YUNCBGjnk13Fd87DFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=N6+Dq86r; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1758719945; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fsdLeF5v5WUELtMkT0ZJlkOB50MZsezd6Q4hx2ENlqOtpIbKycWA9prqrKaZVl3tFZ
    C4tv4O+rXay5xI8cx5Od1JZ7GZ2OOJxepFFzlk1+MUaB6Ys5BqpF0EIhSVsWzLJ/CzKD
    6TJ09lOwAS8qfFW05Zn7Oy0q6VbsYfUD4S9LLec+pDRJmZ+FIVEbYxlH03P1BZn9jSkN
    LJ7lzPsTXMtVFtshilCnWcnv2TRCOWC03H4Kav2JYS5GC2uG0HxKk4bixRSogB9smoWX
    ovpSREul8oPqLxZFmjMMtZvD2CNkJyk3Qkp3eEtdffygAfSAXw5P5h5E2SkBbfkSB0tt
    FEEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1758719945;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=C/+v2yusXJpFBQE3mAZlffS/7UsjM1X0npnJgIwuLnM=;
    b=Gc4HO/WGhkd0NPHdWUWPNzh2lXxt/35MnRNx0RCJnBqswCc8lfBrwysAJPjSr0a7vA
    IHM5Jc2nihzllwHcN22LX/5rl6qT03Jt7ik8EgVwCJsN8jgHmrzU/Cd6D7hnHO8+dM2p
    fzRFNT6gjjFH+0ogmVXsfACCnj577h74nUUeAzrDR003CDKkpjXqdzo85X8sH0lFljOx
    DUMkPU7JcWhwq5uHI5alqHl3A1KrIQi1SMgQOvo3K8Aecyn4Mr7dZIvBJXWyTTRgXK+K
    h76xazJtVjdb2Taam0ELljbPvtLAwuGnNIhYTDDaCDzcJ7xxCY8jJ4ipMkU90fZ5YW3j
    isVQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1758719945;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=C/+v2yusXJpFBQE3mAZlffS/7UsjM1X0npnJgIwuLnM=;
    b=N6+Dq86rWLlmnDS6XYmHFJI8knwUuytWtJHPWhVeZ6unmvV8/2wLBB41nPrp7DzcNv
    68g9r+JKIBRjrNYbarX9gPl+ZTMLYMVRnQLlxkysvTaCQDYufO0Y7akrYWjLCDPPdCXK
    YG3LAqzS+Rsvqe05HJ2D1Wwgn73grjdB77RBGXyzlMt/nDWYwIZlRWuepY3PRGPkPn/K
    M6QnbcLLW4dlecE9kZEWIp7FemI2DC8qE4FtUiLnMm8DwssHUq9abcX84p8UqZMLscIM
    qEPGF+yMQsPPBHXzk1PXuZ2OBJgQrpRDAjzZSl0u8CpSxBbHZ5UGZujoMnTaX/tDM8Bx
    hU+g==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tR5Jgv+fvVh2Tlv+VN3s="
Received: from [192.168.188.239]
    by smtp.strato.de (RZmta 53.3.2 AUTH)
    with ESMTPSA id Kcff9718ODJ2911
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 24 Sep 2025 15:19:02 +0200 (CEST)
Message-ID: <c952c748-4ae7-4ab9-8fd0-3e284a017273@hartkopp.net>
Date: Wed, 24 Sep 2025 15:18:56 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot ci] Re: pull-request: can-next 2025-09-24
To: syzbot ci <syzbot+ci284feacb80736eb0@syzkaller.appspotmail.com>,
 biju.das.jz@bp.renesas.com, davem@davemloft.net, geert@glider.be,
 kernel@pengutronix.de, kuba@kernel.org, linux-can@vger.kernel.org,
 mailhol@kernel.org, mkl@pengutronix.de, netdev@vger.kernel.org,
 stefan.maetje@esd.eu, stephane.grosjean@hms-networks.com,
 zhao.xichao@vivo.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <68d3e6ce.a70a0220.4f78.0028.GAE@google.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <68d3e6ce.a70a0220.4f78.0028.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Vincent,

On 24.09.25 14:40, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v1] pull-request: can-next 2025-09-24
> https://lore.kernel.org/all/20250924082104.595459-1-mkl@pengutronix.de
> * [PATCH net-next 01/48] can: m_can: use us_to_ktime() where appropriate
> * [PATCH net-next 02/48] MAINTAINERS: update Vincent Mailhol's email address
> * [PATCH net-next 03/48] can: dev: sort includes by alphabetical order
> * [PATCH net-next 04/48] can: peak: Modification of references to email accounts being deleted
> * [PATCH net-next 05/48] can: rcar_canfd: Update bit rate constants for RZ/G3E and R-Car Gen4
> * [PATCH net-next 06/48] can: rcar_canfd: Update RCANFD_CFG_* macros
> * [PATCH net-next 07/48] can: rcar_canfd: Simplify nominal bit rate config
> * [PATCH net-next 08/48] can: rcar_canfd: Simplify data bit rate config
> * [PATCH net-next 09/48] can: rcar_can: Consistently use ndev for net_device pointers
> * [PATCH net-next 10/48] can: rcar_can: Add helper variable dev to rcar_can_probe()
> * [PATCH net-next 11/48] can: rcar_can: Convert to Runtime PM
> * [PATCH net-next 12/48] can: rcar_can: Convert to BIT()
> * [PATCH net-next 13/48] can: rcar_can: Convert to GENMASK()
> * [PATCH net-next 14/48] can: rcar_can: CTLR bitfield conversion
> * [PATCH net-next 15/48] can: rcar_can: TFCR bitfield conversion
> * [PATCH net-next 16/48] can: rcar_can: BCR bitfield conversion
> * [PATCH net-next 17/48] can: rcar_can: Mailbox bitfield conversion
> * [PATCH net-next 18/48] can: rcar_can: Do not print alloc_candev() failures
> * [PATCH net-next 19/48] can: rcar_can: Convert to %pe
> * [PATCH net-next 20/48] can: esd_usb: Rework display of error messages
> * [PATCH net-next 21/48] can: esd_usb: Avoid errors triggered from USB disconnect
> * [PATCH net-next 22/48] can: raw: reorder struct uniqframe's members to optimise packing
> * [PATCH net-next 23/48] can: raw: use bitfields to store flags in struct raw_sock
> * [PATCH net-next 24/48] can: raw: reorder struct raw_sock's members to optimise packing
> * [PATCH net-next 25/48] can: annotate mtu accesses with READ_ONCE()
> * [PATCH net-next 26/48] can: dev: turn can_set_static_ctrlmode() into a non-inline function
> * [PATCH net-next 27/48] can: populate the minimum and maximum MTU values
> * [PATCH net-next 28/48] can: enable CAN XL for virtual CAN devices by default
> * [PATCH net-next 29/48] can: dev: move struct data_bittiming_params to linux/can/bittiming.h
> * [PATCH net-next 30/48] can: dev: make can_get_relative_tdco() FD agnostic and move it to bittiming.h
> * [PATCH net-next 31/48] can: netlink: document which symbols are FD specific
> * [PATCH net-next 32/48] can: netlink: refactor can_validate_bittiming()
> * [PATCH net-next 33/48] can: netlink: add can_validate_tdc()
> * [PATCH net-next 34/48] can: netlink: add can_validate_databittiming()
> * [PATCH net-next 35/48] can: netlink: refactor CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
> * [PATCH net-next 36/48] can: netlink: remove useless check in can_tdc_changelink()
> * [PATCH net-next 37/48] can: netlink: make can_tdc_changelink() FD agnostic
> * [PATCH net-next 38/48] can: netlink: add can_dtb_changelink()
> * [PATCH net-next 39/48] can: netlink: add can_ctrlmode_changelink()
> * [PATCH net-next 40/48] can: netlink: make can_tdc_get_size() FD agnostic
> * [PATCH net-next 41/48] can: netlink: add can_data_bittiming_get_size()
> * [PATCH net-next 42/48] can: netlink: add can_bittiming_fill_info()
> * [PATCH net-next 43/48] can: netlink: add can_bittiming_const_fill_info()
> * [PATCH net-next 44/48] can: netlink: add can_bitrate_const_fill_info()
> * [PATCH net-next 45/48] can: netlink: make can_tdc_fill_info() FD agnostic
> * [PATCH net-next 46/48] can: calc_bittiming: make can_calc_tdco() FD agnostic
> * [PATCH net-next 47/48] can: dev: add can_get_ctrlmode_str()
> * [PATCH net-next 48/48] can: netlink: add userland error messages
> 
> and found the following issue:
> KASAN: slab-out-of-bounds Read in can_setup
> 
> Full report is available here:
> https://ci.syzbot.org/series/7feff13b-7247-438c-9d92-b8e9fda977c7
> 
> ***
> 
> KASAN: slab-out-of-bounds Read in can_setup
> 
> tree:      net-next
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
> base:      315f423be0d1ebe720d8fd4fa6bed68586b13d34
> arch:      amd64
> compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> config:    https://ci.syzbot.org/builds/08331a39-4a31-4f96-a377-3125df2af883/config
> C repro:   https://ci.syzbot.org/findings/46cae752-cb54-4ceb-87cb-bb9d2fdb1d79/c_repro
> syz repro: https://ci.syzbot.org/findings/46cae752-cb54-4ceb-87cb-bb9d2fdb1d79/syz_repro
> 
> netlink: 24 bytes leftover after parsing attributes in process `syz.0.17'.
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in can_set_default_mtu drivers/net/can/dev/dev.c:350 [inline]
> BUG: KASAN: slab-out-of-bounds in can_setup+0x209/0x280 drivers/net/can/dev/dev.c:279
> Read of size 4 at addr ffff888106a6ee74 by task syz.0.17/5999
> 
> CPU: 1 UID: 0 PID: 5999 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0xca/0x240 mm/kasan/report.c:482
>   kasan_report+0x118/0x150 mm/kasan/report.c:595
>   can_set_default_mtu drivers/net/can/dev/dev.c:350 [inline]

When can_set_default_mtu() is called from the netlink config context it 
is also used for virtual CAN interfaces (which was created by syzbot 
here), where the priv pointer is not valid.

Please use

struct can_priv *priv = safe_candev_priv(dev);

to detect virtual CAN interfaces too.

Best regards,
Oliver

>   can_setup+0x209/0x280 drivers/net/can/dev/dev.c:279
>   alloc_netdev_mqs+0x795/0x11b0 net/core/dev.c:11949
>   rtnl_create_link+0x31f/0xd10 net/core/rtnetlink.c:3633
>   rtnl_newlink_create+0x25c/0xb00 net/core/rtnetlink.c:3815
>   __rtnl_newlink net/core/rtnetlink.c:3942 [inline]
>   rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4057
>   rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6946
>   netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
>   netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>   netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
>   netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
>   sock_sendmsg_nosec net/socket.c:714 [inline]
>   __sock_sendmsg+0x21c/0x270 net/socket.c:729
>   ____sys_sendmsg+0x505/0x830 net/socket.c:2614
>   ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
>   __sys_sendmsg net/socket.c:2700 [inline]
>   __do_sys_sendmsg net/socket.c:2705 [inline]
>   __se_sys_sendmsg net/socket.c:2703 [inline]
>   __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0b7658ec29
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff71a7bdf8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f0b767d5fa0 RCX: 00007f0b7658ec29
> RDX: 0000000000000000 RSI: 0000200000000280 RDI: 0000000000000003
> RBP: 00007f0b76611e41 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f0b767d5fa0 R14: 00007f0b767d5fa0 R15: 0000000000000003
>   </TASK>
> 
> Allocated by task 5999:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>   poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
>   __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
>   kasan_kmalloc include/linux/kasan.h:260 [inline]
>   __do_kmalloc_node mm/slub.c:4376 [inline]
>   __kvmalloc_node_noprof+0x30d/0x5f0 mm/slub.c:5067
>   alloc_netdev_mqs+0xa3/0x11b0 net/core/dev.c:11893
>   rtnl_create_link+0x31f/0xd10 net/core/rtnetlink.c:3633
>   rtnl_newlink_create+0x25c/0xb00 net/core/rtnetlink.c:3815
>   __rtnl_newlink net/core/rtnetlink.c:3942 [inline]
>   rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4057
>   rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6946
>   netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
>   netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>   netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
>   netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
>   sock_sendmsg_nosec net/socket.c:714 [inline]
>   __sock_sendmsg+0x21c/0x270 net/socket.c:729
>   ____sys_sendmsg+0x505/0x830 net/socket.c:2614
>   ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
>   __sys_sendmsg net/socket.c:2700 [inline]
>   __do_sys_sendmsg net/socket.c:2705 [inline]
>   __se_sys_sendmsg net/socket.c:2703 [inline]
>   __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff888106a6e000
>   which belongs to the cache kmalloc-cg-4k of size 4096
> The buggy address is located 244 bytes to the right of
>   allocated 3456-byte region [ffff888106a6e000, ffff888106a6ed80)
> 
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x106a68
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> memcg:ffff88810e6ebb41
> flags: 0x57ff00000000040(head|node=1|zone=2|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 057ff00000000040 ffff88801a44b500 ffffea00043e4000 dead000000000002
> raw: 0000000000000000 0000000080040004 00000000f5000000 ffff88810e6ebb41
> head: 057ff00000000040 ffff88801a44b500 ffffea00043e4000 dead000000000002
> head: 0000000000000000 0000000080040004 00000000f5000000 ffff88810e6ebb41
> head: 057ff00000000003 ffffea00041a9a01 00000000ffffffff 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd60c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5901, tgid 5901 (syz-executor), ts 69629116017, free_ts 69616324772
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
>   prep_new_page mm/page_alloc.c:1859 [inline]
>   get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
>   __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
>   alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
>   alloc_slab_page mm/slub.c:2492 [inline]
>   allocate_slab+0x8a/0x370 mm/slub.c:2660
>   new_slab mm/slub.c:2714 [inline]
>   ___slab_alloc+0xbeb/0x1420 mm/slub.c:3901
>   __slab_alloc mm/slub.c:3992 [inline]
>   __slab_alloc_node mm/slub.c:4067 [inline]
>   slab_alloc_node mm/slub.c:4228 [inline]
>   __do_kmalloc_node mm/slub.c:4375 [inline]
>   __kvmalloc_node_noprof+0x429/0x5f0 mm/slub.c:5067
>   alloc_netdev_mqs+0xa3/0x11b0 net/core/dev.c:11893
>   vti6_init_net+0x104/0x370 net/ipv6/ip6_vti.c:1146
>   ops_init+0x35c/0x5c0 net/core/net_namespace.c:136
>   setup_net+0x10c/0x320 net/core/net_namespace.c:438
>   copy_net_ns+0x31b/0x4d0 net/core/net_namespace.c:570
>   create_new_namespaces+0x3f3/0x720 kernel/nsproxy.c:110
>   unshare_nsproxy_namespaces+0x11c/0x170 kernel/nsproxy.c:218
>   ksys_unshare+0x4c8/0x8c0 kernel/fork.c:3127
>   __do_sys_unshare kernel/fork.c:3198 [inline]
>   __se_sys_unshare kernel/fork.c:3196 [inline]
>   __x64_sys_unshare+0x38/0x50 kernel/fork.c:3196
> page last free pid 5901 tgid 5901 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1395 [inline]
>   __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
>   __slab_free+0x303/0x3c0 mm/slub.c:4606
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:340
>   kasan_slab_alloc include/linux/kasan.h:250 [inline]
>   slab_post_alloc_hook mm/slub.c:4191 [inline]
>   slab_alloc_node mm/slub.c:4240 [inline]
>   __kmalloc_cache_noprof+0x1be/0x3d0 mm/slub.c:4402
>   kmalloc_noprof include/linux/slab.h:905 [inline]
>   kzalloc_noprof include/linux/slab.h:1039 [inline]
>   ref_tracker_alloc+0x133/0x460 lib/ref_tracker.c:271
>   __netdev_tracker_alloc include/linux/netdevice.h:4379 [inline]
>   netdev_hold include/linux/netdevice.h:4408 [inline]
>   netdev_queue_add_kobject net/core/net-sysfs.c:1994 [inline]
>   netdev_queue_update_kobjects+0x1d1/0x6c0 net/core/net-sysfs.c:2056
>   register_queue_kobjects net/core/net-sysfs.c:2119 [inline]
>   netdev_register_kobject+0x258/0x310 net/core/net-sysfs.c:2362
>   register_netdevice+0x126c/0x1ae0 net/core/dev.c:11287
>   __ip_tunnel_create+0x3e7/0x560 net/ipv4/ip_tunnel.c:268
>   ip_tunnel_init_net+0x2ba/0x800 net/ipv4/ip_tunnel.c:1161
>   ops_init+0x35c/0x5c0 net/core/net_namespace.c:136
>   setup_net+0x10c/0x320 net/core/net_namespace.c:438
>   copy_net_ns+0x31b/0x4d0 net/core/net_namespace.c:570
>   create_new_namespaces+0x3f3/0x720 kernel/nsproxy.c:110
> 
> Memory state around the buggy address:
>   ffff888106a6ed00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff888106a6ed80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ffff888106a6ee00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                                                               ^
>   ffff888106a6ee80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff888106a6ef00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> 
> 
> ***
> 
> If these findings have caused you to resend the series or submit a
> separate fix, please add the following tag to your commit message:
>    Tested-by: syzbot@syzkaller.appspotmail.com
> 
> ---
> This report is generated by a bot. It may contain errors.
> syzbot ci engineers can be reached at syzkaller@googlegroups.com.


