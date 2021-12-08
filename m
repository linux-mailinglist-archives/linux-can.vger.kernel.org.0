Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB2546D35A
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 13:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhLHMfJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 07:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbhLHMfI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 07:35:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86EEC061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 04:31:36 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1muw6g-0000rp-Od; Wed, 08 Dec 2021 13:31:34 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-e45e-c028-b01c-c307.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:e45e:c028:b01c:c307])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 745896BFB9B;
        Wed,  8 Dec 2021 12:31:33 +0000 (UTC)
Date:   Wed, 8 Dec 2021 13:31:32 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: Re: [PATCH v3 1/4] can: kvaser_pciefd: Increase correct
 stats->{rx,tx}_errors counter
Message-ID: <20211208123132.5ft747z35dcwrrq2@pengutronix.de>
References: <20211208115607.202859-1-extja@kvaser.com>
 <20211208115607.202859-2-extja@kvaser.com>
 <20211208122606.v6c2hlb4zlicpuhd@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibusp5nktxqmkfzj"
Content-Disposition: inline
In-Reply-To: <20211208122606.v6c2hlb4zlicpuhd@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ibusp5nktxqmkfzj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.12.2021 13:26:06, Marc Kleine-Budde wrote:
> On 08.12.2021 12:56:04, Jimmy Assarsson wrote:
> > Check the direction bit in the error frame packet (EPACK) to determine
> > which net_device_stats {rx,tx}_errors counter to increase.
> >=20
> > Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
>=20
> Is this a fix that should be applied to the stable kernels? If so, which
> commit is fixed by this?

To me it looks like the problematic code has been in the mainline kernel
since it was added. So I'll add a

| Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan d=
evices")

tag, add stable on Cc and upstream this via net/master. Ok?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ibusp5nktxqmkfzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGwpaIACgkQqclaivrt
76mjhwf/TFBMmSQSyNYKTCKDJiNK2ijFUDSqljkd1OO6vtPMM2ugSgk1XCBmwWR5
rqbMa0+A3RRtwFJ19TpPjlY7HWiUd4eTUWPjHSHkM7L+JYCdrWfG0LO6d2SufJq+
ldykxX+FGlIQva6nKw/26YGZwe9cNTi+o04AlPsykUyKouWQ/B6HDmkgI0auD7GG
60WrFfolODDfCm82jClNWXLKuUx1KiE138L2bHnZJX4uy7B7VtzSKFXikPjEIQ7r
enQoeQtsU0vTwT+QT+BsmATIUya6Sb5LAxjTlL2wuXXiN97bDVn99HQS30jUqUOh
NaeGtUsskNk7wv45MfC+tPdc3wjs+w==
=UlYh
-----END PGP SIGNATURE-----

--ibusp5nktxqmkfzj--
