Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F2733EC12
	for <lists+linux-can@lfdr.de>; Wed, 17 Mar 2021 10:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhCQJA2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 Mar 2021 05:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhCQJAN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Mar 2021 05:00:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB959C06174A
        for <linux-can@vger.kernel.org>; Wed, 17 Mar 2021 02:00:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j18so968238wra.2
        for <linux-can@vger.kernel.org>; Wed, 17 Mar 2021 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NVFDyKO2ygUhA+HtmUiSLptg/TxB303zHN8TrRH0yhE=;
        b=or4XyHJGYy7z/dShZG1PvqNQ3+mrCRPDpPdx3PI6+1HwU8DEjPF4JQ3oy1zyni9pND
         +3mwGjlcdWHO6loLexzfwiDwlYaMrZ+Mat11LPLoJzLks0dNZDeVznd3o9Bkh22yAdxx
         aMAShraWmd/P7VcYr5ttJ5A1V0dgI7FmJsZjcsPD91Y2lyaioIkw3downPUsGLClM5aE
         bJk5cIPKAKbr3oI/YbZMh43PxIIf55zSoYn7FR3tkQ1vit7fyCDDmv1xHjvuoIGVV3Ok
         ZI5iNHKZQCuIiM7FKPo1g+jlfDUQ3SzWXk5/fUba8z2cTLeASOVi8vFa11WHyj2w8TI/
         lV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NVFDyKO2ygUhA+HtmUiSLptg/TxB303zHN8TrRH0yhE=;
        b=AZMxz3023pMuy6iIx/d0A69GiD1K9ebQsGL4pf2MuoU9c2UW5rap/+QDdpdFSrTAXx
         /U9eHRByavxRG5HPxlm/MBHUCdp6w1LxEc4GK+GUvEWAz5hg+IbdxlQW7pybaotGjGmb
         +i0gaAbDJlGjRH2a1NkAdR8PpJlW67/uM2n5am2EL3apyxlQdyEndn9WDSemxTV8gGZw
         9tSwT/cv0m8YStU2Rglp8YT8m1/qgWLz2O6/BasGAXIK8vWUZ0Fak6odXW7nIcu8fLpG
         sZPwAnCBd2w/yAYqIP5M5xlbVXxmL6BbBqy98ttK0/G1w/nmYb4UdDYyLeHLsIGBaX4y
         0e2w==
X-Gm-Message-State: AOAM530Tqo6PtanCo39tdESE3Q3hzDnZQkVt/0Ixuu7GHtTLR68yi7In
        pDN+zMkBFvZf8qVnTT7DAZ3C2w==
X-Google-Smtp-Source: ABdhPJyFsp2Dg+7R5QEB0wMODNdEp2hrkl7dZYkRMuhX4iedkaQnZgEMAu9IeLIWguFwdF0mzGxzDQ==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr3221240wru.78.1615971601574;
        Wed, 17 Mar 2021 02:00:01 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id l4sm24505097wrt.60.2021.03.17.01.59.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Mar 2021 02:00:00 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: Drop type references on common properties
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mark Brown <broonie@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Alex Elder <elder@kernel.org>, Suman Anna <s-anna@ti.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org
References: <20210316194858.3527845-1-robh@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <265c3486-2c85-5c63-e1b5-9b88eaddbb14@linaro.org>
Date:   Wed, 17 Mar 2021 08:59:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210316194858.3527845-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 16/03/2021 19:48, Rob Herring wrote:
> Users of common properties shouldn't have a type definition as the
> common schemas already have one. Drop all the unnecessary type
> references in the tree.
> 
> A meta-schema update to catch these is pending.
> 
> Cc: Nicolas Saenz Julienne<nsaenzjulienne@suse.de>
> Cc: Maxime Ripard<mripard@kernel.org>
> Cc: Linus Walleij<linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski<bgolaszewski@baylibre.com>
> Cc: Bjorn Andersson<bjorn.andersson@linaro.org>
> Cc: Krzysztof Kozlowski<krzk@kernel.org>
> Cc: Marc Kleine-Budde<mkl@pengutronix.de>
> Cc: "David S. Miller"<davem@davemloft.net>
> Cc: Jakub Kicinski<kuba@kernel.org>
> Cc: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
> Cc: Ohad Ben-Cohen<ohad@wizery.com>
> Cc: Mark Brown<broonie@kernel.org>
> Cc: Cheng-Yi Chiang<cychiang@chromium.org>
> Cc: Benson Leung<bleung@chromium.org>
> Cc: Zhang Rui<rui.zhang@intel.com>
> Cc: Daniel Lezcano<daniel.lezcano@linaro.org>
> Cc: Greg Kroah-Hartman<gregkh@linuxfoundation.org>
> Cc: Stefan Wahren<wahrenst@gmx.net>
> Cc: Masahiro Yamada<yamada.masahiro@socionext.com>
> Cc: Odelu Kukatla<okukatla@codeaurora.org>
> Cc: Alex Elder<elder@kernel.org>
> Cc: Suman Anna<s-anna@ti.com>
> Cc: Kuninori Morimoto<kuninori.morimoto.gx@renesas.com>
> Cc: Dmitry Baryshkov<dmitry.baryshkov@linaro.org>
> Cc:linux-gpio@vger.kernel.org
> Cc:linux-pm@vger.kernel.org
> Cc:linux-can@vger.kernel.org
> Cc:netdev@vger.kernel.org
> Cc:linux-remoteproc@vger.kernel.org
> Cc:alsa-devel@alsa-project.org
> Cc:linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring<robh@kernel.org>
> ---
>   .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml       | 5 +----
>   Documentation/devicetree/bindings/arm/cpus.yaml              | 2 --
>   .../bindings/display/allwinner,sun4i-a10-tcon.yaml           | 1 -
>   .../devicetree/bindings/gpio/socionext,uniphier-gpio.yaml    | 3 +--
>   .../devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml      | 1 -
>   .../devicetree/bindings/interconnect/qcom,rpmh.yaml          | 1 -
>   .../bindings/memory-controllers/nvidia,tegra210-emc.yaml     | 2 +-
>   Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml   | 1 -
>   Documentation/devicetree/bindings/net/qcom,ipa.yaml          | 1 -
>   Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml  | 2 --

For nvmem parts,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini
