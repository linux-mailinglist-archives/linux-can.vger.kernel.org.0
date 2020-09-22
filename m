Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50755274935
	for <lists+linux-can@lfdr.de>; Tue, 22 Sep 2020 21:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgIVTcQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Sep 2020 15:32:16 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43662 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVTcQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Sep 2020 15:32:16 -0400
Received: by mail-il1-f194.google.com with SMTP id a19so18461996ilq.10;
        Tue, 22 Sep 2020 12:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+GmmJsG51MCJgMfktGzDABJKpTpLU9Kyx03gh5D3ALI=;
        b=oqJriJqRPot5+aQ42hF+K5oSoZBM94PD7S+3JfsWact+r4DKKz2uFNpvW07lycOBvQ
         V1xqwRxc1VnacyqEoRWO5wVTyO/aTPS0rpQLSQS/6e5dwcAKJAHbvmBB/rDcZ28eOO/P
         XtAsL2wJ+N/aV9mrHDlORp2rQedIBd5QrrE/O5AmcSGE/8LAamyNZdEJswdUPzk1u7hq
         Wb5U26cOokZrO8GMM6V5n1xl88kYGSbnxzXESm8bo9SKYSJhA8YPa7yK7bzkN+6HqmB3
         0Cwz27aXbr8h9HbqJPZYtw8lWnAupesqo+fPuhqDgSERE7vIXiYV9w0iHBIXcFTNX3v6
         kIYA==
X-Gm-Message-State: AOAM530DNo93Xw0NYfc21tSKCZ2+iBb7DVquiPW5B51R9Vn99ny7g4Jl
        +Xy0xtvehLX0lZHg2o5YCLQipl0a202j
X-Google-Smtp-Source: ABdhPJxMNLsl+j4NN8/h89sesKoG6S3FoQiIcvIwGF50BlH5Sr85Lvf1RlMhGpEOUrDIo9xfYaxjIg==
X-Received: by 2002:a92:aa01:: with SMTP id j1mr6007995ili.301.1600803134401;
        Tue, 22 Sep 2020 12:32:14 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b3sm7427280iow.28.2020.09.22.12.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:32:13 -0700 (PDT)
Received: (nullmailer pid 3094515 invoked by uid 1000);
        Tue, 22 Sep 2020 19:32:11 -0000
Date:   Tue, 22 Sep 2020 13:32:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dev.kurt@vandijck-laurijssen.be, o.rempel@pengutronix.de
Subject: Re: [PATCH 2/6] dt-bindings: can: mcp25xxfd: document device tree
 bindings
Message-ID: <20200922193211.GA3089743@bogus>
References: <20200910133806.25077-1-manivannan.sadhasivam@linaro.org>
 <20200910133806.25077-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910133806.25077-3-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Sep 10, 2020 at 07:08:02PM +0530, Manivannan Sadhasivam wrote:
> From: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> This patch adds the device-tree binding documentation for the Microchip
> MCP25xxFD SPI CAN controller family.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/net/can/microchip,mcp25xxfd.yaml | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> new file mode 100644
> index 000000000000..aa2cad14d6d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/microchip,mcp25xxfd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title:
> +  Microchip MCP2517FD and MCP2518FD stand-alone CAN controller device tree
> +  bindings
> +
> +maintainers:
> +  - Marc Kleine-Budde <mkl@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: microchip,mcp2517fd
> +        description: for MCP2517FD
> +      - const: microchip,mcp2518fd
> +        description: for MCP2518FD
> +      - const: microchip,mcp25xxfd
> +        description: to autodetect chip variant
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts-extended:

Use 'interrupts'. (interrupts-extended will automagically be supported 
by the tools)

> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that powers the CAN controller.
> +    maxItems: 1

-supply is always a single item. Drop.

> +
> +  xceiver-supply:
> +    description: Regulator that powers the CAN transceiver.
> +    maxItems: 1

ditto

> +
> +  microchip,rx-int-gpios:
> +    description:
> +      GPIO phandle of GPIO connected to to INT1 pin of the MCP25XXFD, which
> +      signals a pending RX interrupt.
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    description:
> +      Must be half or less of "clocks" frequency.
> +    maximum: 20000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts-extended

interrupts

> +  - clocks

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        can@0 {
> +            compatible = "microchip,mcp25xxfd";
> +            reg = <0>;
> +            clocks = <&can0_osc>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&can0_pins>;
> +            spi-max-frequency = <20000000>;
> +            interrupts-extended = <&gpio 13 IRQ_TYPE_LEVEL_LOW>;
> +            microchip,rx-int-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
> +            vdd-supply = <&reg5v0>;
> +            xceiver-supply = <&reg5v0>;
> +        };
> +    };
> -- 
> 2.17.1
> 
