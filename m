Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F0C40D974
	for <lists+linux-can@lfdr.de>; Thu, 16 Sep 2021 14:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239020AbhIPMGW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 Sep 2021 08:06:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41598 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239029AbhIPMGW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Sep 2021 08:06:22 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18GC4nD4086883;
        Thu, 16 Sep 2021 07:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631793889;
        bh=bDsmnRhMKsj4jyqsXvOzZjiSqeETHi9jq1BUMXa07ak=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SsEx5+WTI9xGUqY9nTiauSiG0HwEGq28HWNARZ9qSzCOjlq49nLApcAXMoyioW0tJ
         Z0pHPcBZsiZ6BlIDxF04hpoQQhI8bsOoLu/unpHw2rY7/rsdttm0sjGD0NEpM+83pg
         g99x1z/5b3M9gde8kKEwJJAxA+8uNabZO0LwRWGs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18GC4nWw068850
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Sep 2021 07:04:49 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 16
 Sep 2021 07:04:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 16 Sep 2021 07:04:48 -0500
Received: from [10.250.232.51] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18GC4kaP062099;
        Thu, 16 Sep 2021 07:04:46 -0500
Subject: Re: [PATCH v3 2/3] can: m_can: Batch FIFO reads during CAN receive
To:     Matt Kline <matt@bitbashing.io>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>
References: <20210817050853.14875-1-matt@bitbashing.io>
 <20210817050853.14875-3-matt@bitbashing.io>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <aa0d3bed-dd0d-ae13-d0ef-6fb130db5aa5@ti.com>
Date:   Thu, 16 Sep 2021 17:34:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817050853.14875-3-matt@bitbashing.io>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Matt, Marc,

On 17/08/21 10:38 am, Matt Kline wrote:
> On peripherals communicating over a relatively slow SPI line
> (e.g. tcan4x5x), individual transfers have high fixed costs.
> This causes the driver to spend most of its time waiting between
> transfers and severely limits throughput.
> 
> Reduce these overheads by reading more than one word at a time.
> Writing could get a similar treatment in follow-on commits.
> 
> Signed-off-by: Matt Kline <matt@bitbashing.io>
> ---
>  drivers/net/can/m_can/m_can.c | 51 +++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 83eb5cd51de5..85d6cd03bff1 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -308,6 +308,15 @@ enum m_can_reg {
>  #define TX_EVENT_MM_MASK	GENMASK(31, 24)
>  #define TX_EVENT_TXTS_MASK	GENMASK(15, 0)
>  
> +/* The ID and DLC registers are adjacent in M_CAN FIFO memory,
> + * and we can save a (potentially slow) bus round trip by combining
> + * reads and writes to them.
> + */
> +struct __packed id_and_dlc {
> +	u32 id;
> +	u32 dlc;
> +};
> +
>  static inline u32 m_can_read(struct m_can_classdev *cdev, enum m_can_reg reg)
>  {
>  	return cdev->ops->read_reg(cdev, reg);
> @@ -460,17 +469,18 @@ static int m_can_read_fifo(struct net_device *dev, u32 rxfs)
>  	struct m_can_classdev *cdev = netdev_priv(dev);
>  	struct canfd_frame *cf;
>  	struct sk_buff *skb;
> -	u32 id, fgi, dlc;
> +	struct id_and_dlc fifo_header;
> +	u32 fgi;
>  	u32 timestamp = 0;
> -	int i, err;
> +	int err;
>  
>  	/* calculate the fifo get index for where to read data */
>  	fgi = FIELD_GET(RXFS_FGI_MASK, rxfs);
> -	err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DLC, &dlc, 1);
> +	err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_ID, &fifo_header, 2);

While reading multiple register fields and calling iomap_read_fifo() in
m_can_platform.c is causing an issue.

In iomap_read_fifo(), ioread32_rep() is being used for reading.
ioread32_rep reads() from the same source address for val_count times.
This is not the intended behavior here. The source address also needs to
be shifted along with the destination address.

Is a fix required in iomap_read_fifo() ?

Thanks,
Aswath

>  	if (err)
>  		goto out_fail;
>  
> -	if (dlc & RX_BUF_FDF)
> +	if (fifo_header.dlc & RX_BUF_FDF)
>  		skb = alloc_canfd_skb(dev, &cf);
>  	else
>  		skb = alloc_can_skb(dev, (struct can_frame **)&cf);
> @@ -479,36 +489,31 @@ static int m_can_read_fifo(struct net_device *dev, u32 rxfs)
>  		return 0;
>  	}
>  
> -	if (dlc & RX_BUF_FDF)
> -		cf->len = can_fd_dlc2len((dlc >> 16) & 0x0F);
> +	if (fifo_header.dlc & RX_BUF_FDF)
> +		cf->len = can_fd_dlc2len((fifo_header.dlc >> 16) & 0x0F);
>  	else
> -		cf->len = can_cc_dlc2len((dlc >> 16) & 0x0F);
> +		cf->len = can_cc_dlc2len((fifo_header.dlc >> 16) & 0x0F);
>  
> -	err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_ID, &id, 1);
> -	if (err)
> -		goto out_fail;
> -
> -	if (id & RX_BUF_XTD)
> -		cf->can_id = (id & CAN_EFF_MASK) | CAN_EFF_FLAG;
> +	if (fifo_header.id & RX_BUF_XTD)
> +		cf->can_id = (fifo_header.id & CAN_EFF_MASK) | CAN_EFF_FLAG;
>  	else
> -		cf->can_id = (id >> 18) & CAN_SFF_MASK;
> +		cf->can_id = (fifo_header.id >> 18) & CAN_SFF_MASK;
>  
> -	if (id & RX_BUF_ESI) {
> +	if (fifo_header.id & RX_BUF_ESI) {
>  		cf->flags |= CANFD_ESI;
>  		netdev_dbg(dev, "ESI Error\n");
>  	}
>  
> -	if (!(dlc & RX_BUF_FDF) && (id & RX_BUF_RTR)) {
> +	if (!(fifo_header.dlc & RX_BUF_FDF) && (fifo_header.id & RX_BUF_RTR)) {
>  		cf->can_id |= CAN_RTR_FLAG;
>  	} else {
> -		if (dlc & RX_BUF_BRS)
> +		if (fifo_header.dlc & RX_BUF_BRS)
>  			cf->flags |= CANFD_BRS;
>  
> -		for (i = 0; i < cf->len; i += 4) {
> -			err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA(i / 4), cf->data + i, 1);
> -			if (err)
> -				goto out_fail;
> -		}
> +		err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA(0),
> +				      cf->data, DIV_ROUND_UP(cf->len, 4));
> +		if (err)
> +			goto out_fail;
>  	}
>  
>  	/* acknowledge rx fifo 0 */
> @@ -517,7 +522,7 @@ static int m_can_read_fifo(struct net_device *dev, u32 rxfs)
>  	stats->rx_packets++;
>  	stats->rx_bytes += cf->len;
>  
> -	timestamp = FIELD_GET(RX_BUF_RXTS_MASK, dlc);
> +	timestamp = FIELD_GET(RX_BUF_RXTS_MASK, fifo_header.dlc);
>  
>  	m_can_receive_skb(cdev, skb, timestamp);
>  
> 

