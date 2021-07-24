Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E8C3D4A14
	for <lists+linux-can@lfdr.de>; Sat, 24 Jul 2021 23:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhGXUmc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 24 Jul 2021 16:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGXUmb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 24 Jul 2021 16:42:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3662AC061575
        for <linux-can@vger.kernel.org>; Sat, 24 Jul 2021 14:23:03 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m7P6r-0007yf-Fl; Sat, 24 Jul 2021 23:23:01 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:41cc:c65c:f580:3bde])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 748096571A2;
        Sat, 24 Jul 2021 21:23:00 +0000 (UTC)
Date:   Sat, 24 Jul 2021 23:22:59 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 4/6] can: etas_es58x: add es58x_free_netdevs() to
 factorize code
Message-ID: <20210724212259.dsikdmoeljpex46o@pengutronix.de>
References: <20210628155420.1176217-1-mailhol.vincent@wanadoo.fr>
 <20210628155420.1176217-5-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jwjvalxipw7izoyb"
Content-Disposition: inline
In-Reply-To: <20210628155420.1176217-5-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--jwjvalxipw7izoyb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.06.2021 00:54:18, Vincent Mailhol wrote:
> Both es58x_probe() and es58x_disconnect() use a similar code snippet
> to release the netdev resources. Factorize it in an helper function
> named es58x_free_netdevs().
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/net/can/usb/etas_es58x/es58x_core.c | 46 +++++++++++----------
>  1 file changed, 24 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/ca=
n/usb/etas_es58x/es58x_core.c
> index d2bb1b56f962..dbc4f75336a1 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> @@ -2107,6 +2107,25 @@ static int es58x_init_netdev(struct es58x_device *=
es58x_dev, int channel_idx)
>  	return ret;
>  }
> =20
> +/**
> + * es58x_free_netdevs() - Release all network resorces of the device.
                                                 ^^^^^^^^
fixed typo

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jwjvalxipw7izoyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmD8hLAACgkQqclaivrt
76m0xQf/R3ZAwHQbQ+VUG2deWTJ+saI54jpsblcpV+4+wsZXcXb+aT9J3pU7WTX/
Wif1Tn3WIUwB2DdAUQlbvuiDBPMpBr7My9oVWOJcQ6YjLvdZxV4gF5kcGUvsYo7o
Ky9yVM6Kvtkite5LzUiIqg0tf8WNDc+HE9hAijSdFAjz7mTidRUR3Z+qurKfoWVl
vsn8l+c1MJOn51Mtvhps41FWjfrOGzGaW7450zk9EuLzdjBsj49PGTTyZ4A9f67g
xrcrMNRr6Z1ULd3G1bXEXcHF1pY+WIGiF7WuwdlNm/Iel85Q8VUH0r4hAM22tb7r
9tOMe5h77nVXlYrxiTm8R+JuKWBtFQ==
=ikV8
-----END PGP SIGNATURE-----

--jwjvalxipw7izoyb--
