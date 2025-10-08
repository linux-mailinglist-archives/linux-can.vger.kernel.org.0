Return-Path: <linux-can+bounces-5102-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53CCBC3D09
	for <lists+linux-can@lfdr.de>; Wed, 08 Oct 2025 10:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF253B9ED2
	for <lists+linux-can@lfdr.de>; Wed,  8 Oct 2025 08:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B307129992A;
	Wed,  8 Oct 2025 08:23:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF2013D521
	for <linux-can@vger.kernel.org>; Wed,  8 Oct 2025 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759911824; cv=none; b=hnc9inTp84UEJXwE7hcsmjd41dHChSTJFXROHOQnsEo8OBNMaH1xB6Z+91MKd/V3ST9/Gik9Qt5PyhdvFIvPKPZjO01LSrSlQe4NsejXwweusysqV5gsQPs75+G8weY6TCLjGbmdqOn6Odt4ougWTxqxZ3lsaP2HR9pXfHAMWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759911824; c=relaxed/simple;
	bh=BpsJk/gZUERHr1u8VCXIuy5IQnCxlaDaq+DYZxjaA9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kl/qdywdTnp8GDHSSQ7a75A86AC+GS/7I+je+nFTiqWymIdazg5eH+xVcQRAAO6kYkzTEUshJh+fd4ODgjLFINqjOVOELWH3syEbR3qbYvM4FJMUENp50F+B+vZeC5kck9A3xEWyEcZzDg0T8szmPSqdwx1olzvRhO6F8gOl5aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6PSN-0005wP-6n; Wed, 08 Oct 2025 10:23:31 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6PSL-002XPK-22;
	Wed, 08 Oct 2025 10:23:29 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 424DC481CCB;
	Wed, 08 Oct 2025 08:23:29 +0000 (UTC)
Date: Wed, 8 Oct 2025 10:23:28 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol@kernel.org>, Patrik Flykt <patrik.flykt@linux.intel.com>, 
	Varka Bhadram <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v4 0/4] can: m_can: fix pm_runtime and CAN state handling
Message-ID: <20251008-versed-diamond-caiman-468c04-mkl@pengutronix.de>
References: <20250929-m_can-fix-state-handling-v4-0-682b49b49d9a@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6s3m3eh5j6u7durc"
Content-Disposition: inline
In-Reply-To: <20250929-m_can-fix-state-handling-v4-0-682b49b49d9a@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--6s3m3eh5j6u7durc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/4] can: m_can: fix pm_runtime and CAN state handling
MIME-Version: 1.0

On 29.09.2025 10:40:12, Marc Kleine-Budde wrote:
> The first patch fixes a pm_runtime imbalance in the m_can_platform
> driver.
>=20
> The rest of this series fixes the CAN state handling in the m_can
> driver:
> - add the missing state transition from "Error Warning" back to "Error
>   Active" (patch 2)
> - address the fact that in some SoCs (observed on the STM32MP15) the
>   M_CAN IP core keeps the CAN state and CAN error counters over an
>   internal reset cycle. Set the correct CAN state during ifup and
>   system resume (patches 3+4)
>=20
> The update of the DT binding for the reset property is upstream:
> https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git/commit/=
?h=3Dstm32-next&id=3Dcfd856da6cf561f7e1dc6b16f3453814cde1058e
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Added to linux-can. Removed mentioning the DT bindings update from cover
letter as these patches were removed from this series.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6s3m3eh5j6u7durc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjmH30ACgkQDHRl3/mQ
kZw4oggAnxUBQ9ntEpLqRzWaij4yRHZUe5RPVDAj82j5luWmg8JgLtV9874K89sN
UXildvP+dgYbZGKOGB8Mr3ZBi+5Ky4LIqErBwkM6VEnKfoF8plDfXSAzEUyivt5Z
0CA/M1wZhspYpOgsnj3DFFvlDMpUPj2SuM2dKN2RBSybWWakwN+EY0eMLVSTB0Rm
kY728IKeZEWQ1zZYcE/cHEakODllRmMRuP1RHzyk5GPbnd8WV5bxjHkAddQdGCGk
n0IYeVN7d9HyjT0LOxZUiHt+ixasvTD+DhE7O8DM4EBcciO4PsphSZqmk499+jqN
UIqa20Bud5pCQ89YUvobNEgpZVu38g==
=oguY
-----END PGP SIGNATURE-----

--6s3m3eh5j6u7durc--

