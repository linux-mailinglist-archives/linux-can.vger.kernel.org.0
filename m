Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7222753D4CF
	for <lists+linux-can@lfdr.de>; Sat,  4 Jun 2022 04:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349987AbiFDCMl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 3 Jun 2022 22:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348625AbiFDCMl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Jun 2022 22:12:41 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E814036E38;
        Fri,  3 Jun 2022 19:12:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id h1so7973729plf.11;
        Fri, 03 Jun 2022 19:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W4St/F4CTvqxuMtRF4L13yrP2FI+M/ORmtQh78TiIRU=;
        b=G8YfO1FqgnjM20P+1jptrNj1+C/m4ku53Qd6UCxTE0twhThSwLHRDOhC6mRDz/EDCB
         5P4B2jLUZNMMfgBvj8fYqfbVqEEe6uu4PJparK4C0sPKA7A7OXd1tLYXbtMs7BqXMvbe
         Uif4JFn3Yo0pnwYl+9fjr3Qxk6HzE5GRU1v7DVtofcqsh2MLw+wJxHiILhAXTG1EPgi2
         XeCGWqwqA7WdDG/m+WlRPfizXYr+qCdTdNrdwxqK0lueU4cvCM7qsn4rCESDsyEm+3S6
         zgK7pJCrRAE7TAPAiA48KVKAVPDXcYzfqxqW4ZsqOjcIrrbeGE6p+FnjM40fqSTasYf9
         zk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=W4St/F4CTvqxuMtRF4L13yrP2FI+M/ORmtQh78TiIRU=;
        b=GD3ewX/xpdXKpLkPm953Yd1h/vd8hz3KK+52hdpNmqFj09YEDQphwMVfuFhLpJA63u
         ROhzN62Ax2MtqBWYxAAjK2aZEW0T3Ce4U9vNm96Md+t+qbirPxEMqy61STJCcnS0yyRI
         3td8jf369LqqAm/jispck4wA8gACSVWCfoaPXRaq6co9mA+1VJnon+p8NE2wY4BKhjox
         oBJQK7KMQTm4pB3R9kTI0w5T65R5QOe24dL3TVAgpRiHxc/4lCIdU6V3pNoQXkJHEAjV
         +hBy7sqmXUkO1XSZObwSKTRM1iwDGGH3RgFIrKT1n4OzAnOEogT4GpbDzFLWiKLoRERf
         VYxg==
X-Gm-Message-State: AOAM530wn0PViYLQcx0AKTY+F0AbY33qIPoTVUH5VdY7h3Pj3BKADQE9
        K6K0b4YOYw39aIuj+72VYN4=
X-Google-Smtp-Source: ABdhPJws4RZq2V+vrAuPzoIS2DTabQAjru9avwA9pJiuOQyAlpUB7UFd0wXCTc7SA/TplVlkkHMr+g==
X-Received: by 2002:a17:902:d2c7:b0:162:4f0a:c790 with SMTP id n7-20020a170902d2c700b001624f0ac790mr4540624plc.110.1654308758085;
        Fri, 03 Jun 2022 19:12:38 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id gb23-20020a17090b061700b001d95c09f877sm5819278pjb.35.2022.06.03.19.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 19:12:37 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Rhett Aultman <rhett.aultman@samsara.com>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>, wg@grandegger.com,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-can@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] can: gs_usb: gs_usb_open/close( ) fix memory leak
Date:   Sat,  4 Jun 2022 11:11:45 +0900
Message-Id: <20220604021145.55484-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <alpine.DEB.2.22.394.2206031547001.1630869@thelappy>
References: <alpine.DEB.2.22.394.2206031547001.1630869@thelappy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

+CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+CC: linux-usb@vger.kernel.org

Rhett Aultman <rhett.aultman@samsara.com> writes:
> The gs_usb driver appears to suffer from a malady common to many USB CAN
> adapter drivers in that it performs usb_alloc_coherent( ) to allocate a
> number of USB request blocks (URBs) for RX, and then later relies on
> usb_kill_anchored_urbs( ) to free them, but this doesn't actually free
> them.  As a result, this may be leaking DMA memory that's been used by the
> driver.
>
> This commit is an adaptation of the techniques found in the esd_usb2 driver
> where a similar design pattern led to a memory leak.  It explicitly frees
> the RX URBs and their DMA memory via a call to usb_free_coherent( ).  Since
> the RX URBs were allocated in the gs_can_open( ), we remove them in
> gs_can_close( ) rather than in the disconnect function as was done in
> esd_usb2.

Right. To be frank, I think that there is a gap in the current URB
interface. If you do a simple kmalloc(), you can just set
URB_FREE_BUFFER in urb::transfer_flags. usb_kill_anchored_urbs() would
then eventually call urb_destroy() and automatically free it for you.

As far as I understand, I am not aware of equivalent mechanism to
automatically call usb_free_coherent() in the case that the driver
uses DMA memory. And I think that this is the root cause of this
"malady".

For me, the natural fix would be:

diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 33d62d7e3929..1460fdac0b18 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -22,6 +22,9 @@ static void urb_destroy(struct kref *kref)
 
        if (urb->transfer_flags & URB_FREE_BUFFER)
                kfree(urb->transfer_buffer);
