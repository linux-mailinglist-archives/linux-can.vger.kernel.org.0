Return-Path: <linux-can+bounces-5879-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB45FCCBCCD
	for <lists+linux-can@lfdr.de>; Thu, 18 Dec 2025 13:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 288633028F4D
	for <lists+linux-can@lfdr.de>; Thu, 18 Dec 2025 12:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432BC2E0910;
	Thu, 18 Dec 2025 12:32:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C369D320A33
	for <linux-can@vger.kernel.org>; Thu, 18 Dec 2025 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766061144; cv=none; b=kUkAtKGKQB0ioB4mKXkHY1FalZ3pA+0arsb7518LMZc2p9+EJwZOcuTrvvT/x23q8fscSRnysFXcd9DNP2NOXMc/Bt6uCCR9ni4mbsLizPufghK7KupfVsYdRctA3U7EfStqN+yr66eHF3sulAMWBbzjrW7yGoGeyT/5+iWdB3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766061144; c=relaxed/simple;
	bh=QyVClMFPjwHKCx/v8AvfbaW/3QxKEVpfyPMMRrSg5mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpLy4atxQfvMPq9Y8bw1vamAPvW3H2yc1eqwFAjrzbBrrLnyzCQU4NK8wlAl19Mo7XtSuTYx/EGIxiIvAxJnENkhay26a6mXgGZ/jqZR9OlhR9rfgovpQ4QBYOAoNniyWQCO2VRrzkC7KNz8l3bh+P+9yi2k3UjQ81OJnz/DzTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vWDB1-0008G8-VV; Thu, 18 Dec 2025 13:32:15 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vWDB1-006HQl-12;
	Thu, 18 Dec 2025 13:32:15 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 160F94B8294;
	Thu, 18 Dec 2025 12:32:15 +0000 (UTC)
Date: Thu, 18 Dec 2025 13:32:14 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH can] can: fix build dependency
Message-ID: <20251218-giraffe-of-angelic-whirlwind-a6b6f5-mkl@pengutronix.de>
References: <20251217-can-fix-dependency-v1-1-fd2d4f2a2bf5@pengutronix.de>
 <f188b330-8bf5-4509-a2fc-712c20160167@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bnfjfek3kukwhyvt"
Content-Disposition: inline
In-Reply-To: <f188b330-8bf5-4509-a2fc-712c20160167@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--bnfjfek3kukwhyvt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can] can: fix build dependency
MIME-Version: 1.0

On 17.12.2025 23:24:05, Vincent Mailhol wrote:
> On 17/12/2025 at 10:45, Marc Kleine-Budde wrote:
> > Arnd Bergmann's patch [1] fixed the build dependency problem introduced=
 by
> > bugfix commit cb2dc6d2869a ("can: Kconfig: select CAN driver infrastruc=
ture
> > by default"). This ended up as commit 6abd4577bccc ("can: fix build
> > dependency"), but I broke Arnd's fix by removing a dependency that we
> > thought was superfluous.
>
> And my comment subverted you into doing so. I think half of the blame goe=
s to me
> here.

:)

> > [1] https://lore.kernel.org/all/20251204100015.1033688-1-arnd@kernel.or=
g/
> >
> > Meanwhile the problem was also found by intel's kernel test robot,
> > complaining about undefined symbols:
> >
> > | ERROR: modpost: "m_can_class_unregister" [drivers/net/can/m_can/m_can=
_platform.ko] undefined!
> > | ERROR: modpost: "m_can_class_free_dev" [drivers/net/can/m_can/m_can_p=
latform.ko] undefined!
> > | ERROR: modpost: "m_can_class_allocate_dev" [drivers/net/can/m_can/m_c=
an_platform.ko] undefined!
> > | ERROR: modpost: "m_can_class_get_clocks" [drivers/net/can/m_can/m_can=
_platform.ko] undefined!
> > | ERROR: modpost: "m_can_class_register" [drivers/net/can/m_can/m_can_p=
latform.ko] undefined!
> >
> > To fix this problem, add the missing dependency again.
> >
> > Cc: Vincent Mailhol <mailhol@kernel.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202512132253.vO9WFDJK-lkp=
@intel.com/
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Closes: https://lore.kernel.org/all/7427949a-ea7d-4854-9fe4-e01db7d878c=
7@app.fastmail.com/
> > Fixes: 6abd4577bccc ("can: fix build dependency")
> > Fixes: cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by=
 default")
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> Acked-by: Vincent Mailhol <mailhol@kernel.org>

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--bnfjfek3kukwhyvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlD9EsACgkQDHRl3/mQ
kZyclggAtBoBlC9Q76WRJYKbcpTgjivd4KLSmZiDftjOPz1hq4dCveSLvyibJ7o7
NM6Cc5anWHtzwWVMeXGD8Ex4fdscpyfIvbkOtAEimUX82Its4JnnL+XzDSviOaxz
GVEVpcG7HMNDKjhOuukj5e4FqX3xVoEoB9Xi7ux3QS9k6kQBneaZoikl0Gs2/NVu
gffI0e/eatyVBfUdd+rOokcfiNte3/DC6J21/IdTzeRyZ/4i+E64iypxOGGq+T1x
jx+aZAH6YRBZEVAkZNplu3bX2r4l89vXdm6oW0S0UW7E1OHRD2HOYSxMwp1lH1R3
EmhWOObvOpoiTZXqZ1/OXmrCw7U6Aw==
=RjWI
-----END PGP SIGNATURE-----

--bnfjfek3kukwhyvt--

