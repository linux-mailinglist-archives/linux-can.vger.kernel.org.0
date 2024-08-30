Return-Path: <linux-can+bounces-1244-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 182609663F6
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 16:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03C228395B
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 14:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947C7190674;
	Fri, 30 Aug 2024 14:18:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370B15C12D
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027499; cv=none; b=QtfhGGDUxID7ajny1/XocYk15olF1Y2N7T4bdCgv1Y6FMLMA97zQZXpHSDCz+G53lnpUPKt++LsHJv9ctio4+IiaI0OYZu61E4PYou+rATa3JTGIfT+VkPvdI2LtrMwWwPnImeJ4JypsIGDEBLsNN/exajDeMPIRkzM3SidWXbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027499; c=relaxed/simple;
	bh=Bc0K/SvTlbFib6wHSGdzvULqLFn5sEn1KuRgEaeGJYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjwejMQXYOOwFAcbPNCJUkdm2A8Z+BkI6QgrO4z0o/eozuBQ4PRGigcsCQRj9MA5CgmSKwGBplVOpWPmlryqbOSfaBSQQAnNW6qPZhBlFDdQDa/os7AOOQz1hZmsK/oVqrR9KrhWzhqw7J60wF6c08st/TIDnE1bBWtMCIqpD2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk2Rv-0000A4-Ok; Fri, 30 Aug 2024 16:18:03 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk2Rt-004AaI-1h; Fri, 30 Aug 2024 16:18:01 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B2E8832DF0E;
	Fri, 30 Aug 2024 14:18:00 +0000 (UTC)
Date: Fri, 30 Aug 2024 16:18:00 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Yan Zhen <yanzhen@vivo.com>, mailhol.vincent@wanadoo.fr, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] can: kvaser_usb: Simplify with dev_err_probe()
Message-ID: <20240830-omniscient-impartial-capuchin-6c4490-mkl@pengutronix.de>
References: <20240830110651.519119-1-yanzhen@vivo.com>
 <e0effc27-f16b-4449-9661-76f0fc330aa9@intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j7xeongrjux5eock"
Content-Disposition: inline
In-Reply-To: <e0effc27-f16b-4449-9661-76f0fc330aa9@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--j7xeongrjux5eock
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30.08.2024 14:50:44, Alexander Lobakin wrote:
> From: Yan Zhen <yanzhen@vivo.com>
> Date: Fri, 30 Aug 2024 19:06:51 +0800
>=20
> > dev_err_probe() is used to log an error message during the probe proces=
s=20
> > of a device.=20
> >=20
> > It can simplify the error path and unify a message template.
> >=20
> > Using this helper is totally fine even if err is known to never
> > be -EPROBE_DEFER.
> >=20
> > The benefit compared to a normal dev_err() is the standardized format
> > of the error code, it being emitted symbolically and the fact that
> > the error code is returned which allows more compact error paths.
> >=20
> > Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> > ---
> >  .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 42 +++++++------------
> >  1 file changed, 16 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers=
/net/can/usb/kvaser_usb/kvaser_usb_core.c
> > index 35b4132b0639..bcf8d870af17 100644
> > --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> > +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> > @@ -898,10 +898,8 @@ static int kvaser_usb_probe(struct usb_interface *=
intf,
> >  	ops =3D driver_info->ops;
> > =20
> >  	err =3D ops->dev_setup_endpoints(dev);
> > -	if (err) {
> > -		dev_err(&intf->dev, "Cannot get usb endpoint(s)");
> > -		return err;
> > -	}
> > +	if (err)
> > +		return dev_err_probe(&intf->dev, err, "Cannot get usb endpoint(s)");
> > =20
> >  	dev->udev =3D interface_to_usbdev(intf);
> > =20
> > @@ -912,26 +910,20 @@ static int kvaser_usb_probe(struct usb_interface =
*intf,
> >  	dev->card_data.ctrlmode_supported =3D 0;
> >  	dev->card_data.capabilities =3D 0;
> >  	err =3D ops->dev_init_card(dev);
> > -	if (err) {
> > -		dev_err(&intf->dev,
> > -			"Failed to initialize card, error %d\n", err);
> > -		return err;
> > -	}
> > +	if (err)
> > +		return dev_err_probe(&intf->dev, err,
> > +					"Failed to initialize card\n");
>=20
> The line wrap is wrong in all the places where you used it. It should be
> aligned to the opening brace, like
>=20
> 		return dev_err_probe(&intf->dev, err,
> 				     "Failed ...)
>=20
> Replace one tab with 5 spaces to fix that, here and in the whole patch.

Fixed while applying.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--j7xeongrjux5eock
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbR1JMACgkQKDiiPnot
vG8iZAf+PAIOYo18T8gGoXog1rNfStaB60QiIUsdtMuP9ZlGcPu8qTESCTsgMPDC
yOG+eJeR7hYrYCyR71vgIzFBjqipA95X31hikZ6ro/iXdKut0iqG/IVkhCFacUys
ZIhn/v9252RmeANar5iy0dI/Q18Y3qV81L4OkmoDl0YOm3OQlmfitLzIhSNbFTFN
rV0nYWk+he83FPVF+fDgyCk7fDlZmpzCTN75ZSqnEQS2Pk2jxnrLb5kqq6bEfsHl
j1vRsgdW4icKDDhgS1GDJKjTFw35/mrW47Iz/X6cycgJ+5MOdtcgSf7gCnyjUKVX
wAv+1SuOJ/e7qBvsw2gnmRd7eRKkBg==
=y9gF
-----END PGP SIGNATURE-----

--j7xeongrjux5eock--

