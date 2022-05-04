Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F2451A409
	for <lists+linux-can@lfdr.de>; Wed,  4 May 2022 17:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352107AbiEDPcC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 May 2022 11:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350433AbiEDPcB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 May 2022 11:32:01 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFAD44747;
        Wed,  4 May 2022 08:28:25 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-edeb6c3642so1522143fac.3;
        Wed, 04 May 2022 08:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CakslCFZPSTLSxniNATtM0iqeyDmotCnHYKTxwUTwS8=;
        b=TsQCQ/cQv1ymjQD9EZFNQT+nZhXI42RhKmj0WPwZbvDDa7m7cvi+CBGFeh7uXiw6vE
         p1K4TltENPnIQMjzuWQ24nT4cQ0xIZZOIcD25yhay+FQys03WMPrTfb8rVde5Crh0n2E
         mmKa8KkO7/G0wA6jKHFYnq1/2YmuImWVaBK8Ognrd8GIGmwJ6dpBwm+wkeb4VHVQLG6v
         pHWOPrkZa+Tb6dtEzfErulPJ5ph4OPAsuQf9GNdD4i+bEDUesfeicTTtTXo7nKqHwQqq
         JJfWtopq4J/6kdguo9R15SG1MR+l2HpaJP+PYvMM6dRQkVZ3aU5bBlzwEYJrJAG4hzuV
         PWgQ==
X-Gm-Message-State: AOAM533i7HhLWasavRrl8+6nux54rVgBenoE5Ot8rzBDyRMaYe2Gwj8m
        MNCzpwiuH4nF5XKtO8rnbQ==
X-Google-Smtp-Source: ABdhPJwZK/kybU2Smle0zi8i7sLp4p4KKYosmp+461ZLK3FH/NX6aV5NvCRLEiF+CqGtFp/A5tXdSw==
X-Received: by 2002:a05:6870:f61d:b0:e2:96b:be74 with SMTP id ek29-20020a056870f61d00b000e2096bbe74mr2720oab.260.1651678104727;
        Wed, 04 May 2022 08:28:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g14-20020a05683030ae00b0060603221239sm5150907ots.9.2022.05.04.08.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:28:24 -0700 (PDT)
Received: (nullmailer pid 1742576 invoked by uid 1000);
        Wed, 04 May 2022 15:28:20 -0000
Date:   Wed, 4 May 2022 10:28:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org,
        Ondrej Ille <ondrej.ille@gmail.com>
Subject: Re: [PATCH can-next] dt-binding: can: ctucanfd: include common CAN
 controller bindings
Message-ID: <YnKblDFXd9Z6Ng1C@robh.at.kernel.org>
References: <20220504062342.52529-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504062342.52529-1-mkl@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, 04 May 2022 08:23:42 +0200, Marc Kleine-Budde wrote:
> Since commit
> 
> | 1f9234401ce0 ("dt-bindings: can: add can-controller.yaml")
> 
> there is a common CAN controller binding. Add this to the ctucanfd
> binding.
> 
> Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> Cc: Ondrej Ille <ondrej.ille@gmail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
