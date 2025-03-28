Return-Path: <linux-can+bounces-3256-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA4AA7478A
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 11:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7744189E478
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AED31B5EA4;
	Fri, 28 Mar 2025 10:10:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912FC215179;
	Fri, 28 Mar 2025 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156643; cv=none; b=hMD5FGPXQeJO/fmnISZTwfiQjLn4cgTPdfhaqey+d0nP4256wzYAd8vo4SbR5VOoIkHy76JexIlp+TOf3WaaApd/xhrV5K0zlcu240jqt1Q5Lh1EbpSDFpM6QRJozBYHGZ9bk36yDckV9SpLJSSpj/GSCEu5JbVLcNmz2Qwcnw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156643; c=relaxed/simple;
	bh=0nI9Ca1x3o2rr54AKPokQQ6t7iUhPztB51rftlk6kgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLmXrQt26h/qRNOCtHXEp+FySa6/DFhtfsx6Z+5bfIjrTfkk3kz3NDTUi9JzHm/XB7LI4HZoofbwNFdowLS9xzlBgZz8eN2hpxgiUnPavK0/jlV1NyR79ul69hkJxKrd7YFwG1gL848ZRN851TuHppMmYCSgee9l9LjDGzHk9Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86d75f4e9a1so936144241.3;
        Fri, 28 Mar 2025 03:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743156640; x=1743761440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOqnhGiI+e+khGaBY9SnUC+e9f6oZLD63mReStuNh28=;
        b=L7SwZchmLH0n08UBRWbDhuWip8H8BDGgJiosMnugWkb5GOBHRz4Q//RqHOORHQ18g6
         uvx8t/BeuHy2jlQa+Kz/YUYQb3XvsFfJaGXHek4ccCVgcQavYKFCjESEklD3x3AZKvfH
         I63DqOofbiWafS0SaLVJBiACN07NyH9deVWIwQMJHaajo21i89lLG/tUSL5DLEBXtXbj
         KdON1BMfmVXq4VDYtYbApT0BoGrN1TZ6kRQ1sz9oydJUhZqY+MiYS9zE05p9SgVZRzjx
         fxYIFqe/m40DrwX3kAHcohGfSTSD8QKg8+IVvNJAkW7nA6SZcp6WJ76wqK4uyDfxSDmq
         Oj5g==
X-Forwarded-Encrypted: i=1; AJvYcCVtPcWnCrTz5Y490LIhTKDUCazOCA+p3mXzUb/6CnlfueHfiHL124oEXIIe1H426aO4ObJVwHFjkFE=@vger.kernel.org, AJvYcCWxXyyU+e4oy4KA1wRsl27wjUCxigG+tfXVRfa71dKCMBgIYZiEVxx+FyGT89ySuEXdPOa1YoKb6qsO6+H6z/7hM8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM7UJEZNW2ISxBWYP9aGhlAGcLpv+u0tVcBIJx0Py5kiPLGDqr
	HAsNMK+QF1H+VJo5xJLhtIoRAEtVZh6u8YYp4JoEXo70XC6IOu3Pa63se1EI
X-Gm-Gg: ASbGnctxawE55dOmc2jywkdybsXv3wdQM3RZ9TYSBMCATWZeAId9TGGvQExWVy3Zgev
	WC5k6eT6H3OEPhl9uIA0Djt7MUPhxdPIFX8zsWchYTxNF1alxO/0gSvjHV+6aTfXGl25wyi4Pl6
	6PymLFERIjqC8q0KJM5FbhPL90Bm02fucTj6gGdT56Nj4gBevJW3iDFE39N7IKFhBUOgJ6kxRDH
	iAs+Gv66PNF42bH23Fke747nDHzsHF+AkLYX++MzXknEWQKQbir2zrniiS6RNHLkARDtNhjTVLg
	4XAOpD05Bcqq2kh9mYxbcoSshNwpSiBFB7j1B8kUHX2Ml9UiyDoa6HP1Ymppwlckc6SCl5hYDmF
	SkbbkhTsyUwc=
X-Google-Smtp-Source: AGHT+IGyU2uNZx5srn0mvnUxqJS6k/68Sjx2zAQXCdB8PqmC/1HfxujhudDPYd8l5V4VJ/nP/kbqgg==
X-Received: by 2002:a05:6102:8015:b0:4b1:14f3:5d6d with SMTP id ada2fe7eead31-4c586f5bf13mr6787699137.6.1743156639845;
        Fri, 28 Mar 2025 03:10:39 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c6bfe5e1b8sm315993137.29.2025.03.28.03.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 03:10:36 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-52446b21cfdso891785e0c.1;
        Fri, 28 Mar 2025 03:10:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUv8FVDYmOrogX87JcvT7xB/UCHNJxkEhg7XlxkVPN09uWjHOSRKONZ9lSdcft41BTCicMhXyKXQJo=@vger.kernel.org, AJvYcCVMrjx2cJH2tAcHROaGrR9EHcazlDaajDUl8/bq8aVi/2pgvsCIM/egQpXcLnbGoa6/LMwuIJIzYRYKt13+XkYl5nA=@vger.kernel.org
