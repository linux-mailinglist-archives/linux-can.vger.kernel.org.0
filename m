Return-Path: <linux-can+bounces-5345-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C206C512A8
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 09:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89921896B7D
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 08:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319212FD7AE;
	Wed, 12 Nov 2025 08:46:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7562FD69F
	for <linux-can@vger.kernel.org>; Wed, 12 Nov 2025 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937162; cv=none; b=AkdnReewrtfgtkblm/PLDr5uqQvjtixtQTHsgBrZsZsTZm4CZrAJ/SvuHk5gLqFDJtB0b5L7aOF/r/rX5msL2x/tl/VZquI93SJ54Vq1oCahrpE28m6LTl4vzH+CVri275aUCzYVd4IbarvyK5cA0WIMCLq4GxdrHyMLfbF8uH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937162; c=relaxed/simple;
	bh=FAKW9/PO4Tviz9rGB02IgVMpyJMsgsoIo7KmmNYxoUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNeO4G72vfatnIqjm/9GVLFgG5AULbBPaPO2tfBIKLmphp+JQuuyYWeUJ5AbGGt33YlwPrGS58esjebTndpsposJBxzN1w1W8rwqsE4D1fEj5PAoTlj4uGdHMUiwR2rOywVxTSXVKikQuvQvkprPNgLGvSaCDJYLNIoVzBvYvb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6Ty-00020B-9x; Wed, 12 Nov 2025 09:45:38 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6Tw-0003I3-2y;
	Wed, 12 Nov 2025 09:45:36 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9A03C49D925;
	Wed, 12 Nov 2025 08:45:36 +0000 (UTC)
Date: Wed, 12 Nov 2025 09:45:36 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>, socketcan@esd.eu, Manivannan Sadhasivam <mani@kernel.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Jimmy Assarsson <extja@kvaser.com>, Axel Forsman <axfo@kvaser.com>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, 
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 0/3] convert can drivers to use ndo_hwtstamp
 callbacks
Message-ID: <20251112-purring-porcelain-hamster-dfc149-mkl@pengutronix.de>
References: <20251029231620.1135640-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xr7ib4q3lr5isf7n"
Content-Disposition: inline
In-Reply-To: <20251029231620.1135640-1-vadim.fedorenko@linux.dev>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--xr7ib4q3lr5isf7n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 0/3] convert can drivers to use ndo_hwtstamp
 callbacks
MIME-Version: 1.0

On 29.10.2025 23:16:17, Vadim Fedorenko wrote:
> The patchset converts generic ioctl implementation into a pair of
> ndo_hwtstamp_get/ndo_hwtstamp_set generic callbacks and replaces
> callbacks in drivers.

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xr7ib4q3lr5isf7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkUSS0ACgkQDHRl3/mQ
kZzzxwgArsFsKQQHeRIjGxCOSMthusW8F/FTUAMB7+MlB+OcgGEzmM2Nu27PozEe
PTld0SStdW49G+ZnXphfSUIRL5wQOlKJHfmVXM2L0JLJ+q6n8/tEq/VFFnMFcAXK
FNyTrxinAR0Z4mSQ1e2yd/p94w59QTxiw/3rvMZwnr6sq4vvCbiXVJsm0ezQ8Mz5
JE1KHQ1lY3UPixB/ZxWFM0JakvLa849NTOHLSeMA/JWnsggien78+s1zgFAt9dhE
MSAvfYQsFqIHbm8RaNHJsNtUbLBsvKHEuwtujQ9OeQZAST5Xn+6WCkgBZXL8k5WB
LtuO84NyV+OePlRCfN7ONeHxwOvDWQ==
=ZgBX
-----END PGP SIGNATURE-----

--xr7ib4q3lr5isf7n--

