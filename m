Return-Path: <linux-can+bounces-4561-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E256EB4AD0D
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 14:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38263346DE6
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E479131C592;
	Tue,  9 Sep 2025 11:59:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D7A322A2F
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419199; cv=none; b=E8t9LrV7UXeusgjku3W7yGn5z8kClOTdk40035kUckXIvAyxi6fXePqTBPNfiE8gSfBLI014IjIIm/nzH8zy+IoR77F+kgHbkAjdyfx7Y2JJmhsuTKeDYAqjWeMWmMyp+v+fTCO+3pmynqWWZ5xI2FW9yHuQtfBfzYvogzj7X9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419199; c=relaxed/simple;
	bh=cv+uZlUT6vEvScvKtWqrhd9kTWqLzZTRw1OQFiJEWmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgZeIj9Hs3NPKPhIadsQYsEfLwLzxo4t/AI5TSUu7bKF36A2Jac9c9UZnSM8yWQ7ASomLtzVPxp4wKKyZxfT7tu2I0BffX7JjhcriTOW2D/Le9JX0B+/Xu9wE58uS15OXgDYG4WpfujwZuxrqPK6zzOY4SpHnrc4J6czJf90308=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvx0p-0005xh-TM; Tue, 09 Sep 2025 13:59:51 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvx0p-000Pef-0A;
	Tue, 09 Sep 2025 13:59:51 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9C2A3469EA3;
	Tue, 09 Sep 2025 11:59:50 +0000 (UTC)
Date: Tue, 9 Sep 2025 13:59:50 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alex Tran <alex.t.tran@gmail.com>
Cc: socketcan@hartkopp.net, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: networking: can: change bcm_msg_head frames
 member to support flexible array
Message-ID: <20250909-fancy-practical-labrador-360abc-mkl@pengutronix.de>
References: <20250904031709.1426895-1-alex.t.tran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ybaodxp5l6dt5ozv"
Content-Disposition: inline
In-Reply-To: <20250904031709.1426895-1-alex.t.tran@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ybaodxp5l6dt5ozv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] docs: networking: can: change bcm_msg_head frames
 member to support flexible array
MIME-Version: 1.0

On 03.09.2025 20:17:09, Alex Tran wrote:
> The documentation of the 'bcm_msg_head' struct does not match how
> it is defined in 'bcm.h'. Changed the frames member to a flexible array,
> matching the definition in the header file.
>=20
> See commit 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with
> flexible-array members")
>=20
> Bug 217783 <https://bugzilla.kernel.org/show_bug.cgi?id=3D217783>
>=20
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ybaodxp5l6dt5ozv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjAFrMACgkQDHRl3/mQ
kZwMVQgAhkVtHUkjTmnDC/Eo55aUQlbKqkygE2QbunJu2Bjgumo2AanbdTabE8jH
FQAdzb9TfmAdwkS+pDMp5MEvzzD2ywPFSWptvv4Y5jqgywhf/poiKRiQDtVsB0+4
qy1mSJX8MlBzyY4UE4UuGpNytm3LsLSbiu9BeHmvi9ioYIkmtDqcXUb0/khhpJo0
VrgSXHwGvfNb2HW5eX4ghIYRxPt9+nFP1e3qI6MENbb0xdAPxreJPPgSGMcu9A4B
L68OmLU9kpOshcGmAXr6sGfRgyDcnK7Qy2HkGy37HP0IRsEd72OXaE3ES1Zps4FA
zRxmpBlzuGRBEmdryt/Uk/SxOeyATQ==
=0Pxt
-----END PGP SIGNATURE-----

--ybaodxp5l6dt5ozv--

