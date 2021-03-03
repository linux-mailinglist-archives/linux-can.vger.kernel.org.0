Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E10932C595
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 01:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355368AbhCDAXn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842627AbhCCIJJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 03:09:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276DFC061794
        for <linux-can@vger.kernel.org>; Wed,  3 Mar 2021 00:08:29 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHMYV-00058L-AH; Wed, 03 Mar 2021 09:08:27 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:a20d:2fb6:f2cb:982e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D6FD55ECA5D;
        Wed,  3 Mar 2021 08:08:25 +0000 (UTC)
Date:   Wed, 3 Mar 2021 09:08:25 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     =?utf-8?B?dWtyZm9pbC5jb20sIEPRgtGD0LTQuNC+0L/QsNC6INCj0LrRgNCw0LjQvdCw?=
         =?utf-8?B?LCDQktC+0YHRgtC+0YfQvdGL0Lkg0YDQtdCz0LjQvtC9?= 
        <ukrfoil@gmail.com>
Cc:     =?utf-8?B?U2NobMO8w59sZXIs?= Timo <t.schluessler@krause.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: mcp251x hangs during ifup
Message-ID: <20210303080825.lcpphr2ihvuugfl7@pengutronix.de>
References: <20210301165856.37gvqkomvjkjvbj2@pengutronix.de>
 <CAMZ6RqKfXR9cHxjvnPwxjWHWEuxYNV9V4qLSd0ZQGP0JOMKX0w@mail.gmail.com>
 <20210302071901.ptwvejkedascbdsv@pengutronix.de>
 <638520bccd0c44d091d5715fe7d303ec@HG-SRV-053.HG.local>
 <CACGOs=TG4jyXKHBfPGDEJp1gSA+PyNVqCM7grPGMpe9+wYDBLA@mail.gmail.com>
 <20210303072653.zb66tkdlsxtval5n@pengutronix.de>
 <CACGOs=TJhoV99D=V-7xa8LG6Ftx8SWUO_XCHGAP3L1_UGLVm3w@mail.gmail.com>
 <20210303074841.me5egjpecebrpxc4@pengutronix.de>
 <CACGOs=SOxiN1PKhZvhTizH92vneKUOfjxL+9fg4-=JmHHgYtNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h2xue36szhfn2e5h"
Content-Disposition: inline
In-Reply-To: <CACGOs=SOxiN1PKhZvhTizH92vneKUOfjxL+9fg4-=JmHHgYtNw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--h2xue36szhfn2e5h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.03.2021 10:00:47, ukrfoil.com, C=D1=82=D1=83=D0=B4=D0=B8=D0=BE=D0=BF=
=D0=B0=D0=BA =D0=A3=D0=BA=D1=80=D0=B0=D0=B8=D0=BD=D0=B0, =D0=92=D0=BE=D1=81=
=D1=82=D0=BE=D1=87=D0=BD=D1=8B=D0=B9 =D1=80=D0=B5=D0=B3=D0=B8=D0=BE=D0=BD w=
rote:
> this with the IRQ_TYPE_EDGE_FALLING value

> > That looks good, the IRQ is not shared. Can you test again with
> > IRQ_TYPE_EDGE_FALLING in the DT instead of IRQ_TYPE_LEVEL_LOW?

Doh! Need more coffee.

Of course I mean try with IRQ_TYPE_LEVEL_LOW and check if the unmodified
mcp2515 driver with disable_irq() does work then.

> >
> > | can0: can@0 {
> > |       reg =3D <0>;
> > |       compatible =3D "microchip,mcp2515";
> > |       pinctrl-names =3D "default";
> > |       pinctrl-0 =3D <&can0_pin_irq>;
> > |       interrupt-parent =3D <&pio>;
> > |       interrupts =3D <6 8 IRQ_TYPE_EDGE_FALLING>;
> >
> > You better use IRQ_TYPE_LEVEL_LOW instead of IRQ_TYPE_EDGE_FALLING, but
> > that's unrelated to this problem.
> >
> > |       clocks =3D <&can0_osc_fixed>;
> > |       spi-max-frequency =3D <10000000>;
> > |       gpio-controller;
> > |       gpio-cells =3D <2>;
> > |       status =3D "okay";
> > | };

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--h2xue36szhfn2e5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA/Q/YACgkQqclaivrt
76mMJggAsDARtvoeSblvAol08AFiY24/uBBi1FxSX0In9CNxjfytw6YBdwOkd4P2
7jD58tOgmEWwgeBZSYcnNP9L/bU1oFnLY4tpJJZuqdjSzrobVXdi7+HYpk2/YIw4
par0qTUq9Dw1qvn8MQ82DTqQe86C3pmFEG9co8y8nC8FIKkJIEakbi8IlCaZzY7C
mQ40ASFqXi4qXi5YuBlMui8UVlFTUBgfY6Pq/oaowYquKzCjzBXegCbwLbjUHOmq
1atpXOlaov6dwMbab90E6DHU86A1Arkfehkr7wAqnWsIGTc6B1AhLA20TuDEIwmk
nQERbPqmVYoTTHmEjiIC26+e0KWMLg==
=es63
-----END PGP SIGNATURE-----

--h2xue36szhfn2e5h--
