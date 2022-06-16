Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFF154E0EC
	for <lists+linux-can@lfdr.de>; Thu, 16 Jun 2022 14:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiFPMlD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 Jun 2022 08:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiFPMlC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Jun 2022 08:41:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02941517D3
        for <linux-can@vger.kernel.org>; Thu, 16 Jun 2022 05:41:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o1onz-0005hK-Gw; Thu, 16 Jun 2022 14:40:59 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 86CF9975DC;
        Thu, 16 Jun 2022 12:40:57 +0000 (UTC)
Date:   Thu, 16 Jun 2022 14:40:56 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: ram initialization on mcp2518fd
Message-ID: <20220616124056.cnnvlqwwkknjta7w@pengutronix.de>
References: <e3f73c56-1b46-4ee9-357e-40400c746e09@prevas.dk>
 <87wndgyl2l.fsf@hardanger.blackshift.org>
 <441514ec-7b43-e11c-09b5-bdaf7fca0077@prevas.dk>
 <d614f497-b8f2-68cd-745b-1e3be2b991d5@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s34mmyin3rpby66e"
Content-Disposition: inline
In-Reply-To: <d614f497-b8f2-68cd-745b-1e3be2b991d5@prevas.dk>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--s34mmyin3rpby66e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.06.2022 13:21:52, Rasmus Villemoes wrote:
> > The ecspi or the qspi?
>=20
> ecspi

OK.

> >> A logic analyzer shows that the spi communication works (mostly) fine
> >> [1], up until mcp251xfd_chip_ecc_init(). In there, it seems that the
> >> regmap_raw_write() ends up trying to do byte-by-byte transfers - i.e.,
> >> the chip select is only asserted for 8 clock cycles, then deasserted,
> >> and asserted again for the next byte.
> >
> > What about the other transfers done before the
> > mcp251xfd_chip_ecc_init()? Do the look correct?
>=20
> Yes. For example the very first write done from mcp251xfd_chip_start()
> -> mcp251xfd_chip_softreset{,_do}() -> mcp251xfd_chip_clock_enable()
> looks like https://ibb.co/xMbdsSq , and the MOSI signal looks right
> (0xa =3D crc write to 0xe00 aka OSC, 4 value bytes, the 0x00000060 value
> in little endian, and the crc partly off-screen).

That looks perfect.

[...]

> >> Obviously, that means that the RAM doesn't get initialized, because
> >> all the device sees is a bunch of aborted spi transactions. I can't
> >> really figure out why this happens, maybe I'm missing some setting in
> >> DT or elsewhere; currently I have
> >
> > Can you show me your SPI host controller node, too?
>=20
> Yes, it's essentially the one from imx8mp.dtsi, i.e.
>=20
> 	ecspi1: spi@30820000 {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
> 		compatible =3D "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
> 		reg =3D <0x30820000 0x10000>;
> 		interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> 		clocks =3D <&clk IMX8MP_CLK_ECSPI1_ROOT>,
> 			 <&clk IMX8MP_CLK_ECSPI1_ROOT>;
> 		clock-names =3D "ipg", "per";
> 		assigned-clock-rates =3D <80000000>;
> 		assigned-clocks =3D <&clk IMX8MP_CLK_ECSPI1>;
> 		assigned-clock-parents =3D <&clk IMX8MP_SYS_PLL1_800M>;
> 		dmas =3D <&sdma1 0 7 1>, <&sdma1 1 7 2>;
> 		dma-names =3D "rx", "tx";
> 		status =3D "disabled";
> 	};
>=20
> with this in the board .dts:
>=20
> &ecspi1 {
> 	status =3D "okay";
> 	pinctrl-names =3D "default";
> 	pinctrl-0 =3D <&pinctrl_ecspi1>;
> 	cs-gpios =3D <&gpio5 9 GPIO_ACTIVE_LOW>;
>=20
> 	CAN_C: spi@0 {
> 		reg =3D <0>;
> 		compatible =3D "microchip,mcp2518fd";
> 		/* clocks =3D <&cdce937 6>; */
> 		clocks =3D <&clk_40MHz>;
> 		interrupts-extended =3D <&gpio1 6 IRQ_TYPE_LEVEL_LOW>;
> 		spi-max-frequency =3D <10000000>;
> 		pinctrl-names =3D "default";
> 		pinctrl-0 =3D <&pinctrl_CAN_C>;
> 	};
> };
>=20
> It's currently (for bad reasons) the nxp kernel, hence the
> fsl,imx6ul-ecspi compatible, but changing that to the one in mainline,
> fsl,imx51-ecspi, doesn't change the symptoms.

The imx8mp.dtsi enables DMA for the SPI host controller.

