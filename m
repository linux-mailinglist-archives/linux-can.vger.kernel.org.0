Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ABE73A140
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 14:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjFVMw4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 08:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjFVMwz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 08:52:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D111BFA
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 05:52:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9786fc23505so842772966b.2
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687438371; x=1690030371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vJn4qK5D0/zBLT8ePA8blzrHlwW1q+g3bf+ZWr4iToU=;
        b=n8kXF96Ou8tJCUZABlfYEiawtFnTorpd6T6wVvKKTS9oU8/wRhv59tqvt+uvAkNr/I
         0wmEqgx6EfnyZV9KUDTjS0YydCVrbGsC1dsZRImLRa0O9dsqeT1RrbG+YDObVXyStten
         2Xhwa00KD+H3SaTiQevquHYXLwCcP3kvSULg2frdOi1Q0l54/zm0MMd0cJ/KIAIYANOT
         obZpyacfm+blrmEvwXYTTtE1u016ho2iADX/o0dl1VV5apDMd0oqmeSxNa2PnnhR4iJY
         bg0mi6k6XBpbTiBjnEU3NiJhMzbwcoeRn3WyNinJdFigx5QvQQ9G0E/z0jLJsSOfvmZC
         NdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687438371; x=1690030371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJn4qK5D0/zBLT8ePA8blzrHlwW1q+g3bf+ZWr4iToU=;
        b=Gh8NQnUQFG/pmDXLI/d/wjAtu1+AITMeinMXiLGe9WBHKOEoYcgLxAR+53BjDWlDOF
         fqerFCLmSN1j0Um2Am/8gwh/CAAqUz6+3eydSe4jgCepBtTKv5629p9oDfv4Gu0AMhAk
         lGUFFuriv6QvUK6ncUcSssnCu+LDY2O7tofGnFW1l/QyVTpaTaOIWgze3llIGe38M4Ud
         auyKJsbxXqKtnW8FH5iGFeGGRYSYe+p0z26MI9r69hDdfvHK0lMp9GTG191V0Xk1A/Jr
         gHHMtGASMvvZSxTB265LQUoEZtbli+j0E5HIAkdpiHsuL0aS7F6sd5FHNAZrPvFoKDRZ
         EDNw==
X-Gm-Message-State: AC+VfDw4/JWQEf+7ygaBCxnfvdWkNyRy29wA6vEW/ftiqPS0aE5xMmet
        ExpxYymgLYAd9tctlYy1vFJVSw==
X-Google-Smtp-Source: ACHHUZ6BL7cV1ab79Z1DXqI3js9EbbIJO29PsCcID0NCQKXDLIPdAJcdnDuaLOt1M2ocx9LetkrqQg==
X-Received: by 2002:a17:906:9b88:b0:988:91cb:afd1 with SMTP id dd8-20020a1709069b8800b0098891cbafd1mr12407657ejc.29.1687438370948;
        Thu, 22 Jun 2023 05:52:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x14-20020a170906134e00b009828e26e519sm4559218ejb.122.2023.06.22.05.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 05:52:50 -0700 (PDT)
Message-ID: <e2cc150b-49e3-7f2f-ce7f-a5982d129346@linaro.org>
Date:   Thu, 22 Jun 2023 14:52:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 5/6] can: tcan4x5x: Add support for tcan4552/4553
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
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
 <20230621093103.3134655-6-msp@baylibre.com>
 <32557326-650c-192d-9a82-ca5451b01f70@linaro.org>
 <20230621123158.fd3pd6i7aefawobf@blmsp>
 <21f12495-ffa9-a0bf-190a-11b6ae30ca45@linaro.org>
 <20230622122339.6tkajdcenj5r3vdm@blmsp>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230622122339.6tkajdcenj5r3vdm@blmsp>
Content-Type: text/plain; charset=UTF-8
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

On 22/06/2023 14:23, Markus Schneider-Pargmann wrote:
>>
>> Yeah, but your code is different, although maybe we just misunderstood
>> each other. You wrote that you cannot use the GPIOs, so I assumed you
>> need to know the variant before using the GPIOs. Then you need
>> compatibles. It's not the case here. You can read the variant and based
>> on this skip entirely GPIOs as they are entirely missing.
> 
> The version information is always readable for that chip, regardless of
> state and wake GPIOs as far as I know. So yes it is possible to setup
> the GPIOs based on the content of the ID register.
> 
> I personally would prefer separate compatibles. The binding
> documentation needs to address that wake and state GPIOs are not
> available for tcan4552/4553. I think having compatibles that are for
> these chips would make sense then. However this is my opinion, you are
> the maintainer.

We do not talk about compatibles in the bindings here. This is
discussion about your driver. The entire logic of validating DTB is
flawed and not needed. Detect the variant and act based on this.

Best regards,
Krzysztof

