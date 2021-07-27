Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D780F3D702C
	for <lists+linux-can@lfdr.de>; Tue, 27 Jul 2021 09:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbhG0HSj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Jul 2021 03:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbhG0HSi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Jul 2021 03:18:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A6FC061757
        for <linux-can@vger.kernel.org>; Tue, 27 Jul 2021 00:18:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mt6so16534515pjb.1
        for <linux-can@vger.kernel.org>; Tue, 27 Jul 2021 00:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hpWdPZDAhy+s9NCI+jbWundi30gCKMjdrIsn3Fa6mps=;
        b=y7sCrsqFcCqb2dcA9cExBkz8Zwjx+r6dRcbA6Jaes6alD1RHLo3XyNTm/mfpOIf8+5
         fnRivvRGINDLPxoWntP7sIX7t+YvtPzD1sF76iIuqfJpY1muZ+iGl3fJ0o9dJtjAy45t
         C+dwB8OFCwbUPePKQrqtcyVU3EqdXtBdMd24nWhyQLC09OzGc8rRgQXV5g8GCZCsxp6O
         8+RaBxOTygWOJXuPnQZuvet3h9ELDBCAR6D3Zrw7uq2sTh7P2yL8PupVkAiFW/JlBgJ8
         m/DhXV3+qmhXZV0bIQ0JR9vYK+/sK8gIoCM9qD51xu6NTvCnHG2KdJa42jAndLvUyzOL
         3Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hpWdPZDAhy+s9NCI+jbWundi30gCKMjdrIsn3Fa6mps=;
        b=UBf+yeXc7mH6/ZD06tBG6PaKO6j6IbeYBuf14UN6aUeaNlfrbJ7k/+ZREaTj9D9JGD
         wDLFXMSgD2nYi1mkkS+VT/a+kdtXJIaIKAZFBaWpkI8lxP9quRkCnFxIE4A5CRMAgQP8
         MDSDb1vmHTNA9cz3Cum4nOcwtGZY5fGpqgY6A1J3bs4rPEJc8cvssrz9rkueRvjJGUHi
         hTDw0QGzUWOFHMpaHJm0qcAZVug4dwvzRLpsz5l8TjX2yS62GF5gJqoy502/kSzTubMo
         pySKbeM4It5nPQViGYIN41RsYVdnrqEXpTm5JOaYmliM6ZB1+tQT0o5sAwQPrO/Am6C5
         Qp7Q==
X-Gm-Message-State: AOAM530awt2NUBb9w3KMlz1gi9J7+YP6ncQ7BDhoHZuep8VsVLJH+Opt
        ssQ0J+5P2SVKtgtJV3eBSAur
X-Google-Smtp-Source: ABdhPJy/4ZhEi8kNamexxtcJn40Un4wgooQWLkbZg3QZK3R+nIiPKO+wzJkT2Ult6efpKVtZVX6lEw==
X-Received: by 2002:aa7:88d3:0:b029:32b:75d0:fa92 with SMTP id k19-20020aa788d30000b029032b75d0fa92mr21904856pff.23.1627370318370;
        Tue, 27 Jul 2021 00:18:38 -0700 (PDT)
Received: from thinkpad ([2409:4072:404:9e26:4427:70e5:216c:501f])
        by smtp.gmail.com with ESMTPSA id on9sm1561474pjb.47.2021.07.27.00.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 00:18:38 -0700 (PDT)
Date:   Tue, 27 Jul 2021 12:48:33 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>
Subject: Re: [PATCH] can: mcp251xfd: mcp251xfd_irq(): stop timestamping
 worker in case error in IRQ
Message-ID: <20210727071833.GB33931@thinkpad>
References: <20210724155131.471303-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724155131.471303-1-mkl@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, Jul 24, 2021 at 05:51:31PM +0200, Marc Kleine-Budde wrote:
> In case an error occurred in the IRQ handler, the chip status is
> dumped via devcoredump and all IRQs are disabled, but the chip stays
> powered for further analysis.
> 
> The chip is in an undefined state and will not receive any CAN frames,
> so shut down the timestamping worker, which reads the TBC register
> regularly, too. This avoids any CRC read error messages if there is a
> communication problem with the chip.
> 
> Fixes: efd8d98dfb90 ("can: mcp251xfd: add HW timestamp infrastructure")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index 47c3f408a799..9ae48072b6c6 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -2300,6 +2300,7 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
>  		   err, priv->regs_status.intf);
>  	mcp251xfd_dump(priv);
>  	mcp251xfd_chip_interrupts_disable(priv);
> +	mcp251xfd_timestamp_stop(priv);
>  
>  	return handled;
>  }
> -- 
> 2.30.2
> 
> 
