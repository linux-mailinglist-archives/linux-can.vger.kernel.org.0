Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB9179EAED
	for <lists+linux-can@lfdr.de>; Wed, 13 Sep 2023 16:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjIMOXB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Sep 2023 10:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjIMOXB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Sep 2023 10:23:01 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A7D98
        for <linux-can@vger.kernel.org>; Wed, 13 Sep 2023 07:22:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qgQlX-0003r1-Vd; Wed, 13 Sep 2023 16:22:51 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qgQlW-0065sq-Rj; Wed, 13 Sep 2023 16:22:50 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 88AE921FB9A;
        Wed, 13 Sep 2023 14:22:50 +0000 (UTC)
Date:   Wed, 13 Sep 2023 16:22:50 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Cc:     linux-can@vger.kernel.org,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 1/2] can: m_can: allow keeping the transceiver running in
 suspend
Message-ID: <20230913-ageless-chump-67dfb3da0f42-mkl@pengutronix.de>
References: <20230912093807.1383720-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r7ptotzekm6qckt5"
Content-Disposition: inline
In-Reply-To: <20230912093807.1383720-1-martin@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--r7ptotzekm6qckt5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.09.2023 11:38:03, Martin Hundeb=C3=B8ll wrote:
> Add a flag to the suspend class function that leaves the chip in a
> running state with rx interrupt enabled, so that m_can device driver can
> configure and use the interrupt as a wakeup source.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@geanix.com>
> ---
>  drivers/net/can/m_can/m_can.c          | 13 +++++++++++--
>  drivers/net/can/m_can/m_can.h          |  2 +-
>  drivers/net/can/m_can/m_can_platform.c |  2 +-
>  3 files changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 16ecc11c7f62..21ac826170f9 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2113,7 +2113,7 @@ void m_can_class_unregister(struct m_can_classdev *=
cdev)
>  }
>  EXPORT_SYMBOL_GPL(m_can_class_unregister);
> =20
> -int m_can_class_suspend(struct device *dev)
> +int m_can_class_suspend(struct device *dev, bool is_wake_source)

Please change all users of m_can_class_suspend().

>  {
>  	struct m_can_classdev *cdev =3D dev_get_drvdata(dev);
>  	struct net_device *ndev =3D cdev->net;
> @@ -2121,7 +2121,16 @@ int m_can_class_suspend(struct device *dev)
>  	if (netif_running(ndev)) {
>  		netif_stop_queue(ndev);
>  		netif_device_detach(ndev);
> -		m_can_stop(ndev);
> +
> +		/*
> +		 * leave the chip running with rx interrupt enabled if it used
> +		 * as a wake-up source.
> +		 */

networking block comments don't use an empty /* line, use /* Comment...

> +		if (is_wake_source)
> +			m_can_write(cdev, M_CAN_IE, IR_RF0N);
> +		else
> +			m_can_stop(ndev);
> +
>  		m_can_clk_stop(cdev);
>  	}
> =20
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index 520e14277dff..542e8daad578 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -105,6 +105,6 @@ int m_can_class_get_clocks(struct m_can_classdev *cde=
v);
>  int m_can_init_ram(struct m_can_classdev *priv);
>  int m_can_check_mram_cfg(struct m_can_classdev *cdev, u32 mram_max_size);
> =20
> -int m_can_class_suspend(struct device *dev);
> +int m_can_class_suspend(struct device *dev, bool is_wake_source);
>  int m_can_class_resume(struct device *dev);
>  #endif	/* _CAN_M_H_ */
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_c=
an/m_can_platform.c
> index cdb28d6a092c..bbf6a245a3e0 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -169,7 +169,7 @@ static int m_can_plat_probe(struct platform_device *p=
dev)
> =20
>  static __maybe_unused int m_can_suspend(struct device *dev)
>  {
> -	return m_can_class_suspend(dev);
> +	return m_can_class_suspend(dev, false);
>  }
> =20
>  static __maybe_unused int m_can_resume(struct device *dev)
> --=20
> 2.42.0
>=20
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--r7ptotzekm6qckt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUBxbcACgkQvlAcSiqK
BOivCAgAkdSRT58oSnfRqq5pdKIZtUKiDPyGmbfXKIm4RuBDTWmX4eT8IkHgnrCJ
r/HI/0UwWo3MVIxYhgp2qEHiSNFkRPcBKZkP9gtOBhkosjOBdKRGZ8tmZ0TOOGT1
3X/fZUtJ1xqFv5hRx/nKZb6m/9DAXYMs1c/ROVoc94ioOrmHGAgXW7ATnWSkrlwp
81KlfxCywZaL0RCnKNmgeL5Ab1q/SPCbjkv19rFuYmXFXnRgals8M9GQkJyDAZm0
1otM+r2StzSIGoLbWWRrsxnKIlJV7j59aaol3+FfJ8k+M3HMqKUtuDoEVKwH/6z3
bq40Cyzh0bRnGhi7yWq1xTK/m8VAFw==
=GaeU
-----END PGP SIGNATURE-----

--r7ptotzekm6qckt5--
