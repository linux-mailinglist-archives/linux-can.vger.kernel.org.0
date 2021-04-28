Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD9436D496
	for <lists+linux-can@lfdr.de>; Wed, 28 Apr 2021 11:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbhD1JNM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Apr 2021 05:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1JNM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Apr 2021 05:13:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB55C061574
        for <linux-can@vger.kernel.org>; Wed, 28 Apr 2021 02:12:27 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lbgF8-0005oz-JD; Wed, 28 Apr 2021 11:12:26 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4048:54d7:3c62:4ce5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A56BD6186BA;
        Wed, 28 Apr 2021 09:12:25 +0000 (UTC)
Date:   Wed, 28 Apr 2021 11:12:24 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: isotp: return -ECOMM on FC timeout on TX path
Message-ID: <20210428091224.lsqf4tttd7uijdms@pengutronix.de>
References: <20210428090914.252967-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qej5eo4xwgqina3a"
Content-Disposition: inline
In-Reply-To: <20210428090914.252967-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--qej5eo4xwgqina3a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.04.2021 11:09:14, Marc Kleine-Budde wrote:
> From: "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>
>=20
> Link: https://github.com/hartkopp/can-isotp/pull/43
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Not-Signed-off-by: Sottas Guillaume (LMB) <Guillaume.Sottas@liebherr.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>=20
> Hello,
>=20
> for better reviewing I'm posting Sottas's patch here. While porting to
> current net/master I've fixed up the indention.
>=20
> regards,
> Marc
>=20
>  net/can/isotp.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 9f94ad3caee9..d02e8f1f240f 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -110,6 +110,11 @@ MODULE_ALIAS("can-proto-6");
>  #define ISOTP_FC_WT 1		/* wait */
>  #define ISOTP_FC_OVFLW 2	/* overflow */
> =20
> +enum {
> +	ISOTP_ERR_NO_ERROR =3D 0,
> +	ISOTP_ERR_FC_TIMEOUT,
> +};
> +
>  enum {
>  	ISOTP_IDLE =3D 0,
>  	ISOTP_WAIT_FIRST_FC,
> @@ -122,6 +127,7 @@ struct tpcon {
>  	int idx;
>  	int len;
>  	u8 state;
> +	u8 error;
>  	u8 bs;
>  	u8 sn;
>  	u8 ll_dl;
> @@ -756,6 +762,10 @@ static enum hrtimer_restart isotp_tx_timer_handler(s=
truct hrtimer *hrtimer)

>               sk->sk_err =3D ECOMM;
>  		if (!sock_flag(sk, SOCK_DEAD))
>  			sk->sk_error_report(sk);

I think the idea is that sk_error_report takes care of propagation of
the error to the user space. I don't know why it's not working as
expected.

> =20
> +		/* set error flag in order to consume it later in the
> +		 * isotp_sendmsg function */
> +		so->tx.error =3D ISOTP_ERR_FC_TIMEOUT;
> +
>  		/* reset tx state */
>  		so->tx.state =3D ISOTP_IDLE;
>  		wake_up_interruptible(&so->wait);
> @@ -954,6 +964,13 @@ static int isotp_sendmsg(struct socket *sock, struct=
 msghdr *msg, size_t size)
>  	if (wait_tx_done) {
>  		/* wait for complete transmission of current pdu */
>  		wait_event_interruptible(so->wait, so->tx.state =3D=3D ISOTP_IDLE);
> +
> +		/* check if an error has been raised in the timer
> +		 * function handler */
> +		if (so->tx.error =3D=3D ISOTP_ERR_FC_TIMEOUT) {
> +			so->tx.error =3D ISOTP_ERR_NO_ERROR;
> +			return -ECOMM;
> +		}
>  	}
> =20
>  	return size;
> @@ -1371,6 +1388,9 @@ static int isotp_init(struct sock *sk)
>  	so->tx.state =3D ISOTP_IDLE;
> =20
>  	hrtimer_init(&so->rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
> +
> +	so->tx.error =3D ISOTP_ERR_NO_ERROR;
> +	so->rx.error =3D ISOTP_ERR_NO_ERROR;
>  	so->rxtimer.function =3D isotp_rx_timer_handler;
>  	hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
>  	so->txtimer.function =3D isotp_tx_timer_handler;


Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--qej5eo4xwgqina3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCJJvYACgkQqclaivrt
76mUNQf/eGMBL4aPtdqQXAkDfOPFWOfvpqu/wNk1zwRPF4IsUeP1xmSc4Is+KoFD
C6twAeggysiTS10Uu44GxMY5FDqblrVxLEv+Ynl7G+Qar1tEFCY2hNO3g9TOV5m5
8Un3Sd3JoLbYJaue0MHMiB0EFSEjicaUEW8piESIez9rD7tchSbLxSQj2rB+ahkC
1CflBCJ+6cG0TPI7AlB2orO2UiTTZQoe4DHsbHtMQigZ9UzE11Te7vamOSQzrlAj
xAt4feEWwmx1ZGLMV8/a6Xe+HechqSzbHc4+W7OYGPwDbseToRaP3NdQgNsn54Ge
oUHcRSsK4IokJFtIKyYc8hO59dRjKg==
=wqQZ
-----END PGP SIGNATURE-----

--qej5eo4xwgqina3a--
