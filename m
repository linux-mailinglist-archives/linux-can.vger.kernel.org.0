Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFC3583B5A
	for <lists+linux-can@lfdr.de>; Thu, 28 Jul 2022 11:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiG1Ji2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 28 Jul 2022 05:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbiG1Ji2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Jul 2022 05:38:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEC362498
        for <linux-can@vger.kernel.org>; Thu, 28 Jul 2022 02:38:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oGzyI-0000it-AG; Thu, 28 Jul 2022 11:38:22 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C15D3BCB95;
        Thu, 28 Jul 2022 09:38:20 +0000 (UTC)
Date:   Thu, 28 Jul 2022 11:38:19 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH v4 05/14] can: tree-wide: advertise software timestamping
 capabilities
Message-ID: <20220728093819.q37lzttsknqzi6a5@pengutronix.de>
References: <20220727101641.198847-1-mailhol.vincent@wanadoo.fr>
 <20220727101641.198847-6-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2yn37vjpzi7ocxpu"
Content-Disposition: inline
In-Reply-To: <20220727101641.198847-6-mailhol.vincent@wanadoo.fr>
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


--2yn37vjpzi7ocxpu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.07.2022 19:16:32, Vincent Mailhol wrote:
> Currently, some CAN drivers support hardware timestamping, some do
> not. But userland has no method to query which features are supported
> (aside maybe of getting RX messages and observe whether or not
> hardware timestamps stay at zero).
>=20
> The canonical way for a network driver to advertised what kind of
> timestamping it supports is to implement ethtool_ops::get_ts_info().
>=20
> This patch only targets the CAN drivers which *do not* support
> hardware timestamping.  For each of those CAN drivers, implement the
> get_ts_info() using the generic ethtool_op_get_ts_info().
>=20
> This way, userland can do:
>=20
> | $ ethtool --show-time-stamping canX
>=20
> to confirm the device timestamping capacities.
>=20
> N.B. the drivers which support hardware timestamping will be migrated
> in separate patches.
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

[...]

> diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
> index 78a21ab63601..b1677588a4c8 100644
> --- a/drivers/net/can/mscan/mscan.c
> +++ b/drivers/net/can/mscan/mscan.c
> @@ -676,6 +676,7 @@ struct net_device *alloc_mscandev(void)
>  	priv =3D netdev_priv(dev);
> =20
>  	dev->netdev_ops =3D &mscan_netdev_ops;
> +	dev->ethtool_ops =3D &mscan_ethtool_ops;
> =20
>  	dev->flags |=3D IFF_ECHO;	/* we support local echo */

| drivers/net/can/mscan/mscan.c: In function =E2=80=98alloc_mscandev=E2=80=
=99:
| drivers/net/can/mscan/mscan.c:679:29: error: =E2=80=98mscan_ethtool_ops=
=E2=80=99 undeclared (first use in this function)
|   679 |         dev->ethtool_ops =3D &mscan_ethtool_ops;
|       |                             ^~~~~~~~~~~~~~~~~
| drivers/net/can/mscan/mscan.c:679:29: note: each undeclared identifier is=
 reported only once for each function it appears in

I'm fixing this.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--2yn37vjpzi7ocxpu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLiWQgACgkQrX5LkNig
013abAf/ew9DoNtMZ3gsaFbLAMggAaDJzotdCEN2Ri3lUK+vTi8MzirzGrWR1kNU
ZR1tfwOqe4UtFyXhMmwTshjV04XFaA4R0uHkNJ4sbKTk3xuCnM3WwZr1auVSFdrU
8W+nNxLBr2UlEq7hZ55EzgbiJhtcAqUPg0t/A7DQhSpruB32SQLyNXlGuL6oUJgy
sOJs/9ma1qIyIKj3hhOpO6InuUKXRsXg4sqybmzSweYc4k8d5aFtq8PZ8+Df/do0
xHQiJxlTs40PWoyV8c2BEkL399Q/xo1HBVXq5Ig523SNdYqLfVLbGuGsFBqDNTcy
+JrYzoXsH8ucyJVfM9n/CAKynR2iEA==
=GxBn
-----END PGP SIGNATURE-----

--2yn37vjpzi7ocxpu--
