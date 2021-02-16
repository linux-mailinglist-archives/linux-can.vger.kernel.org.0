Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C02C31CA8D
	for <lists+linux-can@lfdr.de>; Tue, 16 Feb 2021 13:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhBPMdT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Feb 2021 07:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhBPMdS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Feb 2021 07:33:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90639C061574
        for <linux-can@vger.kernel.org>; Tue, 16 Feb 2021 04:32:38 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lBzWv-00043D-3R; Tue, 16 Feb 2021 13:32:37 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:c976:249:a7:a1bb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E08AC5E23A0;
        Tue, 16 Feb 2021 12:32:35 +0000 (UTC)
Date:   Tue, 16 Feb 2021 13:32:35 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
Message-ID: <20210216123235.i63toczore5vfftp@hardanger.blackshift.org>
References: <20210215144509.rhds7oybzat6u27w@hardanger.blackshift.org>
 <CAALJrqgrmzGHZX+iiMYwMkVMpxtf_3fWYkVA-iMdPOxpGzrCRQ@mail.gmail.com>
 <20210215174408.eea3okssfzjsqrly@hardanger.blackshift.org>
 <CAALJrqj=QC1to9ja0CeL76JxVF1iwjsW7YJHs18VbXea=PvBGg@mail.gmail.com>
 <c47647cd-01c1-a924-263d-72c84b36b2e0@pengutronix.de>
 <CAALJrqiAFR7bacR3eB40OU0fbM1QOc-xnvDtts5tDh5cE+3rrw@mail.gmail.com>
 <20210216102835.v5goqyksqsu6h6xr@hardanger.blackshift.org>
 <CAALJrqiVdmLQr7q2ijbWq70RD6PTD8PtVX_zmLW9=uNdc57WqA@mail.gmail.com>
 <20210216111930.pcg4e7cildzuri6d@hardanger.blackshift.org>
 <CAALJrqjGKPo+5B_qBX1b0hAheiaZk4so85OrjQT=1d51Vj8a=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="peabjqmd7c5aum6u"
Content-Disposition: inline
In-Reply-To: <CAALJrqjGKPo+5B_qBX1b0hAheiaZk4so85OrjQT=1d51Vj8a=w@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--peabjqmd7c5aum6u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.02.2021 11:38:17, Torin Cooper-Bennun wrote:
> > Where do you see these blank frames? On the sending rpi with candump? An
> > on the bus (with a second system) you only see the full 8 byte long
> > frames?
>=20
> My apologies, I should have clarified. The Pi is receiving all these
> frames. The sending node is sending the same frame every time (I'll
> have it send increasing IDs from now on).

This means the tcan receives two "ghost" frames here?

| can0  001   [8]  00 01 02 03 04 05 06 07
| can0  001   [8]  00 01 02 03 04 05 06 07
| can0  001   [8]  00 01 02 03 04 05 06 07
| can0  000   [0]
| can0  000   [0]
| can0  001   [8]  00 01 02 03 04 05 06 07
| can0  001   [8]  00 01 02 03 04 05 06 07

If the tcan driver shuts down the tcan chip properly, depending on your
setup, the sending CAN node might be the only one on the bus, leading to
repeat the CAN frame due to no ACK. This easily triggers race conditions
when starting up the tcan driver again.

With proper timestamps and increasing CAN-IDs you can figure out if the
driver clears the bits on the CAN messages (number of blank frames =3D=3D
number of missing frames) or if it "inserts" blank frames (=3D=3D no missing
frames).

If the number of blank frames equals the number of missing frames, then
have a look where the message RAM is initialized:

    https://elixir.bootlin.com/linux/latest/source/drivers/net/can/m_can/tc=
an4x5x.c#L335

Oh! This doesn't look right :(

I think it's a bad idea to first bring the chip into normal mode and
then initialize the RAM.

> > Use "candump any,0~0,#FFFFFFFF -extA" to get RX/TX annotation.
> > Use "cangen -Ii -L8 -D000102030405060708 -g100 can0" to get increasing
> > CAN-IDs, so you can figure out if a CAN frame got lost.
>=20
> Fab, thank you.
>=20
> > Seems I have to add the TX path to the list of broken things...
> >
> > The mcp251xfd driver can be used as a template for the tcan4x5x driver.
>=20
> I'll go ahead and compare with mcp251xfd and continue testing. I'll be
> working towards getting this stable in the coming weeks.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--peabjqmd7c5aum6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmAru2AACgkQqclaivrt
76n/aggAnRBL7xU0jmYlV4t2Kv8fBMiDelv2zngSMhjiF6aucxt/IHYc+NPyggIY
td81ML7NlAyqNP9TQRgqdJYQOyVp6qQQ5CGcLv3eHAhs4nrzxLOCEqmhhllhYCdZ
s47yWRO4biR6wN36gxXarwCyoPdtuDuJTE8MNm7bkIHVA3AmhXmLrJ28U+ZuzwCq
ZVsTIS3dERHeRbp8VdJv9RDKHit1wSaO1ddXgcd8gXZUk5tCXnc4Kn5M1+hcvlp/
XhLu+1aJJupSe1bRUAQbfWD8Kpg+wu1KY4OvYiw3W2EqwvKrxi4jb0eZ24soNk8N
daDOxXVJWNXjkX/nz6PhIrV9eO7uBQ==
=SNGa
-----END PGP SIGNATURE-----

--peabjqmd7c5aum6u--
