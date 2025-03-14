Return-Path: <linux-can+bounces-3066-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FFAA6111B
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 13:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52BB07A8308
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 12:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECA91A304A;
	Fri, 14 Mar 2025 12:27:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAE41CBE8C
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955235; cv=none; b=RUr2TR0RRjJQs3x24ZMw7bdtuIAaZtFfSPXbfdjjXvS4swTrI5JjCAojwmdinN7irIaiFlL6WdOolR+mSI5il4wdi2ASv9JOBtUrui3Dc/WkkB3jl5v5wscZHXNLMyAy7/l7XjFsTjfujxLC+djruiBqE1yrKAr/9VZKveZS5vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955235; c=relaxed/simple;
	bh=CIE7Y7YG8R87HC0ZtwcGQ6RuyIkWQF1KLYOmNzvgzC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrMny9UE7Kp/fSMwOv7mGFlMGcL9psNPof95U1CZeWEaaFashnQVeBF5YgADvrrxZ1jIdqntHZFx6AHhFWa5w8MGgfmjnIz7QkCeCu6faqcvDZVjQveE1rSndZRYNP96BDhDZQ5Zr/UFkX7LY6sYx9aFSqqz/5IGxFyx20w+vlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt482-0000VE-2x; Fri, 14 Mar 2025 13:27:06 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt481-005hQE-18;
	Fri, 14 Mar 2025 13:27:05 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EAFC03DBAE0;
	Fri, 14 Mar 2025 12:27:04 +0000 (UTC)
Date: Fri, 14 Mar 2025 13:27:04 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: haibo.chen@nxp.com
Cc: mailhol.vincent@wanadoo.fr, ciprianmarian.costea@oss.nxp.com, 
	u.kleine-koenig@baylibre.com, fabio.estevam@nxp.com, festevam@gmail.com, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	imx@lists.linux.dev, han.xu@nxp.com
Subject: Re: [PATCH v3 1/2] can: flexcan: only change CAN state when link up
 in system PM
Message-ID: <20250314-succinct-tall-skunk-cf905e-mkl@pengutronix.de>
References: <20250314110145.899179-1-haibo.chen@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n673osmdubliybov"
Content-Disposition: inline
In-Reply-To: <20250314110145.899179-1-haibo.chen@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--n673osmdubliybov
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] can: flexcan: only change CAN state when link up
 in system PM
MIME-Version: 1.0

On 14.03.2025 19:01:44, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>=20
> After a suspend/resume cycle on a down interface, it will come up as
> ERROR-ACTIVE.
>=20
> $ ip -details -s -s a s dev flexcan0
> 3: flexcan0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN group defaul=
t qlen 10
>     link/can  promiscuity 0 allmulti 0 minmtu 0 maxmtu 0
>     can state STOPPED (berr-counter tx 0 rx 0) restart-ms 1000
>=20
> $ sudo systemctl suspend
>=20
> $ ip -details -s -s a s dev flexcan0
> 3: flexcan0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN group defaul=
t qlen 10
>     link/can  promiscuity 0 allmulti 0 minmtu 0 maxmtu 0
>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 1000
>=20
> And only set CAN state to CAN_STATE_ERROR_ACTIVE when resume process
> has no issue, otherwise keep in CAN_STATE_SLEEPING as suspend did.
>=20
> Fixes: 4de349e786a3 ("can: flexcan: fix resume function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--n673osmdubliybov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfUIJUACgkQDHRl3/mQ
kZyvLQf5AcnFucNADIyh3YzRVDPUdJ21ijFvA31jS2h6YtsXPLA+KxNpc8Bz/2T0
9IdIa5jOrl0gij1s3pUBmRxX34e7Ns68a3RROv8sA+rcTQXU/1ecKkbuNdFf4RWU
b11qLMsZHb3sjY5k5ZUWEftvBV6XnTxx7mq/oChgZUsG9pZPBJ4HtbHR7zybFi1o
Za67pVS081y7rpcJ1Y2rlkPRsRi07VDNq+ncWgsSMhU2+uXwklYmRUVwKfRU2d9r
JV8FmmfMI7JHMWXEnCSUBPzkGZCDtjsofosenX8iO6X39wx7X3eaIRCTw6jSzjJC
udmXDaE8dkwSlciHwd2Yav1cFK25Sg==
=3eya
-----END PGP SIGNATURE-----

--n673osmdubliybov--

