Return-Path: <linux-can+bounces-3868-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1A8AE027B
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 12:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BAF1BC4C32
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 10:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDE121FF2A;
	Thu, 19 Jun 2025 10:16:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3461E21B9C3;
	Thu, 19 Jun 2025 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328178; cv=none; b=gLjCP6vNkmT19WY8VIygM0UmKdxlkdhsZW3wfmP0DhpssGMimX7pD69dIjY4LZbiacva5Sghjd8czG2S3RNU8qsL2V9ueVB8sXRQ280Zl4BsGLVnFBTeaX2bOtHgxmxQ3JpdaLRnBHTTXvBTW4RebO5s6kIVCVEjyT+FVNl0ngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328178; c=relaxed/simple;
	bh=Avzj1zqS4kca1mybN0Kx52WRTHzW7BMvvPF/8Zui8lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avaZGyXoJxyBtY46MmSbfdyVD+lXiENuaE28hN5b/JJkzcQIX+ezzOCIHGnXCPqfzcvGrKbtP4L18q+kRD7t1yNDbaPGvXMrexxEBFr+Sn9bHeg1L8VcX8QIBcKvo0gwWlDv1N+4/6kLhgxcDxFuV/dgtASo6F1G7K5g/mk9mi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4c4fa0bfca2so185191137.0;
        Thu, 19 Jun 2025 03:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750328174; x=1750932974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/JOICuu2gPOtPUvflk6JV6zr6m+LGTAvZ6c4+m0ys0=;
        b=avQx54cZYItBkaNc5pnch0fKn44Io98xBpp8lhyt36j14EJqHYStxEGFA+iNIVIAIw
         ZSvF8ZKWbUw4OrrO6wSL+WvYVT8BkXSnXsdsudOzwYBZEBE/aZRZFDsvD0HTK5q/PaKu
         NAFh+RorSCnZj0KD5icdJuXcJSJHzIDIHv4uWaWoT+lqlRPmYlBUtzWi8HuJMmpOaL+J
         mBZIxhZw7Kqyg/JxDdclVQ1R3jsE8r3/tvZzV922VTvSQ8rZeHSeCHr5nGRW5jMV+dXE
         QMesKIA63Z8GGamQ2kLcdkzLLLUJp7ThchKWLvDE2EuiXBPx4jUB4v3E8d4wttUIdLER
         fndQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr4be8jsKezjpTrMWBoyEoN/szzCeibDoxreePSZkMPJKKx1g9lmtus7jqLQqRwFAnPvlcidSueto=@vger.kernel.org, AJvYcCXZsFn11Vmsg8zjefS0XCatKe+sVdZ9eYlgsb1ftFHD55GE8+9d8J3LZmcLBpQ6x7ee3Ifl26U/@vger.kernel.org
X-Gm-Message-State: AOJu0YwaVIG1ZV1iCKO56uWiAVCnJsyO/0uwpOgS7HgvxCgoyDzB4kn6
	0AeOHnW/E0XsS0ocZCGJX++K0KHPqT6IDyQbGv+WOck2tpCJHtpNW9hEm9p8rubR
X-Gm-Gg: ASbGncvhOzjWIecwoDtFULhzmMU9fm9pe0/FNUaZFu7OB2wB1e/51TY6T0zJt5BYFn6
	nik7DtkGj9NGDSbuu581r5A+uzApXs+6X/5Tj+IifbochuV68dIe5iSYzRgu1VlQ5lxJpRdcS4l
	shqJfVUDxNfNSqiBv/K56nIGt49cf+QYwJGwix1vVAkHqrLmD/OOclmyDgC562FKMjMHxXx7mAl
	BoiocDZ1teWAzsrf2jwoQ925XSnpMpkOdI9WvckXSrHAWLCehZ8mEfDlKqD82SlT50e6eQmYZHg
	3LavR8juxR5Y7tWjnKtrl9M7fLOFcZ+CZPd0hNRv8ObgpHkgMn5WEhx6XoTpamvx4h6Kr5qnBCt
	ae/7iIgbOVwO8q8ev8ABbg/i+
X-Google-Smtp-Source: AGHT+IE/Er2SK/g0owCafLnksla+v/vxhbM0Dsoig+dDhZm/pbWaUAcfdvR0nM/RrIbAohjP0LBBMw==
X-Received: by 2002:a05:6102:5792:b0:4e6:d9f2:957c with SMTP id ada2fe7eead31-4e7f6213469mr16778455137.23.1750328174065;
        Thu, 19 Jun 2025 03:16:14 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e7e6bf189fsm2300868137.6.2025.06.19.03.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 03:16:13 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4c4fa0bfca2so185183137.0;
        Thu, 19 Jun 2025 03:16:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnuIchpa+Jq8uIvyxtizqZHvhiq4gNN5ccwwAw0FcleDRR2P0TLpBFxLaPabZN/NP8XokY5T26E8A=@vger.kernel.org, AJvYcCWVzvXf2nEaXnPgygLvtLsBnyJJhmYeXPZIvMK62UanorcyxK3Z5CahIjL/q7m9AjWOKEj81UFw@vger.kernel.org
