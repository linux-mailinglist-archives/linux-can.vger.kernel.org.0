Return-Path: <linux-can+bounces-5566-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B42AC79143
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 13:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE7543652C6
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 12:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C87E314D31;
	Fri, 21 Nov 2025 12:50:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA4312816
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729451; cv=none; b=pFfjodyecE0mVV4AId/xoXEmseAkU/PiY9+2vGkwr8pN/o8hp1p79LmqI7IihjIKOWBFTYrxZPxywcV/Fr2FmbhkldZ80wQTq1abZY1r9ycIb9/LaPztXfXedWOcdWXm24SqkotbLXDP3Pf3hFdb16l+2ZCAGuHbLHMxF5whJaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729451; c=relaxed/simple;
	bh=nuAgXnT0yJUtOi2Mxh14DBYxKMmztnKuFnvkyNwb8ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Clf3zmLcq7zqHW3SFRJn8apBdjC1V/sqDMg/yRQYvv+QrsPA2UmIwDFokhLs8F6T64Soku5rKQu01JNGPrmZZnxbvEu0Qh1+PO81aN4sLD0Pq3q1/lQ+3w2szQaA7fSEq4requAnDb9WtcY4/TxyOoz3Vt/IgbuXUyILBzWJBkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMQb3-0000hr-3U; Fri, 21 Nov 2025 13:50:41 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMQb2-001aYY-2m;
	Fri, 21 Nov 2025 13:50:40 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 868544A47E3;
	Fri, 21 Nov 2025 12:50:40 +0000 (UTC)
Date: Fri, 21 Nov 2025 13:50:40 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mailhol@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, Daniel Hellstrom <daniel@gaisler.com>
Subject: Re: [PATCH 08/10] can: grcan: Add saving and restoring of CAN FD
 baud-rate registers
Message-ID: <20251121-daft-vigorous-leech-7719b8-mkl@pengutronix.de>
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
 <20251118092115.3455-9-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jcwc2stiqp4lcayd"
Content-Disposition: inline
In-Reply-To: <20251118092115.3455-9-arun.muthusamy@gaisler.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--jcwc2stiqp4lcayd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 08/10] can: grcan: Add saving and restoring of CAN FD
 baud-rate registers
MIME-Version: 1.0

On 18.11.2025 10:21:13, Arun Muthusamy wrote:
> From: Daniel Hellstrom <daniel@gaisler.com>
>
> While reset the GRCAN baud-rates are preserved, since GRCANFD has the
> baud-rate in different registers we need to add saving of those
> registers too.

What about removing the do_set_bittiming callback

	priv->can.do_set_bittiming =3D grcan_set_bittiming;

and calling grcan_set_bittiming() explicitly after the reset?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jcwc2stiqp4lcayd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkgYB0ACgkQDHRl3/mQ
kZyQvgf+LrZ7L1g9G2ILODLcLl0ZrOxbVaeLZ0z2nh+FFYAQzV6kmyWZapkHc56n
72C1Jiv+hatI6TkLMD7rSdmT8d7ttXyvHJadh5p4Rw000la0HvqUmS3EaO177gYJ
RgXKGSLsuRFzgBubwNIeDWxMBwYNoartwi4OpVJoV1k5r/ssTdt4PPvLaPL4ByWv
FTQI9QMKqsEMKm8dEYwcgzwbtQ1fBJvSaQ3CQo55GWOvMon/6tH/J8XaF97So2D0
QsxCatYLBTDJNXyNjXJ7hB7FBl/cqjEEqZGCL5MugrHw62M3b24w2ap3LY5JCiFj
ayyy3sTRHvvWPsb2DPc4XkNWjKLs7Q==
=jkOj
-----END PGP SIGNATURE-----

--jcwc2stiqp4lcayd--

