Return-Path: <linux-can+bounces-2849-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25940A3BAC6
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 10:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B601885675
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 09:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C221BD9C6;
	Wed, 19 Feb 2025 09:46:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5C61C173D
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958382; cv=none; b=Nu0+08sDFl32rH2HyACCtA2e2l84VvVF79d6KyCEBbM8y3gez+ommnoLnJgrJ1J9kYhwk02w1DrhbWpI5uGsZ6yEmpXM6vOWWgNifvZYG7rrAKXZv+o96UnLus7YAP83ikiBwB8HnQ32yTrB5eMv0A4/y6IqSy3O/g0k/QlOEII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958382; c=relaxed/simple;
	bh=6VQ4aEJy9a96AQdVkahptEXSrtt0nmZNJQD2h5YtIQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDJj9s7tR02ful6Q2LsNLS/bcNw5L3FKtZgYCwb10d2yWbTLhybOIEnt1b41bk2w5/4l3uHue2DcOS0bPHplipi6PX+NvqrZ+/DswkHJ2jrNMug+5YxMUuzW3MfN00aogEY3y8vUg0LRdRQsT2b3knG+ZMG0s5KeVMDgVQb6wbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkgen-00029E-De; Wed, 19 Feb 2025 10:46:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkgen-001jyo-0K;
	Wed, 19 Feb 2025 10:46:17 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BDD683C67B3;
	Wed, 19 Feb 2025 09:46:16 +0000 (UTC)
Date: Wed, 19 Feb 2025 10:46:16 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Tong Zhang <ztong0001@gmail.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RESEND v2 0/4] can: c_can: Simplify few things
Message-ID: <20250219-intelligent-fragrant-lionfish-a1e11b-mkl@pengutronix.de>
References: <20250212-syscon-phandle-args-can-v2-0-ac9a1253396b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="srd62ye3iaw732cc"
Content-Disposition: inline
In-Reply-To: <20250212-syscon-phandle-args-can-v2-0-ac9a1253396b@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--srd62ye3iaw732cc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND v2 0/4] can: c_can: Simplify few things
MIME-Version: 1.0

On 12.02.2025 21:23:11, Krzysztof Kozlowski wrote:
> Changes in v2:
> - None, just rebase and drop applied fix.
> - Link to v1: https://lore.kernel.org/r/20250112-syscon-phandle-args-can-=
v1-0-314d9549906f@linaro.org
>=20
> Not tested on hardware.

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--srd62ye3iaw732cc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme1qGUACgkQDHRl3/mQ
kZyhSgf8DyLEUYoXYmDa0PqcV0NWi7+V90cDHTAMBjtZJD/06rCwNVYZubsgqBMG
H7MxPwh0HhHHKdDZ/dEZR7caaXhGNinZOoKG7jtxUV8P4Xrb9V9Y8mRGn9+IlGoe
Nu4kqPBqE6htMpvmFCgnzu21KEhexyaDsYAQwQlN4uQgnblqtds5+/s90ABAOMTq
PHsWuKXTsOutNR0zdrqvhRuRQqadsy/NWOh8/TwhWe1t8dAyGhYDixzIqq4F6Kfx
RxIUMtEKw/LnnXHwubo5N04h9IpTumM2q9JVzplIZl2a0gStiTICEfeN7J5+6rnf
msGnFNSeeW+sak+MEXiWrOCzCcgDBw==
=33r+
-----END PGP SIGNATURE-----

--srd62ye3iaw732cc--

