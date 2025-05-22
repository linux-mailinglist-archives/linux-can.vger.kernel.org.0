Return-Path: <linux-can+bounces-3637-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B23AC0719
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 10:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4F04A7B26
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 08:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC00268690;
	Thu, 22 May 2025 08:28:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E068267F76
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747902492; cv=none; b=RQYBZp0f8I7ESEr1yOho0SweqB8Cun1Nzbmbndi9+xxy6jGbuM/k9ft7e7aI4OB5TmHRPdHc+aQvwFrUcfIJncIOtmdz6dWeFrCrhAHBr8HyRDLdmJaQ7SGxsjV2tUFWK5oVGxeJ+uv4cBmuVNDV9CmKEYUqvVdtWtTW2p6SVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747902492; c=relaxed/simple;
	bh=mFSxiGWPhswaQ1nNt3kiTF9YMqccLwUjFnisAuuMYG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcJAh9BbV1xRCz0wtQRay1VypEIHRNGViw3uJZJRQHsTrXxA5uD0nLw7ZpZL6vPv4KKFSb5ul/b1W34E9jc+ixI/SVHKH9TvN7Idf3T2VhNDnnePVyNpZX0rfPosPw7dHmtlK0TIRn1TI1fh8N0yTILpieoLn0/sqQTPdR2RM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Hb-0003Iw-1x; Thu, 22 May 2025 10:28:07 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Ha-000hb2-2e;
	Thu, 22 May 2025 10:28:06 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009:2000::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 341E241722D;
	Thu, 22 May 2025 08:28:06 +0000 (UTC)
Date: Thu, 22 May 2025 10:28:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net 0/n] pull-request: can 2025-05-21
Message-ID: <20250522-wakeful-kudu-of-acumen-26417a-mkl@pengutronix.de>
References: <20250521082239.341080-2-mkl@pengutronix.de>
 <20250521204114.1d131ff9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s4rwdoqqy27t7gnw"
Content-Disposition: inline
In-Reply-To: <20250521204114.1d131ff9@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--s4rwdoqqy27t7gnw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/n] pull-request: can 2025-05-21
MIME-Version: 1.0

On 21.05.2025 20:41:14, Jakub Kicinski wrote:
> On Wed, 21 May 2025 10:14:24 +0200 Marc Kleine-Budde wrote:
> > Subject: [PATCH net 0/n] pull-request: can 2025-05-21
>=20
> Looks like the 0/n confused patchwork and it couldn't do our build
> testing.

Doh! Sorry :/

> Given that we're targeting the final release I'd rather
> not risk merging this without a full run thru our builds.
> Could you respin?

done:
https://lore.kernel.org/all/20250522082344.490913-1-mkl@pengutronix.de/

> Not sure it will make tomorrow's PR but then again
> I don't think anything here is super critical for 6.15 final?
>=20
> Sorry for not noticing earlier.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--s4rwdoqqy27t7gnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgu4BIACgkQDHRl3/mQ
kZz6nwf+J2JKpvZgB4UKqg8kWf4ZewJo8OF5ZLK7p0HaAsGFZVRG0mdnKCSdOct5
rKLEWOpanUcX/hfasefDRvWVdxrdtDQVoVXmMU5x41N78zTSYtmfxbR+Btl/vhqi
LS0LwvcAmbURIXDVY5MAzD4Oqh71vYXT1sp4yO8vjrjpXhqlnjQAHnKgkM/MdAsb
ctSyF6dXojj3WdirCgn4D2wKYlIjSozlaBdq9Js6PtJxitAETVl9K/bS6I0H8mTv
z9KkjUi7jrbOjZlb0ITxXv+obiMcboTJj8neM/0mH3UAB8fZai25clb3te4JANtS
cQ6vSg7oduz9tpTvPVv6sjLVi6SHAw==
=hEu3
-----END PGP SIGNATURE-----

--s4rwdoqqy27t7gnw--

