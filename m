Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C46D26D6A3
	for <lists+linux-can@lfdr.de>; Thu, 17 Sep 2020 10:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgIQIbP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Sep 2020 04:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQIbO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Sep 2020 04:31:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC17C06174A
        for <linux-can@vger.kernel.org>; Thu, 17 Sep 2020 01:31:12 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kIpJo-0005vz-Cm; Thu, 17 Sep 2020 10:31:04 +0200
Received: from [IPv6:2a03:f580:87bc:d400:8d0c:cfd0:3f99:a545] (unknown [IPv6:2a03:f580:87bc:d400:8d0c:cfd0:3f99:a545])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AEB2B56241B;
        Thu, 17 Sep 2020 08:31:02 +0000 (UTC)
To:     Kirby Nankivell <kirby@kjn.com.au>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <CAJPxYURwMdZqT+j10U4XRVesF43g6uyysCEncvyCJCp-83sNXg@mail.gmail.com>
 <61a5dd2e-7c80-3d33-34ef-7aaa4e8f2a7f@pengutronix.de>
 <CAJPxYUQz6Foon+CbHW03CAjMTs7VYt8gmZYcr=hCgCmXzgMw5w@mail.gmail.com>
 <2f3b0c9f-8f02-a664-670e-f2cb59dfcaca@pengutronix.de>
 <CAJPxYUR4EgMYn9NNoOk_xLHVpPK1tv=gGFekEdTmD9c-rw-cwA@mail.gmail.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: MCP25xxFD Driver Error (-47)
Message-ID: <78c2239b-5d37-6804-b9fd-e6006db19cb5@pengutronix.de>
Date:   Thu, 17 Sep 2020 10:30:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJPxYUR4EgMYn9NNoOk_xLHVpPK1tv=gGFekEdTmD9c-rw-cwA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6BDaKqezHwBQwN2N0k2FBuCsSsbVQGdaa"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6BDaKqezHwBQwN2N0k2FBuCsSsbVQGdaa
Content-Type: multipart/mixed; boundary="cX42s4dWClBW3rSLAOiyo2Rq2Gai6kmhe";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kirby Nankivell <kirby@kjn.com.au>
Cc: linux-can <linux-can@vger.kernel.org>
Message-ID: <78c2239b-5d37-6804-b9fd-e6006db19cb5@pengutronix.de>
Subject: Re: MCP25xxFD Driver Error (-47)
References: <CAJPxYURwMdZqT+j10U4XRVesF43g6uyysCEncvyCJCp-83sNXg@mail.gmail.com>
 <61a5dd2e-7c80-3d33-34ef-7aaa4e8f2a7f@pengutronix.de>
 <CAJPxYUQz6Foon+CbHW03CAjMTs7VYt8gmZYcr=hCgCmXzgMw5w@mail.gmail.com>
 <2f3b0c9f-8f02-a664-670e-f2cb59dfcaca@pengutronix.de>
 <CAJPxYUR4EgMYn9NNoOk_xLHVpPK1tv=gGFekEdTmD9c-rw-cwA@mail.gmail.com>
In-Reply-To: <CAJPxYUR4EgMYn9NNoOk_xLHVpPK1tv=gGFekEdTmD9c-rw-cwA@mail.gmail.com>

--cX42s4dWClBW3rSLAOiyo2Rq2Gai6kmhe
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 9/17/20 2:23 AM, Kirby Nankivell wrote:
>     What about the spi0 node?

>=20
> 		spi0: spi@1c68000 {
> 			#address-cells =3D <2>;
> 			#size-cells =3D <0>;
> 			compatible =3D "allwinner,sun8i-h3-spi";
> 			reg =3D <0x01c68000 0x1000>;
> 			interrupts =3D <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
> 			clocks =3D <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
> 			clock-names =3D "ahb", "mod";
> 			dmas =3D <&dma 23>, <&dma 23>;
> 			dma-names =3D "rx", "tx";
> 			//num-cs =3D 2
> 			pinctrl-names =3D "default", "default";
> 			pinctrl-0 =3D <&spi0_pins>;
> 			pinctrl-1 =3D <&spi0_cs1>;

Please re-read my previous emails. This doesn't look correct, change this=
 to:

pinctrl-names =3D "default";
pinctrl-0 =3D <&spi0_pins &spi0_cs1>;

> 			cs-gpios =3D <0>, <&pio 4 21 0>; /* PE21 */
> 			resets =3D <&ccu RST_BUS_SPI0>;
> 			status =3D "disabled";
>=20
> 		};

