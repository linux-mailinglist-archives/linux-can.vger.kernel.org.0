Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6889970ED17
	for <lists+linux-can@lfdr.de>; Wed, 24 May 2023 07:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjEXFbf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 24 May 2023 01:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239424AbjEXFb1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 May 2023 01:31:27 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C69E41
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 22:31:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-25332422531so630416a91.0
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 22:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684906270; x=1687498270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z936gOiVRN2f8CxYaPFNRFl4gZMz9wRY2If+p7ka5q8=;
        b=UTMPljeFGiX/NgU/J4v67fgH/24dbVzC3tHLBNBqoOxdpKQDjXm3d+MuS6bO7aXO4S
         mOVvWXmCADr6CuucQYKNY2tdC2//Zc7/I9fWbkf8QYs5Cioo/07X6hGMq5WODnLX5Doz
         878CIl5MTZQdMROitPjhX1hJen1yWTv+D2lmdeN5Rj2EGj8/SGbXs2++1vOBh6Gt/TAl
         S96HaXYJX2Wrn1au1G6EUf7xIgBG19kttkFu37QHpGI9eZJ2Hmq5mbW5ot2rcIqpflzT
         BcnsbgEJNLuTLZo5sD+buAX6vFRLJ0IRCssBaowayDxjEo8xp2RTX9sPfKzP5OhxT+fd
         yA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684906270; x=1687498270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z936gOiVRN2f8CxYaPFNRFl4gZMz9wRY2If+p7ka5q8=;
        b=TDJbZzlJRKrdN0jvBt5NnayY1hXtN/KI2WSu+1bSRYiG1Ikri0E1feR2NQTEaqTaEV
         hVTfvU1SgrJsPOfdo28guEyuWKSEAnN0eWMs9zZkCNvPcp5jqWgmSAbusFE5p517vi/+
         Y8Kj3ILQjXnpF3Wa+KgTE+DMaSqKDryaeRUWhgVP0ZEVwXSW78sqBMk6M/adqbnbAGyU
         TP/HqZv9JEqZJwq2iYRWBcJ8Pyj58IR9UPzOuC4nNBLvW11YmeSZ4HqU+Qqfq2Hj1xm8
         4t9QBzTOmyQq+/D6zyn87pCmFnzDZoVvfLQdSr53Lm9WxFMCimYLjMdw1/N/kXSEku4q
         xV/g==
X-Gm-Message-State: AC+VfDw1Tk5VDLpeWnAShOybImZ0X4wQ21/THKlqB5PyMpSMnWaFRfI9
        Gr6SZ8GIYd6yza3LwZbntF292301psAj3fljppI=
X-Google-Smtp-Source: ACHHUZ4jm9C1qG/XfqEdtSBHk2arTcFEXcVKWgN53ECDsez0Ft47NLqFG3kOkUg4SWW8EPWbVFBkLVNWOIfFGEyiFZM=
X-Received: by 2002:a17:90b:4f8b:b0:255:c061:9e6b with SMTP id
 qe11-20020a17090b4f8b00b00255c0619e6bmr2850056pjb.11.1684906269996; Tue, 23
 May 2023 22:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230515212930.1019702-1-mkl@pengutronix.de> <CAMZ6RqKToYbfsOX4v_jK7X28hLyiYnH7j784eVeFuKrj7ujRSA@mail.gmail.com>
 <20230522215354.2c79c007@gmx.net> <20230522-hesitant-dehydrate-d2af514565d0-mkl@pengutronix.de>
In-Reply-To: <20230522-hesitant-dehydrate-d2af514565d0-mkl@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 24 May 2023 14:30:58 +0900
Message-ID: <CAMZ6Rq+-4D_W8d_2wxuN5TnTmRZ4+C3MwGuBOVNH_vQ2UveTbw@mail.gmail.com>
Subject: Re: [PATCH v8] can: usb: IXXAT USB-to-CAN adapters drivers
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Peter Seiderer <ps.report@gmx.net>, linux-can@vger.kernel.org,
        Florian Ferg <flfe@hms-networks.de>, socketcan@hms-networks.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 23 May 2023 at 05:06, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 22.05.2023 21:53:54, Peter Seiderer wrote:
