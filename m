Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9168B381A94
	for <lists+linux-can@lfdr.de>; Sat, 15 May 2021 20:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhEOSmk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 15 May 2021 14:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhEOSmj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 15 May 2021 14:42:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878D3C061573
        for <linux-can@vger.kernel.org>; Sat, 15 May 2021 11:41:25 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lhzDx-0008MD-7w; Sat, 15 May 2021 20:41:17 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:bbeb:8461:90d8:87f0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3AD1B624D13;
        Sat, 15 May 2021 18:41:15 +0000 (UTC)
Date:   Sat, 15 May 2021 20:41:14 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Patrick Menschel <menschel.p@posteo.de>
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: J1939 Questions on Intended usage
Message-ID: <20210515184114.4bfg3e4u5i32tk5s@pengutronix.de>
References: <f0d77797-c485-2f88-57e3-b5c7b4953706@posteo.de>
 <20210515122611.GC2387@x1.vandijck-laurijssen.be>
 <38c85980-a569-b714-2643-9623b3dbc973@posteo.de>
 <72aa8b79-5ba9-26ee-3918-09532e0f1eae@posteo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ajjk5be3unr2oxtp"
Content-Disposition: inline
In-Reply-To: <72aa8b79-5ba9-26ee-3918-09532e0f1eae@posteo.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ajjk5be3unr2oxtp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.05.2021 18:10:20, Patrick Menschel wrote:
> The only thing that I didn't get to work is send to broadcast.
> That PermissionError is somewhat strange.

Does this from Documentation/networking/j1939.rst help?

| By default no broadcast packets can be send or received. To enable sendin=
g or
| receiving broadcast packets use the socket option ``SO_BROADCAST``:

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ajjk5be3unr2oxtp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCgFcYACgkQqclaivrt
76lqLgf/XQS0kn+S7yCOiDJBopWVjCfhfEZ+2Z0KkYtPRYFJpNkJ/tUzfc39GMMA
kJMNol/iWWuVPh+EA3Yez37+YlzX6a8i78+3td/wIjetSAhWkMR9Kw5hnr5mEwWJ
tsaqWd8CGySXqInIk4LISgElABH4kppwfGpriE3vT0AUBFaIVUuykYnb3h5gCRIT
PiV2IReSIcthiqHhCvvob1PBXTnDOccLSpADKbTHpXR9a3M1I4lsYqmGGX6SsitG
6BF7FQcUSwlFPKBv2QXSHr+aNhIc7/a/uBg4WBBDFpvh/dAVWcqtI7RTuLkmzUDF
ZEin1zaHFJTkaVp814rhkcbCzSJWyw==
=THRh
-----END PGP SIGNATURE-----

--ajjk5be3unr2oxtp--
