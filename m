Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE893D56A7
	for <lists+linux-can@lfdr.de>; Mon, 26 Jul 2021 11:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhGZIun (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 04:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhGZIun (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 04:50:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19383C061757
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 02:31:12 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m7wx4-0008Qa-0o; Mon, 26 Jul 2021 11:31:10 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1455:5f5:50a2:3493])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D1EBB657E18;
        Mon, 26 Jul 2021 09:31:08 +0000 (UTC)
Date:   Mon, 26 Jul 2021 11:31:08 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Yasushi SHOJI <yasushi.shoji@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, linux-can@vger.kernel.org,
        Yasushi SHOJI <yashi@spacecubics.com>
Subject: Re: [PATCH] can: mcba_usb: fix memory leak in mcba_usb
Message-ID: <20210726093108.4uqfrvoiu5d2s4br@pengutronix.de>
References: <CAELBRW+6BGDPaUGrTDJtv020zF1AvtBAy2Jb1+i=uDbcH+0SzA@mail.gmail.com>
 <20210725111242.2d9a819f@gmail.com>
 <CAELBRWJQ+QN6+D0M-61Fz818fm7Q-pP4LW=-KUe+nsyFFSXXPg@mail.gmail.com>
 <20210725162720.74fu6qny6dqdc625@pengutronix.de>
 <CAELBRWKqs_XndF46Ucw9g0Y0n2q9qz-iO+CHyDvdJGMt37OuwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y3uqoqeli2iwj6kb"
Content-Disposition: inline
In-Reply-To: <CAELBRWKqs_XndF46Ucw9g0Y0n2q9qz-iO+CHyDvdJGMt37OuwQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--y3uqoqeli2iwj6kb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2021 01:35:53, Yasushi SHOJI wrote:
> On Mon, Jul 26, 2021 at 1:27 AM Marc Kleine-Budde <mkl@pengutronix.de> wr=
ote:
> > Yes absolutely - but I don't have access to that hardware. Since you're
> > interested in that hardware, what about adding you as a reviewer to the
> > kernel. Then for every change on this driver, you'll be added on Cc and
> > can test it. What do you think?
>=20
> Sure, I'm happy to help.

Great! I've send an update to the MAINTAINERs file, Can you reply with
your "Acked-by:"?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--y3uqoqeli2iwj6kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmD+gNkACgkQqclaivrt
76nXOwf/cMFUflTY/1TLldyQlsR1aHDp6hoBeNiP21rRNYNR0xHG+MuAgz31BJc8
BhLPbrNAq8QrshCTArCOuDn4hOxb4p6OwJ+hVJSkwTbl0PZjH2J7CNebFbPtqZaZ
Mey8UKanoYCv9f1uC/sd07JxTsPIYtcJCLnRfL1/4EU36PzWO6+mzk9uuT35euUS
o23su+7Gt5M080ouP6/5xz5o26/v74U9TsSdtNKOkvRTrCDDFUkDKiaO82P+CYs5
1W/rCKhVZF2yVS6UWf8RyVaDAYpIN952Kl01MWzEVMe0qqm2uLFw8mLcKZBZlzY0
IxHDsKAFnkUwQcHWNPfO8OrN50UdGw==
=t0a1
-----END PGP SIGNATURE-----

--y3uqoqeli2iwj6kb--
