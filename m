Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74C42A836F
	for <lists+linux-can@lfdr.de>; Thu,  5 Nov 2020 17:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgKEQYY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Nov 2020 11:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKEQYY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Nov 2020 11:24:24 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DE5C0613CF
        for <linux-can@vger.kernel.org>; Thu,  5 Nov 2020 08:24:24 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id z1so1004448plo.12
        for <linux-can@vger.kernel.org>; Thu, 05 Nov 2020 08:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=krYI39vfsdlqkTaW0MHc1NCwyRoyu4oq8aL23kCybPQ=;
        b=IbTZsnJadlg6WeiC+Xq7pA9TvAomrr+w+5KuKk+oZorPZYb6Wv6beYt2ay4vl66L7I
         7nVIaLQH2T050+5VwDaM6EN2NnJxovSEVuKPGSQRYrKNrbYtRWMdnr/01UINkhuTLhvj
         qmj4z+Q2xp/RpzsH4uzUQPBU8Ag9COWoVKr72eJFKWRcJ0zvi4IA6fCfbzVb7cYrO2dg
         BDhNCM75PKo+81ZvVfsB9F2PEaAYBpDYdHVENfJqKicutmgxKHHb0IP0SlnL8Yn3mxJl
         2xpA4AC7KzRFnI7KuiDa29qI6FBQM8MpjTqBKNJuiBRQC3FAcDgEuf2StGk2bUfsuKpX
         DC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=krYI39vfsdlqkTaW0MHc1NCwyRoyu4oq8aL23kCybPQ=;
        b=ctbboisrS/cvtJpiKnwSgq2K3hVKvmykbzSlct6IO0GEBzk+4rloaqPDUtDVlWARve
         qnt6wTM7ophwurvxU9Sf16bEaVBIGMj6XoVoNSgjsvkYOmEGhh4VvuJ1jA9BYVyBa+4Z
         +aVYdmBOi8i7jgmrbOlXbKlxFQFy6fWpJuOGBaoaJji3rHQp1KgM7zuu4Y9Kd78P8e60
         Q5weBKNlDq+/cY0WO7G2AiDQcSUig94T8p1ELkUMmmO8FrInFdKiT8lAavULFRxPJmfX
         k086L8s0BcYM8ytdepz7PMy/MDEhuekDAHngB43tzext8kAVO3KJYqI7mS43HLifgyNZ
         KqDQ==
X-Gm-Message-State: AOAM531wkCG4XpKnLZocTnTOsJ9U7BznS8f22702q2gwK9DTX0e3YdSv
        +zPwp+QfoaCcn/XyRxBBd7vQ
X-Google-Smtp-Source: ABdhPJwO5/jn6anjiziy9ZVy8X8lHSDb9ENcHZbXXaOEB2uL0G1lRMJbufhprs/+3VzsgLijOBK0oA==
X-Received: by 2002:a17:902:6b03:b029:d6:f20a:83dd with SMTP id o3-20020a1709026b03b02900d6f20a83ddmr3190330plk.47.1604593463561;
        Thu, 05 Nov 2020 08:24:23 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id b3sm3035023pfd.66.2020.11.05.08.24.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 08:24:22 -0800 (PST)
Date:   Thu, 5 Nov 2020 21:54:17 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: Re: [net 21/27] can: mcp251xfd: mcp251xfd_regmap_crc_read():
 increase severity of CRC read error messages
Message-ID: <20201105162417.GH7308@work>
References: <20201103220636.972106-1-mkl@pengutronix.de>
 <20201103220636.972106-22-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103220636.972106-22-mkl@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Tue, Nov 03, 2020 at 11:06:30PM +0100, Marc Kleine-Budde wrote:
> During debugging it turned out that some people have setups where the SPI
> communication is more prone to CRC errors.
> 
> Increase the severity of both the transfer retry and transfer failure message
> to give users feedback without the need to recompile the driver with debug
> enabled.
> 
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Thomas Kopp <thomas.kopp@microchip.com>
> Link: http://lore.kernel.org/r/20201019190524.1285319-15-mkl@pengutronix.de
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
> index ba25902dd78c..c9ffc5ea2b25 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
> @@ -330,17 +330,17 @@ mcp251xfd_regmap_crc_read(void *context,
>  			goto out;
>  		}
>  
> -		netdev_dbg(priv->ndev,
> -			   "CRC read error at address 0x%04x (length=%zd, data=%*ph, CRC=0x%04x) retrying.\n",
> -			   reg, val_len, (int)val_len, buf_rx->data,
> -			   get_unaligned_be16(buf_rx->data + val_len));
> -	}
> -
> -	if (err) {
>  		netdev_info(priv->ndev,
> -			    "CRC read error at address 0x%04x (length=%zd, data=%*ph, CRC=0x%04x).\n",
> +			    "CRC read error at address 0x%04x (length=%zd, data=%*ph, CRC=0x%04x) retrying.\n",
>  			    reg, val_len, (int)val_len, buf_rx->data,
>  			    get_unaligned_be16(buf_rx->data + val_len));

I'm not finding this inner debug log useful. Does the user really care
about the iterations it took to read a register? Just throwing the error
after max try seems better to me.

Thanks,
Mani

> +	}
> +
> +	if (err) {
> +		netdev_err(priv->ndev,
> +			   "CRC read error at address 0x%04x (length=%zd, data=%*ph, CRC=0x%04x).\n",
> +			   reg, val_len, (int)val_len, buf_rx->data,
> +			   get_unaligned_be16(buf_rx->data + val_len));
>  
>  		return err;
>  	}
> -- 
> 2.28.0
> 
