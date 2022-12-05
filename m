Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B78E64363A
	for <lists+linux-can@lfdr.de>; Mon,  5 Dec 2022 22:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiLEU7z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 5 Dec 2022 15:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiLEU7s (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Dec 2022 15:59:48 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5902A408;
        Mon,  5 Dec 2022 12:59:48 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id q186so14488111oia.9;
        Mon, 05 Dec 2022 12:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46QOPVoh0uxqDkXkiHjkWEM9savZteYK/kuiKA+so9g=;
        b=eof5TwEx5IJEL/ZM+aSflFoW24SUjz9yVos1wKvBO5a8Pi/xdni4Y1fm/9lz82T2gM
         wehnP+A0xlFTIycbIx2CFQTgyVu/ifo8Z9fJD90Qrgn93v7PkwX4X6cICSDfu8uAQZ+Q
         mBIjrQjW96bSZsCNMMzqI/YSdiOQPzYS2Qx7MG7yxcaec3jlzQMH1FKpCdeBXyTeUlI4
         8gilX/RUaqq2aSw6poGwZSPVaCMFXByN4jk1BMD8HzVGaC16KMFE7gg8v5C7yHBilxo8
         oSXgdPXxGg6ZLSW3FYRVNLWC7QML/AAK3fUBvNl9GS1erufg4SJol/Ks4UQamCIbD3kM
         QRtA==
X-Gm-Message-State: ANoB5pnfjt5Ro53jMk/+mZ38qruDi2kpVGKJCDj0VG2+n1xyLcLplSJn
        735rfbl0stlxq2K1q9ZUeg==
X-Google-Smtp-Source: AA0mqf789/U8RDRQhSZPB8dU253wTPUUsERtdBRxAH7ZSW9M5bfE5zcqDjX1HUOvRX/ke77JhXSeiA==
X-Received: by 2002:aca:f3c6:0:b0:35b:531:7134 with SMTP id r189-20020acaf3c6000000b0035b05317134mr43314325oih.217.1670273987350;
        Mon, 05 Dec 2022 12:59:47 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id be6-20020a056870588600b00143c7a9bdb0sm9613026oab.27.2022.12.05.12.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:59:47 -0800 (PST)
Received: (nullmailer pid 2612109 invoked by uid 1000);
        Mon, 05 Dec 2022 20:59:46 -0000
Date:   Mon, 5 Dec 2022 14:59:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: can: renesas,rcar-canfd: Fix number of
 channels for R-Car V3U
Message-ID: <20221205205946.GB2513520-robh@kernel.org>
References: <021037bf7e422fcc23700dd62d1174c8e46ac85d.1669969283.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021037bf7e422fcc23700dd62d1174c8e46ac85d.1669969283.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Dec 02, 2022 at 09:22:11AM +0100, Geert Uytterhoeven wrote:
> According to the bindings, only two channels are supported.
> However, R-Car V3U supports eight, leading to "make dtbs" failures:
> 
>         arch/arm64/boot/dts/renesas/r8a779a0-falcon.dtb: can@e6660000: Unevaluated properties are not allowed ('channel2', 'channel3', 'channel4', 'channel5', 'channel6', 'channel7' were unexpected)
> 
> Update the number of channels to 8 on R-Car V3U.
> While at it, prevent adding more properties to the channel nodes, as
> they must contain no other properties than a status property.
> 
> Fixes: d6254d52d70de530 ("dt-bindings: can: renesas,rcar-canfd: Document r8a779a0 support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Is there a way to express this using positive logic (i.e. default to 2
> channels, extend to more where needed)? R-Car V3H_2 (which is not yet
> supported) has 3 channels.

I think you'd need an if/elif/elif/else construct which is doable, but 
not pretty.

> Or perhaps the check should be dropped completely?

I'm fine with that.

Rob
