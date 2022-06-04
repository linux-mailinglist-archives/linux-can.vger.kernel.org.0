Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8574D53D74E
	for <lists+linux-can@lfdr.de>; Sat,  4 Jun 2022 16:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbiFDOxa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 4 Jun 2022 10:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiFDOxa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 4 Jun 2022 10:53:30 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B74E28731;
        Sat,  4 Jun 2022 07:53:29 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id f34so18459560ybj.6;
        Sat, 04 Jun 2022 07:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbIKkQ9MvjZj6Zriuw+OLuJFX5RBqePPJdXr7yrJKBw=;
        b=7Xha9Um+DCCxigVmxs/zHOpR/n2zHk6nt9qdY6ZqCVnyzbeVl2lj6AqFVxE9lCsmYK
         l6YNi3eswJYoQhs+s9XgJ6v7NZbe0oWNzRBZkKQllqM5FQBoTagVhqkXK1wNwMQD5oQE
         IMk2K36WXPzW3W8YYrrauv1U5Mkc2KKAX5kUaCJvf82DfLdO+JEx+f+JIy3M5cJTBx2I
         L7IqmtwP7EFX+4P14L3QDt54Ko7/OQu8KrmuSTxQHyV4+8DYeDP0muuOBfG8jxleJ6BR
         No0a4IyYWRE++e9o6++jqJn0qq+eDmVCgATRs9LhpfVIHhFimSL3XwK2hfRUx6uth2zE
         UuZA==
X-Gm-Message-State: AOAM533NzHCU3HsjmkT8axrDs6LwSMl22qkQQeUdIo7ZJpD2w8Za2FBH
        1S4K5CRz2Rt1ZUs8szWsV0uLce9IwomMo6S7loPEHVsCKnNI+w==
X-Google-Smtp-Source: ABdhPJyw1NRgU5Skta/diSX73qx0+qxN7Jf7CczHrN+9Vw9Mf95VoqkVmDc9EPkOM7Uup8haCeYqSl3w2AFmVFTp7Ys=
X-Received: by 2002:a25:4542:0:b0:660:6b9e:62b8 with SMTP id
 s63-20020a254542000000b006606b9e62b8mr12117967yba.423.1654354408614; Sat, 04
 Jun 2022 07:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2206031547001.1630869@thelappy>
 <20220604021145.55484-1-mailhol.vincent@wanadoo.fr> <CAMZ6RqJJbw6e8n=XRL7cn3P08XJFQCuVP83M2oGLjrrb-HWOfA@mail.gmail.com>
 <alpine.DEB.2.22.394.2206041003320.1657582@thelappy>
In-Reply-To: <alpine.DEB.2.22.394.2206041003320.1657582@thelappy>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 4 Jun 2022 23:53:17 +0900
Message-ID: <CAMZ6RqKttF5Qw3abeMWTqdV+U-cSmZj7P5cFWqRNok7HPb9dfg@mail.gmail.com>
Subject: Re: [PATCH] can: gs_usb: gs_usb_open/close( ) fix memory leak
To:     Rhett Aultman <rhett.aultman@samsara.com>
Cc:     wg@grandegger.com, Marc Kleine-Budde <mkl@pengutronix.de>,
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

On Sat. 4 juin 2022 at 23:08, Rhett Aultman <rhett.aultman@samsara.com> wrote:
> On Sat, 4 Jun 2022, Vincent MAILHOL wrote:
>
> > > For me, the natural fix would be:
> > >
> > > diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> > > index 33d62d7e3929..1460fdac0b18 100644
> > > --- a/drivers/usb/core/urb.c
> > > +++ b/drivers/usb/core/urb.c
> > > @@ -22,6 +22,9 @@ static void urb_destroy(struct kref *kref)
> > >
> > >         if (urb->transfer_flags & URB_FREE_BUFFER)
> > >                 kfree(urb->transfer_buffer);
> > > +       else if (urb->transfer_flags & URB_FREE_COHERENT)
> > > +               usb_free_coherent(urb->dev, urb->transfer_buffer_length,
> > > +                                 urb->transfer_buffer, urb->transfer_dma);
> > >
> > >         kfree(urb);
> > >  }
> > > diff --git a/include/linux/usb.h b/include/linux/usb.h
> > > index 200b7b79acb5..dfc348d56fed 100644
> > > --- a/include/linux/usb.h
> > > +++ b/include/linux/usb.h
> > > @@ -1328,6 +1328,7 @@ extern int usb_disabled(void);
> > >  #define URB_NO_INTERRUPT       0x0080  /* HINT: no non-error interrupt
> > >                                          * needed */
> > >  #define URB_FREE_BUFFER                0x0100  /* Free transfer buffer with the URB */
> > > +#define URB_FREE_COHERENT      0x0200  /* Free DMA memory of transfer buffer */
> >
> > #define URB_FREE_COHERENT      0x0400  /* Free DMA memory of transfer buffer */
> >
> > Obviously, the value 0x0200 is already taken by URB_DIR_IN just below.
> > So 0x0400 seems more adequate.
> > Sorry for the noise.
>
> Now that you've pointed this out, I agree this appears to be the more
> natural way to handle things.  I will take a point of making a rewrite
> here.  Additionally, I'll do my best to bring all the other USB CAN
> drivers in line with this.

For the background, I also had a lot of trouble understanding the
logic of how to usb_free_coherent() URBs when I wrote my own driver
(etas_es58x). At the end, I just mimicked what other USB CAN drivers
were doing which means that the etas_es58x was most certainly also
contaminated by that malady.

I really appreciate your effort to also want to fix others' drivers.

> My only concern in doing that is that I have
> gs_usb devices to confirm the fix with but not devices for the other
> drivers.
>
> > > Maybe I missed something obvious, but if so, I would like to
> > > understand what is wrong in above approach.
>
> I don't think anything is wrong with the above approach.

I hope so. Sometimes, there are some complicated intricacies which are
hard to appreciate (and I am not an expert of the USB subsystem). This
is why I CCed the USB mailing list. If I am wrong, someone should
eventually shout at me.

> I just happened
> to see an issue in the gs_usb driver that was already fixed in the other
> USB CAN drivers, and adapted the fix used in the other drivers to the
> gs_usb one.  Doing so got your attention and you pointed out a more
> general fix, so I agree with going this route.  I'll post a new patch this
> week.

I sent you a patch. You can build on top of it the fixes for the other drivers.
And do not hesitate to resend it as part of your series (and in that
particular case, you would need to explicitly add the From: tag).


Yours sincerely,
Vincent Mailhol
