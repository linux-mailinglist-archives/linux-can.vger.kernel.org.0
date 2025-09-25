Return-Path: <linux-can+bounces-5030-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C02B9F5D3
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0263719C08F9
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6501A83F9;
	Thu, 25 Sep 2025 12:54:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982AB2AE68
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804840; cv=none; b=hxL8TmWPAkAcFlSEyFk39UW2jO2i4SoevPG4YJj9ppUeeIlRHuvJv3r1ZJr+XPmb+U9GpEYO8LfVqBJclS+4uI/JwSNVrQ0P2Hcj52lS6EagpYady9lWqgYUC/yUYtkLortDjj56r5wnjWDxphSojiY/LRHKSqQKkgRYmwiyPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804840; c=relaxed/simple;
	bh=uAZiZyFOo3jXpMZVj5jzaSbAfDu0rilfqw1NRKZF+Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvDJ//SJ56FWBf3fI1PnR3YB+O3mjEAxjuYDt6sP9y2La2qcxcuo/yQIAiGCzNHO8+q19mTUT3qLCgt7kqPEPdXJ8KQx3tfb6EmBwebp1iOgkGBikwZLGcNXhaohvOUlvOP9P/oPQ4g3c93TslgiCPhoDRBNsnR4EpFphtYN0fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1lTu-0002QO-5Q; Thu, 25 Sep 2025 14:53:54 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1lTt-000QFO-16;
	Thu, 25 Sep 2025 14:53:53 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 03B03479BAB;
	Thu, 25 Sep 2025 12:53:53 +0000 (UTC)
Date: Thu, 25 Sep 2025 14:53:52 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/48] pull-request: can-next 2025-09-24
Message-ID: <20250925-aquatic-heron-of-blizzard-b736ac-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
 <20250925-real-mauve-hawk-50b918-mkl@pengutronix.de>
 <c433c2ad1ee19299a46b3538327f4fafb7a25165.camel@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zcz4msxiltmbuo2j"
Content-Disposition: inline
In-Reply-To: <c433c2ad1ee19299a46b3538327f4fafb7a25165.camel@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--zcz4msxiltmbuo2j
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 0/48] pull-request: can-next 2025-09-24
MIME-Version: 1.0

On 25.09.2025 12:53:03, Stefan M=C3=A4tje wrote:
> Am Donnerstag, dem 25.09.2025 um 14:18 +0200 schrieb Marc Kleine-Budde:
> > On 24.09.2025 10:06:17, Marc Kleine-Budde wrote:
> > > Hello netdev-team,
> > >=20
> > > this is a pull request of 48 patches for net-next/main.
> >=20
> > This PR is obsolete, see new PR instead:
> >=20
> > > https://lore.kernel.org/all/20250925121332.848157-1-mkl@pengutronix.d=
e/
> >=20
> > regards,
> > Marc
>=20
> Hello Marc,
>=20
> I've seen that you have already included my two patches as patch 20 / 21 =
in
> this pull request. Shall I still send these patches as a stand alone
> series again (split off from the original 5 patches series)?

No need to resend.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zcz4msxiltmbuo2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjVO1wACgkQDHRl3/mQ
kZx5XAgAt4HD0qSU4851TfsL8lqcTqn5lRPQLZ8TIns8gXBmbwvVL551dCvCo14L
y+NnIfcPYBuZwtVjymrAl6tjKZ3RX+Go62oLOaDyh7Ff93zPC6x2Wus/xtdlCGIn
6z36SRFhdOnEACZDQSnU4A9NQR/fpNiGgBkwHeYU3/CqD6zvHqsEoej5OwXsUgBX
lxdGJVLJ+uPHxmvmtD0FiloLI02H/vW9vnVFItmQ1d1+z7Jh/AR+4T7TWwLJ6+7A
DgXiHYj11Z/mWZWe88ez8iuenMVG5t+8FODHfqbVah8EzMJc2aIOeol7l3F31XqB
w0Df1S10SgdjE8LTzZl09v+SHGz6zg==
=Aj8L
-----END PGP SIGNATURE-----

--zcz4msxiltmbuo2j--

