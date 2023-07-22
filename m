Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC8175DB5D
	for <lists+linux-can@lfdr.de>; Sat, 22 Jul 2023 11:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjGVJ37 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 22 Jul 2023 05:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjGVJ36 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 22 Jul 2023 05:29:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163DA2D7C
        for <linux-can@vger.kernel.org>; Sat, 22 Jul 2023 02:29:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98de21518fbso437984866b.0
        for <linux-can@vger.kernel.org>; Sat, 22 Jul 2023 02:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690018194; x=1690622994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WjVqeX0y//4nrDSpiCRGlr32t9U96I9NgVlq9whIyS4=;
        b=c/lWRogWO7Qdah02C1MkCGhNJvgGrif4oTCaPGdiK7W6NLpgxId3WwbMLqpuO472V/
         hv+v+JpG78Ij/VjrLudZjSb9znRBygfAX13gn7AW9ZXgckupA3UpSu77hFE43mLYi2Fa
         dTmzQqzoJTB+XVZxAcFcRNvrKHq8cPn3QNxRcXjlHczYx/PagKU2z79FFJsETjma5XPk
         WNjKvgSkT7hDponNZI1p983MhnTS1Cst5EKzwhQIk1ixI2QEL4OsiIASZnodOuY3q33i
         DzXo6i6W7Gban+p5Kj2vaFzbtu1B80PDCgmkgfzP8TzJaF9uqIgupXTYoalJZ8ajHxDt
         bdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690018194; x=1690622994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjVqeX0y//4nrDSpiCRGlr32t9U96I9NgVlq9whIyS4=;
        b=Wrn7260RSkfXJHFvL+JPMQLVoOisydh/3FXVcsGCps9Hon6749rba4aU9DYMMU4xgA
         y2Ha6dKv3oWDzpUbajovsdBh+uOzE8nwI3K6VstSiyNzzv0UTiJMfDD5eYd/wE+yCbR5
         n4JIfupvSP8CDyDvHKRONVu9TTPBsBFtJSGoESwDTGYNJEPPzxPnALRMjP62fUEoMwp1
         MV0+IFeVlxuz8lAh6V2ZivZHpMzF3U2v2WdcIqTz2a0TkEYCcP/v5ZnsCP2o+daChvge
         dLIBRQ6uPo0qACbL71F9rpUSDo49W8NY7Q5VL33lBUCHxWhABVdwgTfJkOcJ/QesL0Rb
         ppmw==
X-Gm-Message-State: ABy/qLa2QYCj1Eyfvpl3C//l4+wcvE5IwXs50jVTRT+Sn+coPtfOwMa9
        cvbPjfp7jo9ynuhBliabscfrgQ==
X-Google-Smtp-Source: APBJJlE7HknlGAjPgKT8dkx6J4YpoyIOaTkrnSeiX1f1kudR9TNvxMzo3HNczgig+NEQVx/A2dTm0Q==
X-Received: by 2002:a17:907:778c:b0:997:d975:64eb with SMTP id ky12-20020a170907778c00b00997d97564ebmr3847932ejc.35.1690018194587;
        Sat, 22 Jul 2023 02:29:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id lg26-20020a170906f89a00b00992b50fbbe9sm3307981ejb.90.2023.07.22.02.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 02:29:54 -0700 (PDT)
Message-ID: <9fc41843-3dd6-7b22-edd7-1a22b937f646@linaro.org>
Date:   Sat, 22 Jul 2023 11:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/4] dt-bindings: net: can: Add support for Allwinner
 D1 CAN controller
Content-Language: en-US
To:     John Watts <contact@jookia.org>, linux-sunxi@lists.linux.dev
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230721221552.1973203-2-contact@jookia.org>
 <20230721221552.1973203-3-contact@jookia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721221552.1973203-3-contact@jookia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 22/07/2023 00:15, John Watts wrote:
> The Allwinner D1 has two CAN controllers, both a variant of the R40
> controller. Unfortunately the registers for the D1 controllers are
> moved around enough to be incompatible and require a new compatible.
> 
> Introduce the "allwinner,sun20i-d1-can" compatible to support this.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

