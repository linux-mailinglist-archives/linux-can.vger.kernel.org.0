Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED696FC000
	for <lists+linux-can@lfdr.de>; Tue,  9 May 2023 09:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjEIHGQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 May 2023 03:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbjEIHGP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 May 2023 03:06:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A5DD06A
        for <linux-can@vger.kernel.org>; Tue,  9 May 2023 00:06:09 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pwHQE-0002Zp-6w; Tue, 09 May 2023 09:06:06 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id F07121C09EC;
        Tue,  9 May 2023 07:06:04 +0000 (UTC)
Date:   Tue, 9 May 2023 09:06:04 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Frank Jungclaus <Frank.Jungclaus@esd.eu>,
        Stefan =?utf-8?B?TcOkdGpl?= <Stefan.Maetje@esd.eu>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] can: esd_usb: Add support for esd CAN-USB/3
Message-ID: <20230509-smirk-viewing-5e13ea0abfeb-mkl@pengutronix.de>
References: <20230504154414.1864615-1-frank.jungclaus@esd.eu>
 <20230504154414.1864615-3-frank.jungclaus@esd.eu>
 <CAMZ6RqKgJs-yJaaqREmN1SkUzE1EkGtjBzXiATKx5WL+=J48dQ@mail.gmail.com>
 <ff1374d58d98a42d5f78a2685c748730b26926b9.camel@esd.eu>
 <CAMZ6RqLaDNy-fZ2G0+QMhUEckkXLL+ZyELVSDFmqpd++aBzZQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cztyro3zp6gjit3p"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLaDNy-fZ2G0+QMhUEckkXLL+ZyELVSDFmqpd++aBzZQg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--cztyro3zp6gjit3p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.05.2023 10:28:13, Vincent MAILHOL wrote:
> > > And because hdr.len is initially 3, hdr.len becomes 5. Right? Shouldn=
't it be 8?
> >
> > It might be a little confusing, but I think it's fine.
> > hdr.len is given in units of longwords (4 bytes each)! Therefore we
> > have 12 bytes (the initial 3 longwords) for struct tx_msg before
> > tx_msg.data[].
> > Than (8 + 3)/4=3D2 gives us 2 additional longwords for the 8 data bytes.
> > So that 3+2=3D5 (equal to 20 bytes) should be ok.

I think the term longword is more commonly used in non-Unix operating
systems :)

> OK. So you want to round up the length to the next sizeof(long) multiple,=
 right?
>=20
> First, sizeof(long) being platform specific, you need to declare a
> macro to make your intent explicit.
>=20
> /* Size of a long int on esd devices */
> #define USB_ESD_SIZEOF_LONG 4
>=20
> Please test, but for what I understand, below line is an equivalent
> and a more readable way to achieve your goal:
>=20
>           msg->hdr.len =3D DIV_ROUND_UP(cf->len, USB_ESD_SIZEOF_LONG);

use "sizeof(u32)"

> Also, add documentation to your structure to explain that hdr.len
> represents the length in long, not in bytes.

=2E..lengths in multiple of u32.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cztyro3zp6gjit3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRZ8NkACgkQvlAcSiqK
BOi/CAgArXZ33VpP5wJ4EAb+iWT5U6PxBpnmIS+/HV+/5DY0Jk8tc7eNJfTTVqGv
95HKRAZJSfE/tI9B/SUWu4jDyn76IFR2/WvtB1KZmJtznQb3GN+xjsEEfzgckRZk
JLJGfQpxt2DhZGY2xrGnWWjTZaPrha5IguFmSiFqfomMt1loYkksVlik7sdNRi/n
WZgDZUw7hNRpbMR6ksnSZzN1JC+IXTifqv57drc5eA8LwZn8+jgyatfqZuSz0o7x
THmEnaLWRhHgaSorH1vRE0YBmB2tcmetxZyVe1QyB4GEg+/DLBjrSwKo9bTDa7QD
pcQ21qLLS32BnbzkLBCGrE3hoeFytQ==
=IRkV
-----END PGP SIGNATURE-----

--cztyro3zp6gjit3p--
