Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AC12A9AF7
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgKFRf4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgKFRf4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:35:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C09C0613CF
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 09:35:55 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kb5eT-00060n-Uq; Fri, 06 Nov 2020 18:35:54 +0100
Received: from [IPv6:2a03:f580:87bc:d400:33f0:799f:c05f:fe06] (unknown [IPv6:2a03:f580:87bc:d400:33f0:799f:c05f:fe06])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E360D58C69D;
        Fri,  6 Nov 2020 17:35:52 +0000 (UTC)
Subject: Re: [PATCH 11/17] can: ems_usb: Added ems_usb_write_mode_fd and its
 call in device probe routine. Fixed indentation.
To:     Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        linux-can@vger.kernel.org
Cc:     wg@grandegger.com
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
 <20201106170206.32162-12-uttenthaler@ems-wuensche.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <13fcdd2a-8532-6d8c-166c-148f84ab6a82@pengutronix.de>
Date:   Fri, 6 Nov 2020 18:35:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106170206.32162-12-uttenthaler@ems-wuensche.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ueHU00nVlmIijLCjxrWrhYqmBYaeZihlT"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ueHU00nVlmIijLCjxrWrhYqmBYaeZihlT
Content-Type: multipart/mixed; boundary="XTIXyfkxiz379PT8OQLVWoKI1doKUV8LQ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
 linux-can@vger.kernel.org
Cc: wg@grandegger.com
Message-ID: <13fcdd2a-8532-6d8c-166c-148f84ab6a82@pengutronix.de>
Subject: Re: [PATCH 11/17] can: ems_usb: Added ems_usb_write_mode_fd and its
 call in device probe routine. Fixed indentation.
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
 <20201106170206.32162-12-uttenthaler@ems-wuensche.com>
In-Reply-To: <20201106170206.32162-12-uttenthaler@ems-wuensche.com>

--XTIXyfkxiz379PT8OQLVWoKI1doKUV8LQ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

As mentioned in the other patch, please fix the indention where you intro=
duce
the switch-case

On 11/6/20 6:02 PM, Gerhard Uttenthaler wrote:
> Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
> ---
>  drivers/net/can/usb/ems_usb.c | 49 +++++++++++++++++++++++++++--------=

>  1 file changed, 38 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_us=
b.c
> index a4d9a1b2d2f0..b51a5eb65946 100644
> --- a/drivers/net/can/usb/ems_usb.c
> +++ b/drivers/net/can/usb/ems_usb.c
> @@ -683,6 +683,32 @@ static int ems_usb_write_mode_arm7(struct ems_usb =
*dev, u32 mode)
>  	return ems_usb_command_msg(dev, &dev->active_params);
>  }
> =20
> +static int ems_usb_write_mode_fd(struct ems_usb *dev, u32 mode)
> +{
> +	struct cpc_generic_can_params *gcp =3D
> +		&dev->active_params.msg.can_params.cc_params.generic;
> +
> +	if (mode =3D=3D CPC_USB_RESET_MODE) {
> +		gcp->config |=3D CPC_GENERICCONF_RESET_MODE;
> +	} else if (mode =3D=3D CPC_USB_RUN_MODE) {
> +		gcp->config &=3D ~CPC_GENERICCONF_RESET_MODE;
> +
> +		if (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +			gcp->config |=3D CPC_GENERICCONF_LISTEN_ONLY;
> +		else
> +			gcp->config &=3D ~CPC_GENERICCONF_LISTEN_ONLY;
> +
> +		if (dev->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> +			gcp->config |=3D CPC_GENERICCONF_SINGLE_SHOT;
> +		else
> +			gcp->config &=3D ~CPC_GENERICCONF_SINGLE_SHOT;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return ems_usb_command_msg(dev, &dev->active_params);
> +}
> +
>  /* Send a CPC_Control command to change behaviour when interface recei=
ves a CAN
>   * message, bus error or CAN state changed notifications.
>   */
> @@ -1241,17 +1267,16 @@ static int ems_usb_probe(struct usb_interface *=
intf,
>  	/* Select CPC-USB/ARM7 or CPC-USB/FD */
>  	switch (dev->udev->descriptor.idProduct) {
>  	case USB_CPCUSB_ARM7_PRODUCT_ID:
> -
> -	dev->can.clock.freq =3D EMS_USB_ARM7_CLOCK;
> -	dev->can.bittiming_const =3D &ems_usb_bittiming_const_arm7;
> -	dev->can.do_set_bittiming =3D ems_usb_set_bittiming_arm7;
> -	dev->can.do_set_mode =3D ems_usb_set_mode;
> -	dev->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES |
> +		dev->can.clock.freq =3D EMS_USB_ARM7_CLOCK;
> +		dev->can.bittiming_const =3D &ems_usb_bittiming_const_arm7;
> +		dev->can.do_set_bittiming =3D ems_usb_set_bittiming_arm7;
> +		dev->can.do_set_mode =3D ems_usb_set_mode;
> +		dev->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES |
>  				      CAN_CTRLMODE_LISTENONLY;
> -	init_params_sja1000(&dev->active_params);
> -	dev->ems_usb_write_mode =3D ems_usb_write_mode_arm7;
> -	dev->bulk_rd_buf_size =3D 64;
> -	break;
> +		init_params_sja1000(&dev->active_params);
> +		dev->ems_usb_write_mode =3D ems_usb_write_mode_arm7;
> +		dev->bulk_rd_buf_size =3D 64;
> +		break;
> =20
>  	case USB_CPCUSB_FD_PRODUCT_ID:
>  		dev->can.clock.freq =3D EMS_USB_FD_CLOCK;
> @@ -1259,14 +1284,16 @@ static int ems_usb_probe(struct usb_interface *=
intf,
>  		dev->can.data_bittiming_const =3D &ems_usb_bittiming_const_generic_d=
ata;
>  		dev->can.do_set_bittiming =3D ems_usb_set_bittiming_generic;
>  		dev->can.do_set_data_bittiming =3D ems_usb_set_bittiming_generic_dat=
a;
> +		dev->can.do_set_mode =3D ems_usb_set_mode;
>  		dev->can.ctrlmode_supported =3D CAN_CTRLMODE_LISTENONLY |
>  				CAN_CTRLMODE_ONE_SHOT |
>  				CAN_CTRLMODE_BERR_REPORTING |
>  				CAN_CTRLMODE_FD |
>  				CAN_CTRLMODE_FD_NON_ISO;
>  		init_params_generic(&dev->active_params);
> +		dev->ems_usb_write_mode =3D ems_usb_write_mode_fd;
>  		dev->bulk_rd_buf_size =3D 512;
> -	break;
> +		break;
> =20
>  	default:
>  		err =3D -ENODEV;
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--XTIXyfkxiz379PT8OQLVWoKI1doKUV8LQ--

--ueHU00nVlmIijLCjxrWrhYqmBYaeZihlT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+liXQACgkQqclaivrt
76leCAf+IsMLh9A2fyTKR2L+Cxj/kkyHpuCZcZUrTg0UYIPfDsraPppprgqf5C0S
w2zYEBi1Hv1NzPtNBLm3hWYyoVrde0YmPo50FlYhMs7TuqJQ9bJB+HDzUaVmWwYa
+jlJH0rN0CGB8xLo1ezFKE6caVR1uO7yAa5gfHr79ChFYO1Ts8a+WZbi1+zuZX3Q
up2oRDZBZF7GAtiPTjq8DQO+aeWJl4jhnAgC2BddZVp3F1EaUV+09Gb4OZRU/YrT
MxZ7TX8dIOi+xKcEv9jtk2TbFORUn8VA77isatcYqix3empuIjKu6UiYrnOld9St
mM84JRK7dW8paU40x4f04XGDCCPCzw==
=J74Y
-----END PGP SIGNATURE-----

--ueHU00nVlmIijLCjxrWrhYqmBYaeZihlT--
