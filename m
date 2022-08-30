Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF58B5A6AF1
	for <lists+linux-can@lfdr.de>; Tue, 30 Aug 2022 19:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiH3Rgq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 Aug 2022 13:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiH3Rg0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 30 Aug 2022 13:36:26 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA739D661
        for <linux-can@vger.kernel.org>; Tue, 30 Aug 2022 10:33:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z29so7929246lfb.13
        for <linux-can@vger.kernel.org>; Tue, 30 Aug 2022 10:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=rmlcaT4uod7PpBdmIDlVofuYmhAw0mWF1ocMR7J7jHQ=;
        b=cVmXkrXVB/VhRGL6WXUplEkAQijZtZRPc62bxRDQjALkNmsWvRBHB8+SZLdTSrr7Q2
         jJNPQDHL443hUjM3gm9pRsjjswMMUUxwAqnjJ44an8iwVtGJlPxWlPBGfVEN0PSk3fd+
         X+K160op9w//KYces00QD69pfUOTiQTGjOuQTQVU5NvlTqXtaYCcyzab4kSChbBP2AvF
         cw4SrUCA15vFvM6aZQFS1XZeIaQvGIENMA7nLQ/WODSBrmSLF8GYf6oHwHXfBmhEnv7O
         bq2DewdxbnUmsAbQejrrnx3RQO+QBInCtHIXVri/Q9fTZ16CIKB6QI3CpcUI/nSZE5Ul
         8AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rmlcaT4uod7PpBdmIDlVofuYmhAw0mWF1ocMR7J7jHQ=;
        b=wxZCTnZMgd2X+puJV3w0kGSGy0U+zSZL+l8IHshNy3TpuvWkGpr6HBo7h/XizglrC8
         FyvLvkZL++skWKBadbIH7zwx+SMMpV/I0mfn1ZkWKDHMr7oywj4hrCAIHy/WC/gwJaLJ
         D8ZWZSnEGPn5c9V8drpq2kqPiEnZzvJ2PAZMXnsy08O4JePDrsHPYhZMcCVlWHFi558v
         k3yMPoYpG7ow042WzMLfADnXfLpEIPNbmBlXPJchHbGBUnRWLFu4Job9soKQri7UeWAN
         MGqIgoOauxVq33bzcw4RyuCjRNbGl1AmKosnk22mhI8+UodDtyeSGIrioL2Qo0CJt9af
         l9Jw==
X-Gm-Message-State: ACgBeo2yTSv+dKq5r9P3jL7QlPdOsq130w8562vzBBjsPnY45mtxbPta
        nPlmhdqqSCTGO1SsULxgU6jzGA==
X-Google-Smtp-Source: AA6agR4PY6CaaARXSRtsxN/bcXrQHnxvJheo2EM1aAUGuEOPcsmtvuMW25Oc0Y2r7Drxt2Wkb0cBYQ==
X-Received: by 2002:a05:6512:3b20:b0:492:c04a:1520 with SMTP id f32-20020a0565123b2000b00492c04a1520mr8189476lfv.86.1661880699713;
        Tue, 30 Aug 2022 10:31:39 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id 13-20020a2e050d000000b0026392faf543sm1235119ljf.77.2022.08.30.10.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 10:31:39 -0700 (PDT)
Message-ID: <23539312-caaa-78f0-cd6c-899a826f9947@linaro.org>
Date:   Tue, 30 Aug 2022 20:31:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/3] dt-bindings: can: nxp,sja1000: Document RZ/N1
 power-domains support
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20220830164518.1381632-1-biju.das.jz@bp.renesas.com>
 <20220830164518.1381632-2-biju.das.jz@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830164518.1381632-2-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 30/08/2022 19:45, Biju Das wrote:
> Document RZ/N1 power-domains support. Also update the example with
> power-domains property.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3:
>  * Documented power-domains support.

You made them required, so it would be nice to see reason in such
change. The commit msg says only what you did, but not why you did it.

Best regards,
Krzysztof
