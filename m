Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056CF67B21B
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 12:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjAYL6B (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 06:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjAYL6A (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 06:58:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E996D59F4
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 03:57:59 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pKePd-0006db-AL; Wed, 25 Jan 2023 12:57:57 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6554:ecba:20de:b047])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B435A1636E4;
        Wed, 25 Jan 2023 11:57:56 +0000 (UTC)
Date:   Wed, 25 Jan 2023 12:57:51 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>
Cc:     "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: AW: AW: RE: mcp251xfd: rx frame truncation (1/2)
Message-ID: <20230125115751.hr5tazhbb5wxpd4x@pengutronix.de>
References: <FR0P281MB196633E4F8E1195086E2402B97C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB648434F2B7DE7F75E291E159FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230119133214.ofapvfc2rzi3gvn4@pengutronix.de>
 <FR0P281MB1966B0AD5BD74FA1AE550F2797C59@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20230120215547.ewa5npqsxf5jxjcr@pengutronix.de>
 <BL3PR11MB64841AD10C3CFBC21A2A16FFFBC59@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19669C3FDDBE07D6B320C18997CA9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB64844C1C95CA3BDADAE4D8CCFBC99@BL3PR11MB6484.namprd11.prod.outlook.com>
 <BL3PR11MB648459B22CB39606D18FAED1FBCE9@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB1966FC9C7A02816BA8542A5097CE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v3pzxg4rhjgp6eyl"
Content-Disposition: inline
In-Reply-To: <FR0P281MB1966FC9C7A02816BA8542A5097CE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
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


--v3pzxg4rhjgp6eyl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.01.2023 11:25:48, Stefan Alth=C3=B6fer wrote:
> > Taken from one of your traces is data below We have a tef fifo size
> > of 4, so yeah in this scenario it's expected to have TEF full
> > situations. A larger TEF/Faster SPI/better SPI utilization would all
> > reduce the occurrence of the issue.
>=20
> I was pretty sure that my application never has more than three frames
> on the fly - having sent three frames I wait for the first to be
> arrived before I sent the next.

The driver takes care of flow control, no matter how many CAN frames you
send. If you send too many you'll get a -ENOBUFS.

> However, it seems that the RX IRQ processing is faster than than the TX I=
RQ
> processing and I am sending the next frame when the TX event fifo has not=
 yet
> been read.

ACK, the RX IRQ is processed before the TEF (TX complete IRQ), as we
cannot do flow control on the RX.

> As "buffer full" is no error (as opposed to buffer overflow), should this=
 really be
> a non debug kernel message? Some other means of getting such statistics a=
ppreciated
> (see my posting " mcp251xfd diagnostic outputs").

In the mainline version of the driver you'll get these error messages,
if the TEF doesn't contain the expected sequence number, probably
because the TX FIFO STA register shows a too big TX FIFO head index.
The root cause of this error wasn't known, so an error message is
printed. Feel free to test this series:

| https://lore.kernel.org/all/20230124152729.814840-1-mkl@pengutronix.de

It uses a similar workaround as in the RX FIFO STA workaround.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--v3pzxg4rhjgp6eyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPRGTwACgkQrX5LkNig
013vbQgAi15GegfkxAH/J8Fj8LksSPpSzASxjn8wxm68NBxlqLDzfFguZIYbEbNg
5aixhdQ122FtYmAjE6uuxAjtabwUltFWwedpWX1nQY4UoPb2USbYDbL8K3QTMZuu
Ut+d8IrNE6Mv+PC41NRCBV4nbwJxJ8JSGPVeq7EYRoh6ErJpTjm55wYwdHjEH3As
rfjt8Wcckq4NWWYCm64qTVG7YUz/I0B4qoYGNGpJrPgSNcPuRr92b7uzXtsPcjnC
FC2RImk9eQk/KDeiAtXmz40Z/38NX7akRCSUQAkNJF/CafXxEG2Jj7cBdca85FEC
56XMzwUvtjQ7eEBL5cNqEhyAkwtb+g==
=XaAk
-----END PGP SIGNATURE-----

--v3pzxg4rhjgp6eyl--
