Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0518C547655
	for <lists+linux-can@lfdr.de>; Sat, 11 Jun 2022 18:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiFKQGu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 11 Jun 2022 12:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiFKQGt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 11 Jun 2022 12:06:49 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F6525294;
        Sat, 11 Jun 2022 09:06:49 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3137eb64b67so16446887b3.12;
        Sat, 11 Jun 2022 09:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oeh1RS+gRxsUNDU5zz+azL4BPhkb13sUZDTHCb4dSuQ=;
        b=qiq9BiDzn6WcKvziD8WWb5Swo6QLn1hZ8zG2+SUA3A9TEQot+AGpVJkv9twC+zBUeB
         2BMddf5t2TEfA6ZEDI9aRBTjGHSx8xMYOihnnNVF6ewtdJm3JtC/dtKoS8btJK3RD5DW
         FWoRnpyLXxNdqsOWMTdCRqil1ZoMcsuMWPt5DgCiERPFDOQedGYWWwT81C89oovQeslF
         Jwlx8pQedDGQhsoJiXIkzLOXXGZRm9tdgbIARsqFvjNR0OlUjajc7MZlz7FH1B58smH3
         XgPkR8VU9cE9kzcLoYxq1iGdqtFqHAFiRulGHhRrjCOUED15+qg78t2vATBQNCG8IRin
         h1Eg==
X-Gm-Message-State: AOAM5306hEi5psOGiRjaT6bzEEQLozJmV0WcPYUZmzidbgElgpLtWQ+M
        i86i7hD2mMdtAG0Ypoqd7SYxfS0wREcAN5+ltOc=
X-Google-Smtp-Source: ABdhPJx0O12sgFkHE4UGFP3wSrjxm2O3V3pmLkeaplokyUlLZfdFq4QuAfInHPKgtEE00H3uM70NXAwNeos3yFUdBd8=
X-Received: by 2002:a81:60c6:0:b0:30f:ea59:10c7 with SMTP id
 u189-20020a8160c6000000b0030fea5910c7mr54149593ywb.78.1654963608183; Sat, 11
 Jun 2022 09:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com> <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de>
In-Reply-To: <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 12 Jun 2022 01:06:37 +0900
Message-ID: <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
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

On Sun. 12 juin 2022 at 00:31, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 10.06.2022 17:33:35, Rhett Aultman wrote:
> > From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >
> > When allocating URB memory with kmalloc(), drivers can simply set the
> > URB_FREE_BUFFER flag in urb::transfer_flags and that way, the memory
> > will be freed in the background when killing the URB (for example with
> > usb_kill_anchored_urbs()).
> >
> > However, there are no equivalent mechanism when allocating DMA memory
> > (with usb_alloc_coherent()).
> >
> > This patch adds a new flag: URB_FREE_COHERENT. Setting this flag will
> > cause the kernel to automatically call usb_free_coherent() on the
> > transfer buffer when the URB is killed, similarly to how
> > URB_FREE_BUFFER triggers a call to kfree().
> >
> > In order to have all the flags in numerical order, URB_DIR_IN is
> > renumbered from 0x0200 to 0x0400 so that URB_FREE_COHERENT can reuse
> > value 0x0200.
> >
> > Co-developed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > Co-developed-by: Rhett Aultman <rhett.aultman@samsara.com>
> > Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
> > Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>
> FWIW:
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> This patch probably goes upstream via USB. Once this is in net I'll take
> the 2nd patch.

Question to Greg: can this first patch also be applied to the stable
branches? Technically, this is a new feature but it will be used to
solve several memory leaks on existing drivers (the gs_usb is only one
example).

Yours sincerely,
Vincent Mailhol
