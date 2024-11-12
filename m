Return-Path: <linux-can+bounces-1977-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E43019C5005
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 08:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765C1289E75
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 07:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAB720ADE0;
	Tue, 12 Nov 2024 07:55:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E951990AF
	for <linux-can@vger.kernel.org>; Tue, 12 Nov 2024 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398137; cv=none; b=CQ9j1lVIGfBC0ncEFpKsWy/omlj3jfbk5jpBiLPs5tndV7x9YCaB3GLL5SnbJcgL8v4301KDf/0je7T8m1AGRSmWD0RT6hDzw8BVN9ymjOXLCVBUWa/kOaX2Sv4c8eI7wNgxwnFPSkqiQ/Kx9yRyicB9hQXH5iMBMLzluouEzhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398137; c=relaxed/simple;
	bh=jqfH88goHxUWmGs0ZtcBrBheyTBZFV5qaRxeqIF0nDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFOR4kHJ1UqJby84POpMx6mN3FFaAL1jf7udBh+A09LhFeq8fqJzMv6cwyBpyNTvLb0N3ZrPEBgVx18mF1O/qzx58vfTcZm/m7EugbuP9RZCdgXowYQks2EXX+7NARYffpVFWtP0L1WnmGnNoacWtAbVs2Eg8CRLUAD86KjKzQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tAljt-000840-0J; Tue, 12 Nov 2024 08:55:05 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tAljp-000NFm-0Y;
	Tue, 12 Nov 2024 08:55:01 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A90A23712AA;
	Tue, 12 Nov 2024 07:55:00 +0000 (UTC)
Date: Tue, 12 Nov 2024 08:55:00 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Pantelis Antoniou <pantelis.antoniou@gmail.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
	Byungho An <bh74.an@samsung.com>, Kevin Brace <kevinbrace@bracecomputerlab.com>, 
	Francois Romieu <romieu@fr.zoreil.com>, Michal Simek <michal.simek@amd.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Zhao Qiang <qiang.zhao@nxp.com>, "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, 
	"open list:FREESCALE SOC FS_ENET DRIVER" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCHv2 net-next] net: use pdev instead of OF funcs
Message-ID: <20241112-lush-beneficial-chicken-9a31f5-mkl@pengutronix.de>
References: <20241111210316.15357-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wiafd67i2wzywtxu"
Content-Disposition: inline
In-Reply-To: <20241111210316.15357-1-rosenp@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--wiafd67i2wzywtxu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCHv2 net-next] net: use pdev instead of OF funcs
MIME-Version: 1.0

On 11.11.2024 13:03:16, Rosen Penev wrote:
> np here is the node coming from platform_device. No children are used.
>=20
> I changed irq_of_parse_and_map to platform_get_irq to pass it directly.
>=20
> I changed of_address_to_resource to platform_get_resource for the same
> reason.
>=20
> It ends up being the same.

You should describe in an imperative way your changes. Something like:

Modernize IRQ resource acquisition.

Replace irq_of_parse_and_map() by platform_get_irq()

=2E..and list the other changes, too.

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: fixed compilation errors. Also removed non devm transformations.
>  Those will be handled separately. Also reworded description.
>  drivers/net/can/grcan.c                          |  2 +-
>  drivers/net/can/mscan/mpc5xxx_can.c              |  2 +-

Reviewed by: Marc Kleine-Budde <mkl@pengutronix.de> # for CAN

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wiafd67i2wzywtxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmczCdEACgkQKDiiPnot
vG9P5Qf9GHBDogv141w23Ql4QYhPyQNOFBbAjfAmSaXZJQjwjI2/PT9uMOtwx1N3
xkyyFSufM0a+sr9Mn7vC+liJrlzO9Xmqq+53eTAvq2e2RPKAdVT/aPa21s05sWUI
u1r/6bgaTgg9stZMDtivo6HAYr69FexPGYKdk9bAcm4gANpW/Ih+NpLB4IwzqKv6
EHXEtt4AfiBCLNkq4BUwBO4D1CHsDbICmSZbC2RRZ5Jc85R9u+YYqwj7RN3EbDfL
fWarhFuRuoGubmHPg8gaauKa5/Cxjo9fsjn93QTzRbgEgLJEsii3Y85oI0LaN0U8
e9/zBSWu8p/gXjqOGAwOOYQ1WVxswA==
=3yO+
-----END PGP SIGNATURE-----

--wiafd67i2wzywtxu--

