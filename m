Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A723AF6CE
	for <lists+linux-can@lfdr.de>; Mon, 21 Jun 2021 22:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFUUZR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Jun 2021 16:25:17 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:43797 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUUZQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Jun 2021 16:25:16 -0400
Received: by mail-vs1-f41.google.com with SMTP id v12so1432635vsg.10;
        Mon, 21 Jun 2021 13:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W5suUG3nXhCu6fEPQJeyD5ggFJ03eUoK7j3KW9Y8YPs=;
        b=X1kA3butgVsLZ/oNRkZ3hBytQt3YOs0CKgFq0H2kL9F8nLYWo4KUwaC7Vl5Anh8ZJj
         eK2Zx9QS+fmDuChj0OM0EstBrxFFp3XPCM5+rU0tfak+7cf7C+gkgub4M4Df5IzlyVOf
         MqvXuxVdTVl9kVGC13Jej6u7/9B+//u9IcDhENhvwV+qsznEc5TLAnKBcxrgJQbUPF/U
         930cWE0rEuuXOjPKrQF/xBT+HVfay5ahssKzclgQjwkZXcdhgCBAfvww4Ezf7zG2ZB/Q
         T9psvwOmJDtRLFCUAkrSobxessMkBivBuVHr6XptZ0iFmPRrANHfWiZ91zO+ZQe9Z1tz
         URuw==
X-Gm-Message-State: AOAM5333J92Z68vZbTLsdM8v67mJnNSo6kzVaAKHZqG/suh+ipd9hoQB
        ojJmBkPCCdtuP/JSsqA1QKDUd8rRHlNpVxonnXs=
X-Google-Smtp-Source: ABdhPJysfJhUYb5Tmkq9lj1qLUepqxVSo6ZbHz8aejfjBjNpuRh6HLR11DSKRCln8wsYzRPjvQBe/NVUh7tjS2DfuZE=
X-Received: by 2002:a67:3c2:: with SMTP id 185mr19681734vsd.42.1624306981290;
 Mon, 21 Jun 2021 13:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210621184615.3345846-1-angelo@kernel-space.org>
 <20210621184615.3345846-4-angelo@kernel-space.org> <CAMuHMdV8a=YKowGLY3kGqwsfAPd3VPEXS8x7xqYaUz9ZBh64hg@mail.gmail.com>
 <20210621201816.pk6n4xa7j4bi6vfk@pengutronix.de>
In-Reply-To: <20210621201816.pk6n4xa7j4bi6vfk@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jun 2021 22:22:50 +0200
Message-ID: <CAMuHMdUHQyPB8G5QX-oK7+MDvkLihR6QCoD+9_3pQKQZWu7TGw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] can: flexcan: update Kconfig to allow non-of cases
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Angelo Dureghello <angelo@kernel-space.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-can@vger.kernel.org, Joakim Zhang <qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Mon, Jun 21, 2021 at 10:18 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 21.06.2021 22:11:58, Geert Uytterhoeven wrote:
> > On Mon, Jun 21, 2021 at 8:47 PM Angelo Dureghello
> > <angelo@kernel-space.org> wrote:
> > > Update flexcan to support architectures without fdt.
> > >
> > > Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> > > ---
> > > Changes for v2:
> > > none
> > > Changes for v3:
> > > - change to just remove OF
> > > ---
> > >  drivers/net/can/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> > > index e355d3974977..a0f4ae7ccb84 100644
> > > --- a/drivers/net/can/Kconfig
> > > +++ b/drivers/net/can/Kconfig
> > > @@ -97,7 +97,7 @@ config CAN_AT91
> > >
> > >  config CAN_FLEXCAN
> > >         tristate "Support for Freescale FLEXCAN based chips"
> > > -       depends on OF && HAS_IOMEM
> > > +       depends on HAS_IOMEM
> >
> > I think you want to add a line
> >
> >     depends on ARCH_LAYERSCAPE || ARCH_MXC || COLDFIRE ||
> > FSL_SOC_BOOKE || COMPILE_TEST
> >
> > (or PPC instead of FSL_SOC_BOOKE?)
> > so the question doesn't pop up when compiling a kernel for a system
> > that cannot have a Freescale FlexCAN IP block.
>
> Back in 2018 Pankaj Bansal replaced the "depends on ARM || PPC" by "OF
> && HAS_IOMEM", see:
>
> | 0f8af56f74cd can: flexcan: enable flexcan for all architectures

Probably the real reason behind that was to enable it on ARM64
(more specifically ARCH_LAYERSCAPE || ARCH_MXC).

> So I think there won't be too many configs where the oldconfig question
> would pop up.

Now it will, as Mr. Torvalds' main machine does not satisfy "ARM || PPC"
or "OF && HAS_IOMEM", but does "HAS_IOMEM" ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