X-Received: by 2002:a05:6102:2ad2:b0:4c5:1c43:7cb3 with SMTP id
 ada2fe7eead31-4c5870c8379mr6262371137.25.1743156635888; Fri, 28 Mar 2025
 03:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-6-biju.das.jz@bp.renesas.com> <40392a70-3be4-4d11-8614-eebd5d9d24a8@wanadoo.fr>
 <TY3PR01MB11346C091544B49A6C160712E86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <deffdc35-86cf-4282-ba6d-f36890bf9fcd@wanadoo.fr> <TY3PR01MB11346DA97D5F685D96A638DB086A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346DA97D5F685D96A638DB086A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Mar 2025 11:10:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUacYqUd_iPk95C3+bc64SeMbDj1=zdfLvuMHFbTRS39w@mail.gmail.com>
X-Gm-Features: AQ5f1JoRPSps_8_Qpk56NpaNmth2fteq9Rvk1uoulo0y6tvotRuVutXhACTsZOM
Message-ID: <CAMuHMdUacYqUd_iPk95C3+bc64SeMbDj1=zdfLvuMHFbTRS39w@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros
 in RCANFD_GERFL_ERR
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

On Fri, 28 Mar 2025 at 10:51, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > On 28/03/2025 at 18:21, Biju Das wrote:
> > >> -----Original Message-----
> > >> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > >> Sent: 28 March 2025 09:10
> > >> Subject: Re: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF=
*
> > >> macros in RCANFD_GERFL_ERR
> > >>
> > >> On 26/03/2025 =C3=A0 21:19, Biju Das wrote:
> > >>> The macros RCANFD_GERFL_EEF* in RCANFD_GERFL_ERR can be replaced by
> > >>> gpriv->channels_mask << 16.
> > >>>
> > >>> After this drop the macro RCANFD_GERFL_EEF0_7 as it is unused.
> > >>>
> > >>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

> > >>> --- a/drivers/net/can/rcar/rcar_canfd.c
> > >>> +++ b/drivers/net/can/rcar/rcar_canfd.c
> > >>> @@ -74,7 +74,6 @@
> > >>>  #define RCANFD_GSTS_GNOPM                (BIT(0) | BIT(1) | BIT(2)=
 | BIT(3))
> > >>>
> > >>>  /* RSCFDnCFDGERFL / RSCFDnGERFL */
> > >>> -#define RCANFD_GERFL_EEF0_7              GENMASK(23, 16)
> > >>>  #define RCANFD_GERFL_EEF(ch)             BIT(16 + (ch))
> > >>>  #define RCANFD_GERFL_CMPOF               BIT(3)  /* CAN FD only */
> > >>>  #define RCANFD_GERFL_THLES               BIT(2)
> > >>> @@ -82,9 +81,7 @@
> > >>>  #define RCANFD_GERFL_DEF         BIT(0)
> > >>>
> > >>>  #define RCANFD_GERFL_ERR(gpriv, x) \
> > >>> - ((x) & (reg_gen4(gpriv, RCANFD_GERFL_EEF0_7, \
> > >>> -                  RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1)) | \
> > >>> -         RCANFD_GERFL_MES | \
> > >>> + ((x) & ((gpriv->channels_mask << 16) | RCANFD_GERFL_MES | \
> > >>
> > >> The previous RCANFD_GERFL_EEF0_7 macro documented that the register
> > >> was from bit index 16 to bit index 23. Here, we loose this piece of =
information.
> > >>
> > >> What about:
> > >>
> > >>    FIELD_PREP(RCANFD_GERFL_EEF0_7, gpriv->channels_mask)
> > >
> > > For all SoCs, ECC Error flag for Channel x (a.k.a. EEFx) starts from =
BIT position 16.
> > >
> > > By using gpriv->channels_mask, we allow only enabled channels and <<
> > > 16 says it is from Bit position 16.
> >
> > Yes, it starts at bit 16, but at which bit does it end?
> >
> > The GENMASK() helps to document the register names. Of course is works =
if you replace the FIELD_PREP
> > with a left shift, but you are replacing some meaningful information ab=
out the register name, register
> > start bit and end bit by just a start bit value. See? You just lost the=
 register name and end bit
> > info.
> >
> > FIELD_PREP() is not only about doing the correct shift but also about d=
ocumenting that you are putting
> > the value into a specific register.
> >
> > When reading:
> >
> >   FIELD_PREP(RCANFD_GERFL_EEF0_7, gpriv->channels_mask)
> >
> > I immediately understand that you are putting the gpriv->channels_mask =
value into the GERFL_EEF0_7
> > register and I can look at the datasheet for details about that GERFL_E=
EF0_7 if I want to.
>
> Gen4 has 8 channels (GENMASK(16, 23)
> G3E has 6 channels  (GENMASK(16, 21)
> V4M has 4 channels  (GENMASK(16, 19)
> V3H_2 has 3 channels (GENMASK(16,18)
> All other SoCs has 2 channels (GENMASK(16,17)
>
> So you mean, I should replace RCANFD_GERFL_EEF0_7 with a
>
> Generic one RCANFD_GERFL_EEF(x) GENMASK(16, 16 + (x) - 1) to handle
> this differences
>
> Where x is the number of supported channels(info->max_channels)
>
> and then use
>
> FIELD_PREP(RCANFD_GERFL_EEF(x), gpriv->channels_mask)

Just use

    #define RCANFD_GERFL_EEF    GENMASK(23, 16)

and

    FIELD_PREP(RCANFD_GERFL_EEF, gpriv->channels_mask)

As channels_mask can never have bits set for non-existing channels,
all reserved bits above EEF in the GERFL register will be zero.

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

