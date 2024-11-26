Return-Path: <linux-can+bounces-2232-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 061C09D9A1D
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 16:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5647164085
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 15:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D43D1D54D8;
	Tue, 26 Nov 2024 15:02:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A541D5CFF
	for <linux-can@vger.kernel.org>; Tue, 26 Nov 2024 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633354; cv=none; b=DpQg6sc03TCB1qpC9A6+zMdoI6z4yN0NW/7MiFpSrbyjkZOPkEGJEX5CVuDviopSAOGmNLy/Hz2u1DgYAqINpoc8maGxqxasVldeqOPak1aWiIbkkH5ncw7+i+81jGMmvwFHAigk23UPAMBlTtif6vXbFjqQZK/nO4MooIXylW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633354; c=relaxed/simple;
	bh=4MuCRYTzrI6+DACM8ZYOAL0amwgFcD/iI483sfyCq2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eif82pTiE4jmRGh5Z188VgXbKZZCH0GktW2D1FUQGqpUVlLASS/2LbYit9VbDEg32FL8r5Gn0KFUI8u9qgApufvV5aiWGGzGLnPdOkQWAuwmOIt47Wsf+SHzJSWZHUhJXycsJsrosztctx0zai+hEYHTenRdxAUfjSlD0eKDNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFx4v-0006oE-0x; Tue, 26 Nov 2024 16:02:13 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFx4t-000GZo-0z;
	Tue, 26 Nov 2024 16:02:12 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A8CAB37DBF1;
	Tue, 26 Nov 2024 15:02:11 +0000 (UTC)
Date: Tue, 26 Nov 2024 16:02:11 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, NXP S32 Linux <s32@nxp.com>, 
	imx@lists.linux.dev, Christophe Lizzi <clizzi@redhat.com>, 
	Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3
 SoC support
Message-ID: <20241126-capable-vagabond-tody-8b3717-mkl@pengutronix.de>
References: <20241125163103.4166207-1-ciprianmarian.costea@oss.nxp.com>
 <20241125163103.4166207-2-ciprianmarian.costea@oss.nxp.com>
 <y2fbsxg4pney2iapzcdooxyz6l3pmw6ms2ddupf637svitelbt@wthu23ld5ryq>
 <20241126-independent-crocodile-of-finesse-106009-mkl@pengutronix.de>
 <01a7de95-24e2-4c75-a818-bbc363e89844@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="undj4rwjdiuemcef"
Content-Disposition: inline
In-Reply-To: <01a7de95-24e2-4c75-a818-bbc363e89844@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--undj4rwjdiuemcef
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3
 SoC support
MIME-Version: 1.0

On 26.11.2024 15:48:15, Ciprian Marian Costea wrote:
> Thank you for taking time in reviewing this patchset.
>=20
> I will update description for the first irq as:
> 'Message Buffer interrupt for mailboxes 0-7 and Enhanced RX FIFO'
>=20
> > >=20
> > > > +            - description:
> > > > +                Interrupt indicating that the CAN bus went to Buss=
 Off state
> > >=20
> > > s/Interrupt indicating that//
> > > Buss Off state status?
> >=20
> > What about: "Device went into Bus Off state"
> >=20
> > However from the excel sheet I read it as a device changes state, to Bus
> > Off, finished Bus Off or transition from error counters from < 96 to >=
=3D 96.
> >=20
> > So "Device state change" would be a more complete description?
> >=20
>=20
> I agree "Device state change" would be a more suitable description. I will
> update accordingly in V3.

Thanks.

> > > > +            - description:
> > > > +                Interrupt indicating that errors were detected on =
the CAN bus
> > >=20
> > > Error detection?
> > >=20
> > > > +            - description:
> > > > +                Message Buffer interrupt for mailboxes 8-127 (ored)
> >=20
> > nitpick: all these different events for the other interrupts are ored,
> > so IMHO you can omit the "(ored)".
> >=20
>=20
> True. I will update.

Thanks

> > > > +        interrupt-names:
> > > > +          items:
> > > > +            - const: mb_0-7

I was wondering if it makes sense to have an interrupt name not
mentioning the exact mailbox numbers, so that the same interrupt name
can be used for a different IP core, too. On the coldfire SoC the 1st
IRQ handles mailboxes 0...15.

> > > Choose one: either underscores or hyphens. Keep it consistent in your
> > > bindings.
> >=20
> > > > +            - const: state
> > > > +            - const: berr
> >=20
> > The order of IRQ names is not consistent with the description.

Sorry, I misread the interrupt names and was under the misconception
that the interrupt names have a different order than the interrupt
descriptions.

> Good point. Indeed the order which is in the S32G3 interrupt map excel is
> not consistent with the bindings.
>=20
> The reason is that in the flexcan driver, reusing the
> 'FLEXCAN_QUIRK_NR_IRQ_3' quirk forces the probing of irqs to be done in t=
he
> following order:
> mailbox (irq) -> state (irq_boff) -> berr (irq_err)
>=20
> Hence in order to maintain ABI compatibility I am proposing the following
> order for irqs in case of S32G2/S32G3 SoCs:
> mb-0-7 -> state -> berr -> mb-8-127

That makes totally sense!

>=20
> > > > +            - const: mb_8-127

same here

> > > Choose one: either underscores or hyphens. Keep it consistent in your
> > > bindings.
> > >=20
> > > > +      required:
> > > > +        - compatible
> > > > +        - reg
> > > > +        - interrupts
> > > > +        - interrupt-names
> > >=20
> > > What happened to "else:"? Why all other devices now have up to 4 inte=
rrupts?
> >=20
> > Do you already have a dtsi snippet for the flexcan nodes? Please make
> > sure that the interrupts are correctly mapped.
>=20
> Yes, I am testing using the following dtsi snippet:
>=20
> can0: can@401b4000 {
>     compatible =3D "nxp,s32g3-flexcan",
>                  "nxp,s32g2-flexcan";
>     reg =3D <0x401b4000 0xa000>;
>     interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
>                  <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
>                  <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
>                  <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>     interrupt-names =3D "mb-0-7", "state", "berr", "mb-8-127";
>     clocks =3D <&clks 9>, <&clks 11>;
>     clock-names =3D "ipg", "per";
> };

looks good to me!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--undj4rwjdiuemcef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdF4vAACgkQKDiiPnot
vG9kXgf/aAbe27McJaFq9XHYf6CY/m6U7DLysA8e4qHZLW69Ht2XYnXhYGTDzI4Q
F92kX7CDcsiy6U0XiLtWhHslABIxx1pq6uW5c83IWsQHtp15HIgRdWeEEiQK51us
5RumAKQmbaZhSeaFGEofIaCIHpdSWpVfZF9ecSKUEQDpzF1IJqEXvMaVq4X9yFyD
ZEobf+nToO46iNVARScak0AzF5KbngipOKicG1nE2g2cQfXMRUQBPQtMbl1uaFyW
5PtdtUR+sFdwRcPebFzUXPQWB+DBIjiM2jO6ycjgt1G5090/FmhBg/tNaZPcIMLv
9anedHnWqxRIuSXCcUPQKksuuoVuQg==
=izOt
-----END PGP SIGNATURE-----

--undj4rwjdiuemcef--

