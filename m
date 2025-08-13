Return-Path: <linux-can+bounces-4228-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E285FB244FC
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 11:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6D07A1B00
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1827C20E023;
	Wed, 13 Aug 2025 09:07:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354FC2BE03C
	for <linux-can@vger.kernel.org>; Wed, 13 Aug 2025 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076028; cv=none; b=F2FeZ4h6Xn+O3R0L6qetMwKXx//91fNkN12WL5FXWIcwAGTeGH8rIT6riOc1axQPg/R6VSlDj7x90DZmpM4n7pLSeBomS2lwvBwn9nA52EVeGw1EHI0ydTYBeQ8qQq/Dx5WxI2x3EF1ZFIIhu8egi+R51QoIazH1zDqcXK9EJyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076028; c=relaxed/simple;
	bh=WdB0M+OEvFK3Ssc6+6j7QCXwJt3vCzXdlexsaYeFWfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdvEYvdSs7+chWokDkn5ORqaKidCKz8ti0/6d0IaxcrgYWdXv+csRcmM9xUYDwddnBHcER6ZPfbTZCv2q74+YYyxkBdlbXl5git7LH1PSHVrYQ3Joij2T6YnxzU7xIgM4g0zWa/ybs6XY/szLVJXiGRLOCS85iPsTtXtiSZZ5NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1um7Rh-0001Gb-6F; Wed, 13 Aug 2025 11:06:57 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1um7Rf-0004DN-04;
	Wed, 13 Aug 2025 11:06:55 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9F9D2456956;
	Wed, 13 Aug 2025 09:06:54 +0000 (UTC)
Date: Wed, 13 Aug 2025 11:06:54 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Patrik Flykt <patrik.flykt@linux.intel.com>, 
	Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
	Varka Bhadram <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH 0/7] can: m_can: fix pm_runtime and CAN state handling
Message-ID: <20250813-shaggy-xanthic-griffin-23aede-mkl@pengutronix.de>
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
 <239711fdd1eb6f79a89af7396ef7eb60f485ec12.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hbmzdam4u5w243ii"
Content-Disposition: inline
In-Reply-To: <239711fdd1eb6f79a89af7396ef7eb60f485ec12.camel@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--hbmzdam4u5w243ii
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/7] can: m_can: fix pm_runtime and CAN state handling
MIME-Version: 1.0

On 13.08.2025 10:17:49, Philipp Zabel wrote:
> On Di, 2025-08-12 at 19:36 +0200, Marc Kleine-Budde wrote:
> > The first patch fixes a pm_runtime imbalance in the m_can_platform
> > driver.
> >=20
> > The rest of this series fixes the CAN state handling in the m_can
> > driver:
> > - add the missing state transition from from Error Warning back to
> >   Error Active (Patches 2+3)
> > - address the fact that in some SoCs (observed on the STM32MP15) the
> >   M_CAN IP core keeps the CAN state and CAN error counters over an
> >   internal reset cycle. Set the correct CAN state during ifup and
> >   system resume (Patches 4+5)
> > - add support for optional shared external reset, to properly reset
> >   the IP core (Patches 6+7)
>=20
> Should this declare a dependency on
> https://lore.kernel.org/all/20250807-stm32mp15-m_can-add-reset-v2-1-f69eb=
bfced1f@pengutronix.de/
> or is that already merged?

Still open, reference added to the cover letter.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hbmzdam4u5w243ii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmicVasACgkQDHRl3/mQ
kZxufgf9GutXshp8+S8ac/hryEybfPZHVpDKPMQaIPPYgGazs4P4Wc4bRsfTXWdv
wDoX//fcfh7PSmzB5cnT5lunun8blvpOkTcADMiemvyXXDtyFkGCZFSy+1OI3xFB
o8blZON1f8qnWlVZlxCFyy+kAZRSMmUhpFOfCx8ZUwEApauwBfqCR11D114Ag5ue
+oJtOMPtVaW1OND8dLb1nlzu2QU6CajpyuxDmWcWKqtCRZIHT0TieQX2i/JJiBNu
Wwc5oWFQI1L87v+EwySJRAWp4o2Pz+2MSG45TTRkJrvAoqza23WxqHTtimQzpMyI
K7/xeSinooOxQhpF8OyMTXfOG75ATg==
=tcd7
-----END PGP SIGNATURE-----

--hbmzdam4u5w243ii--

