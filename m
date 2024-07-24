Return-Path: <linux-can+bounces-1006-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF4C93B5A7
	for <lists+linux-can@lfdr.de>; Wed, 24 Jul 2024 19:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E3E1C23A82
	for <lists+linux-can@lfdr.de>; Wed, 24 Jul 2024 17:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3876A16ABF3;
	Wed, 24 Jul 2024 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHGZynhr"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1159216A95E;
	Wed, 24 Jul 2024 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841313; cv=none; b=iQt2IkNpjrYwR3l/HtCewBLK2jM0mBOyaTY+yp+5AMb68kklzYSaJ0MA1W2ySOmDdtGyxTs0F8TkVenHUHSId0Od7b/XH+BZWVSMpw+3QBG69cgc/58q9BFyrFhy5BKWzZrs6bnS2bmjd7JWSuVsdzd3GHTCSXe5rlG9MAZF72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841313; c=relaxed/simple;
	bh=E8IFZR1Vge2tEybKij2yROAYQyWSQQckOEgQRR5cKEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVpjyk+zhnfuiJAjPFViGsRAr4UyzVZbdG75Qxg4nW0NdTqwekhTuvvs1X8R2WBUHsH0hOISvhmBVSJuBUj3a+0S7vSErQKwg7/kqG/wc5oH5uKZF3j0GdRjdKJ7boioLnwJnevxNioNSlsEFuh4Joom7OcQeZvH2jlUb1sL0ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHGZynhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FCEC4AF0C;
	Wed, 24 Jul 2024 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721841312;
	bh=E8IFZR1Vge2tEybKij2yROAYQyWSQQckOEgQRR5cKEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MHGZynhrptdScq8bL4CfpjAaNhSQlP31wTfcAD09a85at1Uluj73OwGafd00ds2Pw
	 csPI6KMLJcJw/eA4JNcdCgueG2KWxca4frBGpIFaBkazkx+LKxCnaiDkVnJfhpAFwt
	 71f7TlYiCCWSO9maOBWx22XHgHekoDEr37lChGZ19UxwmuUqNXda9byMNkzUszdaP3
	 OXPkNQ8ZpYQGt+5zMSnSCuPb7J3H8MCDIw9t1R7E6zCC57P6FN7/S/T6gt5KppFTQv
	 dFnbNpPRMOhAIMt03DPUYaBHWf1KxJ7ycWFy6aeBTCVWjoJzdLu8zQFNbAqZcqPAhm
	 0ff3T/APvHnCQ==
Date: Wed, 24 Jul 2024 18:15:08 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	kuni1840@gmail.com, linux-can@vger.kernel.org, mkl@pengutronix.de,
	netdev@vger.kernel.org, pabeni@redhat.com, socketcan@hartkopp.net,
	syzkaller@googlegroups.com
Subject: Re: [PATCH v1 net] can: bcm: Remove proc entry when dev is
 unregistered.
Message-ID: <20240724171508.GE97837@kernel.org>
References: <20240723090405.GB24657@kernel.org>
 <20240723183805.31201-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723183805.31201-1-kuniyu@amazon.com>

