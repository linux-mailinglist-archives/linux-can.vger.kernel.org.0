Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F50A29221D
	for <lists+linux-can@lfdr.de>; Mon, 19 Oct 2020 07:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgJSFXI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Oct 2020 01:23:08 -0400
Received: from mailrelay3-2.pub.mailoutpod1-cph3.one.com ([46.30.212.2]:52204
        "EHLO mailrelay3-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbgJSFXI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 01:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csselectronics.com; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:cc:references:to:subject:from;
        bh=h6gtpMv9CoFJcjm6fpXiVUMwMQZcVYnbfwIH7C4v0HI=;
        b=js9VoxQDGJYm1ibBMbzxYPwmhfqlFr5pRjqkWeeecms6+LUBNVSF2741nhTOIFhNHW8292y8t8tIE
         jBMnys63Ix5BSsU1SRFzsqBqBgIxulvDfTgxQWrKtEfOqJ5r2YKpwJwaNBOMrWHIaedVdwp2C5R+gT
         F5mkJWfor1EzYf1Dc8gkUDEUdj3/46emr5CjlFoLHWr/huyDwkjk5LHafWe4AAAQMwSyNjqb6gnTBU
         PIdXCAj6sS9XFcaBfp7vLhQzTO9XPKHCL2qCRjCUs7ku7xTqebispxbkqIFiEJtCCS5RFXpTTXO9k1
         iptcGXy2HcgbfLVH1oYYGuv7qw95HoA==
X-HalOne-Cookie: a54260026d79af28958dd5948e2809fb97922bc7
X-HalOne-ID: 29e77891-11cb-11eb-a804-d0431ea8bb03
Received: from [192.168.0.157] (unknown [5.103.118.41])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 29e77891-11cb-11eb-a804-d0431ea8bb03;
        Mon, 19 Oct 2020 05:23:04 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] can: mcp251xfd: mcp251xfd_chip_wake(): renamed
 from mcp251xfd_chip_clock_enable()
To:     linux-can@vger.kernel.org
References: <20201016205211.1141590-1-mkl@pengutronix.de>
 <20201016205211.1141590-2-mkl@pengutronix.de>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
From:   =?UTF-8?Q?Magnus_Aagaard_S=c3=b8rensen?= <mas@csselectronics.com>
Message-ID: <dd0f95b7-27ea-331b-7629-e652b6aa7b9b@csselectronics.com>
Date:   Mon, 19 Oct 2020 07:23:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201016205211.1141590-2-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Magnus Aagaard Sørensen <mas@csselectronics.com>

On 16-10-2020 22:52, Marc Kleine-Budde wrote:
> Co-developed-by: Magnus Aagaard Sørensen <mas@csselectronics.com>
> Not-Singed-off-by: Magnus Aagaard Sørensen <mas@csselectronics.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index c3f49543ff26..c36f5f14d50c 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -519,13 +519,16 @@ static inline bool mcp251xfd_osc_invalid(u32 reg)
>   	return reg == 0x0 || reg == 0xffffffff;
>   }
>   
> -static int mcp251xfd_chip_clock_enable(const struct mcp251xfd_priv *priv)
> +static int mcp251xfd_chip_wake(const struct mcp251xfd_priv *priv)
>   {
>   	u32 osc, osc_reference, osc_mask;
>   	int err;
>   
> -	/* Set Power On Defaults for "Clock Output Divisor" and remove
> -	 * "Oscillator Disable" bit.
> +	/* For normal sleep on MCP2517FD and MCP2518FD, clearing
> +	 * "Oscillator Disable" will wake the chip. For low power mode
> +	 * on MCP2518FD, asserting the chip select will wake the
> +	 * chip. Writing to the Oscillator register will wake it in
> +	 * both cases.
>   	 */
>   	osc = FIELD_PREP(MCP251XFD_REG_OSC_CLKODIV_MASK,
>   			 MCP251XFD_REG_OSC_CLKODIV_10);
> @@ -569,10 +572,10 @@ static int mcp251xfd_chip_softreset_do(const struct mcp251xfd_priv *priv)
>   	const __be16 cmd = mcp251xfd_cmd_reset();
>   	int err;
>   
> -	/* The Set Mode and SPI Reset command only seems to works if
> -	 * the controller is not in Sleep Mode.
> +	/* The Set Mode and SPI Reset command only works if the
> +	 * controller is not in Sleep Mode.
>   	 */
> -	err = mcp251xfd_chip_clock_enable(priv);
> +	err = mcp251xfd_chip_wake(priv);
>   	if (err)
>   		return err;
>   
