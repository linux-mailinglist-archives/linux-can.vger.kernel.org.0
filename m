Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC8269EF9
	for <lists+linux-can@lfdr.de>; Tue, 15 Sep 2020 08:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgIOG5U (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Sep 2020 02:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgIOG5N (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 02:57:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC54C06174A
        for <linux-can@vger.kernel.org>; Mon, 14 Sep 2020 23:57:12 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kI4tq-0005DY-Ox; Tue, 15 Sep 2020 08:57:10 +0200
Received: from [IPv6:2a03:f580:87bc:d400:8d0c:cfd0:3f99:a545] (unknown [IPv6:2a03:f580:87bc:d400:8d0c:cfd0:3f99:a545])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AFC3F5609D5;
        Tue, 15 Sep 2020 06:57:07 +0000 (UTC)
To:     Kirby Nankivell <kirby@kjn.com.au>
References: <CAJPxYURwMdZqT+j10U4XRVesF43g6uyysCEncvyCJCp-83sNXg@mail.gmail.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: MCP25xxFD Driver Error (-47)
Message-ID: <61a5dd2e-7c80-3d33-34ef-7aaa4e8f2a7f@pengutronix.de>
Date:   Tue, 15 Sep 2020 08:56:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJPxYURwMdZqT+j10U4XRVesF43g6uyysCEncvyCJCp-83sNXg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="aKFIQ4e2afgB9dqWlHbbgnVKp3hDN1x7g"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aKFIQ4e2afgB9dqWlHbbgnVKp3hDN1x7g
Content-Type: multipart/mixed; boundary="jw7wVftr5u4PJBnFEFRcXKpMumCXX5hhF";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kirby Nankivell <kirby@kjn.com.au>
Cc: linux-can <linux-can@vger.kernel.org>
Message-ID: <61a5dd2e-7c80-3d33-34ef-7aaa4e8f2a7f@pengutronix.de>
Subject: Re: MCP25xxFD Driver Error (-47)
References: <CAJPxYURwMdZqT+j10U4XRVesF43g6uyysCEncvyCJCp-83sNXg@mail.gmail.com>
In-Reply-To: <CAJPxYURwMdZqT+j10U4XRVesF43g6uyysCEncvyCJCp-83sNXg@mail.gmail.com>

--jw7wVftr5u4PJBnFEFRcXKpMumCXX5hhF
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 8/28/20 11:53 AM, Kirby Nankivell wrote:
> Thankyou for your contribution of a MCP25xxFD driver to the linux kerne=
l. I am
> only a hobbyist=C2=A0in this area (I am a mechanical engineer for work)=
, but it has
> certainly allowed me to pursue a project I could not have previously.

Please use the linux-can mailinglist (Cc'ed) for community support.

> I have been able to successfully=C2=A0integrate your patchset into my b=
uildroot
> environment, after several=C2=A0attempts -- In the end I was missing th=
e rx offload
> patch which solved my compile errors.
>=20
> I used the -47 release submitted to linux-can mailing list that was pub=
lished on
> the kernel.org <http://kernel.org> git / same as your github branch:
> https://www.spinics.net/lists/linux-can/msg03712.html
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/=
log/?h=3Dmcp25xxfd-47
>=20
> *Here is my boot dmesg:*
> /[=C2=A0 =C2=A0 1.235223] CAN device driver interface/
> /[=C2=A0 =C2=A0 1.239239] OF: /soc/spi@1c68000/mcp2518fd@1: #interrupt-=
cells =3D 3 found -1/

This looks like an error message! See comments about mcp2518 interrupts b=
elow.

> /[=C2=A0 =C2=A0 1.246482] spi_master spi0: will run message pump with r=
ealtime priority/
> /[=C2=A0 =C2=A0 1.291590] mcp25xxfd spi0.1 can0: MCP2518FD rev0.0 (-RX_=
INT -MAB_NO_WARN
> +CRC_REG +CRC_RX +CRC_TX +ECC -HD m:9.09MHz r:9.09MHz e:0.00MHz) succes=
sfully
> initialized./
>=20
> *However when I go to try and test:*
> /# ip link set can0 up type can bitrate 500000 restart-ms 100 fd off/
> /[=C2=A0 =C2=A077.424381] A link change request failed with some change=
s committed
> already. Interface can0 may have been left with an inconsistent configu=
ration,
> please check./
> /RTNETLINK answers: Invalid argument/

any output in the dmesg after this?

> *Problem resolution:*
> I found some issues with my interrupt wiring, which has since been fixe=
d. But
> this did not resolve the problem. After doing some research this error =
seems
> related to my choice of using a GPIO for my second chip-select (the har=
dware CS
> is being used for a display). This exact configuration was used for MCP=
2515
> bench testing so I am unsure if it is a driver issue or something else.=

>=20
> Of course I appreciate your time is valuable, however as the main autho=
r of this
> driver I wondered if you had any insight as to if this is a driver issu=
e or a
> hardware issue, or some suggestions for testing.
>=20
> Looking forward to your response,
>=20
> Regards,
> Kirby
>=20
>=20
> Below is some information about my setup and the relevant excerpt from =
my device
> tree.
>=20
> *Hardware:*
> LicheePi Zero - Allwinner V3s
> Buildroot - 5.7 Kernel

I'm succeddfully running the mcp25xxfd driver on an allwinner h3:

https://github.com/marckleinebudde/linux/blob/v4.19-sunxi/mcp25xxfd-20200=
429-46/arch/arm/boot/dts/sun8i-h3-nanopi-easysolar-base-a10.dtsi#L102

> Device Tree Excerpts:
> DTS Clocks:
> can0_osc_fixed: can0_osc_fixed {
> 	#clock-cells =3D <0>;
> 	compatible =3D "fixed-clock";
> 	clock-frequency  =3D <20000000>;
> };
>=20
> PIO:
> spi0_pins: spi0 {
> 	pins =3D "PC0", "PC1", "PC2", "PC3";
> 	function =3D "spi0";
> };
>=20
> spi0_cs1: spi0_cs1 {
> 	pins =3D "PE21";
> 	function =3D "gpio_out";
> 	output-high;
> };
>=20
> can0_pin_irq: can0_pin_irq {
> 	pins =3D "PB0";
> 	function =3D "irq";
> 	bias-pull-up;
> };
>=20
>=20
> SPI:
> spi0: spi@1c68000 {
> 	#address-cells =3D <2>;
> 	#size-cells =3D <0>;
> 	compatible =3D "allwinner,sun8i-h3-spi";
> 	reg =3D <0x01c68000 0x1000>;
> 	interrupts =3D <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
> 	clocks =3D <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
> 	clock-names =3D "ahb", "mod";
> 	dmas =3D <&dma 23>, <&dma 23>;
> 	dma-names =3D "rx", "tx";
> 	pinctrl-names =3D "default", "default";
> 	pinctrl-0 =3D <&spi0_pins>;
> 	pinctrl-1 =3D <&spi0_cs1>;

I'm not sure if this pinctrl works correctly this way, try:

pinctrl-names =3D "default";
pinctrl-0 =3D <&spi0_pins &spi0_cs1>;

> 	cs-gpios =3D <0>, <&pio 4 21 0>; /* PE21 */
> 	resets =3D <&ccu RST_BUS_SPI0>;
> 	status =3D "disabled";
> };
>=20
> SPI devices:
> &spi0 {
>        status =3D "okay";
>=20
>     display@0 {
> 		reg =3D <0>;
> 		compatible =3D "sitronix,st7796s";
> 		spi-max-frequency =3D <50000000>;
> 		rotation =3D <0>;
> 		reset-gpios =3D <&pio 4 0 GPIO_ACTIVE_LOW>; //PE0
> 		dc-gpios =3D <&pio 4 1 GPIO_ACTIVE_HIGH>; //PE1
> 		debug =3D <0>;
> 		status =3D "okay";
>     };
>=20
> 	mcp2518fd@1 {
> 		reg =3D <1>;
> 		compatible =3D "microchip,mcp25xxfd";
> 		pinctrl-names =3D "default";
> 		pinctrl-0 =3D <&can0_pin_irq>;
> 		spi-max-frequency =3D <9090909>;

Why that frequency?

> 		interrupt-parent =3D <&pio>;
> 		interrupts-extended =3D <1 0 8>; //PB2 is IRQ - IRQ_TYPE_LOW =3D 8

Using both interrupt-parent and interrupts-extended is wrong.

For the allwinner H3 this works. Note: it uses a different interrupt pin.=


interrupt-parent =3D <&pio>;
interrupts =3D <0 21 IRQ_TYPE_LEVEL_LOW>; /* PA21 */

> 		clocks =3D <&can0_osc_fixed>;
> 		status =3D "okay";
> 	};
>=20
> };

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--jw7wVftr5u4PJBnFEFRcXKpMumCXX5hhF--

--aKFIQ4e2afgB9dqWlHbbgnVKp3hDN1x7g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl9gZbsACgkQqclaivrt
76nD5Af/RFNfo7rU5u5Z+kTLQmDKuSPND5YcGrkCBCfshvR3JPNBmr69NqNOYiVo
EBc6hoKOYyyiOMcaaijcluPz1Q5C+wX3C1kDWbAuBjNU27AqBFPMtogUPX8dAqU7
NMjJ6yeFkiFTwaME0fx07FcsEvsBi4DkfBM0++TQ2VboWK/CW81MKEeToPn5P7cu
rABTJ3MAsPmCj1+faE92tghZX2GR1ylXw+i8fUfsM6pQJohQ1dwxNGTrvDjS0les
7Dmbx2ibspLZ+Bg+3Lwf5oIyIuVQrID4bXzrnJFLIfvPYmZAHY/opjTaMU7u6rWN
tnj8Q1t04DJoN/VDaKdLyJNg9wpLlg==
=0TXf
-----END PGP SIGNATURE-----

--aKFIQ4e2afgB9dqWlHbbgnVKp3hDN1x7g--
