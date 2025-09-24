Return-Path: <linux-can+bounces-4972-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1699B9A8E2
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 17:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8CF3A94CE
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 15:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862DF30FF13;
	Wed, 24 Sep 2025 15:13:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491DA30C615
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726801; cv=none; b=LD7h3IawBs7IWBFPs2o83EULVfYpqT/IDqIacR5s5WmDkiukuej+rwPM+koKp7XSmO+fjpDE94Ct3omeY73TPY7nrxkYXd/FOuqbwLXrqZ+vtt9Tz1TA/BmwH4vJy0+QP3HV4e9gr++6HCFuYMIpE+594LEGIB/NEoU/pCR+F5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726801; c=relaxed/simple;
	bh=d5WdCjL+KLMcdfoEj3LjFIZq/32CnK9rsIrugyz6h6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ws26Zx2vLdl+Ljph/vlMISxItZ37/XJIZjz3OIpncRe+L159qYUd0fmcg6XZSv+tkkEobCarB5MD3fp2/0wIMJQjAbWrCfNvpqFcDrA9qSQJzdDBOv1vV6mgVLtqHuocgtRzXu5EQ5E8VlqVCQGPh7MFHtIM6YyfLEVtGNspw8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1RB2-0007z8-Re; Wed, 24 Sep 2025 17:13:04 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1RB0-000H7u-0f;
	Wed, 24 Sep 2025 17:13:02 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C7A50478E7A;
	Wed, 24 Sep 2025 15:13:01 +0000 (UTC)
Date: Wed, 24 Sep 2025 17:13:01 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, syzbot ci <syzbot+ci284feacb80736eb0@syzkaller.appspotmail.com>, 
	biju.das.jz@bp.renesas.com, davem@davemloft.net, geert@glider.be, kernel@pengutronix.de, 
	kuba@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	stefan.maetje@esd.eu, stephane.grosjean@hms-networks.com, zhao.xichao@vivo.com
Subject: Re: [PATCH] can: dev: fix out-of-bound read in can_set_default_mtu()
Message-ID: <20250924-monumental-impartial-auk-719514-mkl@pengutronix.de>
References: <68d3e6ce.a70a0220.4f78.0028.GAE@google.com>
 <20250924143644.17622-2-mailhol@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bje7xa3t5opp4lec"
Content-Disposition: inline
In-Reply-To: <20250924143644.17622-2-mailhol@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--bje7xa3t5opp4lec
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: dev: fix out-of-bound read in can_set_default_mtu()
MIME-Version: 1.0

On 24.09.2025 23:35:44, Vincent Mailhol wrote:
> Under normal usage, the virtual interfaces do not call can_setup(),
> unless if trigger by a call to can_link_ops->setup().
>=20
> Patch [1] did not consider this scenario resulting in an out of bound
> read in can_setup() when calling can_link_ops->setup() as reported by
> syzbot ci in [2].
>=20
> Replacing netdev_priv() by safe_candev_priv() may look like a
> potential solution at first glance but is not: can_setup() is used as
> a callback function in alloc_netdev_mqs(). At the moment this callback
> is called, priv is not yet fully setup and thus, safe_candev_priv()
> would fail on physical interfaces. In other words, safe_candev_priv()
> is solving the problem for virtual interfaces, but adding another
> issue for physical interfaces.
>=20
> Remove the call to can_set_default_mtu() in can_setup(). Instead,
> manually set the MTU the default CAN MTU. This decorrelates the two
> functions, effectively removing the conflict.
>=20
> [1] can: populate the minimum and maximum MTU values
> Link: https://lore.kernel.org/linux-can/20250923-can-fix-mtu-v3-3-581bde1=
13f52@kernel.org/
>=20
> [2] https://lore.kernel.org/linux-can/68d3e6ce.a70a0220.4f78.0028.GAE@goo=
gle.com/
>=20
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
> @Marc, please squash in
>=20
>   [PATCH net-next 27/48] can: populate the minimum and maximum MTU values

I've not changed the commit message of "can: populate the minimum and
maximum MTU values", just added the note that I've squashed this fixup
patch.

I've created a new tag: linux-can-next-for-6.18-20250924

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--bje7xa3t5opp4lec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjUCnoACgkQDHRl3/mQ
kZxSpwgAtkAzMP/MbF0LK+TUgUVBCCK/Oq6V0QJF1DzbCeoJREAghWi2PVSE7xcK
Bhp9v5tJFtzX+nlncVcR5umFmnltrowKA1OuAivnBl7jTMp/COWddvGOJ/nTIq1j
bLLCtyTlfRaM6VgK92IH3PgpPRL9rh+yi38dFTeyPDy9yV0YcjmbDd+1+KFigeA5
WDoz4vcHjsLDazkIiaRJ00x3ub+W6z4m+OoY1aav5ALt6l1i6l9xWWdqXlSyba/9
12oEaDXvaEsR7auAxmTF8OCG6OljKIwDOUsfkMDrAdof/UDO/O6B10DY44EYLbsO
PJfwUzrIkNb7ND9FPTbkb9Vss7tg5A==
=CWNe
-----END PGP SIGNATURE-----

--bje7xa3t5opp4lec--

