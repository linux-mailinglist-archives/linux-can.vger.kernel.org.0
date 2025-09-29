Return-Path: <linux-can+bounces-5047-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE33BA8614
	for <lists+linux-can@lfdr.de>; Mon, 29 Sep 2025 10:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4940D3A9418
	for <lists+linux-can@lfdr.de>; Mon, 29 Sep 2025 08:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF13264A60;
	Mon, 29 Sep 2025 08:22:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DBA14B06C
	for <linux-can@vger.kernel.org>; Mon, 29 Sep 2025 08:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134155; cv=none; b=NISnEWKu/o1V/lgCPeWadeDmVQKanTutBgFxmz2JyQ1JZlcOvxH3i4BdHitT9DdUqJyPIh1LQcMGLmC67wm6//gHo/vSO+MKzOa/DXyvm2LgoMUeyVg3nYl1+VIK+o4LQwac5qB5oQQNFI4P+xXooy4NIM+lVJ15q8p8n16qyd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134155; c=relaxed/simple;
	bh=bvzJU8w4wT8IzHIL9JzpE0ujLPMRWcw0FiYpZ5vOfww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPqsuLGPgIk/YWb5atj+65rzMtZAv5OHwdaAhFqgTlvDB38iDglpsxrQQOsQCXz5JyKFWexjvgdT+QmCgYQQXsRYiGMRYTHQL8AmmF6FqJApZCONGXN35texp9dSMFJD7nBzs32LDaeuAD10tZ+Jp4qOHvcDi4nBFKLhhGYY+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v399G-0005Da-TJ; Mon, 29 Sep 2025 10:22:18 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v399E-0012s9-1s;
	Mon, 29 Sep 2025 10:22:16 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3786047C36C;
	Mon, 29 Sep 2025 08:22:16 +0000 (UTC)
Date: Mon, 29 Sep 2025 10:22:15 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andrea Daoud <andreadaoud6@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alexander Shiyan <eagle.alexander923@gmail.com>
Subject: Re: Possible race condition of the rockchip_canfd driver
Message-ID: <20250929-curvy-cicada-of-sufficiency-a7f464-mkl@pengutronix.de>
References: <CAOprWosSvBmORh9NKk-uxoWZpD6zdnF=dODS-uxVnTDjmofL6g@mail.gmail.com>
 <20250919-lurking-agama-of-genius-96b832-mkl@pengutronix.de>
 <CAOprWott046xznChj7JBNmVw3Z65uOC1_bqTbVB=LA+YBw7TTQ@mail.gmail.com>
 <20250922-eccentric-rustling-gorilla-d2606f-mkl@pengutronix.de>
 <CAOprWoucfBm_BZOwU+qzo3YrpDE+f-x4YKNDS6phtOD2hvjsGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kcxxquzapiv75lfm"
Content-Disposition: inline
In-Reply-To: <CAOprWoucfBm_BZOwU+qzo3YrpDE+f-x4YKNDS6phtOD2hvjsGg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kcxxquzapiv75lfm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Possible race condition of the rockchip_canfd driver
MIME-Version: 1.0

On 28.09.2025 00:26:59, Andrea Daoud wrote:
> > Alexander Shiyan (Cc'ed) reads the information from an nvmem cell:
> >
> > | https://github.com/MacroGroup/barebox/blob/macro/arch/arm/boards/dias=
om-rk3568/board.c#L239-L257
> >
> > The idea is to fixup the device tree in the bootloader depending on the
> > SoC revision, so that the CAN driver uses only the needed workarounds.
>=20
> Thanks, it is not easy to correlate this because I am currently not using
> barebox. I'll try this later.

The most important information in this code is where the SoC revision is
located: there is a separate nvmem cell for this. You can read out the
information once manually and change your device tree accordingly.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kcxxquzapiv75lfm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjaQbQACgkQDHRl3/mQ
kZzG/QgAket73QctCSBYEFyXMkmAapZL5ozqRJ4nTbFGZ2D4bxX6sYSf72hYfyk7
irJ+U0i4XYPuRkFvswbR5TLLqnz+Miz2yB1TbhRiD0h8ChLKgZEKZtnrEXm8Inxn
QzEg3x5x6tYQytolcXFHKzIM9FBXGnZB+pSQxXXoLPo+O6E9wmHc6l1BJe1fhJNi
vn1G7zQsFQXxU2e3Mm4j9mi8iCG9k++0f6I1t+hVEg11egn/i3hgs2jpIbKW1uv4
z76o7HAvN7Rdehs+E4VZu91g95TcNfVBJrvFb9HrDST0JG8I0w0GdQtc0ixKkl/5
lXTDJ7pB+WBJmn4iGNmH3CXFgbx2TA==
=CV6U
-----END PGP SIGNATURE-----

--kcxxquzapiv75lfm--

