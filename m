Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD9036D3D3
	for <lists+linux-can@lfdr.de>; Wed, 28 Apr 2021 10:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbhD1IVW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Apr 2021 04:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhD1IVW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Apr 2021 04:21:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05227C061574
        for <linux-can@vger.kernel.org>; Wed, 28 Apr 2021 01:20:38 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lbfQy-0000Dw-LN; Wed, 28 Apr 2021 10:20:36 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4048:54d7:3c62:4ce5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EB2DD61861A;
        Wed, 28 Apr 2021 08:20:35 +0000 (UTC)
Date:   Wed, 28 Apr 2021 10:20:35 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Belisko Marek <marek.belisko@gmail.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: m_can error/overrun frames on high speed
Message-ID: <20210428082035.vpeolugp3pbesk6x@pengutronix.de>
References: <CAAfyv37vMxhN2B1uR5xUzZwVzAqrQOyPA6stWYj_5346xO0s3A@mail.gmail.com>
 <20210331083744.pui7rtjexvejjvf6@pengutronix.de>
 <CAAfyv35tCPxf0KSOk3=mcq6j2yB0DLUrN3AJ6sJtreZmTYZdGQ@mail.gmail.com>
 <20210402192759.up2tperefmwyt3r2@pengutronix.de>
 <CAAfyv35ofuk-z4qByJp3y9JRuAYPu4WaUaBf_o9QyschPNOOUg@mail.gmail.com>
 <CAAfyv37Wkh0rrAeEDyO1No6t0dnm=dSayZLdMvP6nWXCz12vdg@mail.gmail.com>
 <CAAfyv35fksdrAp_=ptbXYNAdiPvyFJGy6k_iZiaNu+GaOWQZkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="os7oiuqp7s4qxegi"
Content-Disposition: inline
In-Reply-To: <CAAfyv35fksdrAp_=ptbXYNAdiPvyFJGy6k_iZiaNu+GaOWQZkA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--os7oiuqp7s4qxegi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.04.2021 10:18:05, Belisko Marek wrote:
> > > For rx-offload branch I was not able yet to run it on my platform
> > > (have panic during boot which I need to resolve first).
> > OK I resolved boot issues on my platform and tested using rx-offload
> > branch but again the issue is present.
> > It's enough to generate can frames using candeg can0 -g0 and I get
> > after some time error/overrun errors.
> > I'm trying now to bump rx-offload patches on top of linux-can-next
> > testing branch and test it.
> Was bit fast with response. With rx-offload feature receiving can
> frames with high speed (small gaps) is working fine as expected.

Great!

> So what are the next steps? I can port rx-offload for c_can to actual
> master and verify and post patches for review?

Yes, please go ahead!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--os7oiuqp7s4qxegi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCJGtAACgkQqclaivrt
76k4oQf/UJz1wjMUN6SHgzmaxZ0SK/+h+jvKYHsNnnzVdSB1tjdebbA9EpxD6Dxt
2dDHTZ+s4mbtUiDRWoWkzjwrEXbjIkrEu/2Pq9HdaxJI81GFhKnATMchsbqtIp4y
aZVzA6o915Gq+PeJoNjZf5LViXkV8dRxmAJEK2iBdGuGw2K0gg9sy1ES3zFGZ56O
q2a13hpefr83y/3FZlwxCVF9asS1IKWqrFHIQ3Zd4GlPeUbXKTcdDFIa3n8p+e8B
qh33n/GqYf5F3M85pGc6zW0fch+GxFPmmSjyIZfwz3WMOFw03Hl1u/Cw9pTyaAVY
Leqxu+2w8XadE4K4WWilDGk6pd/rxg==
=WmMT
-----END PGP SIGNATURE-----

--os7oiuqp7s4qxegi--
