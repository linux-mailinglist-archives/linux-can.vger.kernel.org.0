Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABB1643596
	for <lists+linux-can@lfdr.de>; Mon,  5 Dec 2022 21:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiLEUZN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 5 Dec 2022 15:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiLEUZM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Dec 2022 15:25:12 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F3F27CC0;
        Mon,  5 Dec 2022 12:25:12 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-14449b7814bso9890125fac.3;
        Mon, 05 Dec 2022 12:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P054ussJ/RdkrcHDPcUoxHTe6TuWEX4I2BKRN4ty+wY=;
        b=BU4ETCXJCfdtnd6twbypU25JBQye0kkVBXw48PP15ZEpmKp2wTK6qoqS7TdccRr2cH
         sS/Exv4/ZQYcQTJYM71lZykiFaLTSYbckHVW72R3VfE5odY9/OOOQUrbCQoiY4PdqBxO
         jJAwHNNPUxd7txp0DD9/P5cxnPjPxaNOKAD3MrWWeuTJrT/rnLbuxo0CNry6nye39K/Y
         FlcD5lay0xgGn31+l+3IC+/Rt05KrQrbvjtTpgX1OGN2a2dq3uneC8aJS2KXKZ/YBh4y
         yu6GKZo2S2Q0Z676gyhg11H/rG6c49v+K9rWSGGL74aKkYkbLYuiqWrqZyQdP7K8jj3H
         B0wg==
X-Gm-Message-State: ANoB5pn7ND41I66SaZ4aCJUe9LrngRamVjwiHdDKVM+vKUAjUzef4r2y
        fj0WP0Qbx0Jiy8tFhyjgcg==
X-Google-Smtp-Source: AA0mqf5YLolm7RBXnIcgwg3A6/dqWELfE1936HKE1Qc86vamM++nt9HuUf2h4xJuavcVG+mapkGhyg==
X-Received: by 2002:a05:6870:4788:b0:132:341e:e01a with SMTP id c8-20020a056870478800b00132341ee01amr34560090oaq.191.1670271911327;
        Mon, 05 Dec 2022 12:25:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s22-20020a4a2d56000000b004982f2d3c03sm7152298oof.25.2022.12.05.12.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:25:11 -0800 (PST)
Received: (nullmailer pid 2566218 invoked by uid 1000);
        Mon, 05 Dec 2022 20:25:10 -0000
Date:   Mon, 5 Dec 2022 14:25:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: can: renesas,rcar-canfd: Fix number of
 channels for R-Car V3U
Message-ID: <20221205202510.GA2513520-robh@kernel.org>
References: <021037bf7e422fcc23700dd62d1174c8e46ac85d.1669969283.git.geert+renesas@glider.be>
 <8af1d8b0-8b59-6d2f-ef1c-a24ef49e5d77@linaro.org>
 <CAMuHMdWd3KikD=HKFTorQvD_yGRvP3zCBF=FMJQvrLnF6VX5eA@mail.gmail.com>
 <433b5f09-e14f-b29a-782b-2eef4ae3eada@linaro.org>
 <CAMuHMdXLgU1x87J_suMWWYXe=T_h1iLxp8iDmmOqYjVyXqrtag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXLgU1x87J_suMWWYXe=T_h1iLxp8iDmmOqYjVyXqrtag@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Dec 02, 2022 at 11:58:23AM +0100, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Fri, Dec 2, 2022 at 11:49 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 02/12/2022 10:25, Geert Uytterhoeven wrote:
> > > On Fri, Dec 2, 2022 at 10:01 AM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > >> On 02/12/2022 09:22, Geert Uytterhoeven wrote:
> > >>> According to the bindings, only two channels are supported.
> > >>> However, R-Car V3U supports eight, leading to "make dtbs" failures:
> > >>>
> > >>>         arch/arm64/boot/dts/renesas/r8a779a0-falcon.dtb: can@e6660000: Unevaluated properties are not allowed ('channel2', 'channel3', 'channel4', 'channel5', 'channel6', 'channel7' were unexpected)
> > >>>
> > >>> Update the number of channels to 8 on R-Car V3U.
> > >>> While at it, prevent adding more properties to the channel nodes, as
> > >>> they must contain no other properties than a status property.
> > >>>
> > >>> Fixes: d6254d52d70de530 ("dt-bindings: can: renesas,rcar-canfd: Document r8a779a0 support")
> > >>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > >>> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > >>> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > >
> > >>>      description: Maximum frequency of the CANFD clock.
> > >>>
> > >>>  patternProperties:
> > >>> -  "^channel[01]$":
> > >>> +  "^channel[0-7]$":
> > >>>      type: object
> > >>>      description:
> > >>> -      The controller supports two channels and each is represented as a child
> > >>> -      node.  Each child node supports the "status" property only, which
> > >>> +      The controller supports multiple channels and each is represented as a
> > >>> +      child node.  Each child node supports the "status" property only, which
> > >>>        is used to enable/disable the respective channel.
> > >>>
> > >>> +    unevaluatedProperties: false
> > >>
> > >> There are no other properties within a channel, so this should be rather
> > >> additionalProperties: false.
> > >
> > > Are you sure? Then I also have to add:
> > >
> > >         properties:
> > >           status: true
> >
> > Do you? I think it would be first schema needing it, so maybe that would
> > be a problem for dtschema...
> 
> You think I haven't tried? ;-)
> 
>     arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dtb:
> can@e66c0000: channel0: Additional properties are not allowed
> ('status' was unexpected)

I guess nodes with no properties aren't too common.

Now fixed in dtschema.

Rob
