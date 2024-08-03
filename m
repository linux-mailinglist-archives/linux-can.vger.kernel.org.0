Return-Path: <linux-can+bounces-1104-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 727159469A9
	for <lists+linux-can@lfdr.de>; Sat,  3 Aug 2024 14:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F261C20A6C
	for <lists+linux-can@lfdr.de>; Sat,  3 Aug 2024 12:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEF1139D03;
	Sat,  3 Aug 2024 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDCg5Z/S"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5142D53B;
	Sat,  3 Aug 2024 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722688326; cv=none; b=eo8KMBS57c9mxgEIJg93h7VMoJhxStXq1awPUPXyxFWk/uuJHEiWCPKIfMoEYuT3g0DkjaNvaiSXUkt+qXvNhS0pCEYOBeexQQieFlU8QQwQPY5FyTtP7WhM2vJLLe9EEwkZo9B4vo3RlY5HQGHwfdkvgLlkxT0HxkJMi1+SEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722688326; c=relaxed/simple;
	bh=uOQrYcJATsAaf82PDCx7hDXIknFlDybJKCXPiGw2T9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfVisPOHNXHuIB9MU6Vg4BRDf0E4Icpgl6O/7rCdDuLEPf63E76SRZqyg+u8ksgpcJIkmymUHJle48TnuK1l0hdb0FQXrjGAQ1jFIMZ0dlyg6mm/C1c9XvK1pV4u+ZQ0LlJE7KBkNdxbIQ3Zu9hmHtebxtk6wFtVNzBuiyLk8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDCg5Z/S; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-67b709024bfso83715187b3.3;
        Sat, 03 Aug 2024 05:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722688323; x=1723293123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3+BaC9o/e9DWaWrjc0ap9vXeLeDNjNnKH8vyX7nP08=;
        b=nDCg5Z/SniQge3QxLOy9uGbXR9ZP1lxsTmAln6kVCgUSjqjfsQv5JsUwsY/zWACQ90
         EWAlzI5TjSHNOWN6CqJDSviXcPyuyGJePa71UBHFpmCg15QL7ZW0kfFC3E2uhXmpioi0
         qKQCbz/4Jt5HeQwvEo1JanDAFI1LB7CTtTqA71q9jZG37TxmRNKZMgvLiXWpm2S7E6Az
         KGoT/7l+FF4pLgjuN5d1J5j7HHTODoF6BxH04mVJjbdeMPK39l2iR+RaGQ76l0YuvYS+
         eGpS83g3w4dFpsR4juMoc239AKyR5k62A7AkPXFoB2yCfC1y1Dp2lNjT4g5WC8y+jB9P
         hfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722688323; x=1723293123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3+BaC9o/e9DWaWrjc0ap9vXeLeDNjNnKH8vyX7nP08=;
        b=uGDwk9VU2cfIfQ8iIqczU+9+bSpLzpT3YQe+JdDrNZcqiRSb794Fyn169zA5fGFIcG
         AQh4aBKme5sZ4yo/MRGNdPuwL9kTVboeqVeyceCjdcHLcKWLhDaqKDMICn6YIrd/Sz7c
         oGn+X+JTyTDX2SEHYr+GEyPEF8/V+T1cHBP44dBeWkresLeoPMDuw2yM/g5fiJtYzSal
         3J9N9gQAgbG+zco8eWgoHtxrGAgTkp1aAeFn7c+pK1JFs9p1YuF/DZUXWwCQv7kDiD8t
         lzQL03c0dmW2LWv80lYXg8o36FB214J77m3e6HcCo90f+djPXQsTvOOMGPMqB+FPyxMI
         zakw==
