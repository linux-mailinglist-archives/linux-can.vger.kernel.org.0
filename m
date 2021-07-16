Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD79A3CB768
	for <lists+linux-can@lfdr.de>; Fri, 16 Jul 2021 14:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhGPMjC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Jul 2021 08:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbhGPMjB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Jul 2021 08:39:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02049C06175F
        for <linux-can@vger.kernel.org>; Fri, 16 Jul 2021 05:36:06 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m4N4W-00018d-7E; Fri, 16 Jul 2021 14:36:04 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:df95:c0e5:d620:3bac])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3069D650A36;
        Fri, 16 Jul 2021 12:36:03 +0000 (UTC)
Date:   Fri, 16 Jul 2021 14:36:02 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?TcOkdGpl?= <Stefan.Maetje@esd.eu>
Cc:     o.rempel@pengutronix.de, linux-can@vger.kernel.org
Subject: Re: [PATCH 1/1] can: j1939: j1939_session_tx_dat(): Fix build
 failure introduced by renaming skcb to se_skcb
Message-ID: <20210716123602.lrtgklvsp2c5poly@pengutronix.de>
References: <20210716123437.20825-1-Stefan.Maetje@esd.eu>
 <20210716123437.20825-2-Stefan.Maetje@esd.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tc7vxyqr5rtrvlre"
Content-Disposition: inline
In-Reply-To: <20210716123437.20825-2-Stefan.Maetje@esd.eu>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--tc7vxyqr5rtrvlre
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.07.2021 14:34:37, Stefan M=C3=A4tje wrote:
> The patch a2ea50608a02ac48371a9fab0167c1b44457913e renamed the
> session skb control buffer from skcb to se_skcb. But that patch
> missed one occurrence of skcb which leads to a build failure.
>=20
> This patch renames also the last occurrence of skcb to fix it.
>=20
> Signed-off-by: Stefan M=C3=A4tje <Stefan.Maetje@esd.eu>

Thanks, I've already fixed the here yesterday, but not pushed it yet.
Sorry for that.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--tc7vxyqr5rtrvlre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDxfTAACgkQqclaivrt
76muCwf+O9ZxvdDWcwJKutMV+5C6wSC8JJBSaR+LMTtrK/iMWu6a57X2QCV2IliM
HjrjmQo+5MGyvRTQdFc4XqdAcQer4kkODzH2b89BpqkNZTLByYP+zVsKy8HIy7+u
Qk2iRm0Cwas2ulEbwSL7DNeRBvN03uG2ZCUS9YgXp2KzIbvT0BylRLT9Tfr32RjS
yHtEn4v7Mp2yjlgVvfg/s5PsPLsiCK0VLAVeYdWjkUJ57gJyDEfHp/CP48KlGut7
tFxjyv+dVnzoK5ZRnWyTTQmbzy1UYM2udufPi8zcyaig/V09PFTNl5z1RJ9ie/wx
sjMymQtgwGwPj9NZ+WiGO6WkMTrPww==
=NYLH
-----END PGP SIGNATURE-----

--tc7vxyqr5rtrvlre--
