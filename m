Return-Path: <linux-can+bounces-4579-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAC5B4FFF1
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 16:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA2E1C61995
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FC5246788;
	Tue,  9 Sep 2025 14:48:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D32226D1D
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429298; cv=none; b=GfXcm5YH+ZsTh7AmddxHIvkAiaPjnxshE9xdsBBuOD1qiDbwE2EH53T/JAqWPQ4j7zgJsHu7saPSDCYTDnC1kiWuaYu2DnZeygoka50mHLttVoml9/JIwzwrAoZMMBj++5dvgLs5/yCrfX7P1lF+jr16XU6z7L+74XAsI3vyxfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429298; c=relaxed/simple;
	bh=XzfVWNSC6ZAx32wU0veENsGQOFRetaqmUgN8wfJrWpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/5sWDPYbK0tEfLxPlKSgRI51EhGUGsrLhppuoOW4QZkKeqii9W62wQtfq3o/X/9UIzBgjiLWdYRSX1+RwJBSyc0MuWPO6cpb3ByftBiLZNEoJJIsBJ2dhkJkx2tIUECvc1LGGaI6dTuYQcyuhkwA2y2tb8Crp6XmPY18GjWmQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvzdh-00089t-Gk; Tue, 09 Sep 2025 16:48:09 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvzdf-000REu-2H;
	Tue, 09 Sep 2025 16:48:07 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 500A546A1A8;
	Tue, 09 Sep 2025 14:48:07 +0000 (UTC)
Date: Tue, 9 Sep 2025 16:48:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Patrik Flykt <patrik.flykt@linux.intel.com>, 
	Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
	Varka Bhadram <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH 4/7] can: m_can: m_can_chip_config(): bring up interface
 in correct state
Message-ID: <20250909-spiked-adamant-raccoon-90a315-mkl@pengutronix.de>
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
 <20250812-m_can-fix-state-handling-v1-4-b739e06c0a3b@pengutronix.de>
 <DC74S0QJQ0JV.39VRZ1Y5JSEWS@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eda5myf3wxj5q6sz"
Content-Disposition: inline
In-Reply-To: <DC74S0QJQ0JV.39VRZ1Y5JSEWS@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--eda5myf3wxj5q6sz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/7] can: m_can: m_can_chip_config(): bring up interface
 in correct state
MIME-Version: 1.0

On 20.08.2025 11:00:51, Markus Schneider-Pargmann wrote:
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> > index b485d2f3d971..310a907cbb7e 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -1607,6 +1607,7 @@ static int m_can_chip_config(struct net_device *d=
ev)
> >  static int m_can_start(struct net_device *dev)
> >  {
> >  	struct m_can_classdev *cdev =3D netdev_priv(dev);
> > +	u32 reg_psr;
> >  	int ret;
> > =20
> >  	/* basic m_can configuration */
> > @@ -1617,7 +1618,8 @@ static int m_can_start(struct net_device *dev)
> >  	netdev_queue_set_dql_min_limit(netdev_get_tx_queue(cdev->net, 0),
> >  				       cdev->tx_max_coalesced_frames);
> > =20
> > -	cdev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> > +	reg_psr =3D m_can_read(cdev, M_CAN_PSR);
> > +	cdev->can.state =3D m_can_can_state_get_by_psr(reg_psr);
>=20
> Previous patch makes sense for use here. But how is the state set back
> in operation after mcan was in an error state? Maybe I missed the path
> back to CAN_STATE_ERROR_ACTIVE somewhere?

Sorry, I don't exactly get what you mean here.

> Also CAN_STATE_ERROR_ACTIVE is set in resume() as well, should that also
> read the PSR instead?

see next patch :)

> Ans lastly I don't like the function name, because of the repeated can,
> maybe something like m_can_error_state_by_psr()?

It's m_can_state_get_by_psr() now.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--eda5myf3wxj5q6sz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjAPiMACgkQDHRl3/mQ
kZzywAf/WPSc70nEf3JBlQRZpqQaextMDsmozEvirHn9QavcoFM2vbAJFLzpmnFq
OIcv3o7F78vIm4Odj9FTVZz17lmQa4ObuigCCngm9YWo+jPwODlJbqKllXnGYJrh
yToNoAsEdp8Yh8U7rrzturX+1o92T69zmZPOW5ESEyJrRGrEmdPUO1ZX+lljMl2r
wy1uNbW9Z1qFoDGUV7aVJdQh4WffLoPs4ziqR/ZElNM9jWGgv/zhPkvr5Og7X5x2
nplvFjxfJigip8YA7lFA4uW8swQ7k5Y+fuofchMQMrQPfZq4mgOZQKjJfOr+MGJc
p8+gTq4TOY97s4bTg9/LthysdECeeg==
=+ni9
-----END PGP SIGNATURE-----

--eda5myf3wxj5q6sz--

