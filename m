Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4989711DE98
	for <lists+linux-can@lfdr.de>; Fri, 13 Dec 2019 08:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfLMHYh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 13 Dec 2019 02:24:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36107 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfLMHYg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Dec 2019 02:24:36 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1iffJT-0006Mk-82; Fri, 13 Dec 2019 08:24:35 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1iffJS-0004KD-7w; Fri, 13 Dec 2019 08:24:34 +0100
Date:   Fri, 13 Dec 2019 08:24:34 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Elenita Hinds <ecathinds@gmail.com>
Cc:     dev.kurt@vandijck-laurijssen.be, linux-can@vger.kernel.org
Subject: Re: can-utils jacd questions
Message-ID: <20191213072434.2cezzjvnohmpntha@pengutronix.de>
References: <CAHChkrstQdjVcWtvX4oeUOQfZS3-G_RPWb8Y82Zvaku40dM_qA@mail.gmail.com>
 <20191206085923.GA4896@x1.vandijck-laurijssen.be>
 <CAHChkruBV2btmtk4FdfJ3-VvidGy5Z0hHhno4pPNuxMoDKAYtQ@mail.gmail.com>
 <CAHChkrtv9+hw30ymjMu9M-CpEnT__WWz7OmVCtxwCwyH42jJyg@mail.gmail.com>
 <20191213070253.a6dhb6vjmwlm6fqc@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="htv6gkppdpm4nlzt"
Content-Disposition: inline
In-Reply-To: <20191213070253.a6dhb6vjmwlm6fqc@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:21:02 up 27 days, 22:39, 39 users,  load average: 0.08, 0.09,
 0.11
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--htv6gkppdpm4nlzt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2019 at 08:02:53AM +0100, Oleksij Rempel wrote:
> Hi Elenita,
>=20
> On Thu, Dec 12, 2019 at 03:49:48PM -0600, Elenita Hinds wrote:
> > Hi Kurt,
> >=20
> > I tried using getsockname() to retrieve the source address that was
> > successfully claimed by jacd but was always getting 0xfe (I was
> > expecting it to be 0xf9 as claimed by jacd).
> > Is getsockname() expected to be functional for J1939 with kernel v5.4?
> > Is there another way to retrieving the dynamically claimed address real=
-time?
>=20
> Current stack implementation will return on getsockname(sock, ...) and
> getpeername(sock, ...) values provided by user via bind() and/or connect(=
). If
> we configure the socket by name, then address are automatically resolved
> over address claim cache.

Hm.. this sentence  can be misinterpreted. I'll rephrase it:

The address are automatically resolved for internal use. And could be
potentially resolved for get[sock,peer]name() as well.

> The question is, should we return some thing different?
> If yes, it will be interesting to know, why is it needed? What is the
> use case?
>=20
> > --elenita
> >=20
> >=20
> > >
> > > On Fri, Dec 6, 2019 at 2:59 AM Kurt Van Dijck
> > > <dev.kurt@vandijck-laurijssen.be> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On do, 05 dec 2019 14:55:53 -0600, Elenita Hinds wrote:
> > > > > Hi all,
> > > > >
> > > > > I am hoping to re-use the can-utils' jacd as default Address Clai=
ming
> > > > > daemon but runs into some issues:
> > > > >
> > > > > (1) " err(0, <string>, ...) " is called in several places, even t=
hough
> > > > > looking at the code logic, there is no error and the program shou=
ld be
> > > > > able to continue. The program exits because err()  never returns.
> > > > > For example:
> > > >
> > > > commit 791b6de7 introduced the problem.
> > > > it replaced all error(x, y, sss) calls with err(y, sss)
> > > > but it should have become warn(y, sss) when x=3D0.
> > > >
> > > > Feel free to fix that.
> > > >
> > > > > (2) The socket is configured to also set the SO_BINDTODEVICE opti=
on.
> > > > > In our system, this requires the program to have root permissions=
 to
> > > > > run but we'd rather not do this for security reasons. Is this opt=
ion
> > > > > required? What are the side-effects if this option is not set? Ca=
n it
> > > > > be made optional such that the program does not exit if the
> > > > > setsockoption(SO_BINDTODEVICE) call fails (seems to work without =
it)?
> > > >
> > > > It appears on first sight that SO_BINDTODEVICE isn't strictly neces=
sary
> > > > since bind() will have sockaddr_can.can_ifindex set anyway.
> > > > In that case, rather then ignore the result,
> > > > remove the call to SO_BINDTODEVICE completely.
> > > >
> > > > >
> > > > > (3) The claimed address is only saved to a file when the program
> > > > > terminates.  What is the reason for this? Can it not be saved aft=
er
> > > > > one is claimed already so that another process can  read it real-=
time
> > > > > if needed?
> > > >
> > > > That should not be necessary.
> > > > At time of writing jacd, you could consult 'ip addr show can0' to f=
ind
> > > > out. I'm not sure what option remained to find it.
> > > > I believe you can, from another program, bind() with the same name,=
 and
> > > > then getsockname() will return the complete sockaddr_can with SA fi=
lled
> > > > in.
> > > >
> > > > > Also, in cases of a program crash or a power outage, the
> > > > > claimed address is still saved.
> > > >
> > > > That is a true remark.
> > > > Given a power outage (the program never crashes :-) ),
> > > > and looking at the code, +10 years later, I would now write to a te=
mp file,
> > > > and rename() the file to make it an atomic operation.
> > > > Doing that regularly, or upon change, would be an improvement.
> > > >
> > > > Kurt
> > > > >
> > > > >
> > > > > Thanks in advance,
> > > > > Elenita
> >=20
>=20
> --=20
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |



--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--htv6gkppdpm4nlzt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl3zPLEACgkQ4omh9DUa
UbMpiRAAyP6rGyNob3UftDGnpaQ7OqbEZp4ulGI1SyTpZGfICtkPmhIS0ga6/oo0
Qwr/W/qt7CI7RS1u3xxRBiEqAgr8uGjEzBI7zuIQIi+loFRQ3gcC52z3hXcCXr1L
PG75KHNjqKHHbiBswXLthk09ByWjDfhnIhUar3/drpMhDBYw/xyinbZMmO76u6Nz
uWadcR6Zt1HIZty5TcFuGYP1lvDVemWZIt+ZQth40EFk5uwPlURa1eK/DzkljCeo
AZsKyrHCqG7+E/lNVx2dQiygDjJ1b22RDQJaSd7TvwyxEozsdD2mWkOJwTz5BZca
MOMsxhj6hTiHm+8r6Q2UH8mCXy3t9ZfyxtkxXsxnxB25/vnoY2nBo2s5m7q0wGQT
NrEJh+dI8CPzUJ0COOPbAKo3pIgvAUVik+w/5JA4kDGBFLk0/IQk5bdBCpG2PZks
TledMrgKqR/E1+nBLYZMIpwIoC7oSLwmOZIdtnEqjxM9ZfPxmBUYBhm4uzzjna8r
1ESV4VOyvHjzm9ZvUl9di2TLelNEsGN4Rf37rf+AtLvD7bZhVM7UxE2FDEn0Wgg3
+x0EIYQFK5ng9ot78Y7Apkzstck5hHBMLsHc4JDV4s8H+2VkzASQVjnhfCnlYsFB
4hBu0qvqy7Y2QrsonPrL8y+mtyUQpW9UKmgTFnoPtQxr0uN9JaQ=
=/HNK
-----END PGP SIGNATURE-----

--htv6gkppdpm4nlzt--
