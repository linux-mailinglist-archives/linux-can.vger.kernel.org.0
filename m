Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614E73DFC73
	for <lists+linux-can@lfdr.de>; Wed,  4 Aug 2021 10:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbhHDIHq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Aug 2021 04:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbhHDIHp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Aug 2021 04:07:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E9CC0613D5
        for <linux-can@vger.kernel.org>; Wed,  4 Aug 2021 01:07:33 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mBBw3-0003DM-1O; Wed, 04 Aug 2021 10:07:31 +0200
Received: from pengutronix.de (unknown [IPv6:2a02:810a:8940:aa0:e44:2d7c:bf4a:7b36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C98136605F9;
        Wed,  4 Aug 2021 08:07:28 +0000 (UTC)
Date:   Wed, 4 Aug 2021 10:07:27 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Yasushi SHOJI <yashi@spacecubics.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: fix Microchip CAN BUS Analyzer Tool entry
 typo
Message-ID: <20210804080727.hxirlt6emx6ghv7i@pengutronix.de>
References: <cc4831cb1c8759c15fb32c21fd326e831183733d.1627876781.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pk6h55hu5etvv2y3"
Content-Disposition: inline
In-Reply-To: <cc4831cb1c8759c15fb32c21fd326e831183733d.1627876781.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--pk6h55hu5etvv2y3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.08.2021 06:59:41, Baruch Siach wrote:
> Fixes: 8a7b46fa7902 ("MAINTAINERS: add Yasushi SHOJI as reviewer for the =
Microchip CAN BUS Analyzer Tool driver")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Applied to linux-can/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--pk6h55hu5etvv2y3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmEKSrwACgkQqclaivrt
76lPuAf/TlHUKMGQbTPgsAXokXORi+fDWavpJ575VKT0x3DBYZ1qnZOftQmVWWwF
wWZ8TdFlUwlFBcYUmDgyjQPCpuSi0Xr8Gilm51X+L+Hgj+EaVBPE5rWJ9K3+x1WP
zDndtNqWe4t6t+ylPGznnsMGHpTTDWLcaz52+CiHd8t9K2jC6hzLzb91qzLbzM8K
Kg4YnSE5sW/bXayZ8IHwcRH9cm7YYor/c1fJQcQlzkw+x7AA94akL6Jw+hIaCMI2
gQIJgK1fyGlSFOO+as1iLNwX4MAWyIPJBKmZjNrJ5gMt6ubeGRexZEIuj24v3aOV
uKiPtdFsx6qGXJN1WGdRGGvnPMM4rQ==
=GKXH
-----END PGP SIGNATURE-----

--pk6h55hu5etvv2y3--
