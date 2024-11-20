Return-Path: <linux-can+bounces-2140-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1430C9D3A39
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 13:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB432848B0
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 12:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1319E7E3;
	Wed, 20 Nov 2024 12:06:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E44619F41C
	for <linux-can@vger.kernel.org>; Wed, 20 Nov 2024 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104413; cv=none; b=N8i8jEToobAEhD/sTTn7DFu6CCu0MH5J+sJGGs4FlQOreb4AdjDAeZyfE8ejDejy11tJAJgT55r5ExRJO33eIT4hsQqiuT7ciyyikNFVSFOGvWmLnmWRx4VjhrRe6lecjgL/g3LGhvajguV4CM2Nm/LxX40Ae8yPMoYQKYdvmvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104413; c=relaxed/simple;
	bh=SSGS0r9eKeb50eUbueDOCYyOi5DPHSMpT4Nqdp7ulTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAURfAAE0kCsP6qJKLvqWnhMYVH2DkNIye5HcswUpADHNRXkNphCq9mCVZDX+je0CTIoYZfQR0bxseYfBpctTM/5pGxb7u3/FsQyBc/zxuVB9sKsNHE/o5auUYRAQIGTPGOXcSce8+L5D0nT7ehmSJ2grAIoS+E8updiXni7ha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDjTf-0006Ro-1F; Wed, 20 Nov 2024 13:06:35 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDjTe-001jeA-0S;
	Wed, 20 Nov 2024 13:06:34 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B9627377D05;
	Wed, 20 Nov 2024 12:06:33 +0000 (UTC)
Date: Wed, 20 Nov 2024 13:06:33 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, NXP Linux Team <s32@nxp.com>, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt
 lines
Message-ID: <20241120-angelic-coral-chital-c0f884-mkl@pengutronix.de>
References: <20241120-magnificent-accelerated-robin-70e7ef-mkl@pengutronix.de>
 <c9d8ff57-730f-40d9-887e-d11aba87c4b5@oss.nxp.com>
 <20241120-venomous-skilled-rottweiler-622b36-mkl@pengutronix.de>
 <aa73f763-44bc-4e59-ad4a-ccaedaeaf1e8@oss.nxp.com>
 <20241120-cheerful-pug-of-efficiency-bc9b22-mkl@pengutronix.de>
 <72d06daa-82ed-4dc6-8396-fb20c63f5456@oss.nxp.com>
 <20241120-rational-chocolate-marten-70ed52-mkl@pengutronix.de>
 <06acdf7f-3b35-48bc-ab2e-9578221b7aea@oss.nxp.com>
 <20241120-spirited-vulture-of-coffee-423adb-mkl@pengutronix.de>
 <48171b0f-b0cd-4c9a-a93b-5537000329f8@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jurxan7aor24rika"
Content-Disposition: inline
In-Reply-To: <48171b0f-b0cd-4c9a-a93b-5537000329f8@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--jurxan7aor24rika
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt
 lines
MIME-Version: 1.0

On 20.11.2024 13:42:18, Ciprian Marian Costea wrote:
> > > If you have successfully downloaded the Reference Manual for S32G2 or=
 S32G3
> > > SoC, it should have attached an excel file describing all the interru=
pt
> > > mappings.
> >=20
> > I downloaded the S32G3 Reference Manual:
> >=20
> > | https://www.nxp.com/webapp/Download?colCode=3DRMS32G3
> >=20
> > It's a pdf. Where can I find the execl file?
>=20
> Correct, and in the software used after opening the pdf file (Adobe Acrob=
at
> Reader, Foxit PDF Reader, etc.) you should be able to find some excel fil=
es
> attached to it.

These are not available under Linux (Adobe), or you have to pay (foxit).
Can you recommend a Linux reader?

I've found zathura can extract attached files, use the "export" command
for this:

| export Export attachments. First argument specifies the attachment
| identifier (use completion with Tab), second argument gives the target
| filename (relative to current working directory).

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jurxan7aor24rika
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc90MYACgkQKDiiPnot
vG9Obgf+IkrQWvC0KRcDbDXv1yqHidF/5yebrpyyAwVwK4uR/FiZDGv8aK4Qic9A
WeHYujQjDhlb7Xv9VK2hAHtZQ+h0UAGUSAQuSw+lS40SpKTHOWrG4YQfHrSlr3v6
voXBQgn8DZzblUjNIaBWu8h/OVU2YAX8/JYWRShstx/EF2pgByBeAqlelbHAMq9l
DQORuXtVY4BUpwSE8j/XxXOzo4J9Sp1YZ95yHftnKjxpwanuFYlvmhLsoNx0C9nU
oXLJ6Olmcj8Fd6LXdQRGxKMWr7065lRZdEYUwPt1vyXkMGTRlBsGG3VsdvQ7377o
SbGb5OtbXBmbM4heczHfnk4bVskMiA==
=rqJY
-----END PGP SIGNATURE-----

--jurxan7aor24rika--

