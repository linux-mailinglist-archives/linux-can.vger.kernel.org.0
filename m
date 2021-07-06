Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BA23BC9FE
	for <lists+linux-can@lfdr.de>; Tue,  6 Jul 2021 12:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhGFKfO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Jul 2021 06:35:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34039 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhGFKfO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Jul 2021 06:35:14 -0400
X-Greylist: delayed 960 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jul 2021 06:35:13 EDT
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m0i5v-0002nR-JT; Tue, 06 Jul 2021 12:14:23 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1c71:3c9b:9ef8:2ba3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AE0E6649442;
        Tue,  6 Jul 2021 10:14:22 +0000 (UTC)
Date:   Tue, 6 Jul 2021 12:14:21 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v3 1/2] can: mcp251xfd: mcp251xfd_probe(): try to get
 crystal clock rate from property
Message-ID: <20210706101421.ukdgfo3eyoijblbu@pengutronix.de>
References: <20210531084444.1785397-1-mkl@pengutronix.de>
 <YLS15VESjAVZ2w6G@smile.fi.intel.com>
 <YOQsM4spPVfca4dE@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7k6kpa6fmeykslgo"
Content-Disposition: inline
In-Reply-To: <YOQsM4spPVfca4dE@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--7k6kpa6fmeykslgo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.07.2021 13:10:59, Andy Shevchenko wrote:
> On Mon, May 31, 2021 at 01:09:41PM +0300, Andy Shevchenko wrote:
> > On Mon, May 31, 2021 at 10:44:43AM +0200, Marc Kleine-Budde wrote:
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >=20
> > > In some configurations, mainly ACPI-based, the clock frequency of the
> > > device is supplied by very well established 'clock-frequency'
> > > property. Hence, try to get it from the property at last if no other
> > > providers are available.
>=20
> Is this series missed merge window?
> I never saw it in Linux Next and nor in vanilla...

Yes, I missed the merge window. Will send a pull request after -rc1
(when net-next is open again).

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--7k6kpa6fmeykslgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDkLPsACgkQqclaivrt
76lD/AgAnfVGthhXvNB4y6TgDgom0rjt/4+ocWSJ6EvuK0UV+Uy7C0kdm9grrLYW
S5eCZqojRPuK/cr49Ym4Mv/8H+KMzuy8d4hyx3e/quqC+LahlZ7K7NfKkEP6Kp8I
8CGfpYdTxqKP6MCIsni1/f3FRznvHZDcxmbx6HSmMiSxJVD4fpmxtxSbqY+V+vyM
u/xlAY3L7tGP8saYoGWyVPJQoh+TF1AqAk0KtSRU5RyRys2ijtozpBEey2nQ6NOB
HZeJHHljmWA9rPugW6dzYf8Vox8aarjSDQH9ADFD3JvWh/Tkwiv6vLiSOTNq9On3
yyuIRxn6YnKfTIjLiwkdSanXBK8C9Q==
=1gUF
-----END PGP SIGNATURE-----

--7k6kpa6fmeykslgo--
