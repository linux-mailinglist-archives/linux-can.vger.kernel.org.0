Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A4A5BD835
	for <lists+linux-can@lfdr.de>; Tue, 20 Sep 2022 01:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiISXYL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Sep 2022 19:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiISXYJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Sep 2022 19:24:09 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C83260DF
        for <linux-can@vger.kernel.org>; Mon, 19 Sep 2022 16:24:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id s6so976494lfo.7
        for <linux-can@vger.kernel.org>; Mon, 19 Sep 2022 16:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date;
        bh=Llq6Mkmv5J/ZpQjc/12XhFOnxxk0SFYaOCf0A/S+7zQ=;
        b=qELyURhuBon4UJWvRxMoZtTcgEAFp34cXupvE+VPeuOdEQmKcFY2dEPlCq65NZB8SD
         VJA7o35gS4wtAlMpZVq0QaU54BjJZlqkNXHrzWmjuUPR7UYJGKq4/O5LaMukHUwHZghY
         xURo7SaddTzbnHCUkO4vBaSPRzp9BlVt8mxRurkFVGRgQAQOrjwdxc0yMFSmj4u5yMT4
         VuxLePZfVBKEMyZ1cPfu78AklajAP+0f3uRqbRxKD3Ge7jh8oyU8Yk4i125pdNhHApXf
         TYdPSRTZ1VSco5ctluFY4bWDOrzT20vSY6GP98Rs6cK90VuSoTLK9cu/zia8fZVz431l
         lNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Llq6Mkmv5J/ZpQjc/12XhFOnxxk0SFYaOCf0A/S+7zQ=;
        b=IqG61rjEkVrWmyRPgpQy7mKKXGkiS/1w8LUi1at0LVS0nRAlWpawjpGg6bQ/4X85Q8
         qS0A/OpFrItaxl0DV/8HuYgfpKTA2/UO3qkPzazUtDTzNcPRaferLjZd3ctnEi3DF+sX
         ZjHZCU2vonSd5d9Fd/HAsIBisSOLP/GgKpiqpGO11+NzPVXkJwA+6ONZeP30EEk4WIke
         AsEN5DokAkFPUm9I6bGFMrTQcr9xmcaXQX0viDr/6yiQzyVFSk7KMbELGL0SuvSA+l/2
         U4oZsjFa6EPUOJKC1WB/fAGoHb/pkyhIq/C8tmFvu8t9pQD6nV9IKdc3PSCih4fvebqC
         az3A==
X-Gm-Message-State: ACrzQf3/y+gTH/tUTtY7WKLcYBwDGJh0AICcUI5PircsYgpD1nm1rMZF
        DLDaUku6LRmzQJTz282oj/Lbhp7ssLEMgQ==
X-Google-Smtp-Source: AMsMyM7oTdHT9ToOUJmbuuGJsc3NGzi9SBfCKB1wZLOj5f+drZ45D/WMBa66+bQwmIcOvRQIPeRXzw==
X-Received: by 2002:a05:6512:22d2:b0:49e:19a6:a304 with SMTP id g18-20020a05651222d200b0049e19a6a304mr6704013lfu.561.1663629846609;
        Mon, 19 Sep 2022 16:24:06 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id y11-20020a05651c106b00b0026c3e350682sm1634342ljm.14.2022.09.19.16.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 16:24:05 -0700 (PDT)
Message-ID: <02aeeca7-5958-60f1-3011-fa3aae4ef6b5@gmail.com>
Date:   Tue, 20 Sep 2022 01:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
From:   Jacob Kroon <jacob.kroon@gmail.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, dariobin@libero.it
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
 <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
 <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
 <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
Content-Language: en-US
In-Reply-To: <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc and Dario,

On 9/16/22 06:14, Jacob Kroon wrote:
...> What I do know is that if I revert commit:
> 
> "can: c_can: cache frames to operate as a true FIFO"
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=387da6bc7a826cc6d532b1c0002b7c7513238d5f
> 
> then everything looks good. I don't get any BUG messages, and the host 
> has been running overnight without problems, so it seems to have fixed 
> the network interface lockup as well.

I ran the kernel *with* the commit above, and also with the following patch:

> diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
> index 52671d1ea17d..4375dc70e21f 100644
> --- a/drivers/net/can/c_can/c_can_main.c
> +++ b/drivers/net/can/c_can/c_can_main.c
> @@ -1,3 +1,4 @@
> +#define DEBUG
>  /*
>   * CAN bus driver for Bosch C_CAN controller
>   *
> @@ -469,8 +470,15 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
>  	if (c_can_get_tx_free(tx_ring) == 0)
>  		netif_stop_queue(dev);
>  
> -	if (idx < c_can_get_tx_tail(tx_ring))
> +	netdev_dbg(dev, "JAKR:%d:%d:%d:%d\n", idx,
> +	                                      c_can_get_tx_head(tx_ring),
> +	                                      c_can_get_tx_tail(tx_ring),
> +	                                      c_can_get_tx_free(tx_ring));
> +
> +	if (idx < c_can_get_tx_tail(tx_ring)) {
>  		cmd &= ~IF_COMM_TXRQST; /* Cache the message */
> +		netdev_dbg(dev, "JAKR:Caching messages\n");
> +	}
>  
>  	/* Store the message in the interface so we can call
>  	 * can_put_echo_skb(). We must do this before we enable

and I've uploaded the entire log I could capture from /dev/kmsg, right 
up to the hang, here:

https://pastebin.com/6hvAcPc9

What looks odd to me right from the start is that sometimes when idx 
rolls over to 0, and *only* when it rolls over to 0, the CAN frame gets 
cached because "idx < c_can_get_tx_tail(tx_ring)".

Is it possible there is some difference between c_can and d_can in how 
the HW buffers are working, which breaks the driver on my particular HW 
setup ?

Regards,
Jacob
