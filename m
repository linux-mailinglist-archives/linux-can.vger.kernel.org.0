Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDFC53D4E0
	for <lists+linux-can@lfdr.de>; Sat,  4 Jun 2022 04:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiFDC0P (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 3 Jun 2022 22:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiFDC0O (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Jun 2022 22:26:14 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673674E3AF;
        Fri,  3 Jun 2022 19:26:13 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2ff7b90e635so98824957b3.5;
        Fri, 03 Jun 2022 19:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGLXb5fORHLyYAw9LwMc2SJHXw1wBZUjMfsmSMCCZgo=;
        b=8E9q0jQBj+JGN4VRRoiEkEmICFiYQwkKQ/sPsHB3PJNi4/ddQNcvsdr6OGaznH3tbj
         7acsfdWl/F8E2MtsXdkOl35J0Bek2HdpSlw6YHr0W/g/5lwWO3SHD2nC/6lik9aElNYf
         IPQY9enZxSdjS6vT90CcR1+g6SX6QqVstTWd1c2FTHzTLMwD12Pww8qXORtnPwKooXRU
         8NJ5aoeDjjb/bAHiEMRvoWnWN4BUWiCO2kiIT6S31rfh+1Slpxv+ut1XOTf8JOz9/73z
         tQ/QvgybWhKGuPCy7tdx8W0mF3Awd8+0NFFbnYHwNQR1gi4nGHAmNz5osn+tLH87He+I
         nt9w==
X-Gm-Message-State: AOAM533lr+zNSqmO1Sd+OXbwoDiGsMJeOy30GoR29WEARD+DSJa9B8Ce
        Tu51QT3Cx7iwF4jsvpD78gSXtbJkWuwKi319p1Q=
X-Google-Smtp-Source: ABdhPJyckGhObs+INGzWiv+IK/fBs/8/3KyBCrGTQ5BBJM9bDGnX7I6GrX+NOXaBLT3mmphxS6ejRR6pYdVrbRgOCEI=
X-Received: by 2002:a81:1845:0:b0:30c:b463:cff3 with SMTP id
 66-20020a811845000000b0030cb463cff3mr14308505ywy.45.1654309572531; Fri, 03
 Jun 2022 19:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2206031547001.1630869@thelappy> <20220604021145.55484-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220604021145.55484-1-mailhol.vincent@wanadoo.fr>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 4 Jun 2022 11:26:01 +0900
Message-ID: <CAMZ6RqJJbw6e8n=XRL7cn3P08XJFQCuVP83M2oGLjrrb-HWOfA@mail.gmail.com>
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

On Sat. 4 Jun. 2022 at 11:12, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> +CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +CC: linux-usb@vger.kernel.org
>
> Rhett Aultman <rhett.aultman@samsara.com> writes:
> > The gs_usb driver appears to suffer from a malady common to many USB CAN
> > adapter drivers in that it performs usb_alloc_coherent( ) to allocate a
> > number of USB request blocks (URBs) for RX, and then later relies on
> > usb_kill_anchored_urbs( ) to free them, but this doesn't actually free
> > them.  As a result, this may be leaking DMA memory that's been used by the
> > driver.
> >
> > This commit is an adaptation of the techniques found in the esd_usb2 driver
> > where a similar design pattern led to a memory leak.  It explicitly frees
> > the RX URBs and their DMA memory via a call to usb_free_coherent( ).  Since
> > the RX URBs were allocated in the gs_can_open( ), we remove them in
> > gs_can_close( ) rather than in the disconnect function as was done in
> > esd_usb2.
>
> Right. To be frank, I think that there is a gap in the current URB
> interface. If you do a simple kmalloc(), you can just set
> URB_FREE_BUFFER in urb::transfer_flags. usb_kill_anchored_urbs() would
> then eventually call urb_destroy() and automatically free it for you.
>
> As far as I understand, I am not aware of equivalent mechanism to
> automatically call usb_free_coherent() in the case that the driver
> uses DMA memory. And I think that this is the root cause of this
> "malady".
>
> For me, the natural fix would be:
>
> diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> index 33d62d7e3929..1460fdac0b18 100644
> --- a/drivers/usb/core/urb.c
> +++ b/drivers/usb/core/urb.c
> @@ -22,6 +22,9 @@ static void urb_destroy(struct kref *kref)
>
>         if (urb->transfer_flags & URB_FREE_BUFFER)
>                 kfree(urb->transfer_buffer);
> +       else if (urb->transfer_flags & URB_FREE_COHERENT)
> +               usb_free_coherent(urb->dev, urb->transfer_buffer_length,
> +                                 urb->transfer_buffer, urb->transfer_dma);
>
>         kfree(urb);
>  }
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 200b7b79acb5..dfc348d56fed 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -1328,6 +1328,7 @@ extern int usb_disabled(void);
>  #define URB_NO_INTERRUPT       0x0080  /* HINT: no non-error interrupt
>                                          * needed */
>  #define URB_FREE_BUFFER                0x0100  /* Free transfer buffer with the URB */
> +#define URB_FREE_COHERENT      0x0200  /* Free DMA memory of transfer buffer */

#define URB_FREE_COHERENT      0x0400  /* Free DMA memory of transfer buffer */

Obviously, the value 0x0200 is already taken by URB_DIR_IN just below.
So 0x0400 seems more adequate.
Sorry for the noise.

>  /* The following flags are used internally by usbcore and HCDs */
>  #define URB_DIR_IN             0x0200  /* Transfer from device to host */
> ---
>
> After doing this, drivers only have to add the URB_FREE_COHERENT flag
> and voila!
>
> Reusing URB_NO_TRANSFER_DMA_MAP to force a call to usb_free_coherent()
> would be a bad idea because it would result in a double free for all
> the drivers which correctly free their DMA memory. This is why above
> snippet introduces a new URB_FREE_COHERENT flag.
>
> Maybe I missed something obvious, but if so, I would like to
> understand what is wrong in above approach.
>
> >
> > For more information, see the following:
> > * https://www.spinics.net/lists/linux-can/msg08203.html
> > * https://github.com/torvalds/linux
> >     928150fad41 (can: esd_usb2: fix memory leak)
> >
> > From: Rhett Aultman <rhett.aultman@samsara.com>
>
> Nitpick: the From tag is redundant. You already have it in the e-mail
> header. It is relevant to explicitly add the From tag when picking
> someone's else patch, but if the author and the signer are the same,
> you are good to go without.
>
> > Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
> > ---
> >  drivers/net/can/usb/gs_usb.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> > index b29ba9138866..d3a658b444b5 100644
> > --- a/drivers/net/can/usb/gs_usb.c
> > +++ b/drivers/net/can/usb/gs_usb.c
> > @@ -268,6 +268,8 @@ struct gs_can {
> >
> >       struct usb_anchor tx_submitted;
> >       atomic_t active_tx_urbs;
> > +     void *rxbuf[GS_MAX_RX_URBS];
> > +     dma_addr_t rxbuf_dma[GS_MAX_RX_URBS];
>
> I do not like how the driver has to keep in a local array a reference
> to all DMA allocated memory. All this information is redundant because
> already present in the URB. So I really hope that we can fix it on the
> URB API side and remove such complexity on the driver side.
>
> >  };
> >
> >  /* usb interface struct */
> > @@ -742,6 +744,7 @@ static int gs_can_open(struct net_device *netdev)
> >               for (i = 0; i < GS_MAX_RX_URBS; i++) {
> >                       struct urb *urb;
> >                       u8 *buf;
> > +                     dma_addr_t buf_dma;
> >
> >                       /* alloc rx urb */
> >                       urb = usb_alloc_urb(0, GFP_KERNEL);
> > @@ -752,7 +755,7 @@ static int gs_can_open(struct net_device *netdev)
> >                       buf = usb_alloc_coherent(dev->udev,
> >                                                dev->parent->hf_size_rx,
> >                                                GFP_KERNEL,
> > -                                              &urb->transfer_dma);
> > +                                              &buf_dma);
> >                       if (!buf) {
> >                               netdev_err(netdev,
> >                                          "No memory left for USB buffer\n");
> > @@ -760,6 +763,8 @@ static int gs_can_open(struct net_device *netdev)
> >                               return -ENOMEM;
> >                       }
> >
> > +                     urb->transfer_dma = buf_dma;
> > +
> >                       /* fill, anchor, and submit rx urb */
> >                       usb_fill_bulk_urb(urb,
> >                                         dev->udev,
> > @@ -781,10 +786,17 @@ static int gs_can_open(struct net_device *netdev)
> >                                          "usb_submit failed (err=%d)\n", rc);
> >
> >                               usb_unanchor_urb(urb);
> > +                             usb_free_coherent(dev->udev,
> > +                                               sizeof(struct gs_host_frame),
> > +                                               buf,
> > +                                               buf_dma);
> >                               usb_free_urb(urb);
> >                               break;
> >                       }
> >
> > +                     dev->rxbuf[i] = buf;
> > +                     dev->rxbuf_dma[i] = buf_dma;
> > +
> >                       /* Drop reference,
> >                        * USB core will take care of freeing it
> >                        */
> > @@ -842,13 +854,20 @@ static int gs_can_close(struct net_device *netdev)
> >       int rc;
> >       struct gs_can *dev = netdev_priv(netdev);
> >       struct gs_usb *parent = dev->parent;
> > +     unsigned int i;
> >
> >       netif_stop_queue(netdev);
> >
> >       /* Stop polling */
> >       parent->active_channels--;
> > -     if (!parent->active_channels)
> > +     if (!parent->active_channels) {
> >               usb_kill_anchored_urbs(&parent->rx_submitted);
> > +             for (i = 0; i < GS_MAX_RX_URBS; i++)
> > +                     usb_free_coherent(dev->udev,
> > +                                       sizeof(struct gs_host_frame),
> > +                                       dev->rxbuf[i],
> > +                                       dev->rxbuf_dma[i]);
> > +     }
> >
> >       /* Stop sending URBs */
> >       usb_kill_anchored_urbs(&dev->tx_submitted);
> > --
> > 2.30.2
> >
