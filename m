Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CD6686235
	for <lists+linux-can@lfdr.de>; Wed,  1 Feb 2023 09:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBAI6W (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 1 Feb 2023 03:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBAI6V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2023 03:58:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9221CDD8
        for <linux-can@vger.kernel.org>; Wed,  1 Feb 2023 00:58:20 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pN8wb-00007V-B7; Wed, 01 Feb 2023 09:58:17 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:8296:86a1:ae4c:835e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3F2FB16C052;
        Wed,  1 Feb 2023 08:58:16 +0000 (UTC)
Date:   Wed, 1 Feb 2023 09:58:10 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Thomas.Kopp@microchip.com, linux-can@vger.kernel.org,
        mark@baggywrinkle.co.uk
Subject: Re: [PATCH 2/5] can: bittiming: can_calc_bittiming(): make use of
 min3()
Message-ID: <20230201085810.aoqjbqqojzy65xbz@pengutronix.de>
References: <20220907103845.3929288-1-mkl@pengutronix.de>
 <20220907103845.3929288-3-mkl@pengutronix.de>
 <CAMZ6RqKqhmTgUZiwe5uqUjBDnhhC2iOjZ791+Y845btJYwVDKg@mail.gmail.com>
 <BL3PR11MB64844E3FC13C55433CDD0B3DFB449@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqJ8rhSVwnNHaxyRBg24PoH4EU8prEGsZO56wU6ozfMdAA@mail.gmail.com>
 <20230131160436.2vfszb3qqsyx3ea7@pengutronix.de>
 <CAMZ6RqJDARUjhDF5k1DydZMr=YWU9QSXDshTwznV4oh79a7niQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="id56r6jijyev54y7"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJDARUjhDF5k1DydZMr=YWU9QSXDshTwznV4oh79a7niQ@mail.gmail.com>
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


--id56r6jijyev54y7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.02.2023 14:49:23, Vincent Mailhol wrote:
> > I've converted the existing netdev_err() NL_SET_ERR_MSG_FMT(). This
> > means the error message is transported via netlink to user space and
> > printed by the "ip" tool.
>=20
> I was not aware of this NL_SET_ERR_MSG_FMT() thing, and let me say
> that I really like that solution!
>=20
> > | # ip link set flexcan0 txqueuelen 10 type can bitrate 2200000
> > | Warning: bitrate error 2.5%.
>=20
> The Linux coding style says:
>=20
>   Kernel messages do not have to be terminated with a period.
>=20
> Ref: https://www.kernel.org/doc/html/latest/process/coding-style.html#pri=
nting-kernel-messages
>=20
> However, I am not sure if this also applies to the ip tool.

I think the period is added by "ip".

> > |
> > | # ip link set flexcan0 txqueuelen 10 type can bitrate 22000000
> > | Error: bitrate error 80.5% too high.
> >
> > This is the error message for the SJW check:
> >
> > | # ip link set flexcan0 txqueuelen 10 type can bitrate 500000 sjw 3
> > | Error: SJW 3 bigger than phase_seg1 6 and/or phase_seg2 2.
>=20
> At that point in the code, I assume that sjw was already validated
> against sjw_max. While not impossible, I think that having sjw bigger
> than both phase_seg1 and phase_seg2 at the same time is uncommon. I
> suggest to split the error message in two and only print the relevant
> one:
>=20
>   Error: SJW 3 bigger than phase_seg1 x
>   Error: SJW 3 bigger than phase_seg2 x
>=20
> If the user still manages to violate both, only the phase_seg1 error
> message is displayed.

Makes sense.

> > Maybe add a '=3D' between the phase_seg and the actual number:
> >
> > | Error: SJW 3 bigger than phase_seg1=3D6 and/or phase_seg2=3D2.
>=20
> If you ask me my preferences, I will go with column:
>=20
>   Error: SJW: 3 bigger than phase_seg1: 6 and/or phase_seg2: 2.
>=20
> But I will not complain if you pick anything else.

Period looks good.

What about the error value? Always return -EINVAL instead of a mix of
-EINVAL and -ERANGE?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--id56r6jijyev54y7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPaKaAACgkQrX5LkNig
010QwAf/WtU20tJHkCe9M+jNWqdxkksygPqlTx3ACHJvHS9HeUJPuTAPynYzBkK/
dePaG+LpKPjtujoAT5SXf5V6X+Bqln1JHws2/ZiquzrlRFHi3p5DFI37epcJaQ4P
jqsFbwgXDWOGqosDB8FvVwWuHnRAQ4RQ0dzNhJa4ZMt4o4R2X5rnJAtSPQIXybUu
w4t1sBnljtbK69jtKUpgaLounpkYYCSBx8k+Cafzo86O28fSmmL2K0STeAizSFuO
jODaOlZP10PEyomcf+/fBPz2C3rbS4iLBd8KuqOPdxEUA07qoXbffMH4Pfnb+GwB
KM2SrC/wB7a4APzN3g0AY54RzTouhA==
=jSbp
-----END PGP SIGNATURE-----

--id56r6jijyev54y7--
