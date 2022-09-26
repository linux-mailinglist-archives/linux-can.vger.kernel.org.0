Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DE05E9C95
	for <lists+linux-can@lfdr.de>; Mon, 26 Sep 2022 10:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiIZIzY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Sep 2022 04:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbiIZIzU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Sep 2022 04:55:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CC62F645
        for <linux-can@vger.kernel.org>; Mon, 26 Sep 2022 01:55:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 10so9763906lfy.5
        for <linux-can@vger.kernel.org>; Mon, 26 Sep 2022 01:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gjQi6LyRyOavvltzP5VncqU8vvjMjEcEEdokGWgaaFg=;
        b=VKNqlZTPeNfQaLYQObKyNsP+RPr8YKLUPIt6rDJMK/NOioow4Jqx70jNDf/mqC50YL
         GOgM6Q9REYjc8VXLfqhG1S+4VT+iE2A3dz89uoI5ddJJwjR5wQrmKDLcDvQ4VBz7Et2L
         c5S2UbbWG3T+rqALyCAiEpxigC4VH4sAFbPSsWKJxiJz/YLOWB6OBhURvHfW1xQWqwZu
         sJIGSxlghgaqfl1JoRxQWNYptTrHoww7vrU9uRAa97n3wAU7m2Ovko6FVlLpM8cxt+Mi
         udR9Vea+w/ADLAY3mR1/st2Y4+GEPULVazqFxRhR3YucdlA5I6QU3pCvMnb+ZB01O0PP
         8nJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gjQi6LyRyOavvltzP5VncqU8vvjMjEcEEdokGWgaaFg=;
        b=Tx/a47C8KK/DB9lr/QbURGoEx2sxWUNu6FljTNrvNz9JXPp/gjsOvNPRLJwDEgO3h+
         9V5tsVSsbUfE3v/HDrSaVDau2sVN8fIFAcwuazMll/rQ6jiWRKe1FEfFFcpvh06tJLgK
         EvGdktdNXrXhV/SeeBYpLGABwJrkCq+7Y6slKl3mQLlfQvWCl9fdRv5b94rELEMHSO0y
         b94Ppa1/TBL5f6WIpgl0QPbJzsyHxeCq3jFTRyAix0WAPpGtqcqNGJuFKbWydRe1FlK1
         xHaJc9T/27/3FqhfETl/okVw8ADXOPLy6RcZ5/maF3Sbq7mUu1/AA64eUjiVnuofgpGZ
         yMfA==
X-Gm-Message-State: ACrzQf0AixnY1W9EMx9EcgTvT7TduOv49TKK/Oj3O6IqUWQoaO8s08b7
        9Ut5NTBBbT3mZmRwOwkrdLY=
X-Google-Smtp-Source: AMsMyM7RJjjhH9sHHQ4A/c5TzHI5GS4/S2cAD49NvDoHPv8T+O/8QuO3F7LAg+Dwvu8OsWQEhK2djw==
X-Received: by 2002:a05:6512:1320:b0:488:8fcc:e196 with SMTP id x32-20020a056512132000b004888fcce196mr7981494lfu.602.1664182517173;
        Mon, 26 Sep 2022 01:55:17 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id q14-20020ac25a0e000000b004979989028bsm2460757lfn.147.2022.09.26.01.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:55:16 -0700 (PDT)
Message-ID: <1653bdae-2ed0-7cc4-993e-cae922f1c524@gmail.com>
Date:   Mon, 26 Sep 2022 10:55:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC can-next] can: remove obsolete PCH CAN driver
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Dario Binacchi <dariobin@libero.it>,
        Wolfgang Grandegger <wg@grandegger.com>
References: <20220924174424.86541-1-socketcan@hartkopp.net>
 <f9b37775-edd5-2a5b-18bc-b34bb69b8324@gmail.com>
 <20220926082526.ofoderi7wrpyolff@pengutronix.de>
From:   Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <20220926082526.ofoderi7wrpyolff@pengutronix.de>
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

On 9/26/22 10:25, Marc Kleine-Budde wrote:
> On 24.09.2022 22:24:07, Jacob Kroon wrote:
>> On 9/24/22 19:44, Oliver Hartkopp wrote:
>>> The PCH CAN driver is a driver for a Bosch C_CAN controller IP core which
>>> is attached to the system via PCI. This code has been introduced in 2011
>>> by Oki Semiconductors developers to support the Intel Atom E6xx series
>>> I/O Hub (aka EG20T IOH PCH CAN). Since 2012 the driver only has been
>>> maintained by the kernel community.
>>>
>>> As there is a well maintained and continously tested C_CAN/D_CAN driver
>>> which also supports the PCI configuration from the PCH CAN EG20T setup
>>> this driver became obsolete.
>>>
>>> Cc: Jacob Kroon <jacob.kroon@gmail.com>
>>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>>> Cc: Dario Binacchi <dariobin@libero.it>
>>> Cc: Wolfgang Grandegger <wg@grandegger.com>
>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>> ---
>>>    drivers/net/can/Kconfig       |    8 -
>>>    drivers/net/can/Makefile      |    1 -
>>>    drivers/net/can/c_can/Kconfig |    3 +-
>>>    drivers/net/can/pch_can.c     | 1249 ---------------------------------
>>>    4 files changed, 2 insertions(+), 1259 deletions(-)
>>>    delete mode 100644 drivers/net/can/pch_can.c
>>>
>>
>> Given that the current PCH driver will lockup on my system I'm all for
>> removing it.
> 
> Should I add your Acked-by?
> 

Although I doubt my name carries any weight in this context, yes feel 
free to do so.

Jacob
