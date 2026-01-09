Return-Path: <linux-can+bounces-6069-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D825CD090E6
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 12:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 824C830213E5
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 11:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019FC359F8E;
	Fri,  9 Jan 2026 11:53:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D884133A712
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767959608; cv=none; b=KVBQjBw6SnzKRkxT39x/X/XlKSKbZb9NwMKcNgdA0sLKhnQ6Of/2izRZNoCB9ON0zA1tLesM5aX303GM+mOu00tcsC0icwngcauQOAAzpcViEnQf3iZpOgOOV6aLKgRQ7moojEEqqZy0gddn5ZqUvECUa8GbfZ/PHioqqDY1Nxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767959608; c=relaxed/simple;
	bh=XPRXGMji5pRW2QZBBLmNds7GwR541r+eFwkIoYa/Ow0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSOVodjYq1dWMWuRtdOTsrP0p3O8ZNtc+yx8sPxuXqBwJAP75V/VafM/awE6NYrW9PA8SP7Ah7lJHxoHt4wYZl+S3eG//UDIDB8TZu038+zefUd6KcdsKUdYNbI+WZWnRgbCxQJOlVVteC6Kx3hO1LskQK0wPGIjIPmM/Xy9rN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1veB3S-0006QE-01; Fri, 09 Jan 2026 12:53:22 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1veB3R-009q2q-22;
	Fri, 09 Jan 2026 12:53:21 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2804A4C9851;
	Fri, 09 Jan 2026 11:53:21 +0000 (UTC)
Date: Fri, 9 Jan 2026 12:53:18 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH 2/3] can: propagate CAN device capabilities via ml_priv
Message-ID: <20260109-discerning-unselfish-spoonbill-99d850-mkl@pengutronix.de>
References: <20260101191330.1836-1-socketcan@hartkopp.net>
 <20260101191330.1836-2-socketcan@hartkopp.net>
 <20260109-fearless-diamond-gaur-90b52a-mkl@pengutronix.de>
 <a84166a4-7058-4dd9-b633-5c4cd0a48a28@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ryw6oy5zkqq66on7"
Content-Disposition: inline
In-Reply-To: <a84166a4-7058-4dd9-b633-5c4cd0a48a28@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ryw6oy5zkqq66on7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] can: propagate CAN device capabilities via ml_priv
MIME-Version: 1.0

On 09.01.2026 12:31:08, Oliver Hartkopp wrote:
> > > +static inline bool can_cap_enabled(struct net_device *dev, u32 cap)
> > > +{
> > > +	struct can_ml_priv *can_ml =3D can_get_ml_priv(dev);
> > > +
> > > +	if (!can_ml)
> > > +		return true;
> >
> > Why is the capability enabled, if the device doesn't have a CAN ml_priv?
>
> I have been thought about virtual CAN interfaces first but they also have=
 a
> can_ml.
>
> It's just a double-check if we really have a CAN interface here.
> But returning false would make more sense then. Will change.

=2E..or do we want to just de-ref here, too?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ryw6oy5zkqq66on7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlg7CoACgkQDHRl3/mQ
kZyYeAgAg0iPM+J3up1CXVJ1RBzXZVPU+N5SMET79IF4dDIxVOoXDJ6mpgBMxh4X
bKJliUpEr9WbjOAdHQumFNkq5y3MLLOiOR3VzY74hRG5A1Db3MyGdlYnhuG/MqtV
zbQKHMEOnl6P8PrkQK2HT8oYazVIkIsN0gUowpBYwbG4ZQQWFDUu/yHWDUCecVFB
3PGdawuVjE26C9OA3Sx3tEyN0aaG95fZ0qRdplm48QXvkGi67Qkj/a98Ifrhkmtz
fDBm9Ij70QPAC1NDhgUC1g9XHLP6AsSNc755yKeVnOyZYR+NouaarIkad3RiFauy
/c2ayE18D43AXq/8Gc+yI/+tuskEJQ==
=Jlkz
-----END PGP SIGNATURE-----

--ryw6oy5zkqq66on7--