X-Forwarded-Encrypted: i=1; AJvYcCVxIiF3KC7bhXbOqXl+xu1TtDfvseYN1OkR8ibYa8ezQsfcSNexc4LfhHzWiSPXw2aRo6cKNLfXffKh@vger.kernel.org, AJvYcCWpkSxZJuvJunk89VxprwX2X0V+j66Btw48gDi/l4i0qSX53FJZ5ZzlKibZDy8FoV2LlEG2sa+IH4K/@vger.kernel.org
X-Gm-Message-State: AOJu0YyELCQfvceAwmtuMVPYxDL+DMvjQOn/hrry6RHfvwlzPUiZkOQ1
	rqFFWkQ6JA+OGHK5NvTaC3Ylv4ZN0xcLvl8pV6mUrhYzEHnmA/M2zqqM6OtwEqEfONFYra4gUUU
	dIWjc4/ni3vD7lXCYEqGnWHW4d/w=
X-Google-Smtp-Source: AGHT+IHyulwlUu12HySz+3pTmFjQx/SBzzCVa46bcv3gYiCYNGn3Ea7xgWm+nGgMXckttVObX/mBhtmS3Sx5N+NSxQ8=
X-Received: by 2002:a0d:c346:0:b0:63b:d242:4fa0 with SMTP id
 00721157ae682-68960e44eb2mr69575297b3.21.1722688323383; Sat, 03 Aug 2024
 05:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718210322.37492-1-ilordash02@gmail.com> <20240718210322.37492-2-ilordash02@gmail.com>
 <20240719-ahead-kiwi-995e52bf3e74@spud> <CAGCz5HkF_WNZBVpY2SWVf071Pi896BvKFk0jnfNAYX5AKx2Zcw@mail.gmail.com>
 <20240723-dinginess-john-608d0b28293b@spud> <CAGCz5H=Gncw+Tr0XaQQhhGWQER5Rs1BcxbkPaJwx9jJ-8j7LGQ@mail.gmail.com>
 <20240723-municipal-snowy-136b08b6db90@spud> <CAGCz5HnJKjNj7A0YD2fw20m-NrEs3MoCLwox86mC11Kudq8xbg@mail.gmail.com>
 <CAMuHMdUf=McxMLqb1hgu_-4QkSFJkdWrdtbwiwn9yJoMSi3YWA@mail.gmail.com> <20240801-disarray-gesture-ebad121272b0@spud>
In-Reply-To: <20240801-disarray-gesture-ebad121272b0@spud>
From: Ilya Orazov <ilordash02@gmail.com>
Date: Sat, 3 Aug 2024 15:31:52 +0300
Message-ID: <CAGCz5H=gDfJpfAhH-QbxN5VSDyVtwGU6Zt16z7=sqpTdjkeGqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561
To: Conor Dooley <conor@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, mkl@pengutronix.de, mailhol.vincent@wanadoo.fr, 
	vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	a-govindraju@ti.com, linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Aug 2024 at 18:12, Conor Dooley <conor@kernel.org> wrote:
>
> On Mon, Jul 29, 2024 at 10:51:50AM +0200, Geert Uytterhoeven wrote:
> > Hi Ilya,
> >
> > On Sun, Jul 28, 2024 at 10:52=E2=80=AFAM Ilya Orazov <ilordash02@gmail.=
com> wrote:
> > > On Tue, 23 Jul 2024 at 23:14, Conor Dooley <conor@kernel.org> wrote:
> > > > On Tue, Jul 23, 2024 at 10:55:17PM +0300, Ilya Orazov wrote:
> > > > > On Tue, 23 Jul 2024 at 21:50, Conor Dooley <conor@kernel.org> wro=
te:
> > > > > > On Tue, Jul 23, 2024 at 08:20:04PM +0300, IlorDash wrote:
> > > > > > > On Fri, 19 Jul 2024 at 18:07, Conor Dooley <conor@kernel.org>=
 wrote:
