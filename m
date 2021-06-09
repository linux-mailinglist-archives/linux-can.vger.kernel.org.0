Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527263A0E90
	for <lists+linux-can@lfdr.de>; Wed,  9 Jun 2021 10:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhFIIOy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 9 Jun 2021 04:14:54 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:46762 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbhFIIOy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Jun 2021 04:14:54 -0400
Received: by mail-ua1-f41.google.com with SMTP id p1so12548732uam.13;
        Wed, 09 Jun 2021 01:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ns7di523CTNIuVt+baY7bBFi5ZUlGHzkGIIjcfLMzbk=;
        b=cMSsbbZQx0BRxwn1fwSBc/QyJcmRdytT4HWJTmAEGHp2FRfo6g3KY9bQL+WQbOS3bc
         54N5DRSRLAaHnLl+FBnXi4MLGbQbtBMBHtjRSchAkecIMioXv/3Io4RG3m9jn9Ab8Xmc
         8EukITom4lLadHZNpUJj7mbNwxA9QJ7RAw780KCZVSbsIENOEI+EmsKF3pR0dd2VU24W
         SzWtB8oEJ50Qjps4H+pVRAZMXByd2QWhJZVhmidUo13lgNNfLPkL91MYIFO0rxwEL+PH
         0e4HnDfS0aH8L+jgDiAhNny3pQaXTAANtbdgfmXluUo9K4ZD8EkILqf29QrIfuPENQYH
         0sZw==
X-Gm-Message-State: AOAM533D0i+320yb6vXJ02XOnSYAZnqLMVvczEOzsrPcmhxsUIrjo6YP
        GowyVqdktOMXc/XISoAJYKd7xbj+KhUx93bOUtU+qAYhlF9Nzw==
X-Google-Smtp-Source: ABdhPJyaAYoPj7NCRyR3TpjNy4uEXLK50HJ8uBvqihxtSbIvIJn4n0xrx7Iu5S4pRIoNTipjmdx6xzg2DgxxAioxmT8=
X-Received: by 2002:ab0:708c:: with SMTP id m12mr17570616ual.4.1623226366873;
 Wed, 09 Jun 2021 01:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210608204542.983925-1-angelo@kernel-space.org>
 <20210608204542.983925-5-angelo@kernel-space.org> <DB8PR04MB6795CE1FF40605F69E3A0040E6369@DB8PR04MB6795.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB6795CE1FF40605F69E3A0040E6369@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Jun 2021 10:12:35 +0200
Message-ID: <CAMuHMdUeeH2BWgVRoVX7yfckY=wi8X3qkaH0THhVF_3FpZsbqg@mail.gmail.com>
Subject: Re: [PATCH 5/5] can: flexcan: add mcf5441x support
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Angelo Dureghello <angelo@kernel-space.org>
Cc:     "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Joakim, Angelo,

On Wed, Jun 9, 2021 at 4:05 AM Joakim Zhang <qiangqing.zhang@nxp.com> wrote:
> > From: Angelo Dureghello <angelo@kernel-space.org>
> > Sent: 2021年6月9日 4:46
> > To: gerg@linux-m68k.org; wg@grandegger.com; mkl@pengutronix.de
> > Cc: geert@linux-m68k.org; linux-m68k@vger.kernel.org;
> > linux-can@vger.kernel.org; Joakim Zhang <qiangqing.zhang@nxp.com>;
> > Angelo Dureghello <angelo@kernel-space.org>
> > Subject: [PATCH 5/5] can: flexcan: add mcf5441x support
> >
> > Add flexcan support for NXP ColdFire mcf5441x family.
> >
> > This flexcan module is quite similar to imx6 flexcan module, but with some
> > exceptions:
> >
> > - 3 separate interrupt sources, MB, BOFF and ERR,
> > - implements 16 mb only,
> > - m68k architecture is not supporting devicetrees, so a
> >   platform data check/case has been added,
> > - ColdFire is m68k, so big-endian cpu, with a little-endian flexcan
> >   module.
> >
> > Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>

> > --- a/drivers/net/can/flexcan.c
> > +++ b/drivers/net/can/flexcan.c

> > @@ -637,13 +650,17 @@ static int flexcan_clks_enable(const struct
> > flexcan_priv *priv)  {
> >       int err;
> >
> > -     err = clk_prepare_enable(priv->clk_ipg);
> > -     if (err)
> > -             return err;
> > +     if (priv->clk_ipg) {
> > +             err = clk_prepare_enable(priv->clk_ipg);
> > +             if (err)
> > +                     return err;
> > +     }
> >
> > -     err = clk_prepare_enable(priv->clk_per);
> > -     if (err)
> > -             clk_disable_unprepare(priv->clk_ipg);
> > +     if (priv->clk_per) {
> > +             err = clk_prepare_enable(priv->clk_per);
> > +             if (err)
> > +                     clk_disable_unprepare(priv->clk_ipg);
> > +     }
>
> No need do this check, it will be handled in clk_prepare_enable() / clk_disable_unprepare(). So this change is unnecessary.

Except that the non-CCF implementation of clk_enable() in
arch/m68k/coldfire/clk.c still returns -EINVAL instead of NULL.
Any plans to move to CCF? Or at least fix legacy clk_enable().

> > @@ -2091,6 +2133,11 @@ static int flexcan_probe(struct platform_device
> > *pdev)
> >
> >       devtype_data = of_device_get_match_data(&pdev->dev);
> >
> > +     if (pdata && !devtype_data) {
> > +             devtype_data =
> > +                     (struct flexcan_devtype_data *)&fsl_mcf_devtype_data;

Cast not needed?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
