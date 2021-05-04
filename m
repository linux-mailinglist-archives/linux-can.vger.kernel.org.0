Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB803729BB
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 13:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhEDLzb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 07:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhEDLzb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 07:55:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90C3C061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 04:54:36 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ldtdL-0000kt-EL; Tue, 04 May 2021 13:54:35 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4880:7cee:6dec:c8f9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 91BC361BBFA;
        Tue,  4 May 2021 11:54:34 +0000 (UTC)
Date:   Tue, 4 May 2021 13:54:33 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [REPOST PATCH 0/4] can: m_can: various regmask-related cleanup
Message-ID: <20210504115433.nz3q4fbr62hecnmj@pengutronix.de>
References: <20210504114900.351170-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ybwu6o6uishr4eg6"
Content-Disposition: inline
In-Reply-To: <20210504114900.351170-1-torin@maxiluxsystems.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ybwu6o6uishr4eg6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.05.2021 12:48:56, Torin Cooper-Bennun wrote:
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

What's the base commit for this series?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ybwu6o6uishr4eg6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCRNfYACgkQqclaivrt
76m/kwf/Sl7Iuhw3r3zlNzrW7ly/86Fu1YXbMeVuMdVvznRH4ZP7tr0MADRPIf0x
XQwtXl2XNIVc5oJVuxrmEIQCJnHYOniHVBf8PeXFvHxuzZEIJA2jZKnYqQIF6Hkg
WjUVLN6GGBd+b5bKahvQxDjRbAaTjf2bTVJj7d54Q03QN899/f+fZouSvQM8SLfo
rdt9OzbCr4cXhoETISXkXn64F3LIHnPVnTTxGzikQAFFbE3VnWxhX3yRdRiJuv3f
nTK4tw6PkZUVD5kMD432i+qM6Skxj+S44GzJFYEVGymLrmFtDhXVIQYi2cM+grJi
zGHdbaxOzpU8U/oFZqVUInIUJxPklw==
=fDJp
-----END PGP SIGNATURE-----

--ybwu6o6uishr4eg6--
