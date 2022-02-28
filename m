Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603BF4C65F2
	for <lists+linux-can@lfdr.de>; Mon, 28 Feb 2022 10:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbiB1JrP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Feb 2022 04:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiB1JrO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Feb 2022 04:47:14 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FEC69CF7
        for <linux-can@vger.kernel.org>; Mon, 28 Feb 2022 01:46:36 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B2E683F170
        for <linux-can@vger.kernel.org>; Mon, 28 Feb 2022 09:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646041594;
        bh=vWRVPVArJCYlog6uyWwSBOO+0zNuAlMQrxtxYFl/jDE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=TvGdh8PoahWzvpn7b6V3YD2eKGDapLZDyGdE5cHvc6Jw+YyakuAOdzSnsWc3wWgRD
         /xxcLzkwmFGug+QjvWzk50J+AXbETkGqCP9oTM2kuBek3+cNfvx+ISEw9EdOFBdjg5
         FLVE4IQA94uXdJRGGAbE/rKw6bFfUdouo/rrIKuM1dzsCr1OL7L3XN+9SNKAJHCYdw
         uZ+za7i2L6CYTq2a4kQiu2qLUJIvG1/4ZZJLCTQaxn5DpPQQwOzZMw4KICwh6Ml8f0
         EKtypy9zDu9vpSDwU5gDduxP1aahVPyKqQTvO1VzbAGWga8kSmC9TlyqCoRA9wR2ic
         gEjsCEKsh42gw==
Received: by mail-wm1-f72.google.com with SMTP id w3-20020a7bc743000000b0037c5168b3c4so6164993wmk.7
        for <linux-can@vger.kernel.org>; Mon, 28 Feb 2022 01:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vWRVPVArJCYlog6uyWwSBOO+0zNuAlMQrxtxYFl/jDE=;
        b=sqE/zRb4GCgBhSayVjQwtnLB/gdOZ0Wk2WJtGHF23lR28nftZFGr8gstBYRqXwDVFO
         lsrEoMQUqBiDQIYqjNxd4153J7NP+roHwkQ97Xr6ViWWT9uzzI5hM1sV7FYZyWlP+VSl
         Xw40jZeGAGEEwwFeKi/VGZYSD/NvRDAKj8II7hQJZt1wSyN6VYZasHx7WrPD+BxFX07z
         qEFHJXiDeNtbqBKtTqLNbzY4nrb5x0wDeR4AhJiQ9toB1LIS6yMnLHylId1SGF9bvMSJ
         ufqjZUOBXghtkC5eX6e9DvnLzqnZoKrvUdSvvkfUnka3FOoI0kBiN2SAQ+/N1gGSkyS0
         /0CQ==
X-Gm-Message-State: AOAM533HiXc9AxwANPt7cG/ptyNOef9r98ttGUMhmg0w9v8AJ93mdvXU
        SvLHO01E5EDGV8nafpFmSz+WGSm3+pLezF6Yb35R+uct1mPr6Uzbp3hnZkuogEvMUqUeh+t1hTI
        4NygZO0nLuae5gWtLXh7cMbrRu+K+Fbe4qsYcLQ==
X-Received: by 2002:a05:600c:1c29:b0:381:7667:ab69 with SMTP id j41-20020a05600c1c2900b003817667ab69mr1406260wms.142.1646041594385;
        Mon, 28 Feb 2022 01:46:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjgfHayCZ6lM4CIvn6f9h7ICOQlGN4pyToG5DkHnFk0Kst5sueKcEZizJeXImKTwcW83XFsw==
X-Received: by 2002:a05:600c:1c29:b0:381:7667:ab69 with SMTP id j41-20020a05600c1c2900b003817667ab69mr1406248wms.142.1646041594244;
        Mon, 28 Feb 2022 01:46:34 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id m12-20020adfe0cc000000b001ede2dd604esm9807179wri.106.2022.02.28.01.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:46:33 -0800 (PST)
Message-ID: <5e15401e-761f-2135-7f3c-fd78a455e380@canonical.com>
Date:   Mon, 28 Feb 2022 10:46:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: net: can: renesas,rcar-canfd: Document
 RZ/V2L SoC
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220227213250.23637-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220227213250.23637-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 27/02/2022 22:32, Lad Prabhakar wrote:
> Document RZ/V2L CANFD bindings. RZ/V2L CANFD is identical to one found on
> the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rzg2l-canfd" will be used as a fallback.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> DTSI changes [0] have been posted as part of separate series.
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> 20220227203744.18355-4-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
