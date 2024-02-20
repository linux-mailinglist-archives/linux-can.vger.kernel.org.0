Return-Path: <linux-can+bounces-312-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205AA85B498
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 09:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98310B21902
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6647F5BAF8;
	Tue, 20 Feb 2024 08:10:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C265BAF7
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416633; cv=none; b=FItMi1IX2IFNpvpC+2l3NBUfSUGr1sPsL1FIFlk+vglNk8qI+FWaYF8hrmqNkULAgOkXiGXbJWohci7uyH9uNhFtMzH3kzuTOarOZximwzvXPpPxbEzft1tHd1jviTx45QLqtR1rZsumSiKq3JfdxkUa8WC/zendP2ssstrKYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416633; c=relaxed/simple;
	bh=2mvG8G0vjAYzRghJy+X500Udddlrq5jiwcLv6IqT8Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GH3pPrvJiAd/220L6mcXhfSOoX8XgYs1JsRqx13mjEaRpNqKt+RI8yozOL8FsqduptQA8zdxcJXgtW30wg8UBiD5OiDAcDI4cpw58FxnOfOHETmMBx4C05TllF2LHqF+De9mA3S6w6XanGmllVU+LDX8SyAsvk9cae1B12bi5gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLCt-00035J-QY; Tue, 20 Feb 2024 09:10:27 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLCt-001nlF-Ao; Tue, 20 Feb 2024 09:10:27 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0A00D292E09;
	Tue, 20 Feb 2024 08:10:27 +0000 (UTC)
Date: Tue, 20 Feb 2024 09:10:26 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Dr. Michael 'Mickey' Lauer" <mickey@vanille.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: Protocol recommendation for CAN(FD)-USB adapter
Message-ID: <20240220-cottage-neatly-832a106bc879-mkl@pengutronix.de>
References: <20240216-acclaim-impromptu-4474f57f9761-mkl@pengutronix.de>
 <AEC70E89-BC6E-429A-B756-385ADC2B3E85@vanille.de>
 <20240219-contend-catfight-cd49fff06252-mkl@pengutronix.de>
 <8609D943-B86B-4584-88A1-984BD39E25D3@vanille.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hwbo2qt2hx2ljcuj"
Content-Disposition: inline
In-Reply-To: <8609D943-B86B-4584-88A1-984BD39E25D3@vanille.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--hwbo2qt2hx2ljcuj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.02.2024 08:49:26, Dr. Michael 'Mickey' Lauer wrote:
> Hi Marc,
>=20
> >>=20
> >> Sounds pretty cool. Our design is based on an ESP32-S3 though, so I
> >> have to duplicate that effort. Is there some kind of USB protocol
> >> definition for what gs-usb expects or do I need to learn that from the
> >> implementation?
> >=20
> > I've put together a very rough summary of the driver's side of view:
> >=20
> > https://gist.github.com/marckleinebudde/99f72d9db67accf08cc6efa367cfe54b
> >=20
> > Feel free to update.
>=20
> Wow, that=E2=80=99s very kind of you!

:)

> Later this year I=E2=80=99ll take this blueprint to implement the necessa=
ry
> changes in our firmware. I=E2=80=99ll enhance / update your summary
> as I=E2=80=99ll go.

If you discover any odd points or areas for improvement in the USB
protocol, please let us know.

Currently, TX-complete sends the _entire_ structure back to the host,
which is quite an overhead, especially for CAN FD frames. We're working
on a "short-tx-complete" feature.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hwbo2qt2hx2ljcuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXUXm8ACgkQKDiiPnot
vG8WwwgAm1EM+K1wW07KAUunjhEaOQ/3HomIEdCQxnkJV4PPPub13vIJQ3CBl760
EeA0HkXNlDlg/pbG6Mjf4EBlToHUxkRcU/m72XbxOcvaqGQCp5Yqp6CK/qo/ijWb
E7zrD4y3ygDxCI08Eo4kVJ6hT6O/l7qyHrVxDbvix+mxRGEerFPymG47l5ZlUqHs
Ndw08Oh8S+L7VD0zidAaBtXb1H5LWCkjLbfh6LV0vkxAhk4MtAmLMvdR1kcdFIru
RMN4ghXLkh6bjClw8fr2FHWm6paExLHc83Qny4MLYuKwv9eiVVrOheVjmS+DiB+v
WvSwsCmHBZPBnAIxj59UnQQL3LXxTA==
=2UNa
-----END PGP SIGNATURE-----

--hwbo2qt2hx2ljcuj--

