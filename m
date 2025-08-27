Return-Path: <linux-can+bounces-4379-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A8EB37C2D
	for <lists+linux-can@lfdr.de>; Wed, 27 Aug 2025 09:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F3CB7A5BBC
	for <lists+linux-can@lfdr.de>; Wed, 27 Aug 2025 07:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9A03148C4;
	Wed, 27 Aug 2025 07:49:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059D2749D7
	for <linux-can@vger.kernel.org>; Wed, 27 Aug 2025 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280975; cv=none; b=REzMOYtzlicVs7lwipcm7hCJukKKFJPy60yDH2TN7/MqCQitIHLQX8r52VR3sbm9cw7orHvih07g20vsLFsbYRp3mQ47pgakBLLbwD1ZnM693UNqwyHOJT0w2gfVp+SS8YkkxtsnRhf5M9kocE64g7VpaNK5HS99YATxTo/dDLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280975; c=relaxed/simple;
	bh=VcO2mA3r3AuhPb3tjISs7ZOhpMjbS7Bm61eiWNbKoBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AW8UfwI/hv17L42iqWYCuzdzM6hEg5uPsQCNuJa1YPjnVcYP4rpNfUChK0+D00kdXJb3e+WVPDi04NYMvTzCov1V4GBp26t9A0HIUKNS1oH+tqRLBnpTqh4DzYCBMesWwOoNBv+GzzZHooAOEOs+vefu+IXMDNLk7cNdUk7zhUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1urAuS-00025y-Hq; Wed, 27 Aug 2025 09:49:32 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1urAuS-002MHx-19;
	Wed, 27 Aug 2025 09:49:32 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AECC445ECD2;
	Wed, 27 Aug 2025 07:40:17 +0000 (UTC)
Date: Wed, 27 Aug 2025 09:40:16 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: mailhol@kernel.org
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Vincent Mailhol's email address
Message-ID: <20250827-winged-bizarre-mackerel-a91272-mkl@pengutronix.de>
References: <20250826105255.35501-2-mailhol@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x7y5plluoqutyj6f"
Content-Disposition: inline
In-Reply-To: <20250826105255.35501-2-mailhol@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--x7y5plluoqutyj6f
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: update Vincent Mailhol's email address
MIME-Version: 1.0

On 26.08.2025 19:48:39, mailhol@kernel.org wrote:
> From: Vincent Mailhol <mailhol@kernel.org>
>=20
> Now that I have received my kernel.org account, I am changing my email
> address from mailhol.vincent@wanadoo.fr to mailhol@kernel.org. The
> wanadoo.fr address was my first email which I created when I was a kid
> and has a special meaning to me, but it is restricted to a maximum of
> 50 messages per hour which starts to be problematic on threads where
> many people are CC-ed.
>=20
> Update all the MAINTAINERS entries accordingly and map the old address
> to the new one.
>=20
> I remain reachable from my old address. The different copyright
> notices mentioning my old address are kept as-is for the moment. I
> will update those one at a time only if I need to touch those files.
>=20
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

Applied to linux-can-next.

BTW: The "From" header of your mail only contains you e-mail address,
not your real name.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--x7y5plluoqutyj6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmiutl0ACgkQDHRl3/mQ
kZwuvggAsuU56iTV6Si4It0cvBLYDjjga6dcOWUJjkiTRtzcQQFVWogQ2Tvym4he
T5vjXXbcCrccNBvGhcpBqlhUbNK+5k5Jm8TxBnajFX7lZwq3RbJE+yKc3TT+Qpu3
b8LRrrLrFs9GyVYcSzoTYrQZQ1prNTcynqfonanyFj39mK5H5dkC08YttKHOO4jo
FzPJQeFHgJlhN8L4qzE0kCJlfVqYy8dt+dx7M3eUwxYoNTLPOFN5gXpc4iXL1dVl
Od3TRCDExLcByWP+reZq2BPtZcRmE5BMAt1cOLVvs4hYjHmGaloj+K51pcWtGPGW
0oNxuO9ZeHQ4LlyJPQqG1sidkmc0fA==
=ERBZ
-----END PGP SIGNATURE-----

--x7y5plluoqutyj6f--

