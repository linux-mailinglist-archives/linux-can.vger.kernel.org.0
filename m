Return-Path: <linux-can+bounces-3062-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC19BA60DF5
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 10:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C813461FF3
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8201EF0A5;
	Fri, 14 Mar 2025 09:53:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7111DE4D6
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946023; cv=none; b=DrGqFnWvh+2W/swicpbQ0wcDfyO5NluHqaTKbWLwn/LT1EnBgjutWHLsK52lb8gGIjBQnyr9ZrcBEOqgF4LkwUkd/WtWZJeZ+1nMclm4TnrdpeVp0BgG3NhxBwaW/PxhIrCk/aPoZchLVVZTp++eU8iQgNZBeOrkkLtv4lsgl+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946023; c=relaxed/simple;
	bh=uqi4a1i44VuR63mk4mLewvz1DOGcGyysr+VYBowc650=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvaGBYFo2oTypsHuIspcg5+lInnpKLCgXD4RHAU+SHHmDkzKmAO1EBmQ9W28UUmnOojWsV4kbpyvvX0dcw8lg+Ha9QQsqjT87UaqoU0bWpkBeLutUaZRbfKNR5wUtHYX8uTo6waYhIRsRUugnH3wKwPeoUKTtMVShcJY/JEexEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt1jT-00006B-3y; Fri, 14 Mar 2025 10:53:35 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt1jS-005gEk-29;
	Fri, 14 Mar 2025 10:53:34 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4E22B3DB8FA;
	Fri, 14 Mar 2025 09:53:34 +0000 (UTC)
Date: Fri, 14 Mar 2025 10:53:33 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Bough Chen <haibo.chen@nxp.com>
Cc: "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>, 
	"Ciprian Marian Costea (OSS)" <ciprianmarian.costea@oss.nxp.com>, Han Xu <han.xu@nxp.com>, 
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: RE: [PATCH 1/2] can: flexcan: only set CAN_STATE_ERROR_ACTIVE
 when resume has no issue
Message-ID: <20250314-astonishing-astute-caracara-4ba78c-mkl@pengutronix.de>
References: <20250306065921.2329517-1-haibo.chen@nxp.com>
 <20250314-invaluable-economic-caterpillar-80541a-mkl@pengutronix.de>
 <20250314-married-polar-elephant-b15594-mkl@pengutronix.de>
 <DU0PR04MB9496EC52CF54A8F635F1408690D22@DU0PR04MB9496.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="migyawgtbe5skj3c"
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9496EC52CF54A8F635F1408690D22@DU0PR04MB9496.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--migyawgtbe5skj3c
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: [PATCH 1/2] can: flexcan: only set CAN_STATE_ERROR_ACTIVE
 when resume has no issue
MIME-Version: 1.0

On 14.03.2025 09:48:06, Bough Chen wrote:
> > > > Only set CAN state to CAN_STATE_ERROR_ACTIVE when resume process has
> > > > no issue, otherwise keep in CAN_STATE_SLEEPING as suspend did.
> > >
> > > When looking at the code, it makes no sense to set the can.state to
> > > CAN_STATE_ERROR_ACTIVE, if the device isn't up.
> > >
> > > The suspend function doesn't look correct, either. I'll send a v3.
> >=20
> > After a suspend/resume cycle on a down interface, it will come up as
> > ERROR-ACTIVE.
>=20
> Seems only need to handle the priv->can.state when netif_running(dev) ret=
urn true in PM.

ACK - in both the suspend and the resume function.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--migyawgtbe5skj3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfT/JoACgkQDHRl3/mQ
kZx+Pwf/ZfEVLAzTROaB11mfgT1llPVOR7Xa88LWmIyUoRfgnqK/V4RQ5RSQYXvJ
GwxehE4EaqhAN4O79BMA3D1E7Tc8lB9zo/npgG/+2Oew6cu4a8GCC0ZQHi2HwAx+
eWYQBNTY5F3Hr7C/osnwavurydlvMK/Cq0UYXJ8fqp5ucCW03F/A5IuFULfhgvZ3
G7rvdOjKTiaM2dY3IafRQuDBzle25Lr1UKbDQ/OtaARVWL7XOkTLtRGupMOWjeEU
/m1JevFi9L8QxXKcRYWnZMfsra2q1gbUMTNCRQvMjOySiz/yeLhyD37XHWywHnZC
mfEjnSMblOxB+xKbqkMXcrZbE/yYdw==
=jj4o
-----END PGP SIGNATURE-----

--migyawgtbe5skj3c--

