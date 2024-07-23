Return-Path: <linux-can+bounces-999-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0132693A802
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2024 22:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D121F21F41
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2024 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A701428EA;
	Tue, 23 Jul 2024 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSAWGQDj"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DC613C691;
	Tue, 23 Jul 2024 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721765654; cv=none; b=ZsZFmtVrPdLMoiJ/juPAfaQrrdlTVcGohpWI3Fd2qM66JPQSvp0oa/LdGJZymYFESRCpyUtivLhG2bzkreNa00apu2IApnCVfk31EY0VRuWR5wT5mtw/jT7XDHlZ8mWKHZ9vEnN3HPYybXESefvhV0hPMi3488aBqptgMQ+jHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721765654; c=relaxed/simple;
	bh=90qCsmRc/KyIcHIjkewyjqSMR6l+O5gromMuJ21lzjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+pJV+Ro2OgRPleSl/Qf5RQ62SrgqMvdRLbOGtFnOaw1C9Hu8jGZvM00UcOzf+EyOF3R6+ILiojWuSlA+HDcViHSP502wO6kVxVu5XrSqru+qr5B+inNfUWdod/jW/Zj+CTATd+3Q35HwLPy2FCKaLfVPhqSer0cMSF+Z1RRbNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSAWGQDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59688C4AF0A;
	Tue, 23 Jul 2024 20:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721765653;
	bh=90qCsmRc/KyIcHIjkewyjqSMR6l+O5gromMuJ21lzjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSAWGQDjaFBMhHzuVyukfj/KRAtf99leF3Ay98Q5TFlOm7PdLYc3c5L7Jp10SPDQf
	 ksIA169fWEVkEMXnBbTdbvH1ETzuMUcZE8pT3uuhpf0L29J/Fp8xT8kiVy4rzolF/l
	 WBTFy3HW/5rrY/rk8ChIU1MWQpRbudGJvRnujOi0ltmcwxjYNfHTpodXfDJW0u+lNQ
	 Swq6OdOfYvQkToj2bFcOtAI+2qlLeGcG2fwKDJn+c6VejlKjPxK7U81CUGhTzABaYt
	 QVPYKV6/ZAVuHZN5SYMFXcUR2kYSy5Zeh7hOSthf1hUjEujdkH5v3oZhKOLn6kTXfT
	 mf7flZobri0iw==
Date: Tue, 23 Jul 2024 21:14:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Ilya Orazov <ilordash02@gmail.com>
Cc: geert+renesas@glider.be, mkl@pengutronix.de, mailhol.vincent@wanadoo.fr,
	vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, a-govindraju@ti.com, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6561
Message-ID: <20240723-municipal-snowy-136b08b6db90@spud>
References: <20240718210322.37492-1-ilordash02@gmail.com>
 <20240718210322.37492-2-ilordash02@gmail.com>
 <20240719-ahead-kiwi-995e52bf3e74@spud>
 <CAGCz5HkF_WNZBVpY2SWVf071Pi896BvKFk0jnfNAYX5AKx2Zcw@mail.gmail.com>
 <20240723-dinginess-john-608d0b28293b@spud>
 <CAGCz5H=Gncw+Tr0XaQQhhGWQER5Rs1BcxbkPaJwx9jJ-8j7LGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z63R+4Oqxis0CS5a"
Content-Disposition: inline
In-Reply-To: <CAGCz5H=Gncw+Tr0XaQQhhGWQER5Rs1BcxbkPaJwx9jJ-8j7LGQ@mail.gmail.com>


