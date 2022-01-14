Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F210A48EA06
	for <lists+linux-can@lfdr.de>; Fri, 14 Jan 2022 13:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiANMlX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 Jan 2022 07:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiANMlX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Jan 2022 07:41:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5C8C061574
        for <linux-can@vger.kernel.org>; Fri, 14 Jan 2022 04:41:23 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n8LtR-0006t6-Ek; Fri, 14 Jan 2022 13:41:21 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 564CD18972;
        Fri, 14 Jan 2022 12:41:20 +0000 (UTC)
Date:   Fri, 14 Jan 2022 13:41:16 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Markus Mirevik <markus.mirevik@dpsolutions.se>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: MCP251xFD runs interrupt handler twice per message.
Message-ID: <87o84e1oj1.fsf@hardanger.blackshift.org>
References: <HE1PR04MB310066D557C9D77FE357D90AE6549@HE1PR04MB3100.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eu4wzxdqrcrexufs"
Content-Disposition: inline
In-Reply-To: <HE1PR04MB310066D557C9D77FE357D90AE6549@HE1PR04MB3100.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--eu4wzxdqrcrexufs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.01.2022 11:05:51, Markus Mirevik wrote:
> I have performance problems with mcp2518fd. I have custom board based
> of beagleboard black. (Sitara am335x) using two mcp2518fd. The can
> communication uses a lot of CPU. irq/64-spi1.1 uses around ~20% at
> 1000 can messages/s.
>=20
> I have several questions but I'll start with the most confusing. I
> have found that every can messages fires two interrupts on my board.

Do you mean every RX'ed CAN frame?
Which interrupts does increase twice?

> I have tested this in several ways. If I send one normal can message
> the counter in /proc/interrupts is increased twice. I have also put
> some printouts in mcp251xfd-core.c that confirms that mcp251xfd_irq()
> is run twice and the second time intf_pending is 0.

You mean mcp251xfd_irq() is started twice?

