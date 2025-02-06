Return-Path: <linux-can+bounces-2740-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5837A2A8B9
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2025 13:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297C6168845
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2025 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5104F22E3E8;
	Thu,  6 Feb 2025 12:45:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8664D22370F
	for <linux-can@vger.kernel.org>; Thu,  6 Feb 2025 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738845955; cv=none; b=GyJIFtagMTgGBngWzJO/Ha43nsWJ42un5Xrk0wVuh7lXU41G9gVziSUi3eSv8LIor7//IDMKjK7LbYeh4b6YDFbwcgDMoqcTa2TlCgqJYgUANMGfqVNgN9Z4Fu+xSBfOFHjgGgbHi2/xhpNwwS8tpIeDFkCrsjs8acBMbWLD5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738845955; c=relaxed/simple;
	bh=kghRt7GzMORt+txKdgQ0nTzbjr8JoGelsjiQ9A3NIXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auaqpeOx9iDLvIBoD8MPxp+am0dCwKMSGggOwzXffTJEa1lRr0GEWgNh8tZRZTUVQBYU+8+Z0aqLs6hvtzYsq6TQK+btxchbx5k335bJawaVEsQ8AyQw/OT4bwxXbzqCXLJwPdzs2KLmSVceGzVolC5ngv0EEGolJHMkgq99tT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tg1G5-0004Rm-RI; Thu, 06 Feb 2025 13:45:29 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tg1G5-003oDb-0r;
	Thu, 06 Feb 2025 13:45:29 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DE0DB3BB4C0;
	Thu, 06 Feb 2025 12:45:28 +0000 (UTC)
Date: Thu, 6 Feb 2025 13:45:27 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] can: esd_usb: Fix not detecting version reply in
 probe routine
Message-ID: <20250206-wild-masked-hoatzin-b194e1-mkl@pengutronix.de>
References: <20250203145810.1286331-1-stefan.maetje@esd.eu>
 <20250203145810.1286331-2-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vaw6nh53tkwvlyt2"
Content-Disposition: inline
In-Reply-To: <20250203145810.1286331-2-stefan.maetje@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--vaw6nh53tkwvlyt2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] can: esd_usb: Fix not detecting version reply in
 probe routine
MIME-Version: 1.0

