Return-Path: <linux-can+bounces-704-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8178FE591
	for <lists+linux-can@lfdr.de>; Thu,  6 Jun 2024 13:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9758A1C23C8D
	for <lists+linux-can@lfdr.de>; Thu,  6 Jun 2024 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D66178399;
	Thu,  6 Jun 2024 11:38:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1072414E2F1;
	Thu,  6 Jun 2024 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717673921; cv=none; b=IJ2MjGU0/Gc7CaMcXHvlXn+rh2mQ/j9t/ociYEhVZgRytnsRhIBvB3isd/Dkz4vumFEpp9dabtaQPiVGAGKp4HF1UjN0/Ioh5PhDy2H1Bcxsuc+hhDG0C4QvI/1THZHi+BC5te/7pJBFIX47XAGpfmDOcDMZaD17aTbyVnK6tp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717673921; c=relaxed/simple;
	bh=3ObHWaRVR4jM8iyiq5AY3IthBtWgCZEvXy8aA7zeAv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcdGHQv+i6oZAzTw6W0JTW3v26qHKAtGtVFqh/oCErT+RZ4VVl0OdXaSFeFSuKeZWgp+A8wAaOF31IMo7jWrmVJZQaKRCyWrK/NqhhIqVCNZQXqqKIFFovmf3uvFU2zV3t34ZUw98pixYsinIWKgcYYQUsC6POSX+IfHYYlMq18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a145e0bb2so8233817b3.0;
        Thu, 06 Jun 2024 04:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717673918; x=1718278718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KyiadWuwWcKVlPoXwg0zdSfOmhmr3naUVrDuQJaRpE=;
        b=qzsHqNhoPf7EcWMlelYa6NA2tAW43SRxESQj3GX9ICAWcAVg0/oHB19Um65m2Ew3gR
         fjYtlp6JoVjT0XMdBVLiGuUhenFCPAmrLv36bVnaFzdWJRLGJcxkzfoJlkEfuygyJ6nY
         rw7A6GP4u6MrhlhwymkVU1L5DdBY6jHGQ8U2mIB37Zyi+RD+K3i5YNBDK1QLUmjmupeF
         dAi8izb2diK6lR6j1c8EOeNkoLF63dNRE3dmZYsZCQ3oqC/G+KvL7fITVXXPQHneiia/
         Csa/5+l0d7ErdoK694DaaDHfCx54qUccI158tzpOjdy4rBWtYN/v7mEKs63GkGwXKXnj
         7kFw==
X-Forwarded-Encrypted: i=1; AJvYcCV+UHzxr89HjAD7idLwJ36i4wBWTRap8lW0pB9WYL1oIgEBKq54MUdThh6yD/ti7opLxD3X+PBwJp4IlBlYYOj/vIhhOIauavY7If3tCJ9+dYVFFriXvgvOlrMTaq1f/geWZ3gBEAhSsbMtvfDS+zU/+x0YJDTAPNlwmv7NYMft1U4BCs8=
X-Gm-Message-State: AOJu0Yznqu1Rm7q72caFDNarxCG+q7jyn/4yJG/lYClQGV6AaOkv9Stl
	Wxf3inh9au5E9aoIUFiHFMI+D446tPQL3boidnESvhxuwJxP+CemzjxCBJvI
X-Google-Smtp-Source: AGHT+IG3wRE5QNbXIO3+XBMPgUPELfAl2ioOHqZ02JSBi08nclpu68WvhZjuhosu7GRKn7rqIb4H9A==
X-Received: by 2002:a0d:e0c7:0:b0:62c:c660:72af with SMTP id 00721157ae682-62cc6607301mr26426037b3.24.1717673917579;
        Thu, 06 Jun 2024 04:38:37 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62ccaeaef45sm2116737b3.116.2024.06.06.04.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 04:38:37 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-df771959b5bso913639276.1;
        Thu, 06 Jun 2024 04:38:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9yWBBCwD/3a28d7BnSaqRSfbM6Rvs7O/cEZhTYZghwHTsQyReMIgeXhDgYx2/XuQU4C2MrblLuV/gWuYUUL+giEZetcfna15jlGrrLDdydzD9Z4wuiJ0wQz8YThwYI1dW5bBwrfxq8/LusdEly/pnmqMyURFKeq0YfYSLaS7QeWmL+Zc=