The big loop
(https://elixir.bootlin.com/linux/v5.16/source/drivers/net/can/spi/mcp251xf=
d/mcp251xfd-core.c#L2182)
in mcp251xfd_irq() is run twice, and the IRQ handler is left only if
there are no pending IRQs.

The main IRQ handler loop (omitting the rx-int) is straight forward, and
not optimized:
- read pending IRQs [*]
- exit if there are no pending IRQs
- handle pending IRQs
  for RX:
  - read RX-FIFO level [*]
  - read RX'ed CAN frames [*]
  - mark RX'ed CAN frames as read [*]
- loop

All actions marked with a [*] require a SPI transfer, which results in 5
SPI transfers (read pending IRQs is done twice) per RX'ed CAN frame.
(Assuming there is only 1 RX'ed frame pending and no pending IRQs after
 the first loop.)

I have some ideas how to optimize this:
- do a single SPI transfer instead of several small ones:
  e.g. pending IRQs + RX-FIFO level, or read RX'ed frames + mark as read
- opportunistically assume RX'ed frame on interrupt and get rid of 1st
  read pending IRQs
- assume TX done IRQ, if CAN frames have been TX'ed but not marked as
  sent hardware
- coalesce RX IRQs
- coalesce TX done IRQs
- combine several TX frames into single SPI transfer

> And for testing purposes I changed the interrupt config to trigger on
> falling edge instead of level and with this configured there is only
> one interrupt fired. But I guess this will risk locking the interrupt
> line low if an edge isn't detected.

ACK - Please don't use edge triggered IRQs, sooner or later the driver
will miss an IRQ resulting in a handing driver. Always use level
triggered with the mcp251xfd.

> I have tried both with rx-int active and inactive. My scope shows
> really nice signals and that rx-int and int is deactivated
> simultaneous on incoming frames.

rx-int is an optimization to skip the first get IRQ pending transfer, as
it indicates RX'ed CAN frames.

> I'm testing by sending messages from my computer through a can dongle.
>=20
> The board is currently running Linux 5.10.79-yocto-tiny #1 SMP Tue Nov
> 16 03:57:43 UTC 2021 armv7l armv7l armv7l GNU/Linux

Newer kernels include some optimizations....

> I've also tested updating the driver to the one from
> https://github.com/marckleinebudde/linux.git from 2021-12-29 with the
> same result (IRQ handler run twice).

The newest production ready code is always net-next/master. But you can
use the latest official kernel release (v5.16) too.

> I am profoundly confused by this issue and I can not figure out why
> it's happening. My understanding is that since the IRQ handler is
> loaded with IRQF_ONESHOT the irq line should be masked until
> mcp251xfd_irq() returns.

ACK.

> Since mcp251xfd_irq() checks that !rx_pending before exiting the int
> signal must be high. And the interrupt should not fire again...

The rx-int GPIO:

| microchip,rx-int-gpios =3D <&gpio1 8 GPIO_ACTIVE_LOW>;

is not used as an interrupt. The only interrupt line is:

| interrupts-extended =3D <&gpio2 5 IRQ_TYPE_EDGE_FALLING>;

If there is an interrupt the gpio2_5 will get active, if this is an RX
IRQ the gpio1_8 will get active, too. But only gpio2_5 will trigger the
interrupt handler.

In the interrupt handler, as rx-int is available and active the RX
handling is done first. If there are no more RX IRQs pending, the rx-int
goes inactive and the big loop in the IRQ handler will be handled: read
rx-pending IRQs, probably none pending, then leave IRQ handler.

> Result from init:
> [    4.003029] mcp251xfd spi1.0 can0: MCP2518FD rev0.0 (+RX_INT -MAB_NO_W=
ARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00MHz e:0.=
00MHz) successfully initialized.
> [    4.028220] mcp251xfd spi1.1 can1: MCP2518FD rev0.0 (-RX_INT -MAB_NO_W=
ARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00MHz e:0.=
00MHz) successfully initialized.
>=20
> This is the current dtsi part for the canFD chips. (With rx-pin removed o=
n one of the devices and trigger on edge on the other for debugging purpose=
s).=20
>=20
> #include <dt-bindings/gpio/gpio.h>
> #include <dt-bindings/interrupt-controller/irq.h>
>=20
> &am33xx_pinmux{
>         pinctrl_spi1_pins: pinctrl_spi1_pins {
>                 pinctrl-single,pins =3D <
>                         AM33XX_IOPAD(0x990, PIN_INPUT | MUX_MODE3) /* (A1=
3) mcasp0_aclkx.spi1_sclk */
>                         AM33XX_IOPAD(0x994, PIN_INPUT | MUX_MODE3) /* (B1=
3) mcasp0_fsx.spi1_d0 */
>                         AM33XX_IOPAD(0x998, PIN_INPUT | MUX_MODE3) /* (D1=
2) mcasp0_axr0.spi1_d1 */
>                         AM33XX_IOPAD(0x96c, PIN_OUTPUT_PULLUP | MUX_MODE5=
) /* (E17) uart0_rtsn.spi1_cs0         CleANopen       LEFT*/
>                         AM33XX_IOPAD(0x9b0, PIN_OUTPUT_PULLUP | MUX_MODE4=
) /* (A15) xdma_event_intr0.spi1_cs1   SAWM CAN        RIGHT*/
>                 >;
>         };
>=20
>         can0_int_pins: can0_int_pins {
>                 pinctrl-single,pins =3D <
>                 /*CleANopen*/
>                 AM33XX_IOPAD(0x89c, PIN_INPUT_PULLUP | MUX_MODE7) /* (T6)=
 gpmc_be0n_cle.gpio2[5]        nINT            */
>                 AM33XX_IOPAD(0x968, PIN_INPUT_PULLUP | MUX_MODE7) /* (E18=
) uart0_ctsn.gpio1[8]          nINT1           */
>                 >;
>         };
>=20
>         can1_int_pins: can1_int_pins {
>                 pinctrl-single,pins =3D <
>                 /*SAWM CAN*/
>                 AM33XX_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE7) /* (U10=
) gpmc_ad8.gpio0[22]           nINT            */
>                 AM33XX_IOPAD(0x8c8, PIN_INPUT_PULLUP | MUX_MODE7) /* (U3)=
 lcd_data10.gpio2[16]  nINT1           */
>                 AM33XX_IOPAD(0x8cc, PIN_INPUT_PULLUP | MUX_MODE7) /* (U4)=
 lcd_data11.gpio2[17]  nINT0 NOT USED  */
>                 >;
>         };
> };
>=20
>=20
>=20
> /{
>         /* external 40M oscillator of mcp2518fd on SPI1.0 */
>         mcp2518fd_can0_osc: mcp2518fd_can0_osc {
>                 compatible =3D "fixed-clock";
>                 #clock-cells =3D <0>;
>                 clock-frequency =3D <40000000>;
>         };
> };
>=20
>=20
> /{
>         /* external 40M oscillator of mcp2518fd on SPI1.1 */
>         mcp2518fd_can1_osc: mcp2518fd_can1_osc {
>                 compatible =3D "fixed-clock";
>                 #clock-cells =3D <0>;
>                 clock-frequency =3D <40000000>;
>         };
> };
>=20
> /* the spi config of the can-controller itself binding everything togethe=
r */
> &spi1{
>     #address-cells =3D <1>;
>     #size-cells =3D <0>;
>=20
>     status =3D "okay";
>     pinctrl-names =3D "default";
>     pinctrl-0 =3D <&pinctrl_spi1_pins>;
>=20
>     /*CleANopen*/
>     can@0 {
>         compatible =3D "microchip,mcp2518fd";
>         reg =3D <0>;
>         clocks =3D <&mcp2518fd_can0_osc>;
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&can0_int_pins>;
>         spi-max-frequency =3D <20000000>;
>         interrupts-extended =3D <&gpio2 5 IRQ_TYPE_EDGE_FALLING>;

See comment about edge IRQs above!

>         microchip,rx-int-gpios =3D <&gpio1 8 GPIO_ACTIVE_LOW>;
>     };
>=20
>     can@1 {
>         compatible =3D "microchip,mcp2518fd";
>         reg =3D <1>;
>         clocks =3D <&mcp2518fd_can1_osc>;
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&can1_int_pins>;
>         spi-max-frequency =3D <20000000>;
>         interrupts-extended =3D <&gpio0 22 IRQ_TYPE_LEVEL_LOW>;
> //        microchip,rx-int-gpios =3D <&gpio2 16 GPIO_ACTIVE_LOW>;
>     };
> };

