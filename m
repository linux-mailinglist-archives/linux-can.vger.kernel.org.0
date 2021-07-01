Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387293B8F86
	for <lists+linux-can@lfdr.de>; Thu,  1 Jul 2021 11:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbhGAJNF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Jul 2021 05:13:05 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:34746 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbhGAJNE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Jul 2021 05:13:04 -0400
Received: by mail-ua1-f42.google.com with SMTP id c47so2205654uad.1;
        Thu, 01 Jul 2021 02:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EhjctjUJ1OHIUUYVbsaQFtFCgU+nXale34BYWkx2geM=;
        b=K1h4ksMlQstfBzj6HhcTct6/zEY8iZJ1oC0NkemQMlmFllxCCXLJdUHC8xuYTXR9F5
         kI0OKHUQBgWr7fe/JpbJIuDHnNhdVfVzK4YdlxmZM03ZO14nOj4QFyIAGMPSfDB0Ks29
         e7H7L0qrSXFkDsCTWfJFrVe2GucHWSQbSqFJUTBKAo4aNPq6ym+dUgkO06zGp2BG6BPO
         zMSQTspl8mwQIQIg3Yd/AIdXgytxRjwsA+4P2w2tNUdyhQOtXbtoViH+oe9XB8OBXFbk
         b9RImBDB8KFyHhLIWjNDtFARD4lxqUv4KYlpWQncxB4MONjGKcZ+bmszBWUiuv9KimYU
         G36w==
X-Gm-Message-State: AOAM530iP/XutKoqc6hlV+GsCWmBd5etHkZgAAkhwIuH3uAPaKYLANQJ
        zZQHla3tOHjjGFf96TzXrQabVAMgFGzlPg2mg9kMloEent38KA==
X-Google-Smtp-Source: ABdhPJx3GyXkDdYASmUxls26Occ+Y68KhwE0T5fotjEWdoc6IGEvNiTLVzRPQHX7Z5fp7Zui+u2K30bV+7qS+02MXbk=
X-Received: by 2002:ab0:71c1:: with SMTP id n1mr827434uao.2.1625130632849;
 Thu, 01 Jul 2021 02:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210630230016.4099050-1-angelo@kernel-space.org>
 <20210630230016.4099050-2-angelo@kernel-space.org> <20210701065327.maawrm546dkfzxbx@pengutronix.de>
 <7effec9f-e3aa-12d1-fc91-cb7b2c4ae9ab@linux-m68k.org> <20210701074255.jutewhpjqxsi7bdl@pengutronix.de>
 <7252e8f0-7d16-4707-d091-784c27911173@linux-m68k.org>
In-Reply-To: <7252e8f0-7d16-4707-d091-784c27911173@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Jul 2021 11:10:21 +0200
Message-ID: <CAMuHMdV0nMOO734NAXdhbUmmHJYz781QFZT-k85jbd3hZ=qypg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] m68k: stmark2: update board setup
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Angelo Dureghello <angelo@kernel-space.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-can@vger.kernel.org, Joakim Zhang <qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Greg,

On Thu, Jul 1, 2021 at 10:02 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 1/7/21 5:42 pm, Marc Kleine-Budde wrote:
> > On 01.07.2021 17:41:04, Greg Ungerer wrote:
> >>
> >> On 1/7/21 4:53 pm, Marc Kleine-Budde wrote:
> >>> On 01.07.2021 01:00:13, Angelo Dureghello wrote:
> >>>> Add configuration for flexcan pads.
> >>>>
> >>>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> >>>
> >>> How do we upstream the m68k changes? Should we split this series into
> >>> m68k and CAN?
> >>
> >> I am happy to take the m68k specific changes (patches 2 and 3)
> >> through the m68knommu git tree.
> >
> > Make it so. \o/ I'll take the rest.
>
> As soon as the current merge window closes I will pull them in.

Patch 3 depends on patch 1 through <linux/can/platform/flexcan.h>.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
