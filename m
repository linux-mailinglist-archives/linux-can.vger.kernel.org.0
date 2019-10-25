Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77750E4782
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2019 11:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394355AbfJYJjv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Oct 2019 05:39:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34377 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394243AbfJYJjv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Oct 2019 05:39:51 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1iNw4U-0003Rc-8g; Fri, 25 Oct 2019 11:39:50 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1iNw4T-0005Il-MU; Fri, 25 Oct 2019 11:39:49 +0200
Date:   Fri, 25 Oct 2019 11:39:49 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: Questions around J1939 backport to old kernel
Message-ID: <20191025093949.ijb5qt5beq4qavnk@pengutronix.de>
References: <b2dd08f0-0390-21c8-83c5-c6c361e78d9c@iot.bzh>
 <20191018145333.a27j7d7f4zf3bqjd@pengutronix.de>
 <72a6f8b2-38e3-a54b-d719-10471d4d260b@iot.bzh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tjtkpbtamehgqcos"
Content-Disposition: inline
In-Reply-To: <72a6f8b2-38e3-a54b-d719-10471d4d260b@iot.bzh>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:39:15 up 160 days, 15:57, 100 users,  load average: 0.06, 0.11,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--tjtkpbtamehgqcos
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2019 at 09:38:39AM +0200, Romain Forlot [IoT.bzh] wrote:
> I used it in the mainline kernel without troubles. This is a a very good
> job, thanks.
>=20
> Ok, thanks for the answer. May be I=C2=A0 will work on it in the next few=
 months.
> Let's see. I'll keep you informed.
>=20

Thank you for testing. I hope to get more feed back :)

> Regards.
>=20
> On 18/10/2019 16:53, Oleksij Rempel wrote:
> > Hi,
> >=20
> > On Fri, Oct 18, 2019 at 12:07:34PM +0200, Romain Forlot [IoT.bzh] wrote:
> > > Hi,
> > >=20
> > > I am wondering what the cost is to backport the j1939 module to an old
> > > version like a v4.14 LTSI version.
> > The backport should be quite easy:
> >=20
> > git cherry-pick -sx `git rev-list --reverse 2c1f9e26344483e2c74e80ef708=
d9c7fd2e543f4..9d71dd0c70099914fcd063135da3c580865e924c`
> >=20
> > ...but it isn't :/ Some CAN patches are missing. We'll backport the sta=
ck to
> > v4.14.150 (or newer) and send a follow up mail.
> >=20
> > However, the driver for the CAN adapter needs proper RX/TX frame orderi=
ng,
> > otherwise the stack will explode.
> >=20
> > This is fixed in flexcan mainline. And involves a handful of patches. O=
ther
> > drivers probably need more fixing. Some CAN hardware may even lack the =
hardware
> > support for proper ordering, that is time stamping registers.
> >=20
> > > And what the impact is of backporting the whole CAN stack on the CAN =
drivers?
> > The stack has no impact on the drivers, but requirements on proper RX/TX
> > ordering, see above.
> >=20
> > > Are there any modifications to drivers once the CAN stack is updated ?
> > Yes, as long as they don't have proper RX/TX ordering.
> >=20
> > So, which CAN driver are you planing to use?
> >=20
> > Regards,
> > Oleksij & Marc
> >=20
> --=20
> Romain Forlot - Embedded Engineer - IoT.bzh
> romain.forlot@iot.bzh - www.iot.bzh - +33675142438
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--tjtkpbtamehgqcos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl2ywuUACgkQ4omh9DUa
UbMQ5RAAi8pr5kb8tBuS+i1C4Ua6CuPuQnrEqFmp7f2NbepSiuhpEEmH3qwYEYAg
3jpb865kh/fLQbQ+I2WGbmQGM24wgcozOE8DtPpSHGk+LSd33ooDeuy7aWQMcX0h
hUNi5qTaGJ+ZKpnmMeYpt96+dlsdkuCLZyKNiyPEvq9Quv1RoKtS8n1SjZxcCsty
klYzxDoXuqP8pkZd4XjEztrw2QMZuDpv2erlm4QlsfMP5KbBkiffTiVOcN2CD0lI
xyiAj+wQgMSPCdnluyt70aZhw3w451q5Qs2xx/xDRpNQa94DpwyWlkoj0PyXorCp
fDqFwO87K1/xbxHpG1W4HXHt6BI6rs15qJBN8CxXAXZvc3DYWGjwQKMfQjLZFbli
MYhuPSWuBDbdTo90ITSk4/LwHK9XpDcOrtDKYcFnSbhtcfJym1S3iqlXk6GtU3p8
VjbK1zwuSV5dLjP/fqtwcuiV8jdnfMgoXmhviTXf8mX/f3r4LFoz6mAGQkiqq2yv
wb5S7EqhcxA5RCIhbZPOk21V+jQP8BSYWRLImKKg4h/k+Smh3xiICc3ZodW3edie
hU3r7cfcFV12JT51vS84r2utuqs5ypiRx8LOdP4ngmOZUFkN43KFxnGE83awTy7G
THBJauPW6J5nY4OS+CbbrAbTMOUAgwoOHB3qGqlF6Q4V6GgRdhY=
=20H5
-----END PGP SIGNATURE-----

--tjtkpbtamehgqcos--
