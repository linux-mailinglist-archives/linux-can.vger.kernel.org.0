Return-Path: <linux-can+bounces-162-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B1C83BE5B
	for <lists+linux-can@lfdr.de>; Thu, 25 Jan 2024 11:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7AE11C22C0F
	for <lists+linux-can@lfdr.de>; Thu, 25 Jan 2024 10:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4161CAAA;
	Thu, 25 Jan 2024 10:09:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085091CA82
	for <linux-can@vger.kernel.org>; Thu, 25 Jan 2024 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177347; cv=none; b=VfDdn/3m00Qd9bA2sXXgGqAJVddMDXYKzo1Ng/zUUSxHYStyq7nrMM/94FLEYEHB86a/9dJcaUy+qYR2FHAVoZ2rHVsqJ93u9Ibu6nj/xQ2U+zb+uH+XktnG6Ad7ZiDu1RbGq565yucdNUpaRaJ3D67he/IyekveJO8tHciqko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177347; c=relaxed/simple;
	bh=CPM7Cpy8M37qPA6YtjwBZi66jb7x97G0/tsY6EbsCCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6O4n6OB/mbwSEHwTURiOuyotS/sRGax6Hhi+1nIdpfhllqpeDGqLBnB0Dho+aVHN+AsbC4jDb9hvy4nThGN4zwY1E3aeKPPIztCPJhKQXCftEct//qQlSfSMlGt5R+8Zk4iuZ134Pb27Dn5cl4gfHxKiat7SrWgjr0dqOOSILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rSwfP-00046C-6m; Thu, 25 Jan 2024 11:09:03 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rSwfO-002GFR-Po; Thu, 25 Jan 2024 11:09:02 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7713B27E099;
	Thu, 25 Jan 2024 10:09:02 +0000 (UTC)
Date: Thu, 25 Jan 2024 11:09:01 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Dr. Michael 'Mickey' Lauer" <mickey@vanille.de>
Cc: linux-can@vger.kernel.org
Subject: Re: Candump timing issues
Message-ID: <20240125-squad-revenge-08a50f1af4e4-mkl@pengutronix.de>
References: <AE1EC1F4-8356-49AA-8CB2-748683014B23@vanille.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xzrvvke5binwvbto"
Content-Disposition: inline
In-Reply-To: <AE1EC1F4-8356-49AA-8CB2-748683014B23@vanille.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--xzrvvke5binwvbto
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.01.2024 15:58:57, Dr. Michael 'Mickey' Lauer wrote:
> I=E2=80=99m writing a MCP2518fd driver (for an ESP32) and am using my Log=
ic Analyzer
> to measure timing. I have a simple =E2=80=9Eecho=E2=80=9C program where t=
he MCP repeats every
> CAN frame it receives. The sender is a pretty fast Linux machine using
>=20
> cangen can0 -I 777 -L 8 -D r -v -v -g 1000
>=20
> I=E2=80=99m also monitoring this (on the same machine) via
>=20
> candump -D -catd can0
>=20
> Here=E2=80=99s an excerpt from a few seconds:
>=20
>  (000.000000)  can0  777   [8]  94 F8 BF 7E F1 6E 68 6B   '...~.nhk'
>  (000.000770)  can0  777   [8]  94 F8 BF 7E F1 6E 68 6B   '...~.nhk'
>  (000.999518)  can0  777   [8]  0E 99 51 48 E6 FF CE 64   '..QH...d'
>  (000.000733)  can0  777   [8]  0E 99 51 48 E6 FF CE 64   '..QH...d'
>  (000.999406)  can0  777   [8]  AC 1C A4 01 B7 10 FC 7C   '.......|'
>  (000.000854)  can0  777   [8]  AC 1C A4 01 B7 10 FC 7C   '.......|'
>  (000.999348)  can0  777   [8]  53 DA B4 5B 58 EA B4 5C   'S..[X..\'
>  (000.000769)  can0  777   [8]  53 DA B4 5B 58 EA B4 5C   'S..[X..\'
>  (000.999483)  can0  777   [8]  BF 2E 36 77 49 52 A0 1D   '..6wIR..'
>  (000.000796)  can0  777   [8]  BF 2E 36 77 49 52 A0 1D   '..6wIR..'
>  (000.999389)  can0  777   [8]  16 EF B7 22 85 F0 83 12   '..."....'
>  (000.000735)  can0  777   [8]  16 EF B7 22 85 F0 83 12   '..."....'
>  (000.999357)  can0  777   [8]  BA C4 BF 45 E3 7C CD 73   '...E.|.s'
>  (000.000845)  can0  777   [8]  BA C4 BF 45 E3 7C CD 73   '...E.|.s'
>  (000.999404)  can0  777   [8]  95 1B 65 1C 81 15 DB 64   '..e....d'
>  (000.000731)  can0  777   [8]  95 1B 65 1C 81 15 DB 64   '..e....d=E2=80=
=98
>=20
> Now I really wonder about these values, in particular the
> time between the =E2=80=9Equestion=E2=80=9C and the =E2=80=9Eanswer=E2=80=
=9C. This is a CAN 2.0B
> bus @ 500000bps with only two nodes.
>=20
> Looking at my Logic Analyzer, it takes me about
> 160=C2=B5s to send the received frame back into the MCP,
> where then the arbitration starts on the CAN bus.
>=20
> It takes an additional 200=C2=B5s for the frame to be sent on the bus,
> so I=E2=80=99d expect to see a maximum of 360=C2=B5s, if this is using ha=
rdware
> timestamps.

These are SW timestamps. If you want to display hardware timestamps, add
'-H'. You also need a CAN controller/Linux driver that support HW
timestamps.

> I could only see 750=C2=B5s, if I were to measure from the beginning of
> the =E2=80=9Equestion=E2=80=9C and the end of the =E2=80=9Eanswer=E2=80=
=9C frame, but that=E2=80=99s make
> sense.
>=20
> Is my understanding of these timestamps wrong?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xzrvvke5binwvbto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmWyMzsACgkQvlAcSiqK
BOhlmwgAqOmnq+55Yyu0Bx8TNGd3543DRVgAZD6V/7rWpDbvVEcCudJJu7kP187w
26xl3sHbp4QgBjXDLl7rsqdgvj3llC1Pw9NVFlUCRKsaTJlNzjRYKvntVkZaR+vX
VGgz7s7XBVvGMjab1UMaovXiS7osN8XazD6Ex6aTO9xiSGQyqbCcTUM91kwiGRrC
xn6KPUJAB7BuFMv5ngemwDTxR1YSnyx/1YIGci3jlFAsr7s1BWui2QzbbJVerO31
q/+mBd9306gzsYpojTY+qKUkoeWmqNCbFhxk6C/SJF8TvMNJaD5eqfvCV94x7Tb+
iGZd68YxxJITJLj/r2vNA0yp4dr8xA==
=GR/V
-----END PGP SIGNATURE-----

--xzrvvke5binwvbto--

