Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E643687991
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 10:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjBBJ4P (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 04:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjBBJ4O (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 04:56:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983779020
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 01:56:04 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNWJx-0003M4-HG; Thu, 02 Feb 2023 10:55:57 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:fff9:bfd9:c514:9ad9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B3B8016D140;
        Thu,  2 Feb 2023 09:55:56 +0000 (UTC)
Date:   Thu, 2 Feb 2023 10:55:48 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Thomas.Kopp@microchip.com, linux-can@vger.kernel.org,
        mark@baggywrinkle.co.uk
Subject: Re: [PATCH 2/5] can: bittiming: can_calc_bittiming(): make use of
 min3()
Message-ID: <20230202095548.xkcnhfvdi2gn4s5i@pengutronix.de>
References: <20220907103845.3929288-1-mkl@pengutronix.de>
 <20220907103845.3929288-3-mkl@pengutronix.de>
 <CAMZ6RqKqhmTgUZiwe5uqUjBDnhhC2iOjZ791+Y845btJYwVDKg@mail.gmail.com>
 <BL3PR11MB64844E3FC13C55433CDD0B3DFB449@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqJ8rhSVwnNHaxyRBg24PoH4EU8prEGsZO56wU6ozfMdAA@mail.gmail.com>
 <20230131160436.2vfszb3qqsyx3ea7@pengutronix.de>
 <CAMZ6RqJDARUjhDF5k1DydZMr=YWU9QSXDshTwznV4oh79a7niQ@mail.gmail.com>
 <20230201085810.aoqjbqqojzy65xbz@pengutronix.de>
 <CAMZ6Rq+Jf6BUfrmZ3_biW-XigYO4-8BfPezjwhd68DfbhjCSnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zzmiuhtdw565dqpv"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+Jf6BUfrmZ3_biW-XigYO4-8BfPezjwhd68DfbhjCSnA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--zzmiuhtdw565dqpv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.02.2023 18:38:17, Vincent Mailhol wrote:
[...]
> > > > Maybe add a '=3D' between the phase_seg and the actual number:
> > > >
> > > > | Error: SJW 3 bigger than phase_seg1=3D6 and/or phase_seg2=3D2.
> > >
> > > If you ask me my preferences, I will go with column:
> > >
> > >   Error: SJW: 3 bigger than phase_seg1: 6 and/or phase_seg2: 2.
> > >
> > > But I will not complain if you pick anything else.
> >
> > Period looks good.

Now looks like this:

| sudo ip link set flexcan0 txqueuelen 10 type can bitrate 22000000
| Error: bitrate error: 80.5% too high.
|=20
| sudo ip link set flexcan0 txqueuelen 10 type can bitrate 2200000=20
| Warning: bitrate error: 2.5%.
|=20
| sudo ip link set flexcan0 txqueuelen 10 type can bitrate 1000000 sjw 10
| Error: sjw: 10 greater than max sjw: 4.
|=20
| sudo ip link set flexcan0 txqueuelen 10 type can prop-seg 3 phase-seg1 1 =
phase-seg2 8 tq 10 =20
| Error: resulting brp: 0 less than brp-min: 1.
|=20
| sudo ip link set flexcan0 txqueuelen 10 type can prop-seg 3 phase-seg1 4 =
phase-seg2 4 tq 30 sjw 5
| Error: sjw: 5 greater than max sjw: 4.
|=20
| sudo ip link set flexcan0 txqueuelen 10 type can prop-seg 4 phase-seg1 3 =
phase-seg2 4 tq 30 sjw 4
| Error: sjw: 4 greater than phase-seg1: 3.
|=20
| sudo ip link set flexcan0 txqueuelen 10 type can prop-seg 4 phase-seg1 4 =
phase-seg2 3 tq 30 sjw 4
| Error: sjw: 4 greater than phase-seg2: 3.

> > What about the error value? Always return -EINVAL instead of a mix of
> > -EINVAL and -ERANGE?
>=20
> Looking at the comments from uapi/asm-generic/errno-base.h:
>=20
>   #define EINVAL 22 /* Invalid argument */
>   #define ERANGE 34 /* Math result not representable */
>=20
> We are not dealing with some non-representable math results, so
> -ERANGE is technically incorrect. I did suggest -ERANGE in the past
> because it looks natural to me: we define a min and a max, i.e. its a
> range. But the doc tells me I am wrong. Naming the error -ENAN (Error
> Not A Number) would have been more explicit, but we are not going to
> rewrite UAPI error definitions.
>=20
> Go with -EINVAL This answer also applies to your next message and to
> everywhere else in netlink, I guess.

It's -EINVAL everywhere now.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--zzmiuhtdw565dqpv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmPbiKEACgkQvlAcSiqK
BOjuyQf/f8NYPc2Wk41a1KifNtPRg9TP2qjL3OzAYz8eIc/uPt8nTJRK+WFicOyG
3A9Yq/YT9hmoSfVh/4o49InCC/SuDLOMVbEL0NkWSywcwLsw7LxkRbk619nUUTlM
kdEP6F/SQuv+saTURLimtSdt0EGys5wayQWU2A/KnUJJL5/2/7XMOaOrryP9MeGP
XWzRuzvBQ2/X9u2xCWFrNWqcowhS3onvtv7Q43lCRt2cxhDH+V+mmUjkwXwXwewu
h9yDcjx5+24GWpbLMFoIVE2s6bzMmKWagUjqbQrA0uAnftsFzKWtkAHmjJRxsdXb
vcmZl11G2ZsMzDR8xac7tCDnDH1O/g==
=wtOb
-----END PGP SIGNATURE-----

--zzmiuhtdw565dqpv--
