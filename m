Return-Path: <linux-can+bounces-93-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D896813143
	for <lists+linux-can@lfdr.de>; Thu, 14 Dec 2023 14:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2803D282C5C
	for <lists+linux-can@lfdr.de>; Thu, 14 Dec 2023 13:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E117F55769;
	Thu, 14 Dec 2023 13:20:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA40B9
	for <linux-can@vger.kernel.org>; Thu, 14 Dec 2023 05:20:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rDldH-0006qa-Ix; Thu, 14 Dec 2023 14:20:07 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rDldF-00FoVx-W9; Thu, 14 Dec 2023 14:20:06 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E93BD26304B;
	Thu, 14 Dec 2023 13:20:04 +0000 (UTC)
Date: Thu, 14 Dec 2023 14:20:04 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND v1 2/7] dt-bindings: can: mpfs: add missing
 required clock
Message-ID: <20231214-genetics-issue-b8f9c60c74b2-mkl@pengutronix.de>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
 <20231208-palpitate-passable-c79bacf2036c@spud>
 <20231212-unreeling-depose-8b6b2e032555-mkl@pengutronix.de>
 <20231213-waffle-grueling-3a5c3879395b@spud>
 <20231214-tinderbox-glitzy-60d1936ab85f-mkl@pengutronix.de>
 <20231214-tinderbox-paver-d1ff0fc5c428@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ingrkcbszpm5ox2g"
Content-Disposition: inline
In-Reply-To: <20231214-tinderbox-paver-d1ff0fc5c428@spud>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ingrkcbszpm5ox2g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.12.2023 13:16:55, Conor Dooley wrote:
> > > > > --- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-ca=
n.yaml
> > > > > +++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-ca=
n.yaml
> > > > > @@ -24,7 +24,10 @@ properties:
> > > > >      maxItems: 1
> > > > > =20
> > > > >    clocks:
> > > > > -    maxItems: 1
> > > > > +    maxItems: 2
> > > > > +    items:
> > > > > +      - description: AHB peripheral clock
> > > > > +      - description: CAN bus clock
> > > >=20
> > > > Do we we want to have a "clock-names" property, as we need the clock
> > > > rate of the CAN bus clock.
> > >=20
> > > We should not need the clock-names property to be able to get both of
> > > the clocks. clk_bulk_get_all() for example should be usable here.
> >=20
> > ACK, but we need the clock rate of CAN clock. Does this binding check
> > that the CAN clock rate is the 2nd one?
>=20
> The items list requires that the can clock be the second one, so drivers
> etc can rely on that ordering.

Thanks for the clarification,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ingrkcbszpm5ox2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmV7AQAACgkQvlAcSiqK
BOgXVQgAiYx/qmn+/n56qpOGHQ2TatWn/aI2UbU6V7+JDjHv+P8H3L5u5vHCT3vn
KS93aR3iviTIzFdrnadB3oLNJ4YErKNuszF4zKAb0G24ze4X/ZoGGegGd6nzTzNL
QBNZtOGrSAVZOIF/Kjf0hPUdZMjPDW4D8LG1P1P5T7Jke33m4dEtbYGMUFxJUWf/
z3d8oqJO2H8wym5sTvzfC8rBKor9uJ1Cy+b7m1uXce9JCPqb2x4sHjD6cvO0GnsG
QsqRWDTLt02gmQ/5Bi+yGPuBSRv4DQhukgXTkfHRtp7+VAmpU45p6mD7+iEjCqYn
2zTEKmCfHq+OXBvLtGPaGCfFYkRpPw==
=FXlj
-----END PGP SIGNATURE-----

--ingrkcbszpm5ox2g--

