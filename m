Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0237168E29C
	for <lists+linux-can@lfdr.de>; Tue,  7 Feb 2023 22:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBGVEf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Feb 2023 16:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBGVEe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Feb 2023 16:04:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42A7AE
        for <linux-can@vger.kernel.org>; Tue,  7 Feb 2023 13:04:33 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pPV8i-0004kv-4I; Tue, 07 Feb 2023 22:04:32 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1929:cbfc:e29:aaab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 087A5172CAD;
        Tue,  7 Feb 2023 21:04:31 +0000 (UTC)
Date:   Tue, 7 Feb 2023 22:04:22 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        hsweeten@visionengravers.com
Subject: Re: xlinix_can: bug when sending two RTR frames
Message-ID: <20230207210422.qk5jdhgpvbkgtlfb@pengutronix.de>
References: <94e3c5bc-6af9-f240-86fa-2b780a58533f@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pqmvve6pnyma2yrz"
Content-Disposition: inline
In-Reply-To: <94e3c5bc-6af9-f240-86fa-2b780a58533f@hartkopp.net>
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


--pqmvve6pnyma2yrz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.02.2023 21:45:20, Oliver Hartkopp wrote:
> Hi xilinx_can maintainers,
>=20
> Hartley Sweeten reported a bug when sending RTR frames with the xilinx_can
> driver here:
>=20
> https://github.com/linux-can/can-utils/issues/405#
>=20
> The problem: When sending a single RTR frame (e.g. with 'cansend can0
> 001#R') nothing happens.
>=20
> Only after sending a *second* RTR frame with 'cansend can0 001#R' the two
> (pending) RTR-frames are sent directly after each other.
>=20
> This faulty behavior of RTR frame sending is independent of the time gap
> between the two cansend attempts.

More info:

| Also, this is with a kernel/rootfs created using Petalinux 2020.2.
| Linux s6 5.4.0-xilinx-v2020.2 #1 SMP PREEMPT Fri Feb 3 17:27:45 UTC 2023 =
armv7l GNU/Linux

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--pqmvve6pnyma2yrz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmPivNMACgkQvlAcSiqK
BOgyLgf/eQTc4kNlx8aE8EhohcZGJSjp10vN/jBYZW19x8/AeCCrfPfeAl4HNQlS
tTcs+KKRUk84sFXShLFwRkZQcj7VWNUqyrNjVfxKJfhwgitHDJil1UCQEkTBi5UX
dV227CO089fOT/aqeTlfbsfHlTBF4tr8pLTD/k0/TUT1niqNE8c2NMstkHZ8nMK/
06Z+Jo3Y3ofWVxaoYuMDDJhr0aSpwHBsNqVmtD7aPmlVWLpHg5Dhy+ETiZN13BF3
H8LLHMcobeH23XMUZCw8Lqqh8JoTE37Ao4iGRwYiHKTKHhtqxLuTuLh/FJSPsLWG
PCYI8Dlt1JJVyEqYUqmBMkgX9wGq5A==
=nqdP
-----END PGP SIGNATURE-----

--pqmvve6pnyma2yrz--
