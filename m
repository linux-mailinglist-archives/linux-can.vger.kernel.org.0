Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05E55E7BDD
	for <lists+linux-can@lfdr.de>; Fri, 23 Sep 2022 15:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiIWNaM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Sep 2022 09:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiIWN3q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Sep 2022 09:29:46 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C151E3C2
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 06:29:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j16so320977lfg.1
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date;
        bh=IWljh+63OYTrsua26Qq5c4L/fhQ8/rw3TWM3S4kRPAg=;
        b=cWEG5VOkx/7Rh+fSf6t1Rhdn6HOZP0hDG5YinEh4SI5j2LP6Mmegk0V1JpelFyV+7n
         301lHMdw56CIdbvjStj3mjPW+hxBMhUzlOXzxzSIG90g01tMWai/OJB3skhPneGCPlOB
         nunt9fiEK7ZMSazc/fEo8cXA1ZAaP6XE/cmnPPr44oWquIwfgQdZbvdI7SEcibxVFIDe
         +DPB/1nr99Am3z/dauPKqGaHdnp3xR3ZYlcT2ME05Cztmpiga3kATnDkSkD0bDrXcAuU
         T7+p5vxaaQ0eQLERRirQOu7ap095mpcOiauuiq9UJnipStYYawfIPZW20aQutXxBzdmD
         WLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IWljh+63OYTrsua26Qq5c4L/fhQ8/rw3TWM3S4kRPAg=;
        b=6AxFX5PHBeCQI69KQ8zqDwo8JR6aTJUT6PkxxkaW10iJcaxlKAQF9/k9+T9QleK/IL
         P2C8ZL9uzGXWa71SUs7tSuueTltfjMl5oabxPn5NnozXScgYvduDOfkKAXCRx7+5516c
         xLF1yMUDSnRiSvJ6wGgpB9ckojo68gsxgsYdRzhfh9g7k37Qq/0BOSYuGYPXOOuHZqhc
         atYdVk+UYv7xfOQtyF0vnK3B9UjsFCt0/n7Twm/TJSpsSu70x+Hcf32r4bLrKvTqNgkZ
         5S+Yx6+dw5BXaY/iA1HzdyQY0YP1DFMRN4tmTDUwIlhLJWtmWSoCrSm65Xl8sbQYReFq
         PugA==
X-Gm-Message-State: ACrzQf2bb8ifOz/s1NPI1ZGfvNxe1djpJcaWeEffLZzRCyBttu5e5Gs+
        CQ4aKjXPCeHeV66NGnmSSJW4iQDhEACspQ==
X-Google-Smtp-Source: AMsMyM42t5kqZnIoNgksq2je4YQB/hRRP2pBEg9i92vdevXjLw/FZV8ZK4DpcXxZU7kh+qoKM3F1Kw==
X-Received: by 2002:a05:6512:2308:b0:497:a290:cef6 with SMTP id o8-20020a056512230800b00497a290cef6mr3383604lfu.488.1663939782190;
        Fri, 23 Sep 2022 06:29:42 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id s7-20020a056512314700b0048b0696d0b1sm1458020lfi.90.2022.09.23.06.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 06:29:41 -0700 (PDT)
Message-ID: <2bfef6e8-f684-7e67-59f6-0c3a429abae4@gmail.com>
Date:   Fri, 23 Sep 2022 15:29:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RFC] can: c_can: wake TX queue after kicking TX of cached
 CAN frames
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20220923113821.718486-1-mkl@pengutronix.de>
Content-Language: en-US
From:   Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <20220923113821.718486-1-mkl@pengutronix.de>
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

On 9/23/22 13:38, Marc Kleine-Budde wrote:
> Link: https://lore.kernel.org/all/15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com
> Reported-by: Jacob Kroon <jacob.kroon@gmail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   drivers/net/can/c_can/c_can_main.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
> index dc8132862f33..fcf71c1f3b72 100644
> --- a/drivers/net/can/c_can/c_can_main.c
> +++ b/drivers/net/can/c_can/c_can_main.c
> @@ -748,19 +748,8 @@ static void c_can_do_tx(struct net_device *dev)
>   		return;
>   
>   	tx_ring->tail += pkts;
> -	if (c_can_get_tx_free(tx_ring)) {
> -		/* Make sure that anybody stopping the queue after
> -		 * this sees the new tx_ring->tail.
> -		 */
> -		smp_mb();
> -		netif_wake_queue(priv->dev);
> -	}
> -
> -	stats->tx_bytes += bytes;
> -	stats->tx_packets += pkts;
>   
>   	tail = c_can_get_tx_tail(tx_ring);
> -
>   	if (tail == 0) {
>   		u8 head = c_can_get_tx_head(tx_ring);
>   
> @@ -770,6 +759,17 @@ static void c_can_do_tx(struct net_device *dev)
>   			c_can_object_put(dev, IF_NAPI, obj, IF_COMM_TXRQST);
>   		}
>   	}
> +
> +	if (c_can_get_tx_free(tx_ring)) {
> +		/* Make sure that anybody stopping the queue after
> +		 * this sees the new tx_ring->tail.
> +		 */
> +		smp_mb();
> +		netif_wake_queue(priv->dev);
> +	}
> +
> +	stats->tx_bytes += bytes;
> +	stats->tx_packets += pkts;
>   }
>   
>   /* If we have a gap in the pending bits, that means we either

I tested this patch but unfortunately I got the network lockup after a 
couple of minutes.

Jacob
