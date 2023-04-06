Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80536D950C
	for <lists+linux-can@lfdr.de>; Thu,  6 Apr 2023 13:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbjDFL0Y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Apr 2023 07:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbjDFL0X (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Apr 2023 07:26:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A3286AB
        for <linux-can@vger.kernel.org>; Thu,  6 Apr 2023 04:26:18 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pkNku-0008Ql-Rh; Thu, 06 Apr 2023 13:26:16 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C20981A8372;
        Thu,  6 Apr 2023 11:26:15 +0000 (UTC)
Date:   Thu, 6 Apr 2023 13:26:14 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH] can: allow MSG_CMSG_COMPAT flag in recvmsg() syscalls
Message-ID: <20230406-scant-daisy-fd50d17b0250@pengutronix.de>
References: <20230406110845.5180-1-socketcan@hartkopp.net>
 <dbf2020b-98bc-9ca2-ed54-8f86bdb99ee8@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4y6zppoxorco3jss"
Content-Disposition: inline
In-Reply-To: <dbf2020b-98bc-9ca2-ed54-8f86bdb99ee8@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--4y6zppoxorco3jss
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.04.2023 13:25:11, Oliver Hartkopp wrote:
> I should probably split this into two patches when thinking of stable
> kernels.

+1

> E.g. we have to handle two "Fixes:" tags here:
>=20
> Fixes: 42bf50a1795a ("can: isotp: support MSG_TRUNC flag when reading from
> socket")
>=20
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
>=20
> @Oleksij: Can you please check if adding this flag is fine for you too - =
and
> if you can "ack" it?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4y6zppoxorco3jss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQurFQACgkQvlAcSiqK
BOj8kgf8CIv0CWzhTd+08u/JJuxIiRVkvG2C8FQka1DmnO3/nGHjM+Syyax2JtM4
WyiRUm6CJnoBUIKYqAvnvKqo225wWvb1B9pC8TFAT6ets1iuNf1/JUVGlqOJSFfp
jEEOJay2zAAFR71jYJi0riIvArgYpGCMHSEIphzWEAjFJ+4prmW9ZqejfVw2MfCN
Bg/W5juokGZGMjtJf6zL0YLPVtfoFOXb4Ayxco29jvmVJ6tn8xVsn//i1nFVGhbf
T0EFHs691tHSOE1eqGMgSdxSScv4IWPZ9GX09TuImfZI+1pnBBhxiZstF3EJ5tn9
hgCmT8Z/tjf6je9Q7u52rlTWJxyBFg==
=Mldo
-----END PGP SIGNATURE-----

--4y6zppoxorco3jss--
