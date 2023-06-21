Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195797380A4
	for <lists+linux-can@lfdr.de>; Wed, 21 Jun 2023 13:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjFUKak (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Jun 2023 06:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjFUKaB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Jun 2023 06:30:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699BA1FC9
        for <linux-can@vger.kernel.org>; Wed, 21 Jun 2023 03:29:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98746d7f35dso736222866b.2
        for <linux-can@vger.kernel.org>; Wed, 21 Jun 2023 03:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687343384; x=1689935384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDF4ZVTkAzYPtnHRop0HswLHr6IvSB28yMxQNxguC9g=;
        b=fp1r6E+tfo7FVlQyhEXURJigokj81sj1D4rtTtDD3YB14KJ8jWIGs+PDtj9E5BQcjV
         OK7A4AqrvtrKmAMeSxzvLVrIAIClPOlgVnRIJOhFWYqVEpWMD9cRdTT+rtGsovxdGjrK
         Ey5N96aQtfw1INmOVYMQh7p2Oa85m2JumX1GgHzZPwS7vvFP6F3XSipWnbWl6FRlSr6K
         aPJHq2vNlqrL4ZDIPIR+G6YBuHwpHaPW/mlCt5sXZ2Xv4naXxhDyrVvW7Nrl46u+nACc
         BbyVUU9pxo759TYtyS1F4LUqNUQANug+zd683NX4b37crEf7cCNQ7/3nDtUzwmHkM7Sc
         Bgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343384; x=1689935384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDF4ZVTkAzYPtnHRop0HswLHr6IvSB28yMxQNxguC9g=;
        b=F8FeViqhnOxF0qAWuPhXgeuJz10ZZWdZuHH6H5WcTaho/SFmz0p75SNQ/zmIKUcwu5
         q7xL+bbo7aOs7WeT7qoJtXcG8wVBNO8ccCBMrQy2Og5KeM2yH1G+I7clLjhhfPnXfIMS
         y47N4GJmIAUYXZB2h9GBEN501CmNy6quHzTTNOmwld6ZjaHmjdz3M/Mn8f+wv1ZX8zR4
         K1/33QV62HWvdWtwBd9GxSDzrpTKF1BrUO6yLhfkUN41QU+jDNnEakpZJv9xPEtDmryH
         9i9h0fvSbKNSiBlu4Ok6it0pPb7j4lsEKGX2Qzznt8nA725D/cSeVG5uzrsNL4e8v1sJ
         HCsA==
X-Gm-Message-State: AC+VfDwQxkD2T4QI1kixq2RzstIRtKWJFvZOf13HyRPW+B6pu2GQv+7m
        weON3tuGLUK7uZaXMMjjfcflNg==
X-Google-Smtp-Source: ACHHUZ55pNfRxYE5an/hqYprIWtu5+GhxW3NMHuilP6X5Tq3Kzy5cOi31xrX0IjMRYdy6lFdJ5rbUA==
X-Received: by 2002:a17:907:728b:b0:988:e0cd:99c4 with SMTP id dt11-20020a170907728b00b00988e0cd99c4mr6080249ejc.31.1687343383877;
        Wed, 21 Jun 2023 03:29:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bq26-20020a170906d0da00b0096f5b48fe43sm2854069ejb.47.2023.06.21.03.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 03:29:43 -0700 (PDT)
Message-ID: <315991a3-c825-5df8-2e68-40f24c524df1@linaro.org>
Date:   Wed, 21 Jun 2023 12:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/6] dt-bindings: can: tcan4x5x: Add tcan4552 and
 tcan4553 variants
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
References: <20230621093103.3134655-1-msp@baylibre.com>
 <20230621093103.3134655-2-msp@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621093103.3134655-2-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 21/06/2023 11:30, Markus Schneider-Pargmann wrote:
> These two new chips do not have state or wake pins.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

BTW, why did you ignore the tag?

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

