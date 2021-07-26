Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED98D3D5864
	for <lists+linux-can@lfdr.de>; Mon, 26 Jul 2021 13:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhGZKhN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 06:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhGZKhN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 06:37:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F1AC061757
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 04:17:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m7yc8-0006J9-Ek; Mon, 26 Jul 2021 13:17:40 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1455:5f5:50a2:3493])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 29FDD657F96;
        Mon, 26 Jul 2021 11:17:39 +0000 (UTC)
Date:   Mon, 26 Jul 2021 13:17:38 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Yasushi SHOJI <yashi@spacecubics.com>
Cc:     Yasushi SHOJI <yasushi.shoji@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcba_usb: fix memory leak in mcba_usb
Message-ID: <20210726111738.pgdhynfnw2xaigp5@pengutronix.de>
References: <CAELBRW+6BGDPaUGrTDJtv020zF1AvtBAy2Jb1+i=uDbcH+0SzA@mail.gmail.com>
 <20210725111242.2d9a819f@gmail.com>
 <CAELBRWJQ+QN6+D0M-61Fz818fm7Q-pP4LW=-KUe+nsyFFSXXPg@mail.gmail.com>
 <20210725162720.74fu6qny6dqdc625@pengutronix.de>
 <CAELBRWKqs_XndF46Ucw9g0Y0n2q9qz-iO+CHyDvdJGMt37OuwQ@mail.gmail.com>
 <20210726093108.4uqfrvoiu5d2s4br@pengutronix.de>
 <CAGLTpnK2_v9rEvFgsp8ARrSncYLa1vqfgVh-WzGs0qESfCgehw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hlfy6xhsokwlj4k7"
Content-Disposition: inline
In-Reply-To: <CAGLTpnK2_v9rEvFgsp8ARrSncYLa1vqfgVh-WzGs0qESfCgehw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--hlfy6xhsokwlj4k7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2021 19:42:28, Yasushi SHOJI wrote:
> Hi Marc,
>=20
> On Mon, Jul 26, 2021 at 6:31 PM Marc Kleine-Budde <mkl@pengutronix.de> wr=
ote:
> > Great! I've send an update to the MAINTAINERs file, Can you reply with
> > your "Acked-by:"?
>=20
> Acked-by: Yasushi SHOJI <yashi@spacecubics.com>

Sorry for not being clear - I mean reply to the patch I've send.

However, I've updated your email address, add your Acked-by and sent a
v2.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--hlfy6xhsokwlj4k7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmD+mdAACgkQqclaivrt
76nnsgf/ZE83lKlN0I6nup+CaL8zm3H3EsNqaRng2V8bmPh3CWJEnYaUI324zAsa
VIFyO68kMXjyOCPNnFOlCVnBAMVqQgqeWzkSj50GUuRe5QbuMJUtVOVia8Fl9aYK
epTh0TOpdIMmEMlWpgoelS1HSTd5EBYMX2rSPtJsaqbCWcCnIgNIJTyRi5+p63Tn
ZDy3rYV8GvbMXLWKFHG9JGclgSUwVosvi1VXojo9C+HiWWQQt1YuuXPYXEvTPoBq
ItpvAocUJChFfuPZXo93jIk7q/fIT2UNGu0Ealm92qVJ3k9iuFHo4elcYR6fGb6w
SSgllcbmBG8DxlkFfFsRHjRVsnlNQw==
=Cbrd
-----END PGP SIGNATURE-----

--hlfy6xhsokwlj4k7--
