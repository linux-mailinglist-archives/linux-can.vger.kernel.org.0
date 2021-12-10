Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC0146FB9B
	for <lists+linux-can@lfdr.de>; Fri, 10 Dec 2021 08:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhLJHjc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 Dec 2021 02:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhLJHjc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Dec 2021 02:39:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCF4C061746
        for <linux-can@vger.kernel.org>; Thu,  9 Dec 2021 23:35:57 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mvaRZ-0002AJ-Nw; Fri, 10 Dec 2021 08:35:49 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-5708-5a2a-1200-a3e0.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:5708:5a2a:1200:a3e0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0E13F6C1172;
        Fri, 10 Dec 2021 07:35:46 +0000 (UTC)
Date:   Fri, 10 Dec 2021 08:35:45 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Jimmy Assarsson <extja@kvaser.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Yasushi SHOJI <yashi@spacecubics.com>
Subject: Re: [PATCH v5 3/5] can: do not copy the payload of RTR frames
Message-ID: <20211210073545.qdldwmaykts5dr4u@pengutronix.de>
References: <20211207121531.42941-1-mailhol.vincent@wanadoo.fr>
 <20211207121531.42941-4-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgu4n4z4axtjgfbb"
Content-Disposition: inline
In-Reply-To: <20211207121531.42941-4-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--xgu4n4z4axtjgfbb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.12.2021 21:15:29, Vincent Mailhol wrote:
> The actual payload length of the CAN Remote Transmission Request (RTR)
> frames is always 0, i.e. nothing is transmitted on the wire. However,
                           ^^^^^^^
I've changed this to "no payload" to make it more unambiguous.

> those RTR frames still use the DLC to indicate the length of the
> requested frame.
>=20
> For this reason, it is incorrect to copy the payload of RTR frames
> (the payload buffer would only contain garbage data). This patch
> encapsulates the payload copy in a check toward the RTR flag.
>=20
> CC: Yasushi SHOJI <yashi@spacecubics.com>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xgu4n4z4axtjgfbb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGzA08ACgkQqclaivrt
76k0wgf/Tt5RLv/yuQOh0Bg1Eim3GqTp91tjekXp/Kx65epni6ViEkdY6/B3bhN2
8cprQ2aeC7npSQVSGr4AU8OhoX1dAn7Z986ThJOOl0v0JtuFjniNHoXK9FNjKWNJ
NlpH7wYE3vv5jy9Yy3mSbQPP3Bp539dRfq5puTgFygv3yp2RzRVL0pX8/FK1dal8
Ziq98LUACZF6Tc+uqIfaj9p2CJq94xQBHrmoOtpN7722ODt9JQjqGB8Bk1Dwe8l7
XVWWbTrsWkt0SNniKIQAdo4UsigGQ6Ba3+MhEBraR0uZU7Qt6gNCXIYYR9dd7Iu8
spshptUSQ0EvOSdsXO6MBy0KhT5p5w==
=Niul
-----END PGP SIGNATURE-----

--xgu4n4z4axtjgfbb--