> > > > > > > >
> > > > > > > > On Fri, Jul 19, 2024 at 12:03:21AM +0300, Ilya Orazov wrote=
:
> > > > > > > > > Microchip ATA6561 is High-Speed CAN Transceiver with Stan=
dby Mode.
> > > > > > > > > It is pin-compatible with TI TCAN1042.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
> > > > > > > > > ---
> > > > > > > > >  Documentation/devicetree/bindings/phy/ti,tcan104x-can.ya=
ml | 1 +
> > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > >
> > > > > > > > > diff --git a/Documentation/devicetree/bindings/phy/ti,tca=
n104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > > > > > > > index 79dad3e89aa6..03de361849d2 100644
> > > > > > > > > --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-c=
an.yaml
> > > > > > > > > +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-c=
an.yaml
> > > > > > > > > @@ -18,6 +18,7 @@ properties:
> > > > > > > > >        - nxp,tjr1443
> > > > > > > > >        - ti,tcan1042
> > > > > > > > >        - ti,tcan1043
> > > > > > > > > +      - microchip,ata6561
> > > > > > > >
> > > > > > > > Given that your driver patch has
> > > > > > > > | diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/=
phy/phy-can-transceiver.c
> > > > > > > > | index ee4ce4249698..dbcd99213ba1 100644
> > > > > > > > | --- a/drivers/phy/phy-can-transceiver.c
> > > > > > > > | +++ b/drivers/phy/phy-can-transceiver.c
> > > > > > > > | @@ -89,6 +89,10 @@ static const struct of_device_id can_t=
ransceiver_phy_ids[] =3D {
> > > > > > > > |                 .compatible =3D "nxp,tjr1443",
> > > > > > > > |                 .data =3D &tcan1043_drvdata
> > > > > > > > |         },
> > > > > > > > | +       {
> > > > > > > > | +               .compatible =3D "microchip,ata6561",
> > > > > > > > | +               .data =3D &tcan1042_drvdata
> > > > > > > > | +       },
> > > > > > > > |         { }
> > > > > > > > |  };
> > > > > > > >
> > > > > > > > the driver patch is actually not needed at all, and you jus=
t need to
> > > > > > > > allow ti,tcan1042 as fallback compatible in the binding, so=
 something
