Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4F42DAB74
	for <lists+linux-can@lfdr.de>; Tue, 15 Dec 2020 11:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgLOKwc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 05:52:32 -0500
Received: from first.geanix.com ([116.203.34.67]:47788 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbgLOKw2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 15 Dec 2020 05:52:28 -0500
Received: from [IPv6:2a06:4004:10df:1:da27:a6d2:5305:fd0a] (_gateway [172.21.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 0F6DC48614C;
        Tue, 15 Dec 2020 10:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1608029506; bh=Akiao4UYRAPB3yg+p37X988qx2hxtXo9zMVQ4rV4NOg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=S+o/gALOwLccY1kJJhpstYzWowslrUNF99ANdsHH5voErRgzkPWZB/zaxbr6dOXrk
         xrpwRToOYCE0kRcWKwMDURtLd9LJAad9CV1HncL2EjNFhPZRP2k1ESBQdfrvsd+ds2
         udpTX28eQ58LliYgmQLuAdKWuyNQYTdwMC5mLZvKEo/IM7MoLGKYFEK/pwNkLzINkB
         PonFsswqiiXvwqwVw1t7y+xMc+Tvi1X6vMxhEVuGvpkl5SDdw0iDYaXMDfETz3Vicu
         KhH6t+brK/6n8DIWAlIHC4/aZNcpONXNYtnoWLIDXkh/YJBNLx1wd9S8vZDtS/IXN4
         w1QeHNukrJnbQ==
Subject: Re: [net-rfc 2/2] can: tcan4x5x: fix bittiming const, use common
 bittiming from m_can driver
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>
References: <20201215103238.524029-1-mkl@pengutronix.de>
 <20201215103238.524029-3-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <611cf72a-23ce-160a-a5d3-bbab2204e371@geanix.com>
Date:   Tue, 15 Dec 2020 11:51:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201215103238.524029-3-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on ff3d05386fc5
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 15/12/2020 11.32, Marc Kleine-Budde wrote:
> According to the TCAN4550 datasheet "SLLSF91 - DECEMBER 2018" the tcan4x5x has
> the same bittiming constants as a m_can revision 3.2.x/3.3.0.
>
> The tcan4x5x chip I'm using identifies itself as m_can revision 3.2.1, so
> remove the tcan4x5x specific bittiming values and rely on the values in the
> m_can driver, which are selected according to core revision.
>
> Fixes: 5443c226ba91 ("can: tcan4x5x: Add tcan4x5x driver to the kernel")
> Cc: Dan Murphy <dmurphy@ti.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/m_can/tcan4x5x.c | 26 --------------------------
>   1 file changed, 26 deletions(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index 7347ab39c5b6..f726c5112294 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -129,30 +129,6 @@ struct tcan4x5x_priv {
>   	int reg_offset;
>   };
>   
> -static struct can_bittiming_const tcan4x5x_bittiming_const = {
> -	.name = DEVICE_NAME,
> -	.tseg1_min = 2,
> -	.tseg1_max = 31,
> -	.tseg2_min = 2,
> -	.tseg2_max = 16,
> -	.sjw_max = 16,
> -	.brp_min = 1,
> -	.brp_max = 32,
> -	.brp_inc = 1,
> -};
> -
> -static struct can_bittiming_const tcan4x5x_data_bittiming_const = {
> -	.name = DEVICE_NAME,
> -	.tseg1_min = 1,
> -	.tseg1_max = 32,
> -	.tseg2_min = 1,
> -	.tseg2_max = 16,
> -	.sjw_max = 16,
> -	.brp_min = 1,
> -	.brp_max = 32,
> -	.brp_inc = 1,
> -};
> -
>   static void tcan4x5x_check_wake(struct tcan4x5x_priv *priv)
>   {
>   	int wake_state = 0;
> @@ -479,8 +455,6 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>   	mcan_class->dev = &spi->dev;
>   	mcan_class->ops = &tcan4x5x_ops;
>   	mcan_class->is_peripheral = true;
> -	mcan_class->bit_timing = &tcan4x5x_bittiming_const;
> -	mcan_class->data_timing = &tcan4x5x_data_bittiming_const;
>   	mcan_class->net->irq = spi->irq;
>   
>   	spi_set_drvdata(spi, priv);

