Return-Path: <linux-can+bounces-2230-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AC09D95E8
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 12:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7F628260D
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 11:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F3A1CDFB9;
	Tue, 26 Nov 2024 11:00:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B6366
	for <linux-can@vger.kernel.org>; Tue, 26 Nov 2024 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618815; cv=none; b=JMsyszQy0CpTESG+YXsSVQ3+tQJgdFzi8Qa1TDkdwS/DcXXAH/oMSfT86iknoUe4vFlaQlh+wNAYbQGEjYCMl2/SIfusgh0b7rRx30wIAbMqdV8w6k/XQH7/HHSPPj4wbSaQSbe+BwZu/wRFtmUQS+vIT51TAl6RyUresrDXHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618815; c=relaxed/simple;
	bh=KZOy2PsGSLeRARy7LZDQ2bm+JG1QxNV2pkuwwj66+wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u57Sg06EBCwSG0qKkJVmhHHiy/+2GPq8U7JtiruE/4XZyQtcaGDuRG3wY7JRjvcQ0qFmyRBBWrmp22IC6SkpBRHuH0zxEuooHH5LPAF0ZLEfUpofELmEK0EB2fpUArOWUj78DKvMEYjaZGN+VPfChZgKKeD9qjzg8pvRLkazjaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFtIG-0004nI-4y; Tue, 26 Nov 2024 11:59:44 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFtIE-000EZ5-2X;
	Tue, 26 Nov 2024 11:59:43 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2BC9A37D91F;
	Tue, 26 Nov 2024 10:59:43 +0000 (UTC)
Date: Tue, 26 Nov 2024 11:59:42 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, NXP S32 Linux <s32@nxp.com>, 
	imx@lists.linux.dev, Christophe Lizzi <clizzi@redhat.com>, 
	Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3
 SoC support
Message-ID: <20241126-independent-crocodile-of-finesse-106009-mkl@pengutronix.de>
References: <20241125163103.4166207-1-ciprianmarian.costea@oss.nxp.com>
 <20241125163103.4166207-2-ciprianmarian.costea@oss.nxp.com>
 <y2fbsxg4pney2iapzcdooxyz6l3pmw6ms2ddupf637svitelbt@wthu23ld5ryq>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dfsenyb7jvpat5a3"
Content-Disposition: inline
In-Reply-To: <y2fbsxg4pney2iapzcdooxyz6l3pmw6ms2ddupf637svitelbt@wthu23ld5ryq>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--dfsenyb7jvpat5a3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3
 SoC support
MIME-Version: 1.0

On 26.11.2024 08:19:04, Krzysztof Kozlowski wrote:
> On Mon, Nov 25, 2024 at 06:31:00PM +0200, Ciprian Costea wrote:
> > From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> >=20
> > Add S32G2/S32G3 SoCs compatible strings.
> >=20
> > A particularity for these SoCs is the presence of separate interrupts f=
or
> > state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
> >=20
> > Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
> > same restriction for other SoCs.
> >=20
> > Also, as part of this commit, move the 'allOf' after the required
> > properties to make the documentation easier to read.
> >=20
> > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
>=20
> You made multiple changes afterwards, which invalidated the review. See
> submitting-patches which explain what to do in such case.
>=20
> > ---
> >  .../bindings/net/can/fsl,flexcan.yaml         | 46 +++++++++++++++++--
> >  1 file changed, 42 insertions(+), 4 deletions(-)
>=20
> ...
>=20
> >      maxItems: 2
> > @@ -136,6 +143,37 @@ required:
> >    - reg
> >    - interrupts
> > =20
> > +allOf:
> > +  - $ref: can-controller.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: nxp,s32g2-flexcan
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          items:
> > +            - description:
> > +                Message Buffer interrupt for mailboxes 0-7
>=20
> Keep it in one line.

According to the excel sheet the IRQ is also for the enhanced RX FIFO.

>=20
> > +            - description:
> > +                Interrupt indicating that the CAN bus went to Buss Off=
 state
>=20
> s/Interrupt indicating that//
> Buss Off state status?

What about: "Device went into Bus Off state"

However from the excel sheet I read it as a device changes state, to Bus
Off, finished Bus Off or transition from error counters from < 96 to >=3D 9=
6.

So "Device state change" would be a more complete description?

> > +            - description:
> > +                Interrupt indicating that errors were detected on the =
CAN bus
>=20
> Error detection?
>=20
> > +            - description:
> > +                Message Buffer interrupt for mailboxes 8-127 (ored)

nitpick: all these different events for the other interrupts are ored,
so IMHO you can omit the "(ored)".

> > +        interrupt-names:
> > +          items:
> > +            - const: mb_0-7
>=20
> Choose one: either underscores or hyphens. Keep it consistent in your
> bindings.

> > +            - const: state
> > +            - const: berr

The order of IRQ names is not consistent with the description.

> > +            - const: mb_8-127
>=20
> Choose one: either underscores or hyphens. Keep it consistent in your
> bindings.
>=20
> > +      required:
> > +        - compatible
> > +        - reg
> > +        - interrupts
> > +        - interrupt-names
>=20
> What happened to "else:"? Why all other devices now have up to 4 interrup=
ts?

Do you already have a dtsi snippet for the flexcan nodes? Please make
sure that the interrupts are correctly mapped.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dfsenyb7jvpat5a3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdFqhsACgkQKDiiPnot
vG/LTgf+Mwp1q1vMJAIFstJubBhTvSCwOJbyA++jfcLd3MuPutHUalDu0aHMeb77
A9Us5XLu3d3zwqFhPmSBC2pZYS/71wq7193lTCvD3W/PFx5o5NjHv8QK5Zr2zYIM
hPVDVWPPJHHLp/sqKCfpOWUbyXvedKLAmtqcSjk11iUiUHisiMUWpgX6KQ9X/a/2
bIYYgHBm9EVitdDY49MzdwJH6+tE+xZ9qsfrgEgT1QpGDoD1TErBuijcAyxn/LW6
XSsLhDu/HDsmV499Wj9lSuaHo1+E8Zm6Yy0XVJWdOOO4VisvVOkbFbP51NcEPyez
7RhKu4VQEpP+m49vw8rQT+wEIy6Vjg==
=KwpE
-----END PGP SIGNATURE-----

--dfsenyb7jvpat5a3--

