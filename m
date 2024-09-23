Return-Path: <linux-can+bounces-1544-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C25E097ED3C
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 16:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782561F220A9
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 14:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E52A198E81;
	Mon, 23 Sep 2024 14:36:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012C7433D6
	for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727102187; cv=none; b=g08PsM3VvrM9apn3BbaaUh2aiGmyC/EVasEcsxmIQszjL02wC7KmnTdOp6uhS1d3T7clawo90SousKtMeYRKSIOCLd5wWHW4cX3olakVaeLDy5RhEx6eFdf3zFcuE4dpR91pPJp/j46m3lL38uRJKcCderZwQul0fiic+vp+e4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727102187; c=relaxed/simple;
	bh=yHejjhUlsxEZUCVEVnzYBT3QyPVntJoEmyU6mZuBsHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVbYImOSJw/7Vdy05EnB5oDdPVaTxkiOXOZMpep3AfwyD9GdQ2YcqDkQxtG5TBuF9iAGURE/O8zzIvQOa5Uz9XMmcKqi3+2hSartgtirkJqq4dN3rOSb/nW9smvhuDamHk/W3tmMwpdfK54guGMeV4ZD4syi319CUREara1k75I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sskAl-0003VD-5U; Mon, 23 Sep 2024 16:36:19 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sskAk-000ynv-Ck; Mon, 23 Sep 2024 16:36:18 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 83FD83413F9;
	Mon, 23 Sep 2024 14:36:17 +0000 (UTC)
Date: Mon, 23 Sep 2024 16:36:16 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: Oops on mcp251xfd open on 6.6.52
Message-ID: <20240923-quixotic-okapi-of-rain-99ae09-mkl@pengutronix.de>
References: <20240923115310.GA138774@francesco-nb>
 <20240923-spry-badger-of-perception-303c63-mkl@pengutronix.de>
 <20240923120027.GB138774@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tymcpkc7z7lju776"
Content-Disposition: inline
In-Reply-To: <20240923120027.GB138774@francesco-nb>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--tymcpkc7z7lju776
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.09.2024 14:00:27, Francesco Dolcini wrote:
> Hello Marc,
>=20
> On Mon, Sep 23, 2024 at 01:57:07PM +0200, Marc Kleine-Budde wrote:
> > On 23.09.2024 13:53:10, Francesco Dolcini wrote:
> > > I got the following Oops on doing a simple ip link set canX up, runni=
ng
> > > on an i.MX8MM SoC.
> > >=20
> > > This was reproduced with some automated testing, I have not tried to
> > > reproduce it so far. Any idea or hint? It seems systematic, introduced
> > > around 12th september on the v6.6.y branch.
> >=20
> > Which Kernel version are you using?
>=20
> v6.6.52 is reproducing the issue, I guess it started on some previous
> v6.6.x kernel (with x < 52), but I was not able to dig out the logs
> running on older kernel from our automated testing (yet).
>=20
> I was not able to test mainline (yet).

Can you cherry-pick these and see if it fixes your problem?

51b2a7216122 ("can: mcp251xfd: properly indent labels")
a7801540f325 ("can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into=
 mcp251xfd_chip_start/stop()")

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tymcpkc7z7lju776
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbxfN0ACgkQKDiiPnot
vG88zggAgWasRKSxW1wyTYCu5QfKLILu0Vu95E63tTtFxXoO2DSnUV/laeLFeI4h
TlI3BOtkkPas2Ad4vCb3civaBfiEu+b+1TB5tyEDczCGKUejBY/MyFkf/Wlao8wo
7OMw8T1Sa6QoY5EQxKjdl/t8pZyO84F9RfYUdReidJMBVeX2kltsbeyWoLYIQZ6K
rBW3/K1j2eW9/PLx3rYlSl4lYOgHX9666fA2TVWJ31CRFw5lESpEFT+fG6BDfb7y
JtDrKuX2uKOpjv5GhYnvj7UQ32MgnimMjJPLNAXAb11J7+MWZQJDSFpO4d9TQeb7
/t/FSVKli/3Oyl/GK88HOpDoo2RHBA==
=+W9W
-----END PGP SIGNATURE-----

--tymcpkc7z7lju776--

