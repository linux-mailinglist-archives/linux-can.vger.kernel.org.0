Return-Path: <linux-can+bounces-1033-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C1393F03A
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 10:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4081B28229C
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 08:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED7D13C80F;
	Mon, 29 Jul 2024 08:52:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40971139D12;
	Mon, 29 Jul 2024 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243127; cv=none; b=ZorE/tipSsPP9uf899bzFMtJ6egfSST5V376L2v6TMrn9VQM24bRGs1+SV5509NmFC9jqS6yCuhZyW7KnpepUT+SulLPllFKO7kvtQNvdH4VTrnRRxZ6WSZ4UAWTspA/Oxim/g483fslydvuFsLpdAVQU9AoC5sNAbYcnLlu40w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243127; c=relaxed/simple;
	bh=EllNsFQhKjhnG5Z+UAfKg7NfTbmjqrF+y4x25MeYGlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ReIfVRpm/sQNQXFwaAerHNN2QR6BLR7TYRJtRVZdYecW2D2RptFlm89DRPLJGEeZXK5oMVp/1zNO9UoK1C0faIlz0rZYJmGz41m0XP2hQfbHPvRu2Vu99lLzDvMMJ2kKcoBsZaJ52yvwidJBiF0dSqmnAMS55ygj7lE0N/E4Izo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-65cd720cee2so17070657b3.1;
        Mon, 29 Jul 2024 01:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722243123; x=1722847923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqSAntpxwAaK8Ju6K/LOPA95uiNO3TLROZcY1mWI+vA=;
        b=omEd6X0xfLCJ/A/OIWUJvZDB6zcMIxPFTpqaAvL7lbbmQO21Lw9GkhkLEx0xYAlrVF
         TgEAttJzF3t23xppUH6muXzr6/h76BHP0hzZ/nqll7xJj6Ur3K3ns56BO2FDP8yrW4Ps
         g+0NRSJelcP8nE/2igTDNfslyGXDiMs58yq/SxzGZ9lyAUwxInPsJTM1TbfGjk5gvZNR
         v5CfnI3bG4yiOvgUbZ9nVMvoAOzAwbLtimZCQ63BXab8XNdc7+fSxchu0p13kdmED9H2
         n4YPukEMrIdRMn+gdqvJiwc3scMDmHXUVGCR1EOBUOskihZ61oFey1MXcXH5XyGRt8rK
         9ZDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfRZPRitOrTvR+kXltBlXfdDsinDmuOs6uDpZ1u23WhGUw6aq98GsIeo2h3BRLQ2oDhcWtbRKqH3ZrlokTxklprXolcwvcMQYLzfvi0egt58fewItZKsIjVvuA+7hxtZs9eRAoGw==
X-Gm-Message-State: AOJu0Yxfac8RAUg9RsrlGV9Ut8JYJ2ieQFR6plY5ElM0M5c2kWtns/T6
	uL3rmII1/ATMSlBYPY5ie5ekPv8g6LGpQFHdSDCL3Pt3dfbEwCVItxDDJrwO
X-Google-Smtp-Source: AGHT+IE3FxFtbW35rP/iJQ67nZfFXxxUlKx05dZvHcF3PjBZpWjKzXJlT6fCPlwvNCfjVbmd3I+L+g==
X-Received: by 2002:a0d:c344:0:b0:64a:e220:bfbf with SMTP id 00721157ae682-67a0813c74amr83389287b3.23.1722243123161;
        Mon, 29 Jul 2024 01:52:03 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b024aeasm19700287b3.89.2024.07.29.01.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 01:52:02 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-66599ca3470so16080977b3.2;
        Mon, 29 Jul 2024 01:52:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWk1gI/PjQQ48EM3cdzm6nk2grcC/3HbZkuU8iEq8gHHrX63YyNpoZm8tveTsJQxXyA50HSlYFFMkS0d/DmCYHWhli3ByU22/63Q8uB/ejVsqdRPXeQcAv6gUAieaNciPAajrGbhA==