--Z63R+4Oqxis0CS5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 10:55:17PM +0300, Ilya Orazov wrote:
> On Tue, 23 Jul 2024 at 21:50, Conor Dooley <conor@kernel.org> wrote:
> >
> > On Tue, Jul 23, 2024 at 08:20:04PM +0300, IlorDash wrote:
> > > On Fri, 19 Jul 2024 at 18:07, Conor Dooley <conor@kernel.org> wrote:
> > > >
> > > > On Fri, Jul 19, 2024 at 12:03:21AM +0300, Ilya Orazov wrote:
> > > > > Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
> > > > > It is pin-compatible with TI TCAN1042.
> > > > >
> > > > > Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-ca=
n.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > > > index 79dad3e89aa6..03de361849d2 100644
> > > > > --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > > > +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > > > @@ -18,6 +18,7 @@ properties:
> > > > >        - nxp,tjr1443
> > > > >        - ti,tcan1042
> > > > >        - ti,tcan1043
> > > > > +      - microchip,ata6561
> > > >
> > > > Given that your driver patch has
> > > > | diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-=
can-transceiver.c
> > > > | index ee4ce4249698..dbcd99213ba1 100644
> > > > | --- a/drivers/phy/phy-can-transceiver.c
> > > > | +++ b/drivers/phy/phy-can-transceiver.c
> > > > | @@ -89,6 +89,10 @@ static const struct of_device_id can_transceiv=
er_phy_ids[] =3D {
> > > > |                 .compatible =3D "nxp,tjr1443",
> > > > |                 .data =3D &tcan1043_drvdata
> > > > |         },
> > > > | +       {
> > > > | +               .compatible =3D "microchip,ata6561",
> > > > | +               .data =3D &tcan1042_drvdata
> > > > | +       },
> > > > |         { }
> > > > |  };
> > > >
> > > > the driver patch is actually not needed at all, and you just need to
> > > > allow ti,tcan1042 as fallback compatible in the binding, so somethi=
ng
> > > > like:
> > > >
> > > >   compatible:
> > > >     oneOf:
> > > >       - enum:
> > > >           - nxp,tjr1443
> > > >           - ti,tcan1042
> > > >           - ti,tcan1043
> > > >       - items:
> > > >           - const: microchip,ata6561
> > > >           - const: ti,tcan1042
> > > >
> > > >    '#phy-cells':
> > > >      const: 0
> > >
> > > I tested the build with fallback compatible:
> > >
> > > compatible:
> > >   oneOf:
> > >     - items:
> > >       - enum:
> > >         - microchip,ata6561
> > >       - const: ti,tcan1042
> > >     - items:
> > >       - enum:
> > >         - nxp,tjr1443
> > >       - const: ti,tcan1043
> > >
> > > and modified compatible property in DTS:
> > >
> > > compatible =3D "microchip,ata6561", "ti,tcan1042";
> > >
> > > Build succeeded, phy-can-transceiver driver was used. So I would like
> > > to add a fallback compatible for both "microchip,ata6561" and
> > > "nxp,tjr1443" in this binding and modify other DTS files with
> > > compatible =3D "nxp,tjr1443". What do you think?
> >
> > This is wrong on two counts. Firstly, were what you have correct, you
> > should
> > squash the two:
> >      - items:
> >          - enum:
> >            - nxp,tjr1443
> >            - microchip,ata6561
> >          - const: ti,tcan1042
> >
> > However, that does not allow the TI compatibles in isolation, so you
> > still need to allow that for the actual TI devices, so you need:
> >
> >    oneOf:
> >      - items:
> >          - enum:
> >            - microchip,ata6561
> >            - nxp,tjr1443
> >            - ti,tcan1043
> >          - const: ti,tcan1042
> >      - const: ti,tcan1042
> >
> > There's probably some devicetrees that would need to be fixed up. I'm
> > just not convinced that this is worth retrofitting however.
>=20
> But nxp,tjr1443 is pin compatible with ti,tcan1043, so it should
> fallback only to ti,tcan1043 and not ti,tcan1042. That's why I decided
> to split them into different enums.

Ah, sorry I missed that. I misread the match data. Then you need:
  compatible:
    oneOf:
      - items:
        - enum:
          - microchip,ata6561
        - const: ti,tcan1042
      - items:
        - enum:
          - nxp,tjr1443
        - const: ti,tcan1043
      - enum:
          const: ti,tcan1042
          const: ti,tcan1043

because the TI devices exist and we still need to be able to
differentiate the TI and NXP devices. If you have
  compatible =3D "nxp,tjr1443", "ti,tcan1042";
that means the device is an nxp,tjr1443. If you have
  compatible =3D "ti,tcan1042";
then that's a tcan1042.

> I made my patch according to a similar one that adds support for
> nxp,tjr1443. You can find it's conversation on
> https://lore.kernel.org/all/6ee5e2ce00019bd3f77d6a702b38bab1a45f3bb0.1674=
037830.git.geert+renesas@glider.be/t/#u.

> I thought we want to hold all PHY chip names in one compatible enum
> and each in its own of_device_id struct in driver and extend them
> where appropriate.

Nah, fallbacks are preferred when the programming model is either
identical or a "compatible superset" of an existing device. New
of_device_id structs should only be used where we need to account for
differences in the programming model.

Cheers,
Conor.

--Z63R+4Oqxis0CS5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqAPEQAKCRB4tDGHoIJi
0kUtAQCD4m5JpvCin6NoTN7R88b/5D2xMXjRcMXCbKfv3R5+2AD+P2ctpV4F6zrF
A+Iu8ksIp0p58jPpj6u/fU5EQe+iawE=
=jKJ5
-----END PGP SIGNATURE-----

--Z63R+4Oqxis0CS5a--

