Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0783B9E42
	for <lists+linux-can@lfdr.de>; Fri,  2 Jul 2021 11:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGBJdr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Jul 2021 05:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhGBJdr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Jul 2021 05:33:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06910C061762
        for <linux-can@vger.kernel.org>; Fri,  2 Jul 2021 02:31:14 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lzFVw-0008LX-Jx; Fri, 02 Jul 2021 11:31:12 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:fe13:c2b2:7939:752b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3FBC2647789;
        Fri,  2 Jul 2021 09:31:11 +0000 (UTC)
Date:   Fri, 2 Jul 2021 11:31:10 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Joshua Quesenberry <engnfrc@gmail.com>
Cc:     'Patrick Menschel' <menschel.p@posteo.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org
Subject: Re: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y
Message-ID: <20210702093110.vzfjk4dgovrrs4mj@pengutronix.de>
References: <016701d7678c$2b3d50c0$81b7f240$@gmail.com>
 <20210622212818.enfx5fzgghfxfznb@pengutronix.de>
 <CAMGHUonufNF7CgAzcPkhgykxdYBtA+r5nY2i5xRGXN7Nxd5yMQ@mail.gmail.com>
 <2a99d742-b2dc-4411-acbb-2e23ce7cd132@posteo.de>
 <029101d76855$fa5ac300$ef104900$@gmail.com>
 <20210625065626.b7afwhptoyoxoblx@pengutronix.de>
 <20210625121648.hg4hihfmddss7ptu@pengutronix.de>
 <020f01d769da$9fac86b0$df059410$@gmail.com>
 <022d01d769e2$e623cbf0$b26b63d0$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyh3dmz53hfuo6uv"
Content-Disposition: inline
In-Reply-To: <022d01d769e2$e623cbf0$b26b63d0$@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--oyh3dmz53hfuo6uv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.06.2021 12:55:26, Joshua Quesenberry wrote:
> Forgive me, I forgot can0 =3D spi0.1 and can1 =3D spi0.0 right now because
> I killed my UDEV rule so I was tapped onto the wrong CS line. Attached
> is a snapshot of what I'm seeing AND an export of the data from Saleae
> which may prove more useful than snapshots.

Pulseview cannot parse the csv file correctly (see [1]). Can you save it
in a different format?

Marc

[1] https://www.mail-archive.com/sigrok-devel@lists.sourceforge.net/msg0375=
1.html


--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--oyh3dmz53hfuo6uv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDe3NwACgkQqclaivrt
76klnggArxsAxGLGSod5EIA4KPknwySWKroGk7wr8pQ1bPq6kMCzFkdm6PHOAZiw
YktTgXBfz9L0B9s9t66WJ5qyle3F5n1/gAtK220WnZw9HGjZYcN9EhEHI5Y85YRO
epaVR7lbeFe9alVNIPcuSKk0MSBH6oQipIpUImybkrIuAa76idqesnOtY4ua6swB
dzEcheCK9M6eKFmXvg62EXdMMvs7QwSUy9fsrQdByj3wt8+g94CjhvXYQcQDg5+i
ash0oaJxd6cUkqqBgJ/DkB++mMT7eM9qqLztqPJimzBMmpm05dATVhWZVY/ycf4S
0rhzN7p2iRxSwmGt6Ii+mjcUKi9UEA==
=60wl
-----END PGP SIGNATURE-----

--oyh3dmz53hfuo6uv--
