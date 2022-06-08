Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4644D543926
	for <lists+linux-can@lfdr.de>; Wed,  8 Jun 2022 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245515AbiFHQeA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Jun 2022 12:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343581AbiFHQdX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Jun 2022 12:33:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4B0304B6C
        for <linux-can@vger.kernel.org>; Wed,  8 Jun 2022 09:33:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a29so5552289lfk.2
        for <linux-can@vger.kernel.org>; Wed, 08 Jun 2022 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nczzxga2VzTI61hjMGVwlFiToqM1MiMF50/6VC0BnkQ=;
        b=HI9q91KmJnodakEMkkvIcxiYFhZNvzMEhXQFmkw2A+WEQNB2WvWMTR52zXEbtXiGC7
         Eb8G/wOjNPG4o+Zf4VOC/PTnskLo2rvM/HO2McFqvH3VOfDwp1F73zj3kj2H8Y2Ty1Np
         GOEiXuyyi8OiCcRkDb3E4hU5I8sGAQia/RdhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nczzxga2VzTI61hjMGVwlFiToqM1MiMF50/6VC0BnkQ=;
        b=OULPfrJoiNjdd0niROAWbGHBdtW9pedjAHLVCsZ/M6K6KOczR+jUnbIz80HPlFcTZm
         XGxafRP09YkWmNjpz857y9kVsftofiLvqjjyw2rVMNCKOjtnLscpgW4k4HTl1wlhzZAE
         uO7qPg1A+2QEq4914KJB7i+xqAeCzENOWvd85kHuT2TmcEVLc+HAeL7HSHRAzSeMY8D0
         rCgxWgi52cxBDTsGULBG/ucTB1hQ4RbueAKm1OOpFl16QSAuMOGEEDLnUno6JXbewpXJ
         qz3Ery3ckeETi+Ehcvxl3UmkjppIiwddEfTZP6BDIBQtZXM7pTuAqhtllQXCNc01DL+g
         Q5VA==
X-Gm-Message-State: AOAM533Evq0lnNZso5hpcVQH0Y/BV2YnPgJVl2zByJDx39xGiMxwbOeV
        cBBrYwmXQJQNuEPOmL9n8Zgyb3bu0AK6EL2je5CaIQ==
X-Google-Smtp-Source: ABdhPJzFy7nO2qnr5fKv1EOnBJmnn8JMOGWwCMrZHyWK3WGmMlta2rubmQComAvKJH2Vek8siCSqG/+MbMYHJs8DBgA=
X-Received: by 2002:a05:6512:3a89:b0:479:52fc:f80a with SMTP id
 q9-20020a0565123a8900b0047952fcf80amr8910198lfu.120.1654705999913; Wed, 08
 Jun 2022 09:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
 <20220607094752.1029295-12-dario.binacchi@amarulasolutions.com> <20220607105225.xw33w32en7fd4vmh@pengutronix.de>
In-Reply-To: <20220607105225.xw33w32en7fd4vmh@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Wed, 8 Jun 2022 18:33:08 +0200
Message-ID: <CABGWkvozX51zeQt16bdh+edsjwqST5A11qtfxYjTvP030DnToQ@mail.gmail.com>
Subject: Re: [RFC PATCH 11/13] can: slcan: add ethtool support to reset
 adapter errors
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Tue, Jun 7, 2022 at 12:52 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 07.06.2022 11:47:50, Dario Binacchi wrote:
> > This patch adds a private flag to the slcan driver to switch the
> > "err-rst-on-open" setting on and off.
> >
> > "err-rst-on-open" on  - Reset error states on opening command
> >
> > "err-rst-on-open" off - Don't reset error states on opening command
> >                         (default)
> >
> > The setting can only be changed if the interface is down:
> >
> >     ip link set dev can0 down
> >     ethtool --set-priv-flags can0 err-rst-on-open {off|on}
> >     ip link set dev can0 up
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> I'm a big fan of bringing the device into a well known good state during
> ifup. What would be the reasons/use cases to not reset the device?

Because by default either slcand and slcan_attach don't reset the error states,
but you must use the `-f' option to do so. So,  I followed this use case.

Thanks and regards,
Dario
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |



-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
