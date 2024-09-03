Return-Path: <linux-can+bounces-1328-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07F096997F
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 11:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E561F22E0E
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7195F1A4E97;
	Tue,  3 Sep 2024 09:50:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2621A0BF9
	for <linux-can@vger.kernel.org>; Tue,  3 Sep 2024 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357049; cv=none; b=AV4/yslyBCUwd3CE1Xvz8w+xl4sTO8cigA9dcWJQMelrCUexqcd0141y5SnAD0RBjFufgv3xmskcgxNlAx+KGLFfA+E83N5H/5Ku994q3H9lP0rIMkoL9PsIKX2HMpQl97U8p6w9M1Sd+l3/vDxQTZn71/6BxOkh1WNh3xHJ8jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357049; c=relaxed/simple;
	bh=syp/oHhY8c9dsu9ka0PHtXo7K3bUllWHV9eBW1tmJUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4vVghJyaFS92Z2YoB/LOtcMN3UXmuOVtc7uR4OMtQLYbe3xbU7zi3uSXLNGJqqqwqfcd/wudb88YHHCVa6Nky2ud5JoK37D4WxyNMrfRj8JcFT3Ykt6s8uIsdhKYMmvE6Z2ueZY7fBBlNomlqvMCMW/uSlKn1cKRkKuLNVuwyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slQBR-0006TU-8a; Tue, 03 Sep 2024 11:50:45 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slQBQ-0059vx-RN; Tue, 03 Sep 2024 11:50:44 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8DFFA331351;
	Tue, 03 Sep 2024 09:50:44 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:50:44 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH] can: gs_usb.c: add usb endpoint address detection at
 driver probe step
Message-ID: <20240903-literate-maroon-hamster-5c9a13-mkl@pengutronix.de>
References: <mkl@pengutronix.de>
 <mailhol.vincent@wanadoo.fr>
 <davem@davemloft.net>
 <edumazet@google.com>
 <kuba@kernel.org>
 <pabeni@redhat.com>
 <20240831201643.331810-1-ak.alexander.kozhinov@gmail.com>
 <CAMZ6Rq+F5GLGo_uuCm1Bj7gA5LgH_NbRTLJJ=hWisgV1DWyNsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3lne7tsrh7oabdbq"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+F5GLGo_uuCm1Bj7gA5LgH_NbRTLJJ=hWisgV1DWyNsQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--3lne7tsrh7oabdbq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.09.2024 13:15:15, Vincent Mailhol wrote:
> From the discussion you had with Marc, it seems that this patch is a
> bug fix, right? Then, it is important to put the Fixes tag so that
> this patch gets picked by the stable team so that the stable releases
> also get the fix. The fix tag syntax is also explained in the link
> which Marc previously shared with you:
>=20
>   https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
describe-your-changes

I've added the Fixes tag.

