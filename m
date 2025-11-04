Return-Path: <linux-can+bounces-5313-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B917C312E0
	for <lists+linux-can@lfdr.de>; Tue, 04 Nov 2025 14:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E28429C29
	for <lists+linux-can@lfdr.de>; Tue,  4 Nov 2025 13:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C31A2D641A;
	Tue,  4 Nov 2025 13:13:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8B12F3C11
	for <linux-can@vger.kernel.org>; Tue,  4 Nov 2025 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262030; cv=none; b=V38wjWuxBSGYOwvtlQLGHPcJIWBrCSzdgUyzvhb1LgaJ+BslhTFdyR49U+Q2gEr+OOsvFWtAt9EICernkDBBWuQGNDCtyV7hXc1V7G5yWfjkYeOrxw5+6txtGhy69dyEiVE++eMlPG/lB0/K88fioWJZigvAdJQf5NMAZ8mXc2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262030; c=relaxed/simple;
	bh=GckWwBIRAcR7GlfxyhW8Qlg9/HGMPl5riOm3vIfm/lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mersMu+MgcLhPOEbLsJodB6bDKAeNrOkkvmzyZXrtZ11hz8C88ik8bsWVbpvFJtYSwfe16zbo+6tWkolgxpfqmQwO9oM6c+tmPXUccRd0nKuiQka59Qy6gQPERd0NyxpFAU5ZOBd3P9tB04l+7UMTS3QbGb/ftryp6phIJOhGdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vGGqu-0000Ya-RE; Tue, 04 Nov 2025 14:13:36 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vGGqu-0072JK-02;
	Tue, 04 Nov 2025 14:13:36 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A9E894978A9;
	Tue, 04 Nov 2025 13:13:35 +0000 (UTC)
Date: Tue, 4 Nov 2025 14:13:35 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>
Subject: Re: [PATCH v2 00/10] can: netlink: add CAN XL
Message-ID: <20251104-spicy-junglefowl-from-venus-4d4f96-mkl@pengutronix.de>
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
 <743ba133-3735-48fd-994a-9727cfe8c114@hartkopp.net>
 <69303466-a9ed-44cb-a1a9-30ac1451e7cb@kernel.org>
 <3d7521ba-bd71-46b0-9642-728a5222f2d6@hartkopp.net>
 <20251104-refined-winged-mamba-fd8cc1-mkl@pengutronix.de>
 <570e0ca6-97ea-42d5-8604-4bc04c2fa1af@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kyqvbs6gavjrzcpn"
Content-Disposition: inline
In-Reply-To: <570e0ca6-97ea-42d5-8604-4bc04c2fa1af@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kyqvbs6gavjrzcpn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 00/10] can: netlink: add CAN XL
MIME-Version: 1.0

On 04.11.2025 09:01:00, Oliver Hartkopp wrote:
> > Can you post your tags under the cover letter, so that b4 will pick it
> > up automatically?
>
> Done!
>
> Didn't know that there is an automatism for that.

With "b4 shazam -k -l -M $MSG_ID" b4 will fetch a patch series, run
local checks and apply it with all review headers.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kyqvbs6gavjrzcpn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkJ+/wACgkQDHRl3/mQ
kZx0mggAm6FXmTPn0HeMotfq/XspiK98uwLuOPYGQeVcDZ5fLeaipCchEOMMJYtH
5/o6JjetQ/GSIYmddLGnA1lJUcqaKqeuB2eW0WNZ6d/WMjZyfYS0LZ13+koX2cAk
15W3Jc/ZE1Eayolc4BgUcwe47W9EZYcwsRVpoEzML7H7znQbn+XOzQAy5dp6qzbC
xqbRY/YIVuqSjSmR/LiR7mdrkgcGHPLI6ArsjiPPC0FEYB7WpGkN+LHhQckPXjZn
QM7/5AOa+VSsTvzDjLelOCndZwxQUoQEp7TMp1P5+/Z8TPWNBCnzXAQk4pmkrmhr
LNOml0DPV0lzyhUJ5nCv7nRgGmZsXQ==
=ovEU
-----END PGP SIGNATURE-----

--kyqvbs6gavjrzcpn--

