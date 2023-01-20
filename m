Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F6A675FCF
	for <lists+linux-can@lfdr.de>; Fri, 20 Jan 2023 22:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjATVz6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Jan 2023 16:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjATVz5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Jan 2023 16:55:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEB72112
        for <linux-can@vger.kernel.org>; Fri, 20 Jan 2023 13:55:56 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pIzMX-0002m5-Na; Fri, 20 Jan 2023 22:55:53 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:2ea4:b8b6:f5b:5340])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8ACF915F01E;
        Fri, 20 Jan 2023 21:55:52 +0000 (UTC)
Date:   Fri, 20 Jan 2023 22:55:47 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>
Cc:     "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>,
        linux-can@vger.kernel.org
Subject: Re: AW: RE: mcp251xfd: rx frame truncation (1/2)
Message-ID: <20230120215547.ewa5npqsxf5jxjcr@pengutronix.de>
References: <FR0P281MB1966C774C1ED0752CCD6B80497C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966F32AD422DDD867F8C53A97C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB6484911640CCC738ED799E6FFBC79@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19663A60B0F7CE7F684A7A6297C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB64842584529FAEF279F7B137FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19669083201C1B9C2DFB9E5497C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB196633E4F8E1195086E2402B97C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB648434F2B7DE7F75E291E159FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230119133214.ofapvfc2rzi3gvn4@pengutronix.de>
 <FR0P281MB1966B0AD5BD74FA1AE550F2797C59@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x6oql7wfjlvlqdlo"
Content-Disposition: inline
In-Reply-To: <FR0P281MB1966B0AD5BD74FA1AE550F2797C59@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
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


--x6oql7wfjlvlqdlo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.01.2023 20:24:13, Stefan Alth=C3=B6fer wrote:
> Damn shit. The error triggered right soon after you last email. It took=
=20
> two more errors until I learned that is a good idea to save in native for=
mat
> first, and then attempt to export to vcd (which tends to hang).

doh!

> This time the frame in question was truncated to 4 bytes. The other cases=
 it was=20
> always truncated to 20 bytes.
>=20
> The regdumps were taken quite a while after the error.

I managed to load the VCD into pulseview, decode the SPI and even my old
mcp251xfd decoder shows something.

Keep the mailing list on Cc. As you cannot send the big dumps via the
list, you can send them to Thomas and me directly, but send the text
only mail to the list.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--x6oql7wfjlvlqdlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPLDeAACgkQrX5LkNig
011VCggAl0V3l3Q9Zb5raQiMqggC+mD4X2tzSg5Vq6F0oiNp79/G6MtO01pOP4Iq
gi7U3uyH0l9Q/5PWULDWLmo5u6ymYXrwzby1oBPHhjOjEuPY7jVOJnj6ZhnlqwYX
I5iAcY0NsdJ1YRf4wOs1Ij2oydzkBPmLRyTCDPeGxgZZaEqnIiWAoLi0LFTjr+uk
9zmGwb8bBA0PO7IBWq+Pnq6ZJcMw56DgzIebIfTlqeibiSqrOQYQbhfYWkXiwAkk
O5yT/m5WUhoS5JdZL+dAHWzhIA75TIknRXYOBwUZX0ydaeLrwKE/1txpbwsXikNm
0zZq/AZRJ49iji/1dkXWDf+LpUYRKw==
=fOaW
-----END PGP SIGNATURE-----

--x6oql7wfjlvlqdlo--
