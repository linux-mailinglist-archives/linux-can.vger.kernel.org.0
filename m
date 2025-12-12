Return-Path: <linux-can+bounces-5860-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 010EFCB8B3B
	for <lists+linux-can@lfdr.de>; Fri, 12 Dec 2025 12:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F348E300855A
	for <lists+linux-can@lfdr.de>; Fri, 12 Dec 2025 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EA231691C;
	Fri, 12 Dec 2025 11:21:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8892B231A23
	for <linux-can@vger.kernel.org>; Fri, 12 Dec 2025 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765538503; cv=none; b=K/eg7KKSgBe0AzkpukYdSwEMjyKgaLlrOe+SunKTjRnrwdB+KI7huShMzxVNoTIwvpdbUnmx6yKZ5CXQ2fAHrYZS5P6z9f+mgOhzMuD8TJUIklLGDKFPY9nFDSw+TeWxU/ncV1NMVPgABIpUqdzdy/CdbrhM7+4m3NdyoTIqGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765538503; c=relaxed/simple;
	bh=dBiEXSXqAe1+bjWPLYEbVWzfCTeFakFmTqGBVAZdykk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvBadOa3BhHOb9TtNJGSdhV84HNSa6y1PkAaBtT6v6LtQv6cUtkM69GK7CvF4GpNi4fcgXhLmGMk6Y8u7b/mnumjo/jaxv0r08KlGxWlXqzkxHNdhzc6+1VkNngK8sV4dwKxzmD/0r80t06BnyO0mjLheVouV24mEwu/9zd61lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vU1Cs-0004Lc-D5; Fri, 12 Dec 2025 12:21:06 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vU1Cq-005Hin-05;
	Fri, 12 Dec 2025 12:21:04 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A86804B5198;
	Fri, 12 Dec 2025 11:21:03 +0000 (UTC)
Date: Fri, 12 Dec 2025 12:21:03 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Conor Dooley <conor@kernel.org>
Cc: Prabhakar <prabhakar.csengg@gmail.com>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aswath Govindraju <a-govindraju@ti.com>, Frank Li <Frank.li@nxp.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] dt-bindings: phy: ti,tcan104x-can: Document TI
 TCAN1046
Message-ID: <20251211-wonderful-singing-eel-4e2293-mkl@pengutronix.de>
References: <20251209162119.2038313-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251210-mauve-cow-of-hurricane-0f969d-mkl@pengutronix.de>
 <20251210-persuaded-rewire-8ac93b0cc039@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7xctq6j2q5icdxbk"
Content-Disposition: inline
In-Reply-To: <20251210-persuaded-rewire-8ac93b0cc039@spud>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--7xctq6j2q5icdxbk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] dt-bindings: phy: ti,tcan104x-can: Document TI
 TCAN1046
MIME-Version: 1.0

On 10.12.2025 18:21:34, Conor Dooley wrote:
> On Wed, Dec 10, 2025 at 08:52:58AM +0100, Marc Kleine-Budde wrote:
> > On 09.12.2025 16:21:19, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Document the TI TCAN1046 automotive CAN transceiver. The TCAN1046 is a
> > > dual high-speed CAN transceiver with sleep-mode support and no EN pin,
> > > mirroring the behaviour of the NXP TJA1048, which also provides dual
> > > channels and STB1/2 sleep-control lines.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > TCAN 1046, https://www.ti.com/lit/ds/symlink/tcan1046v-q1.pdf?ts=3D17=
65297159307&ref_url=3Dhttps%253A%252F%252Fwww.ti.com%252Fproduct%252FTCAN10=
46V-Q1
> > > NXP TJA1048, https://www.nxp.com/docs/en/data-sheet/TJA1048.pdf
> >
> > The polarity of the standby line of the chips is different.
> >
> > You must set the correct active high/low property for the GPIO, as the
> > driver uses logical levels.
> >
> > Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> What you're saying seems to contradict the tag you've given, is a
> fallback really suitable if the standby polarity is not the same?

The driver uses _logical_ levels to switch the GPIOs. For example to
power on the PHY, it disables the standby GPIO by setting the value to
"0".

| static int can_transceiver_phy_power_on(struct phy *phy)
| {
[...]
|         gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
[...]
| }

You have to use GPIO_ACTIVE_HIGH/GPIO_ACTIVE_LOW in the DT to configure
the actual level of the GPIO.

If you connect the PHY's standby input directly to the SoC's GPIO....

| TJA1048: HIGH =3D Normal mode, LOW =3D Standby mode
| TCAN1046: High =3D Standby mode, Low =3D Normal Mode

=2E..for the TJA1048 you would use GPIO_ACTIVE_LOW, while for the
TCAN1046 you would use GPIO_ACTIVE_HIGH.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7xctq6j2q5icdxbk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmk7+pwACgkQDHRl3/mQ
kZzoXAf/WppHtgf+xjeHcSDUxWQiT0y/ms86YiQzUQjFGDoc+DrkDvbpuaMAc93u
Gsxz0QtfwMnzoMRyvd514QpjuacWsRppi+Td6sE70o8P4bOMWqy6oErLNqzHqOMX
4Z4ouZIL8vy+0uBD2KOicJ4lveWiJikUM4/I1tA3EW/19a0PJraNizbrnhzytasp
9YkxE/fMQopyYhb7//q4kyyzA/CzNqCS2qvi7RSk9XzXQYfzgSVCvF22USjkTUtH
J+hBMluDYcw1DAoRTB7YqBrCYsdnjDtokuiY2lvvnnXl3FX4PjmWMrSRnkyFhmtB
KlwlVtJ9F8qJbQrT0cqukuPBhyOcwA==
=RGBu
-----END PGP SIGNATURE-----

--7xctq6j2q5icdxbk--

