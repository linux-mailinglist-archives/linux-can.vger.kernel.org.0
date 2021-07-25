Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAE23D4CF4
	for <lists+linux-can@lfdr.de>; Sun, 25 Jul 2021 11:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhGYJCW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Jul 2021 05:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhGYJCW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Jul 2021 05:02:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965F2C061757
        for <linux-can@vger.kernel.org>; Sun, 25 Jul 2021 02:42:52 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m7aen-0006Gp-5t; Sun, 25 Jul 2021 11:42:49 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6671:797e:8cf2:7596])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id DDA8165752A;
        Sun, 25 Jul 2021 09:42:47 +0000 (UTC)
Date:   Sun, 25 Jul 2021 11:42:46 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Yasushi SHOJI <yasushi.shoji@gmail.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcba_usb: fix memory leak in mcba_usb
Message-ID: <20210725094246.pkdpvl5aaaftur3a@pengutronix.de>
References: <CAELBRW+6BGDPaUGrTDJtv020zF1AvtBAy2Jb1+i=uDbcH+0SzA@mail.gmail.com>
 <20210725111242.2d9a819f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7fu3qjfk3ukefn35"
Content-Disposition: inline
In-Reply-To: <20210725111242.2d9a819f@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--7fu3qjfk3ukefn35
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.07.2021 11:12:42, Pavel Skripkin wrote:
> Can You try the following patch?

Can you create a proper patch with you S-o-b?

> diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_us=
b.c
> index a45865bd7254..a1a154c08b7f 100644
> --- a/drivers/net/can/usb/mcba_usb.c
> +++ b/drivers/net/can/usb/mcba_usb.c
> @@ -653,6 +653,8 @@ static int mcba_usb_start(struct mcba_priv *priv)
>  			break;
>  		}
> =20
> +		urb->transfer_dma =3D buf_dma;
> +
>  		usb_fill_bulk_urb(urb, priv->udev,
>  				  usb_rcvbulkpipe(priv->udev, MCBA_USB_EP_IN),
>  				  buf, MCBA_USB_RX_BUFF_SIZE,
>=20
>=20
>=20
> I've added Marc to this discussion, I believe, he can help us, since he
> is CAN maintainer.

Yasushi, please test and post your Tested-by here. After Pavel posts a
proper patch and you tested it, I'll forward it to net/master, then it
will be applied to the stable kernels. Debian can even pick up the patch
earlier.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--7fu3qjfk3ukefn35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmD9MhQACgkQqclaivrt
76nwugf/QcwCeZpkFGw8tMuqf1CTOtBR3vjnOSVDg8clyR1DpnRX3IKm6vxRF+oT
9Pg3pOaV7F4/Gl2JPRoKhyYUfnRlQ6NyLezNnfaOIG4uiW8MdAaXCLGxk3eDKB7K
YbkzBc+IYFKbtVJWYrRxBv9zxZSUKVXuU57M5yG7+Mjw1irY0GW1yzyuZSSKly+t
3cbZYpCVyELhhE3EcY2hxZN+pfEMBEkERVqK+JTCFsmJbsLvg9aWH+Zxu+OVBHhH
i7SKZh5qzIQP3qk5/lNpv/wCLPKRlg1jGutFp2sY3YJC5cIQ1ckAdDWquM8mAtai
FORiasOPifWHKAmiJxS5Za1t4vDg5w==
=P8Y3
-----END PGP SIGNATURE-----

--7fu3qjfk3ukefn35--
