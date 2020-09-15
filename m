Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530AB26B47D
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 01:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgIOXZX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Sep 2020 19:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgIOXZE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 19:25:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7BCC06174A
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2020 16:25:03 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kIKJq-0000uQ-6j; Wed, 16 Sep 2020 01:25:02 +0200
Received: from [IPv6:2a03:f580:87bc:d400:8d0c:cfd0:3f99:a545] (unknown [IPv6:2a03:f580:87bc:d400:8d0c:cfd0:3f99:a545])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2E6A656138C;
        Tue, 15 Sep 2020 23:25:01 +0000 (UTC)
To:     Kirby Nankivell <kirby@kjn.com.au>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <CAJPxYURwMdZqT+j10U4XRVesF43g6uyysCEncvyCJCp-83sNXg@mail.gmail.com>
 <61a5dd2e-7c80-3d33-34ef-7aaa4e8f2a7f@pengutronix.de>
 <CAJPxYUQz6Foon+CbHW03CAjMTs7VYt8gmZYcr=hCgCmXzgMw5w@mail.gmail.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: MCP25xxFD Driver Error (-47)
Message-ID: <2f3b0c9f-8f02-a664-670e-f2cb59dfcaca@pengutronix.de>
Date:   Wed, 16 Sep 2020 01:24:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJPxYUQz6Foon+CbHW03CAjMTs7VYt8gmZYcr=hCgCmXzgMw5w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="CJjeC1xnNlqe41azn3adCb2YBO7mqQQ9L"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CJjeC1xnNlqe41azn3adCb2YBO7mqQQ9L
Content-Type: multipart/mixed; boundary="5jn82eDwO52S0kGU38xCwhheWLIeMfalb";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kirby Nankivell <kirby@kjn.com.au>
Cc: linux-can <linux-can@vger.kernel.org>
Message-ID: <2f3b0c9f-8f02-a664-670e-f2cb59dfcaca@pengutronix.de>
Subject: Re: MCP25xxFD Driver Error (-47)
References: <CAJPxYURwMdZqT+j10U4XRVesF43g6uyysCEncvyCJCp-83sNXg@mail.gmail.com>
 <61a5dd2e-7c80-3d33-34ef-7aaa4e8f2a7f@pengutronix.de>
 <CAJPxYUQz6Foon+CbHW03CAjMTs7VYt8gmZYcr=hCgCmXzgMw5w@mail.gmail.com>
In-Reply-To: <CAJPxYUQz6Foon+CbHW03CAjMTs7VYt8gmZYcr=hCgCmXzgMw5w@mail.gmail.com>

--5jn82eDwO52S0kGU38xCwhheWLIeMfalb
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 9/16/20 12:32 AM, Kirby Nankivell wrote:
> I was able to work my way through the initial issues, I was able to res=
olve the
> device tree interrupt setting.
> This fixed all of the initial issues that I was experiencing, with resp=
ect to
> the bring up of the device and the bringing of the link online.
>=20
> The final DTS fragment ended up like this (Allwinner H3 Base):

> 	mcp2518fd@1 {
> 		reg =3D <1>;
> 		compatible =3D "microchip,mcp2518fd";
> 		clocks =3D <&can0_osc_fixed>;
> 		pinctrl-names =3D "default";
> 		pinctrl-0 =3D <&can0_pin_irq>;
> 		spi-max-frequency =3D <8823529>;
> 		interrupts-extended =3D <&pio 1 1 IRQ_TYPE_LEVEL_LOW>; //PB1
> 		status =3D "okay";
> 	};

What about the spi0 node?

> The clock frequency was chosen on your prior advice: being less than 50=
% of the
> controller clock speed (10Mhz), and a factor of 600/2x as limited by th=
e
> Allwinner SPI peripheral, in this case; 600 / (2*34).
In my H3 DT, I configure the SPI core to 600 MHz, not sure if the V3s sup=
ports that.

