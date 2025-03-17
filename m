Return-Path: <linux-can+bounces-3113-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D490EA64845
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 10:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27BB618857C7
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 09:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0587219A67;
	Mon, 17 Mar 2025 09:53:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1392582D98;
	Mon, 17 Mar 2025 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205228; cv=none; b=GpuWWRcdzhTiIKa2g+LzWbx25eWD4nZVxnu2GmgWcId/GghsI0xHc+hfic/TLoXwkjK6WY3/BCUoGhDjgG0/nG3NcBNmkV6aJcqVymD9IEBWhl5nhUzML+SdDtMFslfAhQNqE8X2Ndp9ByuGPusK8WpHm3OZT9GxJVzI7Q11riM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205228; c=relaxed/simple;
	bh=NuMEqmDs3UaFG+cuNtwlV04NFx1fnRYKQFCE4M/UnP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBMrhN1FZbv26RQcIEk9dchmMZhX8kQS72AkXv9GyL/R1qsQISA8LlxTRkUsTbsl8ILZHhcRoqj4tfOHOhSdxHjZb/AmmupewA6pP2l+yHCyZZp5b9PpgM+TmUFP71tnd0gcZz3hLHqDJPbbEBm/WHx0xRcXm7dsshcxFASCBQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-523eb86b31aso1727747e0c.0;
        Mon, 17 Mar 2025 02:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742205224; x=1742810024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypdIYB47hN7WUW9+hg/WKEOD9mxiK+T7ak5deopKE2k=;
        b=wlGs6kbiv2bLGLi9ZBs/e1bUY5j/167GLo1v3RgEDYP5McodCNtGGTVTB97NCt3Et0
         taddOdroG0yzndwKyluAk3clLXcfuoD46L2sW3WNZc/Z562UbugyfGDUu0ZPVrOE6KVo
         M5gxQQPkay0+7wvWn7wCNSohwhrUiDdqxDHhYyjrkPAdPpLNZAVgpgpmlFr7GJwzGw+m
         NsV81gNwYBKlaJgyImuDDeMQ4oP3eLg2luSDa/dWvqYWwYKkW0hcJZbH0jMzf0f7tJKA
         gs+0SUe/n3nIk1IRnyRq5mzMYJptKubk5qA8FfIeJh0U4sS+YCT2lC1z3bp2e77G8wab
         2jBg==
X-Forwarded-Encrypted: i=1; AJvYcCViNdn0/a8Vnl/kANm6y4K085QMPSh2OXDnD1dhGXAaYnzIajKod+zJuBfGpsLdXdWArOZEb4k6b7o=@vger.kernel.org, AJvYcCWFpgY0VEjuSN3TktS7RpIRY+JMlAysYMGTrsKTV2YF9SjzCPv1ritC1pJxoFN8GYSjecNjNjRt2QuoCvO19+SpphM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1dQTbrCUNdQRtxOPW9d58lTpgAgn0guifxB0XzRin/OLxod9t
	Pvm1qZssLhL28pUJGnWAytPOoTsIjat/FQ5MzL5Yof88Blao4qIGe9/ZaOEn
X-Gm-Gg: ASbGncvQ8HpNNkNiqdiuQjaSiIY06dvOhk+yxuv44OPUcFNtpHY2isF7Zk1XxHB9NFu
	ZRpHr8peMffETY2PFWsmKFU46WgPySE8wWERkD8xrogyfk0Jf1KEZpvVhulJQSobxHW1ZoUfXrP
	YYNxncBGHEZwuT6Om29yjHzvhOBG/rMZNb/RzjXXSpa+VttrymML6B3sh0ZJ2LO6TGnSw+FnUo0
	5uCGXQn7K7H/KXzJAKXIZMXRMlOAzp71HciIs1IocT8N34phgzEHheHGOhueoVmiiGRtTQEOa+w
	VVO++1Iighyoqu2lP0Q4Ka50RPRua2l9LBi1NBQqsyL91cf5DBDzF7zrrwMDBfQAJs4lNtivCZr
	v08KfWSQ=
X-Google-Smtp-Source: AGHT+IFSd6HGaRP5ac1pXaX8owrVZYusSSYt6ZoPVie5lgkTM3NT6gZEbzcor7UeAmScAD4qPWMm1A==
X-Received: by 2002:a05:6122:2487:b0:520:42d3:91bc with SMTP id 71dfb90a1353d-5244986cce8mr7245166e0c.2.1742205223868;
        Mon, 17 Mar 2025 02:53:43 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a6e4c1asm1519475e0c.33.2025.03.17.02.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 02:53:43 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86b9ea43955so1760451241.2;
        Mon, 17 Mar 2025 02:53:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjdlmO3IZL/6FQHMEaAFSK5MRyo3LRewNprLFT35anNaYqDBjtiGgEee1ZDwshjbhtAKLZ8JsYGClMVJWqwdX8+dk=@vger.kernel.org, AJvYcCXJ0SNL/i/1o/DbdAxwSpFWYB1AW+Xjkj5VPYKG/EfK8uOXKuqKT9QuwYhpqi/AWbM25HO3Xiw5enM=@vger.kernel.org
