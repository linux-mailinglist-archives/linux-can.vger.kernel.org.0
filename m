Return-Path: <linux-can+bounces-6061-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8237ED08434
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 10:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A8503061DDE
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 09:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7E2358D38;
	Fri,  9 Jan 2026 09:34:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A722333431
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951261; cv=none; b=W/eRYffI5z66eF5RRkhIcVDU6QJfTC2o8XFbzs+mC4x8gO1mDf6MYkY8GDIzfkKUe6RX9Bp3t1bbSdaYKEP5BZsL0/OOpg6QG4l0FJQ2FTqxq3OIkCblcuNTcpC0VNTKWopa/1/KXQp63wozYI8OYbyJVYcNuB4I+TPaFEn/GEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951261; c=relaxed/simple;
	bh=HGOwSk8S8HDT4sJ9Vum/VM++nG1mV7e0WrIwcS0eQ3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFBkE+CIeqdaba4gGgscM71CXQYGPNBHKq629dA5K3UdQnPdmd71FtSQ/oMM4z6+GnG77jL1eIS6x+F3kTE6UR+qGLMnW71+eset+CAe3caYDnbXN51VaXWs1A3t4IldqGfwRh4xVx8NmwhbUyOjq8xlMpJbQf84fRnZ8UT8OA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ve8ss-0006P6-Ot; Fri, 09 Jan 2026 10:34:18 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ve8ss-009p1x-1o;
	Fri, 09 Jan 2026 10:34:18 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0F8504C96C4;
	Fri, 09 Jan 2026 09:34:17 +0000 (UTC)
Date: Fri, 9 Jan 2026 10:34:17 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH can v2] can: gs_usb: gs_usb_receive_bulk_callback(): fix
 URB memory leak
Message-ID: <20260109-corgi-of-massive-art-abe72a-mkl@pengutronix.de>
References: <20260105-gs_usb-fix-memory-leak-v2-1-cc6ed6438034@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qv5uwemshev6tpyd"
Content-Disposition: inline
In-Reply-To: <20260105-gs_usb-fix-memory-leak-v2-1-cc6ed6438034@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--qv5uwemshev6tpyd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can v2] can: gs_usb: gs_usb_receive_bulk_callback(): fix
 URB memory leak
MIME-Version: 1.0

On 05.01.2026 13:35:54, Marc Kleine-Budde wrote:
> In gs_can_open(), the URBs for USB-in transfers are allocated, added to t=
he
> parent->rx_submitted anchor and submitted. In the complete callback
> gs_usb_receive_bulk_callback(), the URB is processed and resubmitted. In
> gs_can_close() the URBs are freed by calling
> usb_kill_anchored_urbs(parent->rx_submitted).
>
> However, this does not take into account that the USB framework
> unanchors the URB before the close function is called. This means that
                               ^^^^^
                               complete

I've fixed it in my tree.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qv5uwemshev6tpyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlgy5YACgkQDHRl3/mQ
kZwgkgf+MWbPiXPJJAcxBDnav8A43ecX3Dgz9TPWd9qSDjaN5wcQY/SlmWbo+38B
BpN5MKkOm3XTsF2K6MEMi4bh50raC2rqKRRaSpbHVd1vGh8Nonm9CsEQvO8o/dfT
Wi7RVEUjTqLhC9JgivaWgp57Uwxm4zdCEaIICMgkBH2aV653Hzvpz8fjSDxLV2Js
SnzfUToAG0dFZWNxy7rV92R+WRGgPOpdKWENE8d6F/2qo8cvegwRAxphWQd40yBH
ZaT2sPeoLQ85qv1S4+BKy/plczkZNlhxd16oYYKGvcN9L2eFnrGqydPf1nQM3A+H
mSy+X49pymouLbaVVTmhm5AHb7l4TA==
=LK1S
-----END PGP SIGNATURE-----

--qv5uwemshev6tpyd--