The driver will use the DT max frequency as an upper bound. If you use a =
recent
kernel (v5.7 or newer) or have included my patch:

    spi: spi-sun6i: sun6i_spi_transfer_one():
         fix setting of clock rate

the spi host driver will pick up a proper clock rate.

>     [ 1.255123] CAN device driver interface
>     [ 1.259309] spi_master spi0: will run message pump with realtime pr=
iority
>     [ 1.304566] mcp25xxfd spi0.1 can0: MCP2518FD rev0.0 (-RX_INT -MAB_N=
O_WARN
>     +CRC_REG +CRC_RX +CRC_TX +ECC -HD m:8.82MHz r:8.82MHz e:8.33MHz)
>     successfully initialized.

"m:8.82MHz r:8.82MHz e:8.33MHz"

m =3D maximum as defined by DT
r =3D requested by driver
e =3D effective speed used by the host driver

> However that was short lived; I couldn't receive a single message (cand=
ump 500k)
> without getting a crc error:
>=20
>     [ 48.469759] mcp25xxfd spi0.1 can0: CRC read error at address 0x001=
c
>     (length=3D4, data=3D00 00 1a 3f, CRC=3D0x1e7c).
>     [ 48.479730] mcp25xxfd spi0.1 can0: IRQ handler returned -74 (intf=3D=
0x3f1a0002).

Can you compile the mcp25xxfd-regmap.c with adding a:

    #define DEBUG

prior to any of the #include statements. That should give some more debug=
ging
output with enabled CRC mode. Please post that here.

> I used the advice previously posted and disabled the CRC mode quirks in=
 the
> driver prior to build which got me some results (I was able to load-tes=
t once at
> around 15% bus utilisation at 500k), however now I am getting persisten=
t errors
> after a few packets:

Without CRC, you'll not notice any errors on the SPI bus, better keep it =
enabled.

>     [ 382.629705] mcp25xxfd spi0.1 can0: RX tail of chip (26) and ours =
(27)
>     inconsistent.
>     [ 382.637422] mcp25xxfd spi0.1 can0: IRQ handler mcp25xxfd_handle_r=
xif()
>     returned -84.
>     [ 382.645189] mcp25xxfd spi0.1 can0: IRQ handler returned -84 (intf=
=3D0x3e1a0002).
>=20
> It seems horribly inconsistent, sometimes high busload is ok, sometimes=
 anything
> more than 250ms in-between single frames will fault the driver. The onl=
y
> solution is to=C2=A0ip link down and bring up again, however it is like=
ly to occur
> again the next time the link is online and receiving traffic.I initiall=
y=C2=A0thought
> this was related to ECC, however disabling this mode did not improve th=
ings.=C2=A0
>=20
> Any thoughts here?

Can you remove the display from the SPI and test again.
Can you try to limit the spi speed via DT even more, e.g. to 5MHz?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--5jn82eDwO52S0kGU38xCwhheWLIeMfalb--

--CJjeC1xnNlqe41azn3adCb2YBO7mqQQ9L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl9hTUcACgkQqclaivrt
76n9nwgAm5U2IVnDdYAplYYeQMyqcpY++Clr8uS/GC1lkDq4KRGPEqi0qqcc9PlP
edrlIiEpxFhd96wCNCwsjmnZIPHJbIX+pgp+wFMxLoOHXvWDY8Z7rGRlpWkgnAYk
jkovMfpU2p9HLD1jlBMK3dpG/aJMBj3IugeH1iCYM9mshjfNNpc2wJLpyrbxqzZf
WmtLZKYmOlsuJCvwI7PyMBAuqyH0g7e+2JE8K5SIJwAot6lWrMFVvPr5eVmUStHi
2Ds6E2YKEqtGJFtyLC7pwY2uSrXfO3c6noQGlZ2RpNQQGEViUoq/MF8UBXYEcbuD
TzWYOmSL1/aqDY1J8QsTaH7EDg7I1g==
=F5sQ
-----END PGP SIGNATURE-----

--CJjeC1xnNlqe41azn3adCb2YBO7mqQQ9L--
