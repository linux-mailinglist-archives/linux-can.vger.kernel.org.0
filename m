Return-Path: <linux-can+bounces-224-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBCC8517DA
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 16:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C751B22147
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 15:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A8B3C470;
	Mon, 12 Feb 2024 15:22:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04383C46E
	for <linux-can@vger.kernel.org>; Mon, 12 Feb 2024 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751329; cv=none; b=MM/o3/JAuEIkTCOZyXc7yWhjSio1KML47e2c3CrQ+YQEbUrZi8sXGpiQamsSq2f9B/emnMp5TdB8l1d/f//fLSDIlYT1j/MRRl/ZibNyyYuskUfwa2cUNWPvXGlO/YAtgd01S889yv9U/+xeq+6XppNjHSQBoR0bmLybv5RNq+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751329; c=relaxed/simple;
	bh=UEDtnWFQgQ/xfFC55u2Qy2Awc6307hNR13Z/m2xaLCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4ESKXBBKVke9YinOiY01EXef3E6A2wSWEI6nCiWOl/d7KQnQ4EBox0kUTKfPkFN49/vuPdBMLoWA026XL7mqvN+0GQePz5QR/mgv6c4nEEhWxj0O7mRC9swgS/KwnvajdCKCj4rQyximT5gWnN4vAMmdT5H1MMTai7TAJcJ5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZY8A-00056e-9x; Mon, 12 Feb 2024 16:22:02 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZY88-000JWT-Sk; Mon, 12 Feb 2024 16:22:00 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 843A128C656;
	Mon, 12 Feb 2024 15:22:00 +0000 (UTC)
Date: Mon, 12 Feb 2024 16:22:00 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Guy Harris <gharris@sonic.net>, 
	Vincent Mailhol <vincent.mailhol@gmail.com>
Subject: Re: [PATCH rework v1] canxl: add virtual CAN network identifier
 support
Message-ID: <20240212-smooth-pregnancy-3c6ff0a86246-mkl@pengutronix.de>
References: <20240212151404.60828-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wbovqz56idy3enm6"
Content-Disposition: inline
In-Reply-To: <20240212151404.60828-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--wbovqz56idy3enm6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.02.2024 16:14:04, Oliver Hartkopp wrote:
> CAN XL data frames contain an 8-bit virtual CAN network identifier (VCID).
> A VCID value of zero represents an 'untagged' CAN XL frame.
>=20
> To receive and send these optional VCIDs via CAN_RAW sockets a new socket
> option CAN_RAW_XL_VCID_OPTS is introduced to define/access VCID content:
>=20
> - tx: set the outgoing VCID value by the kernel (one fixed 8-bit value)
> - tx: pass through VCID values from the user space (e.g. for traffic repl=
ay)
> - rx: apply VCID receive filter (value/mask) to be passed to the user spa=
ce
>=20
> With the 'tx pass through' option CAN_RAW_XL_VCID_TX_PASS all valid VCID
> values can be sent, e.g. to replay full qualified CAN XL traffic.
>=20
> The VCID value provided for the CAN_RAW_XL_VCID_TX_SET option will
> override the VCID value in the struct canxl_frame.prio defined for
> CAN_RAW_XL_VCID_TX_PASS when both flags are set.
>=20
> With a rx_vcid_mask of zero all possible VCID values (0x00 - 0xFF) are pa=
ssed
> to the user space when the CAN_RAW_XL_VCID_RX_FILTER flag is set. Without=
 this
> flag only untagged CAN XL frames (VCID =3D 0x00, CANXL_VCID flag unset) a=
re
> delivered to the user space.
>=20
> The 8-bit VCID is stored inside the CAN XL prio element (only in CAN XL
> frames!) to not interfere with other CAN content or the CAN filters
> provided by the CAN_RAW sockets and kernel infrastruture.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

What does that mean for
https://lore.kernel.org/all/20240128183758.68401-1-socketcan@hartkopp.net/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wbovqz56idy3enm6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXKN5UACgkQKDiiPnot
vG/i3wf+JDTjmaiMTyeS0EWKYYKi7omlVbugd/28HZlMRI5K9uLDQJDHoPcvKdv0
/dE/UVeIYKR58eiuqAoAdI5pqb39hrJ+ACKPmAGBjBEmDjTjDwZMdMYXI5kvlCql
89VACukAkUDinFnkSXYFldoXcE1/1Vr4WTbei3tXBcSTwp02U33LQ0Def+eqqLsE
KUs30TYkMz3QfQLoodhjLVpm+X3SVgPZ5q0S+zxcGLWyjjqm7dCtLlW83XK20/7u
Q0fX0uk22utM6SYrijRJXEY+aYuPSQrO2PIA5ENcwpmkCD+A4Pzo+g1C8CLnHP7u
muXSPREw/SJNNgKmzv8PrVC/XoGTpg==
=h4d2
-----END PGP SIGNATURE-----

--wbovqz56idy3enm6--

