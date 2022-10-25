Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0387560CAE8
	for <lists+linux-can@lfdr.de>; Tue, 25 Oct 2022 13:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiJYL2s (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Oct 2022 07:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiJYL2q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Oct 2022 07:28:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A5618D828
        for <linux-can@vger.kernel.org>; Tue, 25 Oct 2022 04:28:45 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1onI6u-0001K8-B0; Tue, 25 Oct 2022 13:28:44 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2518B109670;
        Tue, 25 Oct 2022 11:28:43 +0000 (UTC)
Date:   Tue, 25 Oct 2022 13:28:37 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Lukas Magel <lukas.magel@posteo.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 7/7] can: peak_usb: align user device id format in log
 with sysfs attribute
Message-ID: <20221025112837.gkqs7ksrgv4jjlsd@pengutronix.de>
References: <20221022213535.8495-1-lukas.magel@posteo.net>
 <20221022213535.8495-8-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hy6idb4q4xpxkpm6"
Content-Disposition: inline
In-Reply-To: <20221022213535.8495-8-lukas.magel@posteo.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--hy6idb4q4xpxkpm6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.10.2022 21:35:35, Lukas Magel wrote:
> Previously, the user device id was printed to the kernel log in decimal
> upon connecting a new PEAK device. This behavior is inconsistent with
> the hexadecimal format of the user device id sysfs attribute. This patch
> updates the log message to output the id in hexadecimal.
>=20
> Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_core.c
> index fbefd4f05e08..8bb9a3fa686c 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -1028,8 +1028,8 @@ static int peak_usb_create_dev(const struct peak_us=
b_adapter *peak_usb_adapter,
>  	/* get device number early */
>  	dev->adapter->dev_get_user_devid(dev, &dev->user_devid);
> =20
> -	netdev_info(netdev, "attached to %s channel %u (device %u)\n",
> -			peak_usb_adapter->name, ctrl_idx, dev->user_devid);
> +	netdev_info(netdev, "attached to %s channel %u (device %08Xh)\n",
                                                                  ^^
Why is the a trailing 'h'? To denote that it's a hexadecimal value?

> +		    peak_usb_adapter->name, ctrl_idx, dev->user_devid);
> =20
>  	return 0;
> =20
> --=20
> 2.37.2
>=20
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--hy6idb4q4xpxkpm6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNXyGMACgkQrX5LkNig
010bRQf6AwDCNH1QddYjtCqolVDKQAu2MKVHUeLfWD8ZsfxPkwfDnDKzHmjQfgvP
B7pCXp98DpsoDddjNl8DKwLgb6BBJr0V3YhJl9V2DdAH9b9cY9M95hhatL9SuH9U
ePD/jf3B1FssJ5z4lS3UJfqUL/zYgpsc53IfNZUguIC1KeF8Yk4cAUnkcLZ6hMOv
jMMX/knA7UgmeZoId/nV3LCUFE3Wf1Tb+5ao1YJHasG7pe5Qvgh70WE5CEfnxLY/
zEOnCF0AFpx9sHjnqjOITkBy1ycar3jb6Nivmm07hf1YE+dgH+zsTYgdDI6Ej3Kq
IFxB+YwCMCX5ACzvZIctJoNHYwAXwQ==
=HmrB
-----END PGP SIGNATURE-----

--hy6idb4q4xpxkpm6--
