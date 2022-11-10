Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC74B624206
	for <lists+linux-can@lfdr.de>; Thu, 10 Nov 2022 13:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiKJMLt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Nov 2022 07:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiKJMLs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Nov 2022 07:11:48 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB4E1CFC7
        for <linux-can@vger.kernel.org>; Thu, 10 Nov 2022 04:11:47 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id l12so2827671lfp.6
        for <linux-can@vger.kernel.org>; Thu, 10 Nov 2022 04:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUr5GXIjetvqmUBwd3OtcqUULVb7fxkMKk71ECylmYw=;
        b=RzyNMkWzQlNRGMQ957yXWjjTYMYk7hzfCSHU1jaMZgEqtfEqUeKD7s0EqNNelwbla/
         zLzofOCr1d5Lls5/HC4vMnMmmLeY+f9i+e7wJOJaKrQ2aLSDUh4E8GsXxebYXiNJfc/h
         2qO+VAxgS21tYwsT+4DmnnVopOvBBJXtjoGdemSeN9paDBtp3q6woONXUXgTIm6vSzcC
         4rmMFx2BrSQKf44mI+SGjjVAgceQpgFOcnP0cxVfAFnZeh+SWgtX+97s3O8kQ17CKE4C
         b9GYlRXf6EFpJDv/5HF1D8GYBHt0AN29xspQ5xe5SMfNxU90aCukLPlFilxC1m7wic0x
         5zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUr5GXIjetvqmUBwd3OtcqUULVb7fxkMKk71ECylmYw=;
        b=SJUu0PKrybC8ETS03ZUWTHXMDhShZHtiKU/oUC7xw3RmVT79hmDBXjw2PcJTLGANI2
         EBmp+pU5t+hbEWgI2YCf6d8t5fTgInKsAS2u9v782z2rwSHtlgrCkqEEsRr3IGIEfTYV
         GtRNUiGQ1e9fjnGF4CSk1kOyv9hc+doHJdpIcYL/EoMH79uE43IqP6ezG/O+KGFNXA49
         7Ky1T//kCFhoLFncfW1qG2g90SIPD1uBDex7rkBJZidkTGmfQkMbJ6x2ag/2mTQs/1vB
         8fEdw0oAwZ/JFsOPMBarJ+3bGIegB8kOTgvzfxMqlsIkCbyQcPXispJ3ZwstHm3khNT0
         HDXg==
X-Gm-Message-State: ACrzQf0Z6xYsasgZRzqQTAMvUZ2SNDlJ7kBWtIkiEIAo2npCFcmXJ3Z3
        GayxO9xey9/Mq2B9UCunmHgo/Q==
X-Google-Smtp-Source: AMsMyM4PW+P3N9qX9jt9EOP+3xYgM36df0Ws9nuyGcbcwoI6cdOiJLl8jW4SGeWSSWFhsK9tt/83CQ==
X-Received: by 2002:ac2:5f88:0:b0:4a7:8afe:b741 with SMTP id r8-20020ac25f88000000b004a78afeb741mr21323207lfe.15.1668082305520;
        Thu, 10 Nov 2022 04:11:45 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id f10-20020a056512360a00b004ac088fdfd2sm2727049lfs.85.2022.11.10.04.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 04:11:44 -0800 (PST)
Message-ID: <277004ed-3b6b-4ee5-39e4-beb75a272e60@linaro.org>
Date:   Thu, 10 Nov 2022 13:11:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/6] dt-bindings: Document the SYSREG specific
 compatibles found on FSD SoC
Content-Language: en-US
To:     Vivek Yadav <vivek.2311@samsung.com>, rcsekar@samsung.com,
        krzysztof.kozlowski+dt@linaro.org, wg@grandegger.com,
        mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, pankaj.dubey@samsung.com,
        ravi.patel@samsung.com, alim.akhtar@samsung.com,
        linux-fsd@tesla.com, robh+dt@kernel.org
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        aswani.reddy@samsung.com, sriranjani.p@samsung.com
References: <20221109100928.109478-1-vivek.2311@samsung.com>
 <CGME20221109100245epcas5p38a01aed025f491d39a09508ebcdcef84@epcas5p3.samsung.com>
 <20221109100928.109478-2-vivek.2311@samsung.com>
 <709daf8b-a58e-9247-c5d8-f3be3e60fe70@linaro.org>
 <000001d8f4f6$1c7e96e0$557bc4a0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <000001d8f4f6$1c7e96e0$557bc4a0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 10/11/2022 12:18, Vivek Yadav wrote:
>>> +maintainers:
>>> +  - Alim Akhtar <alim.akhtar@samsung.com>
>>> +
>>> +description: |
>>> +  This is a system control registers block, providing multiple low
>>> +level
>>> +  platform functions like board detection and identification,
>>> +software
>>> +  interrupt generation.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>
>> No need for oneOf.
>>
> Removing this results into dt_binding_check error, so this is required.

No, this is not required. You do not have more than one condition for oneOf.

>>> +      - items:
>>> +          - enum:
>>> +              - tesla,sysreg_fsys0
>>> +              - tesla,sysreg_peric
>>
>> From where did you get underscores in compatibles?
>>
> I have seen in MCAN Driver <drivers/net/can/m_can/m_can_platform.c> and also too many other yaml files.
> Do you have any ref standard guideline of compatible which says underscore is not allowed.

git grep compatible arch/arm64/boot/dts/exynos/ | grep _
git grep compatible arch/arm/boot/dts/exynos* | grep _

Both give 0 results. For few other SoCs there such cases but that's
really, really exception. Drop underscores.


Best regards,
Krzysztof

