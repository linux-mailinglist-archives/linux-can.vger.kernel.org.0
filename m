Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF6C3D4A18
	for <lists+linux-can@lfdr.de>; Sat, 24 Jul 2021 23:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhGXUrH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 24 Jul 2021 16:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhGXUrG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 24 Jul 2021 16:47:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35471C061575
        for <linux-can@vger.kernel.org>; Sat, 24 Jul 2021 14:27:38 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m7PBI-0008ND-LJ; Sat, 24 Jul 2021 23:27:36 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:41cc:c65c:f580:3bde])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0C9146571AB;
        Sat, 24 Jul 2021 21:27:35 +0000 (UTC)
Date:   Sat, 24 Jul 2021 23:27:34 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?TcOkdGpl?= <Stefan.Maetje@esd.eu>
Cc:     "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH 1/1] can: j1939: j1939_session_tx_dat(): Fix build
 failure introduced by renaming skcb to se_skcb
Message-ID: <20210724212734.lzqkurwwrrfgqara@pengutronix.de>
References: <20210716123437.20825-1-Stefan.Maetje@esd.eu>
 <20210716123437.20825-2-Stefan.Maetje@esd.eu>
 <20210716123602.lrtgklvsp2c5poly@pengutronix.de>
 <a7c4f2e9e1eb413827e5b226060083f09f0b8471.camel@esd.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="agdekxuasjhuk652"
Content-Disposition: inline
In-Reply-To: <a7c4f2e9e1eb413827e5b226060083f09f0b8471.camel@esd.eu>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--agdekxuasjhuk652
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.07.2021 12:45:17, Stefan M=C3=A4tje wrote:
> Am Freitag, den 16.07.2021, 14:36 +0200 schrieb Marc Kleine-Budde:
> > On 16.07.2021 14:34:37, Stefan M=C3=A4tje wrote:
> > > The patch a2ea50608a02ac48371a9fab0167c1b44457913e renamed the
> > > session skb control buffer from skcb to se_skcb. But that patch
> > > missed one occurrence of skcb which leads to a build failure.
> > >=20
> > > This patch renames also the last occurrence of skcb to fix it.
> > >=20
> > > Signed-off-by: Stefan M=C3=A4tje <Stefan.Maetje@esd.eu>
> >=20
> > Thanks, I've already fixed the here yesterday, but not pushed it yet.
> > Sorry for that.
> >=20
> > Marc
> >=20
> It's fine that it is fixed already. If you could push it now then I could=
 easily
> throw my patch away and start over.

done - pushed to linux-can-next/testing

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--agdekxuasjhuk652
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmD8hcMACgkQqclaivrt
76n86ggAh2Vkx/hCFh5F0DTn+HIXJKeDKb7/bgP92ZXtW+qLVGE7wKLe/wb9wbz6
QZLTatmvsImW5rTKq1hMkwbcWasNbXdbhRZe/2g4ScliEjjH2RCT9H0Jvnp/0jRU
B02RpBc3f6Zimoyw3t1UlEufhx+LAzouq4sJavbeBCKfVklswLe191Psr7ZXvCVW
99k9mGsSwLyAB/RYXDErOMlPnxpGrXw/MLQn5tak9HgBwNWDtlBfuye2Jitj1OE1
GeQKJHqXaUWofTHHwfQzDZ0dzMcOdcRL0kl69sE+i9CPQmMHGE2ba70phGEPMh6c
FUR2xPwtKqP1JNIlrGi32KZYzp7WwA==
=ieou
-----END PGP SIGNATURE-----

--agdekxuasjhuk652--
