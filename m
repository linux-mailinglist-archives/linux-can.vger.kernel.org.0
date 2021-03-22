Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5A7343BF9
	for <lists+linux-can@lfdr.de>; Mon, 22 Mar 2021 09:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCVIlu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Mar 2021 04:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVIlT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Mar 2021 04:41:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CA4C061574
        for <linux-can@vger.kernel.org>; Mon, 22 Mar 2021 01:41:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lOG7W-0001kN-Oe; Mon, 22 Mar 2021 09:41:06 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:2d14:11e9:80f:5de6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8F5FE5FCE38;
        Mon, 22 Mar 2021 08:31:29 +0000 (UTC)
Date:   Mon, 22 Mar 2021 09:31:28 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     linux-can@vger.kernel.org, Petr Porazil <porazil@volny.cz>,
        Han Xu <han.xu@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tiago Brusamarello <tiago.brusamarello@datacom.ind.br>
Subject: Re: CAN FD controllers (M-CAN tcan4x5x as well as Microchip
 mcp251xfd) fails on iMX6 eCSPI interface
Message-ID: <20210322083128.ehblmvyxo5rggeno@pengutronix.de>
References: <202103220906.52896.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wib7nlrln5hiepyj"
Content-Disposition: inline
In-Reply-To: <202103220906.52896.pisa@cmp.felk.cvut.cz>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--wib7nlrln5hiepyj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.03.2021 09:06:52, Pavel Pisa wrote:
> my colleague at Elektroline.cz works on design of iMX6
> based system with CAN FD support realized by tcan4x5x
> chip connected to eCSPI. It seems that there are problems
> with eCSPI DMA stucks and other troubles. When the same
> chip (or even Microchip's mcp251xfd) is connected to
> other (less industry sound platforms) as Allwinner etc...
> drivers seems to work reliably, but tests on iMX6 results
> in failures. They consider fast redesign to slCAN connected
> second Microchip MCU to resolve critical problem for the
> project now....

Don't use slcan, just don't.

- If you want to stick to the SPI, use a mcp2518fd.
- If you don't need CAN-FD, attach a stm32f042 or f072 via USB. There is
  a open source firmware and Linux drivers.
- If you need CAN-FD, use a more modern stm32. I think some of the "G"
  series have CAN-FD. But the firmware and Linux drivers are not
  adopted, yet.

Expect quite some CPU load for the SPI based CAN controllers, due to the
high Linux SPI overhead and the not that optimized imx SPI host driver.

> The setup on 5.7 kernel partially works

For the tcan4x5x better use latest v5.12 plus this series:
https://lore.kernel.org/linux-can/20210308102427.63916-1-torin@maxiluxsyste=
ms.com/

If the SPI DMA makes troubles, deactivate it. I think the tcan4x5x driver
uses single tcan4x5x register reads, which results in small SPI
transfers, so DMA brings no benefits.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wib7nlrln5hiepyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBYVd4ACgkQqclaivrt
76lFSQgAgEgUDDuRX2kjL7V9G5j3N1B1bOzp7Lhqz76MOCu4yRtLLZDZCnypIEci
/2W/OxtsmMq49kReKi+khNxBGViJztTRumkrAQ7PyE9lmnpjWKQARQ5xaYi8LtU6
bMsWJ5ZHuEJ1UQWlMe/4+Wy20rG4/KKe2gf+MkHF+0JfpIcmMEWN8AA54jqfIa02
LGMNqkjk2awri8TAM/PRZya67EE01ASXtWArIq3MtUlwfPNErdD91iDnKjFSAmKl
jYdV9BV4qw9ckDvrzJzJ9IKKpoujOFjGeFmgkSZ9R4t+TMwaO1Kb4iDpwHAFX2FZ
A3Im/aVsUtO6KSGrT9PyN9F20dSULQ==
=lIoL
-----END PGP SIGNATURE-----

--wib7nlrln5hiepyj--
