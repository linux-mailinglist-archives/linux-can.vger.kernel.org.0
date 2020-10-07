Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1702862B9
	for <lists+linux-can@lfdr.de>; Wed,  7 Oct 2020 17:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgJGP4N (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Oct 2020 11:56:13 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:41156 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJGP4N (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Oct 2020 11:56:13 -0400
Received: by mail-oo1-f68.google.com with SMTP id t3so732693ook.8;
        Wed, 07 Oct 2020 08:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xccrMEUqeLhrUSMAgwJzJvAU/EAB747BnNFSuvETB+0=;
        b=XyBhFQGce+4z/CPek+vNkV/5+1ouNtgqUduoJBl4Y5b7b9qkhhe1r0B4qxsCTjXve2
         +Hol51ZIjME1DlZjTuhw0m76gwOXGi0RD0NwtMsvvTX/JXgDck2khlyn+MpOX0j0zR9N
         weH8Giv8W4FOhyPVDE00elr8Mx7xVmcdU882goNCVo6XGKSGkMxB7Wg8vh5mgQyYuDJc
         IFuGMV/WaIwXY7Opd9LAlYuEDzhbRS4HXrZKE4hNYBQWC7UZeXdlQ42MD79AiHM8T6fX
         EbYYvmiEgs4ujZ5qgcRwanLHsye0Jd43VpNGdjjbFCgHqObqEszAmp0+oHUlbCj6hQak
         lXLQ==
X-Gm-Message-State: AOAM530FOhybP3q9HK0/EioOPufdbWqPgJ6iCXk9NS4Q/xZdXtlGjTMt
        LGJK7pY5db/0fx9Bpq82UB8Lm1Tns0JG
X-Google-Smtp-Source: ABdhPJxM3G7xX4GSVbLmCasn14tnEyqaxlGzZp22Q6pdA6mc75F9vuXrdSGu3Nwi8Xhf69zO9lb45A==
X-Received: by 2002:a4a:bc92:: with SMTP id m18mr2534952oop.39.1602086172914;
        Wed, 07 Oct 2020 08:56:12 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o9sm2472536oop.1.2020.10.07.08.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 08:56:12 -0700 (PDT)
Received: (nullmailer pid 292162 invoked by uid 1000);
        Wed, 07 Oct 2020 15:56:11 -0000
Date:   Wed, 7 Oct 2020 10:56:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     kernel@pengutronix.de, devicetree <devicetree@vger.kernel.org>,
        linux-can@vger.kernel.org, Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH 13/17] dt-bindings: can: flexcan: remove ack_grp and
 ack_bit from fsl,stop-mode
Message-ID: <20201007155611.GA292110@bogus>
References: <20201006203748.1750156-1-mkl@pengutronix.de>
 <20201006203748.1750156-14-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006203748.1750156-14-mkl@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 06 Oct 2020 22:37:44 +0200, Marc Kleine-Budde wrote:
> Since commit:
> 
>     048e3a34a2e7 can: flexcan: poll MCR_LPM_ACK instead of GPR ACK for stop mode acknowledgment
> 
> the driver polls the IP core's internal bit MCR[LPM_ACK] as stop mode
> acknowledge and not the acknowledgment on chip level.
> 
> This means the 4th and 5th value of the property "fsl,stop-mode" isn't used
> anymore. It will be removed from the driver in the next patch, so remove it
> from the binding documentation.
> 
> Fixes: 048e3a34a2e7 ("can: flexcan: poll MCR_LPM_ACK instead of GPR ACK for stop mode acknowledgment")
> Cc: devicetree <devicetree@vger.kernel.org>
> Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