> I'm not sure where the Clock registers are generated - the CCU header d=
oesn't
> make sense to me?

I don't understand what you mean by this.

>     > The clock frequency was chosen on your prior advice: being less t=
han 50%
>     of the
>     > controller clock speed (10Mhz), and a factor of 600/2x as limited=
 by the
>     > Allwinner SPI peripheral, in this case; 600 / (2*34).
>     In my H3 DT, I configure the SPI core to 600 MHz, not sure if the V=
3s
>     supports that.
>=20
>     The driver will use the DT max frequency as an upper bound. If you =
use a recent
>     kernel (v5.7 or newer) or have included my patch:
>=20
>     =C2=A0 =C2=A0 spi: spi-sun6i: sun6i_spi_transfer_one():
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fix setting of clock rate
>=20
>     the spi host driver will pick up a proper clock rate.
>=20
> Understood. I have been using the driver from your branch, but you say =
this is
> fixed in 5.7?

The SPI host driver has a bug prior to v5.7, where it selects a higher cl=
ock
rate then requested.

>     >=C2=A0 =C2=A0 =C2=A0[ 1.255123] CAN device driver interface
>     >=C2=A0 =C2=A0 =C2=A0[ 1.259309] spi_master spi0: will run message =
pump with realtime priority
>     >=C2=A0 =C2=A0 =C2=A0[ 1.304566] mcp25xxfd spi0.1 can0: MCP2518FD r=
ev0.0 (-RX_INT -MAB_NO_WARN
>     >=C2=A0 =C2=A0 =C2=A0+CRC_REG +CRC_RX +CRC_TX +ECC -HD m:8.82MHz r:=
8.82MHz e:8.33MHz)
>     >=C2=A0 =C2=A0 =C2=A0successfully initialized.
>=20
>     "m:8.82MHz r:8.82MHz e:8.33MHz"
>=20
>     m =3D maximum as defined by DT
>     r =3D requested by driver
>     e =3D effective speed used by the host driver
>=20
> Understood, so my clock divider=C2=A0looks wrong, do you know how I can=
 determine my
> peripheral bus speed?

Why do you think your clock divider looks wrong? The speed of the periphe=
ral is
shown at "e", so it's 8.33 MHz in your case. It's probably 600 MHz / 72.

However, if you want to be sure, use a scope :)

>     > However that was short lived; I couldn't receive a single message=
 (candump
>     500k)
>     > without getting a crc error:
>     >
>     >=C2=A0 =C2=A0 =C2=A0[ 48.469759] mcp25xxfd spi0.1 can0: CRC read e=
rror at address 0x001c
>     >=C2=A0 =C2=A0 =C2=A0(length=3D4, data=3D00 00 1a 3f, CRC=3D0x1e7c)=
=2E
>     >=C2=A0 =C2=A0 =C2=A0[ 48.479730] mcp25xxfd spi0.1 can0: IRQ handle=
r returned -74
>     (intf=3D0x3f1a0002).
>=20
>     Can you compile the mcp25xxfd-regmap.c with adding a:
>=20
>     =C2=A0 =C2=A0 #define DEBUG
>=20
>     prior to any of the #include statements. That should give some more=
 debugging
>     output with enabled CRC mode. Please post that here.

Can you please recompile the drive with "#define DEBUG" added to the
mcp25xxfd-regmap.c? As requested above?

>     Can you remove the display from the SPI and test again.
>     Can you try to limit the spi speed via DT even more, e.g. to 5MHz?
>=20
> I made a test image, max speed was configured to 5.0MHz, I tried a vari=
ety of
> SPI drivers - But I could not get the controller to initialise at this =
speed - I
> kept getting CRC errors in the boot dmesg.

With or without the display?

> I reverted and tried two different clock speeds:
>=20
> Standard hardware test -=C2=A08.823529 MHz, your SPI driver, LCD connec=
ted:

