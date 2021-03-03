Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF70F32C592
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 01:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345256AbhCDAXh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356447AbhCCH1m (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 02:27:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5082C06178C
        for <linux-can@vger.kernel.org>; Tue,  2 Mar 2021 23:26:58 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHLuK-0001WT-IZ; Wed, 03 Mar 2021 08:26:56 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:a20d:2fb6:f2cb:982e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 84A4C5ECA28;
        Wed,  3 Mar 2021 07:26:54 +0000 (UTC)
Date:   Wed, 3 Mar 2021 08:26:53 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     =?utf-8?B?dWtyZm9pbC5jb20sIEPRgtGD0LTQuNC+0L/QsNC6INCj0LrRgNCw0LjQvdCw?=
         =?utf-8?B?LCDQktC+0YHRgtC+0YfQvdGL0Lkg0YDQtdCz0LjQvtC9?= 
        <ukrfoil@gmail.com>
Cc:     =?utf-8?B?U2NobMO8w59sZXIs?= Timo <t.schluessler@krause.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: mcp251x hangs during ifup
Message-ID: <20210303072653.zb66tkdlsxtval5n@pengutronix.de>
References: <20210301165856.37gvqkomvjkjvbj2@pengutronix.de>
 <CAMZ6RqKfXR9cHxjvnPwxjWHWEuxYNV9V4qLSd0ZQGP0JOMKX0w@mail.gmail.com>
 <20210302071901.ptwvejkedascbdsv@pengutronix.de>
 <638520bccd0c44d091d5715fe7d303ec@HG-SRV-053.HG.local>
 <CACGOs=TG4jyXKHBfPGDEJp1gSA+PyNVqCM7grPGMpe9+wYDBLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g6d3wkx34hkelqqe"
Content-Disposition: inline
In-Reply-To: <CACGOs=TG4jyXKHBfPGDEJp1gSA+PyNVqCM7grPGMpe9+wYDBLA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--g6d3wkx34hkelqqe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.03.2021 22:10:49, ukrfoil.com, C=D1=82=D1=83=D0=B4=D0=B8=D0=BE=D0=BF=
=D0=B0=D0=BA =D0=A3=D0=BA=D1=80=D0=B0=D0=B8=D0=BD=D0=B0, =D0=92=D0=BE=D1=81=
=D1=82=D0=BE=D1=87=D0=BD=D1=8B=D0=B9 =D1=80=D0=B5=D0=B3=D0=B8=D0=BE=D0=BD w=
rote:
> The reason for the terminal freezing on these boards (as an example of
> Nanopi NEO) occurs in this function when trying to disable interrupts
> disable_irq(spi->irq); If you comment out this given call, the hangs
> do not occur.

Nice debugging!

Can you give us the complete device tree and the output of:

    cat /proc/interrupts

Maybe there's a shared interrupt that's vital for your system.

One note:

| can0: can@0 {
|	reg =3D <0>;
|	compatible =3D "microchip,mcp2515";
|	pinctrl-names =3D "default";
|	pinctrl-0 =3D <&can0_pin_irq>;
|	interrupt-parent =3D <&pio>;
|	interrupts =3D <6 8 IRQ_TYPE_EDGE_FALLING>;

You better use IRQ_TYPE_LEVEL_LOW instead of IRQ_TYPE_EDGE_FALLING, but
that's unrelated to this problem.

|	clocks =3D <&can0_osc_fixed>;
|	spi-max-frequency =3D <10000000>;
|	gpio-controller;
|	gpio-cells =3D <2>;
|	status =3D "okay";
| };

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--g6d3wkx34hkelqqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA/OjoACgkQqclaivrt
76lrtQf+N1cUhzOERuQSwy+39cWItCxV3wq5SP6x+deqmbXabbz9QmgoMivVOhs8
giIGUFzx67pcKu2u0tCb+vC1mylkVsePmK693VNcWU2rA3FGNWL+oRL5902fcSWY
xcynmyawHxx7/gPhIVlnt8rKaTclxufD0RGX/dBXaGPOW3pbFXYizWNu5RQjiCp4
QE/RHGzO22NQO1FZDCG0MBD7rkh3xUddnXcfHcEWjHFTlaQNDRAOZstmBAGfUYYw
c857+vLWKi7bPUNoArbbf8sCtecbtCJVKWXYN1njudNvQOhra93g67oOSrw2wSgA
YhvibbRhBl/QuibL04duB7IVM6YDBQ==
=lkSh
-----END PGP SIGNATURE-----

--g6d3wkx34hkelqqe--
