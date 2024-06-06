Return-Path: <linux-can+bounces-702-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A318FE401
	for <lists+linux-can@lfdr.de>; Thu,  6 Jun 2024 12:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A36283F47
	for <lists+linux-can@lfdr.de>; Thu,  6 Jun 2024 10:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8631C194ACB;
	Thu,  6 Jun 2024 10:15:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E1F1581E0;
	Thu,  6 Jun 2024 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668938; cv=none; b=DUlyrrTCBijLKe+1n8ObAzqqyR4Gc6FXEOO9QgfhM9D0zRD1yHX14x3G1UXlS5z5jpgafC4YuKrS4xtXLfEf3YiM51kwFBJraGdSBAcQVtMyjelb/hV+VFI6zWGtA36dThRuinPl7DW9jwmpX6eMJ4gwDDhAEstQjPqOlh53bis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668938; c=relaxed/simple;
	bh=6GrNTeU6syeet0PG3KVv9gtHTFfZOQVvGuKL+LSpJzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPaIEOCA9yvYivju63XDxvhxY60n0aROvBiOshWQF2OebEqKHytKNOl3v0DLroo+na8/4Z+NL4eX2PI98gJLISzeImYjZ2hcXItzo26RyOh5cwRCibw5hfJhPVc/uXeVG7cQM2OAT8G8D9vK/++TdwCVbGL9GIvOJ9DMpZm3xmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfa8427f22dso948268276.0;
        Thu, 06 Jun 2024 03:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717668934; x=1718273734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAbA6XmlO0/+v57iUucYbTHgTS7aAv+JEntCcXUEmSs=;
        b=jY1hj9QMKs/8U2NPnMBxoav/Id/17LtncxIe+LvQJ9Xs9mllqdJuaWSBYw+KMMZb26
         Ji/K/h8VIZeoDaTYe46yvdkMhED4hhrJw55YuXAPS0EcPNhAIn5JmuZigAXfDv2TVvlu
         +kZwflw6K/E2bvPzSP9xLS36h7zRfHisCpUGConeQy627TgI5j9bRx8rTyn5ubIOwo8V
         wxsPp6LedNJvOJQljCt13BpzUfAsB9LbFqF7r+YjdBQQ5pOCjM6rD+YJK4N4OcVKD+gL
         C2G6v4MUdiv/DvUP3nDwVLJH4g5Dn5DeFLMXMDY+0R9QaQQpkSWZ440c8lAOimb1HvGl
         JfVA==
X-Forwarded-Encrypted: i=1; AJvYcCUh20FCYZJL3/vz23ciyVMo1bJBhvFEQf55rZduqz0XVZidq8RMRxUWp5HqYvxrfSDNXU4LKpHz/6/X/XNKxa7AUB4CO0n3uIjMDiz1/WyiD2LjlToPT6SUGvLwOIPfsFpf2MqBNh/GeyqdmLJhbxgpwfLqXTYrlrgh8r7POYEk8pcPNRY=
X-Gm-Message-State: AOJu0YwfO6HPpGerBAVUL6UeOtwKkW5zzlfX7ShuZImH6RRVkQDbZm1x
	x2K4jykFb+j2vOJK2urz9wuE2OQCp3BNsiE1hwBgS0cCGjvPQpZ2/sqq4yR1
X-Google-Smtp-Source: AGHT+IHls98VS/oK1RJtPFcaJRCqi3fRV+uXmEAI7vFotQucASXJXzDeZ1Js2/+eeghp4B9PE+iQ2g==
X-Received: by 2002:a25:b320:0:b0:dfa:e6fe:96df with SMTP id 3f1490d57ef6-dfae6fe9886mr1056028276.29.1717668932618;
        Thu, 06 Jun 2024 03:15:32 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dfae53aa989sm223561276.43.2024.06.06.03.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 03:15:32 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a145e0bb2so7446267b3.0;
        Thu, 06 Jun 2024 03:15:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbqC7mCvHgblC03lCEdJWaKiDrihytIBn79uDhr8AXWDbv4Qb+O/ofGPQV7dCEubs5AEUXHEhKox3hG1arEx/NxODoXmknsFQZNQFAOMit2e4myvG/lXtRmEyq/b3nhspGfC0+z27maQMRRCTvT0/WI9GXf3ZZHGeYqXFVF1DTO7kJGws=
X-Received: by 2002:a25:b192:0:b0:df7:8e6f:b0fc with SMTP id
 3f1490d57ef6-dfacad27254mr5168258276.63.1717668931812; Thu, 06 Jun 2024
 03:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716973640.git.geert+renesas@glider.be> <2cf38c10b83c8e5c04d68b17a930b6d9dbf66f40.1716973640.git.geert+renesas@glider.be>
 <CAMZ6RqKZdo1Mk=tY-vqCm0YYr_Qk8m53+LHXqeM+1LL=S=+RqQ@mail.gmail.com>
In-Reply-To: <CAMZ6RqKZdo1Mk=tY-vqCm0YYr_Qk8m53+LHXqeM+1LL=S=+RqQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Jun 2024 12:15:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXV9q2D=Mhfi7s4NBuvivxBap-k_pkm4pUseoUb3SLWqQ@mail.gmail.com>
Message-ID: <CAMuHMdXV9q2D=Mhfi7s4NBuvivxBap-k_pkm4pUseoUb3SLWqQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] can: rcar_canfd: Simplify clock handling
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On Sun, Jun 2, 2024 at 10:03=E2=80=AFAM Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
> On Wed. 29 May 2024 at 18:12, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > The main CAN clock is either the internal CANFD clock, or the external
> > CAN clock.  Hence replace the two-valued enum by a simple boolean flag.
> > Consolidate all CANFD clock handling inside a single branch.
>
> For what it is worth, your patch also saves up to 8 bytes in struct
> rcar_canfd_global (depends on the architecture).

True.

> > @@ -545,8 +539,8 @@ struct rcar_canfd_global {
> >         struct platform_device *pdev;   /* Respective platform device *=
/
> >         struct clk *clkp;               /* Peripheral clock */
> >         struct clk *can_clk;            /* fCAN clock */
> > -       enum rcar_canfd_fcanclk fcan;   /* CANFD or Ext clock */
> >         unsigned long channels_mask;    /* Enabled channels mask */
> > +       bool extclk;                    /* CANFD or Ext clock */
> >         bool fdmode;                    /* CAN FD or Classical CAN only=
 mode */
>
> Notwithstanding comment: you may consider to replace those two booleans b=
y a:
>
>           unsigned int flags;
>
> This way, no more fields would be needed in the future if more quirks are=
 added.

Using "unsigned int flags" and BIT(x) flags would increase code size
by 8 bytes (arm/arm64).
Using "unsigned int foo:1" bitfields would increase code size by 16
(arm) or 12 (arm64) bytes.
So as long as we can fit more bools inside the hole, it is more
efficient to do so...

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