> # ip link set can0 up type can bitrate 250000 restart-ms 100 fd off
> # candump can0
>   can0  07B   [4]  04 04 00 00
>   can0  07B   [4]  04 04 00 00
>   can0  07B   [4]  04 04 00 00
>   can0  07B   [4]  04 04 00 00
>   can0  07B   [4]  04 04 00 00
>   can0  07B   [4]  04 04 00 00
>   can0  07B   [4]  04 04 00 00
>   can0  2AD   [3]  00 00 00
>   can0  542   [8]  01 00 00 00 00 00 00 00
>   can0  475   [3]  02 00 00
>=20
> [   74.528042] mcp25xxfd spi0.1 can0: CRC read error at address 0x05a8 =
(length=3D20, data=3Df0 02 00 00 01 00 00 00 a7 e8 9e 38 03 07 fe 00 00 0=
0 00 00, CRC=3D0xdac2).
> [   74.542264] mcp25xxfd spi0.1 can0: IRQ handler mcp25xxfd_handle_rxif=
() returned -74.
> [   74.550001] mcp25xxfd spi0.1 can0: IRQ handler returned -74 (intf=3D=
0x3f1a0002).

So CRC error with display attached.

> _I decided then to keep the LCD driver builtin but physically disconnec=
t the FPC
> for the next tests._

Can you try with the display attached, but with the display driver not lo=
aded?

> _20 mhz (using 5.7 standard spi)_

As your mcp25xxfd is clocked with 20 MHz, the SPI speed is limited to 10 =
MHz
(per datasheet). Tests have shown, that the chip is not stable so the spe=
ed is
further reduced to 92.5% (in older versions of my driver) or even 85% in =
the
newest iteration.

> [    1.189727] spi_master spi0: will run message pump with realtime pri=
ority
> [    1.234920] mcp25xxfd spi0.1 can0: MCP2518FD rev0.0 (-RX_INT -MAB_NO=
_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD m:20.00MHz r:9.25MHz e:0.00MHz) s=
uccessfully initialized.

Here you see the mcp25xxfd driver requests ("r:") 9.25 MHz, that's 92.5% =
of 10 MHz.

So without the display it works?

> then at 500K load test:
>=20
> /[=C2=A0=C2=A0 17.568035] mcp25xxfd spi0.1 can0: RX-0: FIFO overflow./
> /[=C2=A0=C2=A0 17.577187] mcp25xxfd spi0.1 can0: RX-0: FIFO overflow./
> /[=C2=A0=C2=A0 17.588286] mcp25xxfd spi0.1 can0: RX-0: FIFO overflow./

This can happen, due to too high load. To fix this, we have to optimize t=
he
V3s's SPI controller driver and/or the mcp25xxfd driver.

> _20 mhz, using your spi driver branch_
>=20
> /[=C2=A0=C2=A0=C2=A0 1.259449] spi_master spi0: will run message pump w=
ith realtime priority/
> /[=C2=A0=C2=A0=C2=A0 1.304714] mcp25xxfd spi0.1 can0: MCP2518FD rev0.0 =
(-RX_INT -MAB_NO_WARN
> +CRC_REG +CRC_RX +CRC_TX +ECC -HD m:20.00MHz r:9.25MHz e:8.33MHz) succe=
ssfully
> initialized./

See above, just the mcp25xxfd driver requests ("r:") 9.25MHz, which resul=
ts in
effective ("e:") 9.09 MHz (600 MHz / 66).

> then load testing at 500k:
>=20
> /[=C2=A0=C2=A0 71.272776] mcp25xxfd spi0.1 can0: RX-0: FIFO overflow./
> /[=C2=A0=C2=A0 71.283761] mcp25xxfd spi0.1 can0: RX-0: FIFO overflow./
> /[=C2=A0=C2=A0 71.295123] mcp25xxfd spi0.1 can0: RX-0: FIFO overflow./


> _8.823529 MHz =E2=80=93 using your spi driver_
>=20
> /[=C2=A0=C2=A0=C2=A0 1.259338] spi_master spi0: will run message pump w=
ith realtime priority/
>=20
> /[=C2=A0=C2=A0=C2=A0 1.304622] mcp25xxfd spi0.1 can0: MCP2518FD rev0.0 =
(-RX_INT -MAB_NO_WARN
> +CRC_REG +CRC_RX +CRC_TX +ECC -HD m:8.82MHz r:8.82MHz e:8.33MHz) succes=
sfully
> initialized./

=2E.. which results ("e:") in 8.33MHz

> *NO RX issues*

looks good.

