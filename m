Return-Path: <linux-can+bounces-1493-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D55B976404
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 10:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C0F1F21E9A
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 08:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DAB19004A;
	Thu, 12 Sep 2024 08:06:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F12318FDDB
	for <linux-can@vger.kernel.org>; Thu, 12 Sep 2024 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128385; cv=none; b=KWrgZaYdmUditKA9FrqzxcHsjIG+Kngo3OeGiSY1hVylv3U9dCCZF7Ng5GPjbmrSrgqwg3zsog2VdV0DpQMtewUwpBeg0V+kv71laVmHaHnU5QvxJyMqQWj28RWZOzzGpgE1FLqeXY7ODJc37DGN5N7tb+qbkGbQMZRYiIJqeu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128385; c=relaxed/simple;
	bh=P0QW3eUui3jH3ahZzJIfEnfBUeffglKNHp4BLtQwZgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogM52gpwgre3HqfPQU+nH8clxuKYAkFOtC6qi4UzVVBFq2NsTbVl35TqhTHkIfbyGy6rBO4wAcWLZwoG7D1yqF/rgWJ8+U+4FDAojFGmXLjOv3wATdfPfNbBS6H/KLEVBb6eoWy6cT1wOPSHhMPtD+bZGytWXC8pDnkzCZA8Ea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeq9-00048c-53; Thu, 12 Sep 2024 10:06:09 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeq6-007Kg6-Qh; Thu, 12 Sep 2024 10:06:06 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 44E80338DE4;
	Thu, 12 Sep 2024 07:45:05 +0000 (UTC)
Date: Thu, 12 Sep 2024 09:45:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jake Hamby <Jake.Hamby@teledyne.com>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Dong Aisheng <b29396@freescale.com>, Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH can v3 1/2] can: m_can: enable NAPI before enabling
 interrupts
Message-ID: <20240912-ingenious-ruddy-deer-327fdb-mkl@pengutronix.de>
References: <20240910-can-m_can-fix-ifup-v3-0-6c1720ba45ce@pengutronix.de>
 <20240910-can-m_can-fix-ifup-v3-1-6c1720ba45ce@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o53ahiqpbfpfpvdc"
Content-Disposition: inline
In-Reply-To: <20240910-can-m_can-fix-ifup-v3-1-6c1720ba45ce@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--o53ahiqpbfpfpvdc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.09.2024 19:15:28, Marc Kleine-Budde wrote:
> From: Jake Hamby <Jake.Hamby@Teledyne.com>
>=20
> If an interrupt (RX-complete or error flag) is set when bringing up
> the CAN device, e.g. due to CAN bus traffic before initializing the
> device, when m_can_start() is called and interrupts are enabled,
> m_can_isr() is called immediately, which disables all CAN interrupts
> and calls napi_schedule().
>=20
> Because napi_enable() isn't called until later in m_can_open(), the
> call to napi_schedule() never schedules the m_can_poll() callback and
> the device is left with interrupts disabled and can't receive any CAN
> packets until rebooted.
>=20
> This can be verified by running "cansend" from another device before
> setting the bitrate and calling "ip link set up can0" on the test
> device. Adding debug lines to m_can_isr() shows it's called with flags
> (IR_EP | IR_EW | IR_CRCE), which calls m_can_disable_all_interrupts()
> and napi_schedule(), and then m_can_poll() is never called.
>=20
> Move the call to napi_enable() above the call to m_can_start() to
> enable any initial interrupt flags to be handled by m_can_poll() so
> that interrupts are reenabled. Add a call to napi_disable() in the
> error handling section of m_can_open(), to handle the case where later
> functions return errors.
>=20
> Also, in m_can_close(), move the call to napi_disable() below the call
> to m_can_stop() to ensure all interrupts are handled when bringing
> down the device. This race condition is much less likely to occur.
>=20
> Tested on a Microchip SAMA7G54 MPU. The fix should be applicable to
> any SoC with a Bosch M_CAN controller.
>=20
> Signed-off-by: Jake Hamby <Jake.Hamby@Teledyne.com>
> Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Tested successfully on a stm32mp1.

Tested-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Mar
c
--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--o53ahiqpbfpfpvdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbim/4ACgkQKDiiPnot
vG+eqgf/Y278Mm2VhmA92JQSpeHGcr4HsaZMY8T8Hb9gCZDC6NMNbz8bSt8Fquaj
NxF8TRlPaTHn5HJSGklvy1IOm3ZMqt9qdqBVDZzK9+zFdQEk5AusVm0PUzUA8ykB
wpSan5ztoT+a5CQilB/YVSyLOxma2AEV9pDrfaq2YtWexRTRPkJ6BvmfW7lOmtu/
SqGIjjCfVo5UwcTBJR5qb6bd3VUcr0ftewKRa3RHcYJ7do7vTCabK9EOFz3DvKky
EsDfbVRXTWdiR17QcsXkiESzuP5iWAqh1jajKivZLeo1Qsj9d7ijb3skznNruxF5
5yCaDZN0lEHJHRb43HGKFhCvEFiSDQ==
=yeUS
-----END PGP SIGNATURE-----

--o53ahiqpbfpfpvdc--

