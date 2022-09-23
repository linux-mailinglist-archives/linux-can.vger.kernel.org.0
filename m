Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535FC5E7BE5
	for <lists+linux-can@lfdr.de>; Fri, 23 Sep 2022 15:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIWNc3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Sep 2022 09:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiIWNc2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Sep 2022 09:32:28 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4769C131F54
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 06:32:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i26so255826lfp.11
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 06:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kD20UgS2S/t9kb9K8nPD/vXNK6c871ihIgCt3+h2szo=;
        b=EWKF99OOAs/FeOEDgqA7w6sJYmek40mHlDqpgVmmWtrpKOPVmC5C75yACbzcuToE5j
         JzCVVQ17eghLBg4vM0lbswmZ/RqbyhsbcSb7zW0UMLOnqKH7yEy9+GJq4dx0Gv3ex94V
         kca6OMBdQKx/1il6J/t9RFURZuOKTJpq+QBQmHipk+L3ffsid2Ix+UHQWJhsyFPPjQyC
         Evig/Ktc6l79AoGStI07EurUr88sMrxh8PAgmNBo+7WwxM9bmLSZeProakcWs3NH0Af0
         0TPFF2fAFf0mv16de+YYy767A+OqFLYZ0e8h4sSx6Y92WHf9WHoiZrhN5Q58l5cQ/n0R
         d3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kD20UgS2S/t9kb9K8nPD/vXNK6c871ihIgCt3+h2szo=;
        b=L3RqIMTA+nzRqoKv45NX+TsBeDwDOw7weqOZJTPbMARJyplyOxK3wqcEx+KL2JYd7Q
         oQnUsArs8TLng6LfU64btLvrfdxUKjNrsGLlG5ys0o9uEtEFc27e71r4kIjuA9a1T/pg
         SP7cYxZxuIQZkGV087ld331AIkmLVF/b1dDPAH/ITZVEF3DJjJgXcshTfmFzlM5bgqOz
         N/sOvPrNN19M/+3AGAwfsg1r8zl0bQQYOJPZabzZjnspoRNX5iuHmnHSg8mCDVW4Bc23
         /n9J3b7aO1GHYg8EgBmvQsbyGm+S3Tva08YlgKDMHCPr3vXgpFOnsnrCtw7wnPGyvPIc
         yDqw==
X-Gm-Message-State: ACrzQf2EPPwqZMSgGIw39qY5FVXjKqJr/Ddkt3ursBENUuYqfrWhP5/x
        S232Pmm4q/k2GY9sq5JC6Pom6YgxtKfh0Q==
X-Google-Smtp-Source: AMsMyM7f6OXGnTEnyz8xuyLzT+Wzp2ke27AxpLTpY4YZTQ0Il6bY8kdcrj8VLLVa7WIzV3lo7IKlAw==
X-Received: by 2002:a05:6512:312a:b0:498:f5d4:52fa with SMTP id p10-20020a056512312a00b00498f5d452famr3435180lfd.311.1663939945569;
        Fri, 23 Sep 2022 06:32:25 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id v4-20020ac258e4000000b00492ca820e15sm1443465lfo.270.2022.09.23.06.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 06:32:25 -0700 (PDT)
