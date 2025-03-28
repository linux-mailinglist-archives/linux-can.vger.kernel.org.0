Return-Path: <linux-can+bounces-3265-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B233A748BC
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 11:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAFF11898745
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A23215040;
	Fri, 28 Mar 2025 10:54:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA94213237;
	Fri, 28 Mar 2025 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743159251; cv=none; b=quTKLXOvgCtCkaUgJFGM8Ihdj2Wrh0t562x0FfZBOeCy3sNaNsYiffBQYrCMtJSd4/hfO0S5yzpQ8I8MdxbDYVB6Wp/XCU+3BYkP7zzM+7gY7ZaqR6I4WpqYgvqfivyC6+6lhV2FLuUPXJJ8uemUHIyc6LYRq7t9WA2oEIfasMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743159251; c=relaxed/simple;
	bh=vJXOUm3e30DYF79lo+AbmupyoyAtXPggoEK2uY+416w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmVOAZC97MF7hNBVj/IyOOYFyiLCrFVNF7AQpO8wKKmVKvXDTISCnHOSL/LPFEVEjtfgaRB3RIiW61h8ezBQUxQyAdedeTAEy0UE7sv2T+DaILLHA4d345m7SA7qPLj3PwvS0vn9MnBDisGPwZLJg2o6Lj616qASDozuX8JyVvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-523dc190f95so1021518e0c.1;
        Fri, 28 Mar 2025 03:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743159247; x=1743764047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ZD2zCXfu8f1Q7njk9I/6vI7xEwTvUpMJtXBabLn7wM=;
        b=eUeSUMW7LPJrp6IZcXIgdc/IJc9lwOMfYSjw3XKdT4K+U/oYt4wZlm4g2DrgfMsObz
         PA8kR8fJG9anWgAXJP/eRhK2UfPi4qllIJOezyyncGwpDVaeHpgTb6kbatzonU7hxgt/
         D2dRjQ3WjTAdo1mCk9h9JC/F2xkmkKd20yVxApV4ZtC9TbbT/ZYDJ2tIDNE4v80lz6+J
         czCjaFQ1A8sZrq3UF2W7bUCW/BRID/GxTgOaWXyXyu42IYMuT/1Pzt89/E3wUhHxaH6T
         1fmXDaTEMgkIbRJUo+T3CafAd7iFr3PXqeKuTdM/iwna4BjseGkHhHek/JApS0H1zqlX
         9mrw==
X-Forwarded-Encrypted: i=1; AJvYcCU88vE1FNWm+zjZ5Fux2Tq2FRsEKspwqP28pkX6kHHyVOBFJBiQnfsXxpnoHImLk7XUXUPcmVB9gsw=@vger.kernel.org, AJvYcCUbXf9t/SD7QUY+hw02zg2D8PS4FeLyYbUWrX77pCc9dUlAPGrW0/c3uKnxTQ6qTXMSDxljuKf3ITjl8C+sSxHwLPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQc/53ewr8XtLzhGqaT8cJxDMBxOv7h2ZsLPvyqHC0duvv11O2
	95G/je8A4G8wdzsjs8xlF/nwcbZPYK+qFpTx8XmBnOdA3IKydnR5HOwcYzgX
X-Gm-Gg: ASbGncvF+hhX6kiGx/NEuxELb1ezGrRzMC44ZfVMzycwxQ/OO5ciIP8W9gCKgQdBPDA
	NVEWLFcgMhuSTVxVVZuyprTwTZcFcVxNzFXcSSDvucVVUQso8xzR8xaih7I+CmbAPAzjsgQH7as
	LGrTKvw1NJs0bWko2QvV6zbUG0M3khVSzqslKB3T6FnEgNYygI+orkf8xCpyg3uTDFhS418V7YZ
	Feb5Q1Cgk+PbvyPCOs7AlnZC1REWVeY8SuzlYnnSnP8lbq0p4NSikJ6a38M0ibO6lqzQifAYvax
	ftyDOrsDzMOcKPwYzE5sQuRw4tUwbxpdcRKISY7fH/5bvcWXHV9N8iH8c+NKIMDMxkPC3mCnCb3
	i3O96i/U=
