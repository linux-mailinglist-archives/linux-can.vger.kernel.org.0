Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFD35593F7
	for <lists+linux-can@lfdr.de>; Fri, 24 Jun 2022 09:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiFXHLl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 24 Jun 2022 03:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXHLk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Jun 2022 03:11:40 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F27163631
        for <linux-can@vger.kernel.org>; Fri, 24 Jun 2022 00:11:39 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g186so1629865pgc.1
        for <linux-can@vger.kernel.org>; Fri, 24 Jun 2022 00:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GN+qNt8Cw83f9WM+EZsvc9AedDf1YkE7NlHHQ95uLcg=;
        b=ZEe4hmibLxokNHF+BLv0iaiMAluCoPLanZmvFCppcyJTMa7gIHPFEyUS1MB1nrETCc
         AEDJRFU6g7ZnhHR4YCV9r18A1yhT1gOW2/2IkONUeeeG/a6CCzdx0RQbgWXmD/OMF8Ws
         YSuNnopDHTXHR8e0oOxroiNAOtQ+WH/aPbFzuCQtISbzYJQ4b4Rpq1Ku6jDJ5m8g5Kzz
         bnNSQ0suC18aSl5o1+Jcl3K3VSRIr6mucSYEaISBi36eZr5L3tLO3Wi2yZDIntv0642M
         EWdE8EkHFGW52GhQ55EX886lqS9ZDHSqHJ77MyvkobO7UlaUYP9WvUAwlAIhAcngJVxc
         Y80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GN+qNt8Cw83f9WM+EZsvc9AedDf1YkE7NlHHQ95uLcg=;
        b=ufOsdI14WCyq7LgkvY0+9K9OGn2mg/TtXw982xajn5h/0/Bjluvufk66Pw50Ley2rC
         mkxGacrxAvqEhlaFtz6Snti9NhYtP4sS1VWCM4wSj4hskdp7i4/+crPh8ysF/UMgwL+z
         muzy7e5xziuGQcU8SOcXPQ9ztRmhCq+R9iPcmHm+pHH3fDrnWhOlz9enzTnBqk2I4f4y
         +zfU701tPRq/bij6RDxPjy2UJgLOD8DQVOEDhCa7Fh5xt96WlUvbm/KqDCHGTSqmPWIA
         gmH/HiLVyIwLgIFdfbR/5IzXofjp6CqTRJXdhTt38XVEJ9UIwUqX/Oo/PCHPJa+QVdbF
         oNPA==
X-Gm-Message-State: AJIora/98pZIxIfB8xV6w0JIQusUMT48T96BATwvOQJq77/rF87nMcqn
        2mqJhfFWeKlWh+RXCcOPOuQl
X-Google-Smtp-Source: AGRyM1u/gNiENA3t+nbnVjc6sbLb6II6uT478GqWAIfvVmlKCAY2eOh1ECiV1ZJQqh3w4zfOHGwJxA==
X-Received: by 2002:a63:f256:0:b0:40d:5509:2126 with SMTP id d22-20020a63f256000000b0040d55092126mr5288029pgk.566.1656054698888;
        Fri, 24 Jun 2022 00:11:38 -0700 (PDT)
Received: from thinkpad ([220.158.158.183])
        by smtp.gmail.com with ESMTPSA id e30-20020a17090a6fa100b001eafa265869sm3155007pjk.56.2022.06.24.00.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 00:11:38 -0700 (PDT)
Date:   Fri, 24 Jun 2022 12:41:30 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: Re: [PATCH] can: mcp251xfd: mcp251xfd_register_get_dev_id(): use
 correct length to read dev_id
Message-ID: <20220624071130.GA11407@thinkpad>
References: <20220616094914.244440-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616094914.244440-1-mkl@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Jun 16, 2022 at 11:49:14AM +0200, Marc Kleine-Budde wrote:
> The device ID register is 32 bits wide. The driver uses incorrectly
> the size of a pointer to a u32 to calculate the length of the SPI
> transfer. This results in a read of 2 registers on 64 bit platforms.
> This is no problem on the Linux side, as the RX buffer of the SPI
> transfer is large enough. In the mpc251xfd chip this results in the
> read of an undocumented register. So far no problems were observed.
> 
> This patch fixes the length of the SPI transfer to read the device ID
> register only.
> 
> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index 34b160024ce3..3160881e89d9 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -1778,7 +1778,7 @@ mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv, u32 *dev_id,
>  	xfer[0].len = sizeof(buf_tx->cmd);
>  	xfer[0].speed_hz = priv->spi_max_speed_hz_slow;
>  	xfer[1].rx_buf = buf_rx->data;
> -	xfer[1].len = sizeof(dev_id);
> +	xfer[1].len = sizeof(*dev_id);
>  	xfer[1].speed_hz = priv->spi_max_speed_hz_fast;
>  
>  	mcp251xfd_spi_cmd_read_nocrc(&buf_tx->cmd, MCP251XFD_REG_DEVID);
> -- 
> 2.35.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
