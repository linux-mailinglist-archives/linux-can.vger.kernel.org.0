Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FA2672784
	for <lists+linux-can@lfdr.de>; Wed, 18 Jan 2023 19:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjARS4M (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 Jan 2023 13:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjARS4L (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2023 13:56:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C515957F
        for <linux-can@vger.kernel.org>; Wed, 18 Jan 2023 10:56:10 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pIDbU-0000pf-2k; Wed, 18 Jan 2023 19:56:08 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:edde:b534:8a61:9dbc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3605C15B0EA;
        Wed, 18 Jan 2023 18:56:06 +0000 (UTC)
Date:   Wed, 18 Jan 2023 19:55:57 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>
Subject: Re: AW: mcp251xfd: rx frame truncation
Message-ID: <20230118185557.vd6shcvu2zp2eror@pengutronix.de>
References: <FR0P281MB1966C774C1ED0752CCD6B80497C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20230118114550.clfspoo5ziax2gtz@pengutronix.de>
 <FR0P281MB19661D8535674EB92D142EBE97C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eswry7qzgm6vevna"
Content-Disposition: inline
In-Reply-To: <FR0P281MB19661D8535674EB92D142EBE97C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
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


--eswry7qzgm6vevna
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.01.2023 12:25:21, Stefan Alth=C3=B6fer wrote:
> > Stefan, can you capture the SPI traffic with a logic analyzer, too?
>=20
> Should be possible, but I need to change my hardware setup to have both o=
f my click board on
> the on pi. So have some patience ;-) I can save as vcd, which you can imp=
ort in sigrok.

Sounds good!

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--eswry7qzgm6vevna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPIQLsACgkQrX5LkNig
0109RAgAl0L//9eJ+Z63Uizh7kuqJDOW1x44yeXyWQO3dhBVql6sFm7xCa7NoCS+
4VgG6ODLuN4Il8lek50CZcCZY7TpOL/fXH14MO5Gi/WPKLJfUqBnUYu2HymTzTLL
PEi77tw0J2515uwtTsoh8Y+fp4ZkN7GcpNgqEXhHjwGx1MQb611HIFOS3FCbUpEm
sUF6qqDZHvUU+0g5hbl6JD+xmSZKfvJRjScQUH5UcPlEGJQYCw/jPQpz/VEPqYZf
jBFfM66DUVhIqDVL22ySR0capDRtZ9PJXuyTEd3toRbDqKdNlPWzur0Z80p40Mhv
KVMTpQ3oVyLZzKHDO1lPSabAzBBLww==
=8zeb
-----END PGP SIGNATURE-----

--eswry7qzgm6vevna--
