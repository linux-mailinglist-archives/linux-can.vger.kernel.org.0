Return-Path: <linux-can+bounces-1301-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CD6968902
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2024 15:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99831F23777
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2024 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1A8205E32;
	Mon,  2 Sep 2024 13:36:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E333020012E
	for <linux-can@vger.kernel.org>; Mon,  2 Sep 2024 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284190; cv=none; b=U5AO9GVA49FhdiH+MMUdCl3dwUHNgQGrueQpnNVBHr23BRPeAWWAnvyIzH7CPRU8eEYMy+9sLxPAoqj4dbeJ75YPuz6BN06xfwt23kPAmFx4U2yoK3rk4RTNoznUVQO4VjZyksycwB8hZRZtYlrUU9PBsVPIelyZwiMAP0dcVjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284190; c=relaxed/simple;
	bh=yhrNCjLBpluETSmKVqeOqruKcLZbweFdeVllkIZ8Un4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ttqdaf1x7Ivho2cOyizphlR4BapGu5M8wOMmb69wUHuiERCNAfo2y+jxyYRZ/uD6i2RR6aeyFOxpsAJUZncWaknCrIwhj7pZrOApgo6uRAgChMiCm3P7lRuHeosWLkUut8Y/FHEH3RNqZcuXXiMpjoeVVJEw1s8NzBWS6sf6bAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sl7EH-0006lH-8Z; Mon, 02 Sep 2024 15:36:25 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sl7EG-004vI9-KL; Mon, 02 Sep 2024 15:36:24 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5382B330749;
	Mon, 02 Sep 2024 13:36:24 +0000 (UTC)
Date: Mon, 2 Sep 2024 15:36:24 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: rednaxelA xelA <ak.alexander.kozhinov@gmail.com>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH] can: gs_usb.c: add usb endpoint address detection at
 driver probe step
Message-ID: <20240902-sensible-wonderful-basilisk-6ac875-mkl@pengutronix.de>
References: <mkl@pengutronix.de>
 <mailhol.vincent@wanadoo.fr>
 <davem@davemloft.net>
 <edumazet@google.com>
 <kuba@kernel.org>
 <pabeni@redhat.com>
 <20240831201643.331810-1-ak.alexander.kozhinov@gmail.com>
 <20240902-fanatic-perky-ara-3c083c-mkl@pengutronix.de>
 <CAK0My692XCCJRPGWuciwdOE0-MUQWuQK0Yom5_XTRp-anFnDDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jrf7gdlx5hjcemwq"
Content-Disposition: inline
In-Reply-To: <CAK0My692XCCJRPGWuciwdOE0-MUQWuQK0Yom5_XTRp-anFnDDA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--jrf7gdlx5hjcemwq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.09.2024 15:03:49, rednaxelA xelA wrote:
> Hello Marc,
>=20
> Thank you for your reply. The description for necessarily of this change
> can be seen below:
>=20
>=20
> There is an approach made to implement gs_usb firmware/driver based on
> Zephyr RTOS. It was found that USB stack of Zephyr RTOS overwrites USB EP
> addresses, if they have different last 4 bytes in absence of other
> endpoints.
> For example in case of gs_usb candlelight firmware EP-IN is 0x81 and EP-O=
UT
> 0x02. If there are no additional USB endpoints, Zephyr RTOS will overwrite
> EP-OUT to 0x01. More information can be found in the discussion with Zeph=
yr
> RTOS USB stack maintainer here:
> https://github.com/zephyrproject-rtos/zephyr/issues/67812
> In the end USB stack maintainer refuses to change this behavior and points
> out on wrong driver implementation made by linux. Thus I have only this
> last option to provide gs_usb driver linux kernel patch.
> Additionally there are already two different gs_usb FW driver
> implementations based on Zephyr RTOS.
> 1. The first one implementation is done by Henrik and can be found here:
> https://github.com/CANnectivity/cannectivity
> 2. The second one implementation is done by me and can be found here:
> https://github.com/zephyrproject-rtos/zephyr/compare/main...KozhinovAlexa=
nder:zephyr:gs_usb
>=20
> At the moment both Zephyr RTOS implementations use dummy USB endpoint, to
> overcome described USB stack behavior from Zephyr itself. Since Zephyr RT=
OS
> is intended to be used on microcontrollers with very constrained amount of
> resources (ROM, RAM) and additional endpoint requires memory, it is more
> convenient to add a patch to linux kernel's gs_usb driver.
>=20
> Please do not hesitate to ask me more questions and/or point out, what I
> can do better. This is my first publicly available patch for linux kernel=
 :)

Thanks for the excellent description of the problem. Now let's transform
this into a commit message that follow the Linux process:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#desc=
ribe-your-changes

-------->8-------->8-------->8-------->8-------->8-------->8-------->8-----=
---
There is an approach made to implement gs_usb firmware/driver based on
Zephyr RTOS. It was found that USB stack of Zephyr RTOS overwrites USB
EP addresses, if they have different last 4 bytes in absence of other
endpoints.

For example in case of gs_usb candlelight firmware EP-IN is 0x81 and
EP-OUT 0x02. If there are no additional USB endpoints, Zephyr RTOS will
overwrite EP-OUT to 0x01. More information can be found in the
discussion with Zephyr RTOS USB stack maintainer here:

https://github.com/zephyrproject-rtos/zephyr/issues/67812

There are already two different gs_usb FW driver implementations based
on Zephyr RTOS:

1. https://github.com/CANnectivity/cannectivity
   (by: https://github.com/henrikbrixandersen)
2. https://github.com/zephyrproject-rtos/zephyr/compare/main...KozhinovAlex=
ander:zephyr:gs_usb
   (by: https://github.com/KozhinovAlexander)

At the moment both Zephyr RTOS implementations use dummy USB endpoint,
to overcome described USB stack behavior from Zephyr itself. Since
Zephyr RTOS is intended to be used on microcontrollers with very
constrained amount of resources (ROM, RAM) and additional endpoint
requires memory, it is more convenient to update the gs_usb driver in
the Linux kernel.

To fix this problem, update the gs_usb driver from using hard coded
endpoint numbers to evaluate the endpoint descriptors and use the
endpoints provided there.
-------->8-------->8-------->8-------->8-------->8-------->8-------->8-----=
---

What do you think?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jrf7gdlx5hjcemwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbVv1UACgkQKDiiPnot
vG8QrAf/VtYSG4na69JGdwsbkC3gwCKWVnaOQSTJtpI/MTPjM5iQlThHdOOYrs3l
FUSh5YvNHdJmR29hdOExoQ/eI/Ny0hPaw34bBrv69guOYFNjSONLry9BaoPmQZcY
AXvHL0T56Dj5xXx7VsrDZ2exKwR5pozXEdmzB0t9SxvfWO5lok1thgtpUvle1nUY
gF/B1ppIyXKow3yh9T/rpWHk7cnjeQW2cVn4BRG+JrEj0C6j0fggTOl5Dgt8/RsI
Uuo2SUvX+0DMn5MnTMSMWIHhjxvYgPJZRnJgeJVpkgm/ExYDV/R9blPjn7sTgd2S
vEpLTZT0nNfbLT6dsOe+YGwXHlLBGg==
=bPlh
-----END PGP SIGNATURE-----

--jrf7gdlx5hjcemwq--