X-Received: by 2002:a05:6102:2927:b0:4e5:ac99:e466 with SMTP id
 ada2fe7eead31-4e7f61ee7admr13758663137.18.1750328173352; Thu, 19 Jun 2025
 03:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618092336.2175168-1-mkl@pengutronix.de> <20250618092336.2175168-7-mkl@pengutronix.de>
 <20250618183827.5bebca8f@kernel.org> <CAMZ6Rq+azM63cyLc+A3JLwVCgopOcu=LSGfmBQAbKrkJzmFYGg@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+azM63cyLc+A3JLwVCgopOcu=LSGfmBQAbKrkJzmFYGg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Jun 2025 12:16:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU=7YUZgcwK_annDigTgE9YqQ=sxjtF9ttAGzPV-7wR6A@mail.gmail.com>
X-Gm-Features: Ac12FXylRT3ykY6PLHhldaA4cW3VzAS1lBKfFH4p3289RHaWJW2qhwj6JFW4oYc
Message-ID: <CAMuHMdU=7YUZgcwK_annDigTgE9YqQ=sxjtF9ttAGzPV-7wR6A@mail.gmail.com>
Subject: Re: [PATCH net-next 06/10] can: rcar_canfd: Repurpose f_dcfg base for
 other registers
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Jakub Kicinski <kuba@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org, 
	davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vincent, Jakub,

On Thu, 19 Jun 2025 at 06:43, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> On Thu. 19 Jun. 2025 at 10:38, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Wed, 18 Jun 2025 11:20:00 +0200 Marc Kleine-Budde wrote:
> > > +static inline unsigned int rcar_canfd_f_dcfg(struct rcar_canfd_globa=
l *gpriv,
> > > +                                          unsigned int ch)
> > > +{
> > > +     return gpriv->info->regs->coffset + 0x00 + 0x20 * ch;
> > > +}
> > > +
> > > +static inline unsigned int rcar_canfd_f_cfdcfg(struct rcar_canfd_glo=
bal *gpriv,
> > > +                                            unsigned int ch)
> > > +{
> > > +     return gpriv->info->regs->coffset + 0x04 + 0x20 * ch;
> > > +}
> > > +
> > > +static inline unsigned int rcar_canfd_f_cfdctr(struct rcar_canfd_glo=
bal *gpriv,
> > > +                                            unsigned int ch)
> > > +{
> > > +     return gpriv->info->regs->coffset + 0x08 + 0x20 * ch;
> > > +}
> > > +
> > > +static inline unsigned int rcar_canfd_f_cfdsts(struct rcar_canfd_glo=
bal *gpriv,
> > > +                                            unsigned int ch)
> > > +{
> > > +     return gpriv->info->regs->coffset + 0x0c + 0x20 * ch;
> > > +}
> > > +
> > > +static inline unsigned int rcar_canfd_f_cfdcrc(struct rcar_canfd_glo=
bal *gpriv,
> > > +                                            unsigned int ch)
> > > +{
> > > +     return gpriv->info->regs->coffset + 0x10 + 0x20 * ch;
> > > +}
> >
> > clang is no longer fooled by static inline, it identifies that 4 out of

Oh well, that explains why someone pointed to a CI log showing more
unused functions in a different driver.  I hope it only does that
for unused functions in .c files, not in header files?

> > these functions are never called. I think one ends up getting used in
> > patch 10 (just looking at warning counts), but the other 3 remain dead
> > code. Geert, do you have a strong attachment to having all helpers
> > defined or can we trim this, please?

I would like to keep them (or at least the information), as it serves
as register documentation, just like the macros they replaced....

> I had a discussion with Geert on these functions here:
>
> https://lore.kernel.org/linux-can/20250613-misty-amethyst-swine-7bd775-mk=
l@pengutronix.de/t/#mef5cb235313c5f0c4910d5571b052eb5e9ada92e
>
> in which I made a suggestion to reword these. That suggestion would
> actually resolve your concerns. Geert was OK with the suggestion but
> we agreed to move on as-is and make those changes later on.
>
> If temporarily having those static inline functions unused is not a
> big blocker for you, can we just have this merged and wait for the
> bigger refactor which is on Geert TODO=E2=80=99s list?

I am still working on converting more ugly macros (while increasing
functionality, and fixing bugs ^-).  But given the clang warnings,
I agree it would be good to fast-track the first conversion.

Patch sent: "[PATCH] can: rcar_canfd: Describe channel-specific FD
registers using C struct"
https://lore.kernel.org/292b75b3bc8dd95f805f0223f606737071c8cf86.1750327217=
.git.geert+renesas@glider.be

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

