Return-Path: <linux-can+bounces-3526-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE79AA80BF
	for <lists+linux-can@lfdr.de>; Sat,  3 May 2025 14:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5C51B61C78
	for <lists+linux-can@lfdr.de>; Sat,  3 May 2025 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3F01EC014;
	Sat,  3 May 2025 12:56:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7C2153598
	for <linux-can@vger.kernel.org>; Sat,  3 May 2025 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746276973; cv=none; b=Ep1A7MKrtD95gGfM2cUvUyCjN5IQX/hcF38IMfr/cRmqt6OSUM1y65wYZA05c9tM+pWd3mP5G6373a/xkHp7X7XEwiAWs5R7OA3PyE0WMEHpDhFs3MMH3/z737vpPQxeYYiid0xaRnwo8gNMPJgJ5a0kPrqcQT5acSNSUW3Zvag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746276973; c=relaxed/simple;
	bh=12EAWKq7MdOtEvzPu5TCuZxnG0PextPRcDusQkAvYgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esKnhXFfblyobp7IYSKhkIM/H2gXjtnxMdql4N4BasO2dgqV8irfz58XPo7lXjKKeSp4l3e6qk30QMNfX0Mxsa2fFhN9HRWSUC2lk57/HpPHRDlKHT6NgtFk+dzBqxpfzD26nXepa/rZUh1UKaJYe34c0oJS/vASTVmWtwhpI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uBCPa-0005iX-9e; Sat, 03 May 2025 14:56:10 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uBCPZ-000uXG-0b;
	Sat, 03 May 2025 14:56:09 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D0B42407493;
	Sat, 03 May 2025 12:56:08 +0000 (UTC)
Date: Sat, 3 May 2025 14:56:08 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kelsey Maes <kelsey@vpprocess.com>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcp251xfd: make TDC controllable from userspace
Message-ID: <20250503-noisy-successful-jaguar-234e7c-mkl@pengutronix.de>
References: <20250425191336.45581-1-kelsey@vpprocess.com>
 <20250428-impressive-masterful-squid-a898c4-mkl@pengutronix.de>
 <79BCE02A-D4EC-4362-B0D3-3FE76FB17B78@vpprocess.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7xjr6d4kpchhhfui"
Content-Disposition: inline
In-Reply-To: <79BCE02A-D4EC-4362-B0D3-3FE76FB17B78@vpprocess.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--7xjr6d4kpchhhfui
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: mcp251xfd: make TDC controllable from userspace
MIME-Version: 1.0

On 28.04.2025 09:11:05, Kelsey Maes wrote:
> > Reported-by: Kelsey Maes <kelsey@vpprocess.com>
> > Closes: https://lore.kernel.org/all/C2121586-C87F-4B23-A933-845362C29CA=
1@vpprocess.com
>=20
> Sure, I=E2=80=99m fine with that.
>=20
> > BTW: In you original mail, you've written that you're using a bitrate
> > of 125 kbit/s and a data bitrate of 500 kbit/s. This is a bit unusual.
> > Is that a real world application? Are you allowed to say which one?
>=20
> We are building an industrial automation system that uses CAN bus in plac=
e of
> RS-485 for controlling potentially distant modules. That particular bitra=
te is one
> of 4 possible bitrates the system can operate at: 125 / 500, 250 / 1000,
> 500 / 2000, 1000 / 4000. We have an automatic bit rate detection mechanism
> and having a fixed 1:4 ratio simplifies the implementation. The lower bit=
rates
> will only be used in situations where a very long bus, poor wiring, and/o=
r noise
> issues prevent the use of higher bitrates. These are all very common issu=
es we
> have encountered with our existing RS-485 systems in the field.=20

I see, so 125/500 is a real world use-case. I'll add lower data bitrates
to the can-utils tools then :)

> > I just noticed that there is another potential problem with this
> > combination of bit rates. The used BRP for the arbitration- and data
> > bitrate are not identical:
[...]
> > This leads to a phase error while switching from arbitration to the data
> > bitrate. A common BRP of 5 is better:
[...]

> I agree. This problem can be worked around by specifying the timing param=
eters
> explicitly, if required. It has not been an issue so far.

Ack

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7xjr6d4kpchhhfui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgWEmQACgkQDHRl3/mQ
kZwMfAf/T+khJnle+ZHtdAu82x40iyuv9vvX6x2+8LmUCgpXx7zM9A05UZVPMPKf
TwMOqIrqaSIF25c3U/JzLcvZZbqZFTx2btALScRlfx1GS15kluK+jV5TNKaO+1Om
U2Z7Y8sGG2vSr4yM+O6z0BDcRsD7S7a10AAEF8Of5Ki7VlFXSa9NUBI3TOjTUQSJ
tN/lkHKO4mkvqCRN79lYoNzrejcTcOSxtWdRdVB1I4VSF3WS7YbTdSbqWhFWZmDW
VYbY9L2R6T+8sENhlTmnMJzb2qEZbwa9Q4j/7gXiA/lLD120RxBY97o3PEXWCuZv
Xyn7xu9spt7F6LgP8FToSmq9D6JO8g==
=+JLj
-----END PGP SIGNATURE-----

--7xjr6d4kpchhhfui--

