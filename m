Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887324AE7C0
	for <lists+linux-can@lfdr.de>; Wed,  9 Feb 2022 04:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245307AbiBIDNK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Feb 2022 22:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343932AbiBIDNB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Feb 2022 22:13:01 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17427C0613CC;
        Tue,  8 Feb 2022 19:13:01 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id q8so1187068oiw.7;
        Tue, 08 Feb 2022 19:13:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=729TJ/Tu7WU2owOkdmRMIluYXU5xC7cHiQxTCoVZ2IA=;
        b=pUdzI6TpLcHS1uhIuQ9YPXtTVWEE0cWH2vyNWFCBgEGlggV173bFncn8zCjndVdLxC
         tp+P0pO0wLzzmM5L07VOEV8qkbxJWBJ6puWpr+bCIn7Nzj/U7wHceIASEM7KEtXD3OmG
         bcXI5/h2O54r/tTld5AKzLDF3FsNznJ41Ihj3JVLzjFDzsDy1p1JnhWiWdDxJJ7tuH6P
         C3U/6deGCrn0GADL01pU0upyxE/eEeK22VZL4h/jN5L1MGUVtKM4XpkrnVhe2xIzfrE1
         L4gKypEcww828SFI8vd7J+cxnvhX9ipuUTb2UGfwaxiQr+0goBICAWXMPK/fYnoZ187O
         iu5g==
X-Gm-Message-State: AOAM533HME2J9cPjeZIH9lznoKb7cK+eyiljXMa1PDnyGnGvi5PFU0CI
        vxGOCXY9EI6C4WX0esSE9DPnO3uYXA==
X-Google-Smtp-Source: ABdhPJxR3JevfDPFrtMjEztlGfDTZEwN3VepxgMo/94PDRdxaTolb/523uVjk/8yq1gRKNHY91LpJQ==
X-Received: by 2002:a05:6808:13c5:: with SMTP id d5mr445134oiw.338.1644376380325;
        Tue, 08 Feb 2022 19:13:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bj8sm6570331oib.20.2022.02.08.19.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:12:56 -0800 (PST)
Received: (nullmailer pid 3556456 invoked by uid 1000);
        Wed, 09 Feb 2022 03:12:55 -0000
Date:   Tue, 8 Feb 2022 21:12:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        linux-can@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-binding: can: mcp251xfd: include common
 CAN controller bindings
Message-ID: <YgMxN5KPWllWLwJd@robh.at.kernel.org>
References: <20220124220653.3477172-1-mkl@pengutronix.de>
 <20220124220653.3477172-2-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124220653.3477172-2-mkl@pengutronix.de>
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

On Mon, 24 Jan 2022 23:06:50 +0100, Marc Kleine-Budde wrote:
> Since commit
> 
> | 1f9234401ce0 ("dt-bindings: can: add can-controller.yaml")
> 
> there is a common CAN controller binding. Add this to the mcp251xfd
> binding.
> 
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Thomas Kopp <thomas.kopp@microchip.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  .../devicetree/bindings/net/can/microchip,mcp251xfd.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
