Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2F566984A
	for <lists+linux-can@lfdr.de>; Fri, 13 Jan 2023 14:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241877AbjAMNTt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 13 Jan 2023 08:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjAMNTW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2023 08:19:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083205D698
        for <linux-can@vger.kernel.org>; Fri, 13 Jan 2023 05:08:47 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pGJnZ-0003ZM-Hk; Fri, 13 Jan 2023 14:08:45 +0100
Received: from pengutronix.de (hardanger-4.fritz.box [IPv6:2a03:f580:87bc:d400:b2c0:1450:f38b:4cbb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 76968156859;
        Fri, 13 Jan 2023 13:08:44 +0000 (UTC)
Date:   Fri, 13 Jan 2023 14:08:44 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: Re: AW: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Message-ID: <20230113130844.spbdtq2kumcjn42k@pengutronix.de>
References: <20230111222042.1139027-1-mkl@pengutronix.de>
 <20230111223004.w7z4ghdahe7jvebe@pengutronix.de>
 <20230112075452.4v3ba2hibxx3i5rm@pengutronix.de>
 <FR0P281MB1966D75DB56E45D225313B5697C29@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nvkkrxt7ugbnbqso"
Content-Disposition: inline
In-Reply-To: <FR0P281MB1966D75DB56E45D225313B5697C29@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
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


--nvkkrxt7ugbnbqso
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.01.2023 12:39:58, Stefan Alth=C3=B6fer wrote:
> > In my over night test the workaround triggered 31 times. The test
> > has found no problems.
>=20
> This is frustrating: how did you manage to get that much triggers ;-)

I don't know. In an older version of the workaround it triggered about
every 12 Minutes.

> I ran 4 targets in parallel and got 3 fifo errors in total after 20 h
> and no test failures.

At least the workaround triggered and the test didn't fail! \o/

> I will now switch my setup from doing the selft-receiption test to a
> two-node-same-host transmission test which is where I first detected
> the error.

Makes sense. If you're happy please reply to the patches with a
"Tested-by: Stefan Alth=C3=B6fer <Stefan.Althoefer@janztec.com>" tag.

> BTW: "... (applies) against current net/main" - is this kh-lingo for
> using this: git clone
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/ ?

Yes - it means that I applied the patches to the main branch of that
tree. On older kernels it might not apply without problems.

But you don't have to clone the tree, you better add it as a remote to
your existing tree, e.g.:

| git remote add -f net git://git.kernel.org/pub/scm/linux/kernel/git/netde=
v/net.git

=2E..and then check it out:

| git checkout -b my-net-main net/main

> Oh and I "backported" the patched driver source into my 6.0.12
> raspbian kernel.

I think the patches apply without problems, there we not many changes
since v6.0.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--nvkkrxt7ugbnbqso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPBV9kACgkQrX5LkNig
013Kzwf/c7BCaEtOOQ9OjHB4qn3EZVIVQqNn1ZEM3UN0mqJFTZJvK3N64s79FTgy
gk8pGMz4bEpmh5+hIUQT2PcbapwEfJtfLiPWm/hCqRzcoPyNyclnunFLUa7yTO8A
4Ua3UxgI4S/iFUf4D15d8MDCpwx5AuE0fZfW1cRKxCRA3EkUESYnmxoZm28qw4cZ
tdFcDjxNSdly6TjegWeLvMRZuhkZiezv9/FTJ/g2r/Ansjq8OP3Sh/ONcq5nq7jz
92ealAYW1dh88BG+EcGKubZKLKJ10MpA/zyMJNHfBj4cnp4prjuKClolwUUmjM/r
tW2YlgxkKTyP1YzEZdjC5e/5ruJJ/g==
=9PfJ
-----END PGP SIGNATURE-----

--nvkkrxt7ugbnbqso--
