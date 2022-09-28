Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2B05ED7BB
	for <lists+linux-can@lfdr.de>; Wed, 28 Sep 2022 10:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiI1I3I (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Sep 2022 04:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbiI1I27 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Sep 2022 04:28:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D42786CB
        for <linux-can@vger.kernel.org>; Wed, 28 Sep 2022 01:28:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a3so19228242lfk.9
        for <linux-can@vger.kernel.org>; Wed, 28 Sep 2022 01:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=vYW28YD0Q2KT2L6+sGkwfdRyu9b683awRycWIxHGZa8=;
        b=ejPnSR269opRrBe3pR4I0aqEO2lWl8hvsMWPneW7Udf0ENTkk40UiY48p15VpKezU5
         Jb/2KS8ZpmO1KdKz2+Isq0j8xBsWmMzh8gR9PAGYYLFHRQUKcLwtFiIUtHI0GRv6/4eX
         UNMuGX89HBnT0GakDc9gersr5n3p1oUAvMQptr0/215iLZSaAtHSokGVL+dDFlFr/guI
         wnhYvmAJKvlMtrDp11UF4saIZvI4cm8vvb8BJRNZgNWNMm8zmAI77EpyI+nowh4BaDh6
         6GoSwZOcwYMWZSKVujN+LdnbYDdWZ4Cd+pHM2EjjQpStV01OFRwvpK24c4ZmymfV4ZgZ
         UNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vYW28YD0Q2KT2L6+sGkwfdRyu9b683awRycWIxHGZa8=;
        b=Yutverb5xkxE9hbSAoXaOvn+jRrsON7DAQHVh4tCFC0Mk36oO6hmO2BshXC6NYw6mW
         5sQt/G2trBAXpd0HFRx3mv/pk1f8wo0y/3I/gRQdcB4KdfuIu2Ejj1ZHbx4dI1io5krW
         q8aVoxIAXGo1OH84SSL+geKlYa7CfWkjTshi76kNWOcbvEY4R14R8v+mgvSoRuKWYIob
         4bNtt1Ufl8CTyls8fOzqZEGeOZSHYb07aOeWWkM85sh2MG4EVfCWosILMW9sIUWtV/gk
         TLjr1MHq+Fa6NHlrdWDAFPKB5qfA3rkssrngVqsaCIERgStTDeyO1SPIZmrIJraBOTVf
         g0ug==
X-Gm-Message-State: ACrzQf0jHuyf16URoY7jXjMEwvooO+HfomEHfaResU1LeFkAdICS9dMp
        O3apMnTM0gNjrn1uFcMI44b1TKq5+psrkUxx
X-Google-Smtp-Source: AMsMyM5fVcHZdA9pTQaeg9GUskZMZYKdzjGJ/bPLZ1roLKMYeALEmYZwvXemXNkeRYKqfL4IPWWhyg==
X-Received: by 2002:a19:dc54:0:b0:49f:53f3:9bcd with SMTP id f20-20020a19dc54000000b0049f53f39bcdmr13332703lfj.158.1664353735059;
        Wed, 28 Sep 2022 01:28:55 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id y9-20020ac255a9000000b00499cf3e3edcsm404908lfg.296.2022.09.28.01.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:28:54 -0700 (PDT)
Message-ID: <1eff87d0-2e63-dee0-6df6-9ce1dead0e8b@gmail.com>
Date:   Wed, 28 Sep 2022 10:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     dariobin@libero.it, Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com
References: <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
 <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
 <20220923113638.tjnbuvkzdq24c4as@pengutronix.de>
 <36690382.801104.1663955706569@mail1.libero.it>
 <a162f149-58ba-24eb-474f-294b9fe78e51@gmail.com>
 <8665ef57-17fb-dfd7-afa2-8e5bebceb617@gmail.com>
 <1885528784.804387.1663962304792@mail1.libero.it>
 <a843df30-f1f9-f2dc-2d3f-4302c928c34c@gmail.com>
 <d9cf121c-de6c-b3e7-cb71-db505fc8c88f@gmail.com>
 <20220928082516.5hxt22y7u6cwjbmz@pengutronix.de>
Content-Language: en-US
From:   Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <20220928082516.5hxt22y7u6cwjbmz@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 9/28/22 10:25, Marc Kleine-Budde wrote:
> On 24.09.2022 07:17:25, Jacob Kroon wrote:
>> Machine is still running with CAN network traffic working, so both patches
>> at
>>
>> https://marc.info/?l=linux-can&m=166393304023574&w=2
>> https://marc.info/?l=linux-can&m=166396200108947&w=2
>>
>> are working for me.
> 
> Can I add your Tested-by for my variant of the patch? That is:
> 
> | https://lore.kernel.org/all/20220923114223.726808-1-mkl@pengutronix.de
> 

Absolutely,

Regards
Jacob
