Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209D231C0E4
	for <lists+linux-can@lfdr.de>; Mon, 15 Feb 2021 18:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhBORpP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 Feb 2021 12:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhBORow (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 Feb 2021 12:44:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5482CC0613D6
        for <linux-can@vger.kernel.org>; Mon, 15 Feb 2021 09:44:12 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lBhus-0003LX-8y; Mon, 15 Feb 2021 18:44:10 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:6c58:64fe:fb36:2083])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E4F745E102E;
        Mon, 15 Feb 2021 17:44:08 +0000 (UTC)
Date:   Mon, 15 Feb 2021 18:44:08 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-can@vger.kernel.org
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
Message-ID: <20210215174408.eea3okssfzjsqrly@hardanger.blackshift.org>
References: <602651f9.1c69fb81.302a5.647d@mx.google.com>
 <20210215144509.rhds7oybzat6u27w@hardanger.blackshift.org>
 <CAALJrqgrmzGHZX+iiMYwMkVMpxtf_3fWYkVA-iMdPOxpGzrCRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5qd3pwk46pdvfw5k"
Content-Disposition: inline
In-Reply-To: <CAALJrqgrmzGHZX+iiMYwMkVMpxtf_3fWYkVA-iMdPOxpGzrCRQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--5qd3pwk46pdvfw5k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've added the linux-can mailing list on Cc.

On 15.02.2021 15:41:57, Torin Cooper-Bennun wrote:
> On Mon, 15 Feb 2021 at 14:45, Marc Kleine-Budde <mkl@pengutronix.de> wrot=
e:
> > Sadly, the driver is still not in good shape...I think it will explode
> > as soon as you receive a CAN frame on the rpi, as the frames are passed
> > into the networking stack from the wrong context...
> >
> > Maybe I'll find some time to get receive properly working.
>=20
> I'm afraid I've just found that myself -- in fact, I'm having problems
> getting TX to behave as well. I think the chip configuration is
> incorrect (at the very least, the chip is never put into standby mode,
> which the datasheet says is paramount!)

Do you have the wake-gpio in your DT? This one works for me:

|         tcan4x5x: tcan4x5x@1 {
|                 reg =3D <1>;
|                 compatible =3D "ti,tcan4x5x";
|                 vsup-supply =3D <&reg_tcan4x5x_vsup>;
|                 pinctrl-names =3D "default";
|                 pinctrl-0 =3D <&pinctrl_tcan4x5x>;
|                 spi-max-frequency =3D <10000000>;
|                 bosch,mram-cfg =3D <0x0 0 0 16 0 0 1 1>;
|                 interrupt-parent =3D <&gpio4>;
|                 interrupts =3D <31 IRQ_TYPE_LEVEL_LOW>;
|                 clock-names =3D "cclk";
|                 clocks =3D <&tcan4x5x_osc>;
|                 device-wake-gpios =3D <&gpio5 5 GPIO_ACTIVE_HIGH>;
|         };

> The current config procedure
> ends up with bizarre activity on the CAN lines. I also observed
> intermittent refcount warnings during driver use.

You mean something like these...

| [  543.116807] WARNING: CPU: 0 PID: 11 at lib/refcount.c:25 refcount_warn=
_saturate+0x108/0x174
| [  543.116820] refcount_t: addition on 0; use-after-free.

with can_put_echo_skb() in the call stack?

| [  543.117745] [<bf186edc>] (can_put_echo_skb [can_dev]) from [<bf1d67ec>=
] (mcp251xfd_start_xmit+0x2b0/0x3bc [mcp251xfd])

We tried to fix the problem, but the patch made the problem more
visible. Working on this.

> I've cherry-picked the relevant changes onto RPi kernel 5.10 :
> https://github.com/tcbennun/linux/commit/c32a0d422b551390f6960243f29e1afa=
cfe30d48
> and I'll be next trying the bleeding-edge driver with 5.11.
>=20
> > BTW: what kind of hardware are you using?
>=20
> This is a Raspberry Pi 3 Model B v1.2, hosting a TCAN4550 on spi0. The
> external oscillator for the TCAN4550 is 20 MHz.

Is that a custom tcan pi hat, or is it officially sold somewhere?

> Since you've confirmed it needs work, I'll probably be able to put
> some time into it myself.

First thing I'd do is to rewrite the RX function and IRQ handler for the
"peripheral", that's the code path used for the SPI attached m-can
core. TX doesn't look efficient, but it should work at least.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5qd3pwk46pdvfw5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmAqsuUACgkQqclaivrt
76l6WggAjkRrOXSQPRntlWxWF+3HvkiKBVi75w48XnU+wnvByezRtD87asAydrhi
qdhZkJTi2XwYaLHoUGmuNoBHdkAp/5lPpt2kEptk6JTUh9WXYMN2Su5aYXUJ8rVe
MRezPtqNqNpenJGfMXTxVyuKfHQNL3bkijG4K/tLD/VTVD6rLZ9bqm8NEqfa1yVg
m6vc1J8dUg2VfMljdNinRXoVTVDlteAEvbZpfdOA0XvipAoUeE+Jc6xrASYgoJc6
i1+3P+/X1w/UNTXc2V0mdX9dEDbRpeFT8V2E6a97Y35WWxoxZT7eU8IX01U4UD4o
W+TZOv+vlWra/P+AeI2uPQNfsZoaBw==
=wCfD
-----END PGP SIGNATURE-----

--5qd3pwk46pdvfw5k--
