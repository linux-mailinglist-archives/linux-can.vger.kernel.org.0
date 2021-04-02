Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580C6352FBE
	for <lists+linux-can@lfdr.de>; Fri,  2 Apr 2021 21:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbhDBT2E (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Apr 2021 15:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbhDBT2D (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Apr 2021 15:28:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA5FC0613E6
        for <linux-can@vger.kernel.org>; Fri,  2 Apr 2021 12:28:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lSPSa-0008Kx-TG; Fri, 02 Apr 2021 21:28:00 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:59d7:5e21:b5c4:e370])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 281A7606C32;
        Fri,  2 Apr 2021 19:28:00 +0000 (UTC)
Date:   Fri, 2 Apr 2021 21:27:59 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Belisko Marek <marek.belisko@gmail.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: m_can error/overrun frames on high speed
Message-ID: <20210402192759.up2tperefmwyt3r2@pengutronix.de>
References: <CAAfyv37vMxhN2B1uR5xUzZwVzAqrQOyPA6stWYj_5346xO0s3A@mail.gmail.com>
 <20210331083744.pui7rtjexvejjvf6@pengutronix.de>
 <CAAfyv35tCPxf0KSOk3=mcq6j2yB0DLUrN3AJ6sJtreZmTYZdGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iuen6oo4ixbxclad"
Content-Disposition: inline
In-Reply-To: <CAAfyv35tCPxf0KSOk3=mcq6j2yB0DLUrN3AJ6sJtreZmTYZdGQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--iuen6oo4ixbxclad
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.04.2021 11:04:25, Belisko Marek wrote:
> Is there anything I can tune to have it read faster? Thanks.

Indeed, with current net-next/master, you put the NAPI on a per
networking device from softirq to threaded mode.

| echo 1 | sudo tee /sys/class/net/can0/threaded

Then you a separate NAPI thread per networking device that can be tuned
with chrt, etc...

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--iuen6oo4ixbxclad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBncDwACgkQqclaivrt
76mangf/Qgj9Kqkc3sFj0Jd6eMLz3V5Qd29rC3y0euzY+Ahj12nIu2d192DsAC6H
Eeh8Lg/25kzrecGn55U3zYqyhDGZbxutIHEjYxTAZzkCrkKz2o4jsX/97q6dCaCi
11tz8y9Jf1sTCfNHIehsuiwHvfendXzQ9Q0CxpwqpoceR3llR2Fb9f4tTRQeZr+4
rMtW9qCV7kUF2l2qp+xXj/TPBVmoau/lJe1LEBAGho6xdWy61lote5kszus91AjJ
V/t4qwijaM4gzwwu6XB/JxblFZ9iqbWto4P+uJqdFXb4M80bIl+Pe+XmnbQbbR06
ELJ/z+DhkSVdjxiuLvKWutBPNoli2w==
=vouo
-----END PGP SIGNATURE-----

--iuen6oo4ixbxclad--
