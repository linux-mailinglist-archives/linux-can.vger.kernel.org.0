Return-Path: <linux-can+bounces-6190-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 339D1D38625
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 20:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7A023065233
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 19:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB67839A819;
	Fri, 16 Jan 2026 19:43:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6606134C140
	for <linux-can@vger.kernel.org>; Fri, 16 Jan 2026 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592614; cv=none; b=eh//hSEbUpmZ0Xuv8y3wGpFqksYVVqcdckX2NNwFemxueKkFAGnQSent3wlVNa/j+50fuGgsxlzfox4X2fj6mPJ2Y4Xxg7AFmSLH2ughVzNkmAMp+CrHWtv5+77QifKECu0WBmCdpIVKBo8msi1W8qNAKULGx7tugD1w306uKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592614; c=relaxed/simple;
	bh=poKp5vX8lh2pR6Sf5S5sLyzNO3n9ufpfwRDGKymvID0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jz3W139sAlYFvoW+XUT8SbH5+GIXxAwJUXmZdBJwco5dR1AiW8y9p9XfOhKzfUepxWSo9gGyU4jykw52HcMtg+Go14ksDlrqXc3RQpBFAIwiqfwgt1j91jGJDwzPVWAOsv3uifhDFL8HnTHwrStAW9PFXPdBHJsR8+txlT/Y9iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgpj9-0001K9-8u; Fri, 16 Jan 2026 20:43:23 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgpj9-000yKs-0R;
	Fri, 16 Jan 2026 20:43:22 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1EBCA4CEF29;
	Fri, 16 Jan 2026 19:43:22 +0000 (UTC)
Date: Fri, 16 Jan 2026 20:43:21 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
	Wolfgang Grandegger <wg@grandegger.com>, Sebastian Haas <haas@ems-wuensche.com>, 
	"David S. Miller" <davem@davemloft.net>, Frank Jungclaus <frank.jungclaus@esd.eu>, socketcan@esd.eu, 
	Yasushi SHOJI <yashi@spacecubics.com>, Daniel Berglund <db@kvaser.com>, 
	Olivier Sobrie <olivier@sobrie.be>, 
	Remigiusz =?utf-8?B?S2/FgsWCxIV0YWo=?= <remigiusz.kollataj@mobica.com>, Bernd Krumboeck <b.krumboeck@gmail.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH can v2 0/5] can: usb: fix URB memory leaks
Message-ID: <20260116-manipulative-wine-pillbug-0b5a36-mkl@pengutronix.de>
References: <20260116-can_usb-fix-memory-leak-v2-0-4b8cb2915571@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s33jddrzvg4u2542"
Content-Disposition: inline
In-Reply-To: <20260116-can_usb-fix-memory-leak-v2-0-4b8cb2915571@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--s33jddrzvg4u2542
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can v2 0/5] can: usb: fix URB memory leaks
MIME-Version: 1.0

On 16.01.2026 20:35:13, Marc Kleine-Budde wrote:
> An URB memory leak [1][2] was recently fixed in the gs_usb driver. The
> driver did not take into account that completed URBs are no longer
> anchored, causing them to be lost during ifdown. The memory leak was fixed
> by re-anchoring the URBs in the URB completion callback.
>
> Several USB CAN drivers are affected by the same error. Fix them
> accordingly.
>
> [1] https://lore.kernel.org/all/20260109135311.576033-3-mkl@pengutronix.d=
e/
> [2] https://lore.kernel.org/all/20260116-can_usb-fix-reanchor-v1-1-9d74e7=
289225@pengutronix.de/
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--s33jddrzvg4u2542
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlqlNYACgkQDHRl3/mQ
kZzxLQgAgeUPHXAwM23AMfM8vIOSylgiuf8STuzdfNSM+ObuEJMcPsgr75cAprgs
Q3vHP7PRR911LqYtaIjw4dcwEqWC3IlE2kiTgJ1CqHdkyEFpqjg0s/rhIywR+O1E
LfAPNjXiiN/79mBoHuphWv8DwmWstcWCrJIcrGH+MtV81QnPBwUN651SilPpqoL3
Yn/uX0Qk+Ix1qF3csrqzq4YUd7zpfgvz+7piyEzTXdKBcck5mZUT4St1WmeMRkw6
Ue/Z6AEKoE0+Yd1xltfnd8/kkr4HU7yexnT7/YlI9ZCW2CGo+Fz+hzJYY9XLwY+R
QQRrJbygJlEcHFz7EmR6G+t1U5IxDQ==
=wUnh
-----END PGP SIGNATURE-----

--s33jddrzvg4u2542--

