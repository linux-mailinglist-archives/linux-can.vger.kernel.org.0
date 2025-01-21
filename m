Return-Path: <linux-can+bounces-2670-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FCDA17A36
	for <lists+linux-can@lfdr.de>; Tue, 21 Jan 2025 10:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BC116A04B
	for <lists+linux-can@lfdr.de>; Tue, 21 Jan 2025 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C611B041B;
	Tue, 21 Jan 2025 09:31:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C30F15C0
	for <linux-can@vger.kernel.org>; Tue, 21 Jan 2025 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737451906; cv=none; b=ODrclMl6AeseqW2tv2LI+fNJU1w8Gjd8yRXnn59QaEZm397I5T9HRIWRrrnX3YUJeuIwOKc5BM9TyLZ6MkfCS+CiY3tGGGw6ckFNw49qPUHI67CXoajGZ+WHE888BQymzavKD6iFM6dLxUfhLF8e6dy3idwqA7FtB1RkTQgAdyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737451906; c=relaxed/simple;
	bh=3pISScyrccuNup3riAEvUCv5TuMgG3TrpekKBzuKgx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oD4pB1qA7OBHYRXspkSFiLbOpzIVAZa6x9SVSXtI/FBUOsn48869EmTHbXuEeocAzti5zh6f5/CMfTVPbW1al6NJDeMz2f45eYMMOYArocPS+4jE00PDE5m2qhRSMDVOuONpu4wsa3eNfWQ++CBFq6wNmMDe8PnGTIEeyvXblYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1taAbm-0004cQ-NY; Tue, 21 Jan 2025 10:31:42 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1taAbm-0015FY-1S;
	Tue, 21 Jan 2025 10:31:42 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 20BC93AD87A;
	Tue, 21 Jan 2025 09:31:42 +0000 (UTC)
Date: Tue, 21 Jan 2025 10:31:41 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Jonas Mark (BT-FS/ENG1-Mue)" <mark.jonas@de.bosch.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"Streidl Hubert (BT-FS/ENG1-Mue)" <Hubert.Streidl@de.bosch.com>
Subject: Re: AW: [can-utils][PATCH 2/3] canbusload: support busload statistic
Message-ID: <20250121-heretic-weightless-terrier-c99522-mkl@pengutronix.de>
References: <20250120162332.19157-1-mark.jonas@de.bosch.com>
 <20250120162332.19157-2-mark.jonas@de.bosch.com>
 <20250120-vigorous-almond-toad-a28dc0-mkl@pengutronix.de>
 <DU0PR10MB7076197E81AB49C6C59ECE60ADE62@DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="22qlic6k5az52sav"
Content-Disposition: inline
In-Reply-To: <DU0PR10MB7076197E81AB49C6C59ECE60ADE62@DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--22qlic6k5az52sav
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: AW: [can-utils][PATCH 2/3] canbusload: support busload statistic
MIME-Version: 1.0

On 21.01.2025 07:51:50, Jonas Mark (BT-FS/ENG1-Mue) wrote:
> > Had to make this a "static" function, otherwise it fails to link. Some
> > singed/unsigned changes were also needed. Can you check if this still
> > works for you:
> >=20
> > | https://github.com/linux-can/can-utils/pull/571
> >=20
> > So far compile tested only.
>=20
> Thank you for your feedback. We'll have a look it by the end of the week.
>=20
> We compiled and tested with Ubuntu 22.04 on amd64 (standard PC). That
> is, we used gcc 11.4 and ld (binutils) 2.38. For us it linked
> flawlessly and compiled without warnings. Which version of gcc and ld
> did you use?

It basically fails on all of our CI plaforms (ubuntu and debian):

| https://github.com/linux-can/can-utils/actions/runs/12872465505/job/35887=
996190

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--22qlic6k5az52sav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmePaXoACgkQKDiiPnot
vG+PFQgAg1cbTejjY3TEib5Lv8SLHYOnWw6CQFIhIzFDsLDq8+bBpMpP1xwO7pGT
zQusi1yiW4Hz9Qh90YMBWHCpVQC//qwwbI5vQHRA+NXKS5TOOc/tAu1wFDmJa3cl
mqoVukphD/MQcIDfgbc2yQ7WdbRpd5DghMFYLLUhNspaJQnAwMjkXsFH/FjUzGtY
iqJ22/10F6lVhxf/mTzBvnGS7r158pRmurzNnaZ6PSbgeQilKZTr81Qj/iLqC1tm
FoptQ/lLpE7sWwr3H4PxmGEgYRP995KZMS9aSKx+anhUnYAcLdcA74E/pASDgzRy
o+4v8A/ri4wLxWL1s1Z0nDBevTTLkA==
=GLHi
-----END PGP SIGNATURE-----

--22qlic6k5az52sav--

