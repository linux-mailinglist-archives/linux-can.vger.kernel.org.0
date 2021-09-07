Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FECA4023DD
	for <lists+linux-can@lfdr.de>; Tue,  7 Sep 2021 09:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhIGHLT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Sep 2021 03:11:19 -0400
Received: from mail-vk1-f181.google.com ([209.85.221.181]:36456 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbhIGHLR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Sep 2021 03:11:17 -0400
Received: by mail-vk1-f181.google.com with SMTP id s126so2964287vkd.3;
        Tue, 07 Sep 2021 00:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBtP9mc69XVfuTO+56uUxq1BAzYKObHV02/QNrtHWJo=;
        b=fA2OT2K5RPqXkhsHQmYHNnrANulzWhxCdoCODs7+JAe9GHuICq6+nWRgyWc5YysITv
         H6iw4DywvmvfQfcUDbbUwlXjot8bHT83QoLFzoAoxFNiG/CuBibZB1B2HOuofOuXrlt9
         dfEKjXTcgRACWRpZkP3Qic8kk+oRu0anqzukuGt1blybdc8/2EPfS0M8khyPauokI7Pe
         NdmxVEGxu0c5gz4aiWqlmUAsyVvRBTB6BNtOYgnRZYKR2Fm+GDEefjRmOnLBq4cnTuNH
         k87meGLi3OafjOiNfvrCUTuYIUGMFFGo6fckvpmCnVuWVMZ1pKjOeYzch0FTzv8ypkI9
         8zKw==
X-Gm-Message-State: AOAM5301iZnGvzBIILqLm3WbXrpSp5SEp9mNMEOa5g37CuLoiJH2GswM
        8jmGJUTMjhJJV5vOh5uxwkjj5L5vZgDEgnKslic=
X-Google-Smtp-Source: ABdhPJwIma66+usweJzyanXrJb3XxlLEmfkI/JyuKgfh3YsqK4FosOLOxClx4FPVgkxNvEX+9CZuny8XUrks74d455U=
X-Received: by 2002:a1f:d247:: with SMTP id j68mr7008661vkg.7.1630998609343;
 Tue, 07 Sep 2021 00:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210907064537.1054268-1-mkl@pengutronix.de>
In-Reply-To: <20210907064537.1054268-1-mkl@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Sep 2021 09:09:58 +0200
Message-ID: <CAMuHMdV-4JM17XPzte5JPN6LfanCugQzVDC-yk2vKhr95zAO4A@mail.gmail.com>
Subject: Re: [PATCH v2] can: rcar_canfd: add __maybe_unused annotation to
 silence warning
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Sep 7, 2021 at 8:48 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Since commit
>
> | dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
>
> the rcar_canfd driver can be compile tested on all architectures. On
> non OF enabled archs, or archs where OF is optional (and disabled in
> the .config) the compilation throws the following warning:
>
> | drivers/net/can/rcar/rcar_canfd.c:2020:34: warning: unused variable 'rcar_canfd_of_table' [-Wunused-const-variable]
> | static const struct of_device_id rcar_canfd_of_table[] = {
> |                                  ^
>
> This patch fixes the warning by marking the variable
> rcar_canfd_of_table as __maybe_unused.
>
> Fixes: ac4224087312 ("can: rcar: Kconfig: Add helper dependency on COMPILE_TEST")
> Fixes: dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: Cai Huoqing <caihuoqing@baidu.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