> > > > +static int ixxat_usb_init_ctrl(struct ixxat_usb_device *dev)
> > > > +{
> > > > +       const struct can_bittiming *bt = &dev->can.bittiming;
> > > > +       const u16 port = dev->ctrl_index;
> > > > +       int err;
> > > > +       struct ixxat_usb_init_cl1_cmd *cmd;
> > > > +       const u32 rcv_size = sizeof(cmd->res);
> > > > +       const u32 snd_size = sizeof(*cmd);
> > >
> > > Remove those size variables and directly use sizeof(cmd->res) and
> > > sizeof(*cmd) in the code.
> >
> > O.k.
> >
> > >
> > > > +       u8 opmode = IXXAT_USB_OPMODE_EXTENDED | IXXAT_USB_OPMODE_STANDARD;
> > > > +       u8 btr0 = ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
> > >
> > > Add a macro definition for the 0x3f  and 0x3 masks using GENMASK() and
> > > then calculate the value using FIELD_PREP().
> >
> > O.k., define names o.k.?
>
> ACK
>
> > +#define IXXAT_USB_CAN_BTR0_BRP_MASK GENMASK(5, 0)
> > +#define IXXAT_USB_CAN_BTR0_SJW_MASK GENMASK(7, 6)
>
> Now use:
>         btr0 = FIELD_PREP(IXXAT_USB_CAN_BTR0_BRP_MASK, bt->brp - 1) |
>                 FIELD_PREP(IXXAT_USB_CAN_BTR0_SJW_MASK, bt->sjw - 1);
>
> [...]
>
> > > > +static void ixxat_usb_update_ts_now(struct ixxat_usb_device *dev, u32 ts_now)
> > > > +{
> > > > +       u32 *ts_dev = &dev->time_ref.ts_dev_0;
> > > > +       ktime_t *kt_host = &dev->time_ref.kt_host_0;
> > > > +       u64 timebase = (u64)0x00000000FFFFFFFF - (u64)(*ts_dev) + (u64)ts_now;
> > >
> > > Replace 0x00000000FFFFFFFF by U32_MAX from linux/limits.h
> >
> > O.k.
>
> Can you read the free running timer register a USB transfer? If so, it's
> better to use the cyclecounter/timecounter framework.
>
> [...]
>
> > > > +static void ixxat_usb_decode_buf(struct urb *urb)
> > > > +{
> > > > +       struct ixxat_usb_device *dev = urb->context;
> > > > +       struct net_device *netdev = dev->netdev;
> > > > +       struct ixxat_can_msg *can_msg;
> > > > +       int err = 0;
> > > > +       u32 pos = 0;
> > > > +       u8 *data = urb->transfer_buffer;
> > > > +
> > > > +       while (pos < urb->actual_length) {
> > > > +               u32 time;
> > > > +               u8 size;
> > > > +               u8 type;
> > > > +
> > > > +               can_msg = (struct ixxat_can_msg *)&data[pos];
> > > > +               if (!can_msg || !can_msg->base.size) {
> > > > +                       err = -ENOTSUPP;
> >
> > checkpatch.pl warns about this one:
> >
> >       WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> >       #1045: FILE: drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c:644:
> >       +                       err = -ENOTSUPP;
> >
> > Is EOPNOTSUPP appropriate (or EBADMSG as below)?
>
> EBADMSG sounds good.

These being used within your driver, I think it is fine to use what
you think is convenient. At the end of the day, if there is an issue,
the error code will be reported to the maintainer (you?). Of course,
it is always better to silence the checkpatch.pl warnings.

EBADMSG is good. I also like EMSGSIZE. While EMSGSIZE is normally
reserved for "Message[s] too long":

  https://elixir.bootlin.com/linux/latest/source/include/uapi/asm-generic/errno.h#L73

it describes the issue pretty well.

> [...]
>
> > > > +static void ixxat_usb_read_bulk_callback(struct urb *urb)
> > > > +{
> > > > +       struct ixxat_usb_device *dev = urb->context;
> > > > +       const struct ixxat_usb_adapter *adapter = dev->adapter;
> > > > +       struct net_device *netdev = dev->netdev;
> > > > +       struct usb_device *udev = dev->udev;
> > > > +       int err;
> > > > +
> > > > +       if (!netif_device_present(netdev))
> > > > +               return;
> > > > +
> > > > +       switch (urb->status) {
> > > > +       case 0: /* success */
> > > > +               break;
> > > > +       case -EPROTO:
> > > > +       case -EILSEQ:
> > > > +       case -ENOENT:
> > > > +       case -ECONNRESET:
> > > > +       case -ESHUTDOWN:
> > > > +               return;
> > > > +       default:
> > > > +               netdev_err(netdev, "Rx urb aborted /(%d)\n", urb->status);
> > >
> > > Do not use parenthesis in log messages.
> > >
> > > Ref: https://www.kernel.org/doc/html/latest/process/coding-style.html#printing-kernel-messages
> > >
> > >   Printing numbers in parentheses (%d) adds no value and should be avoided.
> > >
> >
> > O.k., seems a common pattern, at least the same logging used in peak_usb,
> > change it there as well (but seems you answered this in another thread
> > already '...but bonus points if you send a clean-up patch to fix
> > the existing log messages...')?
>
> IIRC the %pe is quite new compared to the peak_usb driver. Code evolves
> and new code should not be based on outdated examples/drivers.

Yes, that was added in October 2019:

  commit 57f5677e535b ("printf: add support for printing symbolic error names")
  Link: https://git.kernel.org/torvalds/c/57f5677e535b

There is no strong rule to use %pe but I think this gives a better
user experience, so I encourage any new code to use it. The ban of
parentheses (%d) is a way older rule which predates the git history,
it is just that humans are humans and that went through the cracks in
past reviews.

For the existing code, it is as it is. If someone courageous enough
wants to do a big clean-up, it would be great, but there are style
discrepancies everywhere in the code base.

> [...]
>
> > > > +/**
> > > > + * struct ixxat_canbtp Bittiming parameters (CL2)
> > > > + * @mode: Operation mode
> > > > + * @bps: Bits per second
> > > > + * @ts1: First time segment
> > > > + * @ts2: Second time segment
> > > > + * @sjw: Synchronization jump width
> > > > + * @tdo: Transmitter delay offset
> > > > + *
> > > > + * Bittiming parameters of a CL2 initialization request
> > > > + */
> > > > +struct ixxat_canbtp {
> > > > +       __le32 mode;
> > > > +       __le32 bps;
> > > > +       __le16 ts1;
> > > > +       __le16 ts2;
> > > > +       __le16 sjw;
> > > > +       __le16 tdo;
> > >
> > > It seems that your device supports TDC. What is the reason to not configure it?
> > >
> > > Please have a look at struct can_tdc:
> > >
> > >   https://elixir.bootlin.com/linux/v6.2/source/include/linux/can/bittiming.h#L21
> > >
> > > Please refer to this patch if you want an example of how to use TDC:
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1010a8fa9608
> > >
> >
> > Not sure about this one (and I have limited knowledge of the hardware details),
> > seems I need to find more (spare) time to look into this one, or maybe
> > something better for an follow-up patch?
>
> We usually need TDC for bit rates > 1..2 MBit/s

If you do not have the hardware specification (or at least the
documentation of ixxat_canbtp->tdo) then it will be hard for you to do
anything here.

I am fine to skip the TDC features for now and have it as a follow-up
patch if you manage to figure it out someday.


Yours sincerely,
Vincent Mailhol