X-Received: by 2002:a05:6102:148f:b0:4b9:bd00:454b with SMTP id
 ada2fe7eead31-4c3831621ccmr7848559137.13.1742205222941; Mon, 17 Mar 2025
 02:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
 <20250306124256.93033-9-biju.das.jz@bp.renesas.com> <CAMuHMdWk5vXSMSz15NBM+dxYRNyov2jFUAOKDrCANLVzJ5-AtA@mail.gmail.com>
 <TY3PR01MB113462D2249AB5B239E8213E286DD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdWB0N6a_0yfr-e+M1CTmvDy473x+RSvbi++b+oSHWgp3Q@mail.gmail.com> <TY3PR01MB11346DE82F59414FFE322F88286DC2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346DE82F59414FFE322F88286DC2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2025 10:53:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVWAvbJ=uO-ebPc+saXbvARRdfR-xiNLxj2Vr+iPHphtw@mail.gmail.com>
X-Gm-Features: AQ5f1JppQ6V2OGOufe1Zsy06an_OkD5SgjV34Cy24G1yEgZlW4UjQrMvvrbLnds
Message-ID: <CAMuHMdVWAvbJ=uO-ebPc+saXbvARRdfR-xiNLxj2Vr+iPHphtw@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] can: rcar_canfd: Add shift table to struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Sun, 16 Mar 2025 at 18:02, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Sat, 15 Mar 2025 at 18:31, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > From: Geert Uytterhoeven <geert@linux-m68k.org> On Thu, 6 Mar 2025
> > > > at 13:43, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > > R-Car Gen3 and Gen4 has some differences in the shift bits. Add a
> > > > > shift table to handle these differences. After this drop the
> > > > > unused functions reg_gen4() and is_gen4().
> > > > >
> > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > >
> > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > >
> > > > A suggestion for improvement below.
> > > >
> > > > > --- a/drivers/net/can/rcar/rcar_canfd.c
> > > > > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > > > > @@ -90,11 +90,13 @@
> > > > >  /* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */  #define
> > > > > RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
> > > > >         (((x) & (gpriv)->info->mask_table[RCANFD_RNC_MASK]) << \
> > > > > -        (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
> > > > > +        ((gpriv)->info->shift_table[RCANFD_FIRST_RNC_SH] - ((n) & 1) * \
> > > > > +         (gpriv)->info->shift_table[RCANFD_SECOND_RNC_SH]))
> > > >
> > > > Both shifts are dictated by the field width:
> > > >   - R-Car Gen4 packs 2 values in a 32-bit word, using a field width
> > > >     of 16 bits,
> > > >   - R-Car Gen3 packs up to 4 values in a 32-bit word, using a field
> > > >     width of 8 bits.
> > > > The odd split in two shifts is due to the MSB-first numbering of the
> > > > fields.  Hence I think it would be better to use a field width
> > > > parameter, and derive the proper shift value from that (like you
> > > > have already done for ICU ;-)
> > > >
> > > > Note that the formula will have to be reworked anyway to support the
> > > > third channel on R-Car V3H_2, as "n & "1 will no longer fly here...
> > >
> > > Agreed. Will introduce rnc_field_width variable in struct
> > > rcar_canfd_hw_info and Simplify the calculation using the formula (32 - (n + 1) * rnc_field_width).
> > > Which will work for third channel on R-Car V3H_2 as well.
> >
> > Note that you still need to mask n, as n can be up to 7 (on R-Car V4H), while the register holds only
> > 2 or 4 values.
>
> OK, will add separate patch for fixing
>
> -#define RCANFD_GAFLCFG(ch)             (0x009c + (0x04 * ((ch) / 2)))
> +#define RCANFD_GAFLCFG(ch, n)          (0x009c + (0x04 * ((ch) / (n))))
>
> Where n is gpriv->info->rnc_per_reg.

I think you better pass gpriv instead of n, i.e. RCANFD_GAFLCFG(gpriv, ch),
for consistency with other macros.

> and SETRNC is simplified to
>
> #define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
>         (((x) & ((gpriv)->info->num_supported_rules - 1)) << \
> -        (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
> +       (32 - (((n) % (gpriv)->info->rnc_per_reg + 1) * (gpriv)->info->rnc_field_width)))

FTR, gpriv->info->rnc_per_reg == 32 / gpriv->info->rnc_field_width.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