> >> 	CAN_C: spi@0 {
> >> 		reg =3D <0>;
> >> 		compatible =3D "microchip,mcp2518fd";
> >> 		clocks =3D <&clk_40MHz>;
> >> 		interrupts-extended =3D <&gpio1 6 IRQ_TYPE_LEVEL_LOW>;
> >> 		spi-max-frequency =3D <17000000>;
> >> 		pinctrl-names =3D "default";
> >> 		pinctrl-0 =3D <&pinctrl_CAN_C>;
> >> 	};
> >>
> >> with the pinctrl being for the irq gpio. I have also tried lowering
> >> spi-max-frequency to 10MHz (currently it ends up effectively using
> >> 16MHz),
> >
> > The driver uses 85% of clock/2 or spi-max-frequency, whatever is lower.
>=20
> Yes; using 10MHz was just an attempt to see if using an even lower
> frequency than the maximum implied by the errata (and implemented in the
> driver) would make a difference.
>=20
> >> [1] One thing I have noticed is that we probably want to do
> >>
> >> -       xfer[1].len =3D sizeof(dev_id);
> >> +       xfer[1].len =3D sizeof(*dev_id);
> >
> > Fixed. Do you want to appear as Reported-by in the patch?
>=20
> Yes please.

Updated.

> >> But: the reading doesn't seem to work; it's as if the device doesn't
> >> drive MISO at all at this point, because when I configure the pin with
> >> a weak internal pull-up, I get 0xffffffff, while if I use pinmux
> >> settings with a weak pull-down I get 0 - which is the "correct"
> >> answer, but probably not for the right reason.
> >
> > The device id is read after detecting the chip and the
> > mcp251xfd_chip_ecc_init(). Does the chip detection work properly?
>=20
> It appears so, adding a print of the osc variable after the
> regmap_read() in mcp251xfd_register_chip_detect() gives
>=20
> mcp251xfd_register_chip_detect: osc =3D 0x00000468
>=20
> so the LPMEN bit seems to have been set (and the other bits show
> expected values). And it's true that the dev_id is read after this,
> through mcp251xfd_register_done(), which is why I'm puzzled that it
> doesn't seem to work.
>=20
> Are you sure about the ecc_init() part? AFAICT that's only called from
> chip_start, which in turn is only called when the device is brought
> up.

Yes, you're right!

> >> I'm on a 5.10.y kernel, but I don't see any commits related to this
> >> since then (other than the error handling in
> >> mcp251xfd_register_get_dev_id()).
> >
> > Which kernel are you using exactly? Mainline or freescale/nxp
> > downstream?
>=20
> Currently NXP,  lf-5.10.72-2.2.0 aka a68e31b63f86. I'll see if I can
> manage to make a mainline kernel boot.

v5.10 is old, you will not get the best mcp251xfd performance out of it.
There are several performance improvements on the SPI framework, the
spi-imx driver and the mcp251xfd driver with a recent kernel.

> > Have you enabled DMA on SPI?
>=20
> Not explicitly, but nor have I done anything to disable/not enable it,
> so I'm not really sure what the right answer is. Is that a CONFIG_ knob
> or module/kernel parameter?

You can use "/delete-property/ dmas;" and "/delete-property/ dma-names;"
in your board dts on the &ecspi1 node, the module parameter "use_dma=3D0",
or the kernel command line "spi-imx.use_dma=3D0" to disable DMA.

The SPI host driver uses PIO for smaller transfers, but switches to DMA
mode for bigger ones (IIRC > 64 bytes). The clearing of the memory
definitely falls into the big transfer category. The SPI DMA mode is
broken on various kernel variants (downstream, mainline), kernel
versions, SoC variants and used SDMA firmware versions. For the
mcp251xfd driver DMA is also slower. So switch of DMA and try again.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--s34mmyin3rpby66e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKrJNEACgkQrX5LkNig
012D5Qf/e7N6rqBXza3JBpN6PhK+ocQTJ1IUHr75Ym4YPybylB74bfTIn8I1j0vd
qEFJThB08RinS04vYL0sM5v4s0NxHXeoGq6tEwCMc99n/VXQwYaqwKjeaZWwQBK9
s89eTW1zJjwei5g2BO38z1HqF0hUGEkuSH6wwaD+s0YiAEm5S5O7m2y1Ex+fxTMV
64c0ogOeCakjF143CmPsD/uTG82yAs4hPAc8YSMvArn4wW7fmQa7vaFB1CayR11H
aVC1quQPIbP+TkWfNb/df8cww36vQ+lnSRapZPODeTZ552w48S0qdPQOtok1RR+m
mFxV/lLfOB0wkiDziqtinvOe/4DSnQ==
=Rl8+
-----END PGP SIGNATURE-----

--s34mmyin3rpby66e--
