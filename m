Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53702B1DE9
	for <lists+linux-can@lfdr.de>; Fri, 13 Nov 2020 16:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgKMPA2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 13 Nov 2020 10:00:28 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42722 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgKMPAZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Nov 2020 10:00:25 -0500
Received: by mail-ot1-f65.google.com with SMTP id h16so5043546otq.9;
        Fri, 13 Nov 2020 07:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VmahaNCCiWAzP+6zAolyYpB1M5noh0yEIKUtBdGplDQ=;
        b=PN2mLXQZHDHz8Br6rtouFdxVeecFL1Ui14IKSZtkuOQxetGISyo1ACrepll6ZSv9Ga
         /zW8l1AEv+i4zA6UlDqOKIgIDpnz1wPf3YeQYyUL5ZzD+O/TPrKvIW6DTEo/pKetvP5s
         05d7B1qdtmPA6AeRnEyuibZis9IxrSN/uuqcWIZ9EepymTy3BSrHDwVR0sx6Op6TzhPS
         Q0AB1RAjUf+6ZAVqfqQUyy6qGjzYHFus/qgNP3tphSf5P2I8cmDjz1+EOgFf2ZRQfoJZ
         7C7Rbf5jwc9SBoGb5XI+IASIZTd8XsM/AxWcw9C+qGXzWavnM+cRHpZX3HUqJGfoOLgp
         uCUg==
X-Gm-Message-State: AOAM532Hr5MLWiA0pKbXejFLsKvhiXm3rVTAFcODReCjsoaQDVf16kSZ
        48g73oAsFL2xJsV8MHjfGyEKyxvNyA==
X-Google-Smtp-Source: ABdhPJxXF/baKvpipbsRty/VEzCGFQQNM8Lt8ZUoBmoHBr1lD+FWMq2Ne5a9+aSAjUgZ1TF+pfc0gw==
X-Received: by 2002:a9d:62c1:: with SMTP id z1mr1748469otk.108.1605279624148;
        Fri, 13 Nov 2020 07:00:24 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d3sm1990917otb.24.2020.11.13.07.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:00:23 -0800 (PST)
Received: (nullmailer pid 1457523 invoked by uid 1000);
        Fri, 13 Nov 2020 15:00:22 -0000
Date:   Fri, 13 Nov 2020 09:00:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] dt-bindings: clock: imx5: fix example
Message-ID: <20201113150022.GA1455810@bogus>
References: <20201111213548.1621094-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111213548.1621094-1-mkl@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, 11 Nov 2020 22:35:48 +0100, Marc Kleine-Budde wrote:
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

I've fixed things up with this and the compatible fixes and applied as 
this needs to get into rc4.

Rob
