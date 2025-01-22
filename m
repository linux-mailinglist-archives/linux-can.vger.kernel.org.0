Return-Path: <linux-can+bounces-2677-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552EFA1946D
	for <lists+linux-can@lfdr.de>; Wed, 22 Jan 2025 15:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91DCC1643ED
	for <lists+linux-can@lfdr.de>; Wed, 22 Jan 2025 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B77E211712;
	Wed, 22 Jan 2025 14:56:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3D2144A2
	for <linux-can@vger.kernel.org>; Wed, 22 Jan 2025 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737557790; cv=none; b=qKAa92EO/DkPQsj09BJxNh/aojaeeNdD/dXIURu3JoFUF6LnDfgbVX6e/WNmeRFyh6DlPsgOlp5u5UjFh4E/3rRBH0AP1B/nbn0jaJ6glhEZ1W7K2cZRe8Elj3jScrR9Z1cl27sZOxgXYyRpVprprm+Kmf4ZggJKV3rtkhqNexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737557790; c=relaxed/simple;
	bh=OtddwqvUz1gzX7P/B7MGUy86skcIf3n3MAYY6O8XmNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOxBxebBqVVMqz3NyWtX7LFWA1WD0PAxTi5uDp5DZbsk4IwNXabnBlMKSJfPgj3yt2KrslFgxLes97gL5N00t5UkxGzlXic2qXO/+q9jCiLv2S0Xem7zmXLo3ljGnEzAv3ujx2jsBadTfhpUGcaX3CDhOh48hj//QEd7T1JJ55s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tac9R-0000kw-7H; Wed, 22 Jan 2025 15:56:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tac9Q-001IqY-38;
	Wed, 22 Jan 2025 15:56:16 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AC8F73AEBF9;
	Wed, 22 Jan 2025 14:56:16 +0000 (UTC)
Date: Wed, 22 Jan 2025 15:56:16 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Jonas Mark (BT-FS/ENG1-Mue)" <mark.jonas@de.bosch.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"Streidl Hubert (BT-FS/ENG1-Mue)" <Hubert.Streidl@de.bosch.com>
Subject: Re: AW: AW: [can-utils][PATCH 2/3] canbusload: support busload
 statistic
Message-ID: <20250122-scrupulous-sociable-barracuda-5c133f-mkl@pengutronix.de>
References: <20250120162332.19157-1-mark.jonas@de.bosch.com>
 <20250120162332.19157-2-mark.jonas@de.bosch.com>
 <20250120-vigorous-almond-toad-a28dc0-mkl@pengutronix.de>
 <DU0PR10MB7076197E81AB49C6C59ECE60ADE62@DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM>
 <20250121-heretic-weightless-terrier-c99522-mkl@pengutronix.de>
 <DU0PR10MB70768402AD0511053562B7CCADE12@DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="beb5jzc3bcgcowoz"
Content-Disposition: inline
In-Reply-To: <DU0PR10MB70768402AD0511053562B7CCADE12@DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--beb5jzc3bcgcowoz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: AW: AW: [can-utils][PATCH 2/3] canbusload: support busload
 statistic
MIME-Version: 1.0

On 22.01.2025 14:53:30, Jonas Mark (BT-FS/ENG1-Mue) wrote:
> > It basically fails on all of our CI plaforms (ubuntu and debian):
> >=20
> > | https://github.com/linux-can/can-utils/actions/runs/12872465505/job/3=
5887996190
>=20
> We now understood what the problem was: We only compiled using gcc but
> the project supports gcc and clang. So we missed the clang problems we
> introduced. Next time we'll use the project's GitHub actions to
> validate our code.

Thanks again for contributing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--beb5jzc3bcgcowoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmeRBw0ACgkQKDiiPnot
vG9n8gf/U6UmF2bhQ9NBQ74pmWvwOXSlEXx8KDmudvbRbmwboEgo/KRGvjETIABA
9XOlgB2pEycoVtu2H0M04XZCLoJ2+qS13qReeoDkNnQq8t4rYoixVC90WQ53eVB4
i2mBYNFQ9vZq4DgR/nQKe6ae/I+TgQXl3nIYOewhDWUNcLZFuDUXi3XohRaC8mAX
Fk9tJQ7GFmXrYc3RTyvN/mdzW6jOAttT3Pfdq94ZQhcbbgF4TzKVWHPzCLze/3yb
6M2oe8pu3B1JYCit4nXQeADkEe3IxWmhP+DYuRCuKuSMC4CTTL3QB0dzqs//L9aq
iyih/h+w2B769XPB/VvnN0YluTQDtw==
=J0fa
-----END PGP SIGNATURE-----

--beb5jzc3bcgcowoz--