On Tue, Jul 23, 2024 at 11:38:05AM -0700, Kuniyuki Iwashima wrote:
> From: Simon Horman <horms@kernel.org>
> Date: Tue, 23 Jul 2024 10:04:05 +0100
> > On Mon, Jul 22, 2024 at 12:28:42PM -0700, Kuniyuki Iwashima wrote:
> > > syzkaller reported a warning in bcm_connect() below. [0]
> > > 
> > > The repro calls connect() to vxcan1, removes vxcan1, and calls
> > > connect() with ifindex == 0.
> > > 
> > > Calling connect() for a BCM socket allocates a proc entry.
> > > Then, bcm_sk(sk)->bound is set to 1 to prevent further connect().
> > > 
> > > However, removing the bound device resets bcm_sk(sk)->bound to 0
> > > in bcm_notify().
> > > 
> > > The 2nd connect() tries to allocate a proc entry with the same
> > > name and sets NULL to bcm_sk(sk)->bcm_proc_read, leaking the
> > > original proc entry.
> > > 
> > > Since the proc entry is available only for connect()ed sockets,
> > > let's clean up the entry when the bound netdev is unregistered.
> > > 
> > > [0]:
> > > proc_dir_entry 'can-bcm/2456' already registered
> > > WARNING: CPU: 1 PID: 394 at fs/proc/generic.c:376 proc_register+0x645/0x8f0 fs/proc/generic.c:375
> > > Modules linked in:
> > > CPU: 1 PID: 394 Comm: syz-executor403 Not tainted 6.10.0-rc7-g852e42cc2dd4
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > > RIP: 0010:proc_register+0x645/0x8f0 fs/proc/generic.c:375
> > > Code: 00 00 00 00 00 48 85 ed 0f 85 97 02 00 00 4d 85 f6 0f 85 9f 02 00 00 48 c7 c7 9b cb cf 87 48 89 de 4c 89 fa e8 1c 6f eb fe 90 <0f> 0b 90 90 48 c7 c7 98 37 99 89 e8 cb 7e 22 05 bb 00 00 00 10 48
> > > RSP: 0018:ffa0000000cd7c30 EFLAGS: 00010246
> > > RAX: 9e129be1950f0200 RBX: ff1100011b51582c RCX: ff1100011857cd80
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
> > > RBP: 0000000000000000 R08: ffd400000000000f R09: ff1100013e78cac0
> > > R10: ffac800000cd7980 R11: ff1100013e12b1f0 R12: 0000000000000000
> > > R13: 0000000000000000 R14: 0000000000000000 R15: ff1100011a99a2ec
> > > FS:  00007fbd7086f740(0000) GS:ff1100013fd00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00000000200071c0 CR3: 0000000118556004 CR4: 0000000000771ef0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> > > PKRU: 55555554
> > > Call Trace:
> > >  <TASK>
> > >  proc_create_net_single+0x144/0x210 fs/proc/proc_net.c:220
> > >  bcm_connect+0x472/0x840 net/can/bcm.c:1673
> > >  __sys_connect_file net/socket.c:2049 [inline]
> > >  __sys_connect+0x5d2/0x690 net/socket.c:2066
> > >  __do_sys_connect net/socket.c:2076 [inline]
> > >  __se_sys_connect net/socket.c:2073 [inline]
> > >  __x64_sys_connect+0x8f/0x100 net/socket.c:2073
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xd9/0x1c0 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > > RIP: 0033:0x7fbd708b0e5d
> > > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 9f 1b 00 f7 d8 64 89 01 48
> > > RSP: 002b:00007fff8cd33f08 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
> > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fbd708b0e5d
> > > RDX: 0000000000000010 RSI: 0000000020000040 RDI: 0000000000000003
> > > RBP: 0000000000000000 R08: 0000000000000040 R09: 0000000000000040
> > > R10: 0000000000000040 R11: 0000000000000246 R12: 00007fff8cd34098
> > > R13: 0000000000401280 R14: 0000000000406de8 R15: 00007fbd70ab9000
> > >  </TASK>
> > > remove_proc_entry: removing non-empty directory 'net/can-bcm', leaking at least '2456'
> > > 
> > > Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > 
> > Thanks,
> > 
> > I agree that the problem was introduced by the cited commit
> > and is resolved by this patch.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > > ---
> > >  net/can/bcm.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/net/can/bcm.c b/net/can/bcm.c
> > > index 27d5fcf0eac9..46d3ec3aa44b 100644
> > > --- a/net/can/bcm.c
> > > +++ b/net/can/bcm.c
> > > @@ -1470,6 +1470,10 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
> > >  
> > >  		/* remove device reference, if this is our bound device */
> > >  		if (bo->bound && bo->ifindex == dev->ifindex) {
> > > +#if IS_ENABLED(CONFIG_PROC_FS)
> > > +			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read)
> > > +				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
> > > +#endif
> > 
> > As a fix this looks good. But I wonder if it is worth following up
> > with a helper for the above as it inlines #if logic and now appears twice.
> 
> Other places also have #if guard for CONFIG_PROC_FS, so if needed,
> I'd move all of them into helper functions under a single #if in -next.

I'm not saying it's needed.
But it does sound nice to me.

