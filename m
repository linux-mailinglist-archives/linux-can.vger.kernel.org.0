Return-Path: <linux-can+bounces-1069-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0729494288C
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 10:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8528EB247CB
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 08:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1F8182C3;
	Wed, 31 Jul 2024 08:01:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B076D54757
	for <linux-can@vger.kernel.org>; Wed, 31 Jul 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412877; cv=none; b=j1VvagJlnl8f8iHMflptV/fztL08FrCu8Ty/7mBQK5vHMUOT7/cKNW69PjLo9tVU3Q9WWy2lLsGNNVCmBwEeh1krMg0Vun/LU4kXbZOwOii8PVhbYwLj0RbBhQ4M4VOfBFfy5pQwA7vZ4ZbiM6/h8JDQtJR4mDUc7CwkyaLYr+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412877; c=relaxed/simple;
	bh=8McQ3P/hPDG3tbZcqgiR+j7AJr1Ilf05vNWGKKldcec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLudvPeiTol5HZcb649sMuZ6uMNtRT0isN+yGYsmHhRQd1T0ynFNBoIyUWwmxpUIafgzQEXsOb/P2OaC5Ggo0cUtcxo0uinfWET+6evHImrOPZqK2/rktkBpgi/+rNc70ASb9MIARME/Fzbzw52onR4jWNE11F/sodRGWhWlE44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ4GN-0002X6-K8; Wed, 31 Jul 2024 10:00:47 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ4GK-003TS4-Eg; Wed, 31 Jul 2024 10:00:44 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E13C5312682;
	Wed, 31 Jul 2024 08:00:42 +0000 (UTC)
Date: Wed, 31 Jul 2024 10:00:41 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Simon Horman <horms@kernel.org>
Cc: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, David Jander <david.jander@protonic.nl>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next 19/21] can: rockchip_canfd: add hardware
 timestamping support
Message-ID: <20240731-powerful-scarlet-bullfrog-6ccccd-mkl@pengutronix.de>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
 <20240729-rockchip-canfd-v1-19-fa1250fd6be3@pengutronix.de>
 <20240730163014.GC1781874@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hzezjs5mnmqttyrf"
Content-Disposition: inline
In-Reply-To: <20240730163014.GC1781874@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--hzezjs5mnmqttyrf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30.07.2024 17:30:14, Simon Horman wrote:
> On Mon, Jul 29, 2024 at 03:05:50PM +0200, Marc Kleine-Budde wrote:
> > Add support for hardware based timestamping.
> >=20
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Hi Marc,
>=20
> This patch seems to break allmodconfig builds on (at least) x86_64
> when applied to net-next.
>=20
> In file included from drivers/net/can/rockchip/rockchip_canfd-ethtool.c:9:
> drivers/net/can/rockchip/rockchip_canfd.h:471:29: error: field 'cc' has i=
ncomplete type
>   471 |         struct cyclecounter cc;

The required header gets somehow pulled in on arm64, but it even fails
on arm. Fixed.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hzezjs5mnmqttyrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmap7yYACgkQKDiiPnot
vG+FmQf/Q1ZiJkvdFwG9Zqa/C/CevF13n/Nag0jZ1IZK9fOSblBoGBJhM7d2j/5z
b9hPW4o8YQqi6ydhCch4o50NfC+2wYDzWYyhhpZyUF23EwdhmYollJgCoSGzB+Tv
x2Hi1aOvTcL0doilpEI05XZNzCstptf8MwFVFtMgsyhsk4usgjCSEsdeipORGBu/
+vMvEUPuPD+psL3lP7JhMkXNLzKO2KzNyhhm/bGTSNxbEbNbwLyWJgZyHDy1QBng
MdfKtG0byZ6wAKgIPiQuUCIIyWCQU27uH1KclIa3NfOOHxtT49DxrkP/h840JkOW
/X6WtVYUQ0Gj0iYIg/XZA/PhHxN9Qw==
=EFuX
-----END PGP SIGNATURE-----

--hzezjs5mnmqttyrf--

