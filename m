Return-Path: <linux-can+bounces-5395-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D324BC5CBD1
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 12:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 801A6342388
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 11:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378D52882A9;
	Fri, 14 Nov 2025 11:01:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0AE14AD20
	for <linux-can@vger.kernel.org>; Fri, 14 Nov 2025 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763118110; cv=none; b=WFf1w3ZraKM/DQ01xFjgCqDnehpXE6sjCwLLywQFj4xhT8xA8qCLQQ4mKV9uDF46mMUdEhzLq01TPPN/VJVaeWHEyCY2sCKoIDInOKA3oa1muqAohQEA6JIRGo5wyeUvG9jdH4LbosbHynJjnRrXDqPI/7j7oBehmwpAQy4LVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763118110; c=relaxed/simple;
	bh=qxQRkqbCk/eUT2fdiKshEvmipNmgb1luApUH64A7ymE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3nXVLQDil9ngVnqjFDNSBI2Oah/Fkgy9BUfc+UHXhYPGMYhnD+SAu/vrqPP7lTiflptf0ZacQP/UR7D6b3ytUx2lG07H87vukF16mGGUDFulveuVKKFb0c7NAemSijdYjE64+BtmFwNS9KJMsV1aM7zhSmEh1u+jSWrOVnG7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJrYL-0001Cr-Kr; Fri, 14 Nov 2025 12:01:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJrYK-000PGR-0s;
	Fri, 14 Nov 2025 12:01:16 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CE67A49F467;
	Fri, 14 Nov 2025 11:01:15 +0000 (UTC)
Date: Fri, 14 Nov 2025 12:01:15 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: zhangqing <zhangqing@rock-chips.com>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org, 
	conor+dt@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	cl@rock-chips.com, kernel@pengutronix.de, krzk+dt@kernel.org, 
	mailhol.vincent@wanadoo.fr
Subject: Re: [PATCH v9 3/3] net: can: rockchip: add can for RK3576 Soc
Message-ID: <20251114-utopian-cheerful-otter-33c1d5-mkl@pengutronix.de>
References: <20251113075419.482940-1-zhangqing@rock-chips.com>
 <20251113075419.482940-4-zhangqing@rock-chips.com>
 <20251113-slim-foamy-gecko-2dc389-mkl@pengutronix.de>
 <176d96b4-397c-49d4-8e8e-2f77a5d59c12@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7qbjzmaz2uefdur2"
Content-Disposition: inline
In-Reply-To: <176d96b4-397c-49d4-8e8e-2f77a5d59c12@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--7qbjzmaz2uefdur2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 3/3] net: can: rockchip: add can for RK3576 Soc
MIME-Version: 1.0

On 14.11.2025 17:55:53, zhangqing wrote:
> > > +/* The rk3576 CAN-FD */
> > > +static const struct rkcanfd_devtype_data rkcan_devtype_data_rk3576 =
=3D {
> > > +	.model =3D RKCAN_MODEL_RK3576,
> > > +	.quirks =3D RKCANFD_QUIRK_CANFD_BROKEN,
> > Is CAN-FD mode broken on the rk3576?
> >
> > Please test CAN-FD and please do the tests documented near the
> > definition of RKCANFD_QUIRK_CANFD_BROKEN:
> >
> > | Tests on the rk3568v2 and rk3568v3 show that receiving certain
> > | CAN-FD frames trigger an Error Interrupt.
> > |
> > | - Form Error in RX Arbitration Phase: TX_IDLE RX_STUFF_COUNT (0x0a010=
100) CMD=3D0 RX=3D0 TX=3D0
> > |   Error-Warning=3D1 Bus-Off=3D0
> > |   To reproduce:
> > |   host:
> > |     cansend can0 002##01f
> > |   DUT:
> > |     candump any,0:0,#FFFFFFFF -cexdHtA
> > |
> > | - Form Error in RX Arbitration Phase: TX_IDLE RX_CRC (0x0a010200) CMD=
=3D0 RX=3D0 TX=3D0
> > |   Error-Warning=3D1 Bus-Off=3D0
> > |   To reproduce:
> > |   host:
> > |     cansend can0 002##07217010000000000
> > |   DUT:
> > |     candump any,0:0,#FFFFFFFF -cexdHtA
> There is no doubt about the other modifications above. They will be
> corrected in version V10.
>
> CANFD requires authorization and is not supported by default.

Can you explain what you mean by authorization? What do you mean by "not
supported"?

> After obtaining authorization, it can be used, so this place is not
> considered broken.
> What's the best way to handle this situation?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7qbjzmaz2uefdur2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkXC/gACgkQDHRl3/mQ
kZxHpwgAkC5up5LxQ0M/i45TK5HrheSKwaAeoDS/jf4rhHzNBY1cctV7AE15Su8a
Hl3AFmclsThC1Mk1cny/1hCPVZ0t8vWE2NxcZkQdJ1YUMqPhMCgl9PP9RnYl5EZg
bDb71An58FEBd4O0I9Oiwf/5uIsvnJKli71TDwkGWbzLJPuveX5UXJgwzPrpWkvn
iU3+gPOuLHVTq+xWZdWSCSJ9M5R13HXyI3V35vfbvBLHuspYiaFknMmZd3X+5Yhy
eQUHAk9DS67Pkp/0UNm7eYWXwj0DVHI2cffJD/JL8eaZ+iy6rS/8mmAC91gX8PRZ
YIsN5HiZiINF0lao5T2d+ddcKBH/3w==
=Nqc9
-----END PGP SIGNATURE-----

--7qbjzmaz2uefdur2--

