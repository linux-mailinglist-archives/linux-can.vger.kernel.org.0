Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077CE4AE7C3
	for <lists+linux-can@lfdr.de>; Wed,  9 Feb 2022 04:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbiBIDNm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Feb 2022 22:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343946AbiBIDNN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Feb 2022 22:13:13 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F9EC061355;
        Tue,  8 Feb 2022 19:13:12 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id s185so1206684oie.3;
        Tue, 08 Feb 2022 19:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sbqubsmy2GBvat3gdzxwCzAohZTZm6mGXpWdyCu5/lU=;
        b=lt12i3nXdWyiJYqN8UYZ/SxvQvCZK4nIlKEvi12BqObwzH7Vjt1OpvhBFyMdyZhoNW
         +PP0eV5qfjybTp+ZfZTR8LKOS/YJPUkZtcsgMKKB5vtE+llsY+sHKsBLrTob/yml6Yh3
         tYb3Llp8xYYdZcFNPlJxa/XoqdOxXA+lUoyniEnZ045qWiUiLE6iWmg428di8iJ54j7k
         rU0ITErL4OECUtD1vnQWzEIVbBpSVABkKe0ciI7UpaO11Vwe/lG23TADKAILiYfxfwvr
         PbzhzGLfdXq9QWMvrSlA713qu9UXKVjRALQb8x+6Zp0H02goFGFMgT++BCFlGtvCm7/Q
         wgHg==
X-Gm-Message-State: AOAM531X2eZZiQ9gLeUQDDg2LKVdwVx3zg6r2Hndwv2p8H7Z7cjEiQJ6
        cjuk7FfgEzroK/mVwVhmFQ==
X-Google-Smtp-Source: ABdhPJxeMZBgxq6Fnc1uu60DuBl66ERtyZsVC5tc/pwWf8kUrV+ZvZA2s6hCA+jDUdVLCu7AFFleQw==
X-Received: by 2002:a05:6808:1808:: with SMTP id bh8mr470036oib.39.1644376392217;
        Tue, 08 Feb 2022 19:13:12 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x17sm6022491oop.1.2022.02.08.19.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:13:11 -0800 (PST)
Received: (nullmailer pid 3556907 invoked by uid 1000);
        Wed, 09 Feb 2022 03:13:10 -0000
Date:   Tue, 8 Feb 2022 21:13:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
        devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        Evgeny Boger <boger@wirenboard.com>
Subject: Re: [PATCH net-next 2/4] dt-binding: can: sun4i_can: include common
 CAN controller bindings
Message-ID: <YgMxRuZOzXKvdBgN@robh.at.kernel.org>
References: <20220124220653.3477172-1-mkl@pengutronix.de>
 <20220124220653.3477172-3-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124220653.3477172-3-mkl@pengutronix.de>
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

On Mon, 24 Jan 2022 23:06:51 +0100, Marc Kleine-Budde wrote:
> Since commit
> 
> | 1f9234401ce0 ("dt-bindings: can: add can-controller.yaml")
> 
> there is a common CAN controller binding. Add this to the sun4i_can
> binding.
> 
> Cc: Evgeny Boger <boger@wirenboard.com>
> Cc: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  .../devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml   | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
