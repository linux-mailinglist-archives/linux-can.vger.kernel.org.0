Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353E453DBBB
	for <lists+linux-can@lfdr.de>; Sun,  5 Jun 2022 15:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbiFENp0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 5 Jun 2022 09:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiFENpY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 5 Jun 2022 09:45:24 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08992BF5;
        Sun,  5 Jun 2022 06:45:22 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id e184so21498711ybf.8;
        Sun, 05 Jun 2022 06:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R34pfQnmxFquIj0LVUUITUioTiz4eH/X4iuz1+vGIgY=;
        b=tACIuu+DKslj1fOp90lB2fIyCc2qylXUs723LAhNx5AF+wtZotwxYpi18vyWX9dLpg
         vf02DijjgX4FV4m5ytwiWXvMm6vOP/XDBcg003ZeAyrfOr6TCv3bxzKQFSbav+NNuNL4
         h1M8MEBEyy7XZsvgzjgwX9zpdfzo4MMfA8MgCMzbldvKfY+9W9rnLNxOuhLGpeSSksDU
         Lwy0HBJ3T4Cwr1DavKSYg/EVCwl+MrG1hlFwCJ07WeacHr+vpeemUsW11qTyCAf0rsSR
         CHo+xRVBmAlACaK1o4ML/RX+UZcUPiRG1d/2QlBJxCEynNs4e/WtR7Vl6KIgq3v7O4KT
         2mQw==
X-Gm-Message-State: AOAM530BX2meX1oUKJTzTOYdPxAJWY/wyd86m2qxSuO4wR5gYtQ7sGOM
        Rs4ZpPuxllB7bUtVdeIBWvCVxJkqOr3XE2vEO3Y=
X-Google-Smtp-Source: ABdhPJw6tMPhxeP7rJc9ruuGtfX9lWIk7o4qAOm2k6qwJ8Nm9WZ+B25OcNZe7svpyr0r6Vmq1cdH9W8FIq4O2nsd6Ms=
X-Received: by 2002:a25:55d7:0:b0:663:3850:e85f with SMTP id
 j206-20020a2555d7000000b006633850e85fmr8237679ybb.500.1654436721994; Sun, 05
 Jun 2022 06:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2206041003320.1657582@thelappy>
 <20220604144157.208849-1-mailhol.vincent@wanadoo.fr> <YpuLGkPcXrM+Eiwj@rowland.harvard.edu>
 <a57f4af7-3fbc-0853-dd9c-b80b2425b4f5@suse.com>
In-Reply-To: <a57f4af7-3fbc-0853-dd9c-b80b2425b4f5@suse.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 5 Jun 2022 22:45:10 +0900
Message-ID: <CAMZ6Rq+6z-Nz=Nao2u_=LOC5QYF6KBjy-HdK1x41O4zo1c8HHg@mail.gmail.com>
Subject: Re: [RFC PATCH] USB: core: urb: add new transfer flag URB_FREE_COHERENT
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-can <linux-can@vger.kernel.org>, linux-usb@vger.kernel.org
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

On Sun. 5 Jun. 2022 at 15:00, Oliver Neukum <oneukum@suse.com> wrote:
> On 04.06.22 18:40, Alan Stern wrote:
> >
> > I don't see anything wrong with this, except that it would be nice to keep
> > the flag values in numerical order.  In other words, set URB_FREE_COHERENT
> > to 0x0200 and change URB_DIR_IN to 0x0400.
> Hi,
>
> but what sense does this patch make? You use coherent allocations
> to avoid repeated DMA synchronizations. That is sort of incompatible
> with the notion of discarding the buffer automatically.

This is how I see things:
  * In the open() function, the driver will do the coherent allocation
for its transfer_buffers, fill those into URBs and add all the URBs in
an anchor.
  * During runtime, the driver will keep recycling the same URBs (no
need to kill URB nor to usb_free_coherent() the transfer_buffer).
  * Finally, in the close() function, the driver has to kill the URBs
and usb_free_coherent() the transfer_buffers. As far as I understand,
no helper functions allow us to do all that, thus requiring the driver
to iterate through the anchor to manually usb_free_coherent() the
transfer buffer.

So, the intent of this patch is to provide a method to both kill the
URBs and usb_free_coherent() the transfer buffer at once. The
rationale is that those two actions are done sequentially, at least in
the use case exposed above, and so the driver has enough control to
assert that usb_free_coherent() will occur at a good timing. For other
use cases where killing the URBs and freeing the transfer_buffer
should be done separately, the driver should not set URB_FREE_COHERENT
and continue to manually usb_free_coherent() the transfer_buffer.

Which part of this logic is incompatible with the coherent allocation?
Also, if the above is incorrect, what is the canonical way to kill the
URBs and free the transfer_buffers?

Thank you!


Yours sincerely,
Vincent Mailhol
