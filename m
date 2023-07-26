Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348E7763343
	for <lists+linux-can@lfdr.de>; Wed, 26 Jul 2023 12:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGZKRB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jul 2023 06:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjGZKRA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Jul 2023 06:17:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3C21984
        for <linux-can@vger.kernel.org>; Wed, 26 Jul 2023 03:17:00 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qObZO-0002ZA-8k; Wed, 26 Jul 2023 12:16:38 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C32901FB186;
        Wed, 26 Jul 2023 10:16:36 +0000 (UTC)
Date:   Wed, 26 Jul 2023 12:16:36 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     haibo.chen@nxp.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        wg@grandegger.com, kernel@pengutronix.de, linux-imx@nxp.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/3] can: flexcan: lack of stop mode dts properity
 should not block driver probe
Message-ID: <20230726-majorette-manor-ea82bb4afa68-mkl@pengutronix.de>
References: <20230726090909.3417030-1-haibo.chen@nxp.com>
 <20230726090909.3417030-3-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cjbrrbvmxmmqq34f"
Content-Disposition: inline
In-Reply-To: <20230726090909.3417030-3-haibo.chen@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--cjbrrbvmxmmqq34f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2023 17:09:09, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>=20
> If SoC claim to support stop mode, but dts file do not contain the stop
> mode properity, this should not block the driver probe. For this case,
> the driver only need to skip the wakeup capable setting which means this
> device do not support the feature to wakeup system.

This still breaks old DTS on kernels with patch 2 applied, but not 3.
Please squash this into 2.

>=20
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index a3f3a9c909be..d8be69f4a0c3 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -1987,7 +1987,14 @@ static int flexcan_setup_stop_mode(struct platform=
_device *pdev)
>  		/* return 0 directly if doesn't support stop mode feature */
>  		return 0;
> =20
> -	if (ret)
> +	/* If ret is -EINVAL, this means SoC claim to support stop mode, but
> +	 * dts file lack the stop mode property definition. For this case,
> +	 * directly return 0, this will skip the wakeup capable setting and
> +	 * will not block the driver probe.
> +	 */
> +	if (ret =3D=3D -EINVAL)
> +		return 0;
> +	else if (ret)
>  		return ret;
> =20
>  	device_set_wakeup_capable(&pdev->dev, true);
> --=20
> 2.34.1
>=20
>=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cjbrrbvmxmmqq34f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTA8oEACgkQvlAcSiqK
BOitZAgAre7gePm257fB84ueqkVE0mAA41PVK+xx6PvmmzojzCx48WrmuqgJUKxX
iFaah4dWMj5ls7nm/HZBXCNrX8HVfwZQCqOok8TaMNWn2hlZ80kzJwykcngibAEB
UCx+qAsIuUjniC8rEPkYNFxSTZg5Z+a2/oCo0orcMZ5G4mYzsIUMBH9jwtyuTJ1A
qaZqSK58oLMKNrWtJHJox9Ji2i0uhFOtJuKKsZG8yizyxHQPkKvXk37C2aSEzDXV
mDi3cI0KI+G0uNyoueYc/kxV+Dqpp03g5ZJmjSF1ak+NAvWu/g0KjoBKFSf1FYcE
j24fcHXS6KoDt/1uSaorUjAPpPTTPQ==
=FhOU
-----END PGP SIGNATURE-----

--cjbrrbvmxmmqq34f--