> _8.823529 MHz =E2=80=93 using 5.7 mainline spi driver
>=20
> /[=C2=A0=C2=A0=C2=A0 1.259402] spi_master spi0: will run message pump w=
ith realtime priority/
> /[=C2=A0=C2=A0=C2=A0 1.304605] mcp25xxfd spi0.1 can0: MCP2518FD rev0.0 =
(-RX_INT -MAB_NO_WARN
> +CRC_REG +CRC_RX +CRC_TX +ECC -HD m:8.82MHz r:8.82MHz e:0.00MHz) succes=
sfully
> initialized./

> //then load testing at 500k://
>=20
> /[=C2=A0=C2=A0 33.235868] mcp25xxfd spi0.1 can0: RX-0: FIFO overflow./
> /[=C2=A0=C2=A0 33.246714] mcp25xxfd spi0.1 can0: RX-0: FIFO overflow./
> /[=C2=A0=C2=A0 33.257608] mcp25xxfd spi0.1 can0: RX-0: FIFO overflow./
>=20
> The results were clear, there is some SPI issue that prevents me
> specifying=C2=A0above 8.8Mhz, even if the effective speed is detected t=
o be the same.

Probably interger arithmetics :)

600 MHz / 8.823529 Mhz

600000000 / 8823529 =3D 68.0000031733 -> 69

The SPI host driver only supports even dividers.

-> 70

600 MHz / 70 =3D 8.57 MHz

but your SPI host controller selects 8.33MHz...

Maybe your V3s has a different clock tree than the H3.

please post the output of:

> grep . /sys/kernel/debug/clk/spi0/clk_{parent,possible_parents,rate}
> grep . $(for i in $(cat /sys/kernel/debug/clk/spi0/clk_possible_parents=
); do echo /sys/kernel/debug/clk/$i/clk_rate;done)

> Likewise lower speeds (5MHz would not enable).
> Your allwinner spi branch at this speed is stable.

> Additionally it was clear then that the LCD was affecting the SPI traff=
ic from
> the controller and likely the culprit of the CRC errors, I suspected th=
at the
> MISO pin on the LCD was not being properly tri-state when the CS for th=
e display
> was not being asserted.
> And this was causing some noise,=C2=A0bit=C2=A0flipping or similar on t=
he bus. It was also
> likely in this case that I would probably see packet errors during oper=
ation if
> CRC was ignored.

So better keep CRC enabled!

> Luckily the LCD supports open ended mode and does not need MISO (DO) co=
nnected
> to function, also luckily is that I put zero ohm resistors on the board=
 before
> the 0.35mm FPC connector. I removed the resistor to the LCD MISO pin an=
d
> reconfigured for open-ended mode.

\o/

> I can now successfully load test at high rates without packet drop or f=
ailure
> and the LCD works too!

\o/

> image.png
> image.png
> image.png
>=20
> This is a pretty good outcome, thanks for your help! The SPI driver is =
a bit
> odd, I might try with a 40MHz XTAL and see what changes.

With a 40MHz Xtal this you can increase the SPI clock to 40/2*85% =3D 17M=
hz, which
should result in 16.67 MHz (given 600 MHz SPI parent clock).

> Please let me know if I can run any more tests to help!

See above, let's have a look at your clock tree.

Marc
--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--cX42s4dWClBW3rSLAOiyo2Rq2Gai6kmhe--

--6BDaKqezHwBQwN2N0k2FBuCsSsbVQGdaa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl9jHsIACgkQqclaivrt
76mQCwf/YDV4FEKQN5fjIYCgWsAXyz4Fp1SztvRW9BAqUFcpwelSASNCu3mJgjx6
UE7xj8sQCC5M2qVB9zzS1TPT+0btf3Vx1/NRnIQ71TmCGETMy2E4k86fdlt377X4
ko/6Bkk7VmoktNIpE3KMXiwK3KOsbw6Di3Te2yHX68FRG8v28PzbvJf82tbxMzD7
Y4jymF0eWff90KmoRDGsZ1dl40/veYrPiSK4nLIJue7F3JY1YDvc4pjDpEmvFw8R
0v/qrBYwF3hB7LRZPwhstDUf+FeSYXeaXa4Y1rrTWHY1Wx1C0OzArVSRhF+kDQ8o
7u4p8iEf6ouM+QR88yz/V/gUMME/EQ==
=UZYB
-----END PGP SIGNATURE-----

--6BDaKqezHwBQwN2N0k2FBuCsSsbVQGdaa--
