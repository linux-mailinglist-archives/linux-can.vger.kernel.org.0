Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C627332674
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 14:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhCINTu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 08:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhCINT0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 08:19:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612E8C06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 05:19:26 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJcGi-0005bv-64; Tue, 09 Mar 2021 14:19:24 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4699:faa8:8510:ac25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B6B585F18AD;
        Tue,  9 Mar 2021 13:19:22 +0000 (UTC)
Date:   Tue, 9 Mar 2021 14:19:21 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 4/5] can: add netlink interface for CAN-FD Transmitter
 Delay Compensation (TDC)
Message-ID: <20210309131921.7b5jhq3bak2yiv5w@pengutronix.de>
References: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
 <20210224002008.4158-5-mailhol.vincent@wanadoo.fr>
 <CAMZ6RqLZ+LidnRka1-pX8dkHCaqNs3=bRujsMEs8LXnq0Y_E9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kza7ln2wosqaajl4"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLZ+LidnRka1-pX8dkHCaqNs3=bRujsMEs8LXnq0Y_E9Q@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--kza7ln2wosqaajl4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2021 22:16:45, Vincent MAILHOL wrote:
> On Wed. 24 Feb 2021 at 09:20, Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> > diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlin=
k.c
> > index c19eef775ec8..c3f75c09d6c8 100644
> > --- a/drivers/net/can/dev/netlink.c
> > +++ b/drivers/net/can/dev/netlink.c
> > @@ -19,6 +19,12 @@ static const struct nla_policy can_policy[IFLA_CAN_M=
AX + 1] =3D {
> >         [IFLA_CAN_DATA_BITTIMING] =3D { .len =3D sizeof(struct can_bitt=
iming) },
> >         [IFLA_CAN_DATA_BITTIMING_CONST] =3D { .len =3D sizeof(struct ca=
n_bittiming_const) },
> >         [IFLA_CAN_TERMINATION] =3D { .type =3D NLA_U16 },
> > +       [IFLA_CAN_TDCV] =3D { .type =3D NLA_U32 },
> > +       [IFLA_CAN_TDCV_MAX_CONST] =3D { .type =3D NLA_U32 },
> > +       [IFLA_CAN_TDCO] =3D { .type =3D NLA_U32 },
> > +       [IFLA_CAN_TDCO_MAX_CONST] =3D { .type =3D NLA_U32 },
> > +       [IFLA_CAN_TDCF] =3D { .type =3D NLA_U32 },
> > +       [IFLA_CAN_TDCF_MAX_CONST] =3D { .type =3D NLA_U32 },
> >  };
>=20
> Looking back at my patch, I just realized that the values are not
> ordered in a consistent way. Here, I alternate between the TDCx
> and the TDCx_CONST...
>=20
> > (...)
>=20
> > diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/=
netlink.h
> > index f730d443b918..e69c4b330ae6 100644
> > --- a/include/uapi/linux/can/netlink.h
> > +++ b/include/uapi/linux/can/netlink.h
> > @@ -134,6 +134,12 @@ enum {
> >         IFLA_CAN_BITRATE_CONST,
> >         IFLA_CAN_DATA_BITRATE_CONST,
> >         IFLA_CAN_BITRATE_MAX,
> > +       IFLA_CAN_TDCV,
> > +       IFLA_CAN_TDCO,
> > +       IFLA_CAN_TDCF,
> > +       IFLA_CAN_TDCV_MAX_CONST,
> > +       IFLA_CAN_TDCO_MAX_CONST,
> > +       IFLA_CAN_TDCF_MAX_CONST,
> >         __IFLA_CAN_MAX
> >  };
>=20
> ... and there, all the TDCx and the TDCx_CONST are grouped together.
>=20
> Marc, because the patches are already in the
> linux-can-next/testing, how should I proceed to fix this? Should
> I resend the full patch series with the changes or can I just
> prepare one patch and ask you to squash it?

Please send an incremental patch and I'll squash it.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--kza7ln2wosqaajl4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBHddcACgkQqclaivrt
76knrQf8Cuz4Chy7/nuDrKjOGFTAWpiO+aww9QCM4DdiJUK1/owvizH5DCzzyrb8
cBW/Rdw3ko6NBzsd0AOO9vlIfsyfeuu2rYOuOYk7mqMRi29i2GUa286qomkyhyGu
NxWDB36HTyHOnz4fP3DbOVXrVrMshxJnId3IYRXLfjL1qmQMSZY6Hty+xs1+0A/M
e0HIHoAs+nd1RmkGwMdDjLZ+9ySc8SO5BU8blK+vh4zVqnhna7ZAwWZsutWBW91M
kKsARp8DyFzgfhOCjVjaVRW+YhG52Ff1fnDKEmjVf+aqMX5FOTBirQyIBTH7pX+7
QjDzvGn4IfOxwiUL6rfSoL7rPhNdWw==
=IJJ6
-----END PGP SIGNATURE-----

--kza7ln2wosqaajl4--