X-Received: by 2002:a81:8101:0:b0:665:54fa:5abf with SMTP id
 00721157ae682-67a05e78c43mr85473567b3.2.1722243122638; Mon, 29 Jul 2024
 01:52:02 -0700 (PDT)
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
In-Reply-To: <CAGCz5HnJKjNj7A0YD2fw20m-NrEs3MoCLwox86mC11Kudq8xbg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jul 2024 10:51:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUf=McxMLqb1hgu_-4QkSFJkdWrdtbwiwn9yJoMSi3YWA@mail.gmail.com>
Message-ID: <CAMuHMdUf=McxMLqb1hgu_-4QkSFJkdWrdtbwiwn9yJoMSi3YWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561
To: Ilya Orazov <ilordash02@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, mkl@pengutronix.de, mailhol.vincent@wanadoo.fr, 
	vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	a-govindraju@ti.com, linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilya,

On Sun, Jul 28, 2024 at 10:52=E2=80=AFAM Ilya Orazov <ilordash02@gmail.com>=
 wrote:
> On Tue, 23 Jul 2024 at 23:14, Conor Dooley <conor@kernel.org> wrote:
> > On Tue, Jul 23, 2024 at 10:55:17PM +0300, Ilya Orazov wrote:
> > > On Tue, 23 Jul 2024 at 21:50, Conor Dooley <conor@kernel.org> wrote:
> > > > On Tue, Jul 23, 2024 at 08:20:04PM +0300, IlorDash wrote:
> > > > > On Fri, 19 Jul 2024 at 18:07, Conor Dooley <conor@kernel.org> wro=
te:
> > > > > >
> > > > > > On Fri, Jul 19, 2024 at 12:03:21AM +0300, Ilya Orazov wrote:
> > > > > > > Microchip ATA6561 is High-Speed CAN Transceiver with Standby =
Mode.
> > > > > > > It is pin-compatible with TI TCAN1042.
> > > > > > >
> > > > > > > Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
> > > > > > > ---
> > > > > > >  Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml |=
 1 +
