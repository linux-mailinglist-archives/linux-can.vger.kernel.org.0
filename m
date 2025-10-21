Return-Path: <linux-can+bounces-5262-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECCBBF830F
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 21:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60163A43A0
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 19:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179742586C8;
	Tue, 21 Oct 2025 19:05:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5934A3A3
	for <linux-can@vger.kernel.org>; Tue, 21 Oct 2025 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761073556; cv=none; b=KnHBzzgTAaYzPew9qo8d1l8azZN1Y4uaWabaNhJzoehP/9EnfiPFoWj77y7NthyNlhDAXQhzWSUjqj7vM91m0LFhXow+5ONKCMl63YIgIUL+k74n3DgOXVrBG/g2XwMblX40ekGe2L/S0ffJe9og5ID3ms2sN4eQZnFa7LNaogw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761073556; c=relaxed/simple;
	bh=cyjIpRia7tGxgqWvmt5ulD0c6nEC1XXz3/lvCMwASN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZShfc7h2TTz1gzhi4m/beVubt6fG+NUbf4vx07fCmfZduikAba1Een26R2zPcuHOOOQBfXIBQV1CbSzIuqAar+eqZPOL+pjvwUlitb7UVI5FUXihoxElnMna8uMYLkfYWaqKA96uiIFa0zXeyRBmaOq98+NA70o8gEoanAPy4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vBHg0-0007Uk-CW; Tue, 21 Oct 2025 21:05:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vBHfx-004lj2-1M;
	Tue, 21 Oct 2025 21:05:41 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1A08448C708;
	Tue, 21 Oct 2025 19:05:41 +0000 (UTC)
Date: Tue, 21 Oct 2025 21:05:40 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH 0/7] can: m_can: various cleanups
Message-ID: <20251021-friendly-onyx-capybara-10ee0e-mkl@pengutronix.de>
References: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
 <20251017-fervent-encouraging-oxpecker-3b09d4-mkl@pengutronix.de>
 <DDO89HU3O3J7.1OORIVD4XMXSL@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zdmuckotgjygd6zq"
Content-Disposition: inline
In-Reply-To: <DDO89HU3O3J7.1OORIVD4XMXSL@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--zdmuckotgjygd6zq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/7] can: m_can: various cleanups
MIME-Version: 1.0

On 21.10.2025 20:56:01, Markus Schneider-Pargmann wrote:
> On Fri Oct 17, 2025 at 4:22 PM CEST, Marc Kleine-Budde wrote:
> > On 08.10.2025 21:07:35, Marc Kleine-Budde wrote:
> >> While working on the m_can driver, I created several cleanups commits,=
 make
> >> m_can_init_ram() static, rename hrtimer function, convert debugging and
> >> error output to netdev_(), replace open coded register write by
> >> m_can_write(), remove not needed error messages and sanity checks and =
don't
> >> wake up hte controller during m_can_get_berr_counter() if the interfac=
e is
> >> down.
> >>=20
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >
> > Applied to linux-can-next.
> >
> > Marc
>=20
> Sorry, a bit late due to vacation. The patches look good to me.

Hope you all had a good vacation!

> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Thanks, it's already in net-next :)
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zdmuckotgjygd6zq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmj32X0ACgkQDHRl3/mQ
kZwquAf/aP3R2FIFUHH+ke8u0fmjGDwAzgyDWjN0v6Pb5iAWUbW4yBL+gPJ6Y7OU
Nn/C5QYTXlLkQIz+xmo7JJytiYu6T15wTkXjTtkUWi4Ic4CdI8KaeX+mw3xP9qBY
HT0b/zWJMappQXiUe8FWTVBXS6/KWaqzY8F/rKFDVZsq+kbdFf+2Qe7Qhg8lUxAp
HuvfchYiAn4dFxHjyrA/uCSV4kvLFK5Ss2D5U+8QeSWtE35bb6h5YPeC0cUl6P4m
R8JOioYFtrH7CqK+twY8TL9MdFaOds5WWjiXEAvx5SzccLEQyHII+1Pw6c0wuRgZ
SekO1ajPiH/dVq+gKQW2yO2jCKW5lg==
=hNJE
-----END PGP SIGNATURE-----

--zdmuckotgjygd6zq--

