Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A59F211DE5D
	for <lists+linux-can@lfdr.de>; Fri, 13 Dec 2019 08:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfLMHC6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 13 Dec 2019 02:02:58 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48969 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMHC6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Dec 2019 02:02:58 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1ifeyU-00047g-W3; Fri, 13 Dec 2019 08:02:54 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ifeyT-0003lB-BF; Fri, 13 Dec 2019 08:02:53 +0100
Date:   Fri, 13 Dec 2019 08:02:53 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Elenita Hinds <ecathinds@gmail.com>
Cc:     dev.kurt@vandijck-laurijssen.be, linux-can@vger.kernel.org
Subject: Re: can-utils jacd questions
Message-ID: <20191213070253.a6dhb6vjmwlm6fqc@pengutronix.de>
References: <CAHChkrstQdjVcWtvX4oeUOQfZS3-G_RPWb8Y82Zvaku40dM_qA@mail.gmail.com>
 <20191206085923.GA4896@x1.vandijck-laurijssen.be>
 <CAHChkruBV2btmtk4FdfJ3-VvidGy5Z0hHhno4pPNuxMoDKAYtQ@mail.gmail.com>
 <CAHChkrtv9+hw30ymjMu9M-CpEnT__WWz7OmVCtxwCwyH42jJyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ripykotynsdrfd6h"
Content-Disposition: inline
In-Reply-To: <CAHChkrtv9+hw30ymjMu9M-CpEnT__WWz7OmVCtxwCwyH42jJyg@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:47:00 up 27 days, 22:05, 38 users,  load average: 0.01, 0.03,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ripykotynsdrfd6h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Elenita,

On Thu, Dec 12, 2019 at 03:49:48PM -0600, Elenita Hinds wrote:
> Hi Kurt,
>=20
> I tried using getsockname() to retrieve the source address that was
> successfully claimed by jacd but was always getting 0xfe (I was
> expecting it to be 0xf9 as claimed by jacd).
> Is getsockname() expected to be functional for J1939 with kernel v5.4?
> Is there another way to retrieving the dynamically claimed address real-t=
ime?

Current stack implementation will return on getsockname(sock, ...) and
getpeername(sock, ...) values provided by user via bind() and/or connect().=
 If
we configure the socket by name, then address are automatically resolved
over address claim cache.

The question is, should we return some thing different?
If yes, it will be interesting to know, why is it needed? What is the
use case?

> --elenita
>=20
>=20
> >
> > On Fri, Dec 6, 2019 at 2:59 AM Kurt Van Dijck
> > <dev.kurt@vandijck-laurijssen.be> wrote:
> > >
> > > Hi,
> > >
> > > On do, 05 dec 2019 14:55:53 -0600, Elenita Hinds wrote:
> > > > Hi all,
> > > >
> > > > I am hoping to re-use the can-utils' jacd as default Address Claimi=
ng
> > > > daemon but runs into some issues:
> > > >
> > > > (1) " err(0, <string>, ...) " is called in several places, even tho=
ugh
> > > > looking at the code logic, there is no error and the program should=
 be
> > > > able to continue. The program exits because err()  never returns.
> > > > For example:
> > >
> > > commit 791b6de7 introduced the problem.
> > > it replaced all error(x, y, sss) calls with err(y, sss)
> > > but it should have become warn(y, sss) when x=3D0.
> > >
> > > Feel free to fix that.
> > >
> > > > (2) The socket is configured to also set the SO_BINDTODEVICE option.
> > > > In our system, this requires the program to have root permissions to
> > > > run but we'd rather not do this for security reasons. Is this option
> > > > required? What are the side-effects if this option is not set? Can =
it
> > > > be made optional such that the program does not exit if the
> > > > setsockoption(SO_BINDTODEVICE) call fails (seems to work without it=
)?
> > >
> > > It appears on first sight that SO_BINDTODEVICE isn't strictly necessa=
ry
> > > since bind() will have sockaddr_can.can_ifindex set anyway.
> > > In that case, rather then ignore the result,
> > > remove the call to SO_BINDTODEVICE completely.
> > >
> > > >
> > > > (3) The claimed address is only saved to a file when the program
> > > > terminates.  What is the reason for this? Can it not be saved after
> > > > one is claimed already so that another process can  read it real-ti=
me
> > > > if needed?
> > >
> > > That should not be necessary.
> > > At time of writing jacd, you could consult 'ip addr show can0' to find
> > > out. I'm not sure what option remained to find it.
> > > I believe you can, from another program, bind() with the same name, a=
nd
> > > then getsockname() will return the complete sockaddr_can with SA fill=
ed
> > > in.
> > >
> > > > Also, in cases of a program crash or a power outage, the
> > > > claimed address is still saved.
> > >
> > > That is a true remark.
> > > Given a power outage (the program never crashes :-) ),
> > > and looking at the code, +10 years later, I would now write to a temp=
 file,
> > > and rename() the file to make it an atomic operation.
> > > Doing that regularly, or upon change, would be an improvement.
> > >
> > > Kurt
> > > >
> > > >
> > > > Thanks in advance,
> > > > Elenita
>=20

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--ripykotynsdrfd6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl3zN5wACgkQ4omh9DUa
UbOJyw//WsMeqLai7ziR9bWLjhwawmaIE3YbIhablvKwRd1w0vWO7PaQ6WfquzVd
2VhgJGs4OUtLGyz6OQ99NJf5hc8vLVJ9JtsDq0CME4UexZoxDTBWliDObnEHJaN6
iqUGgG/3wP88pAgJAabKXWup5jooXrq9Vg6GPGPrxFo9aQdqRPZJC1icXlzC9HGc
S5mTr1o8T5UwwMRnEFfd9wHPOG+qh2kM1OrsCkYMHt1up/iY+MAIxhxEY+k+KvDp
fIalBhpJve5uf53VAkfb3kFxktLnA/t8+Bd1xJs3dFiyTL9Z727qjtYu4LL/tBdm
0UhD/xPbF9pz9XUgKLQy2WZl/AUfQg5p1+nFtjs9Hcbr/s5I8jYsZDIx2AVWGoam
fOedDi0HV1BrXh6zTPRs71dY6E+Ax7driHOUSoE7Fds+mX1xBUasdtcte+XI74/d
qiAPc31BwwnMPJAakTx9En+ZL2ZlHEMmW7+KWwEsBEWnWZZoiSYpO2co4DXxGoJo
JJMbbZe3uYrqRgxwT+F+Z6tSW8yWvFV1Nv3DeJzzLw7fC0A3KKXPBkWYMdTJTuH6
tXB5T+ToFfPY0BQnYWzyBi4jAsk9cXmhf25SC0/v+7hjOCP8ze3+0tnvOHIwN+g6
J68QzDSUZqITdmWjL+NearqXNklX7yr5wCbO3pUaGY6OOxJXM0M=
=pbUY
-----END PGP SIGNATURE-----

--ripykotynsdrfd6h--