>=20
> > Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
> > ---
> >  drivers/net/can/usb/gs_usb.c | 36 ++++++++++++++++++++++++++++++------
> >  1 file changed, 30 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> > index bc86e9b329fd..5f10cd9bced5 100644
> > --- a/drivers/net/can/usb/gs_usb.c
> > +++ b/drivers/net/can/usb/gs_usb.c
> > @@ -43,9 +43,6 @@
> >  #define USB_XYLANTA_SAINT3_VENDOR_ID 0x16d0
> >  #define USB_XYLANTA_SAINT3_PRODUCT_ID 0x0f30
> >
> > -#define GS_USB_ENDPOINT_IN 1
> > -#define GS_USB_ENDPOINT_OUT 2
> > -
> >  /* Timestamp 32 bit timer runs at 1 MHz (1 =C2=B5s tick). Worker accou=
nts
> >   * for timer overflow (will be after ~71 minutes)
> >   */
> > @@ -336,6 +333,9 @@ struct gs_usb {
> >
> >         unsigned int hf_size_rx;
> >         u8 active_channels;
> > +
> > +       u8 ep_in;
> > +       u8 ep_out;
> >  };
> >
> >  /* 'allocate' a tx context.
> > @@ -687,7 +687,7 @@ static void gs_usb_receive_bulk_callback(struct urb=
 *urb)
> >
> >  resubmit_urb:
> >         usb_fill_bulk_urb(urb, parent->udev,
> > -                         usb_rcvbulkpipe(parent->udev, GS_USB_ENDPOINT=
_IN),
> > +                         usb_rcvbulkpipe(parent->udev, parent->ep_in),
> >                           hf, dev->parent->hf_size_rx,
> >                           gs_usb_receive_bulk_callback, parent);
> >
> > @@ -819,7 +819,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff=
 *skb,
> >         }
> >
> >         usb_fill_bulk_urb(urb, dev->udev,
> > -                         usb_sndbulkpipe(dev->udev, GS_USB_ENDPOINT_OU=
T),
> > +                         usb_sndbulkpipe(dev->udev, dev->parent->ep_ou=
t),
> >                           hf, dev->hf_size_tx,
> >                           gs_usb_xmit_callback, txc);
> >
> > @@ -926,7 +926,7 @@ static int gs_can_open(struct net_device *netdev)
> >                         usb_fill_bulk_urb(urb,
> >                                           dev->udev,
> >                                           usb_rcvbulkpipe(dev->udev,
> > -                                                         GS_USB_ENDPOI=
NT_IN),
> > +                                                         dev->parent->=
ep_in),
> >                                           buf,
> >                                           dev->parent->hf_size_rx,
> >                                           gs_usb_receive_bulk_callback,=
 parent);
> > @@ -1421,6 +1421,26 @@ static int gs_usb_probe(struct usb_interface *in=
tf,
> >         struct gs_device_config dconf;
> >         unsigned int icount, i;
> >         int rc;
> > +       struct usb_host_interface *host_iface;
> > +       u8 ep_in =3D 0, ep_out =3D 0;
> > +
> > +       host_iface =3D intf->cur_altsetting;
> > +
> > +       /* check interface endpoint addresses */
> > +       for (i =3D 0; i < host_iface->desc.bNumEndpoints; i++) {
> > +               struct usb_endpoint_descriptor *ep =3D &host_iface->end=
point[i].desc;
> > +
> > +               if (usb_endpoint_is_bulk_in(ep)) {
> > +                       ep_in =3D ep->bEndpointAddress;
> > +               } else if (usb_endpoint_is_bulk_out(ep)) {
> > +                       ep_out =3D ep->bEndpointAddress;
> > +               }
> > +       }
>=20
> The usb_find_common_endpoints() and
> usb_find_common_endpoints_reverse() helper functions do something
> similar to what you are trying to achieve here:
>=20
>   https://elixir.bootlin.com/linux/v6.10.7/source/drivers/usb/core/usb.c#=
L118
>=20
> Can you refactor your code to use these helpers instead?

Thanks for pointing to the helpers, I'll rework the code.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3lne7tsrh7oabdbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbW2/AACgkQKDiiPnot
vG+5hQf/SyRAeJW49k5A+dbr9fBfNiDrKIM90G0K08MLfXpEMrbk2tiMiCoBTXzK
bk04A1uj1B6qivwJywSYP7wqDgjh3gh1KMgUxSJEym+KJqF2EA5qi05c1RHnfAcl
JtVDvW6VcRuetWylVkPSsd+MwDQKGWv1d+1i/Wzs40Y5PabSPH/A1y9wBIyhcI8K
gYbkQ9XtPhkDen03jTTsO/8QMq6qmsbpA5QvMNpVPft4yna4fbwpapKGCcvrEgvn
EhEtAVeEbo8cYqvxWZBZl/nIK6GYHVbdtZdIs5NW9JyYljQkgQ6Pk8d5+y2neEPj
gx1TO4MmXxvnMfVgUJsTxzx7wBBSFQ==
=PdZE
-----END PGP SIGNATURE-----

--3lne7tsrh7oabdbq--

