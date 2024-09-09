Return-Path: <linux-can+bounces-1445-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 486A097154F
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 12:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07E61F25721
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 10:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C931B3F2D;
	Mon,  9 Sep 2024 10:28:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462EE1B3F2C
	for <linux-can@vger.kernel.org>; Mon,  9 Sep 2024 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877706; cv=none; b=GuycOIvzSAeQvMJa91CAIg6rEPZe8goDGNpj8OUyjRLeSRy5BxPpiEVp2r8buF+zFZvPFg0JIIebXX5KH2AeNKLd1qiGom2YIeDEs/gTKvy+kgFPZ1Zxi+vm4uXS2G7VKyBLsql4UkSeeO6Stzc4J9a7mW+8PkKfPIT8vaD2GZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877706; c=relaxed/simple;
	bh=rwTU4OBCrj5FyIBE23hhrSCcr1FAJSZ6vhDKt8u/RBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6MTd38BRgD/LECA46ikgu6+LhezdXgd21ci92gd2jEmH9VfUd7lW1EJQs7JGG67/rV2zewcie1+Py33XGiRXZZaKjQFaLcbYNlPOutzetxI5p8TiAM73quSC7mgScvT0B56Av2AnSfKc27elMg1WN25S+6BGNPDd4uZHAhfto8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1snbd7-0008Cq-CC; Mon, 09 Sep 2024 12:28:21 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1snbd6-006d5V-Qw; Mon, 09 Sep 2024 12:28:20 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 78E3733682B;
	Mon, 09 Sep 2024 10:28:20 +0000 (UTC)
Date: Mon, 9 Sep 2024 12:28:20 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Hamby, Jake (US)" <Jake.Hamby@teledyne.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: m_can: Enable NAPI before enabling interrupts
Message-ID: <20240909-furry-spectral-guan-bb27d4-mkl@pengutronix.de>
References: <DM8PR14MB5221D9DD3A7F2130EF161AF7EF9E2@DM8PR14MB5221.namprd14.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="atvafioyx2obuspf"
Content-Disposition: inline
In-Reply-To: <DM8PR14MB5221D9DD3A7F2130EF161AF7EF9E2@DM8PR14MB5221.namprd14.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--atvafioyx2obuspf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.09.2024 23:19:51, Hamby, Jake (US) wrote:
> If any error flags are set when bringing up the CAN device, e.g. due to
> CAN bus traffic before initializing the device, when m_can_start is
> called and interrupts are enabled, m_can_isr is called immediately,
> which disables all CAN interrupts and calls napi_schedule.
>=20
> Because napi_enable isn't called until later in m_can_open, the call to
> napi_schedule never schedules the m_can_poll callback and the device is
> left with interrupts disabled and can't receive any CAN packets until
> rebooted. This can be verified by running "cansend" from another device
> before setting the bitrate and calling "ip link set up can0" on the test
> device. Adding debug lines to m_can_isr shows it's called with flags
> (IR_EP | IR_EW | IR_CRCE), which calls m_can_disable_all_interrupts and
> napi_schedule, and then m_can_poll is never called.
>=20
> Move the call to napi_enable above the call to m_can_start to enable any
> initial interrupt flags to be handled by m_can_poll so that interrupts
> are reenabled. Add a call to napi_disable in the error handling section
> of m_can_open, to handle the case where later functions return errors.
>=20
> Also, in m_can_close, move the call to napi_disable below the call to
> m_can_stop to ensure all interrupts are handled when bringing down the
> device. This race condition is much less likely to occur.
>=20
> While testing, I noticed that IR_TSW (timestamp wraparound) fires at
> about 1 Hz, but the driver doesn't care about it. Add it to the list of
> interrupts to disable in m_can_chip_config to reduce unneeded wakeups.
>=20
> Tested on a Microchip SAMA7G54 MPU. The fix should be applicable to any
> SoC with a Bosch M_CAN controller.

Thank you very much for your contribution! I believe you have solved the
problem I was investigating last Friday. I still need to test it with
your solution though.

This patch does not contain your Signed-off-by [1]. Add it to your next
patches; "git commit -s" will add it automatically. For this patch, you
can reply and include it in your email!

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
sign-your-work-the-developer-s-certificate-of-origin

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--atvafioyx2obuspf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbezcEACgkQKDiiPnot
vG/lvgf8CfGCe8ElfbP4xj3EhaeSLMh2VbgJr7KMJF4FL89rVrjTgsFYU/G+XLMn
ynlNRjvGHKPVHyDm93bRrYlIjG61x5JbRZ3Q1ohODpjAE9iMhDBY5mNTLEs5/h9R
ilE+1700Y+UglDgT5Utx/ZoOq2g6R/C46MEZ2x4hk8nAF7acoiBa+iUtBB9Km5cV
boxpjOhhHtm/tEmPKxVK3sAGSsMjMgaCD6Odu7h/Ec/1Mt97T9a9T1Nlp9XgFkB3
Fz03apAos9d0iztKyNYfPeZOSe/LHfwViZ7GNeCmfF0j1QCJ+5wpMlDE5XuixIQk
Gc5n2e6bxlZTo9s2itWXnINzp+Jukw==
=Vucm
-----END PGP SIGNATURE-----

--atvafioyx2obuspf--

