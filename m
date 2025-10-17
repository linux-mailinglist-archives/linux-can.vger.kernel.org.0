Return-Path: <linux-can+bounces-5202-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6A6BE806E
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 12:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 760A45649BE
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 10:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42E12D7DF1;
	Fri, 17 Oct 2025 10:15:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF59298991
	for <linux-can@vger.kernel.org>; Fri, 17 Oct 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696143; cv=none; b=cq5EEz9cOmgWtJlEoEL46kwth48JHMQVRk6q7rrvAALDLa6ejy0jwc2GDAyXmyctD6egjwgrQ7lBrbmPOST+az76/mPF73I8/G8/ghdwV69UgQxRIy5r/H0nyPZTz+7wp04L/nB9MD5MmjFZlJZ4TYshIyuwYIzHJMcsYIpJZuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696143; c=relaxed/simple;
	bh=JvApeXOv0FX+Ib72v+YP0lpk09mQjzAd5OsdmdYCMgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0LhbVDBlsxa+ZQjtJpBVP6HTYKvUjT6ItQutaxhVYW+lJlg7487E1lJmExUcA7y4cJwh0gN5sE/bvvOGsW/IcVYC/v7Ya3U7pQirVDoHZ4cSIxR0noDz8s4bOkmX9Nmh9A3Kfwhy+LFXnD+ouVyUOhlLM0c9r1+AzL2qRKGxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9hUW-0004KA-Ed; Fri, 17 Oct 2025 12:15:20 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9hUS-0042fz-22;
	Fri, 17 Oct 2025 12:15:16 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 39238488F55;
	Fri, 17 Oct 2025 10:15:16 +0000 (UTC)
Date: Fri, 17 Oct 2025 12:15:15 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vincent Mailhol <mailhol@kernel.org>, 
	Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
	Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/4] can: m_can: Add am62 wakeup support
Message-ID: <20251017-hospitable-efficient-firefly-c3f32b-mkl@pengutronix.de>
References: <20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fozm3zg4iurpuf5k"
Content-Disposition: inline
In-Reply-To: <20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--fozm3zg4iurpuf5k
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 0/4] can: m_can: Add am62 wakeup support
MIME-Version: 1.0

On 01.10.2025 16:30:18, Markus Schneider-Pargmann (TI.com) wrote:
> This series adds support for wakeup capabilities to the m_can driver,
> which is necessary for enabling Partial-IO functionality on am62, am62a,
> and am62p SoCs. It implements the wake-on-lan interface for m_can
> devices and handles the pinctrl states needed for wakeup functionality.

Added to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fozm3zg4iurpuf5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjyFzAACgkQDHRl3/mQ
kZwe2AgAnPbCetz/ZW8pmf453IkrJQ9tVaKg6orkrb1BWNSDmwRSwyCI5kBiqbs7
sycHDvAfjslKfBNKekJRgW/UjWfdcT72QzIrFGFgqivqALwcAMwwcSV8dEnlRBc7
qk//Vp8BCtuNbGujOBsbFxY8oEFpqdhUb9incywBKFsMHzpFX4Lw93ZpMuv0RF7k
jhniWakeh1IyA8SWZRCdaMuzykyD+sevWi7+YwzGQ2ajuCn/r2r+k9iROvBwrlw5
CYvbGfKyBUEvlnV/BW91o8jH3tIkGYC/loWHpt5QSLeRvcnDaMH2Xn1/+uLNoYx/
sQuxSGk6G9Pzfgrna0pxjUuMpoVxJA==
=JGCw
-----END PGP SIGNATURE-----

--fozm3zg4iurpuf5k--