X-Received: by 2002:a25:dfc5:0:b0:dfa:c607:1b6a with SMTP id
 3f1490d57ef6-dfacac75c1amr4911584276.31.1717673917184; Thu, 06 Jun 2024
 04:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716973640.git.geert+renesas@glider.be> <2cf38c10b83c8e5c04d68b17a930b6d9dbf66f40.1716973640.git.geert+renesas@glider.be>
 <CAMZ6RqKZdo1Mk=tY-vqCm0YYr_Qk8m53+LHXqeM+1LL=S=+RqQ@mail.gmail.com>
 <CAMuHMdXV9q2D=Mhfi7s4NBuvivxBap-k_pkm4pUseoUb3SLWqQ@mail.gmail.com> <CAMZ6RqK32+i69Rd3qDDNm4cgQa3+m3ikZTbpt5jCGrkNt76+vw@mail.gmail.com>
In-Reply-To: <CAMZ6RqK32+i69Rd3qDDNm4cgQa3+m3ikZTbpt5jCGrkNt76+vw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Jun 2024 13:38:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWCAU7VK97d3yOALpgg7S9+Aa3ZKwC3VVsivUev1iA+Ag@mail.gmail.com>
Message-ID: <CAMuHMdWCAU7VK97d3yOALpgg7S9+Aa3ZKwC3VVsivUev1iA+Ag@mail.gmail.com>
Subject: Re: [PATCH 1/3] can: rcar_canfd: Simplify clock handling
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On Thu, Jun 6, 2024 at 1:05=E2=80=AFPM Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
> On Thu. 6 June 2024 at 19:15, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> > On Sun, Jun 2, 2024 at 10:03=E2=80=AFAM Vincent MAILHOL
> > <mailhol.vincent@wanadoo.fr> wrote:
> > > On Wed. 29 May 2024 at 18:12, Geert Uytterhoeven
> > > <geert+renesas@glider.be> wrote:
> > > > The main CAN clock is either the internal CANFD clock, or the exter=
nal
> > > > CAN clock.  Hence replace the two-valued enum by a simple boolean f=
lag.
> > > > Consolidate all CANFD clock handling inside a single branch.
> > >
> > > For what it is worth, your patch also saves up to 8 bytes in struct
> > > rcar_canfd_global (depends on the architecture).
> >
> > True.
> >
> > > > @@ -545,8 +539,8 @@ struct rcar_canfd_global {
> > > >         struct platform_device *pdev;   /* Respective platform devi=
ce */
> > > >         struct clk *clkp;               /* Peripheral clock */
> > > >         struct clk *can_clk;            /* fCAN clock */
> > > > -       enum rcar_canfd_fcanclk fcan;   /* CANFD or Ext clock */
> > > >         unsigned long channels_mask;    /* Enabled channels mask */
> > > > +       bool extclk;                    /* CANFD or Ext clock */
> > > >         bool fdmode;                    /* CAN FD or Classical CAN =
only mode */
> > >
> > > Notwithstanding comment: you may consider to replace those two boolea=
ns by a:
> > >
> > >           unsigned int flags;
> > >
> > > This way, no more fields would be needed in the future if more quirks=
 are added.
> >
> > Using "unsigned int flags" and BIT(x) flags would increase code size
> > by 8 bytes (arm/arm64).
>
> I am not sure where you derive your figure from, but looking at the pahol=
e:

pahole shows the size of data structures.

> > Using "unsigned int foo:1" bitfields would increase code size by 16
> > (arm) or 12 (arm64) bytes.
> > So as long as we can fit more bools inside the hole, it is more
> > efficient to do so...
>
> I do not get this either. Where did you get your 16 bytes from? If I do:

I also looked at code size[*]: while storing bits takes less space than
storing bytes, processing bits may require more instructions than
processing bytes (depending on the architecture).

[*] size drivers/net/can/rcar/rcar_canfd.o

> But just to reiter my previous message, these are notwithstanding
> comments. I am fine if you keep the patch as-is ;)

So I'd like to keep the patch as-is.

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

