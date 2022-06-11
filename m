Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B262654764B
	for <lists+linux-can@lfdr.de>; Sat, 11 Jun 2022 18:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbiFKQDZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 11 Jun 2022 12:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiFKQDX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 11 Jun 2022 12:03:23 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2137F656A;
        Sat, 11 Jun 2022 09:03:17 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id v81so3455659ybe.0;
        Sat, 11 Jun 2022 09:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w59dRwET9RMHGGruChfZrR2QZTuv2/U+buiZBwoCPWE=;
        b=EIq7TtUOvzqUN6cXrEI5O73nEVXUVtxdtBbUUo0A17uE/yyZvX/5rgM3boZraxavd8
         HafzX6j/GeMsvnf9qbDhx09SLgizqICGLXXqccwiaMO1w0qArrj/s+wNsjFFyOXAzJqI
         2ibImvMYpjxAHU3L36CJq3bhjSnw5l959BpLfH1l7v2rBZmutTDEqGiivQPfC6wuxJ7C
         Baq6zdPz+t1Wm6rUnZgA8ZIjL//IAbQ8ZBN5sZF8G8+9RV0Xcbf9ABKVLprBWdwRctXb
         stV5qnI3pqQ1ttfLC0fGI66BhBoYrsgZDnQ64n9emY3PZdUI1xruEPr1f30MweG3DY96
         rntA==
X-Gm-Message-State: AOAM5306I4N3qI5+HVr0pqWp7w0MFrKzvAaR9NAQ6FSYH+06Vzg+QFOS
        Br+yeEDekQzJBKfk8TdikYEHyBG/nw46HIBkBig=
X-Google-Smtp-Source: ABdhPJzzDOy4a3Xkiem/+j24o/RF5DEaAQHnBWUmn4U/rFHK4y2bSsb/G2Fa/KTWVz3jYlv2ItWEU4MDVLan8dY0D1M=
X-Received: by 2002:a25:9789:0:b0:664:901e:7bcd with SMTP id
 i9-20020a259789000000b00664901e7bcdmr2400918ybo.500.1654963396075; Sat, 11
 Jun 2022 09:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-3-rhett.aultman@samsara.com> <20220611153543.s5enriuu7jcllz3t@pengutronix.de>
In-Reply-To: <20220611153543.s5enriuu7jcllz3t@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 12 Jun 2022 01:03:04 +0900
Message-ID: <CAMZ6RqK2TFg=15CTCSfbO+TE5kUvPLyt2iRwwvUVGzihA2Ctuw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] can: gs_usb: fix DMA memory leak on close
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Rhett Aultman <rhett.aultman@samsara.com>,
        linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun. 12 juin 2022 at 00:35, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 10.06.2022 17:33:37, Rhett Aultman wrote:
> > The gs_usb driver allocates DMA memory with usb_alloc_coherent() in
> > gs_can_open() and then keeps this memory in an URB, with the expectation
> > that the memory will be freed when the URB is killed in gs_can_close().
> > Memory allocated with usb_alloc_coherent() cannot be freed in this way
> > and must be freed using usb_free_coherent() instead.  This means that
> > repeated cycles of calling gs_can_open() and gs_can_close() will lead to
> > a memory leak.
> >
> > Historically, drivers have handled this by keeping an array of pointers
> > to their DMA rx buffers and explicitly freeing them.  For an example of
> > this technique used in the esd_usb2 driver, see here:
> > https://www.spinics.net/lists/linux-can/msg08203.html

Hi Rhett,

It seems that you missed one of my previous comments. Please check this:
https://lore.kernel.org/linux-can/CAMZ6RqJ6fq=Rv-BuL6bA89E_DQdJ949quSWjyphy+2tOJJ=kGw@mail.gmail.com/
and add the Fixes tag.

Thank you.

> Better reference the commit or use a link to lore.kernel.org:
>
> 928150fad41b ("can: esd_usb2: fix memory leak")
> https://lore.kernel.org/all/b31b096926dcb35998ad0271aac4b51770ca7cc8.1627404470.git.paskripkin@gmail.com/
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
