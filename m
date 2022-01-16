Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA70490611
	for <lists+linux-can@lfdr.de>; Mon, 17 Jan 2022 11:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbiAQKiV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jan 2022 05:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbiAQKiU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jan 2022 05:38:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE735C061574
        for <linux-can@vger.kernel.org>; Mon, 17 Jan 2022 02:38:19 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n9PP0-0000Lo-D3; Mon, 17 Jan 2022 11:38:18 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id DA37519E8F;
        Sun, 16 Jan 2022 11:09:44 +0000 (UTC)
Date:   Sun, 16 Jan 2022 12:09:41 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Markus Mirevik <markus.mirevik@dpsolutions.se>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: MCP251xFD runs interrupt handler twice per message.
Message-ID: <20220116110941.6cqzm3skp57pnvth@pengutronix.de>
References: <HE1PR04MB310066D557C9D77FE357D90AE6549@HE1PR04MB3100.eurprd04.prod.outlook.com>
 <87o84e1oj1.fsf@hardanger.blackshift.org>
 <HE1PR04MB3100B7CD240526C06FCA048EE6549@HE1PR04MB3100.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5xa4xxm36szszofp"
Content-Disposition: inline
In-Reply-To: <HE1PR04MB3100B7CD240526C06FCA048EE6549@HE1PR04MB3100.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--5xa4xxm36szszofp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.01.2022 13:43:42, Markus Mirevik wrote:
> > > I have performance problems with mcp2518fd. I have custom board based
> > > of beagleboard black. (Sitara am335x) using two mcp2518fd. The can
> > > communication uses a lot of CPU. irq/64-spi1.1 uses around ~20% at
> > > 1000 can messages/s.
> > >
> > > I have several questions but I'll start with the most confusing. I
> > > have found that every can messages fires two interrupts on my board.
> >=20
> > Do you mean every RX'ed CAN frame?
> Yes, every received CAN frame.
>=20
> > Which interrupts does increase twice?
>=20
> This one:=20
> 64:  4  44e07000.gpio  22 Level     spi1.1

Ok, that's the IRQ line from the mcp251xfd.

> > > I have tested this in several ways. If I send one normal can message
> > > the counter in /proc/interrupts is increased twice. I have also put
> > > some printouts in mcp251xfd-core.c that confirms that mcp251xfd_irq()
> > > is run twice and the second time intf_pending is 0.
> >=20
> > You mean mcp251xfd_irq() is started twice?
>=20
> Yes.

That's not the way it's supposed to be. Maybe it's a limitation of the
am335x IRQ controller.

