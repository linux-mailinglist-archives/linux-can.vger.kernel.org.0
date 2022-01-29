Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFDB4A2FF2
	for <lists+linux-can@lfdr.de>; Sat, 29 Jan 2022 14:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiA2N7L (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 29 Jan 2022 08:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiA2N7K (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 29 Jan 2022 08:59:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F63C061714
        for <linux-can@vger.kernel.org>; Sat, 29 Jan 2022 05:59:10 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nDoFw-0001av-SP; Sat, 29 Jan 2022 14:59:08 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3BFFC2659E;
        Sat, 29 Jan 2022 13:59:08 +0000 (UTC)
Date:   Sat, 29 Jan 2022 14:58:59 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 6/6] can: peak_usb: add ethtool interface to user defined
 flashed device number
Message-ID: <20220129135859.4kxhhtbepgi4ppsf@pengutronix.de>
References: <20220128150157.1222850-1-s.grosjean@peak-system.com>
 <20220128150157.1222850-7-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pnxn3eguo4m6duel"
Content-Disposition: inline
In-Reply-To: <20220128150157.1222850-7-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--pnxn3eguo4m6duel
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.01.2022 16:01:57, Stephane Grosjean wrote:
> This patch introduces 3 new functions implementing support for eeprom
> access of USB - CAN network interfaces managed by the driver, through the
> ethtool interface. All of them (except the PCAN-USB interface) interpret
> the 4 data bytes as a 32-bit value to be read/write in the non-volatile
> memory of the device. The PCAN-USB only manages a single byte value.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb.c      |  9 +++
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c | 69 ++++++++++++++++++++
>  drivers/net/can/usb/peak_usb/pcan_usb_core.h |  6 ++
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c   |  3 +
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  3 +
>  5 files changed, 90 insertions(+)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/us=
b/peak_usb/pcan_usb.c
> index b29daaab2e6e..60c9329701a5 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -981,8 +981,17 @@ static int pcan_usb_set_phys_id(struct net_device *n=
etdev,
>  	return err;
>  }
> =20
> +/* This device only handles 8-bit user device id. */
> +static int pcan_usb_get_eeprom_len(struct net_device *netdev)
> +{
> +	return sizeof(u8);
> +}
> +
>  static const struct ethtool_ops pcan_usb_ethtool_ops =3D {
>  	.set_phys_id =3D pcan_usb_set_phys_id,
> +	.get_eeprom_len	=3D pcan_usb_get_eeprom_len,
> +	.get_eeprom =3D peak_usb_get_eeprom,
> +	.set_eeprom =3D peak_usb_set_eeprom,
>  };
> =20
>  /*
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_core.c
> index aa8bcdcfa2fb..4e858d592e59 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -782,6 +782,75 @@ static const struct net_device_ops peak_usb_netdev_o=
ps =3D {
>  	.ndo_change_mtu =3D can_change_mtu,
>  };
> =20
> +/* CAN-USB devices generally handle 32-bit user device id.
> + * In case one doesn't, then it have to overload this function.
> + */
> +int peak_usb_get_eeprom_len(struct net_device *netdev)
> +{
> +	return sizeof(u32);
> +}
> +
> +/* Every CAN-USB device exports the dev_get_user_devid() operation. It i=
s used
> + * here to fill the data buffer with the user defined device number.
> + */
> +int peak_usb_get_eeprom(struct net_device *netdev,
> +			struct ethtool_eeprom *eeprom, u8 *data)
> +{
> +	struct peak_usb_device *dev =3D netdev_priv(netdev);
> +	u32 devid;
> +	int err;
> +
> +	if (!eeprom->len)
> +		return -EINVAL;

There already is a check for len =3D=3D 0.

> +	err =3D dev->adapter->dev_get_user_devid(dev, &devid);
> +	if (!err) {

Please return on error.

> +		memcpy(data, (u8 *)&devid + eeprom->offset, eeprom->len);

cast not needed.
> +
> +		/* update cached value */
> +		dev->device_number =3D devid;
> +	}
> +
> +	return err;
> +}
> +
> +/* Every CAN-USB device exports the dev_get_user_devid()/dev_set_user_de=
vid()
> + * operations. They are used here to set the new user defined device num=
ber.
> + */
> +int peak_usb_set_eeprom(struct net_device *netdev,
> +			struct ethtool_eeprom *eeprom, u8 *data)
> +{
> +	struct peak_usb_device *dev =3D netdev_priv(netdev);
> +	u32 devid;
> +	int err;
> +
> +	if (!eeprom->len)
> +		return -EINVAL;

There already is a check for len =3D=3D 0.

> +
> +	/* first, read the current user defined device value number */
> +	err =3D dev->adapter->dev_get_user_devid(dev, &devid);
> +	if (err) {
> +		netdev_err(netdev, "Failed to init device id (err %d)\n", err);
> +		return err;
> +	}
> +
> +	/* do update the value with user given bytes */
> +	memcpy((u8 *)&devid + eeprom->offset, data, eeprom->len);

cast not needed.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--pnxn3eguo4m6duel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmH1SCEACgkQqclaivrt
76mafQgAnlZTLvmEmorzBZByQ6KNNBYkKzi+JwcGQkH0XZVi0O76Ce0hd+zNiGnJ
CTLByeY9xHbFi5N7mJEDqZLrmR0RcZOjcl5WcwAFnYUCZhmkfdwYQYhxlOROtu/E
tGiZ7mZnDSCgV0hvn0lPxcdnn1+2k3061It4u/vlv/r5Kx53qQmdzayx/K1HwDeZ
dh83jZBH6uXJH/t1/H7ywDQzn3HNWGfmvRWbualIBzSiZFhdHSOPZePh5nUNTY/X
VSAqr1qrdbDZNNHycZzBYG/AymmCo1TENgWLLHZ+LDWK+jUIZi81hCiOGXYxkz3r
4xJNagg1tTqy8nq9jHSAfu/SJHy+qg==
=2oex
-----END PGP SIGNATURE-----

--pnxn3eguo4m6duel--
