Return-Path: <linux-can+bounces-5398-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A40FC5D58D
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 14:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80AA5345611
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AA7315777;
	Fri, 14 Nov 2025 13:23:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A31C314D39
	for <linux-can@vger.kernel.org>; Fri, 14 Nov 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126584; cv=none; b=lakBWjzd8vsceaSVjpg6SGnoAjeiP/V7mrB/ivnm8ulb1TLfJUD15pmo15Dxq6VSfI3/tj9rtboCsvCUpzBdGTWf+7jsueo2ew54p2yAuVGqH453ICkeLsRsxeP7crPz6wEehsZSO5RCJ19TICsVMUukxC+KnKnjRiV69oKI+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126584; c=relaxed/simple;
	bh=eShN4Ob6yWOBP8ZKZQ3V71WXPtkYdhIepRwN9uTkl7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgR2WveVQp+p9b3HDGPf4ILbbLQvu+lK955jCJEH1gVjCedJl+P1OlYf8fEhwdFE9EOOPCUXPb0EoP9PyOWhZPE0o8+yaEWRcQ4/yNUCMgAUROPk2I/C3Gfvz157FvAe58yYOhaykt/PjB5RcIeXeF3DjQdb2M6tiS9nbbwiNCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJtlF-0003Gu-9f; Fri, 14 Nov 2025 14:22:45 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJtlD-000QjO-0z;
	Fri, 14 Nov 2025 14:22:43 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E3F1E49F5AE;
	Fri, 14 Nov 2025 13:22:42 +0000 (UTC)
Date: Fri, 14 Nov 2025 14:22:42 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: zhangqing <zhangqing@rock-chips.com>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org, 
	conor+dt@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	cl@rock-chips.com, kernel@pengutronix.de, krzk+dt@kernel.org, 
	mailhol.vincent@wanadoo.fr
Subject: Re: [PATCH v9 3/3] net: can: rockchip: add can for RK3576 Soc
Message-ID: <20251114-illegal-flounder-of-maturity-edc269-mkl@pengutronix.de>
References: <20251113075419.482940-1-zhangqing@rock-chips.com>
 <20251113075419.482940-4-zhangqing@rock-chips.com>
 <20251113-slim-foamy-gecko-2dc389-mkl@pengutronix.de>
 <176d96b4-397c-49d4-8e8e-2f77a5d59c12@rock-chips.com>
 <20251114-utopian-cheerful-otter-33c1d5-mkl@pengutronix.de>
 <3233894e-9409-4b74-a954-0b30064c3c8c@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qaousal5vpe3w2e4"
Content-Disposition: inline
In-Reply-To: <3233894e-9409-4b74-a954-0b30064c3c8c@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--qaousal5vpe3w2e4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 3/3] net: can: rockchip: add can for RK3576 Soc
MIME-Version: 1.0

On 14.11.2025 20:14:13, zhangqing wrote:
>
> =E5=9C=A8 2025/11/14 19:01, Marc Kleine-Budde =E5=86=99=E9=81=93:
> > On 14.11.2025 17:55:53, zhangqing wrote:
> > > > > +/* The rk3576 CAN-FD */
> > > > > +static const struct rkcanfd_devtype_data rkcan_devtype_data_rk35=
76 =3D {
> > > > > +	.model =3D RKCAN_MODEL_RK3576,
> > > > > +	.quirks =3D RKCANFD_QUIRK_CANFD_BROKEN,
> > > > Is CAN-FD mode broken on the rk3576?
> > > >
> > > > Please test CAN-FD and please do the tests documented near the
> > > > definition of RKCANFD_QUIRK_CANFD_BROKEN:
> > > >
> > > > | Tests on the rk3568v2 and rk3568v3 show that receiving certain
> > > > | CAN-FD frames trigger an Error Interrupt.
> > > > |
> > > > | - Form Error in RX Arbitration Phase: TX_IDLE RX_STUFF_COUNT (0x0=
a010100) CMD=3D0 RX=3D0 TX=3D0
> > > > |   Error-Warning=3D1 Bus-Off=3D0
> > > > |   To reproduce:
> > > > |   host:
> > > > |     cansend can0 002##01f
> > > > |   DUT:
> > > > |     candump any,0:0,#FFFFFFFF -cexdHtA
> > > > |
> > > > | - Form Error in RX Arbitration Phase: TX_IDLE RX_CRC (0x0a010200)=
 CMD=3D0 RX=3D0 TX=3D0
> > > > |   Error-Warning=3D1 Bus-Off=3D0
> > > > |   To reproduce:
> > > > |   host:
> > > > |     cansend can0 002##07217010000000000
> > > > |   DUT:
> > > > |     candump any,0:0,#FFFFFFFF -cexdHtA
> > > There is no doubt about the other modifications above. They will be
> > > corrected in version V10.
> > >
> > > CANFD requires authorization and is not supported by default.
> > Can you explain what you mean by authorization? What do you mean by "not
> > supported"?
>
> For RK3576 SoC, the IC hardware design supports CANFD.
> However, a license application is required before it can be used; otherwi=
se,
> there will be legal risks.

INANL. If an SoC is supplied without a license for the IP cores that you
want to use in a product you sell, you must purchase a license from
Bosch:

https://www.bosch-semiconductors.com/products/ip-modules/can-protocol-licen=
se/can-protocol-license.html

I don't see why you should restrict the driver to CAN only, if CAN-FD is
functional.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qaousal5vpe3w2e4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkXLR8ACgkQDHRl3/mQ
kZxcJQf+IBUb+EvRr6yojdWFYfh0iU6b+aUU/2CZ3TkeWzdBIRLFUkaKGsPr+XBS
4+qZeP0ur/AFd84E24pp1uN6T7XCVNwQh97MzfCXx32rkJNHQvrQehp8llBWg5mM
jwTsCyuu28Ber/ehYp7aprO0YMSwe+ocKilEtD6TBAG6KU9SQ/BDLnXTyQ3ql8Hj
ZYK8BA1sYtCnz6tr4sHuClKwmfQqoozXi/YWikAtCrNrcphB7cHv5znanwUC1VS4
50HLYsFXPQr/fPAT6bVX28XIGjFK01uDPHacWkzu0WcXLVqfNtN4f79gXkxogwvk
GZDGFSCCXSVNPD0EXrPK838WQ/bRAA==
=aDZ6
-----END PGP SIGNATURE-----

--qaousal5vpe3w2e4--

