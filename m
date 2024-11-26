Return-Path: <linux-can+bounces-2228-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546519D9542
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 11:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA4F282089
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E22B1B4F0C;
	Tue, 26 Nov 2024 10:14:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4528C19066E
	for <linux-can@vger.kernel.org>; Tue, 26 Nov 2024 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616094; cv=none; b=KvlcMTb/bgpAemmbYBxaYCeDbuXMPXT5t1I/7oKKrp432eLQ+tt31RoEQBMWSZ0czhOiLS0hIv/HyUc8jaA3LCA+WBYbhwRondf1M4eDo3UfetuQgJfhqN2a7w4TPwVrTK4Eaoc3GeN9ncBj+SoWxRtwB4HNHsTLXLgLCnEwpvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616094; c=relaxed/simple;
	bh=Nno67BeYNovrN9wiEnxv2HcLJ/Vh7Odgeauech87qOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BphdhO05M6xwWMmK9rw2reEmCHJYXS5hTG70lGSLWDju8N6ES1pdI7MWaXhwaaotOdtrJO6vTzwBnHDxu1sjbUb/Alh04RA+es1Y+NwH7itrdCjnKh+zMQujhP9knAYLjTEJXMNTyLPB4cpQV3qteh3f0/xfv6Bsdae/jGC+Bkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFsaY-0002Se-Eo; Tue, 26 Nov 2024 11:14:34 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFsaU-000EQd-2H;
	Tue, 26 Nov 2024 11:14:31 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F373837D89F;
	Tue, 26 Nov 2024 10:14:30 +0000 (UTC)
Date: Tue, 26 Nov 2024 11:14:30 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Akshay Bhat <akshay.bhat@timesys.com>, Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Chen-Yu Tsai <wens@csie.org>, "David S. Miller" <davem@davemloft.net>, 
	Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
	Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Marek Vasut <marex@denx.de>, Maxime Ripard <mripard@kernel.org>, 
	Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, Samuel Holland <samuel@sholland.org>, 
	Sebastian Haas <haas@ems-wuensche.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Varka Bhadram <varkabhadram@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfgang Grandegger <wg@grandegger.com>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 00/12] Fix {rx,tx}_errors CAN statistics
Message-ID: <20241126-smooth-convivial-elephant-afdf93-mkl@pengutronix.de>
References: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="da6pwqywlractjoy"
Content-Disposition: inline
In-Reply-To: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--da6pwqywlractjoy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 00/12] Fix {rx,tx}_errors CAN statistics
MIME-Version: 1.0

On 22.11.2024 23:15:41, Dario Binacchi wrote:
> This series extends the patch 4d6d26537940 ("can: c_can: fix {rx,tx}_erro=
rs statistics"),
> already merged into the mainline, to other CAN devices that similarly do
> not correctly increment the error counters for reception/transmission.
>=20
> Changes in v2:
> - Fix patches 7 through 12 to ensure that statistics are updated even
>   if the allocation of skb fails.
> - Add five new patches (i. e. 1-5), created during the further analysis
>   of the code while correcting patches from the v1 series (i. e. 7-12).

Applied with some changes to linux-can, omitted patch 3, it will to into
linux-can-next.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--da6pwqywlractjoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdFn30ACgkQKDiiPnot
vG8pLQf/UFjvNxQqVJYbsWq3rJ4rmpk7ymlvoleDl/fOsThzD0wAe+OmS+jhUXp6
TKnIgvkkOGjanvES0XAZ9fzT2Tq9ZHhoqgkQ6hpEO1ucHNIYmmHoxzn28uwMwIC1
J2+mv+RpeuHmdxm6AHSpMuealRAJwvACkVt6T0NSo2Y+4IRr+Q4bstz9apTveLmQ
0qo84F9Jx9FOHx+cIMFo5HapZunJ0+5XNB2aE8hBI9/fzVLmaUi2jEgnFzntm4w0
LsSoBk29gCF91y92aN7yKxusYMsj1Yk6sfm/eo9Gedj2XyKBRmDbeVId9QKJl/T/
iF9zp/mPHcphVj5Hd2THnX97ukngPQ==
=U/LH
-----END PGP SIGNATURE-----

--da6pwqywlractjoy--

