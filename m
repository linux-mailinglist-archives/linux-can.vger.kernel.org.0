Return-Path: <linux-can+bounces-3495-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B98FA9EAF2
	for <lists+linux-can@lfdr.de>; Mon, 28 Apr 2025 10:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522FA16871E
	for <lists+linux-can@lfdr.de>; Mon, 28 Apr 2025 08:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6591725E47E;
	Mon, 28 Apr 2025 08:39:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD725E466
	for <linux-can@vger.kernel.org>; Mon, 28 Apr 2025 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745829568; cv=none; b=GKj7SvfJzxv6MvPAKx5ayMpE0aG8T8Mc91zUyRZrUkogh2JgR5NZiVKJ3kRGUkgLQtESqCNXz83r1haUrJOvbNQ4gUqGPOaM+NwWoVnurbLBZXii8PlO0c2gB+7R8cc+NcM1lgjXtNMSB/neH8n1JQ9lbfO65TaGcte2zzCeAbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745829568; c=relaxed/simple;
	bh=leqFoc21fVUMc1ZGjOyVsVrsWy0RZ0SPhkdz+oVi9YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv1YL4SbpvZ5nIx5ewwlyq+sgc8/uXsMlOnPg/gWacBIi3u1nx+qgQEOz84jdWRRsNgLB7kzj4rk3Z67RQPpMwGUqge5JRWRLy0IFMXNv1+O/5WlSd7mJqGdy6HUYGtRrgS4P+VDcx5/LKWINC3ATuG7HjBT5UIF66xZMTMk764=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1u9K1L-0000nP-VW; Mon, 28 Apr 2025 10:39:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1u9K1L-000403-2Q;
	Mon, 28 Apr 2025 10:39:23 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E01784034D9;
	Mon, 28 Apr 2025 08:39:00 +0000 (UTC)
Date: Mon, 28 Apr 2025 10:39:00 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kelsey Maes <kelsey@vpprocess.com>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcp251xfd: make TDC controllable from userspace
Message-ID: <20250428-impressive-masterful-squid-a898c4-mkl@pengutronix.de>
References: <20250425191336.45581-1-kelsey@vpprocess.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zt2wpvmnr6rh2dwu"
Content-Disposition: inline
In-Reply-To: <20250425191336.45581-1-kelsey@vpprocess.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--zt2wpvmnr6rh2dwu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: mcp251xfd: make TDC controllable from userspace
MIME-Version: 1.0

On 25.04.2025 12:13:36, Kelsey Maes wrote:
> TDC is currently hardcoded enabled so lower CAN FD data bitrates result i=
n a
> bus-off condition. This patch allows userspace to control TDC as needed.

I think the underlying problem is that the original code always enables
TDC. Lower data bitrates result in a DBRP > 1, as you stated in your
original mail:

> > I have a problem where I get a bus-off condition when using bit
> > rates that use a DBRP > 1.

=2E..and in auto mode TDC is only enabled for DBRP =3D=3D 1 or 2. Switching=
 to
CAN_CTRLMODE_TDC_AUTO brings the positive side effect, that TDC is
controllable from user space. So the commit message can be made more
precise, what about:

Subject: can: mcp251xfd: fix TDC setting for low data bit rates

THe TDC is currently hardcoded enabled. This means even for lower CAN-FD
data bitrates (with a DBRP (data bitrate prescaler) > 2) a TDC is
configured. This leads to a bus-off condition.

ISO 11898-1 section 11.3.3 says "Transmitter delay compensation" (TDC)
is only applicable if data BRP is 1 or 2.

To fix the problem, switch the driver to use the TDC calculation
provided by the CAN driver framework (which respects ISO 11898-1 section
11.3.3). This has the positive side effect, that the user space can
control TDC as needed.

Can you also add these tags:

Reported-by: Kelsey Maes <kelsey@vpprocess.com>
Closes: https://lore.kernel.org/all/C2121586-C87F-4B23-A933-845362C29CA1@vp=
process.com

