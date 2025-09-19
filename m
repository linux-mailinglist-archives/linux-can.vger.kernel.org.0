Return-Path: <linux-can+bounces-4758-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B97ABB8AD84
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 20:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9FD1CC2BB5
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 18:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA8422A4CC;
	Fri, 19 Sep 2025 18:02:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE231A2392
	for <linux-can@vger.kernel.org>; Fri, 19 Sep 2025 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304972; cv=none; b=MDyl1rVuQa5jm7OMKgVeid8dhbdoCV4PchuOdJoBiIBiEaCukFEgvRyhzbrpxlfCeeGtF2MqPQH0F53yYDFvov9u6jC5YPeHIxdMdkzlHMXPdQ6qM2ckEXumoTk2jm9TQWjidTsjL7WGXjGCt7uXsYl2yHdHQmZBQpMjwxY1Fso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304972; c=relaxed/simple;
	bh=EWCrKBfF2Qf9kf0iSlYXoPXjHwaQ4trX/gTL334AUF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDVMpl1GYrDpBybuf4VA9TlsW8ywN54hiBnZaGDDvsloIhH48j2wVRMEuvbQ/wmTtE9RiLsHnW8NgG5NIQOkese1tJ9bMTt689pLFcv8caApFQNePP4gSCwiN2Uw0j2G8Qczj8A8mhsgta+/uNcDCaKKJZblKxYIc76CAXvuvHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzfRS-0001HO-Fh; Fri, 19 Sep 2025 20:02:42 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzfRR-0028xk-2S;
	Fri, 19 Sep 2025 20:02:41 +0200
Received: from pengutronix.de (ip-185-104-138-125.ptr.icomera.net [185.104.138.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6496747514B;
	Fri, 19 Sep 2025 18:02:40 +0000 (UTC)
Date: Fri, 19 Sep 2025 20:02:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org, socketcan@esd.eu, 
	Simon Horman <horms@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 4/5] can: esd_usb: Rework display of error messages
Message-ID: <20250919-dugong-of-pleasurable-courtesy-c4abeb-mkl@pengutronix.de>
References: <20250821143422.3567029-1-stefan.maetje@esd.eu>
 <20250821143422.3567029-5-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5z3yj2scionqtwbn"
Content-Disposition: inline
In-Reply-To: <20250821143422.3567029-5-stefan.maetje@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--5z3yj2scionqtwbn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/5] can: esd_usb: Rework display of error messages
MIME-Version: 1.0

On 21.08.2025 16:34:21, Stefan M=C3=A4tje wrote:
> - esd_usb_open(): Get rid of duplicate "couldn't start device: %d\n"
>   message already printed from esd_usb_start().
> - Fix duplicate printout of network device name when network device
>   is registered. Add an unregister message for the network device
>   as counterpart to the register message.
> - Added the printout of error codes together with the error messages
>   in esd_usb_close() and some in esd_usb_probe(). The additional error
>   codes should lead to a better understanding what is really going
>   wrong.
> - Convert all occurrences of error status prints to use "ERR_PTR(err)"
>   instead of printing the decimal value of "err".
> - Rename retval to err in esd_usb_read_bulk_callback() to make the
>   naming of error status variables consistent with all other functions.
>=20
> Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>

I've squashed the changes in the probe function into patch 1.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5z3yj2scionqtwbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjNmrkACgkQDHRl3/mQ
kZwkrwf/SW7PyEEtldAVJOF7U0NFHpYPfu14JbQFCcA8CxtCgpDutOmJyhecNnn9
kJUO8I2kr3olTc35IjpQnPCZQV1wH2OOzRwGcNMaXPQHV6Vrijm35Zr2NiUPF/ZG
0NH8JUphsPqrupwx18MWZjayXdeN/fHE3OgOojOtDLnzaVFMFT/WQp0SMYcx7frL
4L9Y5jUAt6M8iYmkt74+T+FEDIiOWDVeF2Vv7RJ5PAE5aLHOdWX93gTZXNRzIOxE
hyGOKsJI3r5+jdkWQApLEvCSntGNkgoAyaE1LoQXXiYxGddSvQXJUB1JIvR+n3uL
OQFiaqNImOJixz3W8JasRfnSDfYxVw==
=WYNa
-----END PGP SIGNATURE-----

--5z3yj2scionqtwbn--

