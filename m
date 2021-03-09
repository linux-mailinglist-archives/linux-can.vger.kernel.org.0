Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B9A332A68
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 16:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhCIP2C (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 10:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhCIP1n (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 10:27:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88D1C06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 07:27:43 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJeGs-0007gy-9T; Tue, 09 Mar 2021 16:27:42 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4699:faa8:8510:ac25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 15AA25F1E84;
        Tue,  9 Mar 2021 15:27:41 +0000 (UTC)
Date:   Tue, 9 Mar 2021 16:27:40 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 2/3] can/peak_usb: add forgotten supported devices
Message-ID: <20210309152740.mbrkzp3vz53ojeua@pengutronix.de>
References: <20210309110739.x2njhvrau5v5vtaz@pengutronix.de>
 <PA4PR03MB6797F30B0A13B189E969933AD6929@PA4PR03MB6797.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nbttwacwnsixb7cf"
Content-Disposition: inline
In-Reply-To: <PA4PR03MB6797F30B0A13B189E969933AD6929@PA4PR03MB6797.eurprd03.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--nbttwacwnsixb7cf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2021 14:22:38, St=C3=A9phane Grosjean wrote:
> Hi Marc,
>=20
> PCAN-USB X6 support has been added by
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Df00b534ded60bd0a23c2fa8dec4ece52aa7d235f
>=20
> PCAN-Chip USB support has been added by
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dea8b65b596d78969629562f9728f76cbf565fbec
>=20
> Should I update the patch description with these commit Id and push a
> v2?

No need, I've updated the patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--nbttwacwnsixb7cf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBHk+kACgkQqclaivrt
76lnaAgAozm43yIHOq4I99mHOdBdNk6cJZaafZbxgYqyzubX8jvYyvH4nfmVcE4K
QPpQ4Bkt1Ke6Ese2rjlRU0xnN6bcGg6smGqxeaWe7bzEJvbpusAhlPhvgLIslEDe
+bLKjjVFC6jele7lu15XE3JF2RPFXgim0mLOejdNnkKLlrneeN4sETCndHUh58KK
kqlpaQlBuaxvO3q+aTzFCHgtYRNRNTujt8WEhWJ0L5pz1vW8BUs5OYuggAU/vyv7
4Y3jSJlpvzefnXLxt2SVDrFrxAGCxr8h1RAo+CcAg7sOzTYo+z8DdRU/1OSltiPB
0LrBApJlxneWpslPtkj7RZs+EFJpRA==
=5VOP
-----END PGP SIGNATURE-----

--nbttwacwnsixb7cf--
