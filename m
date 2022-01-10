Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBC548933C
	for <lists+linux-can@lfdr.de>; Mon, 10 Jan 2022 09:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbiAJI0f (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Jan 2022 03:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240428AbiAJI0Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Jan 2022 03:26:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5606C061748
        for <linux-can@vger.kernel.org>; Mon, 10 Jan 2022 00:26:23 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n6q0T-0003ca-8Z; Mon, 10 Jan 2022 09:26:21 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-b9a5-4515-13c5-d2a3.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:b9a5:4515:13c5:d2a3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B17176D452B;
        Mon, 10 Jan 2022 08:26:19 +0000 (UTC)
Date:   Mon, 10 Jan 2022 09:26:18 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: softing: softing_startstop(): fix set but not used
 variable warning
Message-ID: <20220110082618.4jhkcwe3b7cm26ko@pengutronix.de>
References: <20220109103126.1872833-1-mkl@pengutronix.de>
 <YdstmL4KSn70ziqx@x1.vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hunkm6lx54al67zs"
Content-Disposition: inline
In-Reply-To: <YdstmL4KSn70ziqx@x1.vandijck-laurijssen.be>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--hunkm6lx54al67zs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.01.2022 19:46:48, Kurt Van Dijck wrote:
> Acked-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
>=20
> > out. Its stated that the functionality is not finally verified.
>=20
> The subsequent call works, but I wasn't able to produce the bus errors,
> so I could not verify that is actually worked.
>=20
> And by now, I don't have access to the card, nor do I have a PCMCIA slot =
:-)

I think Oliver still has a laptop with a PCMCIA slot, but I don't know
if he has that HW....

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--hunkm6lx54al67zs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHb7agACgkQqclaivrt
76knsgf+OLsuJuGuVm/RKiEebzRKBkqz4iyDx6qMoR71SH+vGBrK6HfZluoat+ru
YblJTKMPQGeWWXqrOAXJHQuOxsRIYhmKouinBIdax/HovJbr9aT91NxTOpIUDnZl
HKH/QjgUJNvPu4YIZ6VmG6B2d9y83OzxX26HAZlNjLPJdKhXYrn9PjGT8qMKbIkS
6oLTT3PWVsszj6H1dP+6jX6ifd7+zKqDgPRBsIN5evODRgETEp/qW1dDFIxBJSxc
jP9ZnpdJohtuF8VVKKYJ90Qb4JLfwkrQ174VNJfetxXUMTh2M6g92GEdWnbHtpob
bhcWJNBNKQveQDt1dbqm/HfMUW/Atg==
=33w2
-----END PGP SIGNATURE-----

--hunkm6lx54al67zs--
