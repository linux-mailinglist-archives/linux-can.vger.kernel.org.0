Return-Path: <linux-can+bounces-1300-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511E896883B
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2024 15:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC89282A73
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2024 13:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568EB201249;
	Mon,  2 Sep 2024 13:00:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9E9746E
	for <linux-can@vger.kernel.org>; Mon,  2 Sep 2024 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282022; cv=none; b=o6r8nDpnP52cErD/YeqR5vY/ZMrMJ+lhJHfV63Delo9wXy2CDOr2Epa0187OsW/V6cokTGgUDPfUXU7S8UxdkaSfEgc23sLBl1z4EM44CvgFwiHVnmwFSPqiWFhlZUSa5qklBPo+DwT1qnWYHmxHi9QUm9loRIiupcFv//Qh1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282022; c=relaxed/simple;
	bh=cvvY1VYwr9uYGYWyoX78ungBm1W03Y7raKAzUcsDEhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOJT0PDxdrkrvj+Py8a+7yxcc9K3/AAOdYAjpJ8f8kkG7V7GhASk2mvI3LRr81AGZO0SpbjMVh9duf1zi8OFBMw5G4wNCxTMVFhITQPtmV2sJo0mybOAKLdK5bx/0DxF1jbjV8ZF6iOHVZ/jAs+9lm+1P2kImZriCyDp4UXrMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sl6fH-0003rM-Sp; Mon, 02 Sep 2024 15:00:15 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sl6fH-004uQN-AF; Mon, 02 Sep 2024 15:00:15 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 066963306DF;
	Mon, 02 Sep 2024 13:00:15 +0000 (UTC)
Date: Mon, 2 Sep 2024 15:00:14 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH] can: gs_usb.c: add usb endpoint address detection at
 driver probe step
Message-ID: <20240902-fanatic-perky-ara-3c083c-mkl@pengutronix.de>
References: <mkl@pengutronix.de>
 <mailhol.vincent@wanadoo.fr>
 <davem@davemloft.net>
 <edumazet@google.com>
 <kuba@kernel.org>
 <pabeni@redhat.com>
 <20240831201643.331810-1-ak.alexander.kozhinov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gwxtaki2vs6hfuyp"
Content-Disposition: inline
In-Reply-To: <20240831201643.331810-1-ak.alexander.kozhinov@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--gwxtaki2vs6hfuyp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alexander,

thanks for you contribution.

On 31.08.2024 22:16:24, Alexander Kozhinov wrote:
> Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>

Can you please describe why you did this change.

regards,
Marc

> ---
>  drivers/net/can/usb/gs_usb.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index bc86e9b329fd..5f10cd9bced5 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -43,9 +43,6 @@
>  #define USB_XYLANTA_SAINT3_VENDOR_ID 0x16d0
>  #define USB_XYLANTA_SAINT3_PRODUCT_ID 0x0f30
> =20
> -#define GS_USB_ENDPOINT_IN 1
> -#define GS_USB_ENDPOINT_OUT 2
> -
>  /* Timestamp 32 bit timer runs at 1 MHz (1 =C2=B5s tick). Worker accounts
>   * for timer overflow (will be after ~71 minutes)
>   */
> @@ -336,6 +333,9 @@ struct gs_usb {
> =20
>  	unsigned int hf_size_rx;
>  	u8 active_channels;
> +
> +	u8 ep_in;
> +	u8 ep_out;
>  };
> =20
>  /* 'allocate' a tx context.
> @@ -687,7 +687,7 @@ static void gs_usb_receive_bulk_callback(struct urb *=
urb)
> =20
>  resubmit_urb:
>  	usb_fill_bulk_urb(urb, parent->udev,
> -			  usb_rcvbulkpipe(parent->udev, GS_USB_ENDPOINT_IN),
> +			  usb_rcvbulkpipe(parent->udev, parent->ep_in),
>  			  hf, dev->parent->hf_size_rx,
>  			  gs_usb_receive_bulk_callback, parent);
> =20
> @@ -819,7 +819,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *=
skb,
>  	}
> =20
>  	usb_fill_bulk_urb(urb, dev->udev,
> -			  usb_sndbulkpipe(dev->udev, GS_USB_ENDPOINT_OUT),
> +			  usb_sndbulkpipe(dev->udev, dev->parent->ep_out),
>  			  hf, dev->hf_size_tx,
>  			  gs_usb_xmit_callback, txc);
> =20
> @@ -926,7 +926,7 @@ static int gs_can_open(struct net_device *netdev)
>  			usb_fill_bulk_urb(urb,
>  					  dev->udev,
>  					  usb_rcvbulkpipe(dev->udev,
> -							  GS_USB_ENDPOINT_IN),
> +							  dev->parent->ep_in),
>  					  buf,
>  					  dev->parent->hf_size_rx,
>  					  gs_usb_receive_bulk_callback, parent);
> @@ -1421,6 +1421,26 @@ static int gs_usb_probe(struct usb_interface *intf,
>  	struct gs_device_config dconf;
>  	unsigned int icount, i;
>  	int rc;
> +	struct usb_host_interface *host_iface;
> +	u8 ep_in =3D 0, ep_out =3D 0;
> +
> +	host_iface =3D intf->cur_altsetting;
> +
> +	/* check interface endpoint addresses */
> +	for (i =3D 0; i < host_iface->desc.bNumEndpoints; i++) {
> +		struct usb_endpoint_descriptor *ep =3D &host_iface->endpoint[i].desc;
> +
> +		if (usb_endpoint_is_bulk_in(ep)) {
> +			ep_in =3D ep->bEndpointAddress;
> +		} else if (usb_endpoint_is_bulk_out(ep)) {
> +			ep_out =3D ep->bEndpointAddress;
> +		}
> +	}
> +
> +	if (!ep_in || !ep_out) {
> +		dev_err(&intf->dev, "Required endpoints not found\n");
> +		return -ENODEV;
> +	}
> =20
>  	/* send host config */
>  	rc =3D usb_control_msg_send(udev, 0,
> @@ -1466,6 +1486,10 @@ static int gs_usb_probe(struct usb_interface *intf,
>  	usb_set_intfdata(intf, parent);
>  	parent->udev =3D udev;
> =20
> +	/* store the detected endpoints */
> +	parent->ep_in =3D ep_in;
> +	parent->ep_out =3D ep_out;
> +
>  	for (i =3D 0; i < icount; i++) {
>  		unsigned int hf_size_rx =3D 0;
> =20
> --=20
> 2.43.0
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gwxtaki2vs6hfuyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbVttsACgkQKDiiPnot
vG9wjQf/c3i7+o4S/cBb/ZdArM4hbR/ta6Uy33Kdw12iq6L+LMA6rNMx3un2YxD8
9Cst3l+ZyQVXbBxxzQUnO7INZ2sa81RJYTbfDiNQ90rS4tJlyRthiXbkeglSNAGK
jGGItyxsVvVFxLz7i4LAfgdC0m9hEhkRWYr4nvOGNNhtMpwKYxhhfuqtE95kex+G
dB7fb69nE8xhWrOboPbyIlV7CotE+7MXxAYmD5HFDinvdSQ8f9kwaKm7pVKSlLZG
UN8/ts2sdw+RjZo99IN38X5gJW6sze+CLfuJ1uJT+WHoTv8HY2oGPnTbhOjMFuAS
5lr63tnP+srTQjspeuCRwKzoE0z58Q==
=K/pf
-----END PGP SIGNATURE-----

--gwxtaki2vs6hfuyp--

