Return-Path: <linux-can+bounces-4757-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63921B8AD23
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 19:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B7A161074
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8744323F42;
	Fri, 19 Sep 2025 17:49:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A632340B
	for <linux-can@vger.kernel.org>; Fri, 19 Sep 2025 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304190; cv=none; b=jZbl9SLHnhl2BP0ilsFuP1s4b1U8xM2jQgH/r04JAERFn6OabdxmrZlL5T5mfRWCi2VypIlcplXFmfpA00PLhcnnkSSP3HDk+Z4bXUlP30Xg0EEs0S7Few7+E3g/8rANY2aTzi7vNQEB7BCdSTkkT/RFHahNrwqX0Y03jkUQUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304190; c=relaxed/simple;
	bh=hCR7eP9ezRJaQrPQcekYxdjqG5MgpkMcReCaiOWsMgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLmL+V2X7TWrRoXkYZBY9gU2+bFSwdl/vzZ3mugPoo5uiaoZS/aX1PjdWWVkeHhdxutocwe1EkjhfHUq2uDhzkN3AWH3SKML7hy4yhEBlLrOSL42sraCqlDUSAC/iw2gYq9mjFR42+K67nhduJhc3lvf4f2o5VXX8u0s4IqQ6ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzfEp-0006yt-5R; Fri, 19 Sep 2025 19:49:39 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzfEo-0028wP-2W;
	Fri, 19 Sep 2025 19:49:38 +0200
Received: from pengutronix.de (ip-185-104-138-125.ptr.icomera.net [185.104.138.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4BF3947510E;
	Fri, 19 Sep 2025 17:49:37 +0000 (UTC)
Date: Fri, 19 Sep 2025 19:49:35 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org, socketcan@esd.eu, 
	Simon Horman <horms@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/5] can: esd_usb: Add watermark handling for TX jobs
Message-ID: <20250919-impressive-pillbug-of-diversity-832227-mkl@pengutronix.de>
References: <20250821143422.3567029-1-stefan.maetje@esd.eu>
 <20250821143422.3567029-4-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gmsrfzgoebxzsekn"
Content-Disposition: inline
In-Reply-To: <20250821143422.3567029-4-stefan.maetje@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--gmsrfzgoebxzsekn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/5] can: esd_usb: Add watermark handling for TX jobs
MIME-Version: 1.0

On 21.08.2025 16:34:20, Stefan M=C3=A4tje wrote:
> The driver tried to keep as much CAN frames as possible submitted to the
> USB device (ESD_USB_MAX_TX_URBS). This has led to occasional "No free
> context" error messages in high load situations like with
> "cangen -g 0 -p 10 canX".
>=20
> This patch now calls netif_stop_queue() already if the number of active
> jobs reaches ESD_USB_TX_URBS_HI_WM which is < ESD_USB_MAX_TX_URBS.
> The netif_start_queue() is called in esd_usb_tx_done_msg() only if
> the number of active jobs is <=3D ESD_USB_TX_URBS_LO_WM.
>=20
> This change eliminates the occasional error messages and significantly
> reduces the number of calls to netif_start_queue() and
> netif_stop_queue().
>=20
> The watermark limits have been chosen with the CAN-USB/Micro in mind to
> not to compromise its TX throughput. This device is running on USB 1.1
> only with its 1ms USB polling cycle where a ESD_USB_TX_URBS_LO_WM
> value below 9 decreases the TX throughput.

Just came into my mind:

In a future patch you can make the watermark dependent on the actual USB
device and or the USB connection type.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gmsrfzgoebxzsekn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjNl6gACgkQDHRl3/mQ
kZw4rAf+KiQng7pbXiTtPMvaM1SJvljSJOMJVxfxyHaYfFDKqhlHcnRTBidj/kWa
PBF5o8N/41ITTYZ3fr2a5TpfKdwc8+VqVyGz8Xf9P79jFeaJSeQ6ylAOrHcoO6mV
OfRfVe+DR7z3iWsnu9LTA/HF2jx7o2PYeXnyWsJAFG2reCA9qB+TgZg9qW3fT+KJ
4v2xEDj8QJ+mVpkb7BU0ZP5/887OhIslUVi4vwbIYHxbrRljUfTsx0Am+uUN6cLJ
VyU3YPHbOQ7TP4viDj8AUsIqq9u5sMP9f8AvUQ/Rl3exq12oWcXt/rDLCgvudOcg
JZ7PeonAQbB1MmeRDTMDQKvZv9aGpw==
=Grva
-----END PGP SIGNATURE-----

--gmsrfzgoebxzsekn--

