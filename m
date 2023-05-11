Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC006FEED5
	for <lists+linux-can@lfdr.de>; Thu, 11 May 2023 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjEKJaa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 11 May 2023 05:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbjEKJaU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 May 2023 05:30:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A2E8A52
        for <linux-can@vger.kernel.org>; Thu, 11 May 2023 02:30:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so1367929166b.2
        for <linux-can@vger.kernel.org>; Thu, 11 May 2023 02:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683797416; x=1686389416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L1D3DyfgLO2qgpd2r/Ml+/RxBZh1GZB83GE0hqLy2tQ=;
        b=wlBZemLmgEoqTudarPWQuZoMWjupCJqW8eoiFqUKC2Gp4Kisx9Ypm/BWCaXiB425sb
         wL6FmizCb+Nd7fbe9eek478fDmJcuVtPFcdEwVMYB987GJkWGbSMVj/hHS2uCkg0tQrn
         9YI5HRkpAj6RFwa3rml75hjqocghOdYJLPCNazm5LwJ1BsFArBwhvSp6aGiJmGEtV4Om
         9/FGW40Mp5tcufk2U4PFIwL5Z6k80pflF3Or4zvPjiTdYDkxXYLnIP5nrzM1vZxBTBrz
         woHO0cWJ14RtUahhbItFWkPChjJIzLh8wRLBCJaaBgBWakKP63eA2STq9jEysM4/CCPr
         NSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683797416; x=1686389416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1D3DyfgLO2qgpd2r/Ml+/RxBZh1GZB83GE0hqLy2tQ=;
        b=elb470pGPJLWNZwjnaL42bdaCq94LDVuy3QDamHwqnsiybJ7fdahvOSeYH02WBLoJ/
         trWyUwxotNlYtvPDRxTXYtwPW0p7RI+ocrW8UP0AEPwvY5gpntqwiKbOq9PVaCmBbLy+
         XwdjIGzkOqqZ+E5HP2oQqCZNN6MHYPgICjed3MEEzDkPV7eTdmOHzc9G2GS2zSwNS/Ac
         2cvkv2YjaOil1jGDNlog/7ll+vFQ3U2GQPCmyqHxmlv59yISkok1NksNtr6wFHgGsh/5
         PAM+OJrpw0BEO0/HmLHvSZOqbXAa/Cz0Mz/VFAexxWS/0f4ZRSSvKFAJ4MB7rd3UoVWW
         XKIg==
X-Gm-Message-State: AC+VfDwaT4YIaUDX5Fhcy9sXaPTxVnbm7yQhKtV5E19/X7wcryYbi5Qn
        A/U0oKkjS+Qd18eKE9a1eegCJA==
X-Google-Smtp-Source: ACHHUZ6MCQhIY5WN8mggDOv6ysIWk93HQOiNqbiulZXCxvlq8N7YKfSeITx+13ES2XfyWpsighV8CQ==
X-Received: by 2002:a17:907:72d6:b0:94e:43ce:95f6 with SMTP id du22-20020a17090772d600b0094e43ce95f6mr20428602ejc.47.1683797416337;
        Thu, 11 May 2023 02:30:16 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7e61:f14a:c3a4:809e? ([2a02:810d:15c0:828:7e61:f14a:c3a4:809e])
        by smtp.gmail.com with ESMTPSA id kn3-20020a1709079b0300b0096a27dbb5b2sm1835416ejc.209.2023.05.11.02.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 02:30:15 -0700 (PDT)
Message-ID: <528a82c2-9520-f8c5-c5cc-1084d9083670@linaro.org>
Date:   Thu, 11 May 2023 11:30:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/2] dt-bindings: net: can: Add poll-interval for MCAN
Content-Language: en-US
To:     Judith Mendez <jm@ti.com>, linux-can@vger.kernel.org,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Schuyler Patton <spatton@ti.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-arm-kernel@lists.infradead.org
References: <20230510202952.27111-1-jm@ti.com>
 <20230510202952.27111-2-jm@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510202952.27111-2-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 10/05/2023 22:29, Judith Mendez wrote:
> On AM62x SoC, MCANs on MCU domain do not have hardware interrupt
> routed to A53 Linux, instead they will use software interrupt by
> hrtimer.
> 
> To enable timer polling method, interrupts should be
> optional so remove interrupts property from required section and
> add an example for MCAN node with timer polling enabled.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

