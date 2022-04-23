Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A6D50CD0C
	for <lists+linux-can@lfdr.de>; Sat, 23 Apr 2022 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbiDWS7Y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 23 Apr 2022 14:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbiDWS7W (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 23 Apr 2022 14:59:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5395329835
        for <linux-can@vger.kernel.org>; Sat, 23 Apr 2022 11:56:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a1so8444488edt.3
        for <linux-can@vger.kernel.org>; Sat, 23 Apr 2022 11:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MrTvfbh80/nABjva/CFwZXvVtFfjS4p1cdRggyuMyb0=;
        b=ppMuSB/nzYeA11aQy1DjSqKy2Wgoy6ZkwZidEhMzkqXN4kk/dIXaw+R3AGu0AMtsv2
         udES9lYGsq16likT9Bhj6hoAOghIycaugD3/esamC5Pm6ryIYm+9De4VlVxOz2znnj2L
         M0bufMh81qx1LC5z3VXG5GzsoVGPcBuJ7JX74lBLXwLr9krnuq2W5FxJVEaeChYA7gfC
         qteBQ55ZE1gFvtT82d5Bv+VuNJb0S2rfEv81V8Eui0Jlg3RhJRMWwyzBc7p0dJtmyLwR
         AJQ8pMPjT23ME5D77zMTKVh54XReYrruQT5gaM7LX5GXGEaA220RjQJx45WmQd51jghJ
         WEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MrTvfbh80/nABjva/CFwZXvVtFfjS4p1cdRggyuMyb0=;
        b=WL90ZPbbF1IvFzdukCt5RKVbRXuc2HVVGMMoRjBM58xuxjgkyz7hHPCIIBGT+kqsNO
         UYJpl/pX5pCOoUuz1rZaB/eMXjySi4QQXe+3ZkE9QXYk61LZbpUYT+I4kw+q8tWg+jdT
         9ZKmuFWFHsSheGfFO2pLWcAs3DJ8BFx31K8YR/dTCAX1io5wep3TthOXw482BbDXJktC
         Fl7ik1p2qsxzp2nk9G4as2naIRuvAqgUFmL4utNWx9rKuc2w4mlTeGCQZsgCC12CuRPX
         SByvTkNgyZJz/Z0oB2PHQyHr/oAjlR8V1ZQuIP6gigNtaZRutn/5oVPnN8AqYXwyNV0G
         exMQ==
X-Gm-Message-State: AOAM530PKb2HT3xxaeZpjgYCIl5uely5L420nGQi5BrSrVB+joqNXNcU
        m5qWy9+mt0662XI51gOmaIQEcQ==
X-Google-Smtp-Source: ABdhPJyWCQyw2YMQrWuMvFGV/Ao0pGu3jAcyM/WTvK2mI7V2a9M8hrt1sPfK5Mwmsv2vlV/hFxVa0A==
X-Received: by 2002:a05:6402:34cd:b0:424:793:9f65 with SMTP id w13-20020a05640234cd00b0042407939f65mr11177304edc.88.1650740182965;
        Sat, 23 Apr 2022 11:56:22 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id fx3-20020a170906b74300b006daecedee44sm1916058ejb.220.2022.04.23.11.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 11:56:22 -0700 (PDT)
Message-ID: <da7f4830-aaeb-bb26-e58a-62e67b51645a@linaro.org>
Date:   Sat, 23 Apr 2022 20:56:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: can: renesas,rcar-canfd: Document RZ/G2UL
 support
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20220423130743.123198-1-biju.das.jz@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220423130743.123198-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 23/04/2022 15:07, Biju Das wrote:
> Add CANFD binding documentation for Renesas R9A07G043 (RZ/G2UL) SoC.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
