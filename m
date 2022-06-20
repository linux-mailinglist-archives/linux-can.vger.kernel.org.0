Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E453551F4E
	for <lists+linux-can@lfdr.de>; Mon, 20 Jun 2022 16:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbiFTOpt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 20 Jun 2022 10:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238798AbiFTOph (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Jun 2022 10:45:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE6B3633A
        for <linux-can@vger.kernel.org>; Mon, 20 Jun 2022 07:05:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o3I1o-0005hd-Oe; Mon, 20 Jun 2022 16:05:21 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-e9db-b4a8-ed00-0d4b.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:e9db:b4a8:ed00:d4b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E4A169A09A;
        Mon, 20 Jun 2022 14:05:19 +0000 (UTC)
Date:   Mon, 20 Jun 2022 16:05:19 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: ram initialization on mcp2518fd
Message-ID: <20220620140519.l5uat7oqiif63ns4@pengutronix.de>
References: <e3f73c56-1b46-4ee9-357e-40400c746e09@prevas.dk>
 <87wndgyl2l.fsf@hardanger.blackshift.org>
 <441514ec-7b43-e11c-09b5-bdaf7fca0077@prevas.dk>
 <d614f497-b8f2-68cd-745b-1e3be2b991d5@prevas.dk>
 <20220616124056.cnnvlqwwkknjta7w@pengutronix.de>
 <8db56a87-a1c7-1810-ad74-c7a8e268a00d@prevas.dk>
 <20220617141751.ua3emcdaarrnx7si@pengutronix.de>
 <6e01d1e0-4e26-c42f-5d8d-f5aabe0d9d31@prevas.dk>
 <20220620102732.uou37hhhbaspgmb3@pengutronix.de>
 <3da42c74-66d7-b41d-be7f-87ce687f99b8@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tthwfzluu46dciyf"
Content-Disposition: inline
In-Reply-To: <3da42c74-66d7-b41d-be7f-87ce687f99b8@prevas.dk>
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


--tthwfzluu46dciyf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.06.2022 15:36:35, Rasmus Villemoes wrote:
> >>> What does it read on your board? But still that transfer should work.

[...]

> So the problem was that I was using native chip select, i.e. my pinmux
> setting was
>=20
> MX8MP_IOMUXC_ECSPI1_SS0__ECSPI1_SS0	0x00000144

HW chip selects are broken in the spi-imx driver/hardware, at least how
to the Linux SPI stack uses them.

> and that means the controller only asserts the CS line for the duration
> of one burst; so when the spi message contains two transfers, it
> obviously breaks as the device saw the release of CS after the two
> command/address bytes as the end of the transaction [then, from the
> device's POV another begins, but there MOSI is all 0, so that may get
> interpreted as a reset command, or perhaps it's ignored because it's not
> precisely 16 0 bits - I wonder how the hardware designers thought
> all-zeros was a good idea for a reset command].
>=20
> Switching to gpio, i.e.
>=20
> MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09	0x00000144
>=20
> means CS is held low for the whole message, and I now read the expected
> contents.

\o/

> It's probably not anything to do with the mcp2518fd driver and this is
> straying somewhat from the original problem, but I see that CS is held
> low for a very long time after the last byte has been shifted in/out, on
> the order of 0.5ms. https://ibb.co/n1Hq3YR shows the first write to OSC,
> and zooming out shows https://ibb.co/12Z1YkM (or just looking at the
> mouse-over info in the first one).
>=20
> Similarly, there's a rather large gap between the two spi_transfers in
> the case of the reading of dev_id (but, per the above, with CS correctly
> held throughout): https://ibb.co/pyG1y96 .
>=20
> I'm not sure if this is to be expected.

It's the IRQ latency from transfer complete until the CS is deasserted
in software. In kernel v5.19 you will find some patches the improve the
imx-spi driver to use polling for short transfers, which greatly reduces
the latency you've measured.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--tthwfzluu46dciyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKwfpwACgkQrX5LkNig
010KPgf/Z27vKn0V2/RbTeY15JI/zjcVWfPp2UGVq7HH9bw6MjkpCt6RLoPtkgBz
QVkADjI0K02LxgHzLpQmlLifKbtZbL5HyTy6DWw5joFBB+fZFQCD8lJTh8YB6o30
siDuIMyoz8XZrxdatRtm/TwJJ3Hp7Hfkn3fWJjnVcGoZzljGBo+3J4L1ayXnALg7
IkYUpltbA0bZ+CnEJOf3pOvo0rvWJ3Ugo3DwMLtZSZ4I5ej3DmUxlvKB9WkYeKp2
sl/vt0XU181Jq1xKHF3dv2aHpPqjc0mih3BqWRaQxXfADFanx2rVd+4gnCAJv3fe
5XizMEg55g0Zso1enjjESMNQsr12rg==
=pD+0
-----END PGP SIGNATURE-----

--tthwfzluu46dciyf--
