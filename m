Return-Path: <linux-can+bounces-6141-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B53D1E3FC
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 11:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 246DC300F079
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 10:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB5B38B983;
	Wed, 14 Jan 2026 10:56:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341A396B7D
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388168; cv=none; b=rfoWYNz9M+Fp62FaWsxY9eDhihY+Mn8bj4ZEpJ6MNqSrYyzNfQhRdGgy6iGgZUTbBmDFlSwxkAXXbe5FLDgEQReMrFm5s8De5EPGHRbbfbfXgEH2vYBl7j4NaPIi/s/+ZD9lIxX9vhzLrUqaBRJzO221rUYX3Dqe40Ifoxtm+qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388168; c=relaxed/simple;
	bh=TFXJPZWGpl54cSTcCYhtipKJO/Lux3C0FWYcL5Vh9l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTayipanZl3glDTXtTWiJwAGl3Apcw9jFeF5RMBBltA3BemjEkBGshD1CEA80EHRf+g40obCVfAy3n/nDdh5A/8wvo/8zxz6y6D/2WHsHFjBGdSc/ntRakPAGxhG/lcPCb3tP24DXyITr4lFU0x93xweSy3dfpeTpyRD06XRK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vfyVq-0007Hy-3Z; Wed, 14 Jan 2026 11:54:06 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vfyVq-000ZfO-1r;
	Wed, 14 Jan 2026 11:54:05 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 981BA4CCB8A;
	Wed, 14 Jan 2026 10:54:05 +0000 (UTC)
Date: Wed, 14 Jan 2026 11:54:05 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH can 0/5] can: usb: fix URB memory leaks
Message-ID: <20260114-crimson-oryx-of-attraction-db2620-mkl@pengutronix.de>
References: <20260110-can_usb-fix-memory-leak-v1-0-4a7c082a7081@pengutronix.de>
 <5b5c8a8b-5832-4566-af45-dee6818fa44c@hartkopp.net>
 <20260114-offbeat-impala-of-finesse-df5c4c-mkl@pengutronix.de>
 <e2cadc66-0c11-4651-a2e2-b272d8ed598b@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a2yivffd5lkjt4x2"
Content-Disposition: inline
In-Reply-To: <e2cadc66-0c11-4651-a2e2-b272d8ed598b@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--a2yivffd5lkjt4x2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can 0/5] can: usb: fix URB memory leaks
MIME-Version: 1.0

On 14.01.2026 11:30:59, Oliver Hartkopp wrote:
> Can you probably send a linux-can PR for the
>
> Revert "can: raw: instantly reject unsupported CAN frames"
>
> https://lore.kernel.org/linux-can/20260101191330.1836-1-socketcan@hartkop=
p.net/
>
> patch set in the near future?

done: https://lore.kernel.org/20260114105212.1034554-1-mkl@pengutronix.de

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--a2yivffd5lkjt4x2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlndcoACgkQDHRl3/mQ
kZyI3wf/UINzOcelXM5ebEFQFj9Z6/x9+Ey/YJoIMbJa2G/crjgx49zg/jUWLA9Q
1aELjrQmSAzPMBIUcMXJS0hJUHA1921LRUt+UqpPLi3akpakQYvG+J8Kb2lehdls
ez5PS2ZDsMt54VPQIbphHI++SFaQwGy2QSPgKRS40IfJ4Fhu8ke/WddKGQo1JBZV
DUZOBaIDDy3/Tvzn2Chmj4zGUK3oMbmpYPwjq2vN86lwGlHJYl/c/68kqB2mNpcU
7WZOubVXVHNkJ3MdPBx92lFVysn3hdJJADS4Zl+4rWgxsIVYhkiLonisNv4mxI00
ubqRzWQpZ5cTn+6+V80cljb/1gu7DQ==
=87CX
-----END PGP SIGNATURE-----

--a2yivffd5lkjt4x2--

