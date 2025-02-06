Return-Path: <linux-can+bounces-2743-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE18DA2A8CB
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2025 13:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20A018879A2
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2025 12:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54909225783;
	Thu,  6 Feb 2025 12:50:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E913D897
	for <linux-can@vger.kernel.org>; Thu,  6 Feb 2025 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738846257; cv=none; b=LazZplBlIpWe5u2mQBv3f3UoK3eyxC1a332EFcDmLgGXgKQW3OzZpeLBlGEdEptbepxeRgukYz8nSAtI/i+F9GxeI6iwzDOx2w0sX5Dx6+URu2mqhHw2wh3PldW6MX0m31c5p2J37hAL9ZQPYQqDLiHxCDwdhv6QSRToKj5DmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738846257; c=relaxed/simple;
	bh=VuIhI8tQgA4HUk9XjidJaEK0CojKXyWyBtOSUtaTVjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcEgHKB+QXlwqVMTCJS32ureBcbVtKKZzHYNSiKKUOF/IIZ7Y0x4cd/H3LNsyp+SQlfvrEHECZf8PmF1518ta2xoc8qW3t4Ulg+8TVATUI6OmtYWrsinFHREP9LxF9GqMK9tN1Dz1v1FY6/bDtyRKCVMiqqex6H/4uxddR61tCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tg1LK-00053G-73; Thu, 06 Feb 2025 13:50:54 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tg1LJ-003oEL-1v;
	Thu, 06 Feb 2025 13:50:53 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 432F83BB4D5;
	Thu, 06 Feb 2025 12:50:53 +0000 (UTC)
Date: Thu, 6 Feb 2025 13:50:49 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Henrik Brix Andersen <henrik@brixandersen.dk>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH] can: gs_usb: add VID/PID for the CANnectivity firmware
Message-ID: <20250206-bold-earthworm-of-chaos-e62ff0-mkl@pengutronix.de>
References: <20250120133827.668977-1-henrik@brixandersen.dk>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="duzihgedqgeh7zmy"
Content-Disposition: inline
In-Reply-To: <20250120133827.668977-1-henrik@brixandersen.dk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--duzihgedqgeh7zmy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: gs_usb: add VID/PID for the CANnectivity firmware
MIME-Version: 1.0

On 20.01.2025 13:37:59, Henrik Brix Andersen wrote:
> Add USB VID/PID for the CANnectivity USB to CAN adapter firmware.
>=20
> Signed-off-by: Henrik Brix Andersen <henrik@brixandersen.dk>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--duzihgedqgeh7zmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmeksCcACgkQDHRl3/mQ
kZw9fggAo2bCroQ6MXjPK8ZW09xQjdRGAuPmkYS7Tj959Jr+Q/KBPCKmhAVxgyQT
rB8pT/c2fm2g7ikg9Sz2wxIUnlhiF33lJfhZCDxxMDfmOkQiQywZvYJ6hkYRPyWH
ZBEk3uJCOJDlw1i/qHTlkmQDtAKozOcsmHFLncCgM5errU+J0ejd2tZpUS8o2t/w
k64GuvIkZCwvNmpP0ZYsT3hPFznYeU1wCQdrcTLY5B8HVBd8dsV2JyF9mdeNavcS
llhtaffLLnz1pShIvPBi90Kz/zR+e1CR1KXXmhcWD+JrVX+cfe/n9718Ho7237E1
hrXzuuf5MkAoXvGBX+u4c6EhtKRkZg==
=p3pq
-----END PGP SIGNATURE-----

--duzihgedqgeh7zmy--

