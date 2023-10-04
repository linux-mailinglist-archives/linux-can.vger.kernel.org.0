Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F577B8025
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 15:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242325AbjJDNDW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 09:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbjJDNDU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 09:03:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CECA6
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 06:03:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c5ff5f858dso15919425ad.2
        for <linux-can@vger.kernel.org>; Wed, 04 Oct 2023 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696424595; x=1697029395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0AzAv3iah44ZPLGU3aaVCRRinyf8D1qXCSSS+WP0fE=;
        b=NlfokEOE6JjQqf7S+shWQf5tldQR7domcNYylZA9t+bRABB0hMLQKfHf64W51TZ1qT
         y2w16xlZuwjTudLFscwJQP9s5WUGVFwRZBj/TTRV6EAphZHVZWberT0TJ9MsWHFd+3Fv
         1erLXxEnnWxm2Ivqe5rYcEIXG7bnxle082CwkUkZ9me92DmoUnOlj22ui1OlCHqbjHqM
         w7ZGDwho9XKmmqLqBm4ksur0JBG5myIyLcsV5ke1dUm0IgQ84BhxwzrvidJ0Wmyg0FDS
         A+b10kEuHT43SM0Anj7hhP2X+yb7X5b1ohyOLhlS/hvp0PwN141DRVZ1U7adZqMQBSn0
         jJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696424595; x=1697029395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0AzAv3iah44ZPLGU3aaVCRRinyf8D1qXCSSS+WP0fE=;
        b=lcs946INQ+3Mmdtzfq1g596iia/hF6RwxIU6ZkcXhrTBYtPBZeztQmSEOnNiMLVh1m
         Dm+EI294ca70auVsFQiqHZuJy6SOsNvNwNdtKqvFGBIgbxD24xKI0Jecjjt/DV5wo9OR
         bGOG53eVyq/i/6r5JPof5t9fNaA0qS0uHJusRTOIiW4nPlovaJm7PSQfGZOLuTY8GfuF
         cLkct8bwx/+aBoUeQ4GEW5ks/6metL1xdlHTW9vBFPD3k+BqkWGej/9aMZUD15Jcadaw
         RVuvLY3xDX5EuTohRjiOnjvCwlWFd5r7lvWHnvoHl9BPEW3oP280FYmp8fINpbjqruil
         2+jw==
X-Gm-Message-State: AOJu0YwYXl9cv7Gfn//w3zIwazFEZcejkCUfKV8YhSg+6R4DykGfpH7S
        kSU52p5Zas78oi1q7RIfVksiiQEe++GdMYmKAlacU7+8lTo=
X-Google-Smtp-Source: AGHT+IESWEOcPoeOBaTmQ9GVSlBuR/L2zoB9rq7o6SKsKMpP4EoZ3Mjn/NBOZ0VwFZoF59k7pm/zMAl4GL8uv0EF6ys=
X-Received: by 2002:a17:90a:ad09:b0:268:2500:b17e with SMTP id
 r9-20020a17090aad0900b002682500b17emr2124541pjq.23.1696424594576; Wed, 04 Oct
 2023 06:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-can-dev-fix-can-restart-v1-0-2e52899eaaf5@pengutronix.de>
 <20231004-can-dev-fix-can-restart-v1-4-2e52899eaaf5@pengutronix.de>
 <CAMZ6Rq+=iaRCroX7kQT5f-+qq5iBv3kFX_sytV8BmF0BcrtX2g@mail.gmail.com>
 <20231004-unengaged-monkhood-a2031eac6013-mkl@pengutronix.de> <20231004-goes-pulse-0ed144520edd-mkl@pengutronix.de>
In-Reply-To: <20231004-goes-pulse-0ed144520edd-mkl@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 4 Oct 2023 22:03:01 +0900
Message-ID: <CAMZ6RqLebgso6rRbYgeSwp5YaeoUs3gSSDH6Wta=aAOweM3kRQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] can: dev: can_restart(): update debug and error messages
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 4 Oct. 2023 at 21:05, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 04.10.2023 13:33:59, Marc Kleine-Budde wrote:
> > On 04.10.2023 19:44:15, Vincent Mailhol wrote:
> > > On Wed. 4 Oct. 2023, 18:18, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > > >
> > > > Update the debug message from "restarted" to "Attempting restart", as
> > > > it is actually printed _before_ restarting the CAN device, and that
> > > > restart may fail.
> > > >
> > > > Also update the error message from printing the error number to
> > > > printing symbolic error names.
> > > >
> > > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > > ---
> > > >  drivers/net/can/dev/dev.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> > > > index 9014256c486a..8e4054e2abcc 100644
> > > > --- a/drivers/net/can/dev/dev.c
> > > > +++ b/drivers/net/can/dev/dev.c
> > > > @@ -147,14 +147,14 @@ static void can_restart(struct net_device *dev)
> > > >                 netif_rx(skb);
> > > >         }
> > > >
> > > > -       netdev_dbg(dev, "restarted\n");
> > > > +       netdev_dbg(dev, "Attempting restart\n");
> > > >         priv->can_stats.restarts++;
>
> What about that counter? Also move it into the no-error case?

Indeed. It makes sense to only increment if the restart actually occurred.
