Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6960B354731
	for <lists+linux-can@lfdr.de>; Mon,  5 Apr 2021 21:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbhDETl0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 5 Apr 2021 15:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhDETl0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Apr 2021 15:41:26 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AECC061756
        for <linux-can@vger.kernel.org>; Mon,  5 Apr 2021 12:41:19 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 11so5060863ybe.8
        for <linux-can@vger.kernel.org>; Mon, 05 Apr 2021 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/NzJFjzTNix1nDCQVmRrS5cps67neVpW6L7BWvCDEM=;
        b=LYX3of7g4tg7awA+WhkjRJpmuTMvqCqnCyz7U+7pS11xuOavqRAXaaT/Jbgqbb6wBk
         0qQqDxwWddrYq21dmmLFf5+5aKwVUWDGxeUtxeCjP1/DzFoxctS+169QvGKm1Ug+koBM
         vz0/C8B4BqT8yo+jpTqiffNsZWwPl2mQlkRklGLyWtINrKcw0pz+jfwrF0UrqceLVMFZ
         HB7Cs6SroxITWu3Jhrr7W4O66y5WW59i8FhdEgitLZABAX0luIXNdaAyUgpYBMUir2+7
         ADcWEIaZVW/GyQuccQiN9Sg2fSejb4QbZS/rNF4cQDIASDFEnuDjZFpsJuY/yVEL1fyL
         ZQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/NzJFjzTNix1nDCQVmRrS5cps67neVpW6L7BWvCDEM=;
        b=XFGBRSjr89SZ/z6YTjRGiGbW3qSUK3wGh0BlGOgaLJk95UtMBBlPkcv6ea2Vb73SCC
         fch4RiUnmJtO2cZc6iNpvIO01Iis9iqs+2IPQeySudBAX5IWkuZ5NsQqL/BpYuzDaNlA
         MfUIaJp8k30XB7fJ/LXp+nJ4jyEWyQlKdEh1sjtPGFJ9o54enAKHtcXwJTLBlnEBzuY5
         VhTGZ7i1/nNVt2vbiQCG/7o/t31Sb2sxR1faF+14qTWVoLFrqgq/NFIm0tMEy+xM6zky
         Z1VF5d6rwFVDxtHbR4q06OAK1yYW/30NAGUM8ihg7gT4jxVJOiC2Zje724GCWPj0k2RJ
         EMfA==
X-Gm-Message-State: AOAM530mYPrYNamLMtLoUugZxjILq1BZIYT+kPYJhCwCLpaf9RxkvRIk
        Ya2BbkQfxLgtW3gzMiLgqh9YIlsOG6mtMu5BFiE=
X-Google-Smtp-Source: ABdhPJyTBBt/SNe+aGDEb2NQDbuuNx1LHZ9CaWFEobONaq4/zpjirslhbLXKGXrjzM1LU0ZDHIYnejGt8oY2S3cOPZI=
X-Received: by 2002:a25:7414:: with SMTP id p20mr39120501ybc.186.1617651678781;
 Mon, 05 Apr 2021 12:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAAfyv37vMxhN2B1uR5xUzZwVzAqrQOyPA6stWYj_5346xO0s3A@mail.gmail.com>
 <20210331083744.pui7rtjexvejjvf6@pengutronix.de> <CAAfyv35tCPxf0KSOk3=mcq6j2yB0DLUrN3AJ6sJtreZmTYZdGQ@mail.gmail.com>
 <20210402192759.up2tperefmwyt3r2@pengutronix.de> <CAAfyv35ofuk-z4qByJp3y9JRuAYPu4WaUaBf_o9QyschPNOOUg@mail.gmail.com>
In-Reply-To: <CAAfyv35ofuk-z4qByJp3y9JRuAYPu4WaUaBf_o9QyschPNOOUg@mail.gmail.com>
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Mon, 5 Apr 2021 21:41:07 +0200
Message-ID: <CAAfyv37Wkh0rrAeEDyO1No6t0dnm=dSayZLdMvP6nWXCz12vdg@mail.gmail.com>
Subject: Re: m_can error/overrun frames on high speed
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Mon, Apr 5, 2021 at 7:31 PM Belisko Marek <marek.belisko@gmail.com> wrote:
>
> On Fri, Apr 2, 2021 at 9:28 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> >
> > On 01.04.2021 11:04:25, Belisko Marek wrote:
> > > Is there anything I can tune to have it read faster? Thanks.
> >
> > Indeed, with current net-next/master, you put the NAPI on a per
> > networking device from softirq to threaded mode.
> >
> > | echo 1 | sudo tee /sys/class/net/can0/threaded
> >
> > Then you a separate NAPI thread per networking device that can be tuned
> > with chrt, etc...
> OK I've tse threaded mode for NAPI and for napi:can0 thread I set chrt
> -p 99 <pid> but unfortunately there are still buffer overruns which is
> kind of strange.
>
> For rx-offload branch I was not able yet to run it on my platform
> (have panic during boot which I need to resolve first).
OK I resolved boot issues on my platform and tested using rx-offload
branch but again the issue is present.
It's enough to generate can frames using candeg can0 -g0 and I get
after some time error/overrun errors.
I'm trying now to bump rx-offload patches on top of linux-can-next
testing branch and test it.
>
> Thanks and BR,
>
> marek
> >
> > regards,
> > Marc
> >
> > --
> > Pengutronix e.K.                 | Marc Kleine-Budde           |
> > Embedded Linux                   | https://www.pengutronix.de  |
> > Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> > Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

Thanks and BR,

marek
