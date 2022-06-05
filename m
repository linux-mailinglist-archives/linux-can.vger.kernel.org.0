Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5780F53D928
	for <lists+linux-can@lfdr.de>; Sun,  5 Jun 2022 04:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbiFECFL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 4 Jun 2022 22:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbiFECFJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 4 Jun 2022 22:05:09 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605764EDEA;
        Sat,  4 Jun 2022 19:05:07 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2f83983782fso114810617b3.6;
        Sat, 04 Jun 2022 19:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ila35nCJJFbl+jSZSRY4AKRRNjsznBzv2d2OSpQzPXY=;
        b=JmFUkHR0P0taeGA5MwEk1KlQIol7XcLaxAFolKwSeRFDoqO25j7op9w+x4Ly7bptDr
         bh534s57a2evpaHfEHe3DkLxXvo2Ny9yfpcvNtsrQoRrzUkLQgiw/9vt9jAqEsoSXl3Q
         fU1Z1Rgw3NP9cVgwjxNKDpoppwAdMDg/O7W4uS6Qa82/91oY2/kSHzRY3TpJwyoiuAZy
         m2/heGXGY57YtlgkxF1CM7TAmhCqLn94LO+uhkJtAAAmkKurK7aBsCmYl1HfIVyXXT6g
         eEksE6GFLohTIYB3neRcTwsarBsLWe58dmvRNMh3nJORUFuNmpUofps7UP8mf8zsr6t1
         aGFQ==
X-Gm-Message-State: AOAM533KBZgc6eylvS2iPYuEpl3BiWh/vZfycw6VhQrwoffpX9QLDPwM
        La1G6YI0R3hQ34R12wU9oJPJtL06oArRTGsF/zywj4vyVLw=
X-Google-Smtp-Source: ABdhPJxQEvm2x9VVVthuCWz78ot4M3KYXlWaBLvuPVfdm1uIbGVBJAjijW5v63l2H/ksXFW3XPETghR+7pHi0fTHtME=
X-Received: by 2002:a81:c443:0:b0:2d0:dfa3:9ed9 with SMTP id
 s3-20020a81c443000000b002d0dfa39ed9mr18816152ywj.220.1654394706536; Sat, 04
 Jun 2022 19:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2206041003320.1657582@thelappy>
 <20220604144157.208849-1-mailhol.vincent@wanadoo.fr> <YpuLGkPcXrM+Eiwj@rowland.harvard.edu>
In-Reply-To: <YpuLGkPcXrM+Eiwj@rowland.harvard.edu>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 5 Jun 2022 11:04:55 +0900
Message-ID: <CAMZ6RqLA=0WDCQYULtHyNkZ-+FUZP2T+t3oWi1H+nLQi5mLQsA@mail.gmail.com>
Subject: Re: [RFC PATCH] USB: core: urb: add new transfer flag URB_FREE_COHERENT
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Rhett Aultman <rhett.aultman@samsara.com>, wg@grandegger.com,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-can@vger.kernel.org, linux-usb@vger.kernel.org
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

On Sun. 5 juin 2022 at 01:40, Alan Stern <stern@rowland.harvard.edu> wrote :
> On Sat, Jun 04, 2022 at 11:41:57PM +0900, Vincent Mailhol wrote:
> > When allocating URB memory with kmalloc(), drivers can simply set the
> > URB_FREE_BUFFER flag in urb::transfer_flags and that way, the memory
> > will be freed in the background when calling killing the URB (for
> > example with usb_kill_anchored_urbs()).
> >
> > However, there are no equivalent mechanism when allocating DMA memory
> > (with usb_alloc_coherent()).
> >
> > This patch adds a new flag: URB_FREE_COHERENT. Setting this flag will
> > cause the kernel to automatically call usb_free_coherent() when the
> > URB is killed, similarly to how URB_FREE_BUFFER triggers a call to
> > kfree().
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> > Hi Rhett Aultman,
> >
> > I put the code snippet I previously sent into a patch. It is not
> > tested (this is why I post it as RFC). Please feel free to add this to
> > your series.
> > ---
> >  drivers/usb/core/urb.c | 3 +++
> >  include/linux/usb.h    | 1 +
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> > index 33d62d7e3929..1460fdac0b18 100644
> > --- a/drivers/usb/core/urb.c
> > +++ b/drivers/usb/core/urb.c
> > @@ -22,6 +22,9 @@ static void urb_destroy(struct kref *kref)
> >
> >       if (urb->transfer_flags & URB_FREE_BUFFER)
> >               kfree(urb->transfer_buffer);
> > +     else if (urb->transfer_flags & URB_FREE_COHERENT)
> > +             usb_free_coherent(urb->dev, urb->transfer_buffer_length,
> > +                               urb->transfer_buffer, urb->transfer_dma);
> >
> >       kfree(urb);
> >  }
> > diff --git a/include/linux/usb.h b/include/linux/usb.h
> > index 60bee864d897..2200b3785fdb 100644
> > --- a/include/linux/usb.h
> > +++ b/include/linux/usb.h
> > @@ -1328,6 +1328,7 @@ extern int usb_disabled(void);
> >  #define URB_NO_INTERRUPT     0x0080  /* HINT: no non-error interrupt
> >                                        * needed */
> >  #define URB_FREE_BUFFER              0x0100  /* Free transfer buffer with the URB */
> > +#define URB_FREE_COHERENT    0x0400  /* Free DMA memory of transfer buffer */
> >
> >  /* The following flags are used internally by usbcore and HCDs */
> >  #define URB_DIR_IN           0x0200  /* Transfer from device to host */
>
> I don't see anything wrong with this, except that it would be nice to keep
> the flag values in numerical order.  In other words, set URB_FREE_COHERENT
> to 0x0200 and change URB_DIR_IN to 0x0400.

Indeed, the URB_DIR_IN macro is not part of the UAPI so it should be
safe to renumber it. Maybe I was confused by the USB_DIR_IN which is
part of UAPI so some part of my subcocient was telling me not to
change it...

Thanks for pointing this out, I will send a v2 right away (and I will
keep the RFC tag because this is not yet tested).


Yours sincerely,
Vincent Mailhol
