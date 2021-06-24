Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163EB3B2756
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 08:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFXGWl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Jun 2021 02:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhFXGWl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Jun 2021 02:22:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8AFC061574
        for <linux-can@vger.kernel.org>; Wed, 23 Jun 2021 23:20:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lwIio-0006JO-Rk; Thu, 24 Jun 2021 08:20:18 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:47f5:be86:773e:3d3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 259E86426F4;
        Thu, 24 Jun 2021 06:20:17 +0000 (UTC)
Date:   Thu, 24 Jun 2021 08:20:16 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 1/3] can-calc-bittiming: add stm32 bxcan
Message-ID: <20210624062016.tabvejebommpqcuj@pengutronix.de>
References: <20210624031954.26195-1-dev.kurt@vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vjisjmzni4p3euu7"
Content-Disposition: inline
In-Reply-To: <20210624031954.26195-1-dev.kurt@vandijck-laurijssen.be>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--vjisjmzni4p3euu7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.06.2021 05:19:52, Kurt Van Dijck wrote:
> Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> ---
>  can-calc-bit-timing.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
> index d99bd22..fb61947 100644
> --- a/can-calc-bit-timing.c
> +++ b/can-calc-bit-timing.c
> @@ -273,6 +273,22 @@ static void printf_btr_rcar_can(struct can_bittiming=
 *bt, bool hdr)
>  	}
>  }
> =20
> +		.bittiming_const =3D {
> +			.name =3D "bxcan",

What's that? A new CAN-IP  core?

I can apply these patches to the can-utils or you can create a github
pull request and I'll merge it there. What do you prefer?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--vjisjmzni4p3euu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDUJB0ACgkQqclaivrt
76mxPgf9EIXxYG6+6JNNT4aNV/JA4V0+SwN4jBpsRBB8uwDEhFr8SmOXq75M8SHc
/1URN6UmSbh86G2DDLNLZPg+TYOnBqgJ42jj5nMve3yOlIs0KWdxS5oPXQAPVPGS
uJ9VEWbfa3OD9XbYJ9jExSPMqgbb7+/wDOc6/M0M6F0jqwqQVnTrmZC2KjpVYRBP
BDukRNolH0//KHN4cdJYkXCsnCEF89adbhJvyojyYIGUoB5VZ4gMOUVENibbvn82
RS8juF+XKb55eWNz2NsM/GnzVNWoaInFQxfDezPe2sNK5VYxQEikb3umpdOLrC7L
ZYP0l9jt7fTZRpe4SbcNXdbKZKj/SQ==
=7i/c
-----END PGP SIGNATURE-----

--vjisjmzni4p3euu7--
