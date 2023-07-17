Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D64875672D
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjGQPJG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 11:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGQPJF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 11:09:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37189F9
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 08:09:04 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLPqP-0000wi-SK; Mon, 17 Jul 2023 17:09:01 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E47EF1F376A;
        Mon, 17 Jul 2023 15:09:00 +0000 (UTC)
Date:   Mon, 17 Jul 2023 17:09:00 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: Re: [PATCH v2 0/2] can: kvaser_pciefd: Add support for new Kvaser
 PCI Express devices
Message-ID: <20230717-sponsor-unenvied-d76909f2c1e9-mkl@pengutronix.de>
References: <20230622151153.294844-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n763olvwwct6fmhh"
Content-Disposition: inline
In-Reply-To: <20230622151153.294844-1-extja@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--n763olvwwct6fmhh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.06.2023 17:11:51, Jimmy Assarsson wrote:
> This patch series adds support for a range of new Kvaser PCI Express
> devices based on the SmartFusion2 SoC, to the kvaser_pciefd driver.
>=20
> In the first patch, the hardware specific constants and functions are
> moved into a driver_data struct.
>=20
> In the second patch, we add the new devices and their hardware specific
> constants and functions.
>=20
>=20
> Jimmy Assarsson (2):
>   can: kvaser_pciefd: Move hardware specific constants and functions
>     into a driver_data struct
>   can: kvaser_pciefd: Add support for new Kvaser pciefd devices
>=20
>  drivers/net/can/Kconfig         |   5 +
>  drivers/net/can/kvaser_pciefd.c | 307 ++++++++++++++++++++++++--------
>  2 files changed, 235 insertions(+), 77 deletions(-)

Applied to linux-can-next/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--n763olvwwct6fmhh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS1WYkACgkQvlAcSiqK
BOgG6Af/aQRXAG4bYZ/gvsn2ir5mtbQlZU51hNyxVzFIwjnnYitngvdJpws+rBt5
BGOrh39PZImvK/Fp+hZHgGS1kn+pIjNP4aPkDRAuvl38k67SL1PM2Odt32/mkVtx
sG7YnwLai/x8o3IEBs4Sfi94dtxtLBQ2tSTZz9D0Jx1mh8TnvKGQE4bLOhDWo5bs
qwojoNvB8Yuvyczuhlycj43uJ50mwwPyMwtSEazEQ/zYZobWZTnvPR7p+C5HGWmw
dam1BXn9qJwq5h7Z96/yz8CMxMykCQnl0LWo1ncOPBlYxSg7MFWZAZS4MZnlrzaS
erpVRxsQ4jtqru0MslWu7llsrWOeAA==
=VKUC
-----END PGP SIGNATURE-----

--n763olvwwct6fmhh--