Can you test again with IRQ_TYPE_LEVEL_LOW and no rx-int-gpios. Please
instrument the beginning and the returns of the mcp251xfd_irq() function
to check if it's really started twice. Please print the
priv->regs_status.intf in every loop. Can you record the gpio2_5 with a
scope.

Make sure that you don't send any CAN frames as reaction of reception.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--eu4wzxdqrcrexufs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHhb2oACgkQqclaivrt
76lvNwf/fs02lBjtDOP+xQpmZyyqVz373TCDu+mlYuWvoMfb7yxAfS2rqmzrXKPf
knr5J6RH6m85icadtP6IBowF9Sr4QgK++TpjSbiLRYqf1YKOVwd4z113qPR+xpP+
Vsczc54VKsL1hNWAD6pHUIGZsivRZYLTuv1PtNMFutHmDQOQ6HQHEIwWSydvrtb4
dNF3lUdYOPrmWW6oOt6eTfcDrZ5jEFfpSH1OUf3ongygtyWixAM26HWwTpotS3P8
Gi6nQ51g0DdAc9/oxh2bxDC9LDEt8jWxFBxkTIaUOEVdo5UHMZw8zbkN2u95tagd
18UZzvlxeBVrhtKB4P2gMNRXZAEDfw==
=3zJd
-----END PGP SIGNATURE-----

--eu4wzxdqrcrexufs--
