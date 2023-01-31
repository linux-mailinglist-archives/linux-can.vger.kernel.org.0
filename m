Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7EB682B1D
	for <lists+linux-can@lfdr.de>; Tue, 31 Jan 2023 12:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjAaLGN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Jan 2023 06:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjAaLGM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2023 06:06:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D68D42DD8
        for <linux-can@vger.kernel.org>; Tue, 31 Jan 2023 03:06:11 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pMoSn-0005M3-U0; Tue, 31 Jan 2023 12:06:09 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:29f7:a2fc:d3f6:7550])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4631316A0E3;
        Tue, 31 Jan 2023 11:06:09 +0000 (UTC)
Date:   Tue, 31 Jan 2023 12:06:00 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: raw: fix CAN FD frame transmissions over CAN XL
 devices
Message-ID: <20230131110600.pfydrujxthmokmsc@pengutronix.de>
References: <20230131091824.51026-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mhzusji7t3xklqcu"
Content-Disposition: inline
In-Reply-To: <20230131091824.51026-1-socketcan@hartkopp.net>
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


--mhzusji7t3xklqcu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.01.2023 10:18:24, Oliver Hartkopp wrote:
> A CAN XL device is always capable to process CAN FD frames. The former
> check when sending CAN FD frames relied on the existence of a CAN FD
> device and did not check for a CAN XL device that would be correct too.
>=20
> With this patch the CAN FD feature is enabled automatically when CAN XL
> is switched on - and CAN FD cannot be switch off while CAN XL is enabled.
>=20
> This precondition also leads to a clean up and reduction of checks in the
> hot path in raw_rcv() and raw_sendmsg().
>=20
> Fixes: 626332696d75 ("can: raw: add CAN XL support")
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>=20
> V2: fixed typo: devive -> device
>=20
> net/can/raw.c | 45 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 15 deletions(-)
>=20
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 81071cdb0301..c505d315a7a9 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -130,11 +130,11 @@ static void raw_rcv(struct sk_buff *oskb, void *dat=
a)
>  	/* check the received tx sock reference */
>  	if (!ro->recv_own_msgs && oskb->sk =3D=3D sk)
>  		return;
> =20
>  	/* make sure to not pass oversized frames to the socket */
> -	if ((can_is_canfd_skb(oskb) && !ro->fd_frames && !ro->xl_frames) ||
> +	if ((can_is_canfd_skb(oskb) && !ro->fd_frames) ||
>  	    (can_is_canxl_skb(oskb) && !ro->xl_frames))
>  		return;
> =20
>  	/* eliminate multiple filter matches for the same skb */
>  	if (this_cpu_ptr(ro->uniq)->skb =3D=3D oskb &&
> @@ -668,19 +668,27 @@ static int raw_setsockopt(struct socket *sock, int =
level, int optname,
>  			return -EINVAL;
> =20
>  		if (copy_from_sockptr(&ro->fd_frames, optval, optlen))
>  			return -EFAULT;
> =20
> +		/* Enabling CAN XL includes CAN FD */
> +		if (ro->xl_frames && !ro->fd_frames) {
> +			ro->fd_frames =3D ro->xl_frames;
> +			return -EINVAL;
> +		}

This looks a bit weird. Maybe copy to a local variable first, then
check, then assign ->fd_frames or exit with error (instead of rolling
back)?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--mhzusji7t3xklqcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPY9hUACgkQrX5LkNig
011gMgf+IBBjcE4fnc2K085oBF2B8VKpJhCj4tI2lcd23myeCBMNQ7je6q06Wrms
i42blpxYJ0oGCdb6ihxti7tl2/+EHKdZEthHohje0lE9Av57bWlPHetKqEMc7xw7
+sw/1mCxpnFdQATqRzHq/cpAGqheO8bkpqW5MNNwStEa/K7jWCD0b5hnuRFikmR+
lviGvE2qGi3at4jJVrspr5seZzAfaKdbAKPrqSK3KsiEzYAVcFHN5e1Xv4EgB3hA
eeZgILPPB1D3I4RvoUmYheoOG6u0aZ9JEUqoOtXmwD6ggCQerok3xv7aFEUIj5zI
JBypSmgbBC1HD3R26zGA9Wf7ggzPLg==
=tl+S
-----END PGP SIGNATURE-----

--mhzusji7t3xklqcu--
