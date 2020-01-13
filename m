Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C42EB139D62
	for <lists+linux-can@lfdr.de>; Tue, 14 Jan 2020 00:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAMXfF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Jan 2020 18:35:05 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45271 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgAMXfF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2020 18:35:05 -0500
Received: by mail-oi1-f194.google.com with SMTP id n16so10045729oie.12
        for <linux-can@vger.kernel.org>; Mon, 13 Jan 2020 15:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T2alnzvz8KAPkt6TNZdOKsvg51Cv8nSh38BXX535N54=;
        b=e5VV7DCqjfvHRTVqSU5DYHdxcOOtz8QE+34FrhCMqU2GAmNjb1CuCSe6W/lrZ25lMh
         hybuyHVRQvuQBp4aIh0zhLBILExmcG1uDjVPu7Q+gCKEuurChFaDf2x9Aml4/4MBvM1m
         4A4gmvCBMl96w0P308mO89E3QcKSZV3mX1WugaL+6HgJrRlNX+hsrqiPjOYSlEyHBvv4
         D+HGnUT/binFqAQdhUR9KNwe6lpBfkTVaLc5fEOtP24Uuur4XNMkJPrm+lE78NcbcbmE
         450a4H4tB+BvuG4bXSdyh3Of5A1H3XSFmWTdjjp4qWzZTIxvY4+cfG79CbD7rBma9flJ
         dMZg==
X-Gm-Message-State: APjAAAV9/2cRceokmg+Luvn6qiV1wRMF5UjI+XIXlxljdT3uYyb0zhXV
        IctG7tOI49pIrbbvBoB8a9w+6dQ=
X-Google-Smtp-Source: APXvYqw7zBE8RdBZ9IxtnioBG4SVvxl8IXGPClitdcHSLnwHcD1e2ZhdikkULKS5j36QtEoUolBJ0g==
X-Received: by 2002:aca:4b14:: with SMTP id y20mr13883323oia.160.1578958504615;
        Mon, 13 Jan 2020 15:35:04 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t23sm4042316oic.28.2020.01.13.15.35.02
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:35:04 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 221ac9
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:25:02 -0600
Date:   Mon, 13 Jan 2020 17:25:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        vkoul@kernel.org, eugen.hristev@microchip.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mchehab@kernel.org, lee.jones@linaro.org,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, wg@grandegger.com,
        mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 04/17] dt-bindings: atmel-tcb: add
 microchip,sam9x60-tcb
Message-ID: <20200113232502.GA31265@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-5-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-5-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Jan 10, 2020 at 06:17:56PM +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-tcb to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-tcb.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> index c4a83e364cb6..cf0edf5381c9 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> +++ b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> @@ -1,6 +1,6 @@
>  * Device tree bindings for Atmel Timer Counter Blocks
> -- compatible: Should be "atmel,<chip>-tcb", "simple-mfd", "syscon".
> -  <chip> can be "at91rm9200" or "at91sam9x5"
> +- compatible: Should be "atmel,at91rm9200-tcb", "atmel,at91sam9x5-tcb",
> +  "microchip,sam9x60-tcb", "simple-mfd", "syscon".

How many valid combinations are there? 1 with 5 strings? List one valid 
combination per line.

>  - reg: Should contain registers location and length
>  - #address-cells: has to be 1
>  - #size-cells: has to be 0
> -- 
> 2.7.4
> 
