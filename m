Return-Path: <linux-can+bounces-3695-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878A2AC5285
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 17:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C6416C348
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F9527E7C1;
	Tue, 27 May 2025 15:58:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735227CCF0
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361518; cv=none; b=r6j7dRkkOolglI4cRV9KrTsF1xqtYLr2jmGPEXA45ePTG8WDU5VGrFCMSAZyD2Cod/TX9OlMTnR51oHMe1QcIpNnBGk8/2+hSpvZhqIrasDU+t7FqfSpA4xAKmMlsvJ2Z4vF+FlRDHMWsps4uGqpOmdKGKJMkga4haC9bmG1GUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361518; c=relaxed/simple;
	bh=61A8ZZzlXfCu/SUZbAzP0EpUdS/Qz7fRFXmHVMVqQJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3n++Itaz5j/fo3jVYCIJ9fJYbtYsBaYOIfBenNBteQdXxWjIfU81P8lhIOFlCn1SZSybkciiU5ReAhltcgJYOTrJQaZQQ9n1pHyXzvxZ3leBNFv8vkjkWRfTvsML/ljDnIvOlyPeFcOdzw97Wo1csmme2vbR7a4V1HpbEZRzuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uJwgz-0004eD-Ic; Tue, 27 May 2025 17:58:17 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uJwgx-000Rc3-37;
	Tue, 27 May 2025 17:58:15 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8E8EB41AA8E;
	Tue, 27 May 2025 15:58:15 +0000 (UTC)
Date: Tue, 27 May 2025 17:58:15 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com, 
	kever.yang@rock-chips.com, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/4] rockchip: add can for RK3576 Soc
Message-ID: <20250527-steady-dormouse-of-culture-c45bd6-mkl@pengutronix.de>
References: <20250526062559.2061311-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pckthsx2tg77kzdv"
Content-Disposition: inline
In-Reply-To: <20250526062559.2061311-1-zhangqing@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--pckthsx2tg77kzdv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 0/4] rockchip: add can for RK3576 Soc
MIME-Version: 1.0

On 26.05.2025 14:25:55, Elaine Zhang wrote:
> rk3576 can is a new controller,new register layout and Bit position
> definition:
> Support CAN and CANFD protocol.
> Support Dma.
>=20
> There are major differences from the previous rk3568.
> All errata on the rk3568 have been fixed and redesigned.

Can you configure the IP core for CAN-2.0 a.k.a. CAN-CC only mode, so
that it only receives CAN-CC frames only and not CAN-FD?

What happens if you configure register RKCAN_STR_CTL, ism_sel to 2'b01:
CAN Fixed and receive a CAN-FD frame?

Is there a more detailed description to "2'b00: Flexible; cover_mode
must disable" and "2'b11: Mixed. cover_mode must disable"?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pckthsx2tg77kzdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmg14RQACgkQDHRl3/mQ
kZyZQgf7BB/yyOkv3ry1psGUXvjfa6oVbkh/JVbPbds5HJPB50UhBhjmhbGKPq30
r4BTF8f4ZEPWK+cEbibjbBdW5DXR4VLJ1bMX4C2f53uDNua+5Z3C6TLq1R5IvDoy
PDvwfcRTEba9Oivuu9TNEpsV7hMN9opc4UORUId8yU/2vco4Pt3bQSUlbm9iRgMk
hrWJFWQ+YyEEiJfhVp7V5CarGiEB64ALiK7y8CTESWtc1IWINpFb7raFMF2RvSMW
/oVTymupsa9ltY8nVa+Mz7o4BXe1wG2ReXfn2QIB+S7+nN+ZGF2PMl/V4a1s9ByH
kBPX9qhW+6hvLQgeDJhzgFmF9bYpTQ==
=y8iK
-----END PGP SIGNATURE-----

--pckthsx2tg77kzdv--