BTW: In you original mail, you've written that you're using a bitrate
of 125 kbit/s and a data bitrate of 500 kbit/s. This is a bit unusual.
Is that a real world application? Are you allowed to say which one?

I just noticed that there is another potential problem with this
combination of bit rates. The used BRP for the arbitration- and data
bitrate are not identical:

| Bit timing parameters for mcp251xfd with 40.000000 MHz ref clock (CIA rec=
ommendation) using algo 'v6.3'
|                     _----+--------------=3D> TSeg1: 2 =E2=80=A6  256
|                    /    /     _---------=3D> TSeg2: 1 =E2=80=A6  128
|                   |    |     /    _-----=3D> SJW:   1 =E2=80=A6  128
|                   |    |    |    /    _-=3D> BRP:   1 =E2=80=A6  256 (inc=
: 1)
|                   |    |    |   |    /
|  nominal          |    |    |   |   |     real  Bitrt    nom   real   Sam=
pP
|  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP   Err=
or      NBTCFG
|   500000     25  34   35   10   5   1   500000   0.0%  87.5%  87.5%   0.0=
%   0x00440904
|   125000     50  69   70   20  10   2   125000   0.0%  87.5%  87.5%   0.0=
%   0x018a1309
|=20
| Data Bit timing parameters for mcp251xfd with 40.000000 MHz ref clock (CI=
A recommendation) using algo 'v6.3'
|                     _----+--------------=3D> TSeg1: 1 =E2=80=A6   32
|                    /    /     _---------=3D> TSeg2: 1 =E2=80=A6   16
|                   |    |     /    _-----=3D> SJW:   1 =E2=80=A6   16
|                   |    |    |    /    _-=3D> BRP:   1 =E2=80=A6  256 (inc=
: 1)
|                   |    |    |   |    /
|  nominal          |    |    |   |   |     real  Bitrt    nom   real   Sam=
pP
|  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP   Err=
or      NBTCFG
|   500000    125   6    7    2   1   5   500000   0.0%  87.5%  87.5%   0.0=
%   0x040c0100

This leads to a phase error while switching from arbitration to the data
bitrate. A common BRP of 5 is better:

| Bit timing parameters for mcp251xfd with 40.000000 MHz ref clock (cmd-lin=
e) using algo 'v6.3'
|  nominal                                  real  Bitrt    nom   real   Sam=
pP
|  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP   Err=
or      NBTCFG
|   125000    125  27   28    8   4   5   125000   0.0%  87.5%  87.5%   0.0=
%   0x04360703
|=20
| Data Bit timing parameters for mcp251xfd with 40.000000 MHz ref clock (cm=
d-line) using algo 'v6.3'
|  nominal                                  real  Bitrt    nom   real   Sam=
pP
|  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP   Err=
or      NBTCFG
|   500000    125   6    7    2   1   5   500000   0.0%  87.5%  87.5%   0.0=
%   0x040c0100

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zt2wpvmnr6rh2dwu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgPPqAACgkQDHRl3/mQ
kZw5HQgArp5RmAa8mQDDxrpL6BiFagfgi9H9s+5EgwwHJ3YqJCOxNyrirDkPz64m
jHTZUTNkuNGqJMSZXhOn9Y+GgmKKhtkK5UwPPHSf+4e1Qy/ym/lUTnGUd26y5aUQ
DbcE+KEJGSaj2kFBn+Ai7TXH4KdIUF40M2bA4B6WLGpcAGR816ndTuIkbHvcCc4F
5ApclTh+difNBQDOh6igwODrzDxOfGRSStRiPreh8dv1P7YiuJFzd0EohJg7fMUk
4uB8meOoE/SCMWodwJKz6otLfpN+GTDblSW4x9ogmF5TQ4BPdpgK/GUKSz4i9129
hwoRR8QpJ5X1ghJQKZlFg025qazGbg==
=8n3u
-----END PGP SIGNATURE-----

--zt2wpvmnr6rh2dwu--

