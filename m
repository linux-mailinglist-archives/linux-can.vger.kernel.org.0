Return-Path: <linux-can+bounces-5266-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ACEBFDB58
	for <lists+linux-can@lfdr.de>; Wed, 22 Oct 2025 19:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DBC3B1162
	for <lists+linux-can@lfdr.de>; Wed, 22 Oct 2025 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37262DF147;
	Wed, 22 Oct 2025 17:47:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141982DEA67
	for <linux-can@vger.kernel.org>; Wed, 22 Oct 2025 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155220; cv=none; b=nc+mIrBuYFGcCXVdeJIl6OXRw4PU6h+eQjEflXpAxxmlG7BF6wF9bktHQd4IPxZYExoPJ6R5/CrlUMGx/3eTR6DLogBpSzrxGi0U7RvZqxdHqB5LbHcFIw4dJ/Vy6swubVzc83+ksgrSvBlNloT0Dv41yMiBftwapn1KLPWnZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155220; c=relaxed/simple;
	bh=YFJDQxVXGIt2EVvzI4UDLWngSrJVYknKXX4lJa0qIvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGir5QOv3YOLYRGr9NF1vq68kOtpCAIsJNGCPV5s6V/9DaKf3en3a209aTlZGsrMbP0H9Wut78Vm8DoFccb0ZF7dLKu+KywIXhJ6jb50zIQUwudIqj0qsNOdATNuOlf3fMzPAqeRNEG1qVBAjbNWOSJFFCLlDnjaSmutSxMDvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vBcvD-0005QR-OG; Wed, 22 Oct 2025 19:46:51 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vBcvA-004vcd-2A;
	Wed, 22 Oct 2025 19:46:48 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5D05048D5D9;
	Wed, 22 Oct 2025 17:46:48 +0000 (UTC)
Date: Wed, 22 Oct 2025 19:46:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as m_can reviewer
Message-ID: <20251022-lorikeet-of-fortunate-plenty-43e085-mkl@pengutronix.de>
References: <20251022-topic-mcan-reviewer-v6-18-v1-1-885ec5e43493@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zocc6mbgpq6p4hwg"
Content-Disposition: inline
In-Reply-To: <20251022-topic-mcan-reviewer-v6-18-v1-1-885ec5e43493@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--zocc6mbgpq6p4hwg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: Add myself as m_can reviewer
MIME-Version: 1.0

Hello Chandrasekar,

I've seen not much review feedback from you....

On 22.10.2025 11:10:09, Markus Schneider-Pargmann wrote:
> As I have contributed to the m_can driver over the past years, I would
> like to continue reviewing new patches.
>=20
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46126ce2f968e4f9260263f1574ee29f5ff0de1c..835dfe1a16c975fb3ab46bc7e=
d736cde61ec0bf5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15394,6 +15394,7 @@ F:	drivers/net/phy/mxl-gpy.c
> =20
>  MCAN MMIO DEVICE DRIVER
>  M:	Chandrasekar Ramakrishnan <rcsekar@samsung.com>
> +R:	Markus Schneider-Pargmann <msp@baylibre.com>

=2E..Maybe you want to give the maintainer hat to Markus?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zocc6mbgpq6p4hwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmj5GIQACgkQDHRl3/mQ
kZw6ZQf8DfrpXASMNYTe0xbgYAb39s9gFmgnVNWr2BZn9Awhy5+jhDvkhtk/5zdi
Lx9wJRkKCTimAnTmk6YRSHtUlnxfBeax3swLWUQ4vGI5twAudHyeJgoOfIcoGLQd
9gQ9/LxDWvGq/T96LRTJq3O2+VHDfPxz9U70o+CGIzZcHRFLqadIt/gJPV6zmbex
hsY9YQfhR1nVRQJhBSb9SSR725SUPs3qEIqDZ5Z7QycPMvk8OxSdVJ87UeMvvnng
gNZWP0U7dkUSQSxNyP86CmCUJV/dwXqkhR84rAy+s22xCueCgVrYV884GlpZ4UPm
ZZKl0FbFpNxihlhKbmv5d+7HAYU20w==
=MIld
-----END PGP SIGNATURE-----

--zocc6mbgpq6p4hwg--

