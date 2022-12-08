Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EF7646B99
	for <lists+linux-can@lfdr.de>; Thu,  8 Dec 2022 10:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiLHJML (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 8 Dec 2022 04:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiLHJME (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Dec 2022 04:12:04 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A240C115E
        for <linux-can@vger.kernel.org>; Thu,  8 Dec 2022 01:12:03 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id y25so1071609lfa.9
        for <linux-can@vger.kernel.org>; Thu, 08 Dec 2022 01:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LpWZnDv0P0vniZ/ef/2jOeLWNDrnScsIp14aMU9UV2U=;
        b=RtAO289tYW0S2t5NKExsuW4LQalCzm67lRuKSbqFLkzebMX+nVvUYS7QdlSxkv5cT0
         08DApRn0sSSIeL9eitg82t4cwVK9IeoOGMsReJGtfwsbiVFE61Wzigznth4212GPMme4
         f8gHgATCXIGzphN2OLqMHzY5r+ShouRTHmVsDMqz5/AFLmxOpaEi0LU3faGC7Gobpk/6
         +eEnG+Zjd4c7wtTQ9BMfzJWFbCKsfuiIDVvRMMSuyOaMeagGSfBQo2fF7ro0b6Egs0ds
         PF697DyNNjaTkO45yF6tS40bOcPGV5GAQ3T40pqgx+euya5jEFs0747OMdk0bSEGfDKQ
         GeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpWZnDv0P0vniZ/ef/2jOeLWNDrnScsIp14aMU9UV2U=;
        b=pJTS176B4Gcah4jE0oXrZW6+RNjBqcXOKzFSPRCIfMkL35ECwHYLklkOpPFcUaF09h
         Wg1F3CozstMlpDBtzfanb0RseVJJpg4/o4GCsbuJZQRpCsmnCF+ui4Uf5SHTBCLN9S28
         JmMAV8P5t6wBaGSm9sv0D/Cx59heJS2L5QPswijLgNDzGRv6sKLQ8qMnbusGRYlt4ndq
         CHKvC+NlckZ4o1tFnjDTy7lpqnMW9VmZ4VeJ6mzxm+hhIRCk8J6Mvw6FMZhzXBsGipQ9
         CrPDqxlZtTiCFcqZ3vKw4T6bAIT6WnTmJ+IFdYJYoZ+Jfji90kciMZVoqcb3dID2fxUh
         Oahg==
X-Gm-Message-State: ANoB5pkbaPdWudJmt9pXksAX+S6lSYxccTDpPBfZctMQpOgHIgee+PiC
        PzzqKc3RuliOPnKmCb77xB+aB2QoHpoYapizHgE=
X-Google-Smtp-Source: AA0mqf65lQZQLpcKXomlUK+/tj3N0pC92OPD7wNKHNr7hl/ZX4meN+q7aVA1v5znxxB1y7J0WXgUPQ==
X-Received: by 2002:a05:6512:1516:b0:4b5:1545:2229 with SMTP id bq22-20020a056512151600b004b515452229mr16854820lfb.113.1670490722022;
        Thu, 08 Dec 2022 01:12:02 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z21-20020a056512309500b004aa95889063sm3252215lfd.43.2022.12.08.01.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 01:12:01 -0800 (PST)
Message-ID: <9e02194a-5268-fe2c-5faf-235bb2ec6ae4@linaro.org>
Date:   Thu, 8 Dec 2022 10:12:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] dt-bindings: can: renesas,rcar-canfd: Fix number of
 channels for R-Car V3U
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Ulrich Hecht <uli+renesas@fpond.eu>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <7d41d72cd7db2e90bae069ce57dbb672f17500ae.1670431681.git.geert+renesas@glider.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7d41d72cd7db2e90bae069ce57dbb672f17500ae.1670431681.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 07/12/2022 17:50, Geert Uytterhoeven wrote:
> According to the bindings, only two channels are supported.
> However, R-Car V3U supports eight, leading to "make dtbs" failures:
> 
>         arch/arm64/boot/dts/renesas/r8a779a0-falcon.dtb: can@e6660000: Unevaluated properties are not allowed ('channel2', 'channel3', 'channel4', 'channel5', 'channel6', 'channel7' were unexpected)
> 
> Update the number of channels to 8 on R-Car V3U.
> While at it, prevent adding more properties to the channel nodes, as
> they must contain no other properties than a status property.
> 
> Fixes: d6254d52d70de530 ("dt-bindings: can: renesas,rcar-canfd: Document r8a779a0 support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - s/unevaluatedProperties/additionalProperties/.
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

