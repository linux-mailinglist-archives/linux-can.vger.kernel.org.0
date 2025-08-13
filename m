Return-Path: <linux-can+bounces-4219-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5979DB243CD
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 10:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C541883973
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 08:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB758274FDE;
	Wed, 13 Aug 2025 08:10:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF031A317D
	for <linux-can@vger.kernel.org>; Wed, 13 Aug 2025 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072602; cv=none; b=qIFjKnq5Q2vf1dITl0cNZji+WadhSVZAxOJldR6w6SzCt7/peKgiErAL5HVhEoy2VUvvZqB3+mH+Mm0Cp5TFCtAAAGNhBAOhJWWDQgmE1iIJNARB1DFYzmLkrZ8JEP3eymQMPeyk5VoLF7ojYcthCiN56O0XJl/swFTZdHu1Vi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072602; c=relaxed/simple;
	bh=4KiSNX19Qc3qkOfrFUo/w/Eo9KWpp7c4XVpRXhYycn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZABXXUvDmIIGaAX18W6YQDlamia7YSV8jXP3PAUSpuK1Pu96za3KEG8KX1pCyD6XEbX2PErOvssr7bzSzdueIm5+GfRr0Lk9Y5/HSHWTFN7leoQyl/upEOqTYBcalk7OjXuuH82HNRABUzqqa2HPaaNsaI59bFSjHDAeUHF8Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1um6YS-0001an-Uk; Wed, 13 Aug 2025 10:09:52 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1um6YS-0003kh-0t;
	Wed, 13 Aug 2025 10:09:52 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E1222456864;
	Wed, 13 Aug 2025 08:09:51 +0000 (UTC)
Date: Wed, 13 Aug 2025 10:09:51 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org, socketcan@esd.eu, 
	Simon Horman <horms@kernel.org>, Olivier Sobrie <olivier@sobrie.be>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 6/6] can: esd_usb: Avoid errors triggered from USB
 disconnect
Message-ID: <20250813-tiny-bird-of-painting-999c89-mkl@pengutronix.de>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
 <20250811210611.3233202-7-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lt64ku544zgvs7x2"
Content-Disposition: inline
In-Reply-To: <20250811210611.3233202-7-stefan.maetje@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--lt64ku544zgvs7x2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6/6] can: esd_usb: Avoid errors triggered from USB
 disconnect
MIME-Version: 1.0

On 11.08.2025 23:06:11, Stefan M=C3=A4tje wrote:
> The USB stack calls during disconnect the esd_usb_disconnect() callback.
> esd_usb_disconnect() calls netdev_unregister() for each network which
> in turn calls the net_device_ops::ndo_stop callback esd_usb_close() if
> the net device is up.
>=20
> The esd_usb_close() callback tries to disable all CAN Ids and to reset
> the CAN controller of the device sending appropriate control messages.
>=20
> Sending these messages in .disconnect() is moot and always fails because
> either the device is gone or the USB communication is already torn down
> by the USB stack in the course of a rmmod operation.
>=20
> This patch moves the code that sends these control messages to a new
> function esd_usb_stop() which is approximately the counterpart of
> esd_usb_start() to make code structure less convoluted.
>=20
> It then changes esd_usb_close() not to send the control messages at
> all if the ndo_stop() callback is executed from the USB .disconnect()
> callback. A new flag in_usb_disconnect is added to the struct esd_usb
> device structure to mark this condition which is checked by
> esd_usb_close() whether to skip the send operations in esd_usb_start().

I cannot find the reference anymore, but I remember that Greg said, that
USB devices should just be quiet when being unplugged. I removed the
error prints from the gs_usb's close function, see: 5c6c313acdfc ("can:
gs_usb: gs_can_close(): don't complain about failed device reset during
ndo_stop")

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lt64ku544zgvs7x2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmicSEwACgkQDHRl3/mQ
kZwfgQf/YORMazOc0dy0aG3ryMQVZyJ/EsBLYMo6G+eLDFPD3Y9S69jFQ1VJOqqz
oEaVk8DPpXqjKJaqvJtvEmkp5omXLENE67Os3yRjYhtKT8lFWiV1pvXf+pGW78qK
ROyPFqd0+ro06Jo5l7wI+iyG5x4Km7Ie93Wyl42UCOySII1FiVufquDwzbfj3pMX
Xq407GOqe8BtR72fOkpl1f8ZMVlhUBt143ClhMAPnHL/Q1P/LS85I1vvRAPKX7Gs
qzCng0+3Ymd7JK+yCKR+CgFosjl8dVYjzSm0ayv75vhzg0ELjrEE99pKbetliMEV
yFjFBwLZIlcXSQ2FwNY+BVRx2/H9XQ==
=gVLU
-----END PGP SIGNATURE-----

--lt64ku544zgvs7x2--

