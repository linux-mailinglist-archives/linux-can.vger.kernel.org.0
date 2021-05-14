Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA1C380B8E
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 16:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhENOSt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 10:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhENOSO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 10:18:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7949CC061346
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 07:16:06 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lhYbl-0000tp-3W; Fri, 14 May 2021 16:16:05 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:ab9e:cb46:9dda:16ff])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 48E24624427;
        Fri, 14 May 2021 14:16:04 +0000 (UTC)
Date:   Fri, 14 May 2021 16:16:03 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 1/3] can: m_can: add handle_dev_interrupts
 callback to m_can_ops
Message-ID: <20210514141603.zv7zzxgv23ardzo3@pengutronix.de>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
 <20210514121946.2344901-2-torin@maxiluxsystems.com>
 <20210514122610.q7mhf3frapxig5xg@pengutronix.de>
 <20210514132159.ohq5wtekdjea64yy@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qywtrln77nnyxovo"
Content-Disposition: inline
In-Reply-To: <20210514132159.ohq5wtekdjea64yy@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--qywtrln77nnyxovo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.05.2021 14:21:59, Torin Cooper-Bennun wrote:
> On Fri, May 14, 2021 at 02:26:10PM +0200, Marc Kleine-Budde wrote:
> > On 14.05.2021 13:19:44, Torin Cooper-Bennun wrote:
> > > This callback will allow M_CAN-based devices, e.g. TI TCAN4550, to
> > > handle device-specific interrupts which are not part of the M_CAN cor=
e,
> > > but are signaled on the same interrupt pin.
> > >=20
> > > Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
> >=20
> > Another option would be to register a 2nd threaded interrupt handler in
> > the tcan4x5x driver....But this is much simpler.
>=20
> Total separation of the two does make some sense. Events arising from
> the device-specific interrupt handling would be things like
> under-/over-voltage faults, CAN stuck dominant, SPI malfunction, etc...
> things that M_CAN shouldn't have to care about at all.

Technically you could register a 2nd interrupt handler, which is totally
independent of the main one. But there are no callbacks for open() and
stop() into the tcan4x5x driver to request and free the interrupt
handler. So having a single callback is the way to go here.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--qywtrln77nnyxovo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCehiEACgkQqclaivrt
76lvtgf/e+JEPsyLdkZwHtDF8TvDwHlAfrbtaARGS8/ooY0PXLoHztdp8dVUf0fK
T06OjRUbwJ0CKKNgX42zv9XdP9XfEjPxb+7vtUEUZM8av7v0hGbkNf6qBjnO4IfY
1PaHaDzF2NaqVHdYtWUrXpD4UzyU6c7oyS3ru1rh71S5oc61fKnff+kREWi8eGFZ
lFgLXFww/eoYCOcwHaCBGdOPzLmulYJ3vG8qZ+Y0kI083PIB/7jUS4RdW/sFD1q5
b34ep0TJtDY18g9fKoadRAIQO4pPea0ku0ZbjODvYW0ZaSbePPkZHPOT073eMZk7
WWtlLufk/KoRtSQ/G10r/KAE9RAr2A==
=JuZW
-----END PGP SIGNATURE-----

--qywtrln77nnyxovo--
