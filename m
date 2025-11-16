Return-Path: <linux-can+bounces-5447-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC6EC6181B
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 17:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED2C84E6EFF
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 16:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7953D19D8A8;
	Sun, 16 Nov 2025 16:09:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA59D29E0E5
	for <linux-can@vger.kernel.org>; Sun, 16 Nov 2025 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763309368; cv=none; b=FHLdP09u4b6xneknNmJFusybf4TpEbAn7NxBDstfGXnyrm1EqmzgqGREtaEF3q8JAfwPzVhiVxeLIWg0nh5DgyP256qTVQL+aJWcTw9hOoiyvv8upTB3WEF+MLuGngCWTQwH1+11tDNDwYO3ZoQIZuwIR+ahK2IW+WQw4oWDuOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763309368; c=relaxed/simple;
	bh=AJy8VwbOWsonSaCRtzcqVx/zMF34QG0Ezi0xv1K3/h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3e748oqhP181eOMXtSw8tA6Bo5meVF5tg9xnN/XaUkRHliycCIvLs1FKKeSDZlEyfK5yHil+oA4OBApRW1ah6KwwxaGSmn45gAMQBU568iMAu44pZpm6OqzsJeyNJ8BWMMSQXWaodlbniAxppkQJGIbsbh3tPXG+LDqa3pa4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vKfJa-0007cq-5p; Sun, 16 Nov 2025 17:09:22 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vKfJZ-000lxB-05;
	Sun, 16 Nov 2025 17:09:21 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B1A244A0D8C;
	Sun, 16 Nov 2025 16:09:20 +0000 (UTC)
Date: Sun, 16 Nov 2025 17:09:20 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as m_can reviewer
Message-ID: <20251116-rustling-tapir-of-health-03361a-mkl@pengutronix.de>
References: <20251022-topic-mcan-reviewer-v6-18-v1-1-885ec5e43493@baylibre.com>
 <20251022-lorikeet-of-fortunate-plenty-43e085-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ebvl6csdtzaoujck"
Content-Disposition: inline
In-Reply-To: <20251022-lorikeet-of-fortunate-plenty-43e085-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ebvl6csdtzaoujck
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: Add myself as m_can reviewer
MIME-Version: 1.0

Hello Chandrasekar,

On 22.10.2025 19:46:47, Marc Kleine-Budde wrote:
> Hello Chandrasekar,
>
> I've seen not much review feedback from you....
>
> On 22.10.2025 11:10:09, Markus Schneider-Pargmann wrote:
> > As I have contributed to the m_can driver over the past years, I would
> > like to continue reviewing new patches.
> >
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 46126ce2f968e4f9260263f1574ee29f5ff0de1c..835dfe1a16c975fb3ab46bc=
7ed736cde61ec0bf5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15394,6 +15394,7 @@ F:	drivers/net/phy/mxl-gpy.c
> >
> >  MCAN MMIO DEVICE DRIVER
> >  M:	Chandrasekar Ramakrishnan <rcsekar@samsung.com>
> > +R:	Markus Schneider-Pargmann <msp@baylibre.com>
>
> ...Maybe you want to give the maintainer hat to Markus?

Since I haven't heard from you, I'll pass the maintainer hat on to
Markus if he wants to take it over.

Markus, what do you think?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ebvl6csdtzaoujck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkZ9y0ACgkQDHRl3/mQ
kZzA3ggArsGl0ZphU4TzW+CeaNUy91GtzdNl3fGG7J4lHTx4uz6TYwgfelsFkJy5
roCYUI/c5I2dYvMDxgkEWj0hAuRFGNWt9QXSIPZnDPPD3MOc53tEijFLDQDhvkvs
RLF61FKNw+yEM3uYA74YEkqfO/+1QloSmAC6eazJayvDhtmZ0QhCTsDMtVVQDtKz
uVDzWGVlGdI0Vl3a3mKHFhf2kc4lTQt0q5qcEjl1zvGw2yNCCQDb9W3SI2KXinV7
dztFdp710QBcqz0IBgaI8v1gP+HNE9ZqbGFNo5QT9GVwy/vffhskivWgpGAzZP0g
ShEdmd7yZrl6z1Av1h5XCmPz9F1J6A==
=u23y
-----END PGP SIGNATURE-----

--ebvl6csdtzaoujck--

