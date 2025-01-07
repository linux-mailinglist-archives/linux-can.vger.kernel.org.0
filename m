Return-Path: <linux-can+bounces-2549-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1907CA03E8B
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2025 13:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809BA3A2865
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2025 12:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DF21EBFE3;
	Tue,  7 Jan 2025 12:06:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604341E0B86
	for <linux-can@vger.kernel.org>; Tue,  7 Jan 2025 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251565; cv=none; b=GR2NM/zNB5EiX6j3jMIIBvRRFr1u0D90iStU1jXtJp9EvkYgnyep/1mBBW9yJtJu/y41khGDfNI8KZAKjX5hfATiILH3taLC6ITLCvXh2D0PbVMcV1cuOexw4ZRS+NREqF4bMpTeWp5y66zM7afM1Sxh8dNDNH9goKJGvoXQa3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251565; c=relaxed/simple;
	bh=ITCSuZQwfw2vyxBOUCB4rmYaafYP+KIRaF4bg549Umw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F53UWNWBlctBzp4xUOPzKIcaKfzHneATWG+6LBg4BT2dVNeOoEEUIy8RnCQwURrKzSluZBbln1UcqqCaM4J4YUh9tlelZ7dCmTcK5SvtAjRpgiNbzIG1kC0YzzHJ4+0lOsjrp7VyR4puiSelbGWlbi1JVnwOkqxv/v09NG7SkWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tV8Ku-0000EA-8n; Tue, 07 Jan 2025 13:05:28 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tV8Kq-007L5X-2G;
	Tue, 07 Jan 2025 13:05:25 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 02F0E3A07D8;
	Tue, 07 Jan 2025 12:05:25 +0000 (UTC)
Date: Tue, 7 Jan 2025 13:05:24 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v6 1/7] dt-bindings: can: m_can: Add wakeup properties
Message-ID: <20250107-liberal-unique-uakari-0ddc2c-mkl@pengutronix.de>
References: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
 <20241219-topic-mcan-wakeup-source-v6-12-v6-1-1356c7f7cfda@baylibre.com>
 <20241225-singing-passionate-antelope-88e154-mkl@pengutronix.de>
 <d6hukfwjqgtwqjgvo65icmpzbm32ob6n7ehrzlywwomjbdn5lg@2wm53244pszz>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="irxivooeuvii5qqy"
Content-Disposition: inline
In-Reply-To: <d6hukfwjqgtwqjgvo65icmpzbm32ob6n7ehrzlywwomjbdn5lg@2wm53244pszz>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--irxivooeuvii5qqy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 1/7] dt-bindings: can: m_can: Add wakeup properties
MIME-Version: 1.0

On 07.01.2025 10:53:26, Markus Schneider-Pargmann wrote:
> On Wed, Dec 25, 2024 at 08:50:17PM +0100, Marc Kleine-Budde wrote:
> > On 19.12.2024 20:57:52, Markus Schneider-Pargmann wrote:
> > > m_can can be a wakeup source on some devices. Especially on some of t=
he
> > > am62* SoCs pins, connected to m_can in the mcu, can be used to wakeup
> > > the SoC.
> > >=20
> > > The wakeup-source property defines on which devices m_can can be used
> > > for wakeup and in which power states.
> > >=20
> > > The pins associated with m_can have to have a special configuration to
> > > be able to wakeup the SoC. This configuration is described in the wak=
eup
> > > pinctrl state while the default state describes the default
> > > configuration.
> > >=20
> > > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> >=20
> > The DTBS check fails:
> >=20
> > | $ make CHECK_DTBS=3Dy ti/k3-am625-beagleplay.dtb
> > |   DTC [C] arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb
> > | arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: can@4e08000: wakeup-s=
ource: 'oneOf' conditional failed, one must be fixed:
> > |         ['suspend', 'poweroff'] is not of type 'boolean'
> > |         ['suspend', 'poweroff'] is too long
> > |         from schema $id: http://devicetree.org/schemas/net/can/bosch,=
m_can.yaml#
> > | arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: can@4e08000: wakeup-s=
ource: ['suspend', 'poweroff'] is not of type 'boolean'
> > |         from schema $id: http://devicetree.org/schemas/wakeup-source.=
yaml#
> > | arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: can@4e18000: wakeup-s=
ource: 'oneOf' conditional failed, one must be fixed:
> > |         ['suspend', 'poweroff'] is not of type 'boolean'
> > |         ['suspend', 'poweroff'] is too long
> > |         from schema $id: http://devicetree.org/schemas/net/can/bosch,=
m_can.yaml#
> > | arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: can@4e18000: wakeup-s=
ource: ['suspend', 'poweroff'] is not of type 'boolean'
> > |         from schema $id: http://devicetree.org/schemas/wakeup-source.=
yaml#
>=20
> Thanks, the bot also notified me about this issue. I wasn't able to
> solve it without updating the dt-schema, so I submitted a pull request
> there:
>=20
> https://github.com/devicetree-org/dt-schema/pull/150

I see, please add to the patch description that it depends on the that
PR and re-post once it is accepted.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--irxivooeuvii5qqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmd9GIEACgkQKDiiPnot
vG+zTQgAihSGsmCQN7GOCUVL0pLqGfQ+AHZnIQy8rwBO01Z59sh6sqoE9gXb798d
gHsC/et9Mcrq7CetVsitQgE0+4+1byxSBFQsfBmAY6IAlwoOwmMSMPNYldCs4y13
XtQJnDDPc1zNgj5JGzoTbTs2ysu+qUK+N1lZDAkXd3k78OR9Lh2080q99UxeVFsX
OF2/+FBp5tuxIbKwjpCY61XgW7zZKBQ3/weFrZUeGbeqeV33NOvUr+mvYXJmNG8O
9IlOGY3my6JDMiYg4H6aGUwV2YmeBO3HgaUCJyJ+La+/J2odyAyxTWEUIacvgfDd
p+TND+ZVqXJIXALf8Jk+iKfyB/c9mQ==
=usZs
-----END PGP SIGNATURE-----

--irxivooeuvii5qqy--

