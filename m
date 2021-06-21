Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2253AF6AF
	for <lists+linux-can@lfdr.de>; Mon, 21 Jun 2021 22:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhFUUO0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Jun 2021 16:14:26 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:35643 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhFUUO0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Jun 2021 16:14:26 -0400
Received: by mail-vs1-f53.google.com with SMTP id j15so9981507vsf.2;
        Mon, 21 Jun 2021 13:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Kip9GifiuNfj9QeA3XUqqC+M+epRVwb+HCe4pTkQPs=;
        b=nDWU7VwIzisaQioFwWkl+61kzV6rl9qtweaHJAEfnkQ+jbrgTclfypZUam9IoQYhU4
         ykcyFqp5w11qNH0MpjvfOmRmISalrCRxt4vig42nOUd5lGncX8mu+atRKl5xHAl0G//C
         8DNOSXpEvPdVGSVvVA6rpSoCI+D2W/E5FrmIb7VYk50US8IF69CsjKRNQvRf3W6ehL1n
         iCbCiSBc59lU01t52zAb3ef4OvjkD0E4lpMAO1URzSZ6xl7SdOKoQeInAgc7IWhCip5N
         7By63lJHZoDN4l/RGAVDU9alNeP7REAsFllk5P6WklbTMX8XuKhzPHO3hzgZ+kifKRRT
         0GTQ==
X-Gm-Message-State: AOAM530H0kRtx169RPs9srwtN0QhImk782iZ+nl72HojOBoJDD5C5pL9
        uPODXBzBpt4RjW8PLnSF84hTAKA4d+aWO6hP/7GYEq4RdTPiiw==
X-Google-Smtp-Source: ABdhPJxONGPsVicbk+opB70+yMR9opfn4r2E02U4PIHhh4jNXoJZ+ClcNEBwkvKxL8FhXH438zf5uhlOUUlvx0eToP8=
X-Received: by 2002:a05:6102:c4c:: with SMTP id y12mr19756967vss.18.1624306329961;
 Mon, 21 Jun 2021 13:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210621184615.3345846-1-angelo@kernel-space.org> <20210621184615.3345846-4-angelo@kernel-space.org>
In-Reply-To: <20210621184615.3345846-4-angelo@kernel-space.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jun 2021 22:11:58 +0200
Message-ID: <CAMuHMdV8a=YKowGLY3kGqwsfAPd3VPEXS8x7xqYaUz9ZBh64hg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] can: flexcan: update Kconfig to allow non-of cases
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-can@vger.kernel.org, Joakim Zhang <qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Angelo,

On Mon, Jun 21, 2021 at 8:47 PM Angelo Dureghello
<angelo@kernel-space.org> wrote:
> Update flexcan to support architectures without fdt.
>
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> ---
> Changes for v2:
> none
> Changes for v3:
> - change to just remove OF
> ---
>  drivers/net/can/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index e355d3974977..a0f4ae7ccb84 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -97,7 +97,7 @@ config CAN_AT91
>
>  config CAN_FLEXCAN
>         tristate "Support for Freescale FLEXCAN based chips"
> -       depends on OF && HAS_IOMEM
> +       depends on HAS_IOMEM

I think you want to add a line

    depends on ARCH_LAYERSCAPE || ARCH_MXC || COLDFIRE ||
FSL_SOC_BOOKE || COMPILE_TEST

(or PPC instead of FSL_SOC_BOOKE?)
so the question doesn't pop up when compiling a kernel for a system
that cannot have a Freescale FlexCAN IP block.

>         help
>           Say Y here if you want to support for Freescale FlexCAN.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
