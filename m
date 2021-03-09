Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A00933252F
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 13:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhCIMQF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 07:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCIMPe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 07:15:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34B4C06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 04:15:33 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJbGu-0005Ig-7O; Tue, 09 Mar 2021 13:15:32 +0100
Received: from [IPv6:2a03:f580:87bc:d400:4699:faa8:8510:ac25] (unknown [IPv6:2a03:f580:87bc:d400:4699:faa8:8510:ac25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 160BD5F179B;
        Tue,  9 Mar 2021 12:15:30 +0000 (UTC)
Subject: Re: [PATCH 1/3] can/peak_usb: add support of ethtool set_phys_id()
To:     Stephane Grosjean <s.grosjean@peak-system.com>,
        linux-can Mailing List <linux-can@vger.kernel.org>
References: <20210309082128.23125-1-s.grosjean@peak-system.com>
 <20210309082128.23125-2-s.grosjean@peak-system.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bf2f6330-2f28-54ba-7025-55828f916074@pengutronix.de>
Date:   Tue, 9 Mar 2021 13:15:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210309082128.23125-2-s.grosjean@peak-system.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3XvzNU6AOrFMbjMYUlS2OBckERU3xbUqM"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3XvzNU6AOrFMbjMYUlS2OBckERU3xbUqM
Content-Type: multipart/mixed; boundary="VfX54hJTkie2EATS8Wt8ajo6pXJBq9BbN";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <bf2f6330-2f28-54ba-7025-55828f916074@pengutronix.de>
Subject: Re: [PATCH 1/3] can/peak_usb: add support of ethtool set_phys_id()
References: <20210309082128.23125-1-s.grosjean@peak-system.com>
 <20210309082128.23125-2-s.grosjean@peak-system.com>
In-Reply-To: <20210309082128.23125-2-s.grosjean@peak-system.com>

--VfX54hJTkie2EATS8Wt8ajo6pXJBq9BbN
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 3/9/21 9:21 AM, Stephane Grosjean wrote:
> This patch makes it possible to specifically flash the LED of a CAN por=
t
> of the CAN-USB interfaces of PEAK-System.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb.c      | 47 ++++++++++++++++++++=

>  drivers/net/can/usb/peak_usb/pcan_usb_core.c |  4 ++
>  drivers/net/can/usb/peak_usb/pcan_usb_core.h |  2 +
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 33 ++++++++++++++
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 34 +++++++++++++-
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |  6 +++
>  6 files changed, 125 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/=
usb/peak_usb/pcan_usb.c
> index e6c1e5d33924..aa89c1119e27 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -11,6 +11,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/usb.h>
>  #include <linux/module.h>
> +#include <linux/ethtool.h>
> =20
>  #include <linux/can.h>
>  #include <linux/can/dev.h>
> @@ -42,6 +43,7 @@ MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB adapter=
");
>  #define PCAN_USB_CMD_REGISTER	9
>  #define PCAN_USB_CMD_EXT_VCC	10
>  #define PCAN_USB_CMD_ERR_FR	11
> +#define PCAN_USB_CMD_LED	12
> =20
>  /* PCAN_USB_CMD_SET_BUS number arg */
>  #define PCAN_USB_BUS_XCVER		2
> @@ -250,6 +252,15 @@ static int pcan_usb_set_ext_vcc(struct peak_usb_de=
vice *dev, u8 onoff)
>  	return pcan_usb_send_cmd(dev, PCAN_USB_CMD_EXT_VCC, PCAN_USB_SET, arg=
s);
>  }
> =20
> +static int pcan_usb_set_led(struct peak_usb_device *dev, u8 onoff)
> +{
> +	u8 args[PCAN_USB_CMD_ARGS_LEN] =3D {
> +		[0] =3D !!onoff,
> +	};
> +
> +	return pcan_usb_send_cmd(dev, PCAN_USB_CMD_LED, PCAN_USB_SET, args);
> +}
> +
>  /*
>   * set bittiming value to can
>   */
> @@ -973,6 +984,40 @@ static int pcan_usb_probe(struct usb_interface *in=
tf)
>  	return 0;
>  }
> =20
> +static int pcan_usb_set_phys_id(struct net_device *netdev,
> +				enum ethtool_phys_id_state state)
> +{
> +	struct peak_usb_device *dev =3D netdev_priv(netdev);
> +	int err =3D 0;
> +
> +	switch (state) {
> +	case ETHTOOL_ID_ACTIVE:
> +		/* call ON/OFF twice a second */
> +		return 2;
> +
> +	case ETHTOOL_ID_OFF:
> +		err =3D pcan_usb_set_led(dev, 0);
> +		break;
> +
> +	case ETHTOOL_ID_ON:
> +		fallthrough;
> +
> +	case ETHTOOL_ID_INACTIVE:
> +		/* restore LED default */
> +		err =3D pcan_usb_set_led(dev, 1);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return err;
> +}
> +
> +static const struct ethtool_ops pcan_usb_ethtool_ops =3D {
> +	.set_phys_id =3D pcan_usb_set_phys_id,
> +};
> +
>  /*
>   * describe the PCAN-USB adapter
>   */
> @@ -1003,6 +1048,8 @@ const struct peak_usb_adapter pcan_usb =3D {
>  	/* size of device private data */
>  	.sizeof_dev_private =3D sizeof(struct pcan_usb),
> =20
> +	.ethtool_ops =3D &pcan_usb_ethtool_ops,
> +
>  	/* timestamps usage */
>  	.ts_used_bits =3D 16,
>  	.ts_period =3D 24575, /* calibration period in ts. */
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net=
/can/usb/peak_usb/pcan_usb_core.c
> index 573b11559d73..685c59e2cfd3 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -14,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
>  #include <linux/usb.h>
> +#include <linux/ethtool.h>
> =20
>  #include <linux/can.h>
>  #include <linux/can/dev.h>
> @@ -820,6 +821,9 @@ static int peak_usb_create_dev(const struct peak_us=
b_adapter *peak_usb_adapter,
> =20
>  	netdev->flags |=3D IFF_ECHO; /* we support local echo */
> =20
> +	/* add ethtool support */
> +	netdev->ethtool_ops =3D peak_usb_adapter->ethtool_ops;
> +
>  	init_usb_anchor(&dev->rx_submitted);
> =20
>  	init_usb_anchor(&dev->tx_submitted);
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net=
/can/usb/peak_usb/pcan_usb_core.h
> index 4b1528a42a7b..e15b4c78f309 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
> @@ -46,6 +46,8 @@ struct peak_usb_adapter {
>  	const struct can_bittiming_const * const data_bittiming_const;
>  	unsigned int ctrl_count;
> =20
> +	const struct ethtool_ops *ethtool_ops;
> +
>  	int (*intf_probe)(struct usb_interface *intf);
> =20
>  	int (*dev_init)(struct peak_usb_device *dev);
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_fd.c
> index f347ecc79aef..6183a42f6491 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -7,6 +7,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/usb.h>
>  #include <linux/module.h>
> +#include <linux/ethtool.h>
> =20
>  #include <linux/can.h>
>  #include <linux/can/dev.h>
> @@ -1009,6 +1010,31 @@ static void pcan_usb_fd_free(struct peak_usb_dev=
ice *dev)
>  	}
>  }
> =20
> +/* blink LED's */
> +static int pcan_usb_fd_set_phys_id(struct net_device *netdev,
> +				   enum ethtool_phys_id_state state)
> +{
> +	struct peak_usb_device *dev =3D netdev_priv(netdev);
> +	int err =3D 0;
> +
> +	switch (state) {
> +	case ETHTOOL_ID_ACTIVE:
> +		err =3D pcan_usb_fd_set_can_led(dev, PCAN_UFD_LED_FAST);
> +		break;
> +	case ETHTOOL_ID_INACTIVE:
> +		err =3D pcan_usb_fd_set_can_led(dev, PCAN_UFD_LED_DEF);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return err;
> +}
> +
> +static const struct ethtool_ops pcan_usb_fd_ethtool_ops =3D {
> +	.set_phys_id =3D pcan_usb_fd_set_phys_id,
> +};
> +
>  /* describes the PCAN-USB FD adapter */
>  static const struct can_bittiming_const pcan_usb_fd_const =3D {
>  	.name =3D "pcan_usb_fd",
> @@ -1050,6 +1076,8 @@ const struct peak_usb_adapter pcan_usb_fd =3D {
>  	/* size of device private data */
>  	.sizeof_dev_private =3D sizeof(struct pcan_usb_fd_device),
> =20
> +	.ethtool_ops =3D &pcan_usb_fd_ethtool_ops,
> +
>  	/* timestamps usage */
>  	.ts_used_bits =3D 32,
>  	.ts_period =3D 1000000, /* calibration period in ts. */
> @@ -1122,6 +1150,7 @@ const struct peak_usb_adapter pcan_usb_chip =3D {=

> =20
>  	/* size of device private data */
>  	.sizeof_dev_private =3D sizeof(struct pcan_usb_fd_device),
> +	.ethtool_ops =3D &pcan_usb_fd_ethtool_ops,
> =20
>  	/* timestamps usage */
>  	.ts_used_bits =3D 32,
> @@ -1196,6 +1225,8 @@ const struct peak_usb_adapter pcan_usb_pro_fd =3D=
 {
>  	/* size of device private data */
>  	.sizeof_dev_private =3D sizeof(struct pcan_usb_fd_device),
> =20
> +	.ethtool_ops =3D &pcan_usb_fd_ethtool_ops,
> +
>  	/* timestamps usage */
>  	.ts_used_bits =3D 32,
>  	.ts_period =3D 1000000, /* calibration period in ts. */
> @@ -1269,6 +1300,8 @@ const struct peak_usb_adapter pcan_usb_x6 =3D {
>  	/* size of device private data */
>  	.sizeof_dev_private =3D sizeof(struct pcan_usb_fd_device),
> =20
> +	.ethtool_ops =3D &pcan_usb_fd_ethtool_ops,
> +
>  	/* timestamps usage */
>  	.ts_used_bits =3D 32,
>  	.ts_period =3D 1000000, /* calibration period in ts. */
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/=
can/usb/peak_usb/pcan_usb_pro.c
> index 275087c39602..ff740b4203fa 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> @@ -9,6 +9,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/usb.h>
>  #include <linux/module.h>
> +#include <linux/ethtool.h>
> =20
>  #include <linux/can.h>
>  #include <linux/can/dev.h>
> @@ -908,7 +909,7 @@ static int pcan_usb_pro_init(struct peak_usb_device=
 *dev)
>  	usb_if->dev[dev->ctrl_idx] =3D dev;
> =20
>  	/* set LED in default state (end of init phase) */
> -	pcan_usb_pro_set_led(dev, 0, 1);
> +	pcan_usb_pro_set_led(dev, FW_USBPRO_LED_DEVICE, 1);
> =20
>  	kfree(bi);
>  	kfree(fi);
> @@ -992,6 +993,35 @@ int pcan_usb_pro_probe(struct usb_interface *intf)=

>  	return 0;
>  }
> =20
> +static int pcan_usb_pro_set_phys_id(struct net_device *netdev,
> +				    enum ethtool_phys_id_state state)
> +{
> +	struct peak_usb_device *dev =3D netdev_priv(netdev);
> +	int err =3D 0;
> +
> +	switch (state) {
> +	case ETHTOOL_ID_ACTIVE:
> +		/* fast blinking forever */
> +		err =3D pcan_usb_pro_set_led(dev, FW_USBPRO_LED_BLINK_FAST,
> +					   0xffffffff);
> +		break;
> +
> +	case ETHTOOL_ID_INACTIVE:
> +		/* restore LED default */
> +		err =3D pcan_usb_pro_set_led(dev, FW_USBPRO_LED_DEVICE, 1);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return err;
> +}
> +
> +static const struct ethtool_ops pcan_usb_pro_ethtool_ops =3D {
> +	.set_phys_id =3D pcan_usb_pro_set_phys_id,
> +};
> +
>  /*
>   * describe the PCAN-USB Pro adapter
>   */
> @@ -1020,6 +1050,8 @@ const struct peak_usb_adapter pcan_usb_pro =3D {
>  	/* size of device private data */
>  	.sizeof_dev_private =3D sizeof(struct pcan_usb_pro_device),
> =20
> +	.ethtool_ops =3D &pcan_usb_pro_ethtool_ops,
> +
>  	/* timestamps usage */
>  	.ts_used_bits =3D 32,
>  	.ts_period =3D 1000000, /* calibration period in ts. */
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/net/=
can/usb/peak_usb/pcan_usb_pro.h
> index 6bb12357d078..421104ee29f4 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
> @@ -115,6 +115,12 @@ struct __packed pcan_usb_pro_devid {
>  	__le32 serial_num;
>  };
> =20
> +#define FW_USBPRO_LED_DEVICE		0x00
> +#define FW_USBPRO_LED_BLINK_FAST	0x01
> +#define FW_USBPRO_LED_BLINK_SLOW	0x02
> +#define FW_USBPRO_LED_ON		0x03
> +#define FW_USBPRO_LED_OFF		0x04

What about replacing the FW_ with PCAN_, so that we're using the same pre=
fix
within the driver? I can do this while applying.

> +
>  struct __packed pcan_usb_pro_setled {
>  	u8  data_type;
>  	u8  channel;
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--VfX54hJTkie2EATS8Wt8ajo6pXJBq9BbN--

--3XvzNU6AOrFMbjMYUlS2OBckERU3xbUqM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBHZt8ACgkQqclaivrt
76nVZgf+MteNMx83EoHMkG8DYTerFhPDmL+KUQxiHPMOEcaYkQgUQ5rFplTdF7Qu
GG/4O+BLjtzXk/Z3tcYbewIf3lz6VAeD6LV12Hh6ztWepAYUNtT3HgGkFnHS9JFC
6XTTCgRgvePEGrh8/aWrcSNc9Cuvpc9f3FqDbuQPpny800L0nnd5MKOuheUU42hL
XKwaEe5+HkOY/mQ6jB1XwyWIYiLPqWm7myta9auVBKBRHzM4LsSBOaFxHzxkagrn
wjfo0dyPfGXAOp2+hk6GBTAd09sMBkc5pS4czt3TQSP/Hscst2FuKYFkZK6u2fVY
ChrqH92qh+Udc1bQZHPGkqcx0+4YZQ==
=JlNZ
-----END PGP SIGNATURE-----

--3XvzNU6AOrFMbjMYUlS2OBckERU3xbUqM--
