Return-Path: <linux-can+bounces-4620-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD31B50DEA
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4974E7E1E
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBBD2D24AC;
	Wed, 10 Sep 2025 06:13:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0C2D0614
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484824; cv=none; b=iMNBEbMaFsvpuDeoVJ8gJNd4cxF2atkAYaOqWg13dr+y/DXrdc8OtczQz5it1AOa2c27T5Vu9Z0OctzuzK2Q+t148ckXRuuijdryElH3vIYiecUTDAQZqf4nMVPINYSXAT+JpoWATkcO4me+a0S/1dHuNq2cPjsN2svvOAHKvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484824; c=relaxed/simple;
	bh=TXW5EsKPgr4c5ONJ0jDE+fwkqy249IWWjNFMOAMcdyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUijX0TU8kzZEYMU/kIYOJFa0n7GXWweknQSBtnyYaZNxUsl2gxhnFHHi/qVxDHWonxSzr1jfupNrwkLxtAuNd/dfLDRSlH0vbn8Ujg4TdLMLDAwP0Snp7b21+0O02ac1UdySaV4xa5uih/2MDlYJelkfRtUEAEOLKIXtU7hvW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwE5E-0002c3-W8; Wed, 10 Sep 2025 08:13:33 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwE5C-000XuT-1e;
	Wed, 10 Sep 2025 08:13:30 +0200
Received: from pengutronix.de (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2585F46AA4A;
	Wed, 10 Sep 2025 06:13:30 +0000 (UTC)
Date: Wed, 10 Sep 2025 08:13:29 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>, Robert Nawrath <mbro1689@gmail.com>, 
	Minh Le <minh.le.aj@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/20] can: netlink: refactor can_validate_bittiming()
Message-ID: <20250910-outrageous-liberal-falcon-9215d3-mkl@pengutronix.de>
References: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
 <20250910-canxl-netlink-prep-v2-4-f128d4083721@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lp4tox2vxh5x4cj5"
Content-Disposition: inline
In-Reply-To: <20250910-canxl-netlink-prep-v2-4-f128d4083721@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--lp4tox2vxh5x4cj5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 04/20] can: netlink: refactor can_validate_bittiming()
MIME-Version: 1.0

On 10.09.2025 15:03:29, Vincent Mailhol wrote:
> Whenever can_validate_bittiming() is called, it is always preceded by
> some boilerplate code which was copy pasted all over the place. Move
> that repeated code directly inside can_validate_bittiming().
>=20
> Finally, the mempcy() is not needed. Just use the pointer returned by
> nla_data() as-is.

The memcpy()'ed struct is guaranteed to be properly aligned, is this
also the case for the casted nla_data() pointer?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lp4tox2vxh5x4cj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjBFwQACgkQDHRl3/mQ
kZzT3ggAkmLLYYObiNDEQcKIbz8ncVsf7o15v9oDTS0lvYnLSw4dB4mKzFk9/ktg
PUMvr9x0Jl7ZyangtE6ehI+xNlLPB4nd0U68tIBEFfPpjzO0Y+Oo9+g7x3lg6FZM
6A4uO2SFnvvKxDLc9PtLRXgk4edQf5WaN+6/RwJ4TlCPuX2zeq0eOm1RsBQ4A9tO
FtUNhO9I1Z8NM6xlig3qa/bKbypRwfY8E6UGOmUTqfXClm91gVN7ftknqmLDpU07
IpKpTEPlxHRYyb/yE25grmB0E/IC1O4Y2VPBQU2SRwUrvQE6MVLL7SZxeU73YxUh
zfzlU1h7ZSs+Xa8OO3h6W+PMAN87BQ==
=Tbxj
-----END PGP SIGNATURE-----

--lp4tox2vxh5x4cj5--

