Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F77B536B5E
	for <lists+linux-can@lfdr.de>; Sat, 28 May 2022 09:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiE1Heo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 28 May 2022 03:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiE1Hej (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 28 May 2022 03:34:39 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6513327B02
        for <linux-can@vger.kernel.org>; Sat, 28 May 2022 00:34:38 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x2so1029245ljd.2
        for <linux-can@vger.kernel.org>; Sat, 28 May 2022 00:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=ePMiwdznKuL/1LiEbFemCYK7m9HSy56ettCK3qVn2dw=;
        b=J9HbMUrZcHWMAgLZDSrfLRbuzUUYGqOQ0gA9eTxL7nCCaC0EgM0+bBRAPccMYtQCVK
         74TJRHzCZgPrDuQjtPgXCYS3slqj1JAqRug3vwK2OT3l/JbpKVvqV/PSt5+WWeuu/Qs4
         qJeK7YbNA7eRdo19mWVC42jRhdMUtdcZKUUdY7roJbfFz+/feLimkIlfLEVkDBNGgRFx
         Ns0FrjRMZfRBHl4psUtRtvcr8r3AOyFvkU7sr3cpJ+5mRKrTMl4wDshvMSw3noouZF4v
         o7L1aelntWzQ8SO765Dy9tE/x00wrVnu+9t+Zlv0DvRPrSsZnsef6+rZluS9Ehiomf+Z
         aKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=ePMiwdznKuL/1LiEbFemCYK7m9HSy56ettCK3qVn2dw=;
        b=cldgMxZgiIrYekbBlBTOx6V9A8Rf54dlPV53S9Wvmgv3QeEZDHJ3AT1C7kBjcHinPk
         DXtvveCeWZ/hcgPI/uBVAkUOTvAS2ZX1EJJ7qQK1uL/baJkLt8hf43jpwkjm8KJ+v/qO
         ndQ+qeBc0vFUe7GvMBw1x2u0kIMC4E7L7cMWv98zE/a3ulkRllyUJNCG6TktYZPf0Hum
         uLJl1pex8Ka7n5/TBEdoAmgkLVLjWhxRpyGDGD+SuGBZF89itqWbmYgWj+Lw4LGwNEpj
         8JEW5hFT37UcT2w71wMxZt5WwSdsoZNxCJqsVxvVPQmwMRnzQTi1CiG8w3H8k7j8OzR7
         5AWA==
X-Gm-Message-State: AOAM532vkDl7roHMrnc2f6L80reKoSj4ag407WCphrXGj1+IAUes0ijY
        ZxsaEH6XJYdMFVSKtHtjRRUyGg==
X-Google-Smtp-Source: ABdhPJyXMMmFwV4S0d+momqzLdkJW5J7YiUoERQ63Y5Qy6n83GtmHUhJ2C5BzbSXkF1G66DospBc0A==
X-Received: by 2002:a2e:bc19:0:b0:253:ee6d:7abf with SMTP id b25-20020a2ebc19000000b00253ee6d7abfmr16009268ljf.448.1653723276647;
        Sat, 28 May 2022 00:34:36 -0700 (PDT)
Received: from [192.168.16.143] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id o8-20020a056512050800b004744bfd620fsm1204621lfb.236.2022.05.28.00.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 00:34:36 -0700 (PDT)
Message-ID: <096c5828-2b86-d689-e1cb-ba7de8abbf6f@kvaser.com>
Date:   Sat, 28 May 2022 09:34:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH 02/12] can: kvaser_usb: Fix use of uninitialized
 completion
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
 <20220516134748.3724796-3-anssi.hannula@bitwise.fi>
Content-Language: en-US
In-Reply-To: <20220516134748.3724796-3-anssi.hannula@bitwise.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 5/16/22 15:47, Anssi Hannula wrote:
> flush_comp is initialized when CMD_FLUSH_QUEUE is sent to the device and
> completed when the device sends CMD_FLUSH_QUEUE_RESP.
> 
> This causes completion of uninitialized completion if the device sends
> CMD_FLUSH_QUEUE_RESP before CMD_FLUSH_QUEUE is ever sent (e.g. as a
> response to a flush by a previously bound driver, or a misbehaving
> device).
> 
> Fix that by initializing flush_comp in kvaser_usb_init_one() like the
> other completions.
> 
> This issue is only triggerable after RX URBs have been set up, i.e. the
> interface has been opened at least once.
> 
> Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>

Looks good to me.
Tested-by: Jimmy Assarsson <extja@kvaser.com>


> ---
>   drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  | 1 +
>   drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> index e67658b53d02..47bff40c36b6 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> @@ -673,6 +673,7 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev,
>   	init_usb_anchor(&priv->tx_submitted);
>   	init_completion(&priv->start_comp);
>   	init_completion(&priv->stop_comp);
> +	init_completion(&priv->flush_comp);
>   	priv->can.ctrlmode_supported = 0;
>   
>   	priv->dev = dev;
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index a26823c5b62a..4e90a4b7f95a 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -1910,7 +1910,7 @@ static int kvaser_usb_hydra_flush_queue(struct kvaser_usb_net_priv *priv)
>   {
>   	int err;
>   
> -	init_completion(&priv->flush_comp);
> +	reinit_completion(&priv->flush_comp);
>   
>   	err = kvaser_usb_hydra_send_simple_cmd(priv->dev, CMD_FLUSH_QUEUE,
>   					       priv->channel);
