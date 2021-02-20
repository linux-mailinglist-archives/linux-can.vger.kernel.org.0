Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2584C3206F6
	for <lists+linux-can@lfdr.de>; Sat, 20 Feb 2021 20:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhBTTqz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 20 Feb 2021 14:46:55 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:53176 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhBTTqy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 20 Feb 2021 14:46:54 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3CF381C0B77; Sat, 20 Feb 2021 20:46:11 +0100 (CET)
Date:   Sat, 20 Feb 2021 20:46:10 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     syzbot <syzbot+bdf710cfc41c186fdff3@syzkaller.appspotmail.com>,
        syzkaller@googlegroups.com
Cc:     davem@davemloft.net, kernel@pengutronix.de, kuba@kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Write in j1939_can_recv
Message-ID: <20210220194610.GA16558@amd>
References: <000000000000c086a505bbc1a238@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <000000000000c086a505bbc1a238@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Can we get some kind of common prefix for the subjects?


> This report is generated by a bot. It may contain errors.

It is less useful than average lkml mail, so it should be easy to
filter.


> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

--=20
http://www.livejournal.com/~pavelmachek

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAxZwIACgkQMOfwapXb+vI86wCfZ202w77Ojknu6Bac+jZOgpUK
8h0AoJMKeqGWB3HVOVU4BRvXsDBAD70K
=dFMv
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
