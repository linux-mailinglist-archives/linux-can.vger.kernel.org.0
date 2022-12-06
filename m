Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EAD643E9B
	for <lists+linux-can@lfdr.de>; Tue,  6 Dec 2022 09:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiLFIaG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Dec 2022 03:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiLFI35 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Dec 2022 03:29:57 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A5913F93;
        Tue,  6 Dec 2022 00:29:55 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id ay32so5177482qtb.11;
        Tue, 06 Dec 2022 00:29:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9besuTz430+bUB/dXPphZ+0HwQHk+UhJW3qrSbIBzG0=;
        b=HftG3Tdary4jN8VrRB/rncnDaNf5QIgPqst8Kg0LKWuByaXuAueTke+D2hnNeJRT9C
         +50OWUSbiFI7iZ6LJQDnqDo33qOLT/vxw+M2eZNp0L3UEQPDhhnOVihlhEMrLL/9wAOC
         hIXNgT7S3nf/C8kmhFqjYtz10ZIc4z40M3xY61aWMjjcErjq8m1fZQ6glQytnUJPwNtl
         zEwx/cc93XcIZUw6fXHviP4e+AJbD75fkcA+Y5fU75EQLhcfo65ULzZVG4AyrEgQoit0
         J1QzdqM+7pZH8kttkAYLpOPychE0Z6DJYifOif+cw7nhiCcLAuZ8QUwkm5PTTixBOAKB
         GfbQ==
X-Gm-Message-State: ANoB5pkYeu3IkLwoolh6lzWDBsL5jeqHphsJtuZaXbPoSIDVeMipz2H5
        0AEp+344coc65Oninx0Bwx8K9tgN/l4oOg==
X-Google-Smtp-Source: AA0mqf7DkBYI1OKLcQ+rF9UQ+RCZwqBfZ6ZyU8GjI+AgBj9PrTYC4/4fCcVKVSNliDmaLuIjxZM9GQ==
X-Received: by 2002:a05:622a:1baa:b0:3a6:8be3:301e with SMTP id bp42-20020a05622a1baa00b003a68be3301emr24475054qtb.21.1670315394700;
        Tue, 06 Dec 2022 00:29:54 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id x29-20020a05620a0b5d00b006f87d28ea3asm13530067qkg.54.2022.12.06.00.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:29:54 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-3e78d07ab4fso73942517b3.9;
        Tue, 06 Dec 2022 00:29:53 -0800 (PST)
X-Received: by 2002:a81:a8a:0:b0:37e:6806:a5f9 with SMTP id
 132-20020a810a8a000000b0037e6806a5f9mr633079ywk.47.1670315393631; Tue, 06 Dec
 2022 00:29:53 -0800 (PST)
MIME-Version: 1.0
References: <021037bf7e422fcc23700dd62d1174c8e46ac85d.1669969283.git.geert+renesas@glider.be>
 <8af1d8b0-8b59-6d2f-ef1c-a24ef49e5d77@linaro.org> <CAMuHMdWd3KikD=HKFTorQvD_yGRvP3zCBF=FMJQvrLnF6VX5eA@mail.gmail.com>
 <433b5f09-e14f-b29a-782b-2eef4ae3eada@linaro.org> <CAMuHMdXLgU1x87J_suMWWYXe=T_h1iLxp8iDmmOqYjVyXqrtag@mail.gmail.com>
 <20221205202510.GA2513520-robh@kernel.org>
In-Reply-To: <20221205202510.GA2513520-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Dec 2022 09:29:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUb7OX1nVMAGqPBXaFBBR6fA1nRJO15+aQiMk8=eFL9sA@mail.gmail.com>
Message-ID: <CAMuHMdUb7OX1nVMAGqPBXaFBBR6fA1nRJO15+aQiMk8=eFL9sA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: can: renesas,rcar-canfd: Fix number of
 channels for R-Car V3U
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Rob,

On Mon, Dec 5, 2022 at 9:39 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Dec 02, 2022 at 11:58:23AM +0100, Geert Uytterhoeven wrote:
> > On Fri, Dec 2, 2022 at 11:49 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > > On 02/12/2022 10:25, Geert Uytterhoeven wrote:
> > > > On Fri, Dec 2, 2022 at 10:01 AM Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >> On 02/12/2022 09:22, Geert Uytterhoeven wrote:
> > > >>> According to the bindings, only two channels are supported.
> > > >>> However, R-Car V3U supports eight, leading to "make dtbs" failures:
> > > >>>
> > > >>>         arch/arm64/boot/dts/renesas/r8a779a0-falcon.dtb: can@e6660000: Unevaluated properties are not allowed ('channel2', 'channel3', 'channel4', 'channel5', 'channel6', 'channel7' were unexpected)
> > > >>>
> > > >>> Update the number of channels to 8 on R-Car V3U.
> > > >>> While at it, prevent adding more properties to the channel nodes, as
> > > >>> they must contain no other properties than a status property.
> > > >>>
> > > >>> Fixes: d6254d52d70de530 ("dt-bindings: can: renesas,rcar-canfd: Document r8a779a0 support")
> > > >>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > >
> > > >>> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > > >>> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > > >
> > > >>>      description: Maximum frequency of the CANFD clock.
> > > >>>
> > > >>>  patternProperties:
> > > >>> -  "^channel[01]$":
> > > >>> +  "^channel[0-7]$":
> > > >>>      type: object
> > > >>>      description:
> > > >>> -      The controller supports two channels and each is represented as a child
> > > >>> -      node.  Each child node supports the "status" property only, which
> > > >>> +      The controller supports multiple channels and each is represented as a
> > > >>> +      child node.  Each child node supports the "status" property only, which
> > > >>>        is used to enable/disable the respective channel.
> > > >>>
> > > >>> +    unevaluatedProperties: false
> > > >>
> > > >> There are no other properties within a channel, so this should be rather
> > > >> additionalProperties: false.
> > > >
> > > > Are you sure? Then I also have to add:
> > > >
> > > >         properties:
> > > >           status: true
> > >
> > > Do you? I think it would be first schema needing it, so maybe that would
> > > be a problem for dtschema...
> >
> > You think I haven't tried? ;-)
> >
> >     arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dtb:
> > can@e66c0000: channel0: Additional properties are not allowed
> > ('status' was unexpected)
>
> I guess nodes with no properties aren't too common.
>
> Now fixed in dtschema.

Thanks, confirmed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
