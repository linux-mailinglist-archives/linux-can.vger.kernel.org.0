Return-Path: <linux-can+bounces-5693-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DCBC89459
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D1C0357CAF
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC8F3064BC;
	Wed, 26 Nov 2025 10:25:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3159F3090C6
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152739; cv=none; b=EcFmQmR5ktAwzFPRLRLhUtO36H4PdzA5z5NHFGy2HKCXxLQ8wfkl8VFIUuVLggpwld3Od9EWvFFSIV5cKurvbLm+XJ7XS4pqkUuuZtzPhvat9wFBI6+HGOQ4tHsxiq8raKZAm6CGN0bwBf1XonNuj701jqjj+Ze6uqkTGvSJDfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152739; c=relaxed/simple;
	bh=fCrsqHG0Tuk0e9vjO7jMZQAKc5fd6/8Qk/+Hu2afahs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJSYnCer7apsKNqaMwx1wxcZ+xhgTNK8yx7bLigLce4V22b3Mtpzrp/YNMnInER2XIxYjNyjoA4WYVIgdh33joudLv4dpCJ86kLVG8Opqv5xbHYF82SIFFwYejI7ez0QNA0SKtLEwj3DqsbDZvkubQpCQeZ+eBzm2TuLhIGK1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCiM-00029G-EW; Wed, 26 Nov 2025 11:25:34 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCiL-002aUO-1O;
	Wed, 26 Nov 2025 11:25:33 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 344C34A895F;
	Wed, 26 Nov 2025 10:25:33 +0000 (UTC)
Date: Wed, 26 Nov 2025 11:25:33 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] MAINTAINERS: Add myself as m_can maintainer
Message-ID: <20251126-boisterous-spiritual-urchin-1edc8a-mkl@pengutronix.de>
References: <20251119-topic-mcan-reviewer-v6-18-v2-0-f842c3094b18@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7quptnkvzdrbp3d5"
Content-Disposition: inline
In-Reply-To: <20251119-topic-mcan-reviewer-v6-18-v2-0-f842c3094b18@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--7quptnkvzdrbp3d5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/2] MAINTAINERS: Add myself as m_can maintainer
MIME-Version: 1.0

On 19.11.2025 14:50:01, Markus Schneider-Pargmann wrote:
> these two patches are updating the m_can maintainer entry, replacing the
> current maintainer and simplifying the files mentioned.

applied to linux-can-next

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7quptnkvzdrbp3d5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkm1ZkACgkQDHRl3/mQ
kZwmRQf+JxZYQp1vbG7f7/qh+KDErTBirCZRXUu/DhkxyUklBZVV2q9t91O85Okn
8ov527TIKR6rWN2A+peMZi+xdQ45O6DutDyh2PpvfU4KvZTMf6ZY2OabhBTAURro
HGjR0blc+6ghZkOvFXwazs3xNvrVGUOgrXMuqMw0M9uYU+EdTFiNZJaPQcQwKz03
E/X7tYGk0hrv+dUZ/6NBIMPiAYrSNwMSw2FR3KRn+FN+Nz/Y8aLeHW7d+e5VfA2F
0z6YTYNFTGzFGeKGwTcgnGiq9s52yoJxHYrfGvsOzIohT3g/H/GQ7nTmfypgxyYH
I77IcTGsDfcuIYvHzReTpTicQWu5Zw==
=aVug
-----END PGP SIGNATURE-----

--7quptnkvzdrbp3d5--

