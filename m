Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636EC671C0A
	for <lists+linux-can@lfdr.de>; Wed, 18 Jan 2023 13:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjARM2L (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 Jan 2023 07:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjARM1d (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2023 07:27:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27758A72A
        for <linux-can@vger.kernel.org>; Wed, 18 Jan 2023 03:46:01 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pI6tD-0003B2-Db; Wed, 18 Jan 2023 12:45:59 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:37eb:cfb:76e3:a0a7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7553315AAD4;
        Wed, 18 Jan 2023 11:45:58 +0000 (UTC)
Date:   Wed, 18 Jan 2023 12:45:50 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Thomas.Kopp@microchip.com
Subject: Re: mcp251xfd: rx frame truncation
Message-ID: <20230118114550.clfspoo5ziax2gtz@pengutronix.de>
References: <FR0P281MB1966C774C1ED0752CCD6B80497C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xllfhvifzyyvub33"
Content-Disposition: inline
In-Reply-To: <FR0P281MB1966C774C1ED0752CCD6B80497C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
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


--xllfhvifzyyvub33
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.01.2023 11:26:31, Stefan Alth=C3=B6fer wrote:
>=20
> But now the real problem. After some time one of the socketcans is=20
> receiving only a truncated message:
>=20
> 1: idx    2 exp:2A5#00 02 F4 7C 7B F2 53 BD 53 84 B3 4B B7 5F AE 55 2D 88=
 13 25 7C D4 82 EF 85 35 9C 33 1B 7C 5B 55 91 4F D1 0D 41 24 CA 95 A9 7E E0=
 60 DD 8E B5 0A 16 C8 2F 92 9C B1 82 22 E6 1E 55 01 9A B0 56 2B
> 1:           rx:2A5#00 02 F4 7C 7B F2 53 BD 53 84 B3 4B B7 5F AE 55 2D 88=
 13 25

Thomas, can you try to reproduce and capture the SPI traffic?

> Ask if you want more information!

Stefan, can you capture the SPI traffic with a logic analyzer, too?
Preferred with sigrok/PulseView.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xllfhvifzyyvub33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPH2+sACgkQrX5LkNig
011IzQf7Btu9ybvanAI8NyjyAeSAYzXvfBA2HdbbTQe4QNHkZ0yRRbx3FHP+xt0G
FGuzp6Ocxv3NybN0jU5A5A7o3a8OUNzrpeHADW+DUOa/5xNSF7PHglkaGz44EO0C
C+co7j7WeQV0cvBFBnZ9fZnOK1kGQVH62FAFDYEdmS+JlbjBMAilxTPvh6z8ORha
9Y1aQbxGropuKXW/r+mKxlUw52JjOFeASn/ELgSSwC/NxYy5w+kvADSMT6u1bIMj
1PNIkOnLBOdjMRQkc4z7srAYLTDl3p02HMI76jA1790PNOSURw+0hP/zqE+oYdFe
XlbiOI4Wf02WEM4QlObhlnBVHyuYWg==
=FTT9
-----END PGP SIGNATURE-----

--xllfhvifzyyvub33--
