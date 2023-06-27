Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E050D73FDB7
	for <lists+linux-can@lfdr.de>; Tue, 27 Jun 2023 16:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjF0OXG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Jun 2023 10:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjF0OXG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Jun 2023 10:23:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CA6273C
        for <linux-can@vger.kernel.org>; Tue, 27 Jun 2023 07:23:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98df69cacd1so289400166b.1
        for <linux-can@vger.kernel.org>; Tue, 27 Jun 2023 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687875782; x=1690467782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ukf8kcwkmzk9LYwqXTolLjKgBXXfv/auIr6rnxGGo+0=;
        b=lDipDssM6fhnzbxP/+otLf3ADAtXGyAWRBBj5ozeFqK8p3nHDp9UbZapzYCqpThk7A
         V1J32lVWt4v2aH4iJoJdRTJogfKlEk4UUtAz2pYJ9gkn/KsL1MlfUCOlVjqi+Gmc43CR
         XFwHayAXhaF4YsUIm3g1AHDKCYA8Q0kmdoUy1pRvvObgIV565hclnHeyYr9feSaFlnSd
         Wnzx5fFl/9mbdLvb6v/D4KxnfDiGfYQZUbadrZfvgtpKfVY+0LhOTGuxZSUWxzZM433i
         HRx164LS4cDISfoD7dPe6Fc2UfktqMo01/1RtNb/AMUx28tqCsWrljq5OKogYlTi9/SZ
         qzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687875782; x=1690467782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukf8kcwkmzk9LYwqXTolLjKgBXXfv/auIr6rnxGGo+0=;
        b=a5hLfIuJNZlokmVeZ0LiQKmF7JAiVXcTnnPw1ct8M13nD9N6clvvfgqn2p0a/lACm/
         DEZUAPEb5K7UkhSvmigIkmveolIJZ1JAn7bf8WePsYaeEWYrmRrGWJWLblbeKa7ojpWV
         aYjtSnuJnF4npoRyBIhhGw2M7cwiRE5yfqkNWwVPvsm0CRjbwpqXdKaW9m+YVVskPP8A
         3FAIpBagESpVAMXjOFjEDGG1SG+LotccRAmShFZ9CLnJ2UOnRhXCaRjBJrDh31pV35+x
         T/PWqqxc5oLD4vDbtX5y387x9oRCBXeJE3szgdhb+Hukpmmih8cm8LSlBVBkzxtFIkWb
         lxnQ==
X-Gm-Message-State: AC+VfDyyUZfPzwu8jylmmsGEEjGc37P1+nf8U3uemqAfQB1s8HhsW8V8
        CUE5xAymXuQo5xQyMvIt1vyAyQ==
X-Google-Smtp-Source: ACHHUZ6OV19c18Cv0nNU8zXxPholYkVouLpnSEi8QQ79pSZZvEUYZC9ugwMwAT4QmdwLm8ARWM1TxA==
X-Received: by 2002:a17:907:d1a:b0:988:e223:9566 with SMTP id gn26-20020a1709070d1a00b00988e2239566mr23513151ejc.62.1687875782075;
        Tue, 27 Jun 2023 07:23:02 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id qh15-20020a170906ecaf00b009885462a644sm4575596ejb.215.2023.06.27.07.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:23:01 -0700 (PDT)
Date:   Tue, 27 Jun 2023 16:23:00 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v2 5/6] can: tcan4x5x: Add support for tcan4552/4553
Message-ID: <20230627142300.heju4qccian5hsjk@blmsp>
References: <20230621093103.3134655-1-msp@baylibre.com>
 <20230621093103.3134655-6-msp@baylibre.com>
 <32557326-650c-192d-9a82-ca5451b01f70@linaro.org>
 <20230621123158.fd3pd6i7aefawobf@blmsp>
 <21f12495-ffa9-a0bf-190a-11b6ae30ca45@linaro.org>
 <20230622122339.6tkajdcenj5r3vdm@blmsp>
 <e2cc150b-49e3-7f2f-ce7f-a5982d129346@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2cc150b-49e3-7f2f-ce7f-a5982d129346@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Krzysztof,

On Thu, Jun 22, 2023 at 02:52:48PM +0200, Krzysztof Kozlowski wrote:
> On 22/06/2023 14:23, Markus Schneider-Pargmann wrote:
> >>
> >> Yeah, but your code is different, although maybe we just misunderstood
> >> each other. You wrote that you cannot use the GPIOs, so I assumed you
> >> need to know the variant before using the GPIOs. Then you need
> >> compatibles. It's not the case here. You can read the variant and based
> >> on this skip entirely GPIOs as they are entirely missing.
> > 
> > The version information is always readable for that chip, regardless of
> > state and wake GPIOs as far as I know. So yes it is possible to setup
> > the GPIOs based on the content of the ID register.
> > 
> > I personally would prefer separate compatibles. The binding
> > documentation needs to address that wake and state GPIOs are not
> > available for tcan4552/4553. I think having compatibles that are for
> > these chips would make sense then. However this is my opinion, you are
> > the maintainer.
> 
> We do not talk about compatibles in the bindings here. This is
> discussion about your driver. The entire logic of validating DTB is
> flawed and not needed. Detect the variant and act based on this.

I thought it was about the bindings, sorry.

So to summarize the compatibles ti,tcan4552 and ti,tcan4553 are fine.
But the driver should use the ID register for detection and not compare
the detected variant with the given compatible?

In my opinion it is useful to have an error messages that says there is
something wrong with the devicetree as this can be very helpful for the
developers who bringup new devices. This helps to quickly find issues
with the devicetree.

@Marc: What do you think? Maybe I misinterpreted your mail from last
version?

Best,
Markus
