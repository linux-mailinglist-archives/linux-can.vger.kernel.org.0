Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512C83AFD68
	for <lists+linux-can@lfdr.de>; Tue, 22 Jun 2021 08:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFVGyq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Jun 2021 02:54:46 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:47081 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhFVGyd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Jun 2021 02:54:33 -0400
Received: by mail-ua1-f41.google.com with SMTP id t22so5648169uar.13;
        Mon, 21 Jun 2021 23:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfedJPMzBTJHeSpIFogH4M36+otVjxFa0xdxf+rXd68=;
        b=KUvx2c0JtFXdkzvOCQoKx+I0rYy4/KKJJSMtCAeNlaGOnc7j2iyA8ei60gRBjhmGC6
         jJVeIrN0XKoxICDVS3ksbMa7IvWRhThtgnm5d2GLBxWFuNFHp41bCtMZCWzDNBTC3tb9
         Wxh3G1WQmjORiVp64J/fjXfnJGVjh2JH1HKqBm1VbyCSEi4GmjzRkI/KiLQk8Zo0INm6
         IapxSECuzxvIMBl6dAGgfymtCqhe8Tzm/18WUHz5DmprHhKcqvYIC5XBe7rltHQQafj8
         ti94A69ch7mCf6iSf1Qv0MUarxVn0jA9B6sdoXeW+pk7m1+9MLCZA7B6tIHhpatNy0H/
         erHA==
X-Gm-Message-State: AOAM531OHTlLWyrgL3wWe9emHe7BSoCRxFWnjdtcHaeDzPDtnoM9ARaX
        T4UTIXKq4KXVZEQUOhpgu11hm7w8cZs+Op7C7fk=
X-Google-Smtp-Source: ABdhPJy78Q6xRg3zp4Q7kUDnqKsXHRRRMjrYNgae4hQAY6j/8CoeaFnnR/9g/SXsgPUL/qIav3d1dhdsZT0Q6kD7hys=
X-Received: by 2002:ab0:484b:: with SMTP id c11mr2045706uad.100.1624344736709;
 Mon, 21 Jun 2021 23:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210621184615.3345846-1-angelo@kernel-space.org>
 <20210621184615.3345846-4-angelo@kernel-space.org> <CAMuHMdV8a=YKowGLY3kGqwsfAPd3VPEXS8x7xqYaUz9ZBh64hg@mail.gmail.com>
 <20210621201816.pk6n4xa7j4bi6vfk@pengutronix.de> <CAMuHMdUHQyPB8G5QX-oK7+MDvkLihR6QCoD+9_3pQKQZWu7TGw@mail.gmail.com>
 <20210621204127.xwrk2tlxggct7kst@pengutronix.de>
In-Reply-To: <20210621204127.xwrk2tlxggct7kst@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Jun 2021 08:52:05 +0200
Message-ID: <CAMuHMdUrFa6r2VQdNTgr8mV_wGoOb4VhK0Y5_XQQ1Xzgc93NMw@mail.gmail.com>
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

On Mon, Jun 21, 2021 at 10:41 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 21.06.2021 22:22:50, Geert Uytterhoeven wrote:
> > On Mon, Jun 21, 2021 at 10:18 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > > On 21.06.2021 22:11:58, Geert Uytterhoeven wrote:
> > > > On Mon, Jun 21, 2021 at 8:47 PM Angelo Dureghello
> > > > <angelo@kernel-space.org> wrote:
> > > > > Update flexcan to support architectures without fdt.
> > > > >
> > > > > Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>

> > > > > --- a/drivers/net/can/Kconfig
> > > > > +++ b/drivers/net/can/Kconfig
> > > > > @@ -97,7 +97,7 @@ config CAN_AT91
> > > > >
> > > > >  config CAN_FLEXCAN
> > > > >         tristate "Support for Freescale FLEXCAN based chips"
> > > > > -       depends on OF && HAS_IOMEM
> > > > > +       depends on HAS_IOMEM
> > > >
> > > > I think you want to add a line
> > > >
> > > >     depends on ARCH_LAYERSCAPE || ARCH_MXC || COLDFIRE ||
> > > > FSL_SOC_BOOKE || COMPILE_TEST
> > > >
> > > > (or PPC instead of FSL_SOC_BOOKE?)
> > > > so the question doesn't pop up when compiling a kernel for a system
> > > > that cannot have a Freescale FlexCAN IP block.
> > >
> > > Back in 2018 Pankaj Bansal replaced the "depends on ARM || PPC" by "OF
> > > && HAS_IOMEM", see:
> > >
> > > | 0f8af56f74cd can: flexcan: enable flexcan for all architectures
> >
> > Probably the real reason behind that was to enable it on ARM64
> > (more specifically ARCH_LAYERSCAPE || ARCH_MXC).
>
> Probably. What about the original proposed change: "(OF || M5441x) && HAS_IOMEM"?

Yeah, the Flexcan might pop up on RISC-V, too.
But any new platforms should use OF.
Given the Flexcan is probably present on more than just M5441x,
I'd go for:

    depends on OF || COLDFIRE || COMPILE_TEST
    depends on HAS_IOMEM

> > > So I think there won't be too many configs where the oldconfig question
> > > would pop up.
> >
> > Now it will, as Mr. Torvalds' main machine does not satisfy "ARM || PPC"
> > or "OF && HAS_IOMEM", but does "HAS_IOMEM" ;-)
>
> IC, that would be one question too much :)

I do doubt he has CONFIG_CAN enabled ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
