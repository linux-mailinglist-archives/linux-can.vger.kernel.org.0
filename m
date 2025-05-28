Return-Path: <linux-can+bounces-3713-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58925AC62ED
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 09:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD7B7AFBC9
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 07:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A707A244678;
	Wed, 28 May 2025 07:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="IQSjxLSk"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m1973196.qiye.163.com (mail-m1973196.qiye.163.com [220.197.31.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014A1367;
	Wed, 28 May 2025 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417202; cv=none; b=FGVRlyS2LeDUgvyXB2/QhLn7XYza9oSttr3I7TDmMHodr6NeWiiplU5gITvlOTiS17By0qaiNOo84D+HeOaeOJ2lKF0aS2pEkvvXkNCcCRzcnOllIuO8WYwN3SBoDS2kXQq4U5yg3zrul/VkYBHyd7hTExoxFVLZnJp9yBVvY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417202; c=relaxed/simple;
	bh=oCxNkydoGors5tHiS9k0A0CzHEVAaQ5VWNQ7UidB+6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbtEP08dhTzPM7SHJNnEN9O5vVC5MuW9QC9b+VghbE1X/7IrSjlF05610mIw11CvZoiwtvqfwgmmbYcRkX5PMVg06NgAnx2dmKJ7IeyMqPzZ0zOgEJPHYl3o6b5rLa23dz31Un4LbhKOwKLdvzLUTJiKqnyNTInULzkixSHcHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=IQSjxLSk; arc=none smtp.client-ip=220.197.31.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.30] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 16ad6a08f;
	Wed, 28 May 2025 15:21:18 +0800 (GMT+08:00)
Message-ID: <c3884749-7d26-425c-8ca4-2e2d708aa7f9@rock-chips.com>
Date: Wed, 28 May 2025 15:21:17 +0800
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] net: can: rockchip: support dma for rk3576 rx
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com,
 kever.yang@rock-chips.com, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250526062559.2061311-1-zhangqing@rock-chips.com>
 <20250526062559.2061311-5-zhangqing@rock-chips.com>
 <20250527-benevolent-rainbow-sturgeon-55c33b-mkl@pengutronix.de>
From: zhangqing <zhangqing@rock-chips.com>
In-Reply-To: <20250527-benevolent-rainbow-sturgeon-55c33b-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh9PQlYYQx1DGUtJGh9KGkpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9715c457cd03a3kunm7db02ee67c217e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NDo6PRw5AzE2GEkSCiMhPAID
	HxoaCQFVSlVKTE9DT0pNQ0NKSUlCVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpPT0tJNwY+
DKIM-Signature:a=rsa-sha256;
	b=IQSjxLSkv153Y/Qna1clKI8BTL3sq9ZrV1PtCeXuuO/fxOcJIE9SGv/uTrc2LL5sFT5OKN8rK/QxFrIrmKWsxJ911nnxKEpoS/Sq4mGGmbBejK3NS5c5MtSsmqyhG1JTmKCm2/Ri87IkT4AMRDc80Ajm46Bkty4QF2lgRumPzik=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=xqyFlrQNnrOFMkrHG9lvTlzgz/nAJIiDsV2HEdjtv58=;
	h=date:mime-version:subject:message-id:from;


在 2025/5/27 19:00, Marc Kleine-Budde 写道:
> On 26.05.2025 14:25:59, Elaine Zhang wrote:
>> The new can controller of rk3576 supports rx dma.
> I'm missing dma_sync_single_for_cpu() and dma_sync_single_for_device().
>
> What does the overall picture look like?
>
> The CAN controller receives a CAN frame, it triggers an interrupt, the
> driver starts a RX-DMA, the RX-DMA finishes triggers the callback, the
> driver allocates an skb and copies the data from the DMA dest memory to
> the skb. Finally the skb is passed to the networking stack.
After enabling dma, when the water level of the fifo reaches the 
expected level, dma is initiated. First, the frame numbers in the fifo 
are read, and dma moves the data of these frame numbers at one time.
Then the dma completion interrupt is returned, and the cpu begins to 
process the data moved by dma.
>
> Have you done any measurements if using DMA brings any benefits here? I
> doubt that.
It has been tested that for the RK3576 cpu with relatively strong 
capabilities, switching dma has little impact.

However, for the RK3506 with only three cpu cores, enabling dma can 
reduce cpu interruption. The most obvious one is that after enabling 
dma, there will be no frame loss problem when the CAN load is over 90%.

Subsequently, both rk3506 and rv1126b used the rk3576 canfd controller.

