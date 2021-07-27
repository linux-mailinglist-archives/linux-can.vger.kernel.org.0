Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F673D7028
	for <lists+linux-can@lfdr.de>; Tue, 27 Jul 2021 09:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbhG0HRZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Jul 2021 03:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbhG0HRW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Jul 2021 03:17:22 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2517C061757
        for <linux-can@vger.kernel.org>; Tue, 27 Jul 2021 00:17:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m1so16519562pjv.2
        for <linux-can@vger.kernel.org>; Tue, 27 Jul 2021 00:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YMBM8IxbE+UvcuBd4KuNokODNxj//SeMtYWHKI5blJ8=;
        b=KET0jPWLgY7IBZ+1CD6W1C47dM6MUrWMK44Z334TARUjI4Enb8vzBHm9Iykh6nYwF1
         VNtU8XP1WgsRN93cGuSBUAmfKwmWZm+/euk42+/ovv3sG1fpLXfQK6uKzwYG9eiQRTtR
         r4jQQvpi9O+a23/bgNNb93tRcNcwSgkR1sxgZaKhLqjNeD4I1qTnhsyG8s95a8TMPU3z
         kKhaCSgxtRmKiVtNzyHbN067cQhwI4n7pGMAP3ULl3iHg1jmUcsY6M1fyimfJME1TnQt
         5yWBGguhUMSwH+62mF51EIw5FcVHI/LlpI+JTL6vwubXpcd9jEwjJ2hIdqdc45BR9mOz
         PB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YMBM8IxbE+UvcuBd4KuNokODNxj//SeMtYWHKI5blJ8=;
        b=FnM7hSiAWYhX1DomUUvL0/bVyQklOJ7dU4uGuG3tEfM5K9iB1PcWyzJtX1d7YjJMcK
         plxODPa73MiTGNbWO1ooEXfWedPUTLm7uXwEFpMRDqMNrzONi3ypPFU2CY3Da1YzP8cN
         6Pgp84aOI5L7tHt0JzR5/yIU2GlTQHQrV4NMD0i9dygUSZcL3VU0ERV0MhfpspynkwQq
         jzbght3V3A4RcOT5XxqQianSIywf3S7UjFn0fok7aJkiryetBChgXelB/tclzcAFzRNy
         kRVgHgnjq7VO1iG7hFNx6Qu/eITbnxfr5AWxopk4ZRBpUNHJgRl10ia3Bu7fgmMW2fSe
         exsw==
X-Gm-Message-State: AOAM532+WvZ/584Rm+X+OkXL2/Lb9fwV4t2bczJWBh1r41kT2h8F4L09
        uDnzF0hMS1x2gFdmHzWaPFE5
X-Google-Smtp-Source: ABdhPJxQO+xiQPGN/rrP0hZUC+NcR0eTvqjJZ5hkIzJ/EHVWNczf97XcD1k2UbAO+LSg4//g0MJV0w==
X-Received: by 2002:aa7:9af7:0:b029:32b:34a7:2e73 with SMTP id y23-20020aa79af70000b029032b34a72e73mr21901065pfp.62.1627370242030;
        Tue, 27 Jul 2021 00:17:22 -0700 (PDT)
Received: from thinkpad ([2409:4072:404:9e26:4427:70e5:216c:501f])
        by smtp.gmail.com with ESMTPSA id y139sm2343288pfb.107.2021.07.27.00.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 00:17:21 -0700 (PDT)
Date:   Tue, 27 Jul 2021 12:47:17 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>
Subject: Re: [PATCH] can: mcp251xfd: mcp251xfd_open(): request IRQ as shared
Message-ID: <20210727071717.GA33931@thinkpad>
References: <20210724205212.737328-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724205212.737328-1-mkl@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, Jul 24, 2021 at 10:52:13PM +0200, Marc Kleine-Budde wrote:
> The driver's IRQ handler supports shared IRQs, so request a shared IRQ
> handler.
> 

I don't see any issue with the idea but I'd like to understand the requirement
for it. Usually the IRQ lines are shared when multiple devices use them
physically. For instance, a MFD device using a single GPIO for all of its
functions. But I don't see any sort of requirement like that here.

Making the IRQ lines shared will only induce latency IMO.

Thanks,
Mani

> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index 90b06052549d..2b1e57552e1c 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -2527,8 +2527,8 @@ static int mcp251xfd_open(struct net_device *ndev)
>  	can_rx_offload_enable(&priv->offload);
>  
>  	err = request_threaded_irq(spi->irq, NULL, mcp251xfd_irq,
> -				   IRQF_ONESHOT, dev_name(&spi->dev),
> -				   priv);
> +				   IRQF_SHARED | IRQF_ONESHOT,
> +				   dev_name(&spi->dev), priv);
>  	if (err)
>  		goto out_can_rx_offload_disable;
>  
> -- 
> 2.30.2
> 
> 