> > > > > > > > like:
> > > > > > > >
> > > > > > > >   compatible:
> > > > > > > >     oneOf:
> > > > > > > >       - enum:
> > > > > > > >           - nxp,tjr1443
> > > > > > > >           - ti,tcan1042
> > > > > > > >           - ti,tcan1043
> > > > > > > >       - items:
> > > > > > > >           - const: microchip,ata6561
> > > > > > > >           - const: ti,tcan1042
> > > > > > > >
> > > > > > > >    '#phy-cells':
> > > > > > > >      const: 0
> > > > > > >
> > > > > > > I tested the build with fallback compatible:
> > > > > > >
> > > > > > > compatible:
> > > > > > >   oneOf:
> > > > > > >     - items:
> > > > > > >       - enum:
> > > > > > >         - microchip,ata6561
> > > > > > >       - const: ti,tcan1042
> > > > > > >     - items:
> > > > > > >       - enum:
> > > > > > >         - nxp,tjr1443
> > > > > > >       - const: ti,tcan1043
> > > > > > >
> > > > > > > and modified compatible property in DTS:
> > > > > > >
> > > > > > > compatible =3D "microchip,ata6561", "ti,tcan1042";
> > > > > > >
> > > > > > > Build succeeded, phy-can-transceiver driver was used. So I wo=
uld like
> > > > > > > to add a fallback compatible for both "microchip,ata6561" and
> > > > > > > "nxp,tjr1443" in this binding and modify other DTS files with
> > > > > > > compatible =3D "nxp,tjr1443". What do you think?
> > > > > >
> > > > > > This is wrong on two counts. Firstly, were what you have correc=
t, you
> > > > > > should
> > > > > > squash the two:
> > > > > >      - items:
> > > > > >          - enum:
> > > > > >            - nxp,tjr1443
> > > > > >            - microchip,ata6561
> > > > > >          - const: ti,tcan1042
> > > > > >
> > > > > > However, that does not allow the TI compatibles in isolation, s=
o you
> > > > > > still need to allow that for the actual TI devices, so you need=
:
> > > > > >
> > > > > >    oneOf:
> > > > > >      - items:
> > > > > >          - enum:
> > > > > >            - microchip,ata6561
> > > > > >            - nxp,tjr1443
> > > > > >            - ti,tcan1043
> > > > > >          - const: ti,tcan1042
> > > > > >      - const: ti,tcan1042
> > > > > >
> > > > > > There's probably some devicetrees that would need to be fixed u=
p. I'm
> > > > > > just not convinced that this is worth retrofitting however.
> > > > >
> > > > > But nxp,tjr1443 is pin compatible with ti,tcan1043, so it should
> > > > > fallback only to ti,tcan1043 and not ti,tcan1042. That's why I de=
cided
> > > > > to split them into different enums.
> > > >
> > > > Ah, sorry I missed that. I misread the match data. Then you need:
> > > >   compatible:
> > > >     oneOf:
> > > >       - items:
> > > >         - enum:
> > > >           - microchip,ata6561
> > > >         - const: ti,tcan1042
> > > >       - items:
> > > >         - enum:
> > > >           - nxp,tjr1443
> > > >         - const: ti,tcan1043
> > > >       - enum:
> > > >           const: ti,tcan1042
> > > >           const: ti,tcan1043
> > > >
> > > > because the TI devices exist and we still need to be able to
> > > > differentiate the TI and NXP devices. If you have
> > > >   compatible =3D "nxp,tjr1443", "ti,tcan1042";
> > > > that means the device is an nxp,tjr1443. If you have
> > > >   compatible =3D "ti,tcan1042";
> > > > then that's a tcan1042.
> > > >
> > > > > I made my patch according to a similar one that adds support for
> > > > > nxp,tjr1443. You can find it's conversation on
> > > > > https://lore.kernel.org/all/6ee5e2ce00019bd3f77d6a702b38bab1a45f3=
bb0.1674037830.git.geert+renesas@glider.be/t/#u.
> > > >
> > > > > I thought we want to hold all PHY chip names in one compatible en=
um
> > > > > and each in its own of_device_id struct in driver and extend them
> > > > > where appropriate.
> > > >
> > > > Nah, fallbacks are preferred when the programming model is either
> > > > identical or a "compatible superset" of an existing device. New
> > > > of_device_id structs should only be used where we need to account f=
or
> > > > differences in the programming model.
> > >
> > > However, I am curious as to why the NXP CAN PHY transceiver was not
> > > included as fallback compatible. Geert, could you please share your
> > > thoughts on this matter?
> >
> > The TJR1443 looked sufficiently similar to the TCAN1043 to use the
> > same driver configuration (which is limited to having standby and/or
> > enable signals or not).  However, I'm not sure it behaves exactly
> > the same, e.g. in case of reporting an error condition (which is not
> > yet supported by the driver). The part numbers are also different,
> > so this is not a simple case of SN74HCxx vs. CD74HCxx.
> >
> > Summary: I don't know if they are identical, or if TJR1443 is a
> > compatible superset of TCAN1043, or vice versa. Hence I went for the
> > safest way....
>
> If we don't know for sure what the craic is with compatibility, then we
> should leave the existing tjr1443 compatible as-is I think.

If I understood the kernel documentation correctly, we use fallback
compatibles when devices are similar or there is an iterative
relationship between them. In my case, the TCAN1042 and ATA6561 are
from different manufacturers, and I'm not sure about their fully
identical functionality.

Therefore, I'll go back to the original idea where I shouldn't use a
fallback compatible here and must leave it as another compatible
property with its own of_device_id struct.

What do you think about it? In my opinion, this is not a case for
fallback compatibility.

--=20
Best regards,
Ilya Orazov

