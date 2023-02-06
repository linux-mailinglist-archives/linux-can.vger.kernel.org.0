Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF57868C6FF
	for <lists+linux-can@lfdr.de>; Mon,  6 Feb 2023 20:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBFTqO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 6 Feb 2023 14:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFTqL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 Feb 2023 14:46:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733C417CDD
        for <linux-can@vger.kernel.org>; Mon,  6 Feb 2023 11:46:09 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pP7RH-0006Ij-Qq; Mon, 06 Feb 2023 20:46:07 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1f19:3f00:c06a:b19c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 45225171C66;
        Mon,  6 Feb 2023 19:46:07 +0000 (UTC)
Date:   Mon, 6 Feb 2023 20:45:59 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: proc: properly format table
Message-ID: <20230206194559.lv5ana7slnw2u2st@pengutronix.de>
References: <20230206194305.2827376-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tt6joxhvgsxudtj6"
Content-Disposition: inline
In-Reply-To: <20230206194305.2827376-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--tt6joxhvgsxudtj6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.02.2023 20:43:05, Marc Kleine-Budde wrote:
> The table "/proc/net/can/rcvlist_all" is garbled if the interface
> names are longer than 5 characters.
>=20
> Consider IFNAMSIZ when formatting the table so that it looks like
> this:
>=20
> | receive list 'rx_all':
> |   device              can_id   can_mask  function  userdata   matches  =
ident
> |    any                   000   00000000  8e807747  9bc49fd8         0  =
raw
> |   device              can_id   can_mask  function  userdata   matches  =
ident
> |    mcp251xfd0            000   00000000  8e807747  ec6d80a2
> |   0  raw
      ^^^^^^
Doh! That's my fault, the proc output is OK. fixed.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--tt6joxhvgsxudtj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmPhWPQACgkQvlAcSiqK
BOj3jgf+PwU1x1Ux9x7i3SL79Y4H3X0ccj9ohnv97BHlZSDTz70pxBb4CiRxrOn9
FIgmkRDuXZt52dnmKsZK8AETIAUuaOh3CcbHxQdC6NM58U54b/I71Oo7/vBm5Vh3
X3uAewTOuyAxGZcBgJNWtx/qv/cSg3iKwlpdnQMhPXW1J4rEOrOSsC1HavENpFy/
QQoARNiE0hYwTzBJC8KAgjkde6fs29fFuK3FfjoMmUu6GSHwEPo/YNMb2HqA5eTo
IRuXniTG72Jd50xQIffvStZkgqtC3QWWvNexXktqEq9hLkGMYpR9TA7Ae2/S4Ru4
rghtvy/MQtGpN5pFopkmhzdux/KFsg==
=ta6g
-----END PGP SIGNATURE-----

--tt6joxhvgsxudtj6--
