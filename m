Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2CD536B67
	for <lists+linux-can@lfdr.de>; Sat, 28 May 2022 09:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiE1Hg4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 28 May 2022 03:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355858AbiE1HfC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 28 May 2022 03:35:02 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2A728E33
        for <linux-can@vger.kernel.org>; Sat, 28 May 2022 00:35:00 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v9so6952584lja.12
        for <linux-can@vger.kernel.org>; Sat, 28 May 2022 00:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=c3MdsQSjJrPPj5zwgdhUCesRP5ZIKNwaLgoiq64qu18=;
        b=u4jKqjTs3xxMoVtSwVmYtMLeelLyGfYn9dnlxKomISRpkKTbMjE6NQSC0XaITAgocR
         f8sBFku5EizCFOCxtn+RaDvG/hW85y1/X/0fo1B0K3WJZicZg3rsuC6N7SsUUicjfCcS
         V2HnwA/vaI11zrv2vltBDsyUZ4euUrxw5icGWdFtPxqkbCGncShYyFGFXgo8U8IJFTsR
         pSX9DDCEhtv2rvnvt8Tv7/dwZpenPmGySTQ7OZyemorL7Nabc8QRC6eoYkcJxQqmf1mG
         CjQEUmI4grFidJU5hyK74T4/wNhgazEWy4x/9k0+KR6g3nsWrGtRnAasf3Qnnxkri2Tl
         G9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=c3MdsQSjJrPPj5zwgdhUCesRP5ZIKNwaLgoiq64qu18=;
        b=apdFIcBzGGOayHtnwFOdc/OJXeL+kf3Ui33f4WQIezaUvRXVaRMZkaEER+G3tP/+Pc
         PQoaJfhDzMrxh2VX6Hc8r/rKL9A+9yEBn/YD61HyrTUpTvEkyXNCfpz6DIkDTnK6vqD0
         LGQV6J1OpSvyxcyhCgiLUPr47dJ2IMLSvimWea+rek5pxUwvZ0FiSqh+S+Wc6XVl1qjO
         C7461nr0qGc6Tw0f6MitqvZ/M/mOieYNtz9z1W+ebiv/OEIrhFicGHJQyVkUjg5GbHTP
         GLwFEgNXtuBNGbI+emv9QOk8Q/aliISew70EmPX/+oW994fuzEC4Z9xSp5FlfUuCsCEt
         iqIQ==
X-Gm-Message-State: AOAM532gMwDjfySnKewgVUcRO4bWdNu+vP3Bn23RFLujwQ7wjzuXv6ff
        jyitnWH1cxddP5t5fxmfPnGlFw==
X-Google-Smtp-Source: ABdhPJyK3fvzaN3rlWbayVR7pyD3yq8Znio+4B6lnPjvIvSTsQAB38Qo4Y/6P06gKaWIA8M3kqV9/w==
X-Received: by 2002:a2e:b88a:0:b0:253:e7f5:c0e9 with SMTP id r10-20020a2eb88a000000b00253e7f5c0e9mr18168014ljp.38.1653723298775;
        Sat, 28 May 2022 00:34:58 -0700 (PDT)
Received: from [192.168.16.143] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id k18-20020a05651239d200b0047255d21143sm1208735lfu.114.2022.05.28.00.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 00:34:58 -0700 (PDT)
Message-ID: <99dc6953-b300-36a6-32cb-52edb289ca57@kvaser.com>
Date:   Sat, 28 May 2022 09:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH 12/12] can: kvaser_usb_leaf: Fix bogus restart events
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
 <20220516134748.3724796-13-anssi.hannula@bitwise.fi>
Content-Language: en-US
In-Reply-To: <20220516134748.3724796-13-anssi.hannula@bitwise.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 5/16/22 15:47, Anssi Hannula wrote:
> When auto-restart is enabled, the kvaser_usb_leaf driver considers
> transition from any state >= CAN_STATE_BUS_OFF as a bus-off recovery
> event (restart).
> 
> However, these events may occur at interface startup time before
> kvaser_usb_open() has set the state to CAN_STATE_ERROR_ACTIVE, causing
> restarts counter to increase and CAN_ERR_RESTARTED to be sent despite no
> actual restart having occurred.
> 
> Fix that by making the auto-restart condition checks more strict so that
> they only trigger when the interface was actually in the BUS_OFF state.
> 
> Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>

Looks good to me.
Tested-by: Jimmy Assarsson <extja@kvaser.com>

> ---
>   drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index 4125074c7066..b280d315673f 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -735,7 +735,7 @@ static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
>   	context = &priv->tx_contexts[tid % dev->max_tx_urbs];
>   
>   	/* Sometimes the state change doesn't come after a bus-off event */
> -	if (priv->can.restart_ms && priv->can.state >= CAN_STATE_BUS_OFF) {
> +	if (priv->can.restart_ms && priv->can.state == CAN_STATE_BUS_OFF) {
>   		struct sk_buff *skb;
>   		struct can_frame *cf;
>   
> @@ -852,7 +852,7 @@ kvaser_usb_leaf_rx_error_update_can_state(struct kvaser_usb_net_priv *priv,
>   	}
>   
>   	if (priv->can.restart_ms &&
> -	    cur_state >= CAN_STATE_BUS_OFF &&
> +	    cur_state == CAN_STATE_BUS_OFF &&
>   	    new_state < CAN_STATE_BUS_OFF)
>   		priv->can.can_stats.restarts++;
>   
> @@ -945,7 +945,7 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
>   		}
>   
>   		if (priv->can.restart_ms &&
> -		    old_state >= CAN_STATE_BUS_OFF &&
> +		    old_state == CAN_STATE_BUS_OFF &&
>   		    new_state < CAN_STATE_BUS_OFF) {
>   			cf->can_id |= CAN_ERR_RESTARTED;
>   			netif_carrier_on(priv->netdev);
