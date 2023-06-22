Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCEA7397F7
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 09:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFVHPQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 03:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFVHPP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 03:15:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6C8E69
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 00:15:14 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qCEX7-0008Qg-Ep; Thu, 22 Jun 2023 09:15:09 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 944DB1DF249;
        Thu, 22 Jun 2023 07:15:07 +0000 (UTC)
Date:   Thu, 22 Jun 2023 09:15:06 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH net-next 04/33] can: esd_usb: Replace initializer macros
 used for struct can_bittiming_const
Message-ID: <20230622-batboy-roulette-f94e1ad087a2-mkl@pengutronix.de>
References: <20230621132914.412546-1-mkl@pengutronix.de>
 <20230621132914.412546-5-mkl@pengutronix.de>
 <ZJPytAFaG3UFaw3i@corigine.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="btpfdpaa6xyqcbfy"
Content-Disposition: inline
In-Reply-To: <ZJPytAFaG3UFaw3i@corigine.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--btpfdpaa6xyqcbfy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.06.2023 09:05:24, Simon Horman wrote:
> Hi Marc and Frank,
>=20
> it seems that something might have got mixed up here,
> because GCC complains that:
>=20
>  drivers/net/can/usb/esd_usb.c:916:43: error: use of undeclared identifie=
r 'esd_usb_2_bittiming_const'; did you mean 'esd_usb2_bittiming_const'?
>          const struct can_bittiming_const *btc =3D &esd_usb_2_bittiming_c=
onst;
>                                                   ^~~~~~~~~~~~~~~~~~~~~~~=
~~
>                                                   esd_usb2_bittiming_const
>  drivers/net/can/usb/esd_usb.c:902:41: note: 'esd_usb2_bittiming_const' d=
eclared here
>  static const struct can_bittiming_const esd_usb2_bittiming_const =3D {
>                                         ^
> --=20

Doh! Will fix.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--btpfdpaa6xyqcbfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmST9PgACgkQvlAcSiqK
BOiAUQf/UIYykb6K2z+OnJ0sZHRoshvH3D8TS3+Bm//zDKdfYG6INE2lD2yoSHIQ
EC7MTrbycsAd4NgGgNm8+wzkcJyGoQF1FeZ6APx5If7YCVhhKuNg9v5QO+UXm6Mx
AAX356lCkRWZiI+FKz6p8XJdjKqpZin50aDYIlaLmKMr2IuaKmvxgJoO90PAeLk8
O/AZ4eRxUhP/ekBJM9fMePNULxbU4lyrVertyiJwlvpp6/p0OiGwpFXok12CsUse
M/rGC3MSagGxpAuio6b4DyFB7zkYjGVi9nVYPx7ouIoTZe8u+wd/w1kziyovDloG
irUsz3aLza7NzbgS8G3YGmEQkng+1w==
=V52t
-----END PGP SIGNATURE-----

--btpfdpaa6xyqcbfy--
