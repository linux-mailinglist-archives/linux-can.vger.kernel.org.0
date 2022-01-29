Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC5C4A2FE7
	for <lists+linux-can@lfdr.de>; Sat, 29 Jan 2022 14:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243176AbiA2Nxd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 29 Jan 2022 08:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiA2Nxd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 29 Jan 2022 08:53:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE6BC061714
        for <linux-can@vger.kernel.org>; Sat, 29 Jan 2022 05:53:33 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nDoAV-0001At-N5; Sat, 29 Jan 2022 14:53:31 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id F05B02659A;
        Sat, 29 Jan 2022 13:53:30 +0000 (UTC)
Date:   Sat, 29 Jan 2022 14:53:25 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 4/6] can: peak_usb: allow flashing of user defined value
Message-ID: <20220129135325.y6bpevypigllusw2@pengutronix.de>
References: <20220128150157.1222850-1-s.grosjean@peak-system.com>
 <20220128150157.1222850-5-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pklymfzp5i3mdwfz"
Content-Disposition: inline
In-Reply-To: <20220128150157.1222850-5-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--pklymfzp5i3mdwfz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.01.2022 16:01:55, Stephane Grosjean wrote:
> This series of patches adds a callback that allows the user to flash a
> self-defined value to all USB - CAN/CANFD interfaces of PEAK-System manag=
ed
> by this driver, namely:
> - PCAN-USB
> - PCAN-USB FD
> - PCAN-USB Pro FD
> - PCAN-USB X6
> - PCAN-Chip USB
> - PCAN-USB Pro
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb.c      | 20 +++++++++++++++
>  drivers/net/can/usb/peak_usb/pcan_usb_core.h |  1 +
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 26 ++++++++++++++++++++
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 15 +++++++++++
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |  1 +
>  5 files changed, 63 insertions(+)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/us=
b/peak_usb/pcan_usb.c
> index 954abf43d552..b29daaab2e6e 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -398,6 +398,25 @@ static int pcan_usb_get_user_devid(struct peak_usb_d=
evice *dev, u32 *device_id)
>  	return err;
>  }
> =20
> +/* set a new user device id in the flash memory of the device */
> +static int pcan_usb_set_user_devid(struct peak_usb_device *dev, u32 devi=
d)
> +{
> +	u8 args[PCAN_USB_CMD_ARGS_LEN];
> +
> +	/* this kind of device supports 8-bit values only */
> +	if (devid > 255)
> +		return -EINVAL;

please use U8_MAX.

> +
> +	/* during the flash process the device disconnects during ~1.25 s.:
> +	 * prohibit access when interface is UP
> +	 */
> +	if (dev->netdev->flags & IFF_UP)
> +		return -EBUSY;
> +
> +	args[0] =3D (u8)devid;

cast not needed.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--pklymfzp5i3mdwfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmH1RtMACgkQqclaivrt
76klUwf/Yakfso1AS6J8okQmq06/kAmtPyV1KrsnTEIue/U6E6Tb+YYtWJe1LsCM
wwv1ld4/T5EGHyq47fIVdjthxltJNGjxqqSKEftz12d6AfyvwQepAwYlIEySZdtO
d5g5tsgHZcla1XS5Ik8KdcNhps3dkiY357GL12fIP+j2pftnorwzWwHKUAxkD+wP
+8qUxszKpS9VWSBXtbNqnGnijMYcdwmzKbeL3S7DAeo2YfPSNhRcCTOGr2KjRocx
/qUpIlykeaIEGqcvQny4n+X+w+elCoRgfXcAZgG+ZOTsOFeC1clQ91ertE1u2LOP
sYuRJbdGN2Ecgzrwrj0tkgGUECa4CQ==
=2kyy
-----END PGP SIGNATURE-----

--pklymfzp5i3mdwfz--
