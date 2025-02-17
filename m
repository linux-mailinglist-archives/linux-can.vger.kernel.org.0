Return-Path: <linux-can+bounces-2822-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2967FA383DA
	for <lists+linux-can@lfdr.de>; Mon, 17 Feb 2025 14:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907033A8C62
	for <lists+linux-can@lfdr.de>; Mon, 17 Feb 2025 13:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DC821C19F;
	Mon, 17 Feb 2025 13:00:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D21A21C178
	for <linux-can@vger.kernel.org>; Mon, 17 Feb 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797241; cv=none; b=PvfyKalC3Usua5I1tU09zrlSauvuJduvAudqiBbpTyQYwhqu02QrKl8M4O6gyZwWzZ9PrZSHj5paOYMddgzCbqYddkYI70g+1IZaDUV8XALt5sTATuWFaszShNV3jTw0zN4z2U4+euWTDGdofEdRauxP1eMJKGvaGNC2NQahDQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797241; c=relaxed/simple;
	bh=W0xJp2fHBSO+TzErYJnMGlOWfxHwZNWRa8XWc/U/pJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+6ORebtGzHuG9iVwJdezsgukahmkW1jybLgAgeJ6/b17ldQbooLoOd8TcBgNmnc49XaaDqzjshiqBKroFTXHaqtx5QumzQKUa/j02ebQF1b3EQm7uubOM8r6fD5MBTlxjaaZTqDODxRHJeWdcNRv6CVIZycmOaSG6AwqqdAvlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tk0jX-0005AT-Aw; Mon, 17 Feb 2025 14:00:23 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tk0jV-001PZg-07;
	Mon, 17 Feb 2025 14:00:21 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E345E3C4C3B;
	Mon, 17 Feb 2025 12:57:06 +0000 (UTC)
Date: Mon, 17 Feb 2025 13:57:06 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: syzbot <syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mailhol.vincent@wanadoo.fr, netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com, Xu Panda <xu.panda@zte.com.cn>
Subject: Re: [syzbot] [can?] WARNING in ucan_probe
Message-ID: <20250217-spectral-cordial-booby-968731-mkl@pengutronix.de>
References: <67b323a4.050a0220.173698.002b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g7xglj7mfzpk3kuh"
Content-Disposition: inline
In-Reply-To: <67b323a4.050a0220.173698.002b.GAE@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--g7xglj7mfzpk3kuh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [syzbot] [can?] WARNING in ucan_probe
MIME-Version: 1.0

On 17.02.2025 03:55:16, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    496659003dac Merge tag 'i2c-for-6.14-rc3' of git://git.ke=
r..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D11012bf8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc776e555cfbdb=
82d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd7d8c418e831789=
9e88c
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14f7b9b0580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D155602e4580000
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c1675d5fc116/dis=
k-49665900.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0342ce7d0bc9/vmlinu=
x-49665900.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5ce5b4978fc4/b=
zImage-49665900.xz
>=20
> The issue was bisected to:
>=20
> commit b3e40fc85735b787ce65909619fcd173107113c2
> Author: Oliver Neukum <oneukum@suse.com>
> Date:   Thu May 2 11:51:40 2024 +0000
>=20
>     USB: usb_parse_endpoint: ignore reserved bits

I think the issue was introduced in: 7fdaf8966aae ("can: ucan: use
strscpy() to instead of strncpy()"). I'm preparing a fix.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g7xglj7mfzpk3kuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmezMh8ACgkQDHRl3/mQ
kZzmzQgAhZ+U89NLPUKjnFb9vAGYtSjKJb+1+b3OLpNzt9Ta5nZXyX1gMS0I2zd/
6E3cDfJ7vN/BOGCWTzgTMU5jbLyg4YzCZ2IyfMIyexJjxEUUJ35BkvHj29KUQgtr
bDrK30tqr/XK3tKOvLDZkacNmKRT8dad8Lv36VOCueQU7bJJVUzTx+SbdRiCn2Bv
jMMN3hnhJLQpfALoH/GnzESJcka4xyrHd5ZpD3SDx3mJiw82AEcJ+DLOA8X18ZiF
t1JIY4jgXpD77uMBwsHrhP7FCoW9j/ps/yAbJdc4Je9FCbtvyagP8/uYBNNKGIkJ
QIrwURE0P+NRGibiA//rqR55T8WU0Q==
=sBNn
-----END PGP SIGNATURE-----

--g7xglj7mfzpk3kuh--

