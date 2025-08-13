Return-Path: <linux-can+bounces-4225-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06966B24447
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 10:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151ED724230
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 08:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448D22EA48D;
	Wed, 13 Aug 2025 08:26:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A182ED153
	for <linux-can@vger.kernel.org>; Wed, 13 Aug 2025 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073590; cv=none; b=p+sOw71NaftkW5gazLGcisSwknooPX6SCftAB8ci6lumrj9KNtqNbhfDK6M7GaOXb5TGbTB+JtYnYtYCSXu+fEmIViSYpacE0H5T62nT8MGP27sJ97yMOVCGYh+mPN6OQWWWeddj2tzeQLi8gvjbfj+JsAvn5cgpn/y5u71mRoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073590; c=relaxed/simple;
	bh=Jyt7O8njYePsq/MWBoui+u1Z5wQNi/jDmEYIoung8cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq3AGFGcIyEwlETDji3zzFek5VNoMGf796t7RXVY+kXRuUO4PV+jPDBZhv0yhOXfaEW0ELWgps0maCfTgVaFkrw0iHtc7DcdcsqsZiKVYe5dVTHP9AmCG2eA6xw0mYCcPKHhb+YcFASUPW+WIKZJ9dePyw/uAS94kRJsbiY16Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1um6oO-0004aw-CB; Wed, 13 Aug 2025 10:26:20 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1um6oN-0003o7-2n;
	Wed, 13 Aug 2025 10:26:19 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 78E5B4568DB;
	Wed, 13 Aug 2025 08:26:19 +0000 (UTC)
Date: Wed, 13 Aug 2025 10:26:17 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org, socketcan@esd.eu, 
	Simon Horman <horms@kernel.org>, Olivier Sobrie <olivier@sobrie.be>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/6] can: esd_usb: Fix not detecting version reply in
 probe routine
Message-ID: <20250813-just-independent-angelfish-909305-mkl@pengutronix.de>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
 <20250811210611.3233202-3-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e6icoa6tdvh3k65v"
Content-Disposition: inline
In-Reply-To: <20250811210611.3233202-3-stefan.maetje@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--e6icoa6tdvh3k65v
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/6] can: esd_usb: Fix not detecting version reply in
 probe routine
MIME-Version: 1.0

On 11.08.2025 23:06:07, Stefan M=C3=A4tje wrote:
> This patch fixes some problems in the esd_usb_probe routine that render
> the CAN interface unusable.
>=20
> The probe routine sends a version request message to the USB device to
> receive a version reply with the number of CAN ports and the hard-
> & firmware versions. Then for each CAN port a CAN netdev is registered.
>=20
> The previous code assumed that the version reply would be received
> immediately. But if the driver was reloaded without power cycling the
> USB device (i. e. on a reboot) there could already be other incoming
> messages in the USB buffers. These would be in front of the version
> reply and need to be skipped.
>=20
> In the previous code these problems were present:
> - Only one usb_bulk_msg() read was done into a buffer of
>   sizeof(union esd_usb_msg) which is smaller than ESD_USB_RX_BUFFER_SIZE
>   which could lead to an overflow error from the USB stack.
> - The first bytes of the received data were taken without checking for
>   the message type. This could lead to zero detected CAN interfaces.
>=20
> To mitigate these problems:
> - Use a transfer buffer "buf" with ESD_USB_RX_BUFFER_SIZE.
> - Added a function esd_usb_recv_version() that reads and skips incoming
>   "esd_usb_msg" messages until a version reply message is found. This
>   is evaluated to return the count of CAN ports and version information.
> - The data drain loop is limited by a maximum # of bytes to read from
>   the device based on its internal buffer sizes and a timeout
>   ESD_USB_DRAIN_TIMEOUT_MS.
>=20
> This version of the patch incorporates changes recommended on the
> linux-can list for a first version.
>=20
> References:
> https://lore.kernel.org/linux-can/d7fd564775351ea8a60a6ada83a0368a99ea6b1=
9.camel@esd.eu/#r
>=20
> Fixes: 80662d943075 ("can: esd_usb: Add support for esd CAN-USB/3")
> Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>
> ---
>  drivers/net/can/usb/esd_usb.c | 125 ++++++++++++++++++++++++++--------
>  1 file changed, 97 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
> index 05ed664cf59d..dbdfffe3a4a0 100644
> --- a/drivers/net/can/usb/esd_usb.c
> +++ b/drivers/net/can/usb/esd_usb.c
> @@ -44,6 +44,9 @@ MODULE_LICENSE("GPL v2");
>  #define ESD_USB_CMD_TS			5 /* also used for TS_REPLY */
>  #define ESD_USB_CMD_IDADD		6 /* also used for IDADD_REPLY */
> =20
> +/* esd version message name size */
> +#define ESD_USB_FW_NAME_SZ 16
> +
>  /* esd CAN message flags - dlc field */
>  #define ESD_USB_RTR	BIT(4)
>  #define ESD_USB_NO_BRS	BIT(4)
> @@ -95,6 +98,7 @@ MODULE_LICENSE("GPL v2");
>  #define ESD_USB_RX_BUFFER_SIZE		1024
>  #define ESD_USB_MAX_RX_URBS		4
>  #define ESD_USB_MAX_TX_URBS		16 /* must be power of 2 */
> +#define ESD_USB_DRAIN_TIMEOUT_MS	100
> =20
>  /* Modes for CAN-USB/3, to be used for esd_usb_3_set_baudrate_msg_x.mode=
 */
