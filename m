Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D00432319D
	for <lists+linux-can@lfdr.de>; Tue, 23 Feb 2021 20:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhBWTux (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Feb 2021 14:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhBWTul (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Feb 2021 14:50:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE6EC061574
        for <linux-can@vger.kernel.org>; Tue, 23 Feb 2021 11:50:00 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lEdgz-0000LO-3A; Tue, 23 Feb 2021 20:49:57 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:484:a2a1:2383:f11e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2C9465E7D48;
        Tue, 23 Feb 2021 19:49:56 +0000 (UTC)
Date:   Tue, 23 Feb 2021 20:49:55 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v1 3/5] can: netlink: move '=' operators back to previous
 line (checkpatch fix)
Message-ID: <87im6id0o3.fsf@hardanger.blackshift.org>
References: <20210223162852.218041-1-mailhol.vincent@wanadoo.fr>
 <20210223162852.218041-4-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xsq4c4ibpji4meiw"
Content-Disposition: inline
In-Reply-To: <20210223162852.218041-4-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--xsq4c4ibpji4meiw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.02.2021 01:28:50, Vincent Mailhol wrote:
[...]
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -8,20 +8,18 @@
>  #include <net/rtnetlink.h>
> =20
>  static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] =3D {
> -	[IFLA_CAN_STATE]	=3D { .type =3D NLA_U32 },
> -	[IFLA_CAN_CTRLMODE]	=3D { .len =3D sizeof(struct can_ctrlmode) },
> -	[IFLA_CAN_RESTART_MS]	=3D { .type =3D NLA_U32 },
> -	[IFLA_CAN_RESTART]	=3D { .type =3D NLA_U32 },
> -	[IFLA_CAN_BITTIMING]	=3D { .len =3D sizeof(struct can_bittiming) },
> -	[IFLA_CAN_BITTIMING_CONST]
> -				=3D { .len =3D sizeof(struct can_bittiming_const) },
> -	[IFLA_CAN_CLOCK]	=3D { .len =3D sizeof(struct can_clock) },
> -	[IFLA_CAN_BERR_COUNTER]	=3D { .len =3D sizeof(struct can_berr_counter) =
},
> -	[IFLA_CAN_DATA_BITTIMING]
> -				=3D { .len =3D sizeof(struct can_bittiming) },
> -	[IFLA_CAN_DATA_BITTIMING_CONST]
> -				=3D { .len =3D sizeof(struct can_bittiming_const) },
> -	[IFLA_CAN_TERMINATION]	=3D { .type =3D NLA_U16 },
> +	[IFLA_CAN_STATE]		=3D { .type =3D NLA_U32 },
> +	[IFLA_CAN_CTRLMODE]		=3D { .len =3D sizeof(struct can_ctrlmode) },
> +	[IFLA_CAN_RESTART_MS]		=3D { .type =3D NLA_U32 },
> +	[IFLA_CAN_RESTART]		=3D { .type =3D NLA_U32 },
> +	[IFLA_CAN_BITTIMING]		=3D { .len =3D sizeof(struct can_bittiming) },
> +	[IFLA_CAN_BITTIMING_CONST]	=3D { .len =3D sizeof(struct can_bittiming_c=
onst) },
> +	[IFLA_CAN_CLOCK]		=3D { .len =3D sizeof(struct can_clock) },
> +	[IFLA_CAN_BERR_COUNTER]		=3D { .len =3D sizeof(struct can_berr_counter)=
 },
> +	[IFLA_CAN_DATA_BITTIMING]	=3D { .len =3D sizeof(struct can_bittiming) },
> +	[IFLA_CAN_DATA_BITTIMING_CONST]	=3D { .len =3D sizeof(struct can_bittim=
ing_const) },
> +	[IFLA_CAN_TERMINATION]		=3D { .type =3D NLA_U16 },
> +	[IFLA_CAN_TERMINATION]		=3D { .type =3D NLA_U16 },

You doubled the last entry by mistake.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xsq4c4ibpji4meiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA1XGAACgkQqclaivrt
76lHVQf7BYCalp19NgPiq1b8PxtWCo1Uanx+06KLszmfvquTwXdurtcq5fjlYG3y
mvcpaTYuwMyODCymMSuJ9uYIBRaWv46cfrqgo9S/7o4Qc08sWmhcW9f5z8OreBRN
G1WICVxjtTkOme31EN+Ya62IYrDyU5FFnmhTCRbZAEIFlJT/cMJfz8GZKIr6H9Qa
OyauXTpDgSn8jgRagT/0NGTyn5l1pdH+3WzFZuHr92cvnMR9xl2BMMpPzhvLe0ch
2drNM71qsz+00iVi6+wsACcgtmmJElJjxXOv5cAqwQw4MAQ6O6ev6AfmaQQC6qdc
M57E7Ob7gOox9VOg4cLPAKNvYlwqXg==
=uT+K
-----END PGP SIGNATURE-----

--xsq4c4ibpji4meiw--
