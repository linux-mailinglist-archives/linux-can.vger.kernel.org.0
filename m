Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9686704E7A
	for <lists+linux-can@lfdr.de>; Tue, 16 May 2023 15:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjEPNBI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 May 2023 09:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjEPNBG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 May 2023 09:01:06 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572A83AB1
        for <linux-can@vger.kernel.org>; Tue, 16 May 2023 06:01:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f00d41df22so4243476e87.1
        for <linux-can@vger.kernel.org>; Tue, 16 May 2023 06:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684242060; x=1686834060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLrdjhlmtGafeaYWv0dVakAGfOhbyuXhLBJ6ZpXGY5w=;
        b=drdFiMykbkydw6ax0+H/dlaJE+9mV9PIXqlHr/bYTdd9WtBiktPZ5WJDu3iDBSJvaJ
         VXkZhKjl6fS0gOGMaMsgHWRvkxp/ymlTO2feYO9uZPQOzwkzIpLp32ljcs9RqWmuCmvH
         jOFFL6P4rqVm7BtyI6QvyECG05DeDC4pBZuxb0HZUzh80O9xPMPi0qo9pwsifZUyDwr8
         YwV/+Q/IedolG6BS9/2X52H+0PmHXEdziQTaTvrtwq4O1CKsA3bL/FdFDm+zn9+8C2K5
         uUO3mKUnnVKY9HonNwHfjr27gROmmQ6X13FZnXHm9v8c9XOEqFVpdMyMcViIiAjTxZAE
         AnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684242060; x=1686834060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLrdjhlmtGafeaYWv0dVakAGfOhbyuXhLBJ6ZpXGY5w=;
        b=ND1iIfpbHGzte22LJSyQDQGMVecvHyh+T+4SbqaJe9Q0rnaEusBEJuhHSE8wKdy+un
         6AVoNr9/8K1ftWm2deLPZrees5rD6p6figYOSSTNePMEEAkUKSHwCfN6DJKq+pQxoGLa
         K/0rn4CA/pXWD1MoBv3OMVDeTOaGGmBEpLqh8vyTB6I4kFjTNjHCqNQhZ+Fco9rhPFE6
         7INaboWxSdsPN1yM/fVnFeEA0slnLPMX09bDpctAnhFvrzGQqMfrXtlxy7K7dXzAuo9o
         IFjL4phLaOFiQ8pfVAdbES/sJCop1ndB8/Svz1hY65lfm62ri2hY6YT+CBREPh9vFEEV
         x6bA==
X-Gm-Message-State: AC+VfDwzGeXL/aKcg+ipeYXDzenxojQmoPwLlVUw2oyQexbH9Jpdh86k
        /NqPg4mTCsKRHq6enk6IowiZ/g==
X-Google-Smtp-Source: ACHHUZ7S7VffUxYVzM+pTmxj6kKpgUyvq6z+elDJvWckL1CFoGlAUT2AJCfnTv4Pfvij9ZI71AMd7Q==
X-Received: by 2002:a2e:9643:0:b0:2a8:ccd3:4c40 with SMTP id z3-20020a2e9643000000b002a8ccd34c40mr7269121ljh.13.1684242060566;
        Tue, 16 May 2023 06:01:00 -0700 (PDT)
Received: from [192.168.16.142] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id p21-20020a2e8055000000b002ad8cbb7349sm3636223ljg.98.2023.05.16.06.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 06:00:59 -0700 (PDT)
Message-ID: <d9a7667c-8a0a-bdb3-532f-0b9e686dac74@kvaser.com>
Date:   Tue, 16 May 2023 15:00:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] can: kvaser_usb_leaf: Implement CAN 2.0 raw DLC
 functionality.
To:     Carsten Schmidt <carsten.schmidt-achim@t-online.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org
References: <20230506105529.4023-1-carsten.schmidt-achim@t-online.de>
 <7e25ba42-4aa9-0d88-e708-18462bc7cc48@hartkopp.net>
 <d4eb5d98-f62b-be58-58fb-9e9736d476bd@kvaser.com>
 <a81e55c3-66b9-1f84-b1a3-dd5184478da3@kvaser.com>
 <645E8D12.5060901@t-online.de>
Content-Language: en-US
From:   Jimmy Assarsson <extja@kvaser.com>
In-Reply-To: <645E8D12.5060901@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 5/12/23 21:01, Carsten Schmidt wrote:
> Hello Jimmy,

Hi Carsten,

> yes, please do make a v2 patch!

Now I've sent an updated patch:
https://lore.kernel.org/linux-can/20230516125332.82894-1-extja@kvaser.com

> As this is my first patch, I am very thankful for any support to get
> the work into the main kernel! Thank you!

Ahh, nice :)
And again, thanks for this patch!

Best regards,
jimmy

> @Oliver: Thanx for the encouragement and guidance with the patch!
> 
> Sincerely,
> Carsten
> 
> 
> 
> Am 11.05.2023 um 17:42 schrieb Jimmy Assarsson:
>> On 2023-05-08 18:40, Jimmy Assarsson wrote:
>>> Hi Carsten,
>>> Hi Oliver,
>>>
>>> On 5/6/23 21:10, Oliver Hartkopp wrote:
>>>> Thanks for your patch Carsten!
>>>>
>>>> There should be at least one sentence in the commit message even when
>>>> the subject almost covers the story ;-)
>>>
>>> @Carsten, thanks for the patch!
>>>
>>> Acked-by: Jimmy Assarsson <extja@kvaser.com>
>>> Tested-by: Jimmy Assarsson <extja@kvaser.com>
>>>
>>>> Can you also please change the subject to
>>>>
>>>> can: kvaser_usb: add len8_dlc support for kvaser_usb_leaf
>>>>
>>>> to follow up with the other len8_dlc patches?
>>>>
>>>> @Jimmy: AFAIK Carsten only has a Kvaser USB Leaf for testing. Can you
>>>> probably provide and test a similar improvement for the Kvaser USB
>>>> Hydra hardware?
>>>
>>>
>>> @Oliver, yes, I'll fix this for the remaining Kvaser USB devices.
>>> I'll try to send a patch for it by the end of the week.
>>>
>>> Best regards,
>>> jimmy
>>
>> Hi Carsten,
>>
>> I've implemented cc-len8-dlc support for the Kvaser USB Hydra devices.
>> Is it OK if I add my changes to your patch, and send it is as a V2?
>>
>> Best regards,
>> jimmy
>>
>>>> Many thanks,
>>>> Oliver
