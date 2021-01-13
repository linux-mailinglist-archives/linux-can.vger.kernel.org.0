Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4CA2F426F
	for <lists+linux-can@lfdr.de>; Wed, 13 Jan 2021 04:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbhAMDYi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jan 2021 22:24:38 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:38660 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbhAMDYi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jan 2021 22:24:38 -0500
Received: by mail-ot1-f52.google.com with SMTP id j20so632379otq.5;
        Tue, 12 Jan 2021 19:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZSrpsNbcvEDxYIK+UaeOptgROJkkLzzVbandLpjStnE=;
        b=JgGBBREU4Zh0KSxlXUvtMT/54/Nrts6m8DMMDyjahRZ1x2c0hsS+Cpcn0jZQmPPIUh
         GWfA1hEOw0f5Tw8xxWiMmVfNph6Iasj9I5WjCVS7q2ANfj0o5FkxrYxsgCwWMxNrllZj
         iE/jIlzhCzJpizyLe5HaWTvITqyPmZqulpxFIXGekJborbZsQ1reCC3axl7pxdrFRzBT
         8/bMuHY1NWwUTMgaxaTW9DZ1NlfZ8LdhBRdtYQCv9otXOY+PI6jZll2sVrgRyHlmyEyc
         3ggOqiq+zGIZdN0XSKCxqMxhOARYQD9AwaQyG2h+qYLujLvkjSarSGxma/Qt55fI8+zp
         9HYQ==
X-Gm-Message-State: AOAM532b1ZPZOsnpcYmZTm+TSqcWOxDg6xHhcpWpN2/USdWJZ/EmDFmM
        BulBVx9OejfOmJRZA3H/i++pp7YdJA==
X-Google-Smtp-Source: ABdhPJzl6eyEhSOnI+FuahOcamuGW0ZLvJd4i5sSkbt4f6CH0lH4bYMmBMSGu0yWFed1xQD3Fxe6+w==
X-Received: by 2002:a05:6830:159a:: with SMTP id i26mr1561852otr.315.1610508237028;
        Tue, 12 Jan 2021 19:23:57 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p4sm175190oib.24.2021.01.12.19.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 19:23:56 -0800 (PST)
Received: (nullmailer pid 1469790 invoked by uid 1000);
        Wed, 13 Jan 2021 03:23:55 -0000
Date:   Tue, 12 Jan 2021 21:23:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     mkl@pengutronix.de, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: can: fsl,flexcan.yaml: introduce the
 stb-gpios property
Message-ID: <20210113032355.GA1469209@robh.at.kernel.org>
References: <20210107205915.7602-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107205915.7602-1-festevam@gmail.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Jan 07, 2021 at 05:59:14PM -0300, Fabio Estevam wrote:
> It is very common to have an STB pin in CAN transceivers, which allows
> putting the transceiver in standby or normal operation mode.
> 
> Add a new optional 'stb-gpios' property to describe this.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> index 0d2df30f19db..64f904c4b3d5 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> @@ -66,6 +66,9 @@ properties:
>    xceiver-supply:
>      description: Regulator that powers the CAN transceiver.
>  
> +  stb-gpios:
> +    description: GPIO that controls the STB CAN transceiver pin.

maxItems: 1

> +
>    big-endian:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description: |
> -- 
> 2.17.1
> 
