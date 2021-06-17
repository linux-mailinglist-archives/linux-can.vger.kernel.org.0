Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57D23AAEC9
	for <lists+linux-can@lfdr.de>; Thu, 17 Jun 2021 10:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhFQIak (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Jun 2021 04:30:40 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:43997 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhFQIaa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Jun 2021 04:30:30 -0400
Received: by mail-vs1-f44.google.com with SMTP id s22so2537031vsl.10;
        Thu, 17 Jun 2021 01:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBdgLJO51mRBknUGyxuACP8RJeaq2fMUxDF3YlRLQVk=;
        b=C0r87tuwrkGa5Y+I/NAmjt+BBiwoJnP0gwiYS5/IOTH6TSD82b30+DlyE3YsliCCQi
         MMUx4JURIEeNLkwShfDejL6whckfoOkUZ+n/HXxN4bwrP3oAoF153DA3//hR7rNDR3oy
         F6kuUZTBKYrhIPHFjRT1V/2fwyFTV80IQudizkEvHZGP+GylxdS2Bpz3g3q8WS080b5D
         mxDllxSS4sU/e+ug9URPeZYu12eKxkPL8XftwQ5zPqF+L5lmRPc89zczFv9YkJOzm4cq
         eaUVVFs3GUOyxOHo2Z3C+kZgSJ10/KebnPjSLGSzWhH+8bKB/3dWsS2kqCQzrPSj9zr5
         rg/A==
X-Gm-Message-State: AOAM531kGHu6cjgx1lG0Swkj8FoHhh2uN/UjGlvMzecW1Xo+oO5OXOPB
        7wySlvs0p77ywH5p9Db21mFdbp1z4I1rBL98xFw=
X-Google-Smtp-Source: ABdhPJzbn/rSniqelZ/fGqnV9PjxbVrg3EfzfSPKYIi4xwekQcFoB/f4m/5VXXrzrsTfQa8qwKZDoI7fXgLZTBQPZ6c=
X-Received: by 2002:a67:efd6:: with SMTP id s22mr3324018vsp.3.1623918501678;
 Thu, 17 Jun 2021 01:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210616231652.738027-1-angelo@kernel-space.org>
In-Reply-To: <20210616231652.738027-1-angelo@kernel-space.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Jun 2021 10:28:10 +0200
Message-ID: <CAMuHMdXNsPnaP6xwm0=2naydnxPs2k2ivLTNnrE_bGnhORmaBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] can: flexcan: add platform data for ColdFire
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

On Thu, Jun 17, 2021 at 1:17 AM Angelo Dureghello
<angelo@kernel-space.org> wrote:
> Add platform data object for ColdFire architecture.
>
> ---
> Changes for v2:
> - move header file in more proper location
> - remove irq defines
> - change variable types to match driver types
>
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>

Thanks for your patch!

> --- /dev/null
> +++ b/include/linux/can/platform/mcf5441x.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Flexcan options for ColdFire family
> + *
> + * Copyright (C) 2021  Angelo Dureghello <angelo@kernel-space.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _PLAT_FLEXCAN_MCF_H
> +#define _PLAT_FLEXCAN_MCF_H
> +
> +struct mcf_flexcan_platform_data {
> +       u8 clk_src;
> +       u32 clock_frequency;
> +       bool big_endian;

Please sort the members according to decreasing size, to avoid
holes.

> +};
> +
> +#define FLEXCAN_MCF5411X_MB_CNT_MCF    16
> +
> +#endif /* _PLAT_FLEXCAN_MCF_H */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
