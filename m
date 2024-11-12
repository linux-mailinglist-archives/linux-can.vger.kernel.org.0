Return-Path: <linux-can+bounces-1981-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1201E9C513A
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 09:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB36B28291B
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 08:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509AA1EBFFD;
	Tue, 12 Nov 2024 08:53:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3482D154456
	for <linux-can@vger.kernel.org>; Tue, 12 Nov 2024 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401597; cv=none; b=Ps/E+feb16COGjyq1qAlfGERQp0+aMK2YAH3SOTyLsLl93IuAYdHVrnWqfWuKM2hNbbZ7iogYrcQIl45DCf+jH9ZOBySgb3bdUjQf+KYBd+ERQvdfDPntichunAcUsJGIEKuytTUMnJANEo+w7pgqW7tsNylAh6Eku71qBigCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401597; c=relaxed/simple;
	bh=7FeByrfiaYyvAFoAFAkKJ30sQIiJkvJ54FrP0xajRSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFPAy/D/Hlurn9Sw8olvQ0U/tkLMt5QkfGiOxvD8P0VW9GpUn/5N7OTfwj5qyaED6Wq8txKVZtGNkij/54E5TCmXSIHWK10LUG6yQa4PzXyTw7m0Ou7XwZcg3JStcwchqqWZLOwpyVRqQ/uKlJ2vjeslIcvjBI5KJxIpnTJu9pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tAme7-0001Ub-Vs; Tue, 12 Nov 2024 09:53:12 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tAme7-000Ngz-23;
	Tue, 12 Nov 2024 09:53:11 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3D297371372;
	Tue, 12 Nov 2024 08:53:11 +0000 (UTC)
Date: Tue, 12 Nov 2024 09:53:10 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Robert Nawrath <mbro1689@gmail.com>
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
Message-ID: <20241112-glittering-khaki-uakari-8e15cb-mkl@pengutronix.de>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="duwd7oqetrs2ub74"
Content-Disposition: inline
In-Reply-To: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--duwd7oqetrs2ub74
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
MIME-Version: 1.0

On 11.11.2024 00:55:49, Vincent Mailhol wrote:
> Because of popular request [1] and to celebrate the fact that I joined
> the kernel web of trust this week [2], here is an RFC to introduce the
> CAN XL netlink support.

yeay \o/

> The logic is simple. The CAN XL basically just reuse the same kind of
> parameters as CAN FD: the databittiming and the TDC. So the series is
> just a bunch of refactor to either:
>=20
>   - factorize code.
>   - rename some variable to differentiate between CAN FD and XL.
>   - make some function more generic to accept both CAN FD and XL.
>=20
> The feature is working=E2=84=A2: there is a dummy driver at the end of the
> series to show the traffic from the userland to a driver. This said, I
> did close to zero testing. Once I had one CAN XL frame reaching the
> driver, I call it a day, and decided to send the work. Regardless, it
> is Sunday night. If I do not send it now, that would be next week-end.
> Probably some mistakes are hidden here and there, but this should be
> enough for an RFC level.
>=20
> Also, I am not fully happy that can_dbt_changelink() requires 8
> parameters. I will probably revisit this later on. But for the moment,
> I think this is acceptable for an RFC.
>=20
> Overall, I do not want to rush this series. Linus should send the rc7
> anytime soon, and the merge window will probably start in eight days.
> I do not think this series will be finalized by then. I still need to
> give a deeper look at ISO 11898-1:2024 [3] to check that everything is
> good. However, if I receive positive feedback on this RFC, I would
> probably like to have the first patch merged so that I do not have to
> rebase that tree wide patch each time someone makes a change.
>=20
> I will send a second RFC series for iplink2 just after this one. Stay
> tuned!

What's the base commit of this series? It doesn't apply to
net-next/main. For a series this big, try using 'b4', it also
automatically sends the base commit.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--duwd7oqetrs2ub74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmczF3MACgkQKDiiPnot
vG+dpwgAl+rTNPLEg4w/fCBgO2lIrtSpVXxh1iJokEzqSV4onJqODKkWrPGORElR
2TWIfDJ4Y8qbs4QxHmojC9VBweD8LTUUofdXDhUpwjoqPP3Ap1o5Ch/DdmFn4bH+
u0Vlrv8uJxVRGGJ8hbE7oNmKUHOp4+TWfpH0BB7y+Jnc68dKwbE/xv6lEyMfLvF5
+OLRjyPl1LCIMNr9VN8by8DglLrUg9c/gSpZ+KlGoU53X5HHWHBpnaNiP6ds46LN
DspPa0saLWmTHZdUCsS+tmV9Iavw17itGvBBaY1DJGVzdFUdQl6buTUNWhOTxiNG
x2iFLeVfyZpBXEjbbY379gTzUwhqZw==
=EUFR
-----END PGP SIGNATURE-----

--duwd7oqetrs2ub74--

