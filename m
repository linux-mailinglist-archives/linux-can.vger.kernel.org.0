Return-Path: <linux-can+bounces-3808-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E06CCAD54E2
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 14:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0010189CF11
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 12:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478F225BF01;
	Wed, 11 Jun 2025 12:02:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A318DB2B
	for <linux-can@vger.kernel.org>; Wed, 11 Jun 2025 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643375; cv=none; b=SFj4/h8YcjOG//dFJBrt+PXcBMDP7Co2f5UPJZP8SKrvP+dhelxRBwGi1DHnrCS0WrxbuPWVdsepEAR1rwoCj9OCKvEOaMCws3mciq3c79n+gusYZKVNQD6P0MXX0DVNHUQ6maNjhHe4gq6/I4kF+3sAppbWvL5K1dSmLoDyBFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643375; c=relaxed/simple;
	bh=oFNB79qBPSDfa8chQTC5qVURASHgLB/3n9yFcA+/Uyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwCU+Mg88Nt8uWP6y4cesD4EvTs7SK9J1A7JI2P5CyZ+fFi5OOCKBNX0lfg6oijblf2+g4JSS2NWQSjfsvZ6EXYR35uGvT33B/bK4yEkGJfN3lwvTiu1eZNkp+/UV8IWfd3SgnCG/sx/RQUOKbftOf+c6+ohngrPB4J2tfrXFAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uPKAF-0007OZ-3R; Wed, 11 Jun 2025 14:02:43 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uPKAE-002wOd-27;
	Wed, 11 Jun 2025 14:02:42 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 53DE14253C1;
	Wed, 11 Jun 2025 12:02:42 +0000 (UTC)
Date: Wed, 11 Jun 2025 14:02:40 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [PATCH 02/11] can: netlink: replace tabulation by space in
 assignment
Message-ID: <20250611-wild-glaring-scallop-cf68e7-mkl@pengutronix.de>
References: <20250527195625.65252-1-socketcan@hartkopp.net>
 <20250527195625.65252-2-socketcan@hartkopp.net>
 <20250528-quirky-ultra-hawk-37000f-mkl@pengutronix.de>
 <77c5a904-8b2c-4a78-890d-2777ddefe250@wanadoo.fr>
 <20250528-bronze-penguin-of-joviality-0ce1a8-mkl@pengutronix.de>
 <20250611-just-degu-of-virtuosity-933b17-mkl@pengutronix.de>
 <e2ae158d-eb43-4883-b4c3-90fd23d1ee1f@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kinnvzfzu7nrs4zg"
Content-Disposition: inline
In-Reply-To: <e2ae158d-eb43-4883-b4c3-90fd23d1ee1f@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kinnvzfzu7nrs4zg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 02/11] can: netlink: replace tabulation by space in
 assignment
MIME-Version: 1.0

On 11.06.2025 20:29:32, Vincent Mailhol wrote:
> Yes, I=C2=A0saw the pull request.
>=20
> I=C2=A0actually started to tidy up my previous work. So nice timing.
>=20
> For the next step, I plan to split the CAN-XL series in two:
>=20
>   1. One more preparation series that will do all the netlink.c refactor
>=20
>   2. The actual stuff that will modify the uapi and add the CAN XL netlink
>      interface
>=20
> For point 1., it will be patch 6 to 11 and patch 13 of the original RFC:
>=20
> https://lore.kernel.org/linux-can/20241110155902.72807-16-mailhol.vincent=
@wanadoo.fr/
>=20
> Actually, I already have it ready in my local tree, I just need to double=
 check
> before sending.

nice, looking forward for this.

> I intend to have the preparation series 1. merged first before sending se=
ries 2.

makes sense

> On a different topic, I=C2=A0know have my kernel.org account. I do not kn=
ow what is
> the most convenient for you, but I could also create my own branch on
> git.kernel.org. Or, if gitolite allows it, maybe you can give me write ac=
cess to
> your b4/can-xl branch? (I didn't check yet what gitolite offers in term of
> access control=E2=80=A6)

I haven't checked access control, but it's faster/easier if you create a
b4/can-xl branch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kinnvzfzu7nrs4zg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhJcFwACgkQDHRl3/mQ
kZwy+gf/R1pcYTdOSDcSKhEA71Yxb58UIteBdrL127fzjjHCr3MukGLtsWwIjYQY
fmpZu1j8oKp13Eq4eoPRYDnz9ktMhAl33hWdmOA58/YxaIRIwzBDpVakot3fA3Jp
H/CAeTpafnL2Zs131rgN284FCPk8oAWo0WPt3VfKDfoqGGSzP8loKgDWAjf0/gAp
/0rOqK2VE5QMwQEHt7RMbGIdRI6zQfV2yUPUeeaIpcnHFzFyz8oKeA/99HNLaGbf
VM7y6dJduHcgYxKWeapLr66LDBVvZxyVCMvSbjD+NzIjgC8Xo1h2+NBqnEwWY7C3
vsVtknFDd8hGf4MN1y1NZ9ARqhdkSw==
=FQUK
-----END PGP SIGNATURE-----

--kinnvzfzu7nrs4zg--

