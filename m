Return-Path: <linux-can+bounces-266-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00D385301C
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 13:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A444B20F25
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 12:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE91C3A1CA;
	Tue, 13 Feb 2024 12:04:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D03A1B5
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825862; cv=none; b=X8s/xj/P199B02DvVNZG+yYed8D/a48KB1NciYHxEndyDVCg7nVOhbG5ExcbRoe5gir5kTu4mB3WErx9+ZeSQ97J9QiuU29/m14v2BlGm/S6j2H9Aw122Dlc50b9aZjrM4UdDIHP8CVox3uMfPYXnJLlWhdBvTlmCBjqGd4b6qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825862; c=relaxed/simple;
	bh=ZTLBNtBHSXgDnD/RltSsgibaukz383VqhSTCssQQrw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyirtW+TImAkUvnq8kPcccNM30okfQJHxBgnZHPoN1t58OBuy86tgtWg8aXEhRhEbeteChghkYQHC3pcFwBHa7zKGcPrq/OgRdQB5Rmlej9KIvu/+6O8ER2rqybZvthGb2m9scTq3TyJLNIVrRuECyJE2n/cVBU98zQpuSd7Ol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZrWN-0005Hw-0q; Tue, 13 Feb 2024 13:04:19 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZrWM-000TyA-HV; Tue, 13 Feb 2024 13:04:18 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 375C528D822;
	Tue, 13 Feb 2024 12:04:18 +0000 (UTC)
Date: Tue, 13 Feb 2024 13:04:17 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dave Taht <dave.taht@gmail.com>
Cc: linux-can@vger.kernel.org, msp@baylibre.com
Subject: Re: [PATCH net-next 17/23] can: m_can: Implement BQL
Message-ID: <20240213-uphill-cussed-820d691c7d95-mkl@pengutronix.de>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
 <20240213113437.1884372-18-mkl@pengutronix.de>
 <CAA93jw4awX=pjLVh4u3ERboZw+gG1aaAaEc2Q4ixa5fpS7UNxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lpdidm3jojz4quuu"
Content-Disposition: inline
In-Reply-To: <CAA93jw4awX=pjLVh4u3ERboZw+gG1aaAaEc2Q4ixa5fpS7UNxg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--lpdidm3jojz4quuu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.02.2024 06:45:04, Dave Taht wrote:
> while I am delighted to see this, what is the observed benefit?

Let's add Markus (the author of this patch) and the linux-can Mailing
list on Cc. I haven't implemented this feature, but Markus has.

IIRC BQL is mandatory for xmit_more(). And xmit_more() is used to batch
more then one transfer from the host to the CAN controller. This brings
a performance improvement on for tcan4x5x, which is connected via SPI.
And SPI is a quite slow bus with lots of overhead (at least on Linux).

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lpdidm3jojz4quuu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXLWr4ACgkQKDiiPnot
vG+vvwgAi6P9v0/XowkoC2G/PwqMTktiaJ6NLfVGjI29YXCQf0BCFt71ONJi1V6t
MDlv+dOxAWaxfyvkpcpgTBZhLv8j2gWGaZ1cztoMRwqb1CA93fAYFZmg2p7vLNeF
iWJSOFkgBGFzNBnx2GlZdBG+TiPwnN0Irj1sVZAzbg7Sf/hyiXNC1pBZswFN4TVP
N3LSWKrE0WhY8+tD9Qn0beIEE7RQyXkxuGQ24JVWgN6Q+axX+a48dJhBkEFuZZQS
Ob/R+ULnAUgIkAeyKtePZ9OfrKx1jNb4Yic5A5nx3x3iJVw0Bg2LKwaQmsx7e0qy
N255BvPD36ZwQoXZnaIXRKqJz9zw2w==
=SXDk
-----END PGP SIGNATURE-----

--lpdidm3jojz4quuu--

