Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACF970EF98
	for <lists+linux-can@lfdr.de>; Wed, 24 May 2023 09:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjEXHkO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 24 May 2023 03:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbjEXHkN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 May 2023 03:40:13 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CED490
        for <linux-can@vger.kernel.org>; Wed, 24 May 2023 00:40:11 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b03d3e41fcso17852191fa.0
        for <linux-can@vger.kernel.org>; Wed, 24 May 2023 00:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684914009; x=1687506009;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPEoHWWWFcR8ugYvJb1slJS1oYz2dG1SRLSh7TBkM5w=;
        b=kvl0r0/EK5/IRVKEzcd6S6U72sgKZcE6Rr5+bW4uCVlWxPa0jdsTuNVSam4Ut3WOgn
         0NvtKFO6o+idYHg33L4QSRNJUAI59GEeCoRS/3UCkCQ2rcH+qd1mV30F5Z/xY2mzGUZn
         iJ4kG1KwGQEO3Kpqx2cB/7EmMuYZynpBunnwnDOuxerLKMVt3uPOC81GIoC19AMbToOx
         y4F5RxguZvsq6J2YrTAFcK75Z/irxeKQQF0xmQWRt4+QtErSSsmLTt51S/W+2G1zTOwn
         YAkPh6lZhjcoxOJbFHrCqZ6UD5z7DcW+Mcd0VB3pX1vIS/ug/E5P/Rw4n+lAsrP58YF1
         bMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684914009; x=1687506009;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPEoHWWWFcR8ugYvJb1slJS1oYz2dG1SRLSh7TBkM5w=;
        b=jR88erWnunDJHpC1fOIDr5dBcVzSRhBxCFcRWasvMmxtw2zYb+xY4mr9kLaCEv18XJ
         YCze4VCGy6qLfUXrAYGAwCIO4sbeCzt3CcHtx82h/X+VLhZizcQtJkgYDMARsnHq61Am
         qPLxIW20hV8pdhILulIuFFgC6PJfeli4Pfu88nVrcaJrPVZcX2ARK5T23x9oIFralUQa
         1UvITEspLQRZhKfO0rfyp8AiYdXioAvuoM132He8chen/9rqnAhrsdyvWbcTe4SN2kcF
         k+xZLZ7EIcZdgWyv06rThEHY92/vCSlwklN8+N83L8nSFoEB+zW/0RPlo1SK60uUyjpJ
         cTPA==
X-Gm-Message-State: AC+VfDwjv6YuuY4jKkHlqdr4VGXFuNO8D3xeMOiEP/Lk/Qv7FTG0Uusc
        N0+jHk1iASAagadroqRTkwsGJw==
X-Google-Smtp-Source: ACHHUZ6C3jfzezlLYuzWNwC0NWciyqeWgU+0DPmnOz4xeGf2EHNYHSF5WgVf0ttwQevigKFG/tDR4w==
X-Received: by 2002:a05:6512:90d:b0:4f1:4898:d183 with SMTP id e13-20020a056512090d00b004f14898d183mr5093677lft.25.1684914009280;
        Wed, 24 May 2023 00:40:09 -0700 (PDT)
Received: from [10.0.6.3] (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id q11-20020ac246eb000000b004f001b0eda2sm1622017lfo.56.2023.05.24.00.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 00:40:08 -0700 (PDT)
Subject: Re: [PATCH 11/12] can: kvaser_pciefd: Refactor code
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
References: <20230523094354.83792-1-extja@kvaser.com>
 <20230523094354.83792-12-extja@kvaser.com>
 <CAMZ6RqJbT_rfd=Ueds502b12JaJOG9xevZdSDSV50v5epqtwug@mail.gmail.com>
From:   Jimmy Assarsson <extja@kvaser.com>
Message-ID: <01b58f55-7d54-cbc6-9af8-7a7a88b53fae@kvaser.com>
Date:   Wed, 24 May 2023 09:40:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqJbT_rfd=Ueds502b12JaJOG9xevZdSDSV50v5epqtwug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2023-05-23 13:27, Vincent MAILHOL wrote:
> Hi Jimmy,
> 
> I have one single comment for this series.

Hi Vincent,

Thanks for the feedback!

> On Tue. 23 May 2023 at 18:55, Jimmy Assarsson <extja@kvaser.com> wrote:
>> Refactor code;
>>   - Format code
>>   - Replace constants with macros
>>   - Rename variables and macros
>>   - Remove intermediate variable
>>   - Add/remove blank lines
>>   - Add function to fetch channel id from Rx packets
>>   - Reduce scope of variables
>>
>> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
>> ---

...

>> +static inline u8 kvaser_pciefd_rx_packet_get_ch_id(struct kvaser_pciefd_rx_packet *p)
>> +{
>> +       return (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & KVASER_PCIEFD_PACKET_CHID_MASK;
> 
> Instead of shifting and appliying the mask, define a mask which is
> already shifted with GEN_MASK.
> 
>    Then use the FIELD_GET and FIELD_PREP from linux/bitfield.h.
> 
> The same comment applies to the other shift and mask operations.
> 
> This GEN_MASK, FIELD_GET and FIELD_PREP can be a separate patch.

Good point, will fix this in v2.

Best regards,
jimmy
