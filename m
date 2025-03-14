Return-Path: <linux-can+bounces-3060-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05242A60DA2
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 10:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8D719C6994
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEE11F3BA3;
	Fri, 14 Mar 2025 09:43:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9751F03C7
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945385; cv=none; b=Wf8Y6JZemvRDGt2ve34Vn/Md6mPHXKL0aqFV/BM9E37ThxE/VpL1rPVXGURbsgDmh3c3cfnSkdRJlS4ba+OmwSD4n/n4ZYVUu77Mz7LiU/AqHou85OBb57jQJPTFOZhWfZ/Z6ZFB3Ckh5A1Oz2tzYSGKfxzYp7PXzJiZlWZUkho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945385; c=relaxed/simple;
	bh=Qprz9wpUySPUA48GgPU3RCPs42MHXerLEut3c0IV2cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsKJsEBPbwoW0HFdMIiRPWTcvVAca0Ekzn6br8An6vTcQ6JvZTEK0kAenwauInewizAK4VTvNbHtekjXRRPecXRtTUYsuh0u3dQR7qyOSV6W4Jrm6rmILTvrr8VldQcslpv7Rs92wczF3VNiCFegRCPPjDFVVTt8jdMQH9C1iAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt1ZA-00071c-Tj; Fri, 14 Mar 2025 10:42:56 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt1ZA-005gDi-1X;
	Fri, 14 Mar 2025 10:42:56 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 278AE3DB8E4;
	Fri, 14 Mar 2025 09:42:56 +0000 (UTC)
Date: Fri, 14 Mar 2025 10:42:55 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: haibo.chen@nxp.com
Cc: mailhol.vincent@wanadoo.fr, ciprianmarian.costea@oss.nxp.com, 
	han.xu@nxp.com, u.kleine-koenig@baylibre.com, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] can: flexcan: only set CAN_STATE_ERROR_ACTIVE when
 resume has no issue
Message-ID: <20250314-married-polar-elephant-b15594-mkl@pengutronix.de>
References: <20250306065921.2329517-1-haibo.chen@nxp.com>
 <20250314-invaluable-economic-caterpillar-80541a-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oogkrhl672fkkr2e"
Content-Disposition: inline
In-Reply-To: <20250314-invaluable-economic-caterpillar-80541a-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--oogkrhl672fkkr2e
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] can: flexcan: only set CAN_STATE_ERROR_ACTIVE when
 resume has no issue
MIME-Version: 1.0

On 14.03.2025 10:13:08, Marc Kleine-Budde wrote:
> On 06.03.2025 14:59:20, haibo.chen@nxp.com wrote:
> > From: Haibo Chen <haibo.chen@nxp.com>
> >
> > Only set CAN state to CAN_STATE_ERROR_ACTIVE when resume process has
> > no issue, otherwise keep in CAN_STATE_SLEEPING as suspend did.
>
> When looking at the code, it makes no sense to set the can.state to
> CAN_STATE_ERROR_ACTIVE, if the device isn't up.
>
> The suspend function doesn't look correct, either. I'll send a v3.

After a suspend/resume cycle on a down interface, it will come up as
ERROR-ACTIVE.

| $ ip -details -s -s a s dev flexcan0
| 3: flexcan0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN group defaul=
t qlen 10
|     link/can  promiscuity 0 allmulti 0 minmtu 0 maxmtu 0
|     can state STOPPED (berr-counter tx 0 rx 0) restart-ms 1000
|=20
| $ sudo systemctl suspend
|=20
| $ ip -details -s -s a s dev flexcan0
| 3: flexcan0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN group defaul=
t qlen 10
|     link/can  promiscuity 0 allmulti 0 minmtu 0 maxmtu 0
|     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 1000

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--oogkrhl672fkkr2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfT+hwACgkQDHRl3/mQ
kZxEeggAmJe/1BSs7Ia4z0JQDnv+yNvTHRHBzW/nu0LIxl8GYJiNvdXrfqaHtyRW
3KxMQgn2UHGnBwsGHQX0rVoCVZ/n3i5QMNTnXH7o6XFF80UgGnLL32nR/vsOUPs6
uN7aoJL+U7SChWQvNQOiP2ojt2EVjN8MgV4URjX1nqzV8PrrUuwkX3EcIlvhOlde
yg9UFKNApmwfqZBfRw0UJz9cfil4+HU1E3LOKN5qNvT1Dn1bd7GvWVGZdaENSxiA
aVc90fDYdITbp5Z3iK7hfjKhJqB4X+11uP2EBjonEjKFuE4DekHIaNW0TcIeRUrz
xOIkAVkL0D+/EE8FO6kuAL99RtW6tQ==
=9m1P
-----END PGP SIGNATURE-----

--oogkrhl672fkkr2e--

