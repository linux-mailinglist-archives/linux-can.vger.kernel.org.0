Return-Path: <linux-can+bounces-352-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC8486FB14
	for <lists+linux-can@lfdr.de>; Mon,  4 Mar 2024 08:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9673728170B
	for <lists+linux-can@lfdr.de>; Mon,  4 Mar 2024 07:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0C914A93;
	Mon,  4 Mar 2024 07:47:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351753A6
	for <linux-can@vger.kernel.org>; Mon,  4 Mar 2024 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538470; cv=none; b=idK9L7yLMIXxEqM5QdV5VOXQUl/9G7R8D8hyZP9Ol9KJQXqlQjx0E6qrL+6VEWq/AHqM5K4AOkDACzyKHUWK8dDTj56I7pBJc1UyPSud/p6dSqpDEPBBZJhPp6DMkKMNh0UoH8Zvz4x4czKk3wdvLSo8Frm5ernsF1obP/5oHPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538470; c=relaxed/simple;
	bh=nQ4ljnY13K45KewOWiB2DdI2KYPZESa3KSYcpRtLEqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYv4SN9s0ge4Sv9Bl0cjcMBgXi+kHqBzj8toTYY9lkNST1ae9fgCBAPlEARg8lwzDHYNmk1lIjc2KGjUVgkozvdKpJ6fnzJIsoz6ZH+NI098u3g4RtRUsPCZpbsHvtA0wmqMx9kjAT93XQMB1XP8VwiAubg0lpn1dlG2jvFN87I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rh334-0002jB-Cp; Mon, 04 Mar 2024 08:47:46 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rh333-004J5J-Qi; Mon, 04 Mar 2024 08:47:45 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7E8E429C9C0;
	Mon,  4 Mar 2024 07:47:45 +0000 (UTC)
Date: Mon, 4 Mar 2024 08:47:44 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin =?utf-8?B?Sm9jacSH?= <martin.jocic@kvaser.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>, Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH] can: kvaser_pciefd: Add support for Kvaser PCIe 8xCAN
Message-ID: <20240304-carve-revivable-87758637f715-mkl@pengutronix.de>
References: <2b2c720a788e1904283e354abb320adb5b631d26.camel@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s6qwvhvcz4o7kc7z"
Content-Disposition: inline
In-Reply-To: <2b2c720a788e1904283e354abb320adb5b631d26.camel@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--s6qwvhvcz4o7kc7z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.03.2024 12:37:08, Martin Joci=C4=87 wrote:
> Add support for new Kvaser pciefd device, PCIe 8xCAN, based on Xilinx FPG=
A.

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--s6qwvhvcz4o7kc7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXlfJ0ACgkQKDiiPnot
vG+96wf/da1Umb34wKCfpx0FEZeMhf3GQvJBo/3u9Q1+L/oNGm/aTWiKR2KJl7Ky
MKw4/29/OBT19iRInsEDjrRr2ZMEsxTf9vnvK0TWZpecfKISf6Gjxxz2DVdEM8/A
DZ/bsqmeE1MWLqoFceReP/toxArw+OxCweXY43TWtylwbEIF7MOQwYVBZHdVBXGE
NYthEgSAWqrRsv2NvhhQvlnvSOXhh4Gk2z0m3hSDHjzt9K/lBP3DGte0zMpTLuOn
hxJASENmR8Mx8JixgkMtKQxCJm+zIvSyzvDmTtzxW1ztxbeK65OvDxfeZhCCTZCp
zZsv7xw3vP1i43tMJRPC0VJRp6cZvw==
=FOzg
-----END PGP SIGNATURE-----

--s6qwvhvcz4o7kc7z--

