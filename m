Return-Path: <linux-can+bounces-5857-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D89CB5B7A
	for <lists+linux-can@lfdr.de>; Thu, 11 Dec 2025 12:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE9113032109
	for <lists+linux-can@lfdr.de>; Thu, 11 Dec 2025 11:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C68330DD0B;
	Thu, 11 Dec 2025 11:54:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49E30C63A
	for <linux-can@vger.kernel.org>; Thu, 11 Dec 2025 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765454048; cv=none; b=ijBvRdpLm8klxVWS6gEH6RPIY9HOsHltqZJnh8MXfFEE/b/6swMo90CfsVEYBncwk2zgquZLTx5eKTkEEpYXzIdCgXIdPMFDVJr+q/7YQd2W5UIsnKb08WB9N8kQPAYfA2vCoXncAtQSpeVUIgjSZwthwAvV2bUC54I3N1/VIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765454048; c=relaxed/simple;
	bh=eLq21bKcCebUUqlnNblEmCeRwjgKogVGDfli81WskRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgE8DgWLYpH0ApQNZDHmPUJYAK+85F3v3dkuK/Yfrq0gB3618JDrIE03+9YvzyPXN3xOAFtb26iauPnX0RqLyKtKNJdvN3cgmlXFkqiZD1lpMIOeq7RNA5DGDzcTLEqmlXi2PBvhlYA3RUqeC0fffeEd6hpBt57l+YMGgnCSRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vTezO-0001Dd-Kv; Thu, 11 Dec 2025 12:37:42 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vTezO-0057WA-0u;
	Thu, 11 Dec 2025 12:37:42 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 03D3D4B4844;
	Thu, 11 Dec 2025 11:37:41 +0000 (UTC)
Date: Thu, 11 Dec 2025 12:37:41 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mailhol@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, Daniel Hellstrom <daniel@gaisler.com>
Subject: Re: [PATCH 08/10] can: grcan: Add saving and restoring of CAN FD
 baud-rate registers
Message-ID: <20251211-saffron-ara-of-weather-e83dda-mkl@pengutronix.de>
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
 <20251118092115.3455-9-arun.muthusamy@gaisler.com>
 <20251121-daft-vigorous-leech-7719b8-mkl@pengutronix.de>
 <7b5a723711c7a3045e68246effd806b0@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4lqhpjyi5upb6rww"
Content-Disposition: inline
In-Reply-To: <7b5a723711c7a3045e68246effd806b0@gaisler.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--4lqhpjyi5upb6rww
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 08/10] can: grcan: Add saving and restoring of CAN FD
 baud-rate registers
MIME-Version: 1.0

On 11.12.2025 10:13:15, Arun Muthusamy wrote:
> From the design point of view, I prefer to retain the "do_set_bittiming"
> callback to maintain flexibility in adjusting baud rates by the framework.

If you don't implement the do_set_bittiming callback you don't loose any
flexibility.

> Since CAN and CANFD configurations differ as they use different registers
> for timing configuration and Specifically, the timing configuration is
> closely tied to the reset logic only in scenarios where the baud rate for
> CANFD is stored in a register. This differentiation is not applicable to =
CAN
> timing configuration, as CAN and CANFD are handled differently.

=46rom my point of view not implementing the do_set_bittiming makes it
easier from the driver's perspective.

Now
---

If the interface is down do_set_bittiming may be called at any time.

Consider a scenario where the device and driver support deep sleep,
power down clocks/voltages etc. .... In the do_set_bittiming callback,
you must switch on the device, write the bit timing information and
switch the device off again. Some devices lose their configuration
when they are switched off. It therefore makes no sense to implement
this callback on these devices.


What I propose
--------------

Do not implement do_set_bittiming.

If the interface is down the user can configure the bit timing. The
information is stored as usual in priv->can.bittiming,
priv->can.data_bittiming.

If the user brings up the interface the open callback is executed. In
this callback you power on the device, do a reset and then call
grcan_set_bittiming() explicitly. You don't have to take care to
preserve the timing register information around the reset.


Does this make sense?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4lqhpjyi5upb6rww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmk6rQIACgkQDHRl3/mQ
kZwdKAf/csNWDP/PGSe+qMNFf04a8576lPg3nn8+/yALuPQzB/rOoIxRZok+kGcg
2d9GO4bwQ8dzNdOL0WrBlOpH1OR8Ihfplcr17JhvLNvGJSg0wtBka5Qhq1+DUwYn
kwfDaVb7KQKPvJef1zXfFk89rnM+l72b99EBAjLI4362Sj+ULCblsW0TLrdPcQJp
MI4Np3JI1SsdNQN1Cqi16zivQsW9OU4v9BhQttBqL+BcCkOvMsVXCZgrk05c5/Qy
vpLG6S0ArDgM3qjd77hbBZyRUtxN0oJVWyLklpuJQrD9bLOotVFTOY3d+dMT9lwA
0t5sCz4fn685XXWhGXHvIqLbqNqcYw==
=SGmm
-----END PGP SIGNATURE-----

--4lqhpjyi5upb6rww--