>  #define ESD_USB_3_BAUDRATE_MODE_DISABLE		0 /* remove from bus */
> @@ -131,7 +135,7 @@ struct esd_usb_version_reply_msg {
>  	u8 nets;
>  	u8 features;
>  	__le32 version;
> -	u8 name[16];
> +	u8 name[ESD_USB_FW_NAME_SZ];
>  	__le32 rsvd;
>  	__le32 ts;
>  };
> @@ -625,17 +629,91 @@ static int esd_usb_send_msg(struct esd_usb *dev, un=
ion esd_usb_msg *msg)
>  			    1000);
>  }
> =20
> -static int esd_usb_wait_msg(struct esd_usb *dev,
> -			    union esd_usb_msg *msg)
> +static int esd_usb_req_version(struct esd_usb *dev, void *buf)
>  {
> -	int actual_length;
> +	union esd_usb_msg *msg =3D buf;
> =20
> -	return usb_bulk_msg(dev->udev,
> -			    usb_rcvbulkpipe(dev->udev, 1),
> -			    msg,
> -			    sizeof(*msg),
> -			    &actual_length,
> -			    1000);
> +	msg->hdr.cmd =3D ESD_USB_CMD_VERSION;
> +	msg->hdr.len =3D sizeof(struct esd_usb_version_msg) / sizeof(u32); /* #=
 of 32bit words */
> +	msg->version.rsvd =3D 0;
> +	msg->version.flags =3D 0;
> +	msg->version.drv_version =3D 0;
> +
> +	return esd_usb_send_msg(dev, msg);
> +}
> +
> +static int esd_usb_recv_version(struct esd_usb *dev, void *rx_buf)
> +{
> +	/* Device hardware has 2 RX buffers with ESD_USB_RX_BUFFER_SIZE, * 4 to=
 give some slack. */
> +	const int max_drain_bytes =3D (4 * ESD_USB_RX_BUFFER_SIZE);
> +	unsigned long end_jiffies;
> +	int cnt_other =3D 0;
> +	int cnt_ts =3D 0;
> +	int cnt_vs =3D 0;
> +	int len_sum =3D 0;
> +	int attempt =3D 0;
> +	int err;
> +
> +	end_jiffies =3D jiffies + msecs_to_jiffies(ESD_USB_DRAIN_TIMEOUT_MS);
> +	do {
> +		int actual_length;
> +		int pos;
> +
> +		err =3D usb_bulk_msg(dev->udev,
> +				   usb_rcvbulkpipe(dev->udev, 1),
> +				   rx_buf,
> +				   ESD_USB_RX_BUFFER_SIZE,
> +				   &actual_length,
> +				   ESD_USB_DRAIN_TIMEOUT_MS);
> +		dev_dbg(&dev->udev->dev, "AT %d, LEN %d, ERR %d\n", attempt, actual_le=
ngth, err);
> +		if (err)
> +			goto bail;
> +
> +		err =3D -ENOENT;
> +		len_sum +=3D actual_length;
> +		pos =3D 0;
> +		while (pos < actual_length) {

You have to check that the actual offset you will access later is within
actual_length.

> +			union esd_usb_msg *p_msg;
> +
> +			p_msg =3D (union esd_usb_msg *)(rx_buf + pos);
> +
> +			switch (p_msg->hdr.cmd) {
> +			case ESD_USB_CMD_VERSION:
> +				++cnt_vs;
> +				dev->net_count =3D min(p_msg->version_reply.nets, ESD_USB_MAX_NETS);
> +				dev->version =3D le32_to_cpu(p_msg->version_reply.version);
> +				err =3D 0;
> +				dev_dbg(&dev->udev->dev, "TS 0x%08x, V 0x%08x, N %u, F 0x%02x, %.*s\=
n",
> +					le32_to_cpu(p_msg->version_reply.ts),
> +					le32_to_cpu(p_msg->version_reply.version),
> +					p_msg->version_reply.nets,
> +					p_msg->version_reply.features,
> +					ESD_USB_FW_NAME_SZ, p_msg->version_reply.name);
> +				break;
> +			case ESD_USB_CMD_TS:
> +				++cnt_ts;
> +				dev_dbg(&dev->udev->dev, "TS 0x%08x\n",
> +					le32_to_cpu(p_msg->rx.ts));
> +				break;
> +			default:
> +				++cnt_other;
> +				dev_dbg(&dev->udev->dev, "HDR %d\n", p_msg->hdr.cmd);
> +				break;
> +			}
> +			pos +=3D p_msg->hdr.len * sizeof(u32); /* convert to # of bytes */

Can pos overflow? hdr.len is a u8, so probably not.

> +			if (pos > actual_length) {
> +				dev_err(&dev->udev->dev, "format error\n");
> +				err =3D -EPROTO;
> +				goto bail;
> +			}
> +		}
> +		++attempt;
> +	} while (cnt_vs =3D=3D 0 && len_sum < max_drain_bytes && time_before(ji=
ffies, end_jiffies));
> +bail:
> +	dev_dbg(&dev->udev->dev, "RC=3D%d; ATT=3D%d, TS=3D%d, VS=3D%d, O=3D%d, =
B=3D%d\n",
> +		err, attempt, cnt_ts, cnt_vs, cnt_other, len_sum);
> +	return err;
>  }
> =20
>  static int esd_usb_setup_rx_urbs(struct esd_usb *dev)
> @@ -1274,7 +1352,7 @@ static int esd_usb_probe(struct usb_interface *intf,
>  			 const struct usb_device_id *id)
>  {
>  	struct esd_usb *dev;
> -	union esd_usb_msg *msg;
> +	void *buf;
>  	int i, err;
> =20
>  	dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
> @@ -1289,34 +1367,25 @@ static int esd_usb_probe(struct usb_interface *in=
tf,
> =20
>  	usb_set_intfdata(intf, dev);
> =20
> -	msg =3D kmalloc(sizeof(*msg), GFP_KERNEL);
> -	if (!msg) {
> +	buf =3D kmalloc(ESD_USB_RX_BUFFER_SIZE, GFP_KERNEL);
> +	if (!buf) {
>  		err =3D -ENOMEM;
>  		goto free_dev;
>  	}
> =20
>  	/* query number of CAN interfaces (nets) */
> -	msg->hdr.cmd =3D ESD_USB_CMD_VERSION;
> -	msg->hdr.len =3D sizeof(struct esd_usb_version_msg) / sizeof(u32); /* #=
 of 32bit words */
> -	msg->version.rsvd =3D 0;
> -	msg->version.flags =3D 0;
> -	msg->version.drv_version =3D 0;
> -
> -	err =3D esd_usb_send_msg(dev, msg);
> +	err =3D esd_usb_req_version(dev, buf);

I'm a bit uneasy with the passing of the buffer as an argument, but not
its size.

>  	if (err < 0) {
>  		dev_err(&intf->dev, "sending version message failed\n");
> -		goto free_msg;
> +		goto free_buf;
>  	}
> =20
> -	err =3D esd_usb_wait_msg(dev, msg);
> +	err =3D esd_usb_recv_version(dev, buf);
>  	if (err < 0) {
>  		dev_err(&intf->dev, "no version message answer\n");
> -		goto free_msg;
> +		goto free_buf;
>  	}
> =20
> -	dev->net_count =3D (int)msg->version_reply.nets;
> -	dev->version =3D le32_to_cpu(msg->version_reply.version);
> -
>  	if (device_create_file(&intf->dev, &dev_attr_firmware))
>  		dev_err(&intf->dev,
>  			"Couldn't create device file for firmware\n");
> @@ -1333,8 +1402,8 @@ static int esd_usb_probe(struct usb_interface *intf,
>  	for (i =3D 0; i < dev->net_count; i++)
>  		esd_usb_probe_one_net(intf, i);
> =20
> -free_msg:
> -	kfree(msg);
> +free_buf:
> +	kfree(buf);
>  free_dev:
>  	if (err)
>  		kfree(dev);
> --=20
> 2.34.1
>=20
>=20
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--e6icoa6tdvh3k65v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmicTCYACgkQDHRl3/mQ
kZzbyQf9HAot4Tc6swFP/rldVTaGrk2axazTMaqIy6O3zAPGrUsB0XWMc4Z/qoF3
/jq1XDuzz/QZG9L0WfOEkj2PV9/BPHqMnC/jyVEN6tHMJtxGFkqHgZHLH5fHxa3a
pfmcZjipfu6mmIhvRzCZnScsiNA8JK6P2C2lHquCM4GYiBVt0kpYSmxrHFsNMHKH
J23bPPmKnWSn9+TyhdDT3FMhzAE55lLp1qrwFnZ3NCP/RiDqIvSZWd8PGRklY3w7
6/fvxpPhKv4++lmyXxoIuPTTQ413QWAfMa+3aHrpjZhzR5goaixxbaQPiAP18PyT
pUWB68Cg2dotPX+XyUxCMz4viaXiew==
=ukOx
-----END PGP SIGNATURE-----

--e6icoa6tdvh3k65v--

