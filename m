Return-Path: <linux-can+bounces-2026-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFFE9C84EC
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB63CB2487C
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 08:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BDE1F756B;
	Thu, 14 Nov 2024 08:39:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728CD1F7563
	for <linux-can@vger.kernel.org>; Thu, 14 Nov 2024 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731573596; cv=none; b=GGaPnQyMe8ckrMhi2TSHKu1tnQxZQd0yNQr4C40OCP1hQTFCGe0bDHWkpUkMHWdfyo/ReYRzSLV43/CA2+qWtHVzpyFQCfazHGpeoL+tci28fAKutVu5TRSofOkN83eZROuJ3QamxuXp5CeHKJpW5lafPql5e7umpfeRIgUAKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731573596; c=relaxed/simple;
	bh=IbO8gli/e/c94g3RgX5UhBSer9mV0LL2pC3JNM4V+sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p48v93Lu/rXqhNYcRyDFks99ID9M3VsI02h0zkAVrgO/U32av3JVE/GntcdNtB+t6y/fcRQVyFw0W7VEWCpM22cnGKfyL9CwqKV0yJAYQ8KOpRKRCKteN69YmlTThvfvMrCCoPvEMvpdDJbbeoXXGRI5uLK+OkG3JKWOKhNMEvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBVNv-0006Bt-DF; Thu, 14 Nov 2024 09:39:27 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBVNt-000iGw-33;
	Thu, 14 Nov 2024 09:39:25 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9327A372E77;
	Thu, 14 Nov 2024 08:39:25 +0000 (UTC)
Date: Thu, 14 Nov 2024 09:39:23 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH can-next v3 1/2] dt-bindings: can: tcan4x5x: Document the
 ti,nwkrq-voltage-vio option
Message-ID: <20241114-honest-premium-nightingale-22eae6-mkl@pengutronix.de>
References: <20241112-tcan-wkrqv-v3-0-c66423fba26d@geanix.com>
 <20241112-tcan-wkrqv-v3-1-c66423fba26d@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c4ad3lx4y36kkuyt"
Content-Disposition: inline
In-Reply-To: <20241112-tcan-wkrqv-v3-1-c66423fba26d@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--c4ad3lx4y36kkuyt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v3 1/2] dt-bindings: can: tcan4x5x: Document the
 ti,nwkrq-voltage-vio option
MIME-Version: 1.0

On 12.11.2024 15:39:39, Sean Nyekjaer wrote:
> nWKRQ supports an output voltage of either the internal reference voltage

The nWKRQ pin

> (3.6V) or the reference voltage of the digital interface 0 - 6V (VIO).
> Add the devicetree option ti,nwkrq-voltage-vio to set it to VIO.

If this property is omitted the reset default, the internal reference
voltage, is used.

>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

With this change:

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--c4ad3lx4y36kkuyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc1tzgACgkQKDiiPnot
vG8icwf/bYMlgy/0lxTBYOyveFvfW8QvmWpBdf/22k86tbeGfSIhdFcim4PWLNha
R5Ach6ltU7IA3Zti7aS2cH/dX0ScTsVXoTPCvev8VV6uLwVJgGTH9aRn6HC1a6wD
tv/fTJQHf+t3g2i9zW859qgnto4PjU0nXKwixK5EJsF9F/6gf1QyT9DLDdqi7ugq
FPtC1r2kRvdEmmSz5qB3mqcOygpjblCMx2IUB1AdN51GOopUaJxFJxSRcptObJdg
x8FEeuB1q8RCqpxQH/i8bUMbijU6hMHl7vjYjiLUoRDY5WMUwXEH4uLXKCh3eRbz
U+iLvRxvWJC0+gRYsPwXRSGrIq7QFg==
=HuND
-----END PGP SIGNATURE-----

--c4ad3lx4y36kkuyt--

