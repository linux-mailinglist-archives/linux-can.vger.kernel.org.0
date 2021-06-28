Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4E03B594C
	for <lists+linux-can@lfdr.de>; Mon, 28 Jun 2021 08:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhF1G5Q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Jun 2021 02:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhF1G5Q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 02:57:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D9FC061574
        for <linux-can@vger.kernel.org>; Sun, 27 Jun 2021 23:54:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lxlAP-000572-JN; Mon, 28 Jun 2021 08:54:49 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:5559:217e:8326:2717])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BCBA2644A55;
        Mon, 28 Jun 2021 06:54:48 +0000 (UTC)
Date:   Mon, 28 Jun 2021 08:54:47 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 5/5] can: peak_usb: upgrades the handling of bus state
 changes
Message-ID: <20210628065447.aumi2pkfton35gcj@pengutronix.de>
References: <20210625130931.27438-1-s.grosjean@peak-system.com>
 <20210625130931.27438-6-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pwyhxx6obaxjqwwr"
Content-Disposition: inline
In-Reply-To: <20210625130931.27438-6-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--pwyhxx6obaxjqwwr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.06.2021 15:09:31, Stephane Grosjean wrote:
> This patch updates old code by using the functions published since by the
> socket-can module. In particular, this new code better manages the change
> of bus state by also using the value of the error counters that the driver
> now systematically asks for when initializing the channel.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb.c | 169 ++++++------------------
>  1 file changed, 41 insertions(+), 128 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/us=
b/peak_usb/pcan_usb.c
> index 7d18bc6911f5..1ab3be8dbb83 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -453,146 +453,59 @@ static int pcan_usb_decode_error(struct pcan_usb_m=
sg_context *mc, u8 n,
>  {
>  	struct sk_buff *skb;
>  	struct can_frame *cf;
> -	enum can_state new_state;
> +	enum can_state new_state =3D CAN_STATE_ERROR_ACTIVE;
> =20
>  	/* ignore this error until 1st ts received */
>  	if (n =3D=3D PCAN_USB_ERROR_QOVR)
>  		if (!mc->pdev->time_ref.tick_count)
>  			return 0;
> =20
> -	new_state =3D mc->pdev->dev.can.state;
> -
> -	switch (mc->pdev->dev.can.state) {
> -	case CAN_STATE_ERROR_ACTIVE:
> -		if (n & PCAN_USB_ERROR_BUS_LIGHT) {
> -			new_state =3D CAN_STATE_ERROR_WARNING;
> -			break;
> -		}
> -		fallthrough;
> -
> -	case CAN_STATE_ERROR_WARNING:
> -		if (n & PCAN_USB_ERROR_BUS_HEAVY) {
> -			new_state =3D CAN_STATE_ERROR_PASSIVE;
> -			break;
> -		}
> -		if (n & PCAN_USB_ERROR_BUS_OFF) {
> -			new_state =3D CAN_STATE_BUS_OFF;
> -			break;
> -		}
> -		if (n & ~PCAN_USB_ERROR_BUS) {
> -			/*
> -			 * trick to bypass next comparison and process other
> -			 * errors
> -			 */
> -			new_state =3D CAN_STATE_MAX;
> -			break;
> -		}
> -		if ((n & PCAN_USB_ERROR_BUS_LIGHT) =3D=3D 0) {
> -			/* no error (back to active state) */
> -			new_state =3D CAN_STATE_ERROR_ACTIVE;
> -			break;
> -		}
> -		break;
> -
> -	case CAN_STATE_ERROR_PASSIVE:
> -		if (n & PCAN_USB_ERROR_BUS_OFF) {
> -			new_state =3D CAN_STATE_BUS_OFF;
> -			break;
> -		}
> -		if (n & PCAN_USB_ERROR_BUS_LIGHT) {
> -			new_state =3D CAN_STATE_ERROR_WARNING;
> -			break;
> -		}
> -		if (n & ~PCAN_USB_ERROR_BUS) {
> -			/*
> -			 * trick to bypass next comparison and process other
> -			 * errors
> -			 */
> -			new_state =3D CAN_STATE_MAX;
> -			break;
> -		}
> -
> -		if ((n & PCAN_USB_ERROR_BUS_HEAVY) =3D=3D 0) {
> -			/* no error (back to warning state) */
> -			new_state =3D CAN_STATE_ERROR_WARNING;
> -			break;
> -		}
> -		break;
> -
> -	default:
> -		/* do nothing waiting for restart */
> +	if (n & PCAN_USB_ERROR_TXQFULL) {
> +		netdev_dbg(mc->netdev, "device Tx queue full)\n");
>  		return 0;
>  	}
> =20
> -	/* donot post any error if current state didn't change */
> -	if (mc->pdev->dev.can.state =3D=3D new_state)
> -		return 0;
> -
>  	/* allocate an skb to store the error frame */
>  	skb =3D alloc_can_err_skb(mc->netdev, &cf);

Please update the driver, to do the statistics and state update, even if
the allocation of the skb fails.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--pwyhxx6obaxjqwwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDZcjUACgkQqclaivrt
76nOggf+PCPhrpUav62qgJvZjPWB4P+b2Q7EdcUaitVvbQi1Tp5olNvlg/pl8r7K
VxJGrN6g+DpSi0Xa2d+DvFoJEvB2gL0D6fMgWT/33oGv1g3dB2m41WY7JXU6hgx6
4UH91c+niWeOh6ftd1EdilCmpxeZ5ipgnT9scPKDj3i23zmLRSPLyijye/C+QJtx
iVYkmW7FeYl6o+Bx2WlY3u8y6+vgLmAo+4lURFm6D/EXfKm2fhmERsxn11VAEwzl
SmiYS0rNLFyJlLZ/StSrxF85H+NcHCcu9/YdoIoVLJV1WeY9t3IYvetqzV3vO/W9
/hdj6IA48NyR4jHtDKbLsOIafmCBng==
=17oY
-----END PGP SIGNATURE-----

--pwyhxx6obaxjqwwr--
