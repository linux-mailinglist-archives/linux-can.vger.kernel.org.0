Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0393B2759
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 08:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFXGZT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Jun 2021 02:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhFXGZT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Jun 2021 02:25:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC9EC061574
        for <linux-can@vger.kernel.org>; Wed, 23 Jun 2021 23:23:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lwIlO-0006Zp-TY; Thu, 24 Jun 2021 08:22:58 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:47f5:be86:773e:3d3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 638236426F9;
        Thu, 24 Jun 2021 06:22:57 +0000 (UTC)
Date:   Thu, 24 Jun 2021 08:22:56 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 1/2] canbusload: count full payload for CANFD frames
Message-ID: <20210624062256.gj6j33fp3gkap7cu@pengutronix.de>
References: <20210624032111.26272-1-dev.kurt@vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="unwezwbzq4dy35di"
Content-Disposition: inline
In-Reply-To: <20210624032111.26272-1-dev.kurt@vandijck-laurijssen.be>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--unwezwbzq4dy35di
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.06.2021 05:21:10, Kurt Van Dijck wrote:
> Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> ---
>  canbusload.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/canbusload.c b/canbusload.c
> index d6bfd78..bd74cb5 100644
> --- a/canbusload.c
> +++ b/canbusload.c
> @@ -237,7 +237,7 @@ int main(int argc, char **argv)
>  	int opt;
>  	char *ptr, *nptr;
>  	struct sockaddr_can addr;
> -	struct can_frame frame;
> +	struct canfd_frame frame;
>  	int nbytes, i;
>  	struct ifreq ifr;
>  	sigset_t sigmask, savesigmask;
> @@ -351,6 +351,9 @@ int main(int argc, char **argv)
>  #ifdef DEBUG
>  		printf("using interface name '%s'.\n", ifr.ifr_name);
>  #endif
> +		/* try to switch the socket into CAN FD mode */
> +		const int canfd_on =3D 1;
> +		setsockopt(s[i], SOL_CAN_RAW, CAN_RAW_FD_FRAMES, &canfd_on, sizeof(can=
fd_on));
> =20
>  		if (ioctl(s[i], SIOCGIFINDEX, &ifr) < 0) {
>  			perror("SIOCGIFINDEX");
> @@ -402,9 +405,9 @@ int main(int argc, char **argv)
>  				}
> =20
>  				stat[i].recv_frames++;
> -				stat[i].recv_bits_payload +=3D frame.can_dlc*8;
> -				stat[i].recv_bits_total +=3D can_frame_length((struct canfd_frame*)&=
frame,
> -									    mode, sizeof(frame));
> +				stat[i].recv_bits_payload +=3D frame.len*8;

nitpick: Please add spaces around the "*", even if these are not in the
original code. Create a github pull request or send a v2 and I'll apply
the patches.

> +				stat[i].recv_bits_total +=3D can_frame_length(&frame,
> +									    mode, nbytes);
>  			}
>  		}
>  	}

regard,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--unwezwbzq4dy35di
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDUJL4ACgkQqclaivrt
76lsgAgAtdOAk5TeXAhHZcSCd269Y0HV76POFOzujn1khpL6ur84B5coQvzqpkkQ
ZYh1TWKIhk/ZB5lzYwsPMlgKtBg4TxS5HEdr6Tl2gdPJwFlYKjSLOsSWnoLWt0Sv
FaeLpgyy7XMM5qGAIzgsmmh4/Wbh8fQQIW80jLnSCSa94r/iKxT85uDiB8USlBkl
U9BP1g/RYGK+JoJypzuMlIJj6EKuiMLbx4Wo2laWsBCHkmipWkEdchRRKwYhpCjJ
6BuvoD1BG2Rz6UpYv/FjMWbmw1DeYpxs9+XaI+JHkZGMjxME1KX0fFAgsQYpFOKc
WvWyCP1pcDrWXDNk8LQmlU0uBVKR/g==
=JQ81
-----END PGP SIGNATURE-----

--unwezwbzq4dy35di--
