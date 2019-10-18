Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9A4DC7D5
	for <lists+linux-can@lfdr.de>; Fri, 18 Oct 2019 16:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404764AbfJROxe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Oct 2019 10:53:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37459 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732002AbfJROxe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Oct 2019 10:53:34 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1iLTdF-0000FD-No; Fri, 18 Oct 2019 16:53:33 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1iLTdF-0002gR-FJ; Fri, 18 Oct 2019 16:53:33 +0200
Date:   Fri, 18 Oct 2019 16:53:33 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: Questions around J1939 backport to old kernel
Message-ID: <20191018145333.a27j7d7f4zf3bqjd@pengutronix.de>
References: <b2dd08f0-0390-21c8-83c5-c6c361e78d9c@iot.bzh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hibgeasp36gk66m2"
Content-Disposition: inline
In-Reply-To: <b2dd08f0-0390-21c8-83c5-c6c361e78d9c@iot.bzh>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:56:04 up 153 days, 20:14, 99 users,  load average: 0.12, 0.05,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--hibgeasp36gk66m2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 18, 2019 at 12:07:34PM +0200, Romain Forlot [IoT.bzh] wrote:
> Hi,
>=20
> I am wondering what the cost is to backport the j1939 module to an old
> version like a v4.14 LTSI version.

The backport should be quite easy:

git cherry-pick -sx `git rev-list --reverse 2c1f9e26344483e2c74e80ef708d9c7=
fd2e543f4..9d71dd0c70099914fcd063135da3c580865e924c`

=2E..but it isn't :/ Some CAN patches are missing. We'll backport the stack=
 to
v4.14.150 (or newer) and send a follow up mail.

However, the driver for the CAN adapter needs proper RX/TX frame ordering,
otherwise the stack will explode.

This is fixed in flexcan mainline. And involves a handful of patches. Other
drivers probably need more fixing. Some CAN hardware may even lack the hard=
ware
support for proper ordering, that is time stamping registers.

> And what the impact is of backporting the whole CAN stack on the CAN driv=
ers?

The stack has no impact on the drivers, but requirements on proper RX/TX
ordering, see above.

> Are there any modifications to drivers once the CAN stack is updated ?

Yes, as long as they don't have proper RX/TX ordering.

So, which CAN driver are you planing to use?

Regards,
Oleksij & Marc

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--hibgeasp36gk66m2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl2p0ewACgkQ4omh9DUa
UbOV8BAAqzl9vVwesyucxqMuBxdR3J1AkY2WFgeHJvA0T0+GTjnXfvqgRw0lUL7M
+uUx0dGUWTrQeU21/I9DEU1PxPOG7mZeqx3DHn+DMJGUduz2LexIG02LRIriUZfI
7SExeaf9QMtJxjBbtvXAGIdTpRblM85c4TQc/Ad5K04mCDenQSjF/Kv2bGHPNoYA
Zvvh3fJj2QNewEgzCddQlrQ9vKd/0Cl0N0vyNV1sGtGNlOtECrk1mibiYsspPuaA
c+vAUwMHpu87Mo4OE+YaXnjuS8CVfbYHR7I+Z+iwfvmL7GIrX81BZV7uz5bYSw9V
mJyzkLuPiv1gtijcByY2fWhO2oikhc9Zqp4WDekx8BMzKWiHYfNrEx7r9zP4niUO
pVy8eiWWZTX97la0MZmvVPoD0WIbDMy3NbGQVUzPjKG+hIEsULyWKxrB25d3nfPG
wiY2h1SBaot5DnrUzrnkrrdIaLSnHRA38FEwozRdAdgac1t327/9BN2neYtFBNbG
XoiTQVnKjS29LvjLkm7Ye0urlbR0Yc5Y079zk5RKejFe5PMaTx4OqnXBhurcrjuB
dAs9gITKjfICS9FYyusy9et6xxITWohRGu/M8BO7unkVQV0uJdtTCD1weQcEc8bp
oYRTkvp8yT7w8taUSkwCnk702HH3L9xgy3j6Z9dVuLXTRG5j2YQ=
=ypp9
-----END PGP SIGNATURE-----

--hibgeasp36gk66m2--