> > The big loop
> > (https://elixir.bootlin.com/linux/v5.16/source/drivers/net/can/spi/mcp2=
51xf
> > d/mcp251xfd-core.c#L2182)
> > in mcp251xfd_irq() is run twice, and the IRQ handler is left only if th=
ere are
> > no pending IRQs.
> >=20
> > The main IRQ handler loop (omitting the rx-int) is straight forward, an=
d not
> > optimized:
> > - read pending IRQs [*]
> > - exit if there are no pending IRQs
> > - handle pending IRQs
> >   for RX:
> >   - read RX-FIFO level [*]
> >   - read RX'ed CAN frames [*]
> >   - mark RX'ed CAN frames as read [*]
> > - loop
> >=20
> > All actions marked with a [*] require a SPI transfer, which results in =
5 SPI
> > transfers (read pending IRQs is done twice) per RX'ed CAN frame.
> > (Assuming there is only 1 RX'ed frame pending and no pending IRQs after
> > the first loop.)
> >=20
> > I have some ideas how to optimize this:
> > - do a single SPI transfer instead of several small ones:
> >   e.g. pending IRQs + RX-FIFO level, or read RX'ed frames + mark as read
> > - opportunistically assume RX'ed frame on interrupt and get rid of 1st
> >   read pending IRQs
> > - assume TX done IRQ, if CAN frames have been TX'ed but not marked as
> >   sent hardware
> > - coalesce RX IRQs
> > - coalesce TX done IRQs
> > - combine several TX frames into single SPI transfer
> >=20
>=20
> Indeed there is a lot to work on, I'm a bit out of my depth here and
> as I said the first question is about why it interrupt is fired twice.
>
> It's not only the big loop that is run twice. With rx-int active what
> I can observe is this:
>=20
> - read RX-FIFO level [*]
> - read RX'ed CAN frames [*]
> - mark RX'ed CAN frames as read [*]
> - read pending IRQs [*]
> - exit if there are no pending IRQs
>  -> No Pending IRQ's Exiting.

So far that look correct, but the extra call to mcp251xfd_irq() that
follow is not correct.

> - read pending IRQs [*]
> - exit if there are no pending IRQs
> -> No Pending IRQ's Exiting.

> > > And for testing purposes I changed the interrupt config to trigger on
> > > falling edge instead of level and with this configured there is only
> > > one interrupt fired. But I guess this will risk locking the interrupt
> > > line low if an edge isn't detected.
> >=20
> > ACK - Please don't use edge triggered IRQs, sooner or later the driver =
will
> > miss an IRQ resulting in a handing driver. Always use level triggered w=
ith the
> > mcp251xfd.
> >=20
>=20
> Yes, I figured that.=20
>=20
> > > I have tried both with rx-int active and inactive. My scope shows
> > > really nice signals and that rx-int and int is deactivated
> > > simultaneous on incoming frames.
> >=20
> > rx-int is an optimization to skip the first get IRQ pending transfer, a=
s it
> > indicates RX'ed CAN frames.
>=20
> OFFTOPIC:
> Shouldn=E2=80=99t a return after the rx-int part be ok to skip the next g=
et IRQ pending transfer as well?=20

That's a possible optimization.

I would look at the number of pending TX CAN frames. The higher the
number, the higher the chance that some have been send.

> if (priv->rx_int) {
>   do {
>     int rx_pending;
>     rx_pending =3D gpiod_get_value_cansleep(priv->rx_int);
>    =20
>     if (!rx_pending)
>       break;
>=20
>     err =3D mcp251xfd_handle(priv, rxif);
>     if (err)
>       goto out_fail;
>=20
>     handled =3D IRQ_HANDLED;
>   } while (1);
>  =20
>   if (handled =3D=3D IRQ_HANDLED) {
>     return handled;
>   }
> }
> ...
>=20
> Even better would be to check if (IRQ.VALUE =3D=3D INACTIVE) but I don
> know how to that..

I think this is not possible in the Linux kernel anymore. There was a
function to get the GPIO associated with an IRQ, but that's not
available anymore. In general IRQs are not associated to GPIO, that's
probably only the case for SoCs, but not for other busses like PCI.

[...]

> > Can you test again with IRQ_TYPE_LEVEL_LOW and no rx-int-gpios. Please
> > instrument the beginning and the returns of the mcp251xfd_irq() functio=
n to
> > check if it's really started twice. Please print the
> > priv->regs_status.intf in every loop. Can you record the gpio2_5 with a
> > scope.
>=20
> Yes I can but what do you mean with Instrument?

That's a fancy way of saying: please add printk() :)

> And no scope until Monday.=20

no problem

> > Make sure that you don't send any CAN frames as reaction of reception.
>=20
> How do I make sure of that? :/=20

The Linux kernel doesn't send any CAN frames on its own. You need a user
space program to do so. Make sure you don't have any user space program
running that's sending CAN frames.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5xa4xxm36szszofp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHj/PEACgkQqclaivrt
76myRgf+NM8NEYjRpE39DQT8NkRSE/pwFSpQ2+i3UDJIEC6P/B7mMPlznaCFBu5+
mMbwi5zukmBsdnecweyFOZUWeyLNxrZLsUq9HPJPjxGwRFOUwH6cIruJn3NcXWU2
UmW2HY6d1/CuZHSRPGc/Az95jVlepAUEKiPPgwW1884Az6D/j2OxMDblalzUCXWF
xlHqcH2J6ri4NSwaEukoGOBoDGzRdkW9u+WqlBq4Rc8WhiEbXnXbC6M+9pXhBI0A
Ew0UdJnOXL6SuzOgkgZr7fqfw0a6sr5xBjPqLfNQr4Vua6+23TfqxhjkI3RWzoom
gYP7zFQna65Oqha9xbsUn/yaMNvnJQ==
=pDFF
-----END PGP SIGNATURE-----

--5xa4xxm36szszofp--
