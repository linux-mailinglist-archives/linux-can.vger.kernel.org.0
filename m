Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D853343E80
	for <lists+linux-can@lfdr.de>; Mon, 22 Mar 2021 11:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCVKyu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Mar 2021 06:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCVKyU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Mar 2021 06:54:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A91C061574
        for <linux-can@vger.kernel.org>; Mon, 22 Mar 2021 03:54:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lOICI-00013a-Sc; Mon, 22 Mar 2021 11:54:10 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:2d14:11e9:80f:5de6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4D1AD5FCFD6;
        Mon, 22 Mar 2021 10:53:56 +0000 (UTC)
Date:   Mon, 22 Mar 2021 11:53:55 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     linux-can@vger.kernel.org, Petr Porazil <porazil@volny.cz>,
        Han Xu <han.xu@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tiago Brusamarello <tiago.brusamarello@datacom.ind.br>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: CAN FD controllers (M-CAN tcan4x5x as well as Microchip
 mcp251xfd) fails on iMX6 eCSPI interface
Message-ID: <20210322105355.k33jpdfhxzk45evu@pengutronix.de>
References: <202103220906.52896.pisa@cmp.felk.cvut.cz>
 <20210322083128.ehblmvyxo5rggeno@pengutronix.de>
 <202103221045.40634.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5s5xiniupwssevae"
Content-Disposition: inline
In-Reply-To: <202103221045.40634.pisa@cmp.felk.cvut.cz>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--5s5xiniupwssevae
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.03.2021 10:45:40, Pavel Pisa wrote:
> Hello Marc,
>=20
> thanks much for the fast reply.
>=20
> On Monday 22 of March 2021 09:31:28 Marc Kleine-Budde wrote:
> > On 22.03.2021 09:06:52, Pavel Pisa wrote:
> > > my colleague at Elektroline.cz works on design of iMX6
> > > based system with CAN FD support realized by tcan4x5x
> > > chip connected to eCSPI. It seems that there are problems
> > > with eCSPI DMA stucks and other troubles. When the same
> > > chip (or even Microchip's mcp251xfd) is connected to
> > > other (less industry sound platforms) as Allwinner etc...
> > > drivers seems to work reliably, but tests on iMX6 results
> > > in failures. They consider fast redesign to slCAN connected
> > > second Microchip MCU to resolve critical problem for the
> > > project now....
> >
> > Don't use slcan, just don't.
>=20
> Yes, I agree with it and argued it to my colleagues but they are
> so frustrated by more problems in iMX6 and imxRT erratas that they

imxrt, as in the mmu-less =C2=B5C?

> believe that serial port has highest probability to not been broken.

I can ask my coworker Uwe to tell horror stories about the imx serial
port driver if you want :D
I haven't thought that far, I even don't recommend slcan from the CAN
point of view.

> > - If you want to stick to the SPI, use a mcp2518fd.
> > - If you don't need CAN-FD, attach a stm32f042 or f072 via USB. There is
> >   a open source firmware and Linux drivers.
>=20
> They have Microchip PIC32 for power management in the design and quite
> good experience with it, so they can use little more advanced one
> with CAN FD and use it at CAN interface.

I suggest to use a PIC32 with USB and CAN, to get rid of the SPI. The
existing STM32F0x2 firmware can probably be ported to the PIC32 so that
you can re-use the gs-usb driver unter Linux.

> The idea to use SPI connected MCU (in my case NXP LPC) come to my mind
> at LinCAN era when everybody used MCP2515 with horrible single
> register operation overhead. Can you suggest SPI protocol for CAN, CAN
> FD MCU connection as the SocketCAN interface?

Don't do SPI in the first place, use USB.

Back to the SPI:
If you have a full blown =CC=A7=CC=A7=C2=B5C you don't want to access the =
=C2=B5C's CAN
controller on the register level, but send/receive complete CAN
messages. We don't have a SPI driver for that, but you can model the SPI
messages like the gs-usb USB messages.

> Is there plan for CAN FD version? Anyway if the problems are caused by
> NXP SPI, then they can creep in still.

The only advantage on sending/receiving full CAN messages over SPI is
that you have less overhead compared to register level access. But the
imx SPI host driver will probably still use a lot of CPU.

> > - If you need CAN-FD, use a more modern stm32. I think some of the "G"
> >   series have CAN-FD. But the firmware and Linux drivers are not
> >   adopted, yet.
>=20
> We have solved and mainlined CAN FD on imxRT on NuttX and Microchip
> SAME70 (mainlining to NuttX expected soon) so we can reuse these.

Sounds good. Next step would be to add a gs-usb compatible USB device
driver. There already is a not mainlined gs-usb-fd
(https://github.com/linklayer/gs_usb_fd), but linklayer lost interest in
mainlining it.

> > Expect quite some CPU load for the SPI based CAN controllers, due to the
> > high Linux SPI overhead and the not that optimized imx SPI host driver.
>=20
> Yes, I am not fan of these solution (you know our CTU CAN FD effort,
> hopefully headers generator rewrite comes to the table next month),
> but Elektroline company needs industrial range system and could not
> wait for iMX8X with CAN FD controllers at the project start time.

don't use imx8x, use the imx8mp instead.

> > > The setup on 5.7 kernel partially works
> >
> > For the tcan4x5x better use latest v5.12 plus this series:
> > https://lore.kernel.org/linux-can/20210308102427.63916-1-torin@maxiluxs=
yste
> >ms.com/
>=20
> Thanks, we will test that for sure but for production we probably
> need to backport to 5.10 because it has chance for serious LTS
> support from Civil Infrastructure Platform (adding Pavel to CC)
> for standard and even better preempt-RT kernels.

Ok

> > If the SPI DMA makes troubles, deactivate it. I think the tcan4x5x driv=
er
> > uses single tcan4x5x register reads, which results in small SPI
> > transfers, so DMA brings no benefits.
>=20
> Yes, we try that. I have some reminiscence form old time that we have
> done some similar tricks on imx53 to make it work in infussion system dem=
o.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5s5xiniupwssevae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBYd0AACgkQqclaivrt
76lAiwgAnlAN3CfylRpgn62OEQBPKj4TRU4y4Mj4nHCoNKdmXF4iLNRYebnJnVtC
6xCYTThaHIgylW44WtbAGzOe0aPws/RLolkUrrG+Vd3RZMJ8MEKz9uAY2Od/JvIP
uwiNomkhgVaxuM6OowSyiSs2j0XGun9Vm683lu5s/T77sz8UYCtbydmLieh2/br/
Ln1+8iV6+1RNTOrOtzSnzIYilhetE06OPV71nzk9PVKblwdDC5Y8VTN6tR7pUH/e
lmux6/FflNMT0MWHpECUyUiEv68WFRSyqCxXARhfxSnWoKMetD5lLFrFPHXTDPrL
aE5ow+C+KbyAt3vp/ay+DZDQWpvtZw==
=NDsg
-----END PGP SIGNATURE-----

--5s5xiniupwssevae--
