Return-Path: <linux-can+bounces-1887-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B401A9BC713
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 08:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAAF283B1F
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 07:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58131FE11B;
	Tue,  5 Nov 2024 07:29:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8791BC077
	for <linux-can@vger.kernel.org>; Tue,  5 Nov 2024 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791775; cv=none; b=B06ftlzBMjvvZLIIhewjzrD+gbgWO/lc1lirfkqJjvF6/enK4EtxIgN9766YmxkAfttcSSdmiZ3cIigMzIg7vQrjFB/OWQ1S4lCo+zNIyzpuvvuA5TGzAV3OSmSKH1SdyUFcPuI5qiLpeFTEN/COXyKxNOlvRjk7PWO8ddlTung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791775; c=relaxed/simple;
	bh=2DTOm74VCL3q3+8xZzASedg2vi0UOyqRKHEQI8llv6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjbIew7YEw03ybtqXRInPmDHBetd2L1fg2kR9loGF+QtURKVW3nLQ2zsrkiSnS8jzEiAhDfCdOI4IwlyrgxWVvHEpFMGdgrEsIo+y7USa+kE8ox0J/X08yYEA+ohy5fER//Ug0U3O0MPAU2j9WrDsupoES03Jw9EHoChIXLWUt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t8E0C-0008Qr-BM; Tue, 05 Nov 2024 08:29:24 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t8E0B-0026lk-0k;
	Tue, 05 Nov 2024 08:29:23 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D5626369E37;
	Tue, 05 Nov 2024 05:29:05 +0000 (UTC)
Date: Tue, 5 Nov 2024 06:29:04 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, 
	kernel@pengutronix.de, stable@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net 7/8] can: mcp251xfd: mcp251xfd_ring_alloc(): fix
 coalescing configuration when switching CAN modes
Message-ID: <20241105-jovial-unselfish-wombat-453fe9-mkl@pengutronix.de>
References: <20241104200120.393312-1-mkl@pengutronix.de>
 <20241104200120.393312-8-mkl@pengutronix.de>
 <20241104174446.72a2d120@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qryq5ucgmrporour"
Content-Disposition: inline
In-Reply-To: <20241104174446.72a2d120@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--qryq5ucgmrporour
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 7/8] can: mcp251xfd: mcp251xfd_ring_alloc(): fix
 coalescing configuration when switching CAN modes
MIME-Version: 1.0

On 04.11.2024 17:44:46, Jakub Kicinski wrote:
> On Mon,  4 Nov 2024 20:53:30 +0100 Marc Kleine-Budde wrote:
> > Reported-by: https://github.com/vdh-robothania
>=20
> Did you do this because of a checkpatch warning or to give the person
> credit? If the former ignore the warning, if the latter I think it's
> better to mention their user name in the commit message and that's it.

I added the link to their gh to credit them. Will @-mention github users
without public email addresses in future commits.

> IMO Reported-by should be a machine readable email address, in case we
> need to CC the person and ask for testing.

That makes sense.

> That's just my $.02 for future cases.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qryq5ucgmrporour
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcprR0ACgkQKDiiPnot
vG8qhAf/Rg6EYXIoAEJdQf6xmOHPL0M11ucskQNMBRPh0Tr6OjBxqImCBMs8EN0L
np1bdyNZ25Wnf6QJMY5Fc5erPYrMvvbfTpwn99b60RCsWrC0e4tnsMFhrpnyheFc
jnf2aoGe+e1R8yTqNn3rwDlibZHAywXvqOOdalLSDrdPMA3ADuKuINzHqVHGUt2t
+hymZP7xvBk7pKdgW+eCwlQbKnt4gYbR5cFWIeE8atg2acyq0Hx9fyRvklfsX99P
yyjpAqC3yU/CCqrVOQzV4ZFyNfVoEKtA0zVSzM2nZ6yCj1f/dWaLT64MKMqxKKkn
HFW7xFk7xyhSh/4eYFqTKkJr+oj7wQ==
=6tM2
-----END PGP SIGNATURE-----

--qryq5ucgmrporour--