Message-ID: <64a24092-903a-6722-b9c8-915b5bd1dada@gmail.com>
Date:   Fri, 23 Sep 2022 15:32:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RFC] can: c_can: don't cache TX messages for C_CAN cores
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20220923114223.726808-1-mkl@pengutronix.de>
From:   Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <20220923114223.726808-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On 9/23/22 13:42, Marc Kleine-Budde wrote:
> Link: https://lore.kernel.org/all/15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com
> Reported-by: Jacob Kroon <jacob.kroon@gmail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   drivers/net/can/c_can/c_can.h      | 17 +++++++++++++++--
>   drivers/net/can/c_can/c_can_main.c | 11 +++++------
>   2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
> index f23a03300a81..029cd8194ed5 100644
> --- a/drivers/net/can/c_can/c_can.h
> +++ b/drivers/net/can/c_can/c_can.h
> @@ -235,9 +235,22 @@ static inline u8 c_can_get_tx_tail(const struct c_can_tx_ring *ring)
>   	return ring->tail & (ring->obj_num - 1);
>   }
>   
> -static inline u8 c_can_get_tx_free(const struct c_can_tx_ring *ring)
> +static inline u8 c_can_get_tx_free(const struct c_can_priv *priv,
> +				   const struct c_can_tx_ring *ring)
>   {
> -	return ring->obj_num - (ring->head - ring->tail);
> +	u8 head = c_can_get_tx_head(ring);
> +	u8 tail = c_can_get_tx_tail(ring);
> +
> +	if (priv->type == BOSCH_D_CAN)
> +		return ring->obj_num - (ring->head - ring->tail);
> +
> +	/* This is not a FIFO. C/D_CAN sends out the buffers
> +	 * prioritized. The lowest buffer number wins.
> +	 */
> +	if (head < tail)
> +		return 0;
> +
> +	return ring->obj_num - head;
>   }
>   
>   #endif /* C_CAN_H */
> diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
> index dc8132862f33..d6605dbb7737 100644
> --- a/drivers/net/can/c_can/c_can_main.c
> +++ b/drivers/net/can/c_can/c_can_main.c
> @@ -429,7 +429,7 @@ static void c_can_setup_receive_object(struct net_device *dev, int iface,
>   static bool c_can_tx_busy(const struct c_can_priv *priv,
>   			  const struct c_can_tx_ring *tx_ring)
>   {
> -	if (c_can_get_tx_free(tx_ring) > 0)
> +	if (c_can_get_tx_free(priv, tx_ring) > 0)
>   		return false;
>   
>   	netif_stop_queue(priv->dev);
> @@ -437,7 +437,7 @@ static bool c_can_tx_busy(const struct c_can_priv *priv,
>   	/* Memory barrier before checking tx_free (head and tail) */
>   	smp_mb();
>   
> -	if (c_can_get_tx_free(tx_ring) == 0) {
> +	if (c_can_get_tx_free(priv, tx_ring) == 0) {
>   		netdev_dbg(priv->dev,
>   			   "Stopping tx-queue (tx_head=0x%08x, tx_tail=0x%08x, len=%d).\n",
>   			   tx_ring->head, tx_ring->tail,
> @@ -465,7 +465,7 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
>   
>   	idx = c_can_get_tx_head(tx_ring);
>   	tx_ring->head++;
> -	if (c_can_get_tx_free(tx_ring) == 0)
> +	if (c_can_get_tx_free(priv, tx_ring) == 0)
>   		netif_stop_queue(dev);
>   
>   	if (idx < c_can_get_tx_tail(tx_ring))
> @@ -748,7 +748,7 @@ static void c_can_do_tx(struct net_device *dev)
>   		return;
>   
>   	tx_ring->tail += pkts;
> -	if (c_can_get_tx_free(tx_ring)) {
> +	if (c_can_get_tx_free(priv, tx_ring)) {
>   		/* Make sure that anybody stopping the queue after
>   		 * this sees the new tx_ring->tail.
>   		 */
> @@ -760,8 +760,7 @@ static void c_can_do_tx(struct net_device *dev)
>   	stats->tx_packets += pkts;
>   
>   	tail = c_can_get_tx_tail(tx_ring);
> -
> -	if (tail == 0) {
> +	if (priv->type == BOSCH_D_CAN && tail == 0) {
>   		u8 head = c_can_get_tx_head(tx_ring);
>   
>   		/* Start transmission for all cached messages */

Thanks for looking into the issue.

Perhaps not too surprising, but I'm testing with this patch and 
everything looks good sofar, ~20 minutes into testing. I will leave it 
running overnight to be sure.

Thanks,
Jacob
