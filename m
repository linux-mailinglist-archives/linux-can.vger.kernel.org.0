Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4AA54591B
	for <lists+linux-can@lfdr.de>; Fri, 10 Jun 2022 02:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiFJATF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Thu, 9 Jun 2022 20:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiFJATF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Jun 2022 20:19:05 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3883A3A1B8;
        Thu,  9 Jun 2022 17:19:03 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id v140so90512ybe.9;
        Thu, 09 Jun 2022 17:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zg7KF7YY9aGXptQ4LOLr5Rqt1X0ZoRkoJOPR7f51zj4=;
        b=A/u0L0lMW3IuAzue2l8k118kzkC2tmFq3vWTAt37VJZ/fRYmJ8It9KiWfIKiZyFkLg
         RAPuYNVkZ64kCR58LvmOg9zNHHP2eyxQSDP7799U0vopYllQkM+wytmW5y4H+u2ngpAV
         5qaIGiB/HH0Tv5QXQiNEzi0gbMwC+8W5PELKnxoF1AJYj54Y4tvdUq5bswD28ApT9mEt
         7js87F4DSBT+oxvJKThjE2HoavfRE3ZK2aM6RkxwmtY8avSdmvQWKNvqapZzg6q7f4TN
         xMD02qvZdSWz/QTZK9mTpKAx0kEyonMcS0+1elB3MksF1UNYoqF7K2qnJDfrXTqm8Ijc
         5j4g==
X-Gm-Message-State: AOAM531H0QTEjxcNfC9Hq/Te2UQya+d3Vf/+BomZLnWW0ZxQYyEIgym6
        gHOXdNkzamX6L9S0N2TVY8TG69BeAu0SkNEIABg=
X-Google-Smtp-Source: ABdhPJwAeF77dS1PB55jgGhw11yt/sLQqem2eBt7B8BKJlSeeIBytfEbV1/+5yLuseXDgvwFRif11AOEIQ45AJXtFNE=
X-Received: by 2002:a25:67d7:0:b0:663:b9c3:aa13 with SMTP id
 b206-20020a2567d7000000b00663b9c3aa13mr18864371ybc.20.1654820342456; Thu, 09
 Jun 2022 17:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2206031547001.1630869@thelappy>
 <20220609204714.2715188-1-rhett.aultman@samsara.com> <20220609204714.2715188-2-rhett.aultman@samsara.com>
In-Reply-To: <20220609204714.2715188-2-rhett.aultman@samsara.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 10 Jun 2022 09:18:51 +0900
Message-ID: <CAMZ6Rq+rEoOmy5PQ=oiaohcc=H5GFbZMfECACwe_qjEQXwuxuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drivers: usb/core/urb: Add URB_FREE_COHERENT
To:     Rhett Aultman <rhett.aultman@samsara.com>
Cc:     linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.org>,
        Alan Stern <stern@roland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 10 juin 2022 à 06:11, Rhett Aultman <rhett.aultman@samsara.com> wrote:

The From tag goes at the beginning of the patch.

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> When allocating URB memory with kmalloc(), drivers can simply set the
> URB_FREE_BUFFER flag in urb::transfer_flags and that way, the memory
> will be freed in the background when killing the URB (for example with
> usb_kill_anchored_urbs()).
>
> However, there are no equivalent mechanism when allocating DMA memory
> (with usb_alloc_coherent()).
>
> This patch adds a new flag: URB_FREE_COHERENT. Setting this flag will
> cause the kernel to automatically call usb_free_coherent() on the
> transfer buffer when the URB is killed, similarly to how
> URB_FREE_BUFFER triggers a call to kfree().
>
> In order to have all the flags in numerical order, URB_DIR_IN is
> renumbered from 0x0200 to 0x0400 so that URB_FREE_COHERENT can reuse
> value 0x0200.
>
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Move the From tag from here to the first line.

> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/usb/core/urb.c | 3 +++
>  include/linux/usb.h    | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
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
> index 60bee864d897..945d68ea1d76 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -1328,9 +1328,10 @@ extern int usb_disabled(void);
>  #define URB_NO_INTERRUPT       0x0080  /* HINT: no non-error interrupt
>                                          * needed */
>  #define URB_FREE_BUFFER                0x0100  /* Free transfer buffer with the URB */
> +#define URB_FREE_COHERENT      0x0200  /* Free DMA memory of transfer buffer */
>
>  /* The following flags are used internally by usbcore and HCDs */
> -#define URB_DIR_IN             0x0200  /* Transfer from device to host */
> +#define URB_DIR_IN             0x0400  /* Transfer from device to host */
>  #define URB_DIR_OUT            0
>  #define URB_DIR_MASK           URB_DIR_IN
