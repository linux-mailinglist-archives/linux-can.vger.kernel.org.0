Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7035253D7E7
	for <lists+linux-can@lfdr.de>; Sat,  4 Jun 2022 18:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbiFDQlD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 4 Jun 2022 12:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiFDQlA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 4 Jun 2022 12:41:00 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 27BAD4F9EC
        for <linux-can@vger.kernel.org>; Sat,  4 Jun 2022 09:40:59 -0700 (PDT)
Received: (qmail 329683 invoked by uid 1000); 4 Jun 2022 12:40:58 -0400
Date:   Sat, 4 Jun 2022 12:40:58 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Rhett Aultman <rhett.aultman@samsara.com>, wg@grandegger.com,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-can@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH] USB: core: urb: add new transfer flag
 URB_FREE_COHERENT
Message-ID: <YpuLGkPcXrM+Eiwj@rowland.harvard.edu>
References: <alpine.DEB.2.22.394.2206041003320.1657582@thelappy>
 <20220604144157.208849-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604144157.208849-1-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, Jun 04, 2022 at 11:41:57PM +0900, Vincent Mailhol wrote:
> When allocating URB memory with kmalloc(), drivers can simply set the
> URB_FREE_BUFFER flag in urb::transfer_flags and that way, the memory
> will be freed in the background when calling killing the URB (for
> example with usb_kill_anchored_urbs()).
> 
> However, there are no equivalent mechanism when allocating DMA memory
> (with usb_alloc_coherent()).
> 
> This patch adds a new flag: URB_FREE_COHERENT. Setting this flag will
> cause the kernel to automatically call usb_free_coherent() when the
> URB is killed, similarly to how URB_FREE_BUFFER triggers a call to
> kfree().
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> Hi Rhett Aultman,
> 
> I put the code snippet I previously sent into a patch. It is not
> tested (this is why I post it as RFC). Please feel free to add this to
> your series.
> ---
>  drivers/usb/core/urb.c | 3 +++
>  include/linux/usb.h    | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> index 33d62d7e3929..1460fdac0b18 100644
> --- a/drivers/usb/core/urb.c
> +++ b/drivers/usb/core/urb.c
> @@ -22,6 +22,9 @@ static void urb_destroy(struct kref *kref)
>  
>  	if (urb->transfer_flags & URB_FREE_BUFFER)
>  		kfree(urb->transfer_buffer);
> +	else if (urb->transfer_flags & URB_FREE_COHERENT)
> +		usb_free_coherent(urb->dev, urb->transfer_buffer_length,
> +				  urb->transfer_buffer, urb->transfer_dma);
>  
>  	kfree(urb);
>  }
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 60bee864d897..2200b3785fdb 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -1328,6 +1328,7 @@ extern int usb_disabled(void);
>  #define URB_NO_INTERRUPT	0x0080	/* HINT: no non-error interrupt
>  					 * needed */
>  #define URB_FREE_BUFFER		0x0100	/* Free transfer buffer with the URB */
> +#define URB_FREE_COHERENT	0x0400  /* Free DMA memory of transfer buffer */
>  
>  /* The following flags are used internally by usbcore and HCDs */
>  #define URB_DIR_IN		0x0200	/* Transfer from device to host */

I don't see anything wrong with this, except that it would be nice to keep 
the flag values in numerical order.  In other words, set URB_FREE_COHERENT 
to 0x0200 and change URB_DIR_IN to 0x0400.

Alan Stern
