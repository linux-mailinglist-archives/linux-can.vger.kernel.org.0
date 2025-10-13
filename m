Return-Path: <linux-can+bounces-5148-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC28BBD260B
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 11:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C17594E4A63
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 09:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BBF2FA0D3;
	Mon, 13 Oct 2025 09:52:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9709E142E83
	for <linux-can@vger.kernel.org>; Mon, 13 Oct 2025 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349128; cv=none; b=nLEtIcsJgrhcHbyx1SaZU+cGAxwTlRaexmGh2/QLgrUQ0WVeySrME21HG6zUppiIzJ1fsSLHmOvwPtSUcaqyUOtEL6nDsCzwSrEfj6ENnHaNxwF86twzvx3+TmXZGsruq0QinEzlFrFJ3Zs4hnLJIz0J7HcJo3SvIpObUBKkZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349128; c=relaxed/simple;
	bh=ZE8I0omPAhpLklJEufsFutIeIgqDicG2eGMKv68bvCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbywKBOe4CARb+2CgSJb+MwmKfPto3hJafXoPT6ImJXlkv3ipuFtVM9yZP5WXnfUD9ztg9i5n8gZYSVvTAJB4KUM5ZjHjPJ5MEeCg7GRi2nZ3pVs6j01l5PWtht3vhahTwNoiobIhHHf8CJgpJg1HdkNq2gGL3WBzG6/G5QL0II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8FDc-0005rG-Rl; Mon, 13 Oct 2025 11:51:52 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8FDb-003MYD-2A;
	Mon, 13 Oct 2025 11:51:51 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5A2E1484A28;
	Mon, 13 Oct 2025 09:51:51 +0000 (UTC)
Date: Mon, 13 Oct 2025 11:51:51 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH v3 2/2] phy: add basic support for NXPs TJA1145 CAN
 transceiver
Message-ID: <20251013-unyielding-turquoise-mamba-76a0ea-mkl@pengutronix.de>
References: <20251013-tja1145-support-v3-0-4a9d245fe067@liebherr.com>
 <20251013-tja1145-support-v3-2-4a9d245fe067@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qdg74qywuxcudsqt"
Content-Disposition: inline
In-Reply-To: <20251013-tja1145-support-v3-2-4a9d245fe067@liebherr.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--qdg74qywuxcudsqt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] phy: add basic support for NXPs TJA1145 CAN
 transceiver
MIME-Version: 1.0

On 13.10.2025 11:19:19, Dimitri Fedrau via B4 Relay wrote:
> Add basic driver support for NXPs TJA1145 CAN transceiver which brings the
> PHY up/down by switching to normal/standby mode using SPI commands.

The PHY supports standby and sleep mode. Does the PHY framework provide
a way to configure this?

Why do you put the transceiver into standby not in sleep mode?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qdg74qywuxcudsqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjsy7MACgkQDHRl3/mQ
kZzcWgf+OHX9MypGBZgJ7rndD9uqn3kqkAol7HambwaSnG5pp6Xn2gW/xl0Z9U9V
pSA4CYciskgb/k5CXq16yyR3mgxElA8JWCE6R5gg0TC+Cf37zQy2tCxc2Kzp6e2g
tNVxMeJyjowlFBN63AUyfWA3V98OiHMhdwOYKQ1vSWTYSa6FsOHAdlGJZGjblMXv
74ffibAy8JXsIOC9McNvssCIQi/VdhwQOW5PlzJI6A1BpbHz3aQgwKLv/aKIx8J2
DbaCFWR/kmKwzbEjsque/rhFvSF9JqaSFkvxdoY5YMVODMzlS0bhCMZ+Y1ugUUPi
ZJngsX/6GrL/kDyydwEZxZl/umdeuA==
=GoOc
-----END PGP SIGNATURE-----

--qdg74qywuxcudsqt--

