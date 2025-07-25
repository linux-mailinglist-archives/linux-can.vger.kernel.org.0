Return-Path: <linux-can+bounces-4120-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CE5B11C06
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0EA1CE4CCB
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 10:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745092E6D17;
	Fri, 25 Jul 2025 10:12:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576882E3373
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438332; cv=none; b=fbbxv/MdUmUDvCuEPD37+lsTSJEccIRMZi1O6cszUsf6aXcK8HwlnJ9tf404MNdN2XV94JKBKA8JZdsDLi8AHLoUnewzsHxu9eyv2KPdwPc7VqD3SHV8uzHBnGsPRQMNkeGExr/QDW40ax0P3eEOy9Uh491q62n1IokgwEpFr0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438332; c=relaxed/simple;
	bh=gFyTpGpvnyGRabvKUNl0Ei/SOWYQkAlyoWvNbso2++o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcgEUMwFaTD81nqV/zbCRUA8duFVXMDpSpoJRdlxUyaGIFB6uWNyZzRnAuHrKSWZNuS85ujUK/L08OANcrOtt811Qg/Z7xZ/Bqm/BI8L7qN8qYx83A395igyk64x6zh5JoVRSdoXjHlw8snNWTb3id84Jjrby243HfUGRZlGXc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufFPK-0005nC-7h; Fri, 25 Jul 2025 12:12:06 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufFPJ-00ACZN-32;
	Fri, 25 Jul 2025 12:12:05 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A04BD4493A9;
	Fri, 25 Jul 2025 10:12:05 +0000 (UTC)
Date: Fri, 25 Jul 2025 12:12:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <stephane.grosjean@free.fr>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, 
	Stephane Grosjean <stephane.grosjean@hms-networks.com>
Subject: Re: [PATCH v2] can: peak_usb: fix USB FD devices potential
 malfunction
Message-ID: <20250725-married-fearless-carp-adb86d-mkl@pengutronix.de>
References: <20250724081550.11694-1-stephane.grosjean@free.fr>
 <20250725-whimsical-finicky-sambar-5202a2-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="slket4ak4w5tz3mh"
Content-Disposition: inline
In-Reply-To: <20250725-whimsical-finicky-sambar-5202a2-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--slket4ak4w5tz3mh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: peak_usb: fix USB FD devices potential
 malfunction
MIME-Version: 1.0

On 25.07.2025 10:33:25, Marc Kleine-Budde wrote:
> On 24.07.2025 10:13:19, Stephane Grosjean wrote:
> > From: Stephane Grosjean <stephane.grosjean@hms-networks.com>
> >=20
> > The latest firmware versions of USB CAN FD interfaces export the EP num=
bers
> > to be used to dialog with the device via the "type" field of a response=
 to
> > a vendor request structure, particularly when its value is greater than=
 or
> > equal to 2.
> >=20
> > This patch corrects the driver's test of this field.

Rephrased to: "Correct the driver's test of this field.". This part of
the patch description should use imperative language.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--slket4ak4w5tz3mh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmiDWHIACgkQDHRl3/mQ
kZyN7QgAsqvpY2cHbAaDpyobNnkOdw6x4+MCu26rhgaNV/5sti8+4CEhvnWVA3LS
kAkKPrFl811Jb16YQNSB8K5oGuqgnXpR8NM7Yr2ni87H7I7wsRUPYvYyK26ZXRTL
r7P75EAoZu0ns39m68a+fnt182/W7namK0Pcx0S9YMP0S79jiqaF4EiwQgG1eQ7+
TmxYYbXFlXTMXG974UBjhDZdSWChZigSx4dEi3EHyBxhAbD+29rcfoFczqyR5IR9
b6eF49djN2bmgHiLuGP1ONi2KEDGV6BXH1G9TlZLBjVtaGHhDIvU4Nc2I0VcPQmQ
Z54cgjRg9nyDS8RRyM2Qh1tJfbgh8w==
=nC7M
-----END PGP SIGNATURE-----

--slket4ak4w5tz3mh--

