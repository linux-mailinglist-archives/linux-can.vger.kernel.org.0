Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABB8626F5F
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 13:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbiKMMF7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 07:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiKMMF7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 07:05:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5730064EC
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 04:05:57 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ouBkJ-00041n-O0; Sun, 13 Nov 2022 13:05:55 +0100
Received: from pengutronix.de (hardanger-2.fritz.box [IPv6:2a03:f580:87bc:d400:6d7d:dd1c:b670:c511])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2690711BD7E;
        Sun, 13 Nov 2022 12:05:55 +0000 (UTC)
Date:   Sun, 13 Nov 2022 13:05:54 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils-dev 0/5] can-utils-dev: a set of cleanup patches
Message-ID: <20221113120554.fhwt7kzw25j3pegj@pengutronix.de>
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a7hpu4giu5nns3x5"
Content-Disposition: inline
In-Reply-To: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
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


--a7hpu4giu5nns3x5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.11.2022 17:53:16, Vincent Mailhol wrote:
> This series contain five cleanup patches. There is no real relation
> between each patch so I will end the cover letter here and let you
> refer to the short description.

See my comment on patch 2, the rest looks good.

Marc

P.S.: You can either send a PR on github, or a v2 via mail here.

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--a7hpu4giu5nns3x5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNw3Z4ACgkQrX5LkNig
011QBwf/X7p6Jc/q2BO0hQ+D6QqzaRJ2958FE9XJ6MUWv86fz7xZVvPFsOSeJ9vd
2mY5oy5GZeQrarZduLLDqx1juj9VVogWWIq0qT5MJMPaCTd9dD1B0CZVUjWemMIW
rvS5l6hL8+W9+nV0r41fyGU7OS5ZzCmUjp1rgi1BbdWxPmyN1e2Z6N1hUwhpG9Mf
m6nPhdfYgLg0k9Vjx7Ij/da6EojbeCrQLNJiIoXEgBhe4tb3c3WfCPuBqEiL+4oC
TFc+CYplirpvL9YxA60q2v0Wguyc4Ousu8s+A8PQznEYS/ZRzXLDs9BRGSfwJWPn
DmTKJskxm2s2nntiAKpIcBReUS1kNA==
=B5E1
-----END PGP SIGNATURE-----

--a7hpu4giu5nns3x5--
