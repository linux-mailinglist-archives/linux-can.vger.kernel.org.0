Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4E9622A1D
	for <lists+linux-can@lfdr.de>; Wed,  9 Nov 2022 12:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiKILSB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Nov 2022 06:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiKILR4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Nov 2022 06:17:56 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9D21022
        for <linux-can@vger.kernel.org>; Wed,  9 Nov 2022 03:17:55 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso1516146pjg.5
        for <linux-can@vger.kernel.org>; Wed, 09 Nov 2022 03:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kYj6FyVigVrAiCyf5DhKYcSFa7jCWL9eopZAZUyhSbI=;
        b=r/cG7thrZLrwg+3qxIfbqdOaaSlPggoUFbrMLuVafZRog3+LwopptktJ/3d3D2yUOG
         YLosrqHy0GBH6/GJy0/bCw5lYq9CwGSUQKvXmxmfFMNTAuZPNOJNKoeqfpLQP5flRShK
         /KLD683RBqJzEJUlzOj3LOy5mT6R2nKSxBmDpJsNlGkgiVhHKryPcF4sw1ELSpbwmtnY
         G4l8OGOLw/BaMp7i/Wtx0Dj5YuXJ2c25rSZKyCtRPqgdgSVCZanV5iGnHylvi4vquMt8
         a9/AAYRHxUONbgUuD9PZm1vzjIm5HX7onAxzjaClHwcP1at5j6FnNX76udBeSqvF9RS8
         eGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYj6FyVigVrAiCyf5DhKYcSFa7jCWL9eopZAZUyhSbI=;
        b=4u8bCV2kCG8JbQZJMj7l7Qg3146Ywe9fH7QC2BWE5hVeTRnsfa7FAuXs/R/LuWGPXE
         iFj3rDKIhIjMRsKPIKUi8W9X1K2xKi9T/CfcfOrynQI40w7YfLJLnn8/TjiMDRPCMF+z
         z1LOFZxH7szmYm8tTic1PVFo+igDBSDFl/eAa/3V5nXDtOjnpDYtYKOXXU83SWYcpfLX
         9L43iLL/IiWGqP0KhOepTuW0zSHo2gcqGWFGUpH7sf2/WO8PoXD7ksL/z+eooh5yos6X
         AGEFOSqeIv4Q3mI3eppqZFjkmuLUKiBSHAqVJCbU0s1+0bzxl39ZqgG5FuIqHRnCIG5D
         0UVg==
X-Gm-Message-State: ACrzQf195HsJ9RKSCxZkRtZHK8FPYODzlqMXuzJQRRXZXXBmP7g5wSO/
        yGcSI0ESFWqsUJv5YPyWhNkwnTOnHZjICSFeGekQHw==
X-Google-Smtp-Source: AMsMyM6/uBmYqHx35TsS7Y9sS+d1OiBCRip2SVGzRc2lq5siM5P07MYR6WPLsUofjsCsE/CjTHZRGDMJ4NSaIzUMm5Y=
X-Received: by 2002:a17:90a:64c3:b0:212:d67d:a034 with SMTP id
 i3-20020a17090a64c300b00212d67da034mr79654610pjm.55.1667992674621; Wed, 09
 Nov 2022 03:17:54 -0800 (PST)
MIME-Version: 1.0
References: <CGME20221109100254epcas5p48c574876756f899875df8ac71464ce11@epcas5p4.samsung.com>
 <20221109100928.109478-1-vivek.2311@samsung.com> <20221109100928.109478-4-vivek.2311@samsung.com>
In-Reply-To: <20221109100928.109478-4-vivek.2311@samsung.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 9 Nov 2022 12:17:42 +0100
Message-ID: <CAPLW+4nH=QQj+eWVrxeeOmgZ9UTGeL4__uttkNsji4XsGjOv3w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: fsd: add sysreg device node
To:     Vivek Yadav <vivek.2311@samsung.com>
Cc:     rcsekar@samsung.com, krzysztof.kozlowski+dt@linaro.org,
        wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com,
        alim.akhtar@samsung.com, linux-fsd@tesla.com, robh+dt@kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        aswani.reddy@samsung.com, sriranjani.p@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vivek,

On Wed, 9 Nov 2022 at 11:54, Vivek Yadav <vivek.2311@samsung.com> wrote:
>
> From: Sriranjani P <sriranjani.p@samsung.com>
>
> Add SYSREG controller device node, which is available in PERIC and FSYS0
> block of FSD SoC.
>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Pankaj Kumar Dubey <pankaj.dubey@samsung.com>
> Cc: devicetree@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> ---
>  arch/arm64/boot/dts/tesla/fsd.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
> index f35bc5a288c2..3d8ebbfc27f4 100644
> --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> @@ -518,6 +518,16 @@
>                                 "dout_cmu_fsys1_shared0div4";
>                 };
>
> +               sysreg_peric: system-controller@14030000 {
> +                       compatible = "tesla,sysreg_peric", "syscon";
> +                       reg = <0x0 0x14030000 0x0 0x1000>;

Probably not related to this particular patch, but does the "reg"
really have to have those extra 0x0s? Why it can't be just:

    reg = <0x14030000 0x1000>;

That comment applies to the whole dts/dtsi. Looks like #address-cells
or #size-cells are bigger than they should be, or I missing something?

> +               };
> +
> +               sysreg_fsys0: system-controller@15030000 {
> +                       compatible = "tesla,sysreg_fsys0", "syscon";
> +                       reg = <0x0 0x15030000 0x0 0x1000>;
> +               };
> +
>                 mdma0: dma-controller@10100000 {
>                         compatible = "arm,pl330", "arm,primecell";
>                         reg = <0x0 0x10100000 0x0 0x1000>;
> --
> 2.17.1
>
