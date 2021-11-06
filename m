Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA6C446EFD
	for <lists+linux-can@lfdr.de>; Sat,  6 Nov 2021 17:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhKFQkU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 6 Nov 2021 12:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhKFQkU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 6 Nov 2021 12:40:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2B8C061570
        for <linux-can@vger.kernel.org>; Sat,  6 Nov 2021 09:37:38 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mjOhF-0006in-3P; Sat, 06 Nov 2021 17:37:37 +0100
Received: from pengutronix.de (dialin-80-228-153-084.ewe-ip-backbone.de [80.228.153.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id DABEE6A5DD1;
        Sat,  6 Nov 2021 16:37:35 +0000 (UTC)
Date:   Sat, 6 Nov 2021 17:37:34 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 1/2 v2] can: peak_usb: always ask for BERR reporting for
 PCAN-USB devices
Message-ID: <20211106163734.yzgbfx6s4uaypdso@pengutronix.de>
References: <20211029125304.liokvwgi4qzsrz2i@pengutronix.de>
 <PA4PR03MB6797C3DDC084E6404B0BFBF6D68D9@PA4PR03MB6797.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ttzigtb6islqwa7x"
Content-Disposition: inline
In-Reply-To: <PA4PR03MB6797C3DDC084E6404B0BFBF6D68D9@PA4PR03MB6797.eurprd03.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ttzigtb6islqwa7x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.11.2021 17:06:59, St=C3=A9phane Grosjean wrote:
> - the rxerr/txerr counters were used for the first time to determine
> the new state from:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dc11dcee758302702a83c6e85e4c4c3d9af42d2b3
>=20
> - but their values could be read by the user space according to
> ctrl_mode, starting from:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dea8b33bde76c8fcef347b9b9cf15649fe41a5a6e
>=20
> Which one do you think is the most appropriate?

I'm taking the first one:
Fixes: c11dcee75830 ("can: peak_usb: pcan_usb_decode_error(): upgrade handl=
ing of bus state changes")

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ttzigtb6islqwa7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGGr0wACgkQqclaivrt
76kifAf/eT3aNC1++Bcf8i911rMmITv+3RSw1tRIkZbT8Sxam7/moQuTs3kB4JZy
xk6sdrfJ/U9UgpobvjlVNJvavpiAeauOT27YYTgvWY6zsN+4WKS0CoWiaZyHvi3d
zq2dnzC967wAdE1Q+2ZVvOwPiIuXMfGrxXo6JwoUgd12QAP7UU+hqM+w+NwEqcHK
/6u8SNQvMvBu5p47ffLIHtmz9r1g9ywZe3GUenmz8cV77eKpckhwhXCk1oMgp8Ss
dQvQIFeGwDstOdo3t2dsNOWPn5gnIhCz2B8VpAMVCjkKiibY/bHXc2ZbX0xBU3o5
DG5JYVdsOBnRunR5zmYxm0mSwvgO/A==
=iHso
-----END PGP SIGNATURE-----

--ttzigtb6islqwa7x--