> > > > > > >  1 file changed, 1 insertion(+)
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104=
x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > > > > > index 79dad3e89aa6..03de361849d2 100644
> > > > > > > --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.y=
aml
> > > > > > > +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.y=
aml
> > > > > > > @@ -18,6 +18,7 @@ properties:
> > > > > > >        - nxp,tjr1443
> > > > > > >        - ti,tcan1042
> > > > > > >        - ti,tcan1043
> > > > > > > +      - microchip,ata6561
> > > > > >
> > > > > > Given that your driver patch has
> > > > > > | diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/=
phy-can-transceiver.c
> > > > > > | index ee4ce4249698..dbcd99213ba1 100644
> > > > > > | --- a/drivers/phy/phy-can-transceiver.c
> > > > > > | +++ b/drivers/phy/phy-can-transceiver.c
> > > > > > | @@ -89,6 +89,10 @@ static const struct of_device_id can_trans=
ceiver_phy_ids[] =3D {
> > > > > > |                 .compatible =3D "nxp,tjr1443",
> > > > > > |                 .data =3D &tcan1043_drvdata
> > > > > > |         },
> > > > > > | +       {
> > > > > > | +               .compatible =3D "microchip,ata6561",
> > > > > > | +               .data =3D &tcan1042_drvdata
> > > > > > | +       },
> > > > > > |         { }
> > > > > > |  };
> > > > > >
> > > > > > the driver patch is actually not needed at all, and you just ne=
ed to
> > > > > > allow ti,tcan1042 as fallback compatible in the binding, so som=
ething
> > > > > > like:
> > > > > >
> > > > > >   compatible:
> > > > > >     oneOf:
> > > > > >       - enum:
> > > > > >           - nxp,tjr1443
> > > > > >           - ti,tcan1042
> > > > > >           - ti,tcan1043
> > > > > >       - items:
> > > > > >           - const: microchip,ata6561
> > > > > >           - const: ti,tcan1042
> > > > > >
> > > > > >    '#phy-cells':
> > > > > >      const: 0
> > > > >
> > > > > I tested the build with fallback compatible:
> > > > >
> > > > > compatible:
> > > > >   oneOf:
> > > > >     - items:
> > > > >       - enum:
> > > > >         - microchip,ata6561
> > > > >       - const: ti,tcan1042
> > > > >     - items:
> > > > >       - enum:
> > > > >         - nxp,tjr1443
> > > > >       - const: ti,tcan1043
> > > > >
> > > > > and modified compatible property in DTS:
> > > > >
> > > > > compatible =3D "microchip,ata6561", "ti,tcan1042";
> > > > >
> > > > > Build succeeded, phy-can-transceiver driver was used. So I would =
like
> > > > > to add a fallback compatible for both "microchip,ata6561" and
> > > > > "nxp,tjr1443" in this binding and modify other DTS files with
> > > > > compatible =3D "nxp,tjr1443". What do you think?
> > > >
> > > > This is wrong on two counts. Firstly, were what you have correct, y=
ou
> > > > should
> > > > squash the two:
> > > >      - items:
> > > >          - enum:
> > > >            - nxp,tjr1443
> > > >            - microchip,ata6561
> > > >          - const: ti,tcan1042
> > > >
> > > > However, that does not allow the TI compatibles in isolation, so yo=
u
> > > > still need to allow that for the actual TI devices, so you need:
> > > >
> > > >    oneOf:
> > > >      - items:
> > > >          - enum:
> > > >            - microchip,ata6561
> > > >            - nxp,tjr1443
> > > >            - ti,tcan1043
> > > >          - const: ti,tcan1042
> > > >      - const: ti,tcan1042
> > > >
> > > > There's probably some devicetrees that would need to be fixed up. I=
'm
> > > > just not convinced that this is worth retrofitting however.
> > >
> > > But nxp,tjr1443 is pin compatible with ti,tcan1043, so it should
> > > fallback only to ti,tcan1043 and not ti,tcan1042. That's why I decide=
d
> > > to split them into different enums.
> >
> > Ah, sorry I missed that. I misread the match data. Then you need:
> >   compatible:
> >     oneOf:
> >       - items:
> >         - enum:
> >           - microchip,ata6561
> >         - const: ti,tcan1042
> >       - items:
> >         - enum:
> >           - nxp,tjr1443
> >         - const: ti,tcan1043
> >       - enum:
> >           const: ti,tcan1042
> >           const: ti,tcan1043
> >
> > because the TI devices exist and we still need to be able to
> > differentiate the TI and NXP devices. If you have
> >   compatible =3D "nxp,tjr1443", "ti,tcan1042";
> > that means the device is an nxp,tjr1443. If you have
> >   compatible =3D "ti,tcan1042";
> > then that's a tcan1042.
> >
> > > I made my patch according to a similar one that adds support for
> > > nxp,tjr1443. You can find it's conversation on
> > > https://lore.kernel.org/all/6ee5e2ce00019bd3f77d6a702b38bab1a45f3bb0.=
1674037830.git.geert+renesas@glider.be/t/#u.
> >
> > > I thought we want to hold all PHY chip names in one compatible enum
> > > and each in its own of_device_id struct in driver and extend them
> > > where appropriate.
> >
> > Nah, fallbacks are preferred when the programming model is either
> > identical or a "compatible superset" of an existing device. New
> > of_device_id structs should only be used where we need to account for
> > differences in the programming model.
>
> However, I am curious as to why the NXP CAN PHY transceiver was not
> included as fallback compatible. Geert, could you please share your
> thoughts on this matter?

The TJR1443 looked sufficiently similar to the TCAN1043 to use the
same driver configuration (which is limited to having standby and/or
enable signals or not).  However, I'm not sure it behaves exactly
the same, e.g. in case of reporting an error condition (which is not
yet supported by the driver). The part numbers are also different,
so this is not a simple case of SN74HCxx vs. CD74HCxx.

Summary: I don't know if they are identical, or if TJR1443 is a
compatible superset of TCAN1043, or vice versa. Hence I went for the
safest way....

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

