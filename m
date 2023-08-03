Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F5476E2D5
	for <lists+linux-can@lfdr.de>; Thu,  3 Aug 2023 10:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbjHCIVS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 3 Aug 2023 04:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbjHCIUv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 3 Aug 2023 04:20:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CCA5BA6
        for <linux-can@vger.kernel.org>; Thu,  3 Aug 2023 01:15:54 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qRTUi-0002GF-Bh; Thu, 03 Aug 2023 10:15:40 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 073C22022D2;
        Thu,  3 Aug 2023 08:15:39 +0000 (UTC)
Date:   Thu, 3 Aug 2023 10:15:38 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     haibo.chen@nxp.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        wg@grandegger.com, kernel@pengutronix.de, linux-imx@nxp.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] arm64: dts: imx93: add the Flex-CAN stop mode by
 GPR
Message-ID: <20230803-pureness-lilly-a285e530cc6c-mkl@pengutronix.de>
References: <20230726112458.3524165-1-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p2d3wquopx5arobx"
Content-Disposition: inline
In-Reply-To: <20230726112458.3524165-1-haibo.chen@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--p2d3wquopx5arobx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2023 19:24:57, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>=20
> imx93 A0 chip use the internal q-channel handshake signal in LPCG
> and CCM to automatically handle the Flex-CAN stop mode. But this
> method meet issue when do the system PM stress test. IC can't fix
> it easily. So in the new imx93 A1 chip, IC drop this method, and
> involve back the old way=EF=BC=8Cuse the GPR method to trigger the Flex-C=
AN
> stop mode signal. Now NXP claim to drop imx93 A0, and only support
> imx93 A1. So here add the stop mode through GPR.
>=20
> This patch also fix a typo for aonmix_ns_gpr.
>=20
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Added both to linux-can/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--p2d3wquopx5arobx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTLYicACgkQvlAcSiqK
BOiFPQf/VRYql3MNa/WmqW7jg6JhR4TiarD2pBqlpTAr2ED/rAmmxS09s08TD6l0
rYL18J0Q3Q9qWfAvyiNtKUA5wg4/Z11D4ZghrynDlNF+D7kK8hLaNzCGQRhtviMd
0cbZZVTq8q+2ZsREdKZij4hmGGTFVp0aBX+KSOjLaMR3GjcuusL8qjAqzaWSiRIz
FNkH72i5nic+vC5rUtt+fo03NO4LtA2QPLxV8anU3puahX0X8gVNYnUdcrR+JYJp
qZAMPVcj/DMmKbivTqvfNYLUBj8jS3acMwDpdX+bvcz5abb3EaZFwqwgxxG5Xz4E
7vCvEJRahX3WgKLB9p6OsEMT2Cjtvw==
=619W
-----END PGP SIGNATURE-----

--p2d3wquopx5arobx--
