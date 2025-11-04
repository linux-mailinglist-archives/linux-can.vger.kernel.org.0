Return-Path: <linux-can+bounces-5310-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAB2C2F9C8
	for <lists+linux-can@lfdr.de>; Tue, 04 Nov 2025 08:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDC5A34AB9A
	for <lists+linux-can@lfdr.de>; Tue,  4 Nov 2025 07:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6A1306B08;
	Tue,  4 Nov 2025 07:28:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0593064BD
	for <linux-can@vger.kernel.org>; Tue,  4 Nov 2025 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241316; cv=none; b=MiYzklSVHWZmp+YxflWOAJWeDvT521TxvHlo5sSW3NW/GTxQr+ol4R6Y2gZA5lxxetN3Tq4GnePaZ2oJCdE7UJLm0UYFULATXWGsuO7NgfcboM05CaMwP6musY4iQ52mIMZu6jDt2Or6xgVo11q43aSjLzXzywjFWY0YBYWndEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241316; c=relaxed/simple;
	bh=xY8C59ne4nJrNHOw5nf8AFiWEY75bZlmLVFOlPB54kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7eG228y8CoP0QgSt0XXiWHb7wi9GbaD1uvJgCOcU6yBULU957JcpbNzNChkMQX4PGCtW503jnABbcezP21Zx3CvzpiX86IGj4XrCXincLsKgk/YxBD7R+ueiizZ7MgRnheT69nkOueNfmmVZv5+pI91Bxc21ZQ7OEZ3vNuDtCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vGBSp-0007MQ-Mb; Tue, 04 Nov 2025 08:28:23 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vGBSo-006zRE-2m;
	Tue, 04 Nov 2025 08:28:22 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8540A49650B;
	Tue, 04 Nov 2025 07:28:22 +0000 (UTC)
Date: Tue, 4 Nov 2025 08:28:20 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>
Subject: Re: [PATCH v2 00/10] can: netlink: add CAN XL
Message-ID: <20251104-refined-winged-mamba-fd8cc1-mkl@pengutronix.de>
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
 <743ba133-3735-48fd-994a-9727cfe8c114@hartkopp.net>
 <69303466-a9ed-44cb-a1a9-30ac1451e7cb@kernel.org>
 <3d7521ba-bd71-46b0-9642-728a5222f2d6@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="76szl2xanxjuykrx"
Content-Disposition: inline
In-Reply-To: <3d7521ba-bd71-46b0-9642-728a5222f2d6@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--76szl2xanxjuykrx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 00/10] can: netlink: add CAN XL
MIME-Version: 1.0

On 03.11.2025 20:15:59, Oliver Hartkopp wrote:
> > I just sent
> >
> > https://lore.kernel.org/linux-can/20251102-pwm_sample_point-v1-0-3bbea1=
80f59e@kernel.org/
> >
> > to address the problem. Let me know if this works in your test environm=
ent and I
> > will merge it to the main series.
>
> Very elegant solution. I started some coding into this direction too.
> Good that I didn't post it ;-)
>
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
>
> For the series. The 'nominal' left over was also a good improvement.

Can you post your tags under the cover letter, so that b4 will pick it
up automatically?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--76szl2xanxjuykrx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkJqxEACgkQDHRl3/mQ
kZx0iQf/Yrhyt7EU9Jvsq4XkboVN330KXIvD2yySWr/nitUOMVptsnWxV16pEOVN
HMM30w2fzh4jqVL+mAODHPjK0fcnPKW8OJ0XOgaVvGpVOVvBToE6scb6DP85TcmU
jGyA4mcJ4zImpTcngCHMGvRRji9E326rl4qNuLJOCSL4WVPSVpxSwzCj9rQ7fGLt
VWbwu2MQGLosIib54veNES2ZKdYRvxQ3XDac/LrT1Sx9ThgY5wdO/H2OQPQwX4pn
ThyAEiDTWqLq4JrbDNwwqclq6Eh5gH60U4vcAC9aI5vJs8duEInVveBDROXVTBnJ
p3OlBtI/exz8P9TB1ddIkum30GCmQQ==
=c6+E
-----END PGP SIGNATURE-----

--76szl2xanxjuykrx--