+       else if (urb->transfer_flags & URB_FREE_COHERENT)
+               usb_free_coherent(urb->dev, urb->transfer_buffer_length,
+                                 urb->transfer_buffer, urb->transfer_dma);
 
        kfree(urb);
 }
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 200b7b79acb5..dfc348d56fed 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1328,6 +1328,7 @@ extern int usb_disabled(void);
 #define URB_NO_INTERRUPT       0x0080  /* HINT: no non-error interrupt
                                         * needed */
 #define URB_FREE_BUFFER                0x0100  /* Free transfer buffer with the URB */
+#define URB_FREE_COHERENT      0x0200  /* Free DMA memory of transfer buffer */
 
 /* The following flags are used internally by usbcore and HCDs */
 #define URB_DIR_IN             0x0200  /* Transfer from device to host */
---

After doing this, drivers only have to add the URB_FREE_COHERENT flag
and voila!

Reusing URB_NO_TRANSFER_DMA_MAP to force a call to usb_free_coherent()
would be a bad idea because it would result in a double free for all
the drivers which correctly free their DMA memory. This is why above
snippet introduces a new URB_FREE_COHERENT flag.

Maybe I missed something obvious, but if so, I would like to
understand what is wrong in above approach.

> 
> For more information, see the following:
> * https://www.spinics.net/lists/linux-can/msg08203.html
> * https://github.com/torvalds/linux
>     928150fad41 (can: esd_usb2: fix memory leak)
> 
> From: Rhett Aultman <rhett.aultman@samsara.com>

Nitpick: the From tag is redundant. You already have it in the e-mail
header. It is relevant to explicitly add the From tag when picking
someone's else patch, but if the author and the signer are the same,
you are good to go without.

> Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
> ---
>  drivers/net/can/usb/gs_usb.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index b29ba9138866..d3a658b444b5 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -268,6 +268,8 @@ struct gs_can {
> 
>  	struct usb_anchor tx_submitted;
>  	atomic_t active_tx_urbs;
> +	void *rxbuf[GS_MAX_RX_URBS];
> +	dma_addr_t rxbuf_dma[GS_MAX_RX_URBS];

I do not like how the driver has to keep in a local array a reference
to all DMA allocated memory. All this information is redundant because
already present in the URB. So I really hope that we can fix it on the
URB API side and remove such complexity on the driver side.

>  };
> 
>  /* usb interface struct */
> @@ -742,6 +744,7 @@ static int gs_can_open(struct net_device *netdev)
>  		for (i = 0; i < GS_MAX_RX_URBS; i++) {
>  			struct urb *urb;
>  			u8 *buf;
> +			dma_addr_t buf_dma;
> 
>  			/* alloc rx urb */
>  			urb = usb_alloc_urb(0, GFP_KERNEL);
> @@ -752,7 +755,7 @@ static int gs_can_open(struct net_device *netdev)
>  			buf = usb_alloc_coherent(dev->udev,
>  						 dev->parent->hf_size_rx,
>  						 GFP_KERNEL,
> -						 &urb->transfer_dma);
> +						 &buf_dma);
>  			if (!buf) {
>  				netdev_err(netdev,
>  					   "No memory left for USB buffer\n");
> @@ -760,6 +763,8 @@ static int gs_can_open(struct net_device *netdev)
>  				return -ENOMEM;
>  			}
> 
> +			urb->transfer_dma = buf_dma;
> +
>  			/* fill, anchor, and submit rx urb */
>  			usb_fill_bulk_urb(urb,
>  					  dev->udev,
> @@ -781,10 +786,17 @@ static int gs_can_open(struct net_device *netdev)
>  					   "usb_submit failed (err=%d)\n", rc);
> 
>  				usb_unanchor_urb(urb);
> +				usb_free_coherent(dev->udev,
> +						  sizeof(struct gs_host_frame),
> +						  buf,
> +						  buf_dma);
>  				usb_free_urb(urb);
>  				break;
>  			}
> 
> +			dev->rxbuf[i] = buf;
> +			dev->rxbuf_dma[i] = buf_dma;
> +
>  			/* Drop reference,
>  			 * USB core will take care of freeing it
>  			 */
> @@ -842,13 +854,20 @@ static int gs_can_close(struct net_device *netdev)
>  	int rc;
>  	struct gs_can *dev = netdev_priv(netdev);
>  	struct gs_usb *parent = dev->parent;
> +	unsigned int i;
> 
>  	netif_stop_queue(netdev);
> 
>  	/* Stop polling */
>  	parent->active_channels--;
> -	if (!parent->active_channels)
> +	if (!parent->active_channels) {
>  		usb_kill_anchored_urbs(&parent->rx_submitted);
> +		for (i = 0; i < GS_MAX_RX_URBS; i++)
> +			usb_free_coherent(dev->udev,
> +					  sizeof(struct gs_host_frame),
> +					  dev->rxbuf[i],
> +					  dev->rxbuf_dma[i]);
> +	}
> 
>  	/* Stop sending URBs */
>  	usb_kill_anchored_urbs(&dev->tx_submitted);
> -- 
> 2.30.2
> 
