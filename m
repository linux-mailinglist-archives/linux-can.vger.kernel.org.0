Return-Path: <linux-can+bounces-997-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255B593A76A
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2024 20:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3DC91F22E3C
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2024 18:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8953113C67C;
	Tue, 23 Jul 2024 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB8cUGlB"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5995214286;
	Tue, 23 Jul 2024 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760657; cv=none; b=gQjT2US9BYsqB0p6MzLxx2btTBk8i5YxbIYc0Ja3Ata7gtEsXXvxIOkmnYMv0yGRjvF1jQ26BQjhiUWz/3GTB2WktkgxLm4Pahl4j/2EkYXirSxBMLifrsWkJs2eJrMqHjH8nzYF53zJ8ZhXgbPPIllHhxVMSLFhLgVZ3MTRheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760657; c=relaxed/simple;
	bh=vl1tL+qm9ouTAJDkwaDpLfLbUJBEPsRUkWIiVOPc7Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piPS9qWXZr+ka9RNa35n+zEPCKDe+/WABn1Y9sMOBrtzC0+q2UdCvVbvauSbnYUmEhnLNYAzsu15APYhmd6RPyibCOp5JcSQxcY0uRTL9r727VhX+RVKqpjbaHRimi/hBTEcZxIc7cUDIiesIPxml0XsuO0Tc+vqJGMmmIOHh/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB8cUGlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E864C4AF09;
	Tue, 23 Jul 2024 18:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721760656;
	bh=vl1tL+qm9ouTAJDkwaDpLfLbUJBEPsRUkWIiVOPc7Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nB8cUGlBm+7B0YBAMUzn270OoFVh2zSQvYM8rML0FikCLram4h3liP6vGlF7eNgE7
	 WTGQvUbwx7zDhIMeSTAAvV0O9ZLXrwPYoJiphkQqJdgnM2L2J4GdKktDxC3jp94wbR
	 BAjTM2peIlfNZ3Ys7ge9+dJ5kTwktjKtmnyQVQ4IWLkYncU7DOTnwoIeRgIkuoySQe
	 YCUKgXEBpQnTmYHN7c8RHUhe3ANrssF8UzYO2SNYHrRXaZA2FQuMXlhseQdOI4CA6d
	 133CfwSQ/VJO21ViPGPbAXjgljHmRMg+W4umkreTQR5AgIh29Q5tUcMm02rg2udKwh
	 Acsu02hYpRokw==
Date: Tue, 23 Jul 2024 19:50:52 +0100
From: Conor Dooley <conor@kernel.org>
To: IlorDash <ilordash02@gmail.com>
Cc: geert+renesas@glider.be, mkl@pengutronix.de, mailhol.vincent@wanadoo.fr,
	vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, a-govindraju@ti.com, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6561
Message-ID: <20240723-dinginess-john-608d0b28293b@spud>
References: <20240718210322.37492-1-ilordash02@gmail.com>
 <20240718210322.37492-2-ilordash02@gmail.com>
 <20240719-ahead-kiwi-995e52bf3e74@spud>
 <CAGCz5HkF_WNZBVpY2SWVf071Pi896BvKFk0jnfNAYX5AKx2Zcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Sb1wt06qVRZp8fX7"
Content-Disposition: inline
In-Reply-To: <CAGCz5HkF_WNZBVpY2SWVf071Pi896BvKFk0jnfNAYX5AKx2Zcw@mail.gmail.com>


--Sb1wt06qVRZp8fX7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 08:20:04PM +0300, IlorDash wrote:
> On Fri, 19 Jul 2024 at 18:07, Conor Dooley <conor@kernel.org> wrote:
> >
> > On Fri, Jul 19, 2024 at 12:03:21AM +0300, Ilya Orazov wrote:
> > > Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
> > > It is pin-compatible with TI TCAN1042.
> > >
> > > Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.ya=
ml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > index 79dad3e89aa6..03de361849d2 100644
> > > --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > @@ -18,6 +18,7 @@ properties:
> > >        - nxp,tjr1443
> > >        - ti,tcan1042
> > >        - ti,tcan1043
> > > +      - microchip,ata6561
> >
> > Given that your driver patch has
> > | diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-=
transceiver.c
> > | index ee4ce4249698..dbcd99213ba1 100644
> > | --- a/drivers/phy/phy-can-transceiver.c
> > | +++ b/drivers/phy/phy-can-transceiver.c
> > | @@ -89,6 +89,10 @@ static const struct of_device_id can_transceiver_p=
hy_ids[] =3D {
> > |                 .compatible =3D "nxp,tjr1443",
> > |                 .data =3D &tcan1043_drvdata
> > |         },
> > | +       {
> > | +               .compatible =3D "microchip,ata6561",
> > | +               .data =3D &tcan1042_drvdata
> > | +       },
> > |         { }
> > |  };
> >
> > the driver patch is actually not needed at all, and you just need to
> > allow ti,tcan1042 as fallback compatible in the binding, so something
> > like:
> >
> >   compatible:
> >     oneOf:
> >       - enum:
> >           - nxp,tjr1443
> >           - ti,tcan1042
> >           - ti,tcan1043
> >       - items:
> >           - const: microchip,ata6561
> >           - const: ti,tcan1042
> >
> >    '#phy-cells':
> >      const: 0
>=20
> I tested the build with fallback compatible:
>=20
> compatible:
>   oneOf:
>     - items:
>       - enum:
>         - microchip,ata6561
>       - const: ti,tcan1042
>     - items:
>       - enum:
>         - nxp,tjr1443
>       - const: ti,tcan1043
>=20
> and modified compatible property in DTS:
>=20
> compatible =3D "microchip,ata6561", "ti,tcan1042";
>=20
> Build succeeded, phy-can-transceiver driver was used. So I would like
> to add a fallback compatible for both "microchip,ata6561" and
> "nxp,tjr1443" in this binding and modify other DTS files with
> compatible =3D "nxp,tjr1443". What do you think?

This is wrong on two counts. Firstly, were what you have correct, you
should
squash the two:
     - items:
         - enum:
           - nxp,tjr1443
           - microchip,ata6561
         - const: ti,tcan1042

However, that does not allow the TI compatibles in isolation, so you
still need to allow that for the actual TI devices, so you need:

   oneOf:
     - items:
         - enum:
           - microchip,ata6561
           - nxp,tjr1443
           - ti,tcan1043
         - const: ti,tcan1042
     - const: ti,tcan1042

There's probably some devicetrees that would need to be fixed up. I'm
just not convinced that this is worth retrofitting however.

--Sb1wt06qVRZp8fX7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp/7jAAKCRB4tDGHoIJi
0kqmAQDbg7LV1E4pqgQO3NYNjah0s8scJYHyiLkSKEGkeV8vzgD/Vmkjp6MfrKVF
sb9sNoZYQ2y9gDZh9eTTxUkOP+9ibAI=
=oDmD
-----END PGP SIGNATURE-----

--Sb1wt06qVRZp8fX7--

