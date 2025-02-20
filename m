Return-Path: <linux-can+bounces-2890-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CE5A3D4AA
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 10:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA9B1892D5D
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 09:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B13E1EDA09;
	Thu, 20 Feb 2025 09:27:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B741EE035
	for <linux-can@vger.kernel.org>; Thu, 20 Feb 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043664; cv=none; b=dfua12T0pmZHvyacN35M5a06sJJpJGiSUJZCPgumOCATLHI3zKcJjlfhr4mS54h1lNc8q/BV6timf0Yh5ctK74AJC8ZOoII5Q6A0Fe+dxRoUYuLO5TwxxYtG1ebCyEw/dvUjqAJKjjex353+xk1dDAFiatncRLETklma9uFSGSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043664; c=relaxed/simple;
	bh=07pTNRyBgMlGn/JYUqqp5ghk2Wls4RSHTUQnkjhHCmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qvpyc6nstr/NNgr9RIplNgv0QIAlY3+vIintKyfWdkbjXRuR/3Cu44fi0K7h+Ro3/DaLEb6KDemjQhsdjPj6wppxEpquIqVD0b4PhbZxDumbJbqlymlNaIYqOSX1f3cX+uzh2y6E7DzdFZNfkkdK45dfaUataNxem6ae/eeh0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tl2qA-0003bp-1j; Thu, 20 Feb 2025 10:27:30 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tl2q9-001uct-2I;
	Thu, 20 Feb 2025 10:27:29 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5C73E3C7627;
	Thu, 20 Feb 2025 09:27:29 +0000 (UTC)
Date: Thu, 20 Feb 2025 10:27:29 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 0/12] pull-request: can-next 2025-02-19
Message-ID: <20250220-industrious-tuscan-labradoodle-1e947c-mkl@pengutronix.de>
References: <20250219113354.529611-1-mkl@pengutronix.de>
 <fdf36ae8-10bc-44d8-94c0-b793b84b94f1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fslnmbukkrq4tqob"
Content-Disposition: inline
In-Reply-To: <fdf36ae8-10bc-44d8-94c0-b793b84b94f1@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--fslnmbukkrq4tqob
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 0/12] pull-request: can-next 2025-02-19
MIME-Version: 1.0

On 20.02.2025 10:23:59, Paolo Abeni wrote:
> On 2/19/25 12:21 PM, Marc Kleine-Budde wrote:
> > Hello netdev-team,
> >=20
> > this is a pull request of 12 patches for net-next/master.
>=20
> Just FYI, since a little time, the name of the net and net-next trees
> main branch is indeed 'main' - to better fit the inclusive language
> guidelines.

Thanks, will update my template.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fslnmbukkrq4tqob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme29X4ACgkQDHRl3/mQ
kZzT1gf9HGOxVQKHn1yM9vce2AyO4vnREgvW5Fu4xGddDpJ+fwr5diEhkUuHuJKU
BVMyp8A7tHk0qrnUrq3JpJRb/a9LZkWTnTNTL2diAn4lqgOz8GcI2unXwZKCMb7q
yKVV8bXlkmdH5vntSXglGk5Z+YCUx6QcVAd8JG2ukPjZnHrTf5y+TBoCuRRWZBrT
z5mPAUpKQ1GBeIhI4Nb+yCQgwhQgxBXkueb2S05V579oSJR4vvEOztttMdkmbAZh
a5Z7xKmCVKGjkDMWqf9u+8x8poTPFdDC4QuVzEZbbix/WqvM3/DOncVOUks282N7
ieECVehAlMvbOt16Lvqz3s78sN4HuQ==
=u2aN
-----END PGP SIGNATURE-----

--fslnmbukkrq4tqob--

