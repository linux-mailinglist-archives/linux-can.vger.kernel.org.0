Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E8135663D
	for <lists+linux-can@lfdr.de>; Wed,  7 Apr 2021 10:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbhDGIQL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Apr 2021 04:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbhDGIQK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Apr 2021 04:16:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A662C06174A
        for <linux-can@vger.kernel.org>; Wed,  7 Apr 2021 01:16:01 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lU3Lz-0003t3-GL; Wed, 07 Apr 2021 10:15:59 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:a41a:93b3:8535:9a37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0E37560985A;
        Wed,  7 Apr 2021 08:15:58 +0000 (UTC)
Date:   Wed, 7 Apr 2021 10:15:57 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 4/5] can: add netlink interface for CAN-FD Transmitter
 Delay Compensation (TDC)
Message-ID: <20210407081557.m3sotnepbgasarri@pengutronix.de>
References: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
 <20210224002008.4158-5-mailhol.vincent@wanadoo.fr>
 <20210315155900.a6l5l5aeuvsgn55x@pengutronix.de>
 <CAMZ6RqJyMXzog1mu3S62yMAxJorTg0D5VL5OYKALYRoMxN_DdQ@mail.gmail.com>
 <20210316152948.eqak6slrs2xf5lc4@pengutronix.de>
 <CAMZ6Rq+ET3V3EQDVe9xYF8=Sv7N1WHZCLy2XTvqVXuNEyKg6VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hxmxc2sdywojaloz"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+ET3V3EQDVe9xYF8=Sv7N1WHZCLy2XTvqVXuNEyKg6VQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--hxmxc2sdywojaloz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.04.2021 11:29:31, Vincent MAILHOL wrote:
> Hi Marc,
>=20
> On Wed. 17 Mar 2021 at 00:29, Marc Kleine-Budde <mkl@pengutronix.de> wrot=
e:
> > On 17.03.2021 00:16:01, Vincent MAILHOL wrote:
> > > > I just had a look at the ethtool-netlink interface:
> > > >
> > > > | Documentation/networking/ethtool-netlink.rst
> > > >
> > > > this is much better designed than the CAN netlink interface. It was=
 done
> > > > by the pros and much later than CAN. :D So I'd like to have a simil=
ar
> > > > structure for new CAN netlink stuff.
> > > >
> > > > So I think I'll remove this patch for now from can-next-testing. The
> > > > kernel internal interface to tdc is still OK, we can leave it as is=
 and
> > > > change it if needed. But netlink is user space and I'd like to have=
 it
> > > > properly designed.
> > >
> > > Understood. However, I will need more time to read and understand
> > > the ethtool-netlink interface. The new patch will come later, I
> > > do not know when.
> >
> > No Problem
>=20
> I started to look at Ethtool netlink, but as far as my understanding
> goes, this seems purely restricted to the ethtool application (i.e.
> not to iproute2). I double checked the latest versions of iproute2
> but there isn=E2=80=99t a single #include <linux/ethtool_netlink.h> nor
> anything else related to that new API.
>=20
> Please let me know if I missed the point.

For example have a look at the RINGS_GET of ethtool-netlink.rst:

| RINGS_GET
| =3D=3D=3D=3D=3D=3D=3D=3D=3D
|=20
| Gets ring sizes like ``ETHTOOL_GRINGPARAM`` ioctl request.
|=20
| Request contents:
|=20
|   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
|   ``ETHTOOL_A_RINGS_HEADER``            nested  request header
|   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
|=20
| Kernel response contents:
|=20
|   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
|   ``ETHTOOL_A_RINGS_HEADER``            nested  reply header
|   ``ETHTOOL_A_RINGS_RX_MAX``            u32     max size of RX ring
|   ``ETHTOOL_A_RINGS_RX_MINI_MAX``       u32     max size of RX mini ring
|   ``ETHTOOL_A_RINGS_RX_JUMBO_MAX``      u32     max size of RX jumbo ring
|   ``ETHTOOL_A_RINGS_TX_MAX``            u32     max size of TX ring
|   ``ETHTOOL_A_RINGS_RX``                u32     size of RX ring
|   ``ETHTOOL_A_RINGS_RX_MINI``           u32     size of RX mini ring
|   ``ETHTOOL_A_RINGS_RX_JUMBO``          u32     size of RX jumbo ring
|   ``ETHTOOL_A_RINGS_TX``                u32     size of TX ring
|   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The response consists of a header and several nested values. This looks
to me to be the netlink way to serialize a C-struct. If I understand
your code correctly it was just the values without the nested header.

| RINGS_SET
| =3D=3D=3D=3D=3D=3D=3D=3D=3D
|=20
| Sets ring sizes like ``ETHTOOL_SRINGPARAM`` ioctl request.
|=20
| Request contents:
|=20
|   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
|   ``ETHTOOL_A_RINGS_HEADER``            nested  reply header
|   ``ETHTOOL_A_RINGS_RX``                u32     size of RX ring
|   ``ETHTOOL_A_RINGS_RX_MINI``           u32     size of RX mini ring
|   ``ETHTOOL_A_RINGS_RX_JUMBO``          u32     size of RX jumbo ring
|   ``ETHTOOL_A_RINGS_TX``                u32     size of TX ring
|   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
|=20
| Kernel checks that requested ring sizes do not exceed limits reported by
| driver. Driver may impose additional constraints and may not suspport all
| attributes.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--hxmxc2sdywojaloz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBtajoACgkQqclaivrt
76lENQgAmuKCWhic3EgOzvmL6MOscJQ17Cl8Ss3YW8SfiruAj50mbFyRyTWOtZ3l
BJNNrU+U5IJz5rBdgDLWVysm7I1oP8o2Wnk0NWTfGPN6kluRcnoEvNI8uduprY4I
afixKPJ1LSGAShSgv1LEpa5a5dYQn4ACdnhg0YA0oIJakdL6DdZ9fViC0xyyVezy
pEvxFXvekk2ABHiMbhGSOI2cI9PduqwHNck5SMWTlB0K8IQd3PlCeZ7QVDOHJhM7
0Ta3KbFoeG36T4emxWT3fi91ArqQxqSGXsQPU9H3v0xAunXltgNuwgn5TER759oc
ggHhDcEbrKZGB8RbXZyYLCvyUjWPiQ==
=Zw6I
-----END PGP SIGNATURE-----

--hxmxc2sdywojaloz--
