Return-Path: <linux-can+bounces-2569-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74644A08E2D
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 11:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DEE3A5375
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 10:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5681D20ADE7;
	Fri, 10 Jan 2025 10:38:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A120ADC9
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505530; cv=none; b=Ttxq0R8cwr6TYrHIX+izj+SrTLW+PemfTOVaMUnLZ7iGTqee074zx94XzPgQ0zRFRAE86fPSB1GJbWr3yUbXv5aQ5Fh4xWrXmK739KBSJ4f+mMVuRMBKzz8kEHydLAXs1wd6RafDndofs+4L4/lSqpNzE36mq36uOIFi05E2kKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505530; c=relaxed/simple;
	bh=GW09V2pfyiQzvT0ieJ622MwI66BI+LwvRPjyU+e/Vd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ycw0IW7DemldAql/cflVRnrzkJh2BuNCL3qNsdorQnFHrjFTgWcXnIM8r03NejTc9St4knwfop28XZBS82S8ORY5IgXiLGtF2XOkbAujw4KUCcxJlPSxm7GJQ4Qpwu790/pxfE6TcV2CFbV9ApG7guhjr6rDmymrX+nhQ2gxnyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWCPe-0000m6-Mj; Fri, 10 Jan 2025 11:38:46 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWCPe-0008zs-1K;
	Fri, 10 Jan 2025 11:38:46 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0D3493A4519;
	Fri, 10 Jan 2025 10:38:46 +0000 (UTC)
Date: Fri, 10 Jan 2025 11:38:45 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Jimmy Assarsson <jimmyassarsson@gmail.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH 1/4] can: kvaser_usb: Update stats and state even if
 alloc_can_err_skb() fails
Message-ID: <20250110-quantum-bug-of-rain-8c2ca8-mkl@pengutronix.de>
References: <20241230142645.128244-1-extja@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jcdigyyc3kojy5j7"
Content-Disposition: inline
In-Reply-To: <20241230142645.128244-1-extja@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--jcdigyyc3kojy5j7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/4] can: kvaser_usb: Update stats and state even if
 alloc_can_err_skb() fails
MIME-Version: 1.0

On 30.12.2024 15:26:42, Jimmy Assarsson wrote:
> Ensure statistics, error counters, and CAN state are updated consistently,
> even when alloc_can_err_skb() fails during state changes or error message
> frame reception.
>=20
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>

Applied all patches to linux-can-next.

As I'm merging series to linux-can(-next), it would be nice to have a
cover letter the summarizes the series for future contributions. b4 will
automatically include it in the merge commit.

Regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jcdigyyc3kojy5j7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmeA+LIACgkQKDiiPnot
vG8AVwf+NKDeotmKgjrOsM/JF7etsRpl08VVJdaM3aPH07qAGt24PopjK+/Mh6Xu
eBfYu5rSFqYWFDaH19UlKBRmkmzhNK9ZLjNROsMJHr7vl7y/Br9GPILDZbwgaoZ8
hO1B66fVyTHB0qGwcNk7LrcTv6+BOyaIu6VYjJ6wiO9z+rsR9vWWHkfoI7jtS8CS
VNZpDnalY/tM1Ym2Ui6R4ukvczfb7S5pBnitQtYG4wNmK7zmh4WiH4CXi3HouGuS
ApGz1MT6NUX5abPUo9OsMYIJueaVkii0Os/NRYnV/jMmo7f17aXvWdJjOSs+TOw5
hzvsPJA8Sl1E4uXSXQeUuF1YgvFAzw==
=+0W2
-----END PGP SIGNATURE-----

--jcdigyyc3kojy5j7--

