Return-Path: <linux-can+bounces-5090-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCCEBB096A
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 16:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B9C19469AB
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 14:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7252FD7AE;
	Wed,  1 Oct 2025 14:00:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5A2FCBE9
	for <linux-can@vger.kernel.org>; Wed,  1 Oct 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327203; cv=none; b=MApJwTqixrCo4PIKf9UBuu1zJNKIlfuXEEpQC81l+yAGgFtAcGIi88MhIc2aPnhDgOhZmkcojcMwHp17eIYRDJf011BWqpGhAA4ww3TxdxCPTyion0Tv2UxOF+t7k8gm9UryM7JLuHs9k9cSE0gf/LVIjphK85bPieoV7uLLI28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327203; c=relaxed/simple;
	bh=mViMuCwgiu9GW33DdlEf1ADOtOgaSJ1t0rBgRPiNpdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEPrKMXg0eTo9yqMlZwztfneCMVLMd0zwL1njokw5YEWfpL/bLlDZRuAhu5i5aGyWEimOWlue4JrhKFfg/r4P5CG9LMXnmeB/IY2QhRJ3fskGm+Bk3+M+sAoeUuZvPTj5yuAGb2qtbM3je0pf3QBz3ykZqr383StETiQ03A0Qxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v3xMs-0002tU-Ol; Wed, 01 Oct 2025 15:59:42 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v3xMr-001QGP-0w;
	Wed, 01 Oct 2025 15:59:41 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D82C347DE9F;
	Wed, 01 Oct 2025 13:59:40 +0000 (UTC)
Date: Wed, 1 Oct 2025 15:59:40 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, mani@kernel.org, 
	thomas.kopp@microchip.com, mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linus.walleij@linaro.org, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com, 
	anup.kulkarni@oss.qualcomm.com, Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 5/6] can: mcp251xfd: add gpio functionality
Message-ID: <20251001-fascinating-orange-skunk-7545f3-mkl@pengutronix.de>
References: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
 <20251001091006.4003841-6-viken.dadhaniya@oss.qualcomm.com>
 <CAMRc=MfMO-+SSrTY-XQLtsDnxpj_E3TdTJ43ZxCUi-iDrvnc2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dheqrci4kj4ldcp6"
Content-Disposition: inline
In-Reply-To: <CAMRc=MfMO-+SSrTY-XQLtsDnxpj_E3TdTJ43ZxCUi-iDrvnc2w@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--dheqrci4kj4ldcp6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 5/6] can: mcp251xfd: add gpio functionality
MIME-Version: 1.0

On 01.10.2025 15:52:56, Bartosz Golaszewski wrote:
> On Wed, Oct 1, 2025 at 11:10=E2=80=AFAM Viken Dadhaniya
> <viken.dadhaniya@oss.qualcomm.com> wrote:
> > +
> > +       if (!device_property_present(&priv->spi->dev, "gpio-controller"=
))
> > +               return 0;
> > +
>=20
> Hi! I didn't notice this before you're returning 0 here, meaning the
> device will be attached to the driver even though it doesn't do
> anything. It would make more sense to return -ENODEV.

I consider the GPIO functionality of the mcp251xfd CAN controllers
optional. So if the DT doesn't contain gpio-controller, continue without
GPIO functionality.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dheqrci4kj4ldcp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjdM8kACgkQDHRl3/mQ
kZzIDgf7BCH8q6+Cv9RlPmia1P2Kf+tzDwMJONSASAwkQOpvwstGbJZqQTMSeGpx
WvPPDwPENjIiZKIDDIo7yKuFYRIHSSWYmVoqBoSUhElm5V0CHZfJCFY7FVWHy9Ji
FM4WZt+3bS+dKcQuFc/FqJUD4ANf4sB4WgVZ5rfqx1qUCyVz0nfoYvbNel5DaiXu
4rCWGoWQjcYOLFZAMdy70RlJuosPtU18wKNc2xfMUl3E8sMpkzRTZibGgD+g66oo
/BgroYa+mylH3z1e5Fd+1LQBzhwRUAsjg/p9SJau3aGVu/Q4kum5Ub1mYUsqQc0e
FFTnKkGDREIdny5xKv2XrSNRYykmMw==
=FWOd
-----END PGP SIGNATURE-----

--dheqrci4kj4ldcp6--

