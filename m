Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D325E8249
	for <lists+linux-can@lfdr.de>; Fri, 23 Sep 2022 21:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiIWTDW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Sep 2022 15:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiIWTDV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Sep 2022 15:03:21 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FC8124142
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 12:03:20 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d42so1773228lfv.0
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 12:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=sJSKl+Cujzht2LprnU9wboW4I6MuQOsFwlp0kJu7eTI=;
        b=KYybN1rtjxVAQimQxowq7aiw79ZIRxvXvBUmr3k3uwnVlCMx8h6LYKb4D1VtswcRBS
         aEeJa5YLy3hJDF8CRJby7YpfQRnjz/BG/r5IJV0OQoXvRXQiCpSubLmyiIyEK9DGxkRq
         HTU4Ty9e/3xzQVLipYusUUyCzeWt4sR81jQ4SbvnuEdYlvfN8SAo5iJVq8L1Lb5w4i2X
         Ff4HL8CWH3Kp/ivx+bAzyvgcnk0i+pwk3K+zYalwipOCeeTc2S3AbcBDeMvupH+F4am/
         iuhJoL25XbxMpA5PTvvxbvUcdPP46vA0ZzG74q36mYGPs4sM15BDS/UH1PzcpjfhrvIc
         GFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sJSKl+Cujzht2LprnU9wboW4I6MuQOsFwlp0kJu7eTI=;
        b=RaI8cCeHrVKDGDoj9MesAUEsSymuumVGh+Xcf5eQT9tkwHS+J62oFMVDA8u9x5HfhO
         l8J+7CaqplYs7EBWilDsAvjbA8nT9LMmjxqexQ1JtEvK2s9a15T3GWVyev7y8He01/kC
         t+XkfHwP5jRg84K623+vECkle1sjaH65ykHznifxIch1yq2GkMAUkDKmpVZETr7/rTZS
         YnvT3PNbHIKK/cPvuERwPoX3a21I3aJYYb/5t7jd6DPdghLBmUM5ybOvGGjNFPbUdkkT
         At2FZ2vwTs3Am+eldJNEXkIckoMEwhb+w6PxsiAIVQsK+9is9Zr4VoAM5lYoVEHtzrDn
         tXiA==
X-Gm-Message-State: ACrzQf3sndIRTvg7GyhDlC1mk8KgHvfhkpat2SE5hlXbfrhToKXLYMAf
        PDNeC1sA/Q2CCwbvUeArEDA=
X-Google-Smtp-Source: AMsMyM7q8kGYp/0MMCFcr93rZubsMVcgYzRqJ08R3z6WhRaSdTvSAJ3iwzBYi4Q+9mitRtXx3kPIMQ==
X-Received: by 2002:a05:6512:b8d:b0:49f:59db:62ec with SMTP id b13-20020a0565120b8d00b0049f59db62ecmr3572355lfv.566.1663959798145;
        Fri, 23 Sep 2022 12:03:18 -0700 (PDT)
Received: from [192.168.10.124] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id s9-20020a056512202900b00494b2d8030fsm1561903lfs.177.2022.09.23.12.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 12:03:17 -0700 (PDT)
Message-ID: <a162f149-58ba-24eb-474f-294b9fe78e51@gmail.com>
Date:   Fri, 23 Sep 2022 21:03:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
To:     dariobin@libero.it, Marc Kleine-Budde <mkl@pengutronix.de>
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
 <20220923113638.tjnbuvkzdq24c4as@pengutronix.de>
 <36690382.801104.1663955706569@mail1.libero.it>
Content-Language: en-US
From:   Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <36690382.801104.1663955706569@mail1.libero.it>
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

Hi Dario,

On 9/23/22 19:55, dariobin@libero.it wrote:
> Hi Michael,
> 
>> Il 23/09/2022 13:36 Marc Kleine-Budde <mkl@pengutronix.de> ha scritto:
>>
>>   
>> On 16.09.2022 06:14:58, Jacob Kroon wrote:
>>> What I do know is that if I revert commit:
>>>
>>> "can: c_can: cache frames to operate as a true FIFO"
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=387da6bc7a826cc6d532b1c0002b7c7513238d5f
>>>
>>> then everything looks good. I don't get any BUG messages, and the host
>>> has been running overnight without problems, so it seems to have fixed
>>> the network interface lockup as well.
>>
>> Jacob, after this mail, I'll send 2 patches. One tries to disable the
>> cache feature for C_CAN cores, the other shuts a potential race window.
> 
> About the "can: c_can: don't cache TX messages for C_CAN cores" patch:
> Could it make sense to change the c_can_start_xmit in this way
> 
> -       if (idx < c_can_get_tx_tail(tx_ring))
> -               cmd &= ~IF_COMM_TXRQST; /* Cache the message */
> +       if (idx < c_can_get_tx_tail(tx_ring)) {
> +               if (priv->type == BOSCH_D_CAN) {
> +                       cmd &= ~IF_COMM_TXRQST; /* Cache the message */
> +               } else {
> +                       netif_stop_queue(priv->dev);
> +                       return NETDEV_TX_BUSY;
> +               }
> +       }
> 
> without changing the c_can_get_tx_{free,busy} routines ?
> 

I can test, so you suggest only doing the above patch, or were there 
other parts from Marc's patch you wanted in ?

Jacob
