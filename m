Return-Path: <linux-can+bounces-3832-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD82AD8512
	for <lists+linux-can@lfdr.de>; Fri, 13 Jun 2025 09:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF19818968C9
	for <lists+linux-can@lfdr.de>; Fri, 13 Jun 2025 07:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D880C2D8DA4;
	Fri, 13 Jun 2025 07:40:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A652D8768
	for <linux-can@vger.kernel.org>; Fri, 13 Jun 2025 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800455; cv=none; b=f6dZcDvkrq9ViNKEmwwvnDK1X+VCUFtXlqusunrB19td3rkYOyQtlqcd2NqJ1Y9XNzaBAKzdPVgji/+8XL0Rfj0lHB09uWQsyZT9zLo9Ajwb8Ks83HqCJYSfSSoap6jvikP0gLCoAA7FXHNN6J8sJi9LnVvgV+2jIb6IBRGKTDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800455; c=relaxed/simple;
	bh=ZTgykwrQ/uvu0WxrFe5IWaDg+Ue2q3mSdGGue0wJEzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsXMyWYy08pErKHtIsKJaUiItGqtRlksjgXgAlRFf79VRdfzU0jHWVCR3adPEM2gHxF5ueFwZlLdcaVetrWk6TXPLpkFuF8PzHkJNyeK8mdLg4VL3zC3lzzmvkcZrwc3n9QJVC8m4/FM2JZPsH2v5YHGGnx7LtlKIPzzq2qfWI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uPz1m-0000p0-91; Fri, 13 Jun 2025 09:40:42 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uPz1l-003Fm3-0I;
	Fri, 13 Jun 2025 09:40:41 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BCB85426D71;
	Fri, 13 Jun 2025 07:40:40 +0000 (UTC)
Date: Fri, 13 Jun 2025 09:40:40 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 00/10] can: rcar_canfd: Add support for Transceiver
 Delay Compensation
Message-ID: <20250613-misty-amethyst-swine-7bd775-mkl@pengutronix.de>
References: <cover.1749655315.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cqr3lbnu6ay557v2"
Content-Disposition: inline
In-Reply-To: <cover.1749655315.git.geert+renesas@glider.be>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--cqr3lbnu6ay557v2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 00/10] can: rcar_canfd: Add support for Transceiver
 Delay Compensation
MIME-Version: 1.0

On 11.06.2025 17:37:29, Geert Uytterhoeven wrote:
> 	Hi all,
>=20
> This patch series adds CAN-FD Transceiver Delay Compensation support to
> the R-Car CAN-FD driver, after the customary cleanups and refactorings.
>=20

There's no reference to footnote [1], as it refers to the v1, I'll add
it here.

> Changes compared to v1:

Changes compared to v1 [1]:

>   - Dropped patch "can: rcar_canfd: Use ndev parameter in
>     rcar_canfd_set_bittiming()",
>   - New patch "[PATCH v2 02/10] can: rcar_canfd: Remove bittiming debug
>     prints",
>   - New patch "[PATCH v2 07/10] can: rcar_canfd: Rename
>     rcar_canfd_setrnc() to rcar_canfd_set_rnc()",
>   - Add Reviewed-by,
>   - Replace function-like RCANFD_F_*() macros by rcar_canfd_f_*()
>     inline functions,
>   - Replace function-like macro RCANFD_FDSTS_TDCR() by bitmask
>     RCANFD_FDSTS_TDCR and helper function rcar_canfd_get_tdcr(),
>   - Replace function-like macro RCANFD_FDSTS_TDCVF() by two bit
>     definitions,
>   - Drop debug print of tdc mode and tdco value.
>=20
> This has been tested on R-Car V4H (White Hawk), V4M (Gray Hawk Single),
> and E3 (Ebisu-4D[2]), using various data bit rates.  Without proper TDC
> configuration, transmitting at 8 Mbps makes the CAN-FD controller enter
> BUS-OFF state.  The TDCV value as measured by the CAN-FD controller is 4
> on all boards tested (base clock 40 MHz, i.e. 25 ns period), and ca. 90
> ns as measured by a logic analyzer on Gray Hawk Single.
>=20
> Note that the BSP (predating upstream TDC support), uses a much simpler
> method: for transfer rates >=3D 5 Mbps on R-Car Gen4, it enables TDC with
> a hardcoded (hardware) TDCO value of 2 (i.e. actual 3), which matches
> the behavior of this series at 8 Mbps.
>=20
> Thanks for your comments!
>=20
> [1] "[PATCH 0/9] can: rcar_canfd: Add support for Transceiver Delay Compe=
nsation"
>     https://lore.kernel.org/cover.1748863848.git.geert+renesas@glider.be

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cqr3lbnu6ay557v2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhL1fYACgkQDHRl3/mQ
kZz2fgf/edR1T7y9FKCMHjWXZUu8CKSp/DTFYYtRtJx7sJbLDxIsV/Iqx/ZcOm0d
9VojNbRX3gFAW0LuoMl++jV6DNrSRnELY3YIMTu9ZGVHlthVe+AYIiwa0ApWZqov
jQ+S9Z9rnhkWBzJx/mIxnWfxD15s1pbWIUd8rMjx4bHR+csXU/EogF3rOmb08G33
l/YkzcAqYenYJJac9okyckodwFl26or9r4ROmegF2A8tN6EKK+nOAiPhVrInB6pG
U1AmC+xLddxDW0T5/MPSicDn3VRQy42q99AngPIRT2R3dX2W0HHv/OIq2VPHf6ww
mOe+8nepx2bkf4zF+0vKACRrNVFafg==
=/l4W
-----END PGP SIGNATURE-----

--cqr3lbnu6ay557v2--

