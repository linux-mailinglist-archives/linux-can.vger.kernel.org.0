Return-Path: <linux-can+bounces-984-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBDB9337B7
	for <lists+linux-can@lfdr.de>; Wed, 17 Jul 2024 09:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455921C22445
	for <lists+linux-can@lfdr.de>; Wed, 17 Jul 2024 07:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F72E1BC39;
	Wed, 17 Jul 2024 07:21:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45460B64C
	for <linux-can@vger.kernel.org>; Wed, 17 Jul 2024 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721200897; cv=none; b=E5FI1/1sK1oTQfRDNy5lDkVc0Rm23cG3pZLOELyNrarbSvjY6xtiqeYrgmLkg53oC4JM0o3T7ycJNgypD8uogX/lqYqOMuv5OG8WUeuHmRb/PSGiAk6wJtkZYZ8fyu5zHDc3aAHNbFfwYA3AoRcqIkNW8fMk7Ueq7UmPq2wEHwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721200897; c=relaxed/simple;
	bh=7dyhTQjy+22B7GIQfMe+2jE4/DTU5dL5I/JauqWJc+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbSA+Q6v0vUiE3TNAXYT+hUoEJ4MhlH2vgmWx8WUUvlIOsdTcPi6b6E8BFREx3tIH49mAccQ2SsHGNoTZbb59/Qo3Pf8yEr8JKho8ihCrVYweQFWoW5c8ZwqYqxXl1Ldqrv9cmsdY2J8Y2S5wBUPvn1Y0EvygS4LzMQ/dqTGOhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sTyyQ-0006wr-Ga; Wed, 17 Jul 2024 09:21:14 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sTyyO-000A17-Cx; Wed, 17 Jul 2024 09:21:12 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 524B830595B;
	Wed, 17 Jul 2024 07:20:46 +0000 (UTC)
Date: Wed, 17 Jul 2024 09:20:45 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Bough Chen <haibo.chen@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Han Xu <han.xu@nxp.com>
Subject: Re: RE: [PATCH v2 4/4] can: flexcan: add wakeup support for imx95
Message-ID: <20240717-porpoise-of-imminent-inspiration-ef2fc6-mkl@pengutronix.de>
References: <20240715-flexcan-v2-0-2873014c595a@nxp.com>
 <20240715-flexcan-v2-4-2873014c595a@nxp.com>
 <20240716-curious-scorpion-of-glory-8265aa-mkl@pengutronix.de>
 <ZpaF4Wc70VuV4Cti@lizhi-Precision-Tower-5810>
 <20240716-chowchow-of-massive-joviality-77e833-mkl@pengutronix.de>
 <DU0PR04MB9496C653249E66016A43F97790A32@DU0PR04MB9496.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lyoxbz5qrcbtajuw"
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9496C653249E66016A43F97790A32@DU0PR04MB9496.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--lyoxbz5qrcbtajuw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.07.2024 02:03:35, Bough Chen wrote:
> > On 16.07.2024 10:40:31, Frank Li wrote:
> > > > > @@ -2330,9 +2366,12 @@ static int __maybe_unused
> > flexcan_noirq_resume(struct device *device)
> > > > >  	if (netif_running(dev)) {
> > > > >  		int err;
> > > > >
> > > > > -		err =3D pm_runtime_force_resume(device);
> > > > > -		if (err)
> > > > > -			return err;
> > > > > +		if (!(device_may_wakeup(device) &&
> > > >                       ^^^^^^^^^^^^^^^^^^^^^^^^
> > > >
> > > > Where does this come from?
> > >
> > > include/linux/pm_wakeup.h
> > >
> > > static inline bool device_may_wakeup(struct device *dev)
> > > {
> > >         return dev->power.can_wakeup && !!dev->power.wakeup;
> > > }
> >=20
> > Sorry for the confusion. I wanted to point out, that the original drive=
r doesn't
> > have the check to device_may_wakeup(). Why was this added?
>=20
> Here add this to make sure for CAN with flag
> FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI and really used as wakeup source,
> do not need to call pm_runtime_force_resume(), keep it align with what
> we do in flexcan_noirq_suspend.

> As the comment in flexcan_noirq_suspend, CAN with flag
> FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI, when used as wakeup source, need
> to keep CAN clock on when system suspend, let ATF part logic works,
> detail steps please refer to this patch commit log. Whether gate off
> the CAN clock or not depends on the Hardware design. So for this case,
> in flexcan_noirq_suspend, directly return0, do not call the
> pm_runtime_force_suspend(), then in flexcan_noirq_resume(), use the
> same logic to skip the pm_runtime_force_resume().

Please change the control flow, so that flexcan_noirq_suspend() and
flexcan_noirq_resume() look symmetrical.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lyoxbz5qrcbtajuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmaXcMoACgkQKDiiPnot
vG+oPQf/YPWUrvcT++JZ07FcseBQUWKsH7dE6a2zvUJix3NiJbujU/7ZWRis8Bhl
CGbvtpAmEkpcNuKWucYwTYt2eB8y4d0h3qCHeSi1B6Jsg+SGccThY+3/WxfCmwUu
pMcw4nfvza024LNjyeZLBtys3O81K/GIg3iJ2NULzgQNeKfM8oalPvoEhrMVHEVn
J+GyKB4zCaZAGfbndeG7OBQleiFSTQ4oi7OEq8rr8lsnjcCfPYDKDfLZQIpFZtqa
VRiFq7hTayk/qYyVsZhRf8089C4wsp6zhLDoe9Dweu/J8sQ03klMIOUvpKuRD5jC
FbL9ybQfk28QbWIANcLZnko0sBa6RA==
=3SL7
-----END PGP SIGNATURE-----

--lyoxbz5qrcbtajuw--

