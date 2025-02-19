Return-Path: <linux-can+bounces-2854-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB854A3BC4E
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 12:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67661887031
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 11:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A5B286291;
	Wed, 19 Feb 2025 11:00:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C823DE
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962833; cv=none; b=NotTgGOjwjlDgdGy226EPc56hB10h5hJ0SmWsBDncBlZgMeO6OWorjFje1eNqIgRMWdxXC2r7Upga1ausJ1gaAaDeOucBwBV/S4lFEYk8KZ8fgKcBzPRK9ePbys715fMAL9QZDB0J31oxt3p2UzENTWBiZ3e8f7KHQQ3ry3FUqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962833; c=relaxed/simple;
	bh=MG3xGBAkVKmKkqiO52O8AdqSHtZcQiyeNK+723bu6Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJVxj5eL4esbnNg/Askm78VP2+KO8himiNWElqtoGjLqHhaw0fv0EuThR/RyXuQhbVngS7MWol126igU2yw6pDiKgjCuLrIk2D50kO4WgEuruGFdhQGxcwtTtmSCmAHKAQVDRWUi68btn9ahiqUnJTSEGnStEXV3zwvyc+lL/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkhoS-0004su-Oc; Wed, 19 Feb 2025 12:00:20 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkhoR-001kbf-2H;
	Wed, 19 Feb 2025 12:00:19 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5272A3C6891;
	Wed, 19 Feb 2025 11:00:19 +0000 (UTC)
Date: Wed, 19 Feb 2025 12:00:17 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH 2/2] can: flexcan: add transceiver capabilities
Message-ID: <20250219-xanthic-elephant-of-jest-9b5720-mkl@pengutronix.de>
References: <20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com>
 <20250211-flexcan-add-transceiver-caps-v1-2-c6abb7817b0f@liebherr.com>
 <20250219-garnet-gorilla-of-will-6e389e-mkl@pengutronix.de>
 <20250219103955.GB3888@debian>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l2mzcqrvw6yumylm"
Content-Disposition: inline
In-Reply-To: <20250219103955.GB3888@debian>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--l2mzcqrvw6yumylm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] can: flexcan: add transceiver capabilities
MIME-Version: 1.0

On 19.02.2025 11:39:55, Dimitri Fedrau wrote:
> > > diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flex=
can/flexcan.h
> > > index 4933d8c7439e62b5d6fcc445d88c2b5ccbfa13bb..56be40875eee24aee9297=
c4bc7c2fc4380e682ff 100644
> > > --- a/drivers/net/can/flexcan/flexcan.h
> > > +++ b/drivers/net/can/flexcan/flexcan.h
> > > @@ -103,6 +103,7 @@ struct flexcan_priv {
> > >  	struct clk *clk_per;
> > >  	struct flexcan_devtype_data devtype_data;
> > >  	struct regulator *reg_xceiver;
> > > +	struct phy *xceiver;
> >=20
> > All other drivers name this variable "transceiver", does it make sense
> > to use this name here, too?
> >=20
> I have no preference on this, but my intention was to name it xceiver
> according to reg_xceiver, so people familiar with the code would know
> what it is about. I can change it to transceiver, what do you think ?

Please use transceiver.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--l2mzcqrvw6yumylm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme1ub4ACgkQDHRl3/mQ
kZzwZwf/V0UbOs2j2oZzUGx3EQAySIQ843epnVc8qB11S6fhhnBq+2/cCc3ABqpO
QkZ4w0HomALIB2wT9Weqiv2QhbgzlN+jJK+C9gjTm8hEK91v28uzR7JcO+Zod7eO
/eDYaHx5UrGooB2f5MH4mwWwH6W3kDYoFerMhM9rwcgDLJ8BByBdi5aKgnzCb5wU
Sn1L5eD02YQEb42iOIVdmJxnGhWQKC3jCM25Lo4PNVP+iRtol2uMqXLYJrZFle0t
XUO3QL/Qv9g2q7amwHfgQewjbWc8ZgOZ4Lpni5trJUIiqOrQzSF0b1tVIqV6Ahjk
yxxexAh0DUC6cwIjOlheDS8Cw967og==
=81Ih
-----END PGP SIGNATURE-----

--l2mzcqrvw6yumylm--

