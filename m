Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EEA3CB530
	for <lists+linux-can@lfdr.de>; Fri, 16 Jul 2021 11:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhGPJWm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Jul 2021 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhGPJWm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Jul 2021 05:22:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA90C06175F
        for <linux-can@vger.kernel.org>; Fri, 16 Jul 2021 02:19:47 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m4K0Y-0004Bm-53; Fri, 16 Jul 2021 11:19:46 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:df95:c0e5:d620:3bac])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 99D886508D4;
        Fri, 16 Jul 2021 09:19:44 +0000 (UTC)
Date:   Fri, 16 Jul 2021 11:19:43 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] can: peak_usb: Add a "firmware update available"
 msg to old PCAN-USB
Message-ID: <20210716091943.ilvws7dxpthbhmjl@pengutronix.de>
References: <20210715142842.35793-1-s.grosjean@peak-system.com>
 <20210715142842.35793-2-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5ovmzxwp77d6m737"
Content-Disposition: inline
In-Reply-To: <20210715142842.35793-2-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--5ovmzxwp77d6m737
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.07.2021 16:28:42, Stephane Grosjean wrote:
> When the driver detects that the PCAN-USB device runs an old firmware
> (< 4.1) then it prints a message suggesting to contact
> <support@peak-system.com> for a possible firmware update.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/us=
b/peak_usb/pcan_usb.c
> index 3af3136645ac..cb492584fdb0 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -850,6 +850,19 @@ static int pcan_usb_init(struct peak_usb_device *dev)
>  		 pcan_usb.name, dev->device_rev, serial_number,
>  		 pcan_usb.ctrl_count);
> =20
> +	/* Since rev 4.1, PCAN-USB is able to make single-short as well as
                                                             ^

Fixed typo while applying.

> +	 * looped back frames.
> +	 */
> +	if (dev->device_rev >=3D 41) {
> +		struct can_priv *priv =3D netdev_priv(dev->netdev);
> +
> +		priv->ctrlmode_supported |=3D CAN_CTRLMODE_ONE_SHOT |
> +					    CAN_CTRLMODE_LOOPBACK;
> +	} else {
> +		dev_info(dev->netdev->dev.parent,
> +			 "Firmware update available. Please contact support@peak-system.com\n=
");
> +	}
> +
>  	return 0;
>  }

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5ovmzxwp77d6m737
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDxTywACgkQqclaivrt
76mFRwf/eAxC922RMe20Hu9WYQvGi2cgi1mVekLSZq3nBwDZTX+QHHbmEZvW4juU
hvkRxIsjztb2E1PRTitS222cygF5r92P0gMIMPhqaxV//I45KxEbDzrXrEJnrt4U
wM2BzNWeygPJQbRCcQOlxjanYQrAuHghOPDDQAmANldjM0pIujcFUd/idKWf3dEO
LLngJzKTDfbax7M+v8utf3wtbnBcGVp/UCxNv4jRa5iUr8j0GOds5ELsPL3R+tBh
wJigCzUDxVUxLhR2gUe6IzhU+NWNzXeoXGSDH9nw4aHXsLIfnMGNSFGCZNrLF5+9
jWc/vNYX6wFILdp16mW1SMLwjehDMg==
=8QQT
-----END PGP SIGNATURE-----

--5ovmzxwp77d6m737--
