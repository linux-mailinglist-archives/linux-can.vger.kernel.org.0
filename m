Return-Path: <linux-can+bounces-4576-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F84B4FF66
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 16:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FA616E290
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3409E3451B3;
	Tue,  9 Sep 2025 14:29:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D9132CF8A
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428144; cv=none; b=MbEAWATfJOacpcywH6Y8Fqz63ri9u7fxQv++R8zZM0FDRPk7isXEYHFCw68RqChA/eBNKaOpVAZweSwex9F2DXlR8rM0SSK0I9eeRs6nqgO520SBfZWowKLT6wmEs32PwxtLJdt0nsC5RvDOl7DvVRyIMtjGpySrsa4fnbSliwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428144; c=relaxed/simple;
	bh=hC7H+w01gLo3obgorFIHYQWZFivk41zLY1ojBAhlKVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDtqvWqCFfoYsGA6baCyNsjssCYQZ30tv/Iv+lF/6EFAdsJSl1aRKv1ljiPOpWfzjUf2+0Aa0azcAv1l5aNvR8DUnoQA7KkuZu4Ds88tGeGcwtQrkLVziWLjZNdGrcb8oz6PJJ3kBOqYyJH7ZnTD5xk2XRCen9HKEl8bmKaBT38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvzKz-00044I-RW; Tue, 09 Sep 2025 16:28:49 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvzKy-000R8e-33;
	Tue, 09 Sep 2025 16:28:48 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9A02846A148;
	Tue, 09 Sep 2025 14:28:48 +0000 (UTC)
Date: Tue, 9 Sep 2025 16:28:48 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Patrik Flykt <patrik.flykt@linux.intel.com>, 
	Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
	Varka Bhadram <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH 3/7] can: m_can: m_can_handle_state_errors(): fix CAN
 state transition to Error Active
Message-ID: <20250909-nightingale-of-strange-defense-631196-mkl@pengutronix.de>
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
 <20250812-m_can-fix-state-handling-v1-3-b739e06c0a3b@pengutronix.de>
 <DC74JEKBB6HL.1LJ53UZJ0T0Q9@baylibre.com>
 <DC74YGSPTL16.KG2SWZD4L3YV@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x5l5tximgvzotqsw"
Content-Disposition: inline
In-Reply-To: <DC74YGSPTL16.KG2SWZD4L3YV@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--x5l5tximgvzotqsw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/7] can: m_can: m_can_handle_state_errors(): fix CAN
 state transition to Error Active
MIME-Version: 1.0

On 20.08.2025 11:09:16, Markus Schneider-Pargmann wrote:
> >> --- a/drivers/net/can/m_can/m_can.c
> >> +++ b/drivers/net/can/m_can/m_can.c

[...]

> >> +static enum can_state
> >> +m_can_can_state_get_by_psr(const u32 psr)
> >> +{
> >> +	if (psr & PSR_BO)
> >> +		return CAN_STATE_BUS_OFF;
> >> +	if (psr & PSR_EP)
> >> +		return CAN_STATE_ERROR_PASSIVE;
> >> +	if (psr & PSR_EW)
> >> +		return CAN_STATE_ERROR_WARNING;
> >
> > Why should m_can_handle_state_errors() should be called if none of these
> > flags are set?
> >
> > m_can_handle_state_errors() seems to only be called if IR_ERR_STATE
> > which is defined as:
> >   #define IR_ERR_STATE	(IR_BO | IR_EW | IR_EP)
> >
> > This is the for the interrupt register but will the PSR register bits be
> > set without the interrupt register being set?
>=20
> After reading the other users of the above function, I do see why this
> was added. I am still wondering if there is a way to return to
> ERROR_ACTIVE once the errors are cleared from the error register.

Sorry, I don't get what you mean.

> Also looking at all the users added for the function above, could you
> read the register inside the function? Currently you are adding a
> reg variable and a read call for each call to this function.
> m_can_handle_state_errors() also doesn't need the psr value with your
> refactoring.

That makes sense.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--x5l5tximgvzotqsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjAOZ0ACgkQDHRl3/mQ
kZyhlggAtZExm2Zo96ICbdvXAo84z8ofTkiGmxOgCzBIXeqY0g+rTSH4iVsI7LYw
1qAtZGXNLsoWYAVy8h6Q6uafXvAqskl6CTgZT7Q2BPE3dM+3g4U9/aiJVu8c2P1w
OeAbA9FOQsjfJhMW/Xz0RY3O+E36nav5vXFzGCP1CmZ7j6qZfYHDitI+PbkR5G5A
7TjE43ZpZGI63GcBcvUbjGnc/dY3nZxeNoaFgFhT3v4cLqdU8vz/c0UxNphIQn27
/wvGeHnwhnTO2ETkJ0KzctxT4kyFQOZGaNYJoaBNjrIhaSYAEbHBL/1jyf7HeOpx
BiiLXsN6jQuq8rVOTSZcC3+SSoJ34Q==
=GWZf
-----END PGP SIGNATURE-----

--x5l5tximgvzotqsw--

