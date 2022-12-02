Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3EC640343
	for <lists+linux-can@lfdr.de>; Fri,  2 Dec 2022 10:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiLBJZu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Dec 2022 04:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiLBJZc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Dec 2022 04:25:32 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B87E13FB9;
        Fri,  2 Dec 2022 01:25:30 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id s14so3037202qvo.11;
        Fri, 02 Dec 2022 01:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMI5tS8skVho4WVNvy+4Y+948fh/Zr6JgQS25XTwcPs=;
        b=E6Td5z4+sBBv8XEmqsAa3NCICkkW/jrz2KPKiXznzbYXbJQrq1lb5yQNI1e8CCxYvS
         +coijIVG45tCciGAlBLVWMoGIyKTGlS79TAmiw0/ff40uIqYHElZBlcOY/e1bnYy1FUG
         Wu8RaLQmBXr6lc5K8Zl+NYOI5TSmcg7CvY5AX7TsfdVvjwEiwiIASj1mDv8QbzADwC88
         qes6jGvpiy1xEDUmzaYzyKFr93vETGRVL1JmyjYtHsPMogRNte418riDeepgP3jHOyUY
         Y6MpNugsEhpONP1iNx6OciDOKUxVLwVqGcW+gL3Tho73G3TwpUnllTC0LQCqZPZhugRw
         uc0w==
X-Gm-Message-State: ANoB5pk5K5iMBibIdM1u6f6HK3/pQ+ufw58zrE1zf52os645h4uSEKLo
        MwqgsiinO7tqgdHaWZw/86tSJVAgrEOe5g==
X-Google-Smtp-Source: AA0mqf4W1aYsjPPJuo59f/91LwDQISaFzO7nj6BWZmJTZO5GevuI6cZE7UmfEpVBMjBh2C1pR6zSJg==
X-Received: by 2002:ad4:52ca:0:b0:4bb:cb21:df19 with SMTP id p10-20020ad452ca000000b004bbcb21df19mr51987650qvs.85.1669973129457;
        Fri, 02 Dec 2022 01:25:29 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id bj9-20020a05620a190900b006b95b0a714esm5076536qkb.17.2022.12.02.01.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 01:25:28 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 7so5311118ybp.13;
        Fri, 02 Dec 2022 01:25:28 -0800 (PST)
X-Received: by 2002:a25:7408:0:b0:6f2:49a7:38ef with SMTP id
 p8-20020a257408000000b006f249a738efmr34049752ybc.365.1669973127972; Fri, 02
 Dec 2022 01:25:27 -0800 (PST)
MIME-Version: 1.0
References: <021037bf7e422fcc23700dd62d1174c8e46ac85d.1669969283.git.geert+renesas@glider.be>
 <8af1d8b0-8b59-6d2f-ef1c-a24ef49e5d77@linaro.org>
In-Reply-To: <8af1d8b0-8b59-6d2f-ef1c-a24ef49e5d77@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 2 Dec 2022 10:25:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWd3KikD=HKFTorQvD_yGRvP3zCBF=FMJQvrLnF6VX5eA@mail.gmail.com>
Message-ID: <CAMuHMdWd3KikD=HKFTorQvD_yGRvP3zCBF=FMJQvrLnF6VX5eA@mail.gmail.com>
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

On Fri, Dec 2, 2022 at 10:01 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 02/12/2022 09:22, Geert Uytterhoeven wrote:
> > According to the bindings, only two channels are supported.
> > However, R-Car V3U supports eight, leading to "make dtbs" failures:
> >
> >         arch/arm64/boot/dts/renesas/r8a779a0-falcon.dtb: can@e6660000: Unevaluated properties are not allowed ('channel2', 'channel3', 'channel4', 'channel5', 'channel6', 'channel7' were unexpected)
> >
> > Update the number of channels to 8 on R-Car V3U.
> > While at it, prevent adding more properties to the channel nodes, as
> > they must contain no other properties than a status property.
> >
> > Fixes: d6254d52d70de530 ("dt-bindings: can: renesas,rcar-canfd: Document r8a779a0 support")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

> >      description: Maximum frequency of the CANFD clock.
> >
> >  patternProperties:
> > -  "^channel[01]$":
> > +  "^channel[0-7]$":
> >      type: object
> >      description:
> > -      The controller supports two channels and each is represented as a child
> > -      node.  Each child node supports the "status" property only, which
> > +      The controller supports multiple channels and each is represented as a
> > +      child node.  Each child node supports the "status" property only, which
> >        is used to enable/disable the respective channel.
> >
> > +    unevaluatedProperties: false
>
> There are no other properties within a channel, so this should be rather
> additionalProperties: false.

Are you sure? Then I also have to add:

        properties:
          status: true

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
