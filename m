Return-Path: <linux-can+bounces-1536-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A0097EA31
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 12:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D6C1F21693
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D2A194C75;
	Mon, 23 Sep 2024 10:54:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EF817543
	for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727088861; cv=none; b=kay9Elb/qLURJAYlbfxn4psQklyh4f+smnGwVLWyGRQA3JIqgCcUmeuBGpQmljUIcf8MD4rpFQTKrJRH7FKjkU2V5y19jz6M+xgDv/OvRhS95aaHvKf9YwVlJwTaNCPYjh4cLshs9IQrWXrrFA2ZOlpBTsfc+dWKSYvx833icyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727088861; c=relaxed/simple;
	bh=WAJvlyIZQzQRld5opE0oWxW3MYdHo16vBhQPxen6k8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKvsGPqMm+LK4rBeVaUisKaLTRIUZzYF3N35V3E+IgMakyEY+HzdKicJTl3APHZOOIdpv50gCl+BwW+vpArmpKZfKOXyLpA25HXVbwKcZP6x5qHIcytZgumqoSIJ1dAn0A89xZiLXSpBHPIwbLCZiuR7ue3xalJ6bNudILlOv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ssghd-00061R-SB; Mon, 23 Sep 2024 12:54:01 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1ssghZ-000wI7-7F; Mon, 23 Sep 2024 12:53:57 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9703B341110;
	Mon, 23 Sep 2024 10:53:53 +0000 (UTC)
Date: Mon, 23 Sep 2024 12:53:50 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, "Felipe Balbi (Intel)" <balbi@kernel.org>, 
	Raymond Tan <raymond.tan@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 2/2] can: m_can: fix missed interrupts with m_can_pci
Message-ID: <20240923-hot-overjoyed-stork-12e138-mkl@pengutronix.de>
References: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726745009.git.matthias.schiffer@ew.tq-group.com>
 <861164dfe6d95fd69ab2f82528306db6be94351a.1726745009.git.matthias.schiffer@ew.tq-group.com>
 <lfxoixj52ip25ys5ndhsn4jhoruucpavstwvwzygsvkmld2vxw@d7yiwmz3jb4y>
 <cc14312b391c17443a04129ae7871ae6aba43c20.camel@ew.tq-group.com>
 <coaa4yade2fwwfuk6xt6rqdxatuejft2wpuvuzw3dwpskjft7f@miabhan3ddgi>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ddv2r5xvimknhrpk"
Content-Disposition: inline
In-Reply-To: <coaa4yade2fwwfuk6xt6rqdxatuejft2wpuvuzw3dwpskjft7f@miabhan3ddgi>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ddv2r5xvimknhrpk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.09.2024 12:07:33, Markus Schneider-Pargmann wrote:
> > > > diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/=
m_can.h
> > > > index 92b2bd8628e6b..8c17eb94d2f98 100644
> > > > --- a/drivers/net/can/m_can/m_can.h
> > > > +++ b/drivers/net/can/m_can/m_can.h
> > > > @@ -99,6 +99,7 @@ struct m_can_classdev {
> > > >  	int pm_clock_support;
> > > >  	int pm_wake_source;
> > > >  	int is_peripheral;
> > > > +	bool is_edge_triggered;
> > >=20
> > > To avoid confusion could you rename it to irq_edge_triggered or
> > > something similar, to make clear that it is not about the chip but the
> > > way the interrupt line is connected?
> >=20
> > Will do.
> >=20
> > >=20
> > > Also I am not sure it is possible, but could you use
> > > irq_get_trigger_type() to see if it is a level or edge based interrup=
t?
> > > Then we wouldn't need this additional parameter at all and could just
> > > detect it in m_can.c.
> >=20
> > Unfortunately that doesn't seem to work. irq_get_trigger_type() only re=
turns a meaningful value
> > after the IRQ has been requested. I thought about requesting the IRQ wi=
th IRQF_NO_AUTOEN and then
> > filling in the irq_edge_triggered field before enabling the IRQ, but IR=
QF_NO_AUTOEN is incompatible
> > with IRQF_SHARED.
>=20
> The mentioned function works for me on ARM and DT even before
> irq_request_threaded_irq() was called.
>=20
> Also I am probably missing something here. Afer requesting the irq, the
> interrupts are not enabled yet right? So can't you just request it and
> check the triggertype immediately afterwards?

You have to distinguish between the IRQ controller and the IRQ source in
your device. You must be able to handle IRQs right after request_irq().
If you IP core is in reset or has all IRQs masked, this will probably
not happen, but with shared IRQ one of the other IRQ sources on the IRQ
can trigger and your IRQ handler will be called. See
CONFIG_DEBUG_SHIRQ_FIXME and CONFIG_DEBUG_SHIRQ_FIXME.

> > Of course there are ways around this - checking irq_get_trigger_type() =
=66rom the ISR itself, or
> > adding more locking, but neither seems quite worthwhile to me. Would yo=
u agree with this?
> >=20
> > Maybe there is some other way to find out the trigger type that would b=
e set when the IRQ is
> > requested? I don't know what that would be however - so I'd just keep s=
etting the flag statically
> > for m_can_pci and leave a dynamic solution for future improvement.
>=20
> No if it doesn't work easily the parameter is probably the best option.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ddv2r5xvimknhrpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbxSLoACgkQKDiiPnot
vG+O8wgAhz4ozhGItTxlf5uPMXovelnVbDItPi8+lfKrycppv5r312bp2DpTnnYp
JxMnGg/8d19seCzjZNdLgAYfElLSfXrJOzUtcxs1hHvDE65b8tCH+r0IXuxGJnAy
CmG18gZeJb9sklahqVIlJH7EorF3d42k/B1/pQnTG1/XJeGsNRRx/prVpHWVwxeM
XQJpvPSUM7/v5ppTxUZ8LTII2AQIewv/4HyvMDYZNBoEzFMRXAt5oQWfof22pqHJ
w3wVfD5VLOxzPDEHZrkcwJDJEmK92bVBUk+TaH3fZ3mxIPT+nekOP9N8UHSf/Gh3
TREm11V8gC1b3QO9ZIWjaRRtkGHDdQ==
=DtKE
-----END PGP SIGNATURE-----

--ddv2r5xvimknhrpk--

