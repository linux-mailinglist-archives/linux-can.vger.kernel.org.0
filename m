Return-Path: <linux-can+bounces-2607-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E24CA0B43E
	for <lists+linux-can@lfdr.de>; Mon, 13 Jan 2025 11:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D327A5265
	for <lists+linux-can@lfdr.de>; Mon, 13 Jan 2025 10:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F88120458D;
	Mon, 13 Jan 2025 10:13:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BE31FDA9C
	for <linux-can@vger.kernel.org>; Mon, 13 Jan 2025 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763180; cv=none; b=qMagqcUFDB7s8hCzNlkrnBFqETawnbSokUPjYzp9ROjz9ZGDBGdMzreej/uWyqtkM1UpOzAkgNSB5kleJW8V5X617tpznE8ufMlmLK8RFwA4tEdXw1pS60Q+ZC8W921kaKWKzAqjuw2IZK36EVgUas6qUDOLW4lcNUOaf+IL6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763180; c=relaxed/simple;
	bh=aSlU/XU7Gw9vwATkxMVfaJHI9YBD7QlnksgCXz3qbtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjDGnAIq0P5zxZQvwO8O/FH6wvzVBLDKNm0q0dEwENDhq8Ih04QIC5L0EGn0DGH9tchq9o/Yj34X4prQRB5Mct8oWuHSCqTykEz0YpOF7o4TZ9tXg6PHC+FHdeNv7w/jvofTRwTFZkNklwFXWcn4srX+GzhoTxpqYWwbvR8Aw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tXHRA-0003rW-Dw; Mon, 13 Jan 2025 11:12:48 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tXHR8-000Ere-1K;
	Mon, 13 Jan 2025 11:12:46 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 369573A60B6;
	Mon, 13 Jan 2025 09:52:33 +0000 (UTC)
Date: Mon, 13 Jan 2025 10:52:32 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	mailhol.vincent@wanadoo.fr, linux-can@vger.kernel.org
Subject: Re: [PATCH net-next] can: grcan: move napi_enable() from under spin
 lock
Message-ID: <20250113-outstanding-bronze-kestrel-d0927f-mkl@pengutronix.de>
References: <20250111024742.3680902-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w3ictz64yuvhjsen"
Content-Disposition: inline
In-Reply-To: <20250111024742.3680902-1-kuba@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--w3ictz64yuvhjsen
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] can: grcan: move napi_enable() from under spin
 lock
MIME-Version: 1.0

On 10.01.2025 18:47:42, Jakub Kicinski wrote:
> I don't see any reason why napi_enable() needs to be under the lock,
> only reason I could think of is if the IRQ also took this lock
> but it doesn't. napi_enable() will soon need to sleep.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Marc, if this is correct is it okay for me to take via net-next
> directly? I have a bunch of patches which depend on it.

Yes, please take it via net-next directly.

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--w3ictz64yuvhjsen
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmeE4l4ACgkQKDiiPnot
vG9HeAf+KWsa4lVfcia7SK0/l4aQ9itqxlDjwiV3UfE+FgzC+gb+dg1v8ZWEICMx
+2By71lhY3hYIS+H6vltiAIRNPHX2x0nZNe1HTdECwrA1rJxa9P7SkYpkF5DRnjP
XX6bgn4Rln0/jXF+eo3q//3wXNFWh/qs5ir1vzAvlkI2bPTWrlCkKVTiF0nlZRXM
Kl6Jjq6UNoAVLCZHH0UIgzcTZ4ER/PnVZS+pEw/kfCu4F6T3VXxBKemG1TfYy9DH
ZeB6524+h9uI61RY+oI7cQ6eDS7IkpT/B7yGSdxsssSlEnY/54I7lUubq9uzpO/K
eMYIcm3empQmdvvOiS+1MjnX9lBYAA==
=BQhA
-----END PGP SIGNATURE-----

--w3ictz64yuvhjsen--

