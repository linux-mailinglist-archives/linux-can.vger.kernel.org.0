Return-Path: <linux-can+bounces-290-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CAF857D98
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 14:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75619286761
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 13:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3123768ED;
	Fri, 16 Feb 2024 13:22:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B320D1E4A0
	for <linux-can@vger.kernel.org>; Fri, 16 Feb 2024 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089731; cv=none; b=RHbqf5bwvlD7+lBi7EjeC76e6Y9TtAvSE4eXSPPu4Bk8T6KjIjzbxvF6WXeGOm8fkgAmOtMaqt7wkibr2SYL6s1X2PkAm04Z4MEhKMxxHGauQIzylDBtPldrc+cgjwJJnR3W3SVcVAbZIUSJB1wDbOilJg0EogmEhC+MDECF5FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089731; c=relaxed/simple;
	bh=Dkal/cne9RIm0JYuBPKkRmqHFPI3nM8wxNxzQB4KNFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQFDJ6YMJKEpI9jzYQflUdVxLukKmHtBNk6orXUOgsCklMhEq0BIcE72IatTFPvOGpnLBRcfSX1MzMbCA7M7MbIBLot06fOScvW+ZSKPtkaydKfBKSrVvhHkRqHjPL1ZlR1tBkxF44bHFtVtknMZ3Kv7ozIP/gdLom1pKnPKhuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rayAG-0001uK-73; Fri, 16 Feb 2024 14:22:04 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rayAF-0015Me-Mf; Fri, 16 Feb 2024 14:22:03 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5DCC5290413;
	Fri, 16 Feb 2024 13:22:03 +0000 (UTC)
Date: Fri, 16 Feb 2024 14:22:02 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 1/3] can: peak_usb: fix potential "UBSAN:
 shitf-out-of-bounds" issue
Message-ID: <20240216-storewide-province-2a26f06f2205-mkl@pengutronix.de>
References: <20240215152656.13883-1-s.grosjean@peak-system.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qlaeo4nwjhqykj3l"
Content-Disposition: inline
In-Reply-To: <20240215152656.13883-1-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--qlaeo4nwjhqykj3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.02.2024 16:26:54, Stephane Grosjean wrote:
> Shift exponent 32 is too large for 32-bit type 'int' so u64 values are
> used instead.

FYI: Consider migrating this code to timecounter_read/cyclecounter. See

| https://elixir.bootlin.com/linux/v6.7/source/drivers/net/can/spi/mcp251xf=
d/mcp251xfd-timestamp.c

for an example.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qlaeo4nwjhqykj3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXPYXcACgkQKDiiPnot
vG9zgwf/RtOZ09uLV6ba/P47X0tasoYBRD/5izbyZgpXQiqjP+tUzDADHvIYP/Fy
D4u9mzU7jEjqx3zBfdooTMKHS8jC4xVURNSFQ2/i+KKYd2TS7eEYOO9h2uioTtE+
wEPQ9UeKcpnarK/Z2qmtbsZ1St3sk3Or4g0Zxp57CJKqGo1PzKZEA3/gKGkSLS+/
aQz3SUQtn0mZQVMhlRdFoH4eL2KmQXMZ2Qmlrmp2zlTuZBvs6PHbRqUbDpffLyce
vwYalfed+hzxWnOmuviBZgdPasQr493C7qADom7GXflEJ9osUkUCYdhAanAzavtu
U5AI3Z2WA74QZK/eYgOj2KNw1mPw4A==
=fefc
-----END PGP SIGNATURE-----

--qlaeo4nwjhqykj3l--

