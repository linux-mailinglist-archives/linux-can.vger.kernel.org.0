Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61458640521
	for <lists+linux-can@lfdr.de>; Fri,  2 Dec 2022 11:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiLBKtk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Dec 2022 05:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiLBKtj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Dec 2022 05:49:39 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3072B0B59
        for <linux-can@vger.kernel.org>; Fri,  2 Dec 2022 02:49:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g7so6821700lfv.5
        for <linux-can@vger.kernel.org>; Fri, 02 Dec 2022 02:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jW6y8+mPDb9kuBlxMtBNIHAxUSBlrElhmRnvpEEfr3E=;
        b=Br5B60iYwj3UJV2SZlq5ruNo4XWBUKAYgISQRN17fb4ZRB82q5tBKnIvvugGjCXSsx
         XNR8fykvOxoJwC9I/oiVv8FPSY0qkZEfpQTCrb1Bq8jfeF/cWE5L9EOSrA5ZfeP8/BVE
         dNEq6wjvCXwwMJ4vNvX3TPyoT8dSwuorHF4vXzvMs2MXPEZZWJ3592WFcxGboKnW8FA2
         /2P7d3LEbitOP5ZdCUzBHYgvZJvQw597LvU/IPceMmWWyuwcpT23LVQ2Fq5qPx8p6GBY
         UEPy1G2i4QOgEjIPitGVV5qsiD63ekeO6+amMLvJi3biy6CNxiw8N11QYHFv/8aUYJTl
         ScHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jW6y8+mPDb9kuBlxMtBNIHAxUSBlrElhmRnvpEEfr3E=;
        b=jhCL2ZCfDblHheKfCSSX1vlTxPhmenFgo3Cv68uujNFyl9yYjzQReKM2mDyeoI8jYg
         AiRTU0mtonOaqvOnV6ODScxmfbtjdcyele235lB2MMKi6J6asRAx6SHheCdXruZ6PVp1
         xiT2iwt3bcKbkOeZdAfF832i5jJ51dET94/BsYgeP8vjqMqniS5bwsSilJuFik+rGDPf
         JO4cMLQAddnCY1EhHrH9NTLvnmGjGrNghfKM+lMHRBFA3GT8ZXbeh62Sz/1GZWyBwfva
         Kqy6VX3uaEwOyAK5Mz9JWR4B4ZWO4bn9cyn0MrmZ/4nt7wMK2vmLxkJs4Z8Ha8gTH+D6
         gJTA==
X-Gm-Message-State: ANoB5pnkF9TgYp2VNB+5mGU3nNNKobonMEvCbszBiuQgzuP1v87F+sif
        H1XlJ3NJw4j+hVYmtI7WCMXclQ==
X-Google-Smtp-Source: AA0mqf7ktYnk3XWmcGW4CGl7M8NI9jnfOkabPGQGTPOed7MAlSwnyGBNVMdddCQoaV9KwizR3kI5HQ==
X-Received: by 2002:a05:6512:1584:b0:4b5:345c:516a with SMTP id bp4-20020a056512158400b004b5345c516amr4310320lfb.483.1669978177248;
        Fri, 02 Dec 2022 02:49:37 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id x28-20020a0565123f9c00b004b550c26949sm207070lfa.290.2022.12.02.02.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:49:36 -0800 (PST)
Message-ID: <433b5f09-e14f-b29a-782b-2eef4ae3eada@linaro.org>
Date:   Fri, 2 Dec 2022 11:49:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: can: renesas,rcar-canfd: Fix number of
 channels for R-Car V3U
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <021037bf7e422fcc23700dd62d1174c8e46ac85d.1669969283.git.geert+renesas@glider.be>
 <8af1d8b0-8b59-6d2f-ef1c-a24ef49e5d77@linaro.org>
 <CAMuHMdWd3KikD=HKFTorQvD_yGRvP3zCBF=FMJQvrLnF6VX5eA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdWd3KikD=HKFTorQvD_yGRvP3zCBF=FMJQvrLnF6VX5eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 02/12/2022 10:25, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Fri, Dec 2, 2022 at 10:01 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 02/12/2022 09:22, Geert Uytterhoeven wrote:
>>> According to the bindings, only two channels are supported.
>>> However, R-Car V3U supports eight, leading to "make dtbs" failures:
>>>
>>>         arch/arm64/boot/dts/renesas/r8a779a0-falcon.dtb: can@e6660000: Unevaluated properties are not allowed ('channel2', 'channel3', 'channel4', 'channel5', 'channel6', 'channel7' were unexpected)
>>>
>>> Update the number of channels to 8 on R-Car V3U.
>>> While at it, prevent adding more properties to the channel nodes, as
>>> they must contain no other properties than a status property.
>>>
>>> Fixes: d6254d52d70de530 ("dt-bindings: can: renesas,rcar-canfd: Document r8a779a0 support")
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
>>> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
>>> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> 
>>>      description: Maximum frequency of the CANFD clock.
>>>
>>>  patternProperties:
>>> -  "^channel[01]$":
>>> +  "^channel[0-7]$":
>>>      type: object
>>>      description:
>>> -      The controller supports two channels and each is represented as a child
>>> -      node.  Each child node supports the "status" property only, which
>>> +      The controller supports multiple channels and each is represented as a
>>> +      child node.  Each child node supports the "status" property only, which
>>>        is used to enable/disable the respective channel.
>>>
>>> +    unevaluatedProperties: false
>>
>> There are no other properties within a channel, so this should be rather
>> additionalProperties: false.
> 
> Are you sure? Then I also have to add:
> 
>         properties:
>           status: true
> 

Do you? I think it would be first schema needing it, so maybe that would
be a problem for dtschema...

Best regards,
Krzysztof

