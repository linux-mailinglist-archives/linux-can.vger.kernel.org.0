Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30405B9ABD
	for <lists+linux-can@lfdr.de>; Thu, 15 Sep 2022 14:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIOM1u (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 15 Sep 2022 08:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIOM1t (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Sep 2022 08:27:49 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED6F6E2F3
        for <linux-can@vger.kernel.org>; Thu, 15 Sep 2022 05:27:48 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id v15so14007078qvi.11
        for <linux-can@vger.kernel.org>; Thu, 15 Sep 2022 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=R4GXUR0A2GjLJhlVCZ766lOHuqhTaf6ukPgKB5lalII=;
        b=KaW3J2rML8GNWXiq6ZuwNsO4sPWPU0pU0jo3CfqsNdBZT4EcCVkO4aIeUY0qQUjdc+
         HN3gkNHgrntFDNIPMlnCRJ02xze8UORXZTKT2G1Amuk+Ukr3I9paKuP6cM6FVdI2tsfZ
         mKtDINXkjfiUvoHyVLNvHsGw/G6phGT4AJHWe2h4XfrgJp37Pjp1SeYz+mzI81OUZI6J
         cgdteXyid4TICWKIqfo8yxyueIS8eOx28lrIK0ZvlZySXrxbF2Wimw9quevJDDBrm1Zy
         dfbiRfWNLEF66cJ47+JZueAL9IxeNhdGZDb0L8qmWOfUjlvIk+KWndEMX4fLUMsaRDKb
         j/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=R4GXUR0A2GjLJhlVCZ766lOHuqhTaf6ukPgKB5lalII=;
        b=jiYKZNfUrDGMhb1geBg0EmVLdmR9tyaPxMBV9WxhhFcmqCcA084k3B6o34Nt/qHM8b
         MuyaiYBQI+mRY+oonY+LzPfaIw0gnxgCHMR4UiJ06MuHHiA56OgZ6tVuE2uneHfjbem3
         tsN2A+gCAgsQ99S14GygR2FDEcKUNh3Iwn3NSNmk9yI8r6y1ay5XH2adz3wWwBeZGXRh
         uT17QKZa7wzKP/82AqkzSNaCGKJJVpQebZiUz7FSVv3arE8zs338nc1xgeIOY9fjYyEN
         90cY+8bf4bt1R5pzr0UB6xNbrnIfZrVVvDDRZmcbXCIsrUgpORfJmvSQfB0tYDJY4eKO
         AAtg==
X-Gm-Message-State: ACrzQf1OvKzK5NbXBg6iakdiPdfGVXYCl/oXqrKjymSK57dMi0DDUY37
        4GGedMELE7u4nf16Vxj0rDKjC+DMTKdnlCCT+7M4GkpXCFQ=
X-Google-Smtp-Source: AMsMyM6UeyReE+9ROIzuAJPtPD0zaY/S5ppuN0isg8forKo2sXkjsp8zrrI16pVCzYNUVj7xVIsmSOEhRmPxJ54oU6U=
X-Received: by 2002:a05:6214:e86:b0:4ad:8c9:a397 with SMTP id
 hf6-20020a0562140e8600b004ad08c9a397mr141301qvb.82.1663244867868; Thu, 15 Sep
 2022 05:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
 <20220726082707.58758-1-mailhol.vincent@wanadoo.fr> <YyLkrj5v2EiBIXk+@surfacebook>
 <20220915122454.xsczmhz4e62musse@pengutronix.de>
In-Reply-To: <20220915122454.xsczmhz4e62musse@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Sep 2022 15:27:11 +0300
Message-ID: <CAHp75VeXbs4AQ-yQvv2kgpwhCF4fkOL83J=1YcfhV+SeRmai=w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] can: remove litteral strings used for driver
 names and remove DRV_VERSION
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Sep 15, 2022 at 3:25 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 15.09.2022 15:18:02, andy.shevchenko@gmail.com wrote:
> > Tue, Jul 26, 2022 at 05:26:57PM +0900, Vincent Mailhol kirjoitti:
> > > This is a cleanup series.
> > >
> > > The patches 1 to 8 get rid of any hardcoded strings and instead relies
> > > on the KBUILD_MODNAME macros to get the device name. Patch 9 replaces
> > > the ES58X_MODULE_NAME macro with KBUILD_MODNAME in
> > > etas_es58x. Finally, also in etas_es58x, patch 10 removes the
> > > DRV_VERSION so that the module uses the default behavior and advertise
> > > the kernel version instead of a custom version.
> >
> > I guess you all understand that this is potential ABI breakage.
>
> Good point.
>
> > The driver can be instantiated by its name (for matching purposes) from board
> > files or MFD cell.
>
> Hope we don't have board files anymore....
>
> > If you change the name of the file, the module will be
> > changed and hence the breakage.
> >
> > That said, NAK from me (as I do usually the opposite change).
>
> Let's look at the diffstat:
>
> These are serial line disciplines, they have their own ID:
>  drivers/net/can/can327.c                         |  4 ++--
>  drivers/net/can/slcan/slcan-core.c               | 14 ++++++++------
>
> This might be a problem, it's a platform driver:
>  drivers/net/can/softing/softing_main.c           |  4 ++--
>
> It should be no problem for USB devices, right?
>  drivers/net/can/usb/ems_usb.c                    |  4 ++--
>  drivers/net/can/usb/esd_usb.c                    |  2 +-
>  drivers/net/can/usb/etas_es58x/es58x_core.c      | 14 +++++---------
>  drivers/net/can/usb/gs_usb.c                     |  6 +++---
>  drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c |  2 +-
>  drivers/net/can/usb/usb_8dev.c                   |  4 ++--

I agree with your grouping and analysis. This is minor anyway, but
better to have it more robust. So, yes, with USB I don't believe it
would be an issue, but for platform driver it might be.


-- 
With Best Regards,
Andy Shevchenko
