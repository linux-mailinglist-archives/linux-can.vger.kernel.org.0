Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0DD557E6F
	for <lists+linux-can@lfdr.de>; Thu, 23 Jun 2022 17:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiFWPGd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 Jun 2022 11:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiFWPGc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 Jun 2022 11:06:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C973120C
        for <linux-can@vger.kernel.org>; Thu, 23 Jun 2022 08:06:32 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so2851630pjl.5
        for <linux-can@vger.kernel.org>; Thu, 23 Jun 2022 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JUGHboUEtnPE9len480rKR90aLHcfphaOPLPpQuwfvo=;
        b=n/TUyGZyUUXQoBtIhqcGwJQL7pH834dPX3K4ZGKO6lEpQ77cZ9dVqOIeMaR1k4qMDb
         IYgGxfZR77wWjhLaL2SEPlYcTpnmDh6IjYlEVD7aVnEfAiXMfTVmWetWiry6w6ZmNx93
         DRNpZCEyB7WewI+fZDzAVEen3gvxBqaPzC21WvjiKJRUIAAtoYYTJ1C1n4Yybhu2iJJ/
         5Pq5t3OMZhbnwTIOUwEsK8t2ilwIH1GjxQUYhUXN8XvI8VPzk8BE78U0Xs1D3EplgcoJ
         eqLp7kmd69b4a58p+PmpK+QAxK5N6Es+CO2BrwN3+NV1/gN6vU40DEiEczlum7KfYpat
         FWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JUGHboUEtnPE9len480rKR90aLHcfphaOPLPpQuwfvo=;
        b=1LVOTcVPQLC2HZmWgbT1evyW97gPbjJxl/jvXz7wOxMKaopePFfzO4klERzGGQApz7
         BrUCiPfg0+KXlZtE4sm5vSrg4bLB6PVYgljmo0s2ccCQjxQZiNxuwhBAKA/TzKZOlwrU
         g6mCmIulbfIe5VnAVuooM1fBI/+wT7OetJfziV8mV0B9hWHPWtzDaVIBbFOBiPD7uZz9
         z/UAj3+CcIcriNS2xCxsNKzN5GemIDXqatv8ebP66+U3SAbR0V3bS/FMO3KIAnl6T70f
         kMAPI3WKDjA4g+/UuSG3iXRIbAxzEggrzkC6fT9eZfZFRrI2N3dtHPinZyk/gupNlvkC
         F7mw==
X-Gm-Message-State: AJIora8VhYemhcxeg+azZ/ihpA171EvuMLZ1BkXFQXkrk3SO1oxt5Okz
        h4AdG+dmwmQFuBUNpH4rTjL/
X-Google-Smtp-Source: AGRyM1sfPaKV+EGkxkmyqdBwHgQU82/nN0Rx1ixEUUI7YEQqON2Pn50ZID77mDhoX37qe8X9GmL9Lg==
X-Received: by 2002:a17:902:ce01:b0:16a:1a44:93e8 with SMTP id k1-20020a170902ce0100b0016a1a4493e8mr24769812plg.29.1655996791535;
        Thu, 23 Jun 2022 08:06:31 -0700 (PDT)
Received: from thinkpad ([220.158.158.149])
        by smtp.gmail.com with ESMTPSA id iz18-20020a170902ef9200b0016a275623c1sm8169232plb.219.2022.06.23.08.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 08:06:31 -0700 (PDT)
Date:   Thu, 23 Jun 2022 20:36:27 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: Re: [PATCH] can: mcp251xfd: mcp251xfd_stop(): add missing
 hrtimer_cancel()
Message-ID: <20220623150627.GC15542@thinkpad>
References: <20220620143942.891811-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220620143942.891811-1-mkl@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Jun 20, 2022 at 04:39:42PM +0200, Marc Kleine-Budde wrote:
> In commit 169d00a25658 ("can: mcp251xfd: add TX IRQ coalescing
> support") software based TX coalescing was added to the driver. The
> key idea is to keep the TX complete IRQ disabled for some time after
> processing it and re-enable later by a hrtimer. When bringing the
> interface down, this timer has to be stopped.
> 
> Add the missing hrtimer_cancel() of the tx_irq_time hrtimer to
> mcp251xfd_stop().
> 
> Fixes: 169d00a25658 ("can: mcp251xfd: add TX IRQ coalescing support")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index b21252390216..34b160024ce3 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -1650,6 +1650,7 @@ static int mcp251xfd_stop(struct net_device *ndev)
>  	netif_stop_queue(ndev);
>  	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
>  	hrtimer_cancel(&priv->rx_irq_timer);
> +	hrtimer_cancel(&priv->tx_irq_timer);
>  	mcp251xfd_chip_interrupts_disable(priv);
>  	free_irq(ndev->irq, priv);
>  	can_rx_offload_disable(&priv->offload);
> -- 
> 2.35.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
