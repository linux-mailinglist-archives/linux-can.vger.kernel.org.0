Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4082A67240C
	for <lists+linux-can@lfdr.de>; Wed, 18 Jan 2023 17:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjARQuP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 Jan 2023 11:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjARQt6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2023 11:49:58 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C935139BBB;
        Wed, 18 Jan 2023 08:49:56 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-15f64f2791dso5787962fac.7;
        Wed, 18 Jan 2023 08:49:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8pejbMfGfA7sger1cIjryPDFShEDApGoNKKJ3O3DdI=;
        b=5OPewo7E+4BwtSnMxcwh/EF577Q0ZUSyg99o2kx+WaebbdcC38Cb9mpp2BN26Iabi3
         bhYlJ/UvBIpx/CB4hU3xX7lvGFl9tuOx9yytAf3Pf6yZbwc7QWmT3aK3iOsRlImcpfvD
         J9sHg/wsKbiU7Uwqn/GuWP6ySJH1B2vACzBcsNhO27J9HMwA/xbqTcgi2Unx08wE7Zlw
         RVFR21G2l41SyZmIiO49BDgIAtg4k+IJVE+13u2NqhzpN6OMymb93uAgKUxdsmpVmrVi
         hRoDGqvoCAZ9zf0IrJ5F+zRURNDx+XLTxuYnyctA4rsc3y1ZPVCG1LbymMUNUNAiF+6f
         rpcw==
X-Gm-Message-State: AFqh2ko8EyhK9j5nONfLTYG1H7iyuLPGfgSVjDIm2axchk1Ewpd+uuwJ
        u2VCl9/cd/dJNcCSvT993g==
X-Google-Smtp-Source: AMrXdXvM1ASDy1gMYTuFGeV9oShiw5s+IVzD1szfQKLsv0gKQG9VVXcVsWRFlId3mgDlBmOWlnx9lQ==
X-Received: by 2002:a05:6870:4c06:b0:15e:a2c6:143f with SMTP id pk6-20020a0568704c0600b0015ea2c6143fmr4594407oab.25.1674060596032;
        Wed, 18 Jan 2023 08:49:56 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id p22-20020a056870831600b0014813cc4a51sm18493694oae.29.2023.01.18.08.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:49:55 -0800 (PST)
Received: (nullmailer pid 149666 invoked by uid 1000);
        Wed, 18 Jan 2023 16:49:54 -0000
Date:   Wed, 18 Jan 2023 10:49:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJR1443
Message-ID: <167406059441.149609.14786053112798414488.robh@kernel.org>
References: <cover.1674037830.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


On Wed, 18 Jan 2023 11:39:23 +0100, Geert Uytterhoeven wrote:
> The NXP TJR1443 High-speed CAN transceiver with Sleep mode is a
> pin-compatible alternative for the TI TCAN1043.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
