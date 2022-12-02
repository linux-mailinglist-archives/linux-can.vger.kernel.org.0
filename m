Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53648640560
	for <lists+linux-can@lfdr.de>; Fri,  2 Dec 2022 11:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiLBK6j (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Dec 2022 05:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiLBK6i (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Dec 2022 05:58:38 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C14A9381B;
        Fri,  2 Dec 2022 02:58:37 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id c14so3199027qvq.0;
        Fri, 02 Dec 2022 02:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLjo6NrLzv2cehaX1IIFnQYvk2Lc89gcTFnanKE7jbE=;
        b=kpDJZHNk/NP/OrIeaoJwcha8o+sBHjHDtqm+ymb8VhJvNiTLpUbef1OknmqUmesWae
         13bfU2Xba0dFEr8QFqfxjKjldMZOa/V55tUH2p/oZGfz6iubl/W8gfvJWHWHoTSCvuT0
         NOHIU3mFp/K5ObUyMzXrTJACkwA6ot21s2OqZt+phPsc5gdIf1vf+B+3pb6+2PdNksXm
         v2ppTN9vkI5UybXCOET2D9jfN+s6hgNwgVXHxR/nw+dD2d4mje6o2wUWhB+GlZ9IzG7M
         E3Vsot+tUZguLXeBdKyEtdXOeyY8NlHKGUtdPiQAcxwETjRsIuGT63u9Pvo5WTbD4tbU
         3tXg==
X-Gm-Message-State: ANoB5pkrQ60Tw3f2uUSoNTa/BHpydjkLstAGf0D2aBPU/OER0CzGoOmd
        CFm2eJAFimeq9PWF4fvOXfNRi1NUN17DNg==
X-Google-Smtp-Source: AA0mqf6RKQt9uKHhAtCjjalwicMAU0La9zdZVbEDvmEAOlXH2e/RtXn01qVNybDFdvkT8GGb9pyC0Q==
X-Received: by 2002:a0c:e7c5:0:b0:4c6:f8a7:3dcf with SMTP id c5-20020a0ce7c5000000b004c6f8a73dcfmr25665421qvo.59.1669978715950;
        Fri, 02 Dec 2022 02:58:35 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id br36-20020a05620a462400b006faa2c0100bsm5232844qkb.110.2022.12.02.02.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:58:35 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3b48b139b46so44790077b3.12;
        Fri, 02 Dec 2022 02:58:35 -0800 (PST)
X-Received: by 2002:a81:4e09:0:b0:370:202b:f085 with SMTP id
 c9-20020a814e09000000b00370202bf085mr1005374ywb.502.1669978715325; Fri, 02
 Dec 2022 02:58:35 -0800 (PST)
MIME-Version: 1.0
References: <021037bf7e422fcc23700dd62d1174c8e46ac85d.1669969283.git.geert+renesas@glider.be>
 <8af1d8b0-8b59-6d2f-ef1c-a24ef49e5d77@linaro.org> <CAMuHMdWd3KikD=HKFTorQvD_yGRvP3zCBF=FMJQvrLnF6VX5eA@mail.gmail.com>
 <433b5f09-e14f-b29a-782b-2eef4ae3eada@linaro.org>
In-Reply-To: <433b5f09-e14f-b29a-782b-2eef4ae3eada@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 2 Dec 2022 11:58:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXLgU1x87J_suMWWYXe=T_h1iLxp8iDmmOqYjVyXqrtag@mail.gmail.com>
Message-ID: <CAMuHMdXLgU1x87J_suMWWYXe=T_h1iLxp8iDmmOqYjVyXqrtag@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: can: renesas,rcar-canfd: Fix number of
 channels for R-Car V3U
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Krzysztof,

On Fri, Dec 2, 2022 at 11:49 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 02/12/2022 10:25, Geert Uytterhoeven wrote:
> > On Fri, Dec 2, 2022 at 10:01 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >> On 02/12/2022 09:22, Geert Uytterhoeven wrote:
> >>> According to the bindings, only two channels are supported.
> >>> However, R-Car V3U supports eight, leading to "make dtbs" failures:
> >>>
> >>>         arch/arm64/boot/dts/renesas/r8a779a0-falcon.dtb: can@e6660000: Unevaluated properties are not allowed ('channel2', 'channel3', 'channel4', 'channel5', 'channel6', 'channel7' were unexpected)
> >>>
> >>> Update the number of channels to 8 on R-Car V3U.
> >>> While at it, prevent adding more properties to the channel nodes, as
> >>> they must contain no other properties than a status property.
> >>>
> >>> Fixes: d6254d52d70de530 ("dt-bindings: can: renesas,rcar-canfd: Document r8a779a0 support")
> >>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> >>> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> >>> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> >
> >>>      description: Maximum frequency of the CANFD clock.
> >>>
> >>>  patternProperties:
> >>> -  "^channel[01]$":
> >>> +  "^channel[0-7]$":
> >>>      type: object
> >>>      description:
> >>> -      The controller supports two channels and each is represented as a child
> >>> -      node.  Each child node supports the "status" property only, which
> >>> +      The controller supports multiple channels and each is represented as a
> >>> +      child node.  Each child node supports the "status" property only, which
> >>>        is used to enable/disable the respective channel.
> >>>
> >>> +    unevaluatedProperties: false
> >>
> >> There are no other properties within a channel, so this should be rather
> >> additionalProperties: false.
> >
> > Are you sure? Then I also have to add:
> >
> >         properties:
> >           status: true
>
> Do you? I think it would be first schema needing it, so maybe that would
> be a problem for dtschema...

You think I haven't tried? ;-)

    arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dtb:
can@e66c0000: channel0: Additional properties are not allowed
('status' was unexpected)

And indeed, that would be the first reference to status in a bindings
file...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
