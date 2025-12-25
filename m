Return-Path: <linux-can+bounces-5938-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4692CDDD7F
	for <lists+linux-can@lfdr.de>; Thu, 25 Dec 2025 15:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 819E230124F5
	for <lists+linux-can@lfdr.de>; Thu, 25 Dec 2025 14:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80B1314D07;
	Thu, 25 Dec 2025 14:07:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA88314B69
	for <linux-can@vger.kernel.org>; Thu, 25 Dec 2025 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766671665; cv=none; b=W+hII06N/14ovAJ5PC7iCPeNpJaLBrbx5puAATrXftzvJGYv1KRLA1nsCNOVFpJU1haNE+IYBAvbQ7FKdj8ng8opgO6nT23NKB7OSzt4d0BICxDvY8id5I6G4yZsE3ZTGwYxTgYUMK/j3fmR2cYW+bqlqtiRiG8BYGNmci9pa9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766671665; c=relaxed/simple;
	bh=Nk42kE/GnI9S9aDy/f94+uej0h0ib2Dcs896RavQ3Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XusHtxX2TNGG2nP8zl1c7hxIaDbe+vZQsRrWJqQ0YVrLfqXySxoFqTcJtu8pI8Pfc8cDBbh8AwsI7TXiTKZUM5x6IKSe9C1OQ8eYHurRCP4f9nzAxfdqzzpl0+osB3YVpDAwOxm8WMnkIG0Po+FVFXm7BgfiOL68YXWPUqmsJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vYm0E-0006hG-6U; Thu, 25 Dec 2025 15:07:42 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vYm0D-007QK3-3D;
	Thu, 25 Dec 2025 15:07:42 +0100
Received: from pengutronix.de (2a02-8206-2427-4700-1e0b-5707-3eab-e71d.dynamic.ewe-ip-backbone.de [IPv6:2a02:8206:2427:4700:1e0b:5707:3eab:e71d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 99C574BEB33;
	Thu, 25 Dec 2025 14:07:41 +0000 (UTC)
Date: Thu, 25 Dec 2025 15:07:41 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH can] can: gs_usb: gs_usb_receive_bulk_callback(): fix URB
 memory leak
Message-ID: <20251225-jasmine-viper-of-eternity-36dcac-mkl@pengutronix.de>
References: <20251225-gs_usb-fix-memory-leak-v1-1-a7b09e70d01d@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pj7fbaxphmnxcokh"
Content-Disposition: inline
In-Reply-To: <20251225-gs_usb-fix-memory-leak-v1-1-a7b09e70d01d@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--pj7fbaxphmnxcokh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can] can: gs_usb: gs_usb_receive_bulk_callback(): fix URB
 memory leak
MIME-Version: 1.0

On 25.12.2025 15:05:43, Marc Kleine-Budde wrote:
> In gs_can_open(), the URBs for USB-in transfers are allocated, added to t=
he
> parent->rx_submitted anchor and submitted. In the complete callback
> gs_usb_receive_bulk_callback(), the URB is processed and resubmitted. In
> gs_can_close() the URBs are freed by calling
> usb_kill_anchored_urbs(parent->rx_submitted).
>
> However, this does not take into account that the USB framework
> unanchors the URB before the close function is called. This means that
> once an in-URB has been completed, it is no longer anchored and is
> ultimately not released in gs_can_close().
>
> Fix the memory leak by anchoring the URB in the
> gs_usb_receive_bulk_callback() to the parent->rx_submitted anchor.
>
> Fixes: f16623a04943 ("can: gs_usb: fix")

That should have been:
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices=
")

fixed in v2 + add stable on Cc.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pj7fbaxphmnxcokh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlNRSoACgkQDHRl3/mQ
kZz9Nwf/awqBaoB4GDd0ZmgUNAx4N56D/2VVRCBUYC3yGR2tjSeGmynGILFiyvf/
9QVR3gVpz2TJe463ZXSnKvwl2k8k8M5/nrQouCOfBh6dyJA1Pl21fN2ojtp0UHts
kpgOaS2LZEA8EPU8OHmN+pp+BiTAccLwadN9flCgX/CckIu4BoJR3t81T5PQJ1xY
XXlpNDR51wqhIutW/dtFzIg8XOSLm5+nXTfoVFmmovrzyHucOsf864sG7TeW4w6k
jZtYhCGrfX8HQrkYT1iVLn4OXSnICqHYwAg4MA+o8i8vuDj6UyN9QszMhKp5IeY/
t0CFhCDI6zXX757E4t4+eXm7A8ARGA==
=XbJx
-----END PGP SIGNATURE-----

--pj7fbaxphmnxcokh--

