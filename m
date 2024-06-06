Return-Path: <linux-can+bounces-703-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C77C8FE4DF
	for <lists+linux-can@lfdr.de>; Thu,  6 Jun 2024 13:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD121C23C67
	for <lists+linux-can@lfdr.de>; Thu,  6 Jun 2024 11:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB0B194C9A;
	Thu,  6 Jun 2024 11:05:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ED61922CA;
	Thu,  6 Jun 2024 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717671912; cv=none; b=qbYb+sTHyW1+WmdaK32CajzPzbdyr8Rm7etCfPtvg45std+evCUTPxyONS25+Yd0hvWLoe2wL5Fi61H3bRkymelmjSY9t9mp0ZXprjYifyxG7EvRI6PPHM1cLxMRO2mWS5xpAS75GHjuWiuJBO0dzaFxFCJHZhHsqEqwgH9yeWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717671912; c=relaxed/simple;
	bh=CtU6PkAiXt1tm2tia7A+TYEez2ihXxxskRZin6bEYZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g71N+CeTpEa7CtAHaQwf7O8Fyi/vzYH5qNJeApIoNGdgGGWs4Uwvru6VPZnto9yBDpwxZbXosiqwYIqI1JbfepH1gFs1fFWwntlWg5wjoStxBRwGBBciQ6aWFFPM/992Zl3JsvNyyZO4jzAH8G32dCnwZhHuPheL0mVmWQaN3IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7025f4f4572so1448510b3a.1;
        Thu, 06 Jun 2024 04:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717671910; x=1718276710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bflXmSi7eryx3IutiZnVV6UwS2elHr4HGVzH+xQaNuo=;
        b=XmpY1OmqQK/lg7P11hhACVVyoHt4FWwwXEEtxr12H8zEjYyg5Me90eIqBVpG0cNyys
         rFQ87QTCRooL9ycXBYKcxkgRTG3HdZv8LJtRMFwRSCK3ETYhlSRFIbBPGDdhKrFztRvq
         iZIUuTx4UhLdMk4w4CO0ZUfMZAk4uhX3O7wKBxEndXadSQxAMUri+psOZewtVa1X26vC
         /pZ9m8wX/b5g88tIf5yUV2nFRh2CSRCsIp/aLYYByn2z8EA558FFP11SNT5OFM6z9tta
         gmGU9Hg01pkMNnNRYvl/PZ8LQi69BZVydM40VnNSvLBb2vI+9zAlJxLmYpVTAu/QCWAu
         eiug==
X-Forwarded-Encrypted: i=1; AJvYcCW7mQuSKoeMXIvf9utt6/Tlw39sAfYd6TqowXsOnySBz5FKo3u3B4DXfgALEhYJTkQ/9fS1UoJWyRBpshvQ+AcMzZUNIualgS2hic8IOcK+y3YQ0eikrv7OKrQelD5RQKTL1gqtyuDODxIIthp503RN6v85QC6qDpY6wCEbr9K9oD6k7Hs=
X-Gm-Message-State: AOJu0Ywug1mqW8ccf4XA+TijyZk3b8S57T8pxjPdIYOMYGCkUkjKIFsK
	TFPki7c7H74TMrLiBL8Nno18llPjoI30NnVMfWrXxiK2PMyGSzP3il5EmitqbnhdR+ueX6Dnipo
	XAca6fVJ8Ol3CyQ+bAWmObEvv/7s=
X-Google-Smtp-Source: AGHT+IFKW2ec3/HRyqmVW0kIun75Cic1VJob9nyHZ54FV+XUWliI+kAKLZGeOO5h3wXialZib/X58uQ2+UGJOvlCNcs=
X-Received: by 2002:a17:90b:192:b0:2bf:7dd0:1713 with SMTP id
 98e67ed59e1d1-2c299a22206mr3066297a91.16.1717671910108; Thu, 06 Jun 2024
 04:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716973640.git.geert+renesas@glider.be> <2cf38c10b83c8e5c04d68b17a930b6d9dbf66f40.1716973640.git.geert+renesas@glider.be>
 <CAMZ6RqKZdo1Mk=tY-vqCm0YYr_Qk8m53+LHXqeM+1LL=S=+RqQ@mail.gmail.com> <CAMuHMdXV9q2D=Mhfi7s4NBuvivxBap-k_pkm4pUseoUb3SLWqQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXV9q2D=Mhfi7s4NBuvivxBap-k_pkm4pUseoUb3SLWqQ@mail.gmail.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Thu, 6 Jun 2024 20:04:58 +0900
