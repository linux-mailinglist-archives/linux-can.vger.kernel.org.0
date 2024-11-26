Return-Path: <linux-can+bounces-2234-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB719D9A4C
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 16:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F5A282378
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291301C1F02;
	Tue, 26 Nov 2024 15:19:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0B17591
	for <linux-can@vger.kernel.org>; Tue, 26 Nov 2024 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732634342; cv=none; b=q6LDshG8ztbPat5hxchdSCm3mAIkxe7ccM28kYtLT+1OeW8mA+9mSGXPhP4AFYFeE0nfAT02q33auwvpLgxH2B4C+sFn3fQJwydHHmmH3uTUy+mIlsDx7+G2/38hzLeMd/JnQs9oUZvSonNcKqOTm0+mgB+4FSwjKYqP5dlf/Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732634342; c=relaxed/simple;
	bh=xrPTT7KJv2b4DPJS5VTnxOhvuA8MYTq84S6PSgv3ozA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdHtmQ9z4WRldiefk4qy0qK5LRRwApNWU3FptHKiqS3ah9bl4WRjZoY1tOEpJCZXFkbhxDcM/XM1iWrk6E/RDpwbTVZLU9LYSCtaC8k8JOUM5hfKq/YLt7o46D1Jw9kdQ1eQqY2A77fT860gyOwGTYpScvtF+h0HFMz+rObIraE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFxKs-0004YV-DN; Tue, 26 Nov 2024 16:18:42 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFxKr-000Gs6-0H;
	Tue, 26 Nov 2024 16:18:41 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6BB0837DC17;
	Tue, 26 Nov 2024 15:18:41 +0000 (UTC)
Date: Tue, 26 Nov 2024 16:18:41 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, NXP S32 Linux <s32@nxp.com>, 
	imx@lists.linux.dev, Christophe Lizzi <clizzi@redhat.com>, 
	Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3
 SoC support
Message-ID: <20241126-aquatic-brawny-shrimp-b3cc0e-mkl@pengutronix.de>
References: <20241125163103.4166207-1-ciprianmarian.costea@oss.nxp.com>
 <20241125163103.4166207-2-ciprianmarian.costea@oss.nxp.com>
 <y2fbsxg4pney2iapzcdooxyz6l3pmw6ms2ddupf637svitelbt@wthu23ld5ryq>
 <20241126-independent-crocodile-of-finesse-106009-mkl@pengutronix.de>
 <01a7de95-24e2-4c75-a818-bbc363e89844@oss.nxp.com>
 <20241126-capable-vagabond-tody-8b3717-mkl@pengutronix.de>
 <1a9281ec-3a4f-4175-8892-ee2e1ce1308a@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zoosu5ek2bwbfp6a"
Content-Disposition: inline
In-Reply-To: <1a9281ec-3a4f-4175-8892-ee2e1ce1308a@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--zoosu5ek2bwbfp6a
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3
 SoC support
MIME-Version: 1.0

On 26.11.2024 17:15:10, Ciprian Marian Costea wrote:
> > > > > > +        interrupt-names:
> > > > > > +          items:
> > > > > > +            - const: mb_0-7
> >=20
> > I was wondering if it makes sense to have an interrupt name not
> > mentioning the exact mailbox numbers, so that the same interrupt name
> > can be used for a different IP core, too. On the coldfire SoC the 1st
> > IRQ handles mailboxes 0...15.
> >=20
>=20
> I am ok with proposing a more generic name for mailboxes in order to
> increase reusability among FlexCAN enabled SoCs.
> Further specific mailbox numbers could be mentioned in the actual
> S32G2/S32G3 dtsi flexcan node.
>=20
> One proposal could be:
> - mb-1: First Range of Mailboxes
> - mb-2: Second Range of Mailboxes
>=20
> Let me know if you agree to update as proposed in V3.

Looks good to me!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zoosu5ek2bwbfp6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdF5s0ACgkQKDiiPnot
vG9B9Qf/T4Fj9Yq5Yqd3fE9w4scQuvsbvXGelsZ0gNp3mTWjZOtDDLCsZUYuy1LR
/uHLsDvDUNR1GOPDK7ub5uKb7JfvI3Xi9AVjAvD/geMBnQzAadqj8vjYq/tdhqU5
F59iVgbBlGLIby23Lrd6hGWz4hldnZOmuRE3MUSLLJHEMA9C9tuQgottxWrDTuQL
MX/mi5kXzsfdYZ8kUnjBzQlgT97p+F0kns8DjX+oWe4BHVJ+jmsZ9egG+BpDw6tU
Ps13x1dn26oxWSPUh/Q/kO473SeNcBGYPMm/MxIntQz6Idm4zg/AafIRo7WvCLOU
vwwx94rtYvLaHzsbA9YhEFkMi3PyhA==
=K2QF
-----END PGP SIGNATURE-----

--zoosu5ek2bwbfp6a--