On 03.02.2025 15:58:10, Stefan M=C3=A4tje wrote:
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
> - On kmalloc() fail for the "union esd_usb_msg msg" (i. e. msg =3D=3D NUL=
L)
>   kfree() would be called with this NULL pointer.
>=20
> To mitigate these problems:
> - Use a transfer buffer "buf" with ESD_USB_RX_BUFFER_SIZE.
> - Fix the error exit path taken after allocation failure for the
>   transfer buffer.
> - Added a function esd_usb_recv_version() that reads and skips incoming
>   "esd_usb_msg" messages until a version reply message is found. This
>   is evaluated to return the count of CAN ports and version information.
>=20
> Fixes: 80662d943075 ("can: esd_usb: Add support for esd CAN-USB/3")
> Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>
> ---
>  drivers/net/can/usb/esd_usb.c | 122 +++++++++++++++++++++++++---------
>  1 file changed, 92 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
> index 03ad10b01867..a6b3b100f8ac 100644
> --- a/drivers/net/can/usb/esd_usb.c
> +++ b/drivers/net/can/usb/esd_usb.c
> @@ -625,17 +625,86 @@ static int esd_usb_send_msg(struct esd_usb *dev, un=
ion esd_usb_msg *msg)
>  			    1000);
>  }
> =20
> -static int esd_usb_wait_msg(struct esd_usb *dev,
> -			    union esd_usb_msg *msg)
> +static int esd_usb_req_version(struct esd_usb *dev, void *buf)
> +{
> +	union esd_usb_msg *msg =3D buf;
> +
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
> +static int esd_usb_recv_version(struct esd_usb *dev,
> +				void *rx_buf,
> +				u32 *version,
> +				int *net_count)

static int esd_usb_recv_version(struct esd_usb *dev, void *rx_buf,
				u32 *version, int *net_count)

>  {
>  	int actual_length;
> +	int cnt_other =3D 0;
> +	int cnt_ts =3D 0;
> +	int cnt_vs =3D 0;
> +	int attempt;
> +	int pos;
> +	int err;

Try to reduce the scope of the variables and move them into the for-loop.

> =20
> -	return usb_bulk_msg(dev->udev,
> -			    usb_rcvbulkpipe(dev->udev, 1),
> -			    msg,
> -			    sizeof(*msg),
> -			    &actual_length,
> -			    1000);
> +	for (attempt =3D 0; attempt < 8 && cnt_vs =3D=3D 0; ++attempt) {

Can you create a #define for the "8" to avoid a magic number here?

> +		err =3D usb_bulk_msg(dev->udev,
> +				   usb_rcvbulkpipe(dev->udev, 1),
> +				   rx_buf,
> +				   ESD_USB_RX_BUFFER_SIZE,
> +				   &actual_length,
> +				   1000);
> +		if (err)
> +			break;

nitpick: I would make it explicit with "goto bail", should be the same?

> +
> +		err =3D -ENOENT;
> +		pos =3D 0;
> +		while (pos < actual_length) {
> +			union esd_usb_msg *p_msg;
> +
> +			p_msg =3D (union esd_usb_msg *)(rx_buf + pos);
> +
> +			switch (p_msg->hdr.cmd) {
> +			case ESD_USB_CMD_VERSION:
> +				++cnt_vs;
> +				*net_count =3D (int)p_msg->version_reply.nets;

Cast not needed.

What happens if nets is > 2? Please sanitize input from outside against
ESD_USB_MAX_NETS.

> +				*version =3D le32_to_cpu(p_msg->version_reply.version);
> +				err =3D 0;
> +				dev_dbg(&dev->udev->dev, "TS 0x%08x, V 0x%08x, N %u, F 0x%02x, %.16s=
\n",
> +					le32_to_cpu(p_msg->version_reply.ts),
> +					le32_to_cpu(p_msg->version_reply.version),
> +					p_msg->version_reply.nets,
> +					p_msg->version_reply.features,
> +					(char *)p_msg->version_reply.name

Is this cast needed?
What about using '"%.*s", sizeof(p_msg->version_reply.name)'?

> +					);

Please move the closing ")" into the previous line.

> +				break;

Why keep parsing after you've found the version?

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
> +
> +			if (pos > actual_length) {
> +				dev_err(&dev->udev->dev, "format error\n");
> +				err =3D -EPROTO;
> +				goto bail;
> +			}
> +		}
> +	}
> +bail:
> +	dev_dbg(&dev->udev->dev, "%s()->%d; ATT=3D%d, TS=3D%d, VS=3D%d, O=3D%d\=
n",
> +		__func__, err, attempt, cnt_ts, cnt_vs, cnt_other);
> +	return err;
>  }
> =20
>  static int esd_usb_setup_rx_urbs(struct esd_usb *dev)
> @@ -1258,7 +1327,7 @@ static int esd_usb_probe_one_net(struct usb_interfa=
ce *intf, int index)
>  	}
> =20
>  	dev->nets[index] =3D priv;
> -	netdev_info(netdev, "device %s registered\n", netdev->name);
> +	netdev_info(netdev, "registered\n");
> =20
>  done:
>  	return err;
> @@ -1273,13 +1342,13 @@ static int esd_usb_probe(struct usb_interface *in=
tf,
>  			 const struct usb_device_id *id)
>  {
>  	struct esd_usb *dev;
> -	union esd_usb_msg *msg;
> +	void *buf;
>  	int i, err;
> =20
>  	dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
>  	if (!dev) {
>  		err =3D -ENOMEM;
> -		goto done;
> +		goto bail;
>  	}
> =20
>  	dev->udev =3D interface_to_usbdev(intf);
> @@ -1288,34 +1357,25 @@ static int esd_usb_probe(struct usb_interface *in=
tf,
> =20
>  	usb_set_intfdata(intf, dev);
> =20
> -	msg =3D kmalloc(sizeof(*msg), GFP_KERNEL);
> -	if (!msg) {
> +	buf =3D kmalloc(ESD_USB_RX_BUFFER_SIZE, GFP_KERNEL);
> +	if (!buf) {
>  		err =3D -ENOMEM;
> -		goto free_msg;
> +		goto free_dev;
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
>  	if (err < 0) {
>  		dev_err(&intf->dev, "sending version message failed\n");
> -		goto free_msg;
> +		goto free_buf;
>  	}
> =20
> -	err =3D esd_usb_wait_msg(dev, msg);
> +	err =3D esd_usb_recv_version(dev, buf, &dev->version, &dev->net_count);

Why pass the "&dev->version, &dev->net_count" pointers, if you already
pass dev?

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
> @@ -1332,11 +1392,12 @@ static int esd_usb_probe(struct usb_interface *in=
tf,
>  	for (i =3D 0; i < dev->net_count; i++)
>  		esd_usb_probe_one_net(intf, i);

Return values are not checked here. :/

> =20
> -free_msg:
> -	kfree(msg);
> +free_buf:
> +	kfree(buf);
> +free_dev:
>  	if (err)
>  		kfree(dev);
> -done:
> +bail:
>  	return err;
>  }
> =20
> @@ -1357,6 +1418,7 @@ static void esd_usb_disconnect(struct usb_interface=
 *intf)
>  		for (i =3D 0; i < dev->net_count; i++) {
>  			if (dev->nets[i]) {
>  				netdev =3D dev->nets[i]->netdev;
> +				netdev_info(netdev, "unregister\n");
>  				unregister_netdev(netdev);
>  				free_candev(netdev);
>  			}
> --=20
> 2.34.1
>=20
>=20
>=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vaw6nh53tkwvlyt2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmekruQACgkQDHRl3/mQ
kZybbwgAtsPIdtggyaoprycIyPs18kKX1/vpDc/uw/46gCC4Yo7U6GRG+q/owYfk
j6sUe2VlVZG0jdK/0Cl5EpJx8eYViNzdsYEkQkBvrTA5m/7Y+BBpAqpV+OeeB2dx
I6a7wfnnxltLyFJ3zpDQNpzmsMlUGaRAfYUvhKx7RJEjB9BVlm8dWv6UptompQ7x
CVRN9HJDkbzjtGyg6bghWry4/eRIzxKmEzGufqsKIXg2d7lfZL4ihIHYv4U04oLC
vGUJUEsKZNJfcaCWArUVQ8UHiiwsMAvf+wLZalxzyFRYuTzdPxd+RhekNux2GF5r
69i7okhFP+vcWzMHcqYGdQin+Lwykg==
=6QkE
-----END PGP SIGNATURE-----

--vaw6nh53tkwvlyt2--

