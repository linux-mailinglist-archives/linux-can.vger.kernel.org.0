Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D758536B91F
	for <lists+linux-can@lfdr.de>; Mon, 26 Apr 2021 20:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbhDZSkg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Apr 2021 14:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238706AbhDZSkX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Apr 2021 14:40:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AA8C061574
        for <linux-can@vger.kernel.org>; Mon, 26 Apr 2021 11:39:41 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lb68y-0005es-3F; Mon, 26 Apr 2021 20:39:40 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:5abc:85dd:13f5:c6cb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 590D161769C;
        Mon, 26 Apr 2021 18:39:38 +0000 (UTC)
Date:   Mon, 26 Apr 2021 20:39:37 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Patrick Menschel <menschel.p@posteo.de>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: [PATCH] can-isotp: Add error message if txqueuelen is too small.
Message-ID: <20210426183937.45qvcnbc343yuecv@pengutronix.de>
References: <20210425151028.8238-1-menschel.p@posteo.de>
 <CAMZ6RqKkeq6vo0X4_KH01=SXfjKF7YMXGT_cgm+sS+T10hr_CA@mail.gmail.com>
 <0a2b2615-ed9e-f813-8574-b170969c37ba@posteo.de>
 <CAMZ6RqK=4QifudsgxWHxoDYR0PfZvJg-kJjeshqmds1X8c4XfA@mail.gmail.com>
 <9d45b867-c1cc-76fb-9fff-59d5067e9be0@posteo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nk2ggactnfvltfa5"
Content-Disposition: inline
In-Reply-To: <9d45b867-c1cc-76fb-9fff-59d5067e9be0@posteo.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--nk2ggactnfvltfa5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.04.2021 17:10:18, Patrick Menschel wrote:
> Am 26.04.21 um 01:59 schrieb Vincent MAILHOL:
> > On Mon. 26 Apr 2021 at 01:45, Patrick Menschel <menschel.p@posteo.de> w=
rote:
> >>
> >> Am 25.04.21 um 17:35 schrieb Vincent MAILHOL:
> >>> On Sun. 26 Apr 2021 at 00:10, Patrick Menschel <menschel.p@posteo.de>=
 wrote:
> >>> Speaking of comprehensive error messages, it would be great to
> >>> print the mnemotechnic of the error code instead of its value:
> >>> |                       pr_notice_once("can-isotp: %s: can_send_ret
> >>> %pe : tx queue is full\n",
> >>> |                                      __func__, ERR_PTR(err));
> >>>
> >> Thanks Vincent,
> >>
> >> it's the first time I see this format string %pe , is it new or kernel
> >> specific?
> >=20
> > Yes, this is fairly recent and it is kernel specific (and I love it).
> >=20
> > It was added in commit 57f5677e535ba ("printf: add support for
> > printing symbolic error names").
> > Ref: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/commit/?id=3D57f5677e535ba24b8926a7125be2ef8d7f09323c
>=20
> Now that is really neat, sort of like python's __member__.name attribute
> of the Enum type.
> https://docs.python.org/3/library/enum.html#allowed-members-and-attribute=
s-of-enumerations
> I use it all the time since I moved away from ctypes.
> Saves at least 2 lines per log message.
>=20
> Proves that the very nature of best practice is convenience.
>=20
> I'll do a v2 and substitute for every occurrence of err in that file
> while I'm at it.

Make it two patches....what will increase you patch count :)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--nk2ggactnfvltfa5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCHCOYACgkQqclaivrt
76lj9wf/cGbVKkOsghJwEPgXjSZhqBjKDAJc8bL1NVWHTsSB/82iMa07hsgrQLBl
A8ESdVzcB63NaP1KwsFDNHxZUvFuzzTjZtCqYrC1RBcyi/bOmrY0wGIZSamLpcQY
BTzkCOEZ04jwiRuu9XMpA8Sx+EMN7XFtwp/lBF9JPHBeGrRifw1abv8beU1tkEut
ZKd8LvaTF63kiqwl+kjJoEDleqswmvhH+gKNll151NlElGVvNczmTuTV+5HDWlse
O9oM19UGV6BunCh62b2Eg2jxdpHm9KtYU+854Qoz0OnbznpE6MNjx2gWA6b7cOBq
v/iCzagp+CQmr9DYCYApul3p13544w==
=rn6D
-----END PGP SIGNATURE-----

--nk2ggactnfvltfa5--
