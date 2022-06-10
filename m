Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE7B54598C
	for <lists+linux-can@lfdr.de>; Fri, 10 Jun 2022 03:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiFJB2d (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 Jun 2022 21:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345504AbiFJB23 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Jun 2022 21:28:29 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFD640E7D;
        Thu,  9 Jun 2022 18:28:25 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id h27so415003ybj.4;
        Thu, 09 Jun 2022 18:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b/7KNh9s+MFyW7FHyqGy/cWHV9LNJaLnUFNwS0lEkfo=;
        b=nWpwXoYycX1subytWcd82uj/10TPG7bJz+j06jndBEWouuIUQo+xVspGAcjl3HrMeQ
         XCnEVKlyU96Ho9/mWbGYnt22aTWmsLDRMuMoXEaOYsHjxT6ky3D1FqXOpd7csihi2SdR
         tOQgL5gyrsW79ieQE0GfTGp4yBLOT4XICBQaPzRmjg4JFf6dbg/bmTh7Z3cmgiTV+kD2
         FKvuzaXLf1M+U4ADfms/EF0XzHMAIek4MYVHpZE9RcOsUuinyZjYji7qf0FHl6GA/gGB
         Y4PaWqEck47qAt/kS9DtivPfKu/fXF320CVkBa+JNW2s7aBEODDtFG2DJ0aOcJDyBinV
         d+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b/7KNh9s+MFyW7FHyqGy/cWHV9LNJaLnUFNwS0lEkfo=;
        b=N2z42j0tnoQTELgNhbPG+WOjsTA2evBrNtpfTxJFy+avwpc0FjFdVYvUgHaIYZV9Nz
         a9/w+Qhkvg5X8JjgBy6/wvUNn6ZjHYEeUIDMOy8FnHFDjli5Ipna0Fqvsif1KHAYr8KV
         2KnRxYLv0h0pMLyaaJuCiPp6m3tNK3kfk6HwkolldX1uYY0Bi/mvGbNrc1JxbqbYyu68
         a9WkK8D5Wtlvp6NMGxlfXgDd9F7sYVdtStq6PSsUUaTs88800xYMOp7RlCm4SFwt2dul
         ikn6YrLo2WuOpfHws2z4D1659o5WeBkYvm/htdvM3L3b51qn2sD1343qUfRg4V+Uzm/S
         EFnw==
X-Gm-Message-State: AOAM530Uu9IMcxpSVs/CUViHYzvuHHBy4puT4yI/gmtd5YghtY54K2G1
        KH0cJu54R+YkwyupfPOioOJejxZVdzK7YKR3+nVegSRWJEJQWw==
X-Google-Smtp-Source: ABdhPJyQrSHn/B5qxkQ1AkVegf5a9gE0ohxvTowVHzeS+Z7sOa/GoCJVd0HV/G43XbKEeaQ1nwfyHSjxeFBV46tbBmw=
X-Received: by 2002:a25:6588:0:b0:65d:57b9:c470 with SMTP id
 z130-20020a256588000000b0065d57b9c470mr43530425ybb.142.1654824504751; Thu, 09
 Jun 2022 18:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2206031547001.1630869@thelappy>
 <20220609204714.2715188-1-rhett.aultman@samsara.com> <20220609204714.2715188-4-rhett.aultman@samsara.com>
 <CAMZ6RqKwvSswxThiKqEB8VhD5MyHvRbSwO_9-ZNwLgmnm-0iBw@mail.gmail.com>
In-Reply-To: <CAMZ6RqKwvSswxThiKqEB8VhD5MyHvRbSwO_9-ZNwLgmnm-0iBw@mail.gmail.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 10 Jun 2022 10:28:14 +0900
Message-ID: <CAMZ6RqJ6fq=Rv-BuL6bA89E_DQdJ949quSWjyphy+2tOJJ=kGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] can: gs_usb: fix DMA memory leak on close
To:     Rhett Aultman <rhett.aultman@samsara.com>
Cc:     linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.org>,
        Alan Stern <stern@roland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 10 juin 2022 at 09:05, Vincent Mailhol
<vincent.mailhol@gmail.com> wrote:
> On Fri. 10 Jun 2022 at 05:53, Rhett Aultman <rhett.aultman@samsara.com> w=
rote:
> > The gs_usb driver allocates DMA memory with usb_alloc_coherent() in
> > gs_can_open() and then keeps this memory in an URB, with the expectatio=
n
> > that the memory will be freed when the URB is killed in gs_can_close().
> > Memory allocated with usb_alloc_coherent() cannot be freed in this way
> > and much be freed using usb_free_coherent() instead.  This means that
>       ^^^^
> and must
>
> > repeated cycles of calling gs_can_open() and gs_can_close() will lead t=
o
> > a memory leak.
> >
> > Historically, drivers have handled this by keeping an array of pointers
> > to their DMA rx buffers and explicitly freeing them.  For an example of
> > this technique used in the esd_usb2 driver, see here:
> > https://www.spinics.net/lists/linux-can/msg08203.html
> >
> > While the above method works, the conditions that cause this leak are
> > not apparent to driver writers and the method for solving it at the
> > driver level has been piecemeal.  This patch makes use of a new
> > URB_FREE_COHERENT flag on the URB, reducing the solution of this memory
> > leak down to a single line of code.
> >

One more thing, for bug fixes, the best practice is to add a Fixes tag. c.f=
.:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#desc=
ribe-your-changes

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices=
")

> > Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
> > ---
> >  drivers/net/can/usb/gs_usb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.=
c
> > index b29ba9138866..3ded3e14c830 100644
> > --- a/drivers/net/can/usb/gs_usb.c
> > +++ b/drivers/net/can/usb/gs_usb.c
> > @@ -768,7 +768,7 @@ static int gs_can_open(struct net_device *netdev)
> >                                           buf,
> >                                           dev->parent->hf_size_rx,
> >                                           gs_usb_receive_bulk_callback,=
 parent);
> >
> > -                       urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MA=
P;
> > +                       urb->transfer_flags |=3D (URB_NO_TRANSFER_DMA_M=
AP | URB_FREE_COHERENT);
>
> Nitpick but parenthesis are not needed here. Also, there are no
> reasons to do a |=3D. I would prefer to see this:
>         urb->transfer_flags =3D URB_NO_TRANSFER_DMA_MAP | URB_FREE_COHERE=
NT;
>
> >                         usb_anchor_urb(urb, &parent->rx_submitted);
>
> I looked at the code of gs_usb, this driver has a lot of dust. What
> strikes me the most is that it uses usb_alloc_coherent() each time in
> its xmit() function instead of allocating the TX URB once in the
> open() function and resubmitting then in the callback function. That
> last comment is not a criticism of this patch. But if someone has the
> motivation to do some cleaning, go ahead=E2=80=A6
>
> Aside from the nitpicks, the patch looks good to me. You can add this
> to your v3:
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>
>
> Yours sincerely,
> Vincent Mailhol
