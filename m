Return-Path: <linux-can+bounces-3661-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC70BAC080E
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 11:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436AC4A12D9
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 09:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135B8262FEA;
	Thu, 22 May 2025 08:59:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7203B1F17F7
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904387; cv=none; b=F2iwh9mHhx+ZCYdIypV+T9AmdMvUX+NcjmKJA0HN50ZK8VzLNuCwUUzrNtnlGGULuPNKkvP5bRCXCeZ/OyytBaT4JvPILsOG0AkpOQKa1sU0TPfiQhTYRHwrbLgyxDWzKSRSD8S/FqO53rXDC7Lq2Dfxhilwe8FWOkAQq3QjTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904387; c=relaxed/simple;
	bh=vKURFuIpdq/K/4MGm+TN1457AIiKfPHKolVqXUq2u90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eac04U+8N3KcropJ9EcKi/5VqHhY0HgEiMYB3rKjX17tfHbwbmyS39XjL6JtcfSnFXMXTTqUOoBVE80xP+mmys+WRGOeHq7KsKkcQE9i3zdbsJgasvbYYg+cK5+rHhan7Vd0gzxbifiU5pVAmnbAZ3kqCoAmDcK6HjzAlxXvlYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1lv-0002vJ-Hh; Thu, 22 May 2025 10:59:27 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1lu-000huF-01;
	Thu, 22 May 2025 10:59:26 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009:2000::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1844F4175DB;
	Thu, 22 May 2025 08:59:25 +0000 (UTC)
Date: Thu, 22 May 2025 10:59:22 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com, 
	kever.yang@rock-chips.com, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/3] rockchip: add can for RK3576 Soc
Message-ID: <20250522-idealistic-khaki-tuna-91290d-mkl@pengutronix.de>
References: <20250522074616.3115348-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sa6ejazolcmnr6ge"
Content-Disposition: inline
In-Reply-To: <20250522074616.3115348-1-zhangqing@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--sa6ejazolcmnr6ge
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/3] rockchip: add can for RK3576 Soc
MIME-Version: 1.0

On 22.05.2025 15:46:13, Elaine Zhang wrote:
> rk3576 can is a new controller:
> Support CAN and CANFD protocol.
> Support Dma.
>=20
> There are major differences from the previous rk3568. All errata on the
> rk3568 have been fixed and redesigned.

Which tree does this series apply to? Please rebase to
linux-can-next-for-6.16-20250522

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--sa6ejazolcmnr6ge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgu52cACgkQDHRl3/mQ
kZwdfgf/d8vv4Y+eCOIDpy04JenmxN8n8PZDriO0bTQAcrysrzSwWUfkouJA9sI5
avJL3hLCOVrSRzmvh/lkkW4voCfIfki7FI/STC/LeEpri85JOxOQfYLw1FgZ1Oeu
/b70nkM8d5A06HIVBB6WpUuj9B3B06p58KMlvSySaiK1EtfyIzZZ5O8LPmvzGLBZ
Nn9dbaH7KmSHboVpsx21zOyAIu1yAeu1Shl62nWBuFCBT1RYIpOWAKUX7cLpH4Dd
WTzeBnQxhzNKvLV91+pM/W0t89/tH5L7UfyhOHH3F1y4owdA2InWkOkYj22yTFiL
rNz898AB9XRisrl8I6jjG3Xp/yVvMA==
=7M2p
-----END PGP SIGNATURE-----

--sa6ejazolcmnr6ge--

