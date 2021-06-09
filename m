Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590453A0E95
	for <lists+linux-can@lfdr.de>; Wed,  9 Jun 2021 10:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbhFIIQv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Jun 2021 04:16:51 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:44738 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbhFIIQu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Jun 2021 04:16:50 -0400
Received: by mail-vs1-f50.google.com with SMTP id x13so3984026vsf.11;
        Wed, 09 Jun 2021 01:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxY6frud7n1hDQgMN18Mv4MxDlacWmnSMfu7VtWpX0U=;
        b=oCqwRyJdEZhQprM6fHY9IhE/doYPbrrYmgZAunKc+bKoDaT01j1nd7zU5xgLEDUAme
         E1CTJwa0d+1BnF1aIF9PMfBLfRnzNUvnDYSpgKWxZiancyvfZe2ZdZIF+4nZ/DMCsFaf
         cCR84Dbmv2LOLk2o1AEse4/SFAVGaPihO0DY2E1NhkKIxZnDneksWKw1TdQr6SQblvIK
         73hKxB2carbEMfKMjIzvlggpxdFB0gn0DmK5WzGXKfTFWj4WP/0bIKyuOtcD23elZIov
         ENvmBqZxV0ppclb2fQgDP6qEnWZyPcGYqjg/8VOhMf2NIeanEMHf9n6Xpz7JQj9ugO6b
         0grw==
X-Gm-Message-State: AOAM531h8bcV8Fb283ntwvLljAF6NyvRVstF4FqMxzCdLJLx0ekK3zq+
        Rj99W1P3Vo2/KQ+R+sB8tZHXBgn5hAM9jMY42XU=
X-Google-Smtp-Source: ABdhPJxqM8zxSMqUfnWo12fHNYuNEkvSJNwIg/kr3M169pgG8IfsBK2ZGoTZQ76kI//IKlkJQjPR13v1wIO6iqegZjg=
X-Received: by 2002:a05:6102:c4c:: with SMTP id y12mr3975975vss.18.1623226481849;
 Wed, 09 Jun 2021 01:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210608204542.983925-1-angelo@kernel-space.org>
In-Reply-To: <20210608204542.983925-1-angelo@kernel-space.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Jun 2021 10:14:30 +0200
Message-ID: <CAMuHMdUCatwWyoEwLDTfStePduFGFg4BykFdYCskk=ZLTiS0TA@mail.gmail.com>
Subject: Re: [PATCH 1/5] can: flexcan: add platform data for ColdFire
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Angelo,

On Tue, Jun 8, 2021 at 10:46 PM Angelo Dureghello
<angelo@kernel-space.org> wrote:
> Add platform data object for ColdFire architecture.
>
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>

Thanks for your patch!

> --- /dev/null
> +++ b/include/linux/platform_data/flexcan-mcf.h
> @@ -0,0 +1,27 @@
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
> +       int stop_mode;

Unused?

> +       int clk_src;
> +       int clock_frequency;

Might be worthwhile to match the types used in the driver
(i.e. u8 and u32).

> +       bool big_endian;
> +};
> +
> +#endif /* _PLAT_FLEXCAN_MCF_H */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
