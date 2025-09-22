Return-Path: <linux-can+bounces-4813-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A0AB91559
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 15:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1141D422C7A
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 13:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A21E302156;
	Mon, 22 Sep 2025 13:13:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA4730DD1D
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546784; cv=none; b=fabvutJJWKd6hSUR9I+NN4tf82q0v7E42pRv9oxzlyq1/9IaYavrlxBq736AF00ooZxWdalqsiVa+YAT9lfQuX1Blcj2ZYNYzoJeq7t3U8WCU9piketj96BtTTCqlvrXpxxunCzxrPGNbOUZMPzACzAffFmi3BS53gjTiUvq7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546784; c=relaxed/simple;
	bh=fifZ7UrR3FG0IWv0F3QlkHcEIoJkRo+i1fID8hMDXS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I74VnxMH2xbMa+/OA4xXD00Nuj32i3AR48WBRJ3S3Ufce1NdEeuV6xLPSs8g+q20+CQZ2V8sTKrqBx43K3pkthX7O7mV0BU3zWvW+3Vkdt50+Me5sTQv0QrY8pa+6sSqsOmHaCPEiC5Ef69NmoayYfVUXGleRjNXSW5FVUgNTXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0gLU-0003pc-1P; Mon, 22 Sep 2025 15:12:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0gLS-002bMp-1J;
	Mon, 22 Sep 2025 15:12:42 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 06C7C477022;
	Mon, 22 Sep 2025 13:12:42 +0000 (UTC)
Date: Mon, 22 Sep 2025 15:12:40 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com, 
	kever.yang@rock-chips.com, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/4] dt-bindings: can: rockchip_canfd: add rk3576
 CAN-FD controller
Message-ID: <20250922-secret-visionary-macaque-4f52a7-mkl@pengutronix.de>
References: <20250922071543.73923-1-zhangqing@rock-chips.com>
 <20250922071543.73923-2-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ta3ykn3sqrxc7f3w"
Content-Disposition: inline
In-Reply-To: <20250922071543.73923-2-zhangqing@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ta3ykn3sqrxc7f3w
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 1/4] dt-bindings: can: rockchip_canfd: add rk3576
 CAN-FD controller
MIME-Version: 1.0

On 22.09.2025 15:15:40, Elaine Zhang wrote:
> Add documentation for the rockchip rk3576 CAN-FD controller.

Please make DMA optional, I'm not convinced that it brings any benefit
for the system.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ta3ykn3sqrxc7f3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjRS0QACgkQDHRl3/mQ
kZzmYgf/XGDJsCLS4h1r22LbETIcTtzkKskRIg8uS4VtJ6+B3fpEpeSdiurlbgLJ
H2Uk60UC2qwtfCGX34k3W/KUZAcMiWUF0uSwIey54+V/47Z57T7tyF+qlLXavAJg
EvMzEqQBXo/HF7qKjn5zwGt/cfJzkaZ0gQurGnuGcVfQCtVh6yyjRK7zA3az9tso
9aeJjgqJxCR2Eu41e1X5ch1iFULgtRXPhzeUi1ApANoiqWy10XR1GpCRvOlMYxQo
d4Ss493hcO5HefbgwTXnJ12waxg3YZSOSfV9iRdiZoSdgeGZyYKd+Ffeyps8Ep34
DZMvjmPilwpExGCnFVr7LJBfrco1Ww==
=/ET9
-----END PGP SIGNATURE-----

--ta3ykn3sqrxc7f3w--

