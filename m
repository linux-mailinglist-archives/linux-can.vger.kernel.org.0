Return-Path: <linux-can+bounces-5993-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE95CF33E2
	for <lists+linux-can@lfdr.de>; Mon, 05 Jan 2026 12:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 837603028D56
	for <lists+linux-can@lfdr.de>; Mon,  5 Jan 2026 11:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0FA33A9D1;
	Mon,  5 Jan 2026 11:16:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF06633A70A
	for <linux-can@vger.kernel.org>; Mon,  5 Jan 2026 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611816; cv=none; b=HqLRUidYGPjYoX8kVFFBJTFwPTQqgmPZ4AfDexUXYUC3ZXxcTzs80tp6II4n3SFOS6IaVuHjcY3qK8cmElQK2TEtP3tAryyZP3ZCd5n5jL4LIvI3dBEagkf1mtQcnjOQNVFTrjAVe22SpPC2iSbh8Xrk34lTbnjaOCPi3kGTsWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611816; c=relaxed/simple;
	bh=JjoPgzEC4mP6Vy0x1fg8v6Y4M8XNcEd2kWV8rJLszAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGN6p66LvnYE/va7H9doITp+qoxMlKdF9TNCS8iQGcjt6jxii3H9G36QP7dboEbcT/iiFKTkqujp0CLyG6/wVSXlxt6oXiin8VfOvjIGXH/p5uloJqfwErLo0NeIByiAuZ0BsyRswcVynVqB+vY7aFP073jtLp4CCr/Hgfz7b0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vciIH-00025R-Jy; Mon, 05 Jan 2026 11:58:37 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vciIG-0099Xn-0v;
	Mon, 05 Jan 2026 11:58:36 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F2F134C64B7;
	Mon, 05 Jan 2026 10:58:35 +0000 (UTC)
Date: Mon, 5 Jan 2026 11:58:35 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: linux-can@vger.kernel.org, David Laight <david.laight.linux@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Andrea Daoud <andreadaoud6@gmail.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Jiri Novak <jnovak@fel.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>
Subject: Re: [PATCH] can: ctucanfd: fix SSP_SRC in cases when bit-rate is
 higher than 1 MBit.
Message-ID: <20260105-flying-thankful-chachalaca-1d68e5-mkl@pengutronix.de>
References: <20251231231926.20043-1-pisa@fel.cvut.cz>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="donhkjnqvsccjyie"
Content-Disposition: inline
In-Reply-To: <20251231231926.20043-1-pisa@fel.cvut.cz>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--donhkjnqvsccjyie
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: ctucanfd: fix SSP_SRC in cases when bit-rate is
 higher than 1 MBit.
MIME-Version: 1.0

On 01.01.2026 00:19:26, Pavel Pisa wrote:
> From: Ondrej Ille <ondrej.ille@gmail.com>

Let's describe the problem here and in an imperative way how it is
fixed.

> The change has been tested on AMD/Xilinx Zynq
> with the next CTU CN FD IP core versions:
>
>  - 2.6 aka master in the "integration with Zynq-7000 system" test
>    6.12.43-rt12+ #1 SMP PREEMPT_RT kernel with CTU CAN FD git
>    driver (change already included in the driver repo)
>  - older 2.5 snapshot with mainline kernels with this patch
>    applied locally in the multiple CAN latency tester nightly runs
>    6.18.0-rc4-rt3-dut #1 SMP PREEMPT_RT
>    6.19.0-rc3-dut
>
> The logs are available at
>
>  https://canbus.pages.fel.cvut.cz/
>
> Signed-off-by: Ondrej Ille <ondrej.ille@gmail.com>
> Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--donhkjnqvsccjyie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlbmVgACgkQDHRl3/mQ
kZztzwf/cm4EoX+2NpVICR7MwS7jUx9mWlSapHJR9hbWx5RVtIqcFpwGKFa6AoaX
Yi7xpig5yDCb6RPcwTi7RyrbMzf+1cCOTv4xHoWAzHdFhxyh5GGs/LVX+v3Z+vbn
nbbw8cPKXoJZ2UyRA3osPFH/Vq0O3PMx1wq3zws5k4urgPb8NQ+uAodeyLJKYXgJ
+/gd/LbPYlyZBfAezaGXSq13ZNrTmdfbSLlZ8OfScG3k9iPP5ASn7FkoNJeUC6ab
3SxHgoggSdF3nvtzmwGXV2GyQdkRpVWH6GWuOQGTsSFnGBwmHSzWaVfZ63U7rYg6
72iN/iKKeqRqea3qNt3sfYzF4N/xEg==
=bFZ0
-----END PGP SIGNATURE-----

--donhkjnqvsccjyie--

