Return-Path: <linux-can+bounces-1423-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FE796DA3C
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 15:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D17282B42
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 13:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557B819D08A;
	Thu,  5 Sep 2024 13:25:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BA719D077
	for <linux-can@vger.kernel.org>; Thu,  5 Sep 2024 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542722; cv=none; b=srgCytOXJQk0Hahxh6h/jWJChWFGZG0wvpnPM/BamnftHzc7Cgb+ldgryYvNR7UGNkPNbIrXDPghLDAK3Q5bXhJiRH4Xe5TJar5xYaGpTCgA5t/tBZB10XSZJeq8Voh6uVGfypxSlwD5xAryILEgZ739Cn03zonbmFmK28bymck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542722; c=relaxed/simple;
	bh=7jZHLN6x7TS1NEyREZ70lKrrl7an8E99MUq7DicLtJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daVhvz7RivlYt9wcWjS3Hjy0Q1Vp9eDDCXj9WtLGH6V69lqobUCQnBnmClOvvu6lK/iozrvpK8B5dJgOa2/VHyWK4MZLYwrIfzbJ5H2syRa2xX110sl0ToL1Nw+NHLfgrIkYXt0uEP+CIASBAOnKm1z8XNYSui7IEmZditVtgC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1smCTY-0003eO-E5; Thu, 05 Sep 2024 15:24:40 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1smCTV-005iOY-Fj; Thu, 05 Sep 2024 15:24:37 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 031D4333683;
	Thu, 05 Sep 2024 13:24:37 +0000 (UTC)
Date: Thu, 5 Sep 2024 15:24:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Elaine Zhang <zhangqing@rock-chips.com>, 
	David Jander <david.jander@protonic.nl>, Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, David Jander <david@protonic.nl>
Subject: Re: [PATCH can-next v5 00/20] can: rockchip_canfd: add support for
 CAN-FD IP core found on Rockchip RK3568
Message-ID: <20240905-thoughtful-gerbil-of-growth-28f014-mkl@pengutronix.de>
References: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
 <86274585.BzKH3j3Lxt@diego>
 <20240904-imposing-determined-mayfly-ba6402-mkl@pengutronix.de>
 <4091366.iTQEcLzFEP@diego>
 <20240905-galago-of-unmatched-development-cc97ac-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z26o4qqv53ya5nl6"
Content-Disposition: inline
In-Reply-To: <20240905-galago-of-unmatched-development-cc97ac-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--z26o4qqv53ya5nl6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.09.2024 08:19:10, Marc Kleine-Budde wrote:
> On 04.09.2024 18:43:52, Heiko St=C3=BCbner wrote:
> > Am Mittwoch, 4. September 2024, 17:10:08 CEST schrieb Marc Kleine-Budde:
> > > On 04.09.2024 10:55:21, Heiko St=C3=BCbner wrote:
> > > [...]
> > > > How/when are you planning on applying stuff?
> > > >=20
> > > > I.e. if you're going to apply things still for 6.12, you could simp=
ly take
> > > > the whole series if the dts patches still apply to your tree ;-)
> > >=20
> > > The DTS changes should not go via any driver subsystem upstream, so
> > > here's a dedicated PR:
> > >=20
> > > https://patch.msgid.link/20240904-rk3568-canfd-v1-0-73bda5fb4e03@peng=
utronix.de
> >=20
> > I wasn't on Cc for the pull-request so I'll probably not get a notifica=
tion
> > when it gets merged?
> >=20
> > So if you see your PR with the binding and driver getting merged to
> > next-next, can you provide a ping please?
>   ^^^^^^^^^
>   net-next?
>=20
> Will do.

The driver reached net-next/main:

https://lore.kernel.org/all/172554243626.1687913.5623663966016175191.git-pa=
tchwork-notify@kernel.org/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--z26o4qqv53ya5nl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbZsREACgkQKDiiPnot
vG/JvAf/XoO+j2bRaV/OIKVKmVBLZH5kRJnidPSorqD9aB1pbIDk0+hNkyuHTghI
sZIvHzuNJYf+y93aEiK2M3k8++YM0bEMLbkVOOJEK/CaMHCf1jIyFgOATkffElPC
yOjaUlOuwyJwZt2idPGQIRqdoCO1PtkPTs6mki1ZY3y8pO7y1HXsoGJy4sKLnXxp
BTZpdvAUZmdGeLEUefKaxiRH1NHMjh3jAb1TEst2IWdB/13IjNTw3jeALqer28nq
1eJflTIXAs24J4CxUruHRl1YttaaTgyets+Qu0jTZnBZSnzlbm7qh+t8qrAoPyQx
+2os847WP91NL5CRSbE0eMGZBR8A+w==
=DLSm
-----END PGP SIGNATURE-----

--z26o4qqv53ya5nl6--

