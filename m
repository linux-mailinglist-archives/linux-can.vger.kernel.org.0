Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF68C67AB1B
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 08:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjAYHmx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 02:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjAYHmw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 02:42:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4419A11653
        for <linux-can@vger.kernel.org>; Tue, 24 Jan 2023 23:42:51 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pKaQe-0000R5-1w; Wed, 25 Jan 2023 08:42:44 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6dc:cd87:5f9a:b36e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BD4E416332A;
        Wed, 25 Jan 2023 07:42:31 +0000 (UTC)
Date:   Wed, 25 Jan 2023 08:42:26 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Tom Evans <tom_usenet@optusnet.com.au>
Cc:     linux-can@vger.kernel.org,
        Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>,
        Thomas.Kopp@microchip.com, kernel@pengutronix.de
Subject: Re: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Message-ID: <20230125074226.k2pw7prjerab2l6t@pengutronix.de>
References: <20230111222042.1139027-1-mkl@pengutronix.de>
 <20230111223004.w7z4ghdahe7jvebe@pengutronix.de>
 <a269b5b8-a88d-d2da-5bcf-59f2aac40f87@optusnet.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gptff7pf3bp5e62f"
Content-Disposition: inline
In-Reply-To: <a269b5b8-a88d-d2da-5bcf-59f2aac40f87@optusnet.com.au>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--gptff7pf3bp5e62f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.01.2023 16:41:50, Tom Evans wrote:
> On 12/1/23 09:30, Marc Kleine-Budde wrote:
> > On 11.01.2023 23:20:37, Marc Kleine-Budde wrote:
> > > this is a proof of concept implementation to work around the
> > > "double-RX" erratum found by Stefan Alth=C3=B6fer.
> > >=20
> > > With the help of Thomas we found out that the chip has a time window
> > > after receiving a CAN frame where the RX FIFO STA register content is
> > > not read correctly.
>=20
> This is being called an "erratum". I take that to mean an admitted bug
> published by the chip manufacturer. Has there been any response from
> Microchip on this yet? If they could properly describe what's wrong, it
> might lead to more robust work arounds.

I'm working with Thomas from Microchip on this actively on this. We're
waiting from simulation results from the hardware team...

> I've noticed people know about the "maximum SPI clock rate", and are gett=
ing
> close to it in testing. The chip might have more (and more frequent)
> problems near that limit.

In Stefan's test setup one SPI bus uses 16.67 MHz and the other 10 MHz.
Stefan, Thomas, which chip shows the problem?

I have reproduced the problem at 15 MHz on a different SoC (i.MX6).

> The MCP2517FD has more errata items than the MCP2518FD. Anyone using the
> earlier chip might be seeing more problems than people using the MCP2518FD
> are.

Yes, Thomas found problems with the loopback mode of the MCP2517FD, but
we haven't looked deeper into that.

> The MCP2517FD (published Errata item #1) is sensitive to delays between S=
PI
> Write and delays between writes and Chip Select Deassertion. Some SPI
> drivers and setups don't use the SPI controller's native chip-select, but
> use GPIO pins for flexibility. On Linux that can result in long delays un=
til
> the GPIO Chip Select is deasserted, and long delays between bytes. There =
are
> DMA-based SPI controllers without these problems, but there may not be fu=
ll
> driver support for them. YMMV.
>=20
> Anyone seeing a difference in errors between two different SPI controllers
> might be seeing the results of different timing (chip select and byte to
> byte) between them.

Both Linux based tests system (rpi4, imx6) are using GPIO chip selects.
On the other hand Thomas has reproduced the broken RX FIFO STA register
read bug on a =C2=B5C based setup (with a mcp2518fd). As far as we understa=
nd
it, the problem occurs in a critical timing window between the reception
of a CAN frame and the reading of the RX FIFO STA register.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--gptff7pf3bp5e62f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPQ3V8ACgkQrX5LkNig
0113nAgAtTBTeLnK2xxFfCUlr8tew2tjMTIG9OFxRNCKHWAORwlj5hs1l4oyapuG
rCBo4jiaclAJ0jjV64TfP5XTjZRGtaZqpch6a1Qa0XDkzzeWO9Zaj71aF1FKxSHZ
sAVXtaMDap9o8KMI/9qWOXE62Pzu59TVp3/TFZqsdgStkf+xOUPEsIa0NJs85XS3
jt9dkj44VqRxXPMUOGy+HK3682k1u/2VUvgtTiFjnus2X/RtB7Yri4K7igxKpEZU
QnXCk4gbGDKpy3BBevV25DnQuCz+yx5eXX15iJBkRhgRuYyWIwX3MX76oEUFRYou
Pc0aE5Ia0fWa8IWFkc+gyPqUvRWamg==
=hf84
-----END PGP SIGNATURE-----

--gptff7pf3bp5e62f--