Message-ID: <CAMZ6RqK32+i69Rd3qDDNm4cgQa3+m3ikZTbpt5jCGrkNt76+vw@mail.gmail.com>
Subject: Re: [PATCH 1/3] can: rcar_canfd: Simplify clock handling
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu. 6 June 2024 at 19:15, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
> Hi Vincent,
>
> On Sun, Jun 2, 2024 at 10:03=E2=80=AFAM Vincent MAILHOL
> <mailhol.vincent@wanadoo.fr> wrote:
> > On Wed. 29 May 2024 at 18:12, Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > The main CAN clock is either the internal CANFD clock, or the externa=
l
> > > CAN clock.  Hence replace the two-valued enum by a simple boolean fla=
g.
> > > Consolidate all CANFD clock handling inside a single branch.
> >
> > For what it is worth, your patch also saves up to 8 bytes in struct
> > rcar_canfd_global (depends on the architecture).
>
> True.
>
> > > @@ -545,8 +539,8 @@ struct rcar_canfd_global {
> > >         struct platform_device *pdev;   /* Respective platform device=
 */
> > >         struct clk *clkp;               /* Peripheral clock */
> > >         struct clk *can_clk;            /* fCAN clock */
> > > -       enum rcar_canfd_fcanclk fcan;   /* CANFD or Ext clock */
> > >         unsigned long channels_mask;    /* Enabled channels mask */
> > > +       bool extclk;                    /* CANFD or Ext clock */
> > >         bool fdmode;                    /* CAN FD or Classical CAN on=
ly mode */
> >
> > Notwithstanding comment: you may consider to replace those two booleans=
 by a:
> >
> >           unsigned int flags;
> >
> > This way, no more fields would be needed in the future if more quirks a=
re added.
>
> Using "unsigned int flags" and BIT(x) flags would increase code size
> by 8 bytes (arm/arm64).

I am not sure where you derive your figure from, but looking at the pahole:

  $ pahole drivers/net/can/rcar/rcar_canfd.o -C rcar_canfd_global
  struct rcar_canfd_global {
      struct rcar_canfd_channel * ch[8];               /*     0    64 */
      /* --- cacheline 1 boundary (64 bytes) --- */
      void *                     base;                 /*    64     8 */
      struct platform_device *   pdev;                 /*    72     8 */
      struct clk *               clkp;                 /*    80     8 */
      struct clk *               can_clk;              /*    88     8 */
      long unsigned int          channels_mask;        /*    96     8 */
      bool                       extclk;               /*   104     1 */
      bool                       fdmode;               /*   105     1 */

      /* XXX 6 bytes hole, try to pack */

      struct reset_control *     rstc1;                /*   112     8 */
      struct reset_control *     rstc2;                /*   120     8 */
      /* --- cacheline 2 boundary (128 bytes) --- */
      const struct rcar_canfd_hw_info  * info;         /*   128     8 */

      /* size: 136, cachelines: 3, members: 11 */
      /* sum members: 130, holes: 1, sum holes: 6 */
      /* last cacheline: 8 bytes */
  };

on a 64 bits architecture, you are currently using two booleans (two
bytes), followed by a hole of six bytes, which is a total of eight
bytes. This should be way enough to fit an unsigned int. Same would go
on 32 bits architecture in which you would use two bytes for the
booleans and have a hole of two bytes, which is four bytes: one more
time enough for an unsigned int.

In both scenarios, you are not consuming more bytes, nor are you
saving bytes. It is a neutral change.

Of course, the pahole above was done on x86_64, but as far as I know,
arm and arm64 paddings behave similarly.

> Using "unsigned int foo:1" bitfields would increase code size by 16
> (arm) or 12 (arm64) bytes.
> So as long as we can fit more bools inside the hole, it is more
> efficient to do so...

I do not get this either. Where did you get your 16 bytes from? If I do:

  struct foo {
          unsigned int foo1:1;
          unsigned int foo2:1;
  };

and

  struct bar {
          unsigned int flags;
  };

then I am pretty sure that sizeof(struct foo) is the same as
sizeof(struct bar). That's the point of the bitfields: as long as the
total of the bitfields fit in the type, the total size consumed by the
bitfield is the same as the type size.

But just to reiter my previous message, these are notwithstanding
comments. I am fine if you keep the patch as-is ;)

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
>

