Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03B64C4ACD
	for <lists+linux-can@lfdr.de>; Fri, 25 Feb 2022 17:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243028AbiBYQdm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Feb 2022 11:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243031AbiBYQdk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Feb 2022 11:33:40 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3844FDF37;
        Fri, 25 Feb 2022 08:33:08 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id 12so7943163oix.12;
        Fri, 25 Feb 2022 08:33:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XXg+FEt5mLgbXsRsErmFUwdBh6AYb/1xe2xli27bLXI=;
        b=N3FhshSlBEsiMneBb2hZsccEVODFNHo+sGaOlXljnJ6DDawAvToI0GdlImhwwwiSp4
         SJbruQs862Trojv3fpIoDg83A0E8Q5Z7+9v7NQEhGWN319vJ9zWnh8pHtkBQrhxYLfTh
         VAxexv3yXUg/LpuF6hkuim/rwdLydY4XyAYuPyu+QVxgz7swnshmkRaXM/tjsCKmw817
         /y61kM9YHcGKimfM35upbwBElIl4R6Z+DeV6KCZ3/+DQBJIUTnCfqhJR1ORNARBaW9ka
         mckyCyP9rflKA0JdvXl48+PyHDevi8Dp5BPrsot+njVi+dDeFNwvRHSLMpoZNHcVJhT1
         SB+w==
X-Gm-Message-State: AOAM533FiLmpcsLprpm8zyKWOM/fur5/MFwh0b8GDulr4BHmLRn5m6/h
        VTRYUSxvK4/68EDGhR9dmA==
X-Google-Smtp-Source: ABdhPJwn+VcYtq5OlnrynM+W03vZrYxW/uTx27PrtmXIyIxm11wkdwZr1zX97le62iz5C30DDwkEtQ==
X-Received: by 2002:aca:3e56:0:b0:2d4:c902:b851 with SMTP id l83-20020aca3e56000000b002d4c902b851mr2037230oia.114.1645806787497;
        Fri, 25 Feb 2022 08:33:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm1227099oou.10.2022.02.25.08.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:33:06 -0800 (PST)
Received: (nullmailer pid 1049444 invoked by uid 1000);
        Fri, 25 Feb 2022 16:33:05 -0000
Date:   Fri, 25 Feb 2022 10:33:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Sriram Dash <sriram.dash@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-can@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH net-next] dt-binding: can: m_can: fix indention of table
 in bosch,mram-cfg description
Message-ID: <YhkEwTaduIc5Dd5W@robh.at.kernel.org>
References: <20220217101111.2291151-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217101111.2291151-1-mkl@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, 17 Feb 2022 11:11:11 +0100, Marc Kleine-Budde wrote:
> This patch fixes the indention of the table in the description of the
> bosch,mram-cfg property.
> 
> Cc: Sriram Dash <sriram.dash@samsung.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@st.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
