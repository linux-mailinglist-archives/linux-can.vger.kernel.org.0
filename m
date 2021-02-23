Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6FD32319F
	for <lists+linux-can@lfdr.de>; Tue, 23 Feb 2021 20:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhBWTww (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Feb 2021 14:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhBWTww (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Feb 2021 14:52:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F82C06174A
        for <linux-can@vger.kernel.org>; Tue, 23 Feb 2021 11:52:11 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lEdj7-0000bt-FM; Tue, 23 Feb 2021 20:52:09 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:484:a2a1:2383:f11e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7ACB85E7D50;
        Tue, 23 Feb 2021 19:52:08 +0000 (UTC)
Date:   Tue, 23 Feb 2021 20:52:07 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v1 4/5] can: add netlink interface for CAN-FD Transmitter
 Delay Compensation (TDC)
Message-ID: <20210223195207.p75p2svt647tr5by@pengutronix.de>
References: <20210223162852.218041-1-mailhol.vincent@wanadoo.fr>
 <20210223162852.218041-5-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mxsom5xuquwoqidg"
Content-Disposition: inline
In-Reply-To: <20210223162852.218041-5-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--mxsom5xuquwoqidg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.02.2021 01:28:51, Vincent Mailhol wrote:
[...]
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -19,7 +19,12 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX=
 + 1] =3D {
>  	[IFLA_CAN_DATA_BITTIMING]	=3D { .len =3D sizeof(struct can_bittiming) },
>  	[IFLA_CAN_DATA_BITTIMING_CONST]	=3D { .len =3D sizeof(struct can_bittim=
ing_const) },
>  	[IFLA_CAN_TERMINATION]		=3D { .type =3D NLA_U16 },
> -	[IFLA_CAN_TERMINATION]		=3D { .type =3D NLA_U16 },

here you remove the double last entry.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--mxsom5xuquwoqidg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA1XOUACgkQqclaivrt
76nVlwf8Dteuf4sgeR1sdseyO8Y1EkCiAvnerysS+f1yArG4c6pXCmLPI5TkP9BS
0XGRE5SLC51zwavuHk0OkBDzVOIWMUI921kuKdLSETxjX+I+a0yt5wtiIDtQpsAc
UXKqqCamQqrUr27maLAJ0Fi0L7VW3a4dQEsbtsjAAj42yI7/jCuH1uOMAq9ciJ6x
W6g34zLH0HTVOqRQEB3zG2wbj+PBi8bkSRiK6vZVNBPpOUZx5r4IfxxknUDw1p3c
pB5Ma543JaSIAqxNzW19uXBBT9dKagnpF0+Io2uWgGhrquV/uqYqMWh6ODdtaQRv
+jdHrc/MoHr1T9oCbLH8Wfr63jtDcQ==
=Sfrg
-----END PGP SIGNATURE-----

--mxsom5xuquwoqidg--
