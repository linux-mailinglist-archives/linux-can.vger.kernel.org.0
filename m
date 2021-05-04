Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAD2372A79
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 14:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhEDM4z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 08:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhEDM4z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 08:56:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C028C061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 05:56:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ldual-0007IU-0z; Tue, 04 May 2021 14:55:59 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4880:7cee:6dec:c8f9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EAF8061BCB1;
        Tue,  4 May 2021 12:55:57 +0000 (UTC)
Date:   Tue, 4 May 2021 14:55:57 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v2 0/4] can: m_can: various regmask-related cleanup
Message-ID: <20210504125557.lwss6dn3tqmsfs6p@pengutronix.de>
References: <20210504125123.500553-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zy3e46nffylizx4r"
Content-Disposition: inline
In-Reply-To: <20210504125123.500553-1-torin@maxiluxsystems.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--zy3e46nffylizx4r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.05.2021 13:51:19, Torin Cooper-Bennun wrote:
> Hi all!
>=20
> 1/4 modernises m_can.c, using GENMASK for all regmasks and
> FIELD_{GET,PREP,MAX} for ops. Maintainable, consistent and concise.
>=20
> 2/4 makes clear all the differences in CCCR between M_CAN spec
> revisions,
> and orders the defs by revision, ascending.
>=20
> 3/4 makes explicit the config of RX & TX buffer sizes, making it a bit
> more readable, especially against the spec.
>=20
> 4/4 fixes whitespace in a few comments.

Applied to linux-can-next/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--zy3e46nffylizx4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCRRFoACgkQqclaivrt
76l6Vgf/X6tOfyx6AmCYCe9zkBEvDpxK8EaIqLHyyGGQBE0uOd+eywOMw+tw/REV
T7uhq5Sm6E54qD7FLZZLO5ONCTNR6sQFvVke4bjGLkuXkQ92v1EcKSIZxnJMPhtS
Xlp0mR4YEvP5lslyoA/AVwBV8Ra9iYEGOJuayOnM2i5ACjgJc1BBh5UrcYE1ACut
Cuv+Wj160M+/QJ5N4B0TBDdIKF77qsOX/br+myyhGm/JJpaPRAExpbc8Q//Jvo93
BG6NNlaMngSPIcQPJD+DgGA9X5auUgIu1ZGi7g5iGnANWU1r3KZBnWiqVhscXoRC
Miqa465/qwnNSdymnJ39coJ94bIUjw==
=VCxu
-----END PGP SIGNATURE-----

--zy3e46nffylizx4r--
