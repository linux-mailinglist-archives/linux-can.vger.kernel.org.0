Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B94AE7C4
	for <lists+linux-can@lfdr.de>; Wed,  9 Feb 2022 04:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344046AbiBIDNo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Feb 2022 22:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344313AbiBIDNV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Feb 2022 22:13:21 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6FFC0613CC;
        Tue,  8 Feb 2022 19:13:21 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id s185so1206890oie.3;
        Tue, 08 Feb 2022 19:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RLoT+uEmCrb0IZtLhnid6Dp9TPDAaGO03PPq9PXx/rI=;
        b=s1cbacuF4A1+nEgdy2riiYeNWo1LKM8L/L6I/y8AGSJNa9qrPaLpoxgkwxj9WS4PUB
         00LEfhlCMtd2BF5Y35056vyzqhiKgY2rvCZd0fiH8Vp6ms930EWjtdQVGuTGLyOfHa6O
         2Jk/0hABqxmwepExOaSX/EDnckOF+m+GUS6cF8l6aqj7ase4BLJCTamR3bknJaVGBrPN
         O6Kd18Pvp4nG3T5S2cfyLYZTB/BzPWt3bGVLZjzc639i9y8a6HqKLyrClN1fx0OsuY9N
         Qsh7E/ANqFfSdiADNGSXj2DCywrk0s0m5WiDDYzMfJqt/89TaOL9BVBbMIGJ07nENMbz
         h8aA==
X-Gm-Message-State: AOAM5315gd+Na7anwyUj2K+Z0DknNcdrvgPx55uHZNhJFQ1DIkc5BlBM
        I0+/T1gMLdfOe18oRuctxWxWFBDy3g==
X-Google-Smtp-Source: ABdhPJzsCs+Y61NIZFObEuh5R9FFE5LvLHqWbBs2oYAnUqgvqdm6Enf3tXs1byba2pco0lHB+2Srgg==
X-Received: by 2002:a05:6808:1a13:: with SMTP id bk19mr87593oib.311.1644376400537;
        Tue, 08 Feb 2022 19:13:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a8sm6078619otj.47.2022.02.08.19.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:13:19 -0800 (PST)
Received: (nullmailer pid 3557223 invoked by uid 1000);
        Wed, 09 Feb 2022 03:13:19 -0000
Date:   Tue, 8 Feb 2022 21:13:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] dt-binding: can: m_can: include common CAN
 controller bindings
Message-ID: <YgMxT2KQRFtTYwKZ@robh.at.kernel.org>
References: <20220124220653.3477172-1-mkl@pengutronix.de>
 <20220124220653.3477172-4-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124220653.3477172-4-mkl@pengutronix.de>
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

On Mon, 24 Jan 2022 23:06:52 +0100, Marc Kleine-Budde wrote:
> Since commit
> 
> | 1f9234401ce0 ("dt-bindings: can: add can-controller.yaml")
> 
> there is a common CAN controller binding. Add this to the m_can
> binding.
> 
> Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
