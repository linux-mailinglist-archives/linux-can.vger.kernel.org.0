Return-Path: <linux-can+bounces-4026-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85C5B0D77B
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 12:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C733162899
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 10:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF08288C0F;
	Tue, 22 Jul 2025 10:41:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5807DA7F
	for <linux-can@vger.kernel.org>; Tue, 22 Jul 2025 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753180894; cv=none; b=TZh6PTVBMwLyhiAsPMxi27Xe0XsQM/cOYArBR2pBPusisHnR/9IkOabbiWxlydMMPsTTHLH9ExY5RsnDnQCZ97bSDa6HlS4zMUcoCkrfV18AlKpu2YrFagF690kf1HNObrF9p484T9O6UD1zY6YIi3uJ25epugpKNCXGZDIHFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753180894; c=relaxed/simple;
	bh=Bm+drY1+FBOiszmInR5pRtFvHGfuncjYGS4zRB5DLv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMDGWqnstaZV1kgd7T52gCmYWnkVgwmT1YGBHiSToH3487ON5FKpjrHoUsEoPIOjJSRrEEQI6WOLplbEP25Hj/5Tc5lcqS17gwW0QMF6EcloFEGZVDCt9Cc+6RrCiCMkyMAzAovcpw5/5KTAwQM2+KRwXWXYO89kOlArxgPqcR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ueAR6-0002fs-Mw; Tue, 22 Jul 2025 12:41:28 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ueAR6-009i0Q-1F;
	Tue, 22 Jul 2025 12:41:28 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 178D94463A5;
	Tue, 22 Jul 2025 10:41:28 +0000 (UTC)
Date: Tue, 22 Jul 2025 12:41:27 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Pavel Pisa <pisa@fel.cvut.cz>, 
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Ondrej Ille <ondrej.ille@gmail.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: Fix kernel-doc error in CAN driver
Message-ID: <20250722-warm-stereotyped-falcon-edfbf9-mkl@pengutronix.de>
References: <20250722035352.21807-1-luis.hernandez093@gmail.com>
 <202507220837.23333.pisa@fel.cvut.cz>
 <399941c7-2ee5-4d8b-a7c6-c8ed7d85b565@wanadoo.fr>
 <202507220957.14122.pisa@fel.cvut.cz>
 <83498a43-9e39-44ae-821d-7a7492f57a83@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hoe54zqjfgsfiff4"
Content-Disposition: inline
In-Reply-To: <83498a43-9e39-44ae-821d-7a7492f57a83@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--hoe54zqjfgsfiff4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] docs: Fix kernel-doc error in CAN driver
MIME-Version: 1.0

On 22.07.2025 17:50:56, Vincent Mailhol wrote:
> On 22/07/2025 at 16:57, Pavel Pisa wrote:
> > On Tuesday 22 of July 2025 09:27:39 Vincent Mailhol wrote:
> >> On 22/07/2025 at 15:37, Pavel Pisa wrote:
> >>> On Tuesday 22 of July 2025 06:06:30 Vincent Mailhol wrote:
> >>>> On 22/07/2025 at 12:53, Luis Felipe Hernandez wrote:
> >>>>> Fix kernel-doc formatting issue causing unexpected indentation error
> >>>>> in ctucanfd driver documentation build. Convert main return values
> >>>>> to bullet list format while preserving numbered sub-list in order to
> >>>>> correct indentation error and visual structure in rendered html.
> >>>>>
> >>>>> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> >>>>
> >>>> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >>>
> >>> Reviewed-by: Vincent Mailhol <pisa@fel.cvut.cz>
> >>
> >>                ^^^^^^^^^^^^^^^
> >> Are you trying to impersonate me?
> >>
> >> Can you reply again with the proper Reviewed-by tag? ;)
> >>
> >>
> >> Yours sincerely,
> >> Vincent Mailhol
> >=20
> > Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>
> >=20
> > Excuse, I have been in too much hurry.
>=20
> No problem :)
>=20
> Marc, b4 will not be able to manage the review tags correctly. Can you pl=
ease
> fix it manually when picking up the patch?

Thanks, for the heads up.

I wrote to the tools mailing list and described the problem, maybe
someone comes up with a fix.

Applied to linux-can-next.

Gr=C3=BC=C3=9Fe,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hoe54zqjfgsfiff4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmh/atQACgkQDHRl3/mQ
kZzcpQf/TPgIhCNfWhl9hMIwy5Sh45WDOgOksaQcRTQNjqpsIeClSCw++ynTDmtu
iXPtmczEgpNna7Py3U8JTB9Nf0sQMO/d1wApTAVAVEDSp6C8V9XcqB6lVsDK1FFV
1EOFbKfeS9DOozbRfmQCnuRcjsCpgI7iYhFjGypNhI+BXyuwXzeZL+aJqX3JZlyZ
IUwCILgRvewziCNrLZBHSpAHLn0dRKXLZYWoQVok6t0pC6whtHx39ReU5BYy9kD4
69e6ahSey82Ia8sqxFkfumEEp3j6l4GARchGSSPb7jYYuSiumyQidwuhkSwn/szj
nCDG2+/Lj7RAG+76X0bMmSLUE73Uog==
=v+KC
-----END PGP SIGNATURE-----

--hoe54zqjfgsfiff4--

