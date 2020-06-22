Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38ADE203844
	for <lists+linux-can@lfdr.de>; Mon, 22 Jun 2020 15:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgFVNiI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Jun 2020 09:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbgFVNiH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2020 09:38:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF82C061573
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 06:38:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jnMeE-000722-6I; Mon, 22 Jun 2020 15:38:06 +0200
Received: from [IPv6:2a03:f580:87bc:d400:789c:8c3:eaa5:9d1b] (unknown [IPv6:2a03:f580:87bc:d400:789c:8c3:eaa5:9d1b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EFB1151EF30;
        Mon, 22 Jun 2020 13:38:04 +0000 (UTC)
Subject: Re: [PATCH] can: mcp25xxfd: add listen-only mode
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        linux-can@vger.kernel.org
References: <20200622122047.9494-1-dev.kurt@vandijck-laurijssen.be>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 mQINBFFVq30BEACtnSvtXHoeHJxG6nRULcvlkW6RuNwHKmrqoksispp43X8+nwqIFYgb8UaX
 zu8T6kZP2wEIpM9RjEL3jdBjZNCsjSS6x1qzpc2+2ivjdiJsqeaagIgvy2JWy7vUa4/PyGfx
 QyUeXOxdj59DvLwAx8I6hOgeHx2X/ntKAMUxwawYfPZpP3gwTNKc27dJWSomOLgp+gbmOmgc
 6U5KwhAxPTEb3CsT5RicsC+uQQFumdl5I6XS+pbeXZndXwnj5t84M+HEj7RN6bUfV2WZO/AB
 Xt5+qFkC/AVUcj/dcHvZwQJlGeZxoi4veCoOT2MYqfR0ax1MmN+LVRvKm29oSyD4Ts/97cbs
 XsZDRxnEG3z/7Winiv0ZanclA7v7CQwrzsbpCv+oj+zokGuKasofzKdpywkjAfSE1zTyF+8K
 nxBAmzwEqeQ3iKqBc3AcCseqSPX53mPqmwvNVS2GqBpnOfY7Mxr1AEmxdEcRYbhG6Xdn+ACq
 Dq0Db3A++3PhMSaOu125uIAIwMXRJIzCXYSqXo8NIeo9tobk0C/9w3fUfMTrBDtSviLHqlp8
 eQEP8+TDSmRP/CwmFHv36jd+XGmBHzW5I7qw0OORRwNFYBeEuiOIgxAfjjbLGHh9SRwEqXAL
 kw+WVTwh0MN1k7I9/CDVlGvc3yIKS0sA+wudYiselXzgLuP5cQARAQABtCZNYXJjIEtsZWlu
 ZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPokCVAQTAQoAPgIbAwIeAQIXgAULCQgHAwUV
 CgkICwUWAgMBABYhBMFAC6CzmJ5vvH1bXCte4hHFiupUBQJcUsSbBQkM366zAAoJECte4hHF
 iupUgkAP/2RdxKPZ3GMqag33jKwKAbn/fRqAFWqUH9TCsRH3h6+/uEPnZdzhkL4a9p/6OeJn
 Z6NXqgsyRAOTZsSFcwlfxLNHVxBWm8pMwrBecdt4lzrjSt/3ws2GqxPsmza1Gs61lEdYvLST
 Ix2vPbB4FAfE0kizKAjRZzlwOyuHOr2ilujDsKTpFtd8lV1nBNNn6HBIBR5ShvJnwyUdzuby
 tOsSt7qJEvF1x3y49bHCy3uy+MmYuoEyG6zo9udUzhVsKe3hHYC2kfB16ZOBjFC3lH2U5An+
 yQYIIPZrSWXUeKjeMaKGvbg6W9Oi4XEtrwpzUGhbewxCZZCIrzAH2hz0dUhacxB201Y/faY6
 BdTS75SPs+zjTYo8yE9Y9eG7x/lB60nQjJiZVNvZ88QDfVuLl/heuIq+fyNajBbqbtBT5CWf
 mOP4Dh4xjm3Vwlz8imWW/drEVJZJrPYqv0HdPbY8jVMpqoe5jDloyVn3prfLdXSbKPexlJaW
 5tnPd4lj8rqOFShRnLFCibpeHWIumqrIqIkiRA9kFW3XMgtU6JkIrQzhJb6Tc6mZg2wuYW0d
 Wo2qvdziMgPkMFiWJpsxM9xPk9BBVwR+uojNq5LzdCsXQ2seG0dhaOTaaIDWVS8U/V8Nqjrl
 6bGG2quo5YzJuXKjtKjZ4R6k762pHJ3tnzI/jnlc1sXz
Message-ID: <24a81519-9628-6626-77e6-22dbd5253954@pengutronix.de>
Date:   Mon, 22 Jun 2020 15:38:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622122047.9494-1-dev.kurt@vandijck-laurijssen.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 6/22/20 2:20 PM, Kurt Van Dijck wrote:
> This commit enables listen-only mode, which works internally like CANFD mode.

Does the controller distinguish between CAN-2.0 listen only and CAN-FD listen
only mode?

If listen only means CAN-FD...should we add a check to open() if CAN_CTRLMODE_FD
and CAN_CTRLMODE_LISTENONLY is both set (or unset).

Please compile with #define DEBUG and look in dmesg the size of the objects in
the mailbox. Maybe it's worth not allocating any TEF and TX mailbox and using
more RX instead.

We have to convert the driver from using a bit mask to modulo to get from the
tail and head to the actual index inside the RAM.

> Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> ---
>  drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
> index c744a0bf2faa..f3bc7d0f1f94 100644
> --- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
> +++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
> @@ -392,7 +392,8 @@ static int mcp25xxfd_ring_alloc(struct mcp25xxfd_priv *priv)
>  	int ram_free, i;
>  
>  	tef_obj_size = sizeof(struct mcp25xxfd_hw_tef_obj);
> -	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
> +	/* listen-only mode works like FD mode */
> +	if (priv->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_LISTENONLY)) {
>  		tx_obj_num = MCP25XXFD_TX_OBJ_NUM_CANFD;
>  		tx_obj_size = sizeof(struct mcp25xxfd_hw_tx_obj_canfd);
>  		rx_obj_size = sizeof(struct mcp25xxfd_hw_rx_obj_canfd);
> @@ -807,7 +808,7 @@ mcp25xxfd_chip_rx_fifo_init_one(const struct mcp25xxfd_priv *priv,
>  		MCP25XXFD_REG_FIFOCON_RXOVIE |
>  		MCP25XXFD_REG_FIFOCON_TFNRFNIE;
>  
> -	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
> +	if (priv->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_LISTENONLY))
>  		fifo_con |= FIELD_PREP(MCP25XXFD_REG_FIFOCON_PLSIZE_MASK,
>  				       MCP25XXFD_REG_FIFOCON_PLSIZE_64);
>  	else
> @@ -857,7 +858,7 @@ static int mcp25xxfd_chip_fifo_init(const struct mcp25xxfd_priv *priv)
>  		MCP25XXFD_REG_FIFOCON_TXEN |
>  		MCP25XXFD_REG_FIFOCON_TXATIE;
>  
> -	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
> +	if (priv->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_LISTENONLY))
>  		val |= FIELD_PREP(MCP25XXFD_REG_FIFOCON_PLSIZE_MASK,
>  				  MCP25XXFD_REG_FIFOCON_PLSIZE_64);
>  	else
> @@ -930,7 +931,9 @@ static u8 mcp25xxfd_get_normal_mode(const struct mcp25xxfd_priv *priv)
>  {
>  	u8 mode;
>  
> -	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +		mode = MCP25XXFD_REG_CON_MODE_LISTENONLY;
> +	else if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
>  		mode = MCP25XXFD_REG_CON_MODE_MIXED;
>  	else
>  		mode = MCP25XXFD_REG_CON_MODE_CAN2_0;
> @@ -2778,6 +2781,7 @@ static int mcp25xxfd_probe(struct spi_device *spi)
>  	priv->can.bittiming_const = &mcp25xxfd_bittiming_const;
>  	priv->can.data_bittiming_const = &mcp25xxfd_data_bittiming_const;
>  	priv->can.ctrlmode_supported = CAN_CTRLMODE_FD |
> +		CAN_CTRLMODE_LISTENONLY |
>  		CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_FD_NON_ISO;

please sort this list following (I know it currently isn't):

https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/can/netlink.h#L95

>  	priv->ndev = ndev;
>  	priv->spi = spi;
> 

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
