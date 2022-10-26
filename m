Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485CD60E6F2
	for <lists+linux-can@lfdr.de>; Wed, 26 Oct 2022 20:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJZSEp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Oct 2022 14:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiJZSEo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Oct 2022 14:04:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB52205E4
        for <linux-can@vger.kernel.org>; Wed, 26 Oct 2022 11:04:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bp15so30276726lfb.13
        for <linux-can@vger.kernel.org>; Wed, 26 Oct 2022 11:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Q8kGhOrDwBQ2oN4a2TtKVwW3Xfh65pTBvHD/KcWiLg=;
        b=DMxk1c1WBU4T8kx15P5M4Ztmhoxm2KPG4mc6QqTkXS+zIQmI975sXHujCmj4GjF2Ip
         L+M1Y5im3itb5OlcOpXFhyttbm2v6WFsJssW64QeE/YM2qDorR3kyrDr/S9nFP6jM5qU
         urhdwY9PmDKAMlllqjq40z/505YPFNgNmPnCQP/a0tF5/jpUpjTRdR2Gi84bPzCLzju3
         jeIg6tBR3GeUzWDPwwWROmzdr2qTjjVRDU1h3UD1VN9OQXKOPKAQvGo0bdFEktKE7V78
         EDOh+FqHmDfC0+Am+cLj+qLY4W6zqwi43jehb4cQaUt5irFu52VmUM2dqi16EXoQ1XWC
         UjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q8kGhOrDwBQ2oN4a2TtKVwW3Xfh65pTBvHD/KcWiLg=;
        b=fWGqKfvfQBQ3x7ycYYFqYC6L7yn946PLqx6TTfZ0tJqTB59a1h+c/FKWBb57Gu2L6c
         4/EDmIqE3AK9TOtjNA7g5g4mnL8E5vOQoW/GaKXBknh8g1boXAOahxJ+P307E/nj3l7M
         TsHyoiSRVQdo/2R455Z4cMkiYIPDB0zoexlLm8/F0udK5iK9v7OO6W76QNDUSrifb+di
         0M4aVSAICuRPevMPkjS1KJly461jFQn1rn86SkZYXJBOdKsCllkiFWvqzOhJhLGl27zO
         fogFCDX5QZNKZ55cL2rrQnd5JX0NWtWKjW9OTEHGrjI/lERV/Q07vs+BSVoKSp4y1czY
         4+3g==
X-Gm-Message-State: ACrzQf0q3Zs6DXrB57/OMcjYSAIhHw5BUT5T00aeTLm9RPGrHxd58fX9
        XwkmUrTo3UBEHfx7teGgFlc=
X-Google-Smtp-Source: AMsMyM5pm9AQjeMIPJsnh4Q0oDJVpUb9yrgu7WClah3Y1alEA8TxguaukxcwT8j4sab1h/jBPl3/eQ==
X-Received: by 2002:ac2:5616:0:b0:4a2:61f6:85e9 with SMTP id v22-20020ac25616000000b004a261f685e9mr15930031lfd.419.1666807481187;
        Wed, 26 Oct 2022 11:04:41 -0700 (PDT)
Received: from [192.168.16.196] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.googlemail.com with ESMTPSA id j5-20020a056512344500b00494a603953dsm925484lfr.89.2022.10.26.11.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 11:04:40 -0700 (PDT)
Message-ID: <f53a9afa-42fa-73b0-4dfa-f1684bacf63e@gmail.com>
Date:   Wed, 26 Oct 2022 20:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH can-next v5 01/11] can: kvaser_usb: Fix possible
 completions during init_completion
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Anssi Hannula <anssi.hannula@bitwise.fi>,
        Jimmy Assarsson <extja@kvaser.com>
References: <20221010185237.319219-1-extja@kvaser.com>
 <20221010185237.319219-2-extja@kvaser.com>
 <20221026081432.5lrzl5tkcfp7gzxj@pengutronix.de>
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
In-Reply-To: <20221026081432.5lrzl5tkcfp7gzxj@pengutronix.de>
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

On 10/26/22 10:14, Marc Kleine-Budde wrote:
> On 10.10.2022 20:52:27, Jimmy Assarsson wrote:
>> From: Anssi Hannula <anssi.hannula@bitwise.fi>
>>
>> kvaser_usb uses completions to signal when a response event is received
>> for outgoing commands.
>>
>> However, it uses init_completion() to reinitialize the start_comp and
>> stop_comp completions before sending the start/stop commands.
>>
>> In case the device sends the corresponding response just before the
>> actual command is sent, complete() may be called concurrently with
>> init_completion() which is not safe.
>>
>> This might be triggerable even with a properly functioning device by
>> stopping the interface (CMD_STOP_CHIP) just after it goes bus-off (which
>> also causes the driver to send CMD_STOP_CHIP when restart-ms is off),
>> but that was not tested.
>>
>> Fix the issue by using reinit_completion() instead.
> 
> Looks like this should go to net instead of net-next.

Yes, I agree.

Thanks!

/jimmy


> Marc
