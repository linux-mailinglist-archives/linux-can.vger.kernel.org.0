Return-Path: <linux-can+bounces-1418-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B08096CF2B
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 08:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306711C22A34
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 06:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C33218D655;
	Thu,  5 Sep 2024 06:24:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E54418BC31
	for <linux-can@vger.kernel.org>; Thu,  5 Sep 2024 06:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725517493; cv=none; b=tTkMWrMqSh8NH0vimKV7DAznCdSgXtO+0M0xHqI+5tfPlFGn5Xpt4GSE+iLPgRI19hDvZB9/JA7ID7v9Qo46jcVbHkpeVmYzBOEp1AJu1KGresuhFJvZ/6R0vNO2lGcCTQ7kSf49em+s2rTfYn5tR1f/cQ5ZDT8uk8AyX4FOQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725517493; c=relaxed/simple;
	bh=e2sDllAE5dXX739UjklTQRWClgsjH3CekyR+KVCQsw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdcQB3DMCkIG6hiebVWXEIhx2FwWkEZtKMoPEOn0LMFkombzQRe/+09ScIVGXktHqariiSoX0GFgoFGdGMVMhJ9riTl87XOHZSLoZnHlstBWiyhMqUAvEHZIKEUOA1OBBeMSubglKS1xzMSmQ5Jk8WiLsi+t0k+Htq9XIfYaKnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sm5vD-00008J-KC; Thu, 05 Sep 2024 08:24:47 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sm5vC-005daU-Nj; Thu, 05 Sep 2024 08:24:46 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 72D3E33308D;
	Thu, 05 Sep 2024 06:24:46 +0000 (UTC)
Date: Thu, 5 Sep 2024 08:24:45 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-can@vger.kernel.org, 
	syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 can] can: bcm: Clear bo->bcm_proc_read after
 remove_proc_entry().
Message-ID: <20240905-glossy-positive-bison-8de492-mkl@pengutronix.de>
References: <20240905012237.79683-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xvutjovijiclgebx"
Content-Disposition: inline
In-Reply-To: <20240905012237.79683-1-kuniyu@amazon.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--xvutjovijiclgebx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.09.2024 18:22:37, Kuniyuki Iwashima wrote:
> syzbot reported a warning in bcm_release(). [0]
>=20
> The blamed change fixed another warning that is triggered when
> connect() is issued again for a socket whose connect()ed device has
> been unregistered.
>=20
> However, if the socket is just close()d without the 2nd connect(), the
> remaining bo->bcm_proc_read triggers unnecessary remove_proc_entry()
> in bcm_release().
>=20
> Let's clear bo->bcm_proc_read after remove_proc_entry() in bcm_notify().
>=20
> [0]
> name '4986'
> WARNING: CPU: 0 PID: 5234 at fs/proc/generic.c:711 remove_proc_entry+0x2e=
7/0x5d0 fs/proc/generic.c:711
> Modules linked in:
> CPU: 0 UID: 0 PID: 5234 Comm: syz-executor606 Not tainted 6.11.0-rc5-syzk=
aller-00178-g5517ae241919 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> RIP: 0010:remove_proc_entry+0x2e7/0x5d0 fs/proc/generic.c:711
> Code: ff eb 05 e8 cb 1e 5e ff 48 8b 5c 24 10 48 c7 c7 e0 f7 aa 8e e8 2a 3=
8 8e 09 90 48 c7 c7 60 3a 1b 8c 48 89 de e8 da 42 20 ff 90 <0f> 0b 90 90 48=
 8b 44 24 18 48 c7 44 24 40 0e 36 e0 45 49 c7 04 07
> RSP: 0018:ffffc9000345fa20 EFLAGS: 00010246
> RAX: 2a2d0aee2eb64600 RBX: ffff888032f1f548 RCX: ffff888029431e00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000345fb08 R08: ffffffff8155b2f2 R09: 1ffff1101710519a
> R10: dffffc0000000000 R11: ffffed101710519b R12: ffff888011d38640
> R13: 0000000000000004 R14: 0000000000000000 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcfb52722f0 CR3: 000000000e734000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  bcm_release+0x250/0x880 net/can/bcm.c:1578
>  __sock_release net/socket.c:659 [inline]
>  sock_close+0xbc/0x240 net/socket.c:1421
>  __fput+0x24a/0x8a0 fs/file_table.c:422
>  task_work_run+0x24f/0x310 kernel/task_work.c:228
>  exit_task_work include/linux/task_work.h:40 [inline]
>  do_exit+0xa2f/0x27f0 kernel/exit.c:882
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1031
>  __do_sys_exit_group kernel/exit.c:1042 [inline]
>  __se_sys_exit_group kernel/exit.c:1040 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
>  x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:=
232
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fcfb51ee969
> Code: Unable to access opcode bytes at 0x7fcfb51ee93f.
> RSP: 002b:00007ffce0109ca8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fcfb51ee969
> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
> RBP: 00007fcfb526f3b0 R08: ffffffffffffffb8 R09: 0000555500000000
> R10: 0000555500000000 R11: 0000000000000246 R12: 00007fcfb526f3b0
> R13: 0000000000000000 R14: 00007fcfb5271ee0 R15: 00007fcfb51bf160
>  </TASK>
>=20
> Fixes: 76fe372ccb81 ("can: bcm: Remove proc entry when dev is unregistere=
d.")
> Reported-by: syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D0532ac7a06fb1a03187e
> Tested-by: syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xvutjovijiclgebx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbZTqoACgkQKDiiPnot
vG9nlwf9FSIFmU2pXydTxehJ5S+IEqkMLrk2LxjOYV6Hopz9DPoQpE+JFpqr4eHM
9auAeS3q6nyquPsJz/H85awwBqDNjwvbUirPh9IGx0sb/nK3LkpPnwWY4Cng6z1W
Hu1XxlikjR6vzIB/1gVxHEDqonDo9qtrs/29ufWha35YslCuZNx4Qlgesx1wDQwO
Awmgm3paDAWmNl4DEmOYvkZAYZ4yGDZ1Z4jD2+Bc4vZBzlc3AkQcqkmKZiUomBgk
/LcjPBE7AFqdmIXOTOWMcFfLAR06XJuXEOIvqgWjLZSBh/h7b4dqIfY1uGLHMWwZ
J/ukypnPo1R8D309NM7cZMkDtWJ5iw==
=CWdf
-----END PGP SIGNATURE-----

--xvutjovijiclgebx--

