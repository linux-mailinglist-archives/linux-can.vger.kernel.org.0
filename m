Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F921557E68
	for <lists+linux-can@lfdr.de>; Thu, 23 Jun 2022 17:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiFWPDG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 Jun 2022 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiFWPDF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 Jun 2022 11:03:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA63B852
        for <linux-can@vger.kernel.org>; Thu, 23 Jun 2022 08:03:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w24so10746869pjg.5
        for <linux-can@vger.kernel.org>; Thu, 23 Jun 2022 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jb0TECMeJEyD3LbffzKp4rPCQPjjsSrNiIBcD6Hy6O4=;
        b=y45KeMTtVlGZjnWXnjf3G6h6Jng46GBFFcLlqHnqXshzXfbus3kOUL8lnTc+j/NqZB
         EMZzX5L+Ei6ihVb29tBYv1loOtPFxW3q76Be3a9xLkHd2x2hFo0iG3VQQiyXxyOtUM++
         4s4yjKbG9QfWTe2DYZK3aAAOvqeCsB5eMlwYtm8/KgklEOELx6kesOP/yS98Nudu9OB6
         4y6bY55Epk7bNdCDuLRUCBF8AdfhRzb5iFJoKTVXnkq75AR2GpW/hpv+Nx1nh0EMVync
         FSYaA2dykyCEvpNLctJxpkbWw7UwS5a93UVE9XHiZkw2Me1KSTL63CVKh3LicK6YZ5II
         bjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jb0TECMeJEyD3LbffzKp4rPCQPjjsSrNiIBcD6Hy6O4=;
        b=bCh5xu3Gjr/WkYbfZ/jlPdrPNE5nsLXTZsCXwn8ltXtTPci0c6bzvL3IMdN3PMiopr
         C8dLlI3P3E3QwBEB/EopZNvW6SiPWrRMT9fyH8Ye2QaY7KC3jYZztc5Sfa3QrUZElcR6
         jPx2tyx4fh0pOfAGbyG9iwWTgOxuI9+DninsxyF0Et/TZm2fP+aaXJ2rp+4nVhYxFGMQ
         CPLbC5W8XOEXfzrblPwF3zbh0Ia46LTdSYgf+SqYT9EXKUGdnVYklFslpxceZtuSXKJl
         D+cd699ip5JDwgK0zw4RE8alrAN8/jrjqXY4rR7lNVlcRWZha4BKyiE3DPQOqlL6U5PE
         Khpw==
X-Gm-Message-State: AJIora93eC706H6wsjCYf0hdGmOGnRnrdUEGPXNa+VjENpEjwUACib8w
        im7VDYsFUWx3fV6Z33QEnXbIB3Gnc3h0
X-Google-Smtp-Source: AGRyM1u2RgC1yLESGXpNNzrC4KSsQMfGR+u66gcVMReR+y07QGvdOKrATMQLcobWAaUi++OTZd4ryQ==
X-Received: by 2002:a17:90b:38c2:b0:1e8:7ad1:bec5 with SMTP id nn2-20020a17090b38c200b001e87ad1bec5mr4370042pjb.51.1655996584511;
        Thu, 23 Jun 2022 08:03:04 -0700 (PDT)
Received: from thinkpad ([220.158.158.149])
        by smtp.gmail.com with ESMTPSA id y18-20020a62b512000000b0051e7b6e8b12sm9854853pfe.11.2022.06.23.08.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 08:03:03 -0700 (PDT)
Date:   Thu, 23 Jun 2022 20:32:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] can: mcp251xfd: mcp251xfd_register_get_dev_id(): fix
 endianness conversion
Message-ID: <20220623150259.GB15542@thinkpad>
References: <20220620144954.895582-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220620144954.895582-1-mkl@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Jun 20, 2022 at 04:49:54PM +0200, Marc Kleine-Budde wrote:
> In mcp251xfd_register_get_dev_id() the device ID register is read with
> handcrafted SPI transfers. As all registers, this register is in
> little endian, too. However after the transfer the register content is
> converted from big endian to CPU endianness.
> 
> Fix the conversion by converting from little endian to CPU endianness.
> 
> Side note: So far the register content is 0x0 on all mcp251xfd
> compatible chips, and is only used for an informative printk.
> 
> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index 3160881e89d9..d7f406dbe2ce 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -1787,7 +1787,7 @@ mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv, u32 *dev_id,
>  	if (err)
>  		goto out_kfree_buf_tx;
>  
> -	*dev_id = be32_to_cpup((__be32 *)buf_rx->data);
> +	*dev_id = le32_to_cpup((__le32 *)buf_rx->data);
>  	*effective_speed_hz_slow = xfer[0].effective_speed_hz;
>  	*effective_speed_hz_fast = xfer[1].effective_speed_hz;
>  
> -- 
> 2.35.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