X-Google-Smtp-Source: AGHT+IFq9IfrBSLTkOgHjzZAHD7MlJ0Ui7v/D2bGzHa2CrCh0sl9ifxANTwSUf/VlpE/srGa51HaFg==
X-Received: by 2002:a05:6122:4897:b0:520:5a87:66ed with SMTP id 71dfb90a1353d-526009598damr6537052e0c.5.1743159246752;
        Fri, 28 Mar 2025 03:54:06 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-871a33b28e3sm317439241.30.2025.03.28.03.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 03:54:06 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86d377306ddso838002241.2;
        Fri, 28 Mar 2025 03:54:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXYSSKfNT/pv8qBTFb7RUMrUpqmtCGnS1cuucDkiyBYnrm6DN65zYv95lEC1oVLoErWrf+yz/XRi/g=@vger.kernel.org, AJvYcCXZU/e2jOtZhvmu6okodoVA58/Jayxbmdi0rIOTPYuCLvqCa+FPGy8XgE1AAnG8HNIcr1h50seDhcqmQDPx7EF8Ems=@vger.kernel.org
X-Received: by 2002:a05:6102:4407:b0:4bb:4c52:6730 with SMTP id
 ada2fe7eead31-4c586fbaf67mr4918794137.12.1743159245693; Fri, 28 Mar 2025
 03:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-9-biju.das.jz@bp.renesas.com> <ee0f8bff-6dc4-4ddc-a2d2-89ed6fddcc8f@wanadoo.fr>
In-Reply-To: <ee0f8bff-6dc4-4ddc-a2d2-89ed6fddcc8f@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Mar 2025 11:53:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWYTTpmwXdUpQnm8HWFWnDGp1M6mHn8jqUKFU5z_2Q2Sw@mail.gmail.com>
X-Gm-Features: AQ5f1JqO3jjyQbXYAyJ2G64QUgkGevm5fy7rh0sszZPaDxyZB0llAmUX_8XGb1Q
Message-ID: <CAMuHMdWYTTpmwXdUpQnm8HWFWnDGp1M6mHn8jqUKFU5z_2Q2Sw@mail.gmail.com>
Subject: Re: [PATCH v7 08/18] can: rcar_canfd: Simplify RCANFD_GAFLCFG_SETRNC macro
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Fri, 28 Mar 2025 at 11:39, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> On 26/03/2025 at 21:19, Biju Das wrote:
> > The shift values in RCANFD_GAFLCFG_SETRNC are dictated by the field width:
> >   - R-Car Gen4 packs 2 values in a 32-bit word, using a field width
> >     of 16 bits,
> >   - R-Car Gen3 packs up to 4 values in a 32-bit word, using a field
> >     width of 8 bits.
> >
> > Add rnc_field_width variable to struct rcar_canfd_hw_info to handle this
> > difference and simplify the shift value in RCANFD_GAFLCFG_SETRNC macro by
> > using a formula (32 - (n % rnc_stride + 1) * rnc_field_width).
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

> > --- a/drivers/net/can/rcar/rcar_canfd.c
> > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > @@ -89,7 +89,7 @@
> >  /* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
> >  #define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
> >       (((x) & ((gpriv)->info->num_supported_rules - 1)) << \
> > -      (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
> > +      (32 - (((n) % (gpriv)->info->rnc_stride + 1) * (gpriv)->info->rnc_field_width)))
>
> I can not follow how this is the same. Let's take the gen4 as an
> example. Before:
>
>   (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8))) =
>   16 - ((n & 1) * 16)
>
> So, I have:
>
>          n      shift value
>         ---------------------------------
>          0      16 - ((0 & 1) * 16) = 0

16

>          1      16 - ((1 & 1) * 16) = 16

0

>          2      16 - ((2 & 1) * 16) = 0

16

>          3      16 - ((3 & 1) * 16) = 16

0

>          4      16 - ((4 & 1) * 16) = 0

16

>
> After:
>
>   (32 - ((n % rnc_stride + 1)) * rnc_field_width) =
>   32 - ((n % (2 + 1)) * 16) =

You got the operator precedence wrong: should be (n % 2) + 1 instead
of n % (2 + 1).

>   32 - ((n % 3) * 16)
>
>          n      shift value
>         ---------------------------------
>          0      32 - ((0 % 3) * 16) = 32
>          1      32 - ((1 % 3) * 16) = 16
>          2      32 - ((2 % 3) * 16) = 0
>          3      32 - ((3 % 3) * 16) = 32
>          4      32 - ((4 % 3) * 16) = 16
>
> Is there something wrong in my calculation? What am I missing?
>
> More generally, it is really hard to review and understand what this
> macro does.

It prepares a value for storing in a 16-bit or 8-bit field of a 32-bit
register, where the fields are numbered MSB-first.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

