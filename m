Return-Path: <linux-can+bounces-2570-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0D9A08E3B
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 11:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81B91692EE
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 10:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D36920ADE7;
	Fri, 10 Jan 2025 10:42:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4291B4F14
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505727; cv=none; b=Fl0aEzQvKoT+LejhAl7TDE8R+n29vPQU0dXR2Vns9q1jaYryLOarXCT/QOzF/BuLkDxzDR9qQDwo3db9XM+oLsQ+TNZMqn1cV1TkHY4s30JHvuKyRgCaHAU6xS8YYoncwXrzhMbTpfVl9mHrCxoGLG5TN+TvAqNYnzw91lfwGQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505727; c=relaxed/simple;
	bh=2t6560ciqPluM5jV4icj76vKmnBYruYYY1iaoWGUwOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOqG64FQA8oK10koq0T9iVxneo2sa+j5iFDhIs7ZYapHXCYByFuIKhlb47x2wcACYHgw66OcICGka/XL+At0nVDeKED8aPTgHtr3scIYI0BCvJDK++NuY/Z778LAXI4HgZmi4dup5EGtSkxr3w4DImjOeGyrGztNJaUxNzwgkgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWCSd-00010v-9s; Fri, 10 Jan 2025 11:41:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWCSc-00090F-1b;
	Fri, 10 Jan 2025 11:41:50 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 216863A4529;
	Fri, 10 Jan 2025 10:41:50 +0000 (UTC)
Date: Fri, 10 Jan 2025 11:41:49 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: remove duplicate word
Message-ID: <20250110-screeching-quixotic-tanuki-1e6fa0-mkl@pengutronix.de>
References: <20241120044014.92375-1-RuffaloLavoisier@gmail.com>
 <20241120-antique-earwig-of-modernism-1fc66e-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ip3hmrnf27rnbmsn"
Content-Disposition: inline
In-Reply-To: <20241120-antique-earwig-of-modernism-1fc66e-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ip3hmrnf27rnbmsn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] docs: remove duplicate word
MIME-Version: 1.0

On 20.11.2024 09:27:22, Marc Kleine-Budde wrote:
> On 20.11.2024 13:40:13, Ruffalo Lavoisier wrote:
> > - Remove duplicate word, 'to'.
>=20
> Can I add your Signed-off-by to the patch?
>=20
> https://elixir.bootlin.com/linux/v6.12/source/Documentation/process/submi=
tting-patches.rst#L396

Is it OK to add your Signed-off-by to the patch?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ip3hmrnf27rnbmsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmeA+WoACgkQKDiiPnot
vG9LlggAlAOvAjXwwTntSfaNIv3HMCQcKByFRx2L9fN9+YOvmAfaAZuwlgi9Qzed
2Z+XbYsa3t3SOK/5+FbeNu1tWs3mu8cpYpserlakQb7g6V3Bel2LxlqR3W9hCdI4
Z8y0KbKTTRrWGmIdiOeP6AbZph0H1szaMuP4S0VmTg54HlZX0loblaQ/XCOc0PmS
KByCbK7C/u3665FnM5PM0BndSGku9kg43FpnENKr3/eExZsSgMj7Ji83ua/7wOKe
44rBWSCCvG9Ns+eLzepDW5JXqqnGP2ycpTBO3qeEDu/iTVMdP3xqBUbP+9HRqEp4
YIhdcUlVTIr9G1eSi8SXllPLNg+6Dg==
=iCBi
-----END PGP SIGNATURE-----

--ip3hmrnf27rnbmsn--

