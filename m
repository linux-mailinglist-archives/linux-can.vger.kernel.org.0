Return-Path: <linux-can+bounces-1419-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C48696CF5E
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 08:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F6F1F21926
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 06:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA33E188582;
	Thu,  5 Sep 2024 06:35:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E84C3612D
	for <linux-can@vger.kernel.org>; Thu,  5 Sep 2024 06:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518153; cv=none; b=VTPLsWKeWxFC8vGMLIWllf4DYEFoXr+Po/ZV6caQgVShYLgFCbel42PccEd3uoiiq/7DyEizLKf1Gn/pltNktT5O33t4w+OZKH428f0aCBtzNZafvJxIP5LMfXjmIy5t/6/xsXe5x1JJDy8izSvegNX8akBhBOtSwBcImQ3xFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518153; c=relaxed/simple;
	bh=fxbe3eBK8bMpz4tzZDuiCT7sEGJo5RoRZf3rP9xvuSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kvs3n6/JZyr1eoO3rSG3APL6ycBSIdJ8xdH6dmz3GlzRqYCPpXPoS+89mpZku0w+LjSZJ8hc+OWn6WlDSu7B2CG8tXvEnpgpu+iR1nq05suh1pw+Zj7ReEjB5v9iPTUU4wlnIQzFSkiJMJkVftuF2wfjFO4/ITyx21z1o5idJ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sm65s-0002jQ-IT; Thu, 05 Sep 2024 08:35:48 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sm65r-005dhu-Md; Thu, 05 Sep 2024 08:35:47 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 666ED3330CB;
	Thu, 05 Sep 2024 06:35:47 +0000 (UTC)
Date: Thu, 5 Sep 2024 08:35:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>, 
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH net-next 16/20] can: rockchip_canfd: prepare to use full
 TX-FIFO depth
Message-ID: <20240905-funky-unbiased-oxpecker-eae021-mkl@pengutronix.de>
References: <20240904094218.1925386-1-mkl@pengutronix.de>
 <20240904094218.1925386-17-mkl@pengutronix.de>
 <28a20a6697dbe610bd13829baa9d188ef22a1742.camel@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gkgxphd6b7mz6kwr"
Content-Disposition: inline
In-Reply-To: <28a20a6697dbe610bd13829baa9d188ef22a1742.camel@googlemail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--gkgxphd6b7mz6kwr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.09.2024 18:13:21, Christoph Fritz wrote:
> > The workaround for the chips that are affected by erratum 6, i.e. EFF
> > frames may be send as standard frames, is to re-send the EFF frame.
> > This means the driver cannot queue the next frame for sending, as long
> > ad the EFF frame has not been successfully send out.
>=20
> just a nitpick, shouldn't it be "as" instead of "ad" ?

Fixed. But I will not send another PR unless there is another problem :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gkgxphd6b7mz6kwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbZUT8ACgkQKDiiPnot
vG8tbQf+JsOgAT6CJQ5FllwDvyYx7ySV0b7laQxLXdqqbYhVAgl4f5Kfmg5mWNQg
Wa8d7qWOA/dOZpdLhQ0WwT94DKMtQSvSquIL+F6ZTyXSAuXl8JmaT3bZ9wfoGyWX
Ce7pSZDvXbi4bva/jL+lEShm/73wNEcKdy3mK0/LWirDWci+dSktUH0G8DHYhptw
e2aNECn91OpniNzIEn5ogB1eN3ckF2xgNYNRyZ9HTrcnsqMY5KR6kdzcnvezH3Ct
yfI9OQHYtarCG6exyOLircD9Kyktz+l8s2gj8BCyAHLKZdQu9Be/jmxk4HKopf3K
5JxahEbcrkorxV3sYj3imArGsORHRw==
=kPKf
-----END PGP SIGNATURE-----

--gkgxphd6b7mz6kwr--

