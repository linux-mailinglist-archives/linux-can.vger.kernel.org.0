Return-Path: <linux-can+bounces-832-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A49911EF5
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F363EB20CE9
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA5216C876;
	Fri, 21 Jun 2024 08:39:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94033134A5
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959196; cv=none; b=OBGMLUlSrsYC+vdm3yx36ub8ND1A+plDeAcLMtPuIS03dPFtiycaw7Fd6W1fvHMhx7SJd9Dl3gNG8L7veOw0Gd6Vg6rVWivdmNHblAUlPcVipsPF+MeuHmxHPkPos7SA7FNgQdSNtDrItT4xiJxgl8WaKe7a+J3arLgFjccfJGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959196; c=relaxed/simple;
	bh=uXBgHevjrFEApEJTDKrrkPPnFg9epgsgwPy9K/sEoms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j47LYXAAHcODaXU31AMgsMEIB2mix32o6F2BE1elR6vOW9ncJbbNwfQ0lr4mWzs8FRzFSdkO7Ika52hnHhpKiwIMUR5ceLVqCsXJCufyt+cQdb/x17M1de/B+RG9Zsms9JeAhU4LT4X0km4peypoFjtRZuxRCD0fGXGF2m0aTgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZo7-0000u2-11; Fri, 21 Jun 2024 10:39:43 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZo6-003tw7-61; Fri, 21 Jun 2024 10:39:42 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E08012EE59B;
	Fri, 21 Jun 2024 08:39:41 +0000 (UTC)
Date: Fri, 21 Jun 2024 10:39:41 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: mailhol.vincent@wanadoo.fr, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, extja@kvaser.com, 
	carsten.schmidt-achim@t-online.de, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: kvaser_usb: fix return value for hif_usb_send_regout
Message-ID: <20240621-cyan-cuttlefish-from-eldorado-11bff2-mkl@pengutronix.de>
References: <20240521041020.1519416-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jiubb3efwkr2svb2"
Content-Disposition: inline
In-Reply-To: <20240521041020.1519416-1-nichen@iscas.ac.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--jiubb3efwkr2svb2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.05.2024 12:10:20, Chen Ni wrote:
> As the potential failure of usb_submit_urb(), it should be better to
> return the err variable to catch the error.
>=20
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jiubb3efwkr2svb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ1PEsACgkQKDiiPnot
vG+cBgf/aA6QRdkplMyfag2SBpDs/bGj74Watxxyx0RceqY4NU/bIWwq9GhCNXBV
UAGOhx4IdEeWYn7UbDf+/bV0JK1GI/8CWFoqzBvCBdh4sgejtYz91CC+jHw/XItk
GsX/Lvmlpxz6xUmdlcLpsH6f3684Pazqc25jCOpWRvtasG2NR+YVBiNntFIZGO88
jrTs8qeng2cWPFC8ZceHHk6+RX6PKW0hs8KTNYrDhkt7x3yOm3Fs4MoEWXw8im6W
aWASIXMOQnhiOsZYcTIS9dPtgsnMz6U0Sm6WqUujaI6geWN53VIMvXXa6dIao8nB
v8CRbwj4JVRIv6h2rvuVQRWwnLXZdA==
=PAuB
-----END PGP SIGNATURE-----

--jiubb3efwkr2svb2--

