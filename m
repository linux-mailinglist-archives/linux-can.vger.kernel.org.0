Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2528E2AFD5F
	for <lists+linux-can@lfdr.de>; Thu, 12 Nov 2020 02:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgKLBbQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Nov 2020 20:31:16 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42326 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgKKXJ5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Nov 2020 18:09:57 -0500
Received: by mail-oi1-f196.google.com with SMTP id w145so4140380oie.9;
        Wed, 11 Nov 2020 15:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=60RrVFqWWdxAN6Mge7nSOxyHfyjaJE+UbXHO2MJ0/Ew=;
        b=MjcRO3DARFMPCMxbcv8Vn7zZGkeWnLIyCz+EZKi7ud9ZcAZuhuxNM5FUuGKeKkulmX
         hv5d6tNeZRpY4LqmbaU9h4zJvh0sng+TthM5GPkKSnM8cCJK5ETKa/YNtuNUb0zU/91j
         EEyGL+zSKgh1RQqLv6stbhD5Q8a7BmRSe3Vx8m+25doRh82bHhGNIABiisIKD7vB564Y
         bgt1WxLGFhJ8EsHxC77GcyGYsUr0iwfDCb5jQNTmBdPA4eesuftwjhryP77OgO8O7+Ok
         MploKB80vakBRg0a66pzK/EOOVY3b8aQ0styCTzLBwhSv53ABHO9eXVtQa2fysZs/l1D
         5OBw==
X-Gm-Message-State: AOAM531gjwKZVlKhUck8yDd8/Dfolw2ijpBobqH0I+jPleqkFilxSeLT
        81LD/sSYv28ephFtNZkT3Q==
X-Google-Smtp-Source: ABdhPJzc4X68X6/P1ZrKLVbEWkCMzB4pbLAPm5keK9jd9uq8aLjvGozwDxCJyDCSnvSxi6+A1pil5g==
X-Received: by 2002:aca:4797:: with SMTP id u145mr2610482oia.0.1605136196720;
        Wed, 11 Nov 2020 15:09:56 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x8sm872464ooc.44.2020.11.11.15.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:09:55 -0800 (PST)
Received: (nullmailer pid 2220284 invoked by uid 1000);
        Wed, 11 Nov 2020 23:09:55 -0000
Date:   Wed, 11 Nov 2020 17:09:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] dt-bindings: clock: imx5: fix example
Message-ID: <20201111230955.GA2214526@bogus>
References: <20201111213548.1621094-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111213548.1621094-1-mkl@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Nov 11, 2020 at 10:35:48PM +0100, Marc Kleine-Budde wrote:
> Since commit:
> 
>     0e030a373df3 ("can: flexcan: fix endianess detection")
> 
> the fsl,imx53-flexcan isn't compatible with the fsl,p1010-flexcan any more. As
> the former accesses the IP core in Little Endian mode and the latter uses Big
> Endian mode.
> 
> With the conversion of the flexcan DT bindings to yaml, the dt_binding_check
> this throws the following error:
> 
> Documentation/devicetree/bindings/clock/imx5-clock.example.dt.yaml: can@53fc8000: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['fsl,imx53-flexcan', 'fsl,imx25-flexcan'] is too long
>         Additional items are not allowed ('fsl,imx25-flexcan' was unexpected)
>         'fsl,imx53-flexcan' is not one of ['fsl,imx7d-flexcan', 'fsl,imx6ul-flexcan', 'fsl,imx6sx-flexcan']
>         'fsl,imx53-flexcan' is not one of ['fsl,ls1028ar1-flexcan']
>         'fsl,imx6q-flexcan' was expected
>         'fsl,lx2160ar1-flexcan' was expected
>         From schema: Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> 
> The error is fixed by removing the "fsl,p1010-flexcan" compatible (which turned
> out the be incompatible) from the binding example.
> 
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: devicetree@vger.kernel.org
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/clock/imx5-clock.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.yaml b/Documentation/devicetree/bindings/clock/imx5-clock.yaml
> index 4d9e7c73dce9..155379c3c41e 100644
> --- a/Documentation/devicetree/bindings/clock/imx5-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx5-clock.yaml
> @@ -57,7 +57,7 @@ examples:
>      };
>  
>      can@53fc8000 {
> -        compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
> +        compatible = "fsl,imx53-flexcan";

But you just added that "fsl,imx53-flexcan" has a fallback of 
'fsl,imx25-flexcan'. 

Looks like "fsl,imx53-flexcan" alone needs to be dropped. Decide the one 
way that is valid please. I've dropped the schema change until sorted 
out.

Rob
