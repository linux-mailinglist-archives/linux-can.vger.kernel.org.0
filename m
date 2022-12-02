Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29146402D6
	for <lists+linux-can@lfdr.de>; Fri,  2 Dec 2022 10:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiLBJDF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Dec 2022 04:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiLBJCg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Dec 2022 04:02:36 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F0DB0A2A
        for <linux-can@vger.kernel.org>; Fri,  2 Dec 2022 01:01:35 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bp15so6397723lfb.13
        for <linux-can@vger.kernel.org>; Fri, 02 Dec 2022 01:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5D0Oi8pnnqHGWQe+pRPVpXa8Ph86jMzrpUcwFO77+PA=;
        b=KS3HqPHHrgw2nF3z6xCU/tB3IatlylyE7MSDzQxtUK13PhZct23EoswdmUN+lwUPAC
         wGZ3RTXPu8cCZSuZPwVEPRF/mCVtaZ/+KIa6n9l7GE93mm5qS481YSV9rvpVmnmoj7lt
         veM7kihXB3EVM/Xd+n4Qk40ym6zmSpY8L2r6lsxYv3bV2vOXfs24U5pU98RTrzeT76Qy
         k85V6tL3oXVQKHRVGB1AfkdNBXwzDVAs3XrP9XZElqD4WNG3SN2gD7V+Lwhw+u+99Dep
         XN0QX6bGqjjjIM7S6bqAEvtjXS0vglv+BZV8GsQL84PfRUnqRVrLVlgvcX4wZhK1CySB
         WDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5D0Oi8pnnqHGWQe+pRPVpXa8Ph86jMzrpUcwFO77+PA=;
        b=wQl4D1dPaWZWJZdjnbM0afKe38RPTkD8Wou58c+oodUaAkLaUykOIvVT2F0WlUxY7o
         f6DrPSMCX6elxlmVi3uf1DT8vO8F20H1unUokeAl2/aAi3riiPYXEYoWrJjNEaCOD0li
         Jg5fxxCtHbr2bm+u2who9/rfAWIJI/2ab1+RWu8Tqls1RB05Tpby4Li0MZbbgYWNGmSP
         bAcFX9FxACST97jOWkKtplsdpWF8AQiJDtsUM1pCef2YCe3qxO20Kdk0qVJ296hg/T4v
         7fb4lie4jftNo46m3maSK/GYoAuD42rptIxH0xtb46VG/piHBKps2x+Xn1IgN8ofNOAC
         lEgQ==
X-Gm-Message-State: ANoB5plDBiS71n5In0Jd4j2xc6THfj4QgcWjv8tbTbTr5VXtsYyg4R7L
        0K6tamx2rAuqXumhWkg0RnA1Nw==
X-Google-Smtp-Source: AA0mqf6mq2WNHsxflBKrJkNA7LIyq31snYN9EFZvGZVXaH48gkKbWivM/4nhFls1aeCFoZjXkbFFig==
X-Received: by 2002:ac2:41d9:0:b0:4b1:4d9f:2204 with SMTP id d25-20020ac241d9000000b004b14d9f2204mr22473433lfi.22.1669971693753;
        Fri, 02 Dec 2022 01:01:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f27-20020a19381b000000b004a25468d86asm958339lfa.68.2022.12.02.01.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 01:01:32 -0800 (PST)
Message-ID: <8af1d8b0-8b59-6d2f-ef1c-a24ef49e5d77@linaro.org>
Date:   Fri, 2 Dec 2022 10:01:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: can: renesas,rcar-canfd: Fix number of
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
References: <021037bf7e422fcc23700dd62d1174c8e46ac85d.1669969283.git.geert+renesas@glider.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <021037bf7e422fcc23700dd62d1174c8e46ac85d.1669969283.git.geert+renesas@glider.be>
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

On 02/12/2022 09:22, Geert Uytterhoeven wrote:
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
> Is there a way to express this using positive logic (i.e. default to 2
> channels, extend to more where needed)? R-Car V3H_2 (which is not yet
> supported) has 3 channels.
> Or perhaps the check should be dropped completely?
> ---
>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 132 ++++++++++--------
>  1 file changed, 72 insertions(+), 60 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index 6f71fc96bc4e3156..6a4fb26cfd7b8979 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> @@ -9,9 +9,6 @@ title: Renesas R-Car CAN FD Controller
>  maintainers:
>    - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>  
> -allOf:
> -  - $ref: can-controller.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -77,13 +74,15 @@ properties:
>      description: Maximum frequency of the CANFD clock.
>  
>  patternProperties:
> -  "^channel[01]$":
> +  "^channel[0-7]$":
>      type: object
>      description:
> -      The controller supports two channels and each is represented as a child
> -      node.  Each child node supports the "status" property only, which
> +      The controller supports multiple channels and each is represented as a
> +      child node.  Each child node supports the "status" property only, which
>        is used to enable/disable the respective channel.
>  
> +    unevaluatedProperties: false

There are no other properties within a channel, so this should be rather
additionalProperties: false.


Best regards,
Krzysztof