>
> If your hardware supports, a better setup would be to allocate a bunch
> of skbs and setup the a DMA request per skb and push them all to the DMA
> engine during open(). If the CAN controller receives a CAN frame, the
> DMA automatically starts and raises an IRQ after finish of the DMA
> transfer. Transform the header and then pass the skb to the networking
> stack - no need for memcpy.
>
> This _might_ lower the total CPU cost of RX, but a lot of additional
> code is used for that.
I can try to modify.
Including other modifications proposed below, they will be updated in 
the next version
>
> Never the less, review inline.
>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> ---
>>   .../net/can/rockchip/rockchip_canfd-core.c    | 39 +++++++++
>>   drivers/net/can/rockchip/rockchip_canfd-rx.c  | 87 +++++++++++++++++++
>>   drivers/net/can/rockchip/rockchip_canfd.h     | 11 +++
>>   3 files changed, 137 insertions(+)
>>
>> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
>> index 92e260cb2527..9ef4a9ae19d8 100644
>> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
>> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
>> @@ -433,6 +433,9 @@ static void rk3576canfd_chip_start(struct rkcanfd_priv *priv)
>>   		      RK3576CANFD_REG_BRS_CFG_BRS_NEGSYNC_EN |
>>   		      RK3576CANFD_REG_BRS_CFG_BRS_POSSYNC_EN);
>>   
>> +	if (priv->use_dma)
>> +		rkcanfd_write(priv, RK3576CANFD_REG_DMA_CTRL,
>> +			      RK3576CANFD_REG_DMA_CTRL_DMA_RX_EN | priv->dma_thr);
>>   	rkcanfd_set_bittiming(priv);
>>   
>>   	priv->devtype_data.interrupts_disable(priv);
>> @@ -1324,10 +1327,31 @@ static const struct of_device_id rkcanfd_of_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, rkcanfd_of_match);
>>   
>> +static void rk3576_canfd_dma_init(struct rkcanfd_priv *priv)
>> +{
>> +	struct dma_slave_config rxconf = {
>> +		.direction = DMA_DEV_TO_MEM,
>> +		.src_addr = priv->rx_dma_src_addr,
>> +		.src_addr_width = 4,
>> +		.dst_addr_width = 4,
>> +		.src_maxburst = 9,
>> +	};
>> +
>> +	priv->dma_thr = rxconf.src_maxburst - 1;
>> +	priv->rxbuf = dma_alloc_coherent(priv->dev, priv->dma_size * 14,
> Where does the 14 come from?
In the fixed mode of CANFD, there are 18 words per frame, and the 
maximum number of words in the fifo is 256. The fifo can store up to 
256/18=14 frames at most.
>
>> +					 &priv->rx_dma_dst_addr, GFP_KERNEL);
> I'm missing the cleanup for priv->rxbuf.
>
>> +	if (!priv->rxbuf) {
>> +		priv->use_dma = 0;
>> +		return;
>> +	}
>> +	dmaengine_slave_config(priv->rxchan, &rxconf);
> Please add error handling.
>
>> +}
>> +
>>   static int rkcanfd_probe(struct platform_device *pdev)
>>   {
>>   	struct rkcanfd_priv *priv;
>>   	struct net_device *ndev;
>> +	struct resource *res;
>>   	const void *match;
>>   	int err;
>>   
>> @@ -1349,6 +1373,7 @@ static int rkcanfd_probe(struct platform_device *pdev)
>>   		goto out_free_candev;
>>   	}
>>   
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>   	priv->regs = devm_platform_ioremap_resource(pdev, 0);
> Please use devm_platform_get_and_ioremap_resource();
>
>>   	if (IS_ERR(priv->regs)) {
>>   		err = PTR_ERR(priv->regs);
>> @@ -1376,6 +1401,7 @@ static int rkcanfd_probe(struct platform_device *pdev)
>>   	priv->can.do_set_mode = rkcanfd_set_mode;
>>   	priv->can.do_get_berr_counter = rkcanfd_get_berr_counter;
>>   	priv->ndev = ndev;
>> +	priv->dev = &pdev->dev;
> Please remove, priv->dev is not used in the hot path, use
> priv->ndev->dev.parent instead.
>
>>   
>>   	match = device_get_match_data(&pdev->dev);
>>   	if (match) {
>> @@ -1384,6 +1410,19 @@ static int rkcanfd_probe(struct platform_device *pdev)
>>   			priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
>>   	}
>>   
>> +	priv->rxchan = dma_request_chan(&pdev->dev, "rx");
> I'm missing the cleanup for priv->rxchan.
>
>> +	if (IS_ERR(priv->rxchan)) {
> Please handle -EPROBE_DEFER properly.
>
>> +		dev_warn(&pdev->dev, "Failed to request rxchan\n");
> Please print the error value and state that you are continuing w/o DMA,
> e.g.:
>
>      netdev_warn("Failed to request RX-DMA channel: %pe, continuing without DMA", priv->rxchan);
>
>> +		priv->rxchan = NULL;
>> +		priv->use_dma = 0;
>> +	} else {
>> +		priv->rx_dma_src_addr = res->start + RK3576CANFD_REG_RXFRD;
>> +		priv->dma_size = RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT * 4;
> Why do you need priv->dma_size, it doesn't change during runtime, does it?
>
>> +		priv->use_dma = 1;
>> +	}
>> +	if (priv->use_dma)
>> +		rk3576_canfd_dma_init(priv);
>> +
> Can you move all DMA related functionality into rk3576_canfd_dma_init(),
> pass res as a parameter, remove rx_dma_src_addr.
>
> I think you don't need use_dma, checking rxchan != NULL should be
> sufficient.
>
>>   	err = can_rx_offload_add_manual(ndev, &priv->offload,
>>   					RKCANFD_NAPI_WEIGHT);
>>   	if (err)
>> diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
>> index 8a383cabd9d2..ac06e876552e 100644
>> --- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
>> +++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
>> @@ -285,6 +285,52 @@ static int rk3576canfd_handle_rx_int_one(struct rkcanfd_priv *priv)
>>   	return 0;
>>   }
>>   
>> +static int rk3576canfd_handle_rx_dma(struct rkcanfd_priv *priv, u32 addr)
>> +{
>> +	struct net_device_stats *stats = &priv->ndev->stats;
>> +	struct canfd_frame cfd[1] = { }, *skb_cfd;
>> +	struct rk3576canfd_fifo_header header[1] = { };
>> +	struct sk_buff *skb;
>> +	u32 __iomem *rxbuf = (u32 __iomem *)priv->rxbuf;
> Why do you cast rx_buf to __iomem? It's normal memory, isn't it?
>
>> +	unsigned int len;
>> +	int i;
>> +
>> +	header->frameinfo = readl(rxbuf +
>> +				  addr * RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
>> +	header->id = readl(rxbuf + 1 +
>> +			   addr * RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
>> +	for (i = 0; i < (RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT - 2); i++)
>> +		cfd->data[i] = readl(rxbuf + 2 + i +
>> +				     addr * RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
>> +
> Remove cfd and header and directly access the rxbuf.
>
>> +	len = rk3576canfd_fifo_header_to_cfd_header(priv, header, cfd);
>> +
>> +	/* Manual handling of CAN Bus Error counters. See
>> +	 * rkcanfd_get_corrected_berr_counter() for detailed
>> +	 * explanation.
>> +	 */
>> +	if (priv->bec.rxerr)
>> +		priv->bec.rxerr = min(CAN_ERROR_PASSIVE_THRESHOLD,
>> +				      priv->bec.rxerr) - 1;
>> +
>> +	if (header->frameinfo & RK3576CANFD_REG_RXFRD_FRAMEINFO_FDF)
>> +		skb = alloc_canfd_skb(priv->ndev, &skb_cfd);
>> +	else
>> +		skb = alloc_can_skb(priv->ndev, (struct can_frame **)&skb_cfd);
> copy the data to the allocated skb directly.
>
>> +
>> +	if (!skb) {
>> +		stats->rx_dropped++;
>> +
>> +		return 0;
>> +	}
>> +
>> +	memcpy(skb_cfd, cfd, len);
>> +	stats->rx_packets++;
>> +	stats->rx_bytes += cfd->len;
>> +	netif_rx(skb);
> Use the rx_offload_helper here too.
>
>> +	return 0;
>> +}
>> +
>>   static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
>>   {
>>   	struct net_device_stats *stats = &priv->ndev->stats;
>> @@ -380,6 +426,43 @@ rk3576canfd_rx_fifo_get_len(const struct rkcanfd_priv *priv)
>>   	return DIV_ROUND_UP(val, RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
>>   }
>>   
>> +static void rk3576_canfd_rx_dma_callback(void *data)
>> +{
>> +	struct rkcanfd_priv *priv = data;
>> +	int i;
>> +
>> +	for (i = 0; i < priv->quota; i++)
>> +		rk3576canfd_handle_rx_dma(priv, i);
>> +
>> +	rkcanfd_write(priv, RK3576CANFD_REG_INT_MASK, priv->reg_int_mask_default);
>> +}
>> +
>> +static int rk3576_canfd_rx_dma(struct rkcanfd_priv *priv)
>> +{
>> +	struct dma_async_tx_descriptor *rxdesc = NULL;
>> +	const u32 reg = rkcanfd_read(priv, RK3576CANFD_REG_STR_STATE);
>> +	int quota = FIELD_GET(RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT, reg);
>> +
>> +	quota = DIV_ROUND_UP(quota, RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
>> +	priv->quota = quota;
>> +	if (priv->quota == 0) {
>> +		rkcanfd_write(priv, RK3576CANFD_REG_INT_MASK, priv->reg_int_mask_default);
>> +		return 0;
>> +	}
>> +
>> +	rxdesc = dmaengine_prep_slave_single(priv->rxchan, priv->rx_dma_dst_addr,
>> +					     priv->dma_size * priv->quota, DMA_DEV_TO_MEM, 0);
>> +	if (!rxdesc)
>> +		return -ENOMSG;
>> +
>> +	rxdesc->callback = rk3576_canfd_rx_dma_callback;
>> +	rxdesc->callback_param = priv;
>> +
>> +	dmaengine_submit(rxdesc);
> Please add error handling.
>
>> +	dma_async_issue_pending(priv->rxchan);
>> +	return 0;
>> +}
>> +
>>   int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv)
>>   {
>>   	unsigned int len;
>> @@ -399,6 +482,10 @@ int rkcanfd_handle_rk3576_rx_int(struct rkcanfd_priv *priv)
>>   	unsigned int len;
>>   	int err;
>>   
>> +	if (priv->use_dma) {
>> +		rk3576_canfd_rx_dma(priv);
>> +		return 0;
> Please add error handling.
>
>> +	}
>>   	while ((len = rk3576canfd_rx_fifo_get_len(priv))) {
>>   		err = rk3576canfd_handle_rx_int_one(priv);
>>   		if (err)
>> diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
>> index 9b91d757d054..c7d6845c6d95 100644
>> --- a/drivers/net/can/rockchip/rockchip_canfd.h
>> +++ b/drivers/net/can/rockchip/rockchip_canfd.h
>> @@ -11,6 +11,8 @@
>>   #include <linux/can/dev.h>
>>   #include <linux/can/rx-offload.h>
>>   #include <linux/clk.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/dmaengine.h>
>>   #include <linux/io.h>
>>   #include <linux/netdevice.h>
>>   #include <linux/reset.h>
>> @@ -737,6 +739,7 @@ struct rkcanfd_priv {
>>   	struct can_priv can;
>>   	struct can_rx_offload offload;
>>   	struct net_device *ndev;
>> +	struct device *dev;
> It's not used in the hot path, please remove.
>
>>   
>>   	void __iomem *regs;
>>   	unsigned int tx_head;
>> @@ -758,6 +761,14 @@ struct rkcanfd_priv {
>>   	struct reset_control *reset;
>>   	struct clk_bulk_data *clks;
>>   	int clks_num;
>> +	bool use_dma;
>> +	u32 dma_size;
>> +	u32 dma_thr;
>> +	int quota;
>> +	struct dma_chan *rxchan;
>> +	u32 *rxbuf;
>> +	dma_addr_t rx_dma_src_addr;
>> +	dma_addr_t rx_dma_dst_addr;
>>   };
>>   
>>   static inline u32
> I'll look at patch 3/4 later this week or next week.
>
> regards,
> Marc
>
-- 
张晴
瑞芯微电子股份有限公司
Rockchip Electronics Co.,Ltd
地址：福建省福州市铜盘路软件大道89号软件园A区21号楼
Add:No.21 Building, A District, No.89 Software Boulevard Fuzhou, Fujian 350003, P.R.China
Tel:+86-0591-83991906-8601
邮编：350003
E-mail:elaine.zhang@rock-chips.com
****************************************************************************
保密提示：本邮件及其附件含有机密信息，仅发送给本邮件所指特定收件人。若非该特定收件人，请勿复制、使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件或其他方式即刻告知发件人。福州瑞芯微电子有限公司拥有本邮件信息的著作权及解释权，禁止任何未经授权许可的侵权行为。

IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., Ltd .The contents of this email and any attachments may contain information that is privileged, confidential and/or exempt from disclosure under applicable law and relevant NDA. If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the information is STRICTLY PROHIBITED. Please immediately contact the sender as soon as possible and destroy the material in its entirety in any format. Thank you.

****************************************************************************


