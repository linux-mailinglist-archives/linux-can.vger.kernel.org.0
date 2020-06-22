Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625AA203D2A
	for <lists+linux-can@lfdr.de>; Mon, 22 Jun 2020 18:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgFVQxc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Jun 2020 12:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbgFVQxb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2020 12:53:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC929C061573
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 09:53:31 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jz3so101209pjb.0
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NpkpcotZmGj4i0NBx5etUjZX6gHgwGTv4I+/nW7jWnk=;
        b=ZpWmsDYP/NXKdELvA9R27i6+YI1KfuTGt39P9dCp7zTpFUUQil3nCsdHJkV7MoCfRP
         hGW7JkuL1F+7x8yEUtOHp4Rp1YPRklVyOzunraNVl+7WZyLUfTK+HLe41TWdkNGNhipj
         gWsU4ueSjZXilefNduhyIP5Azwz/B8eUe1FcCcE/Ng5BrTb6HtAp1/FT+j9Jq/9+MW6M
         2UG5/A880rFoEz+H3BVn/YjwfJlzQBGQXz7XoJamjFt9SMR0slAf/WZrD4tBk3ygTeIi
         S3hxqDI0Q4tA/DubsHoN58XBuzs8gcTUW29gwQAawsBONxertJ4TYBFswQfJvY6ITLQk
         LpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NpkpcotZmGj4i0NBx5etUjZX6gHgwGTv4I+/nW7jWnk=;
        b=OqlmLzLeyyHxDoW6SDrKbGpZJr41bCzkoXsVwb/CVzBkF6CMfeH7ZMQwu9EbBiqfgZ
         KOLHrjfGzhtxLCLsxvCqS+Q50IajgAQUo20rlvfBt6c7JBTH4X7F5fW1cvy8ZSrJXtd3
         vPSm43Ihix9T9vCTcncNT/pHnq/4ZulMebDg/TWL9vtOlUlc8Ykzoarr4j4cbS/AglJl
         YPwpx9cF1ccn+9anSi+q4GuwFadYkW8Cu+AH1fKnDHfiAjOL1SpcglbcYdemXK2vbHhE
         L2pCFxtos4tDT7IzaeLVPIvLqv7VyHK9rd5lKhji6XoDfBYMqMykPsUnP05PMqDaQ594
         zGBw==
X-Gm-Message-State: AOAM533Mt21v9+aRjEHPH12f9MRNHL6VXYXdbYHPHJbN+v20uJDmvJvn
        +OxbXxyr1+u7wcMWQNJqvMQlWjW16Q==
X-Google-Smtp-Source: ABdhPJzi+wAQQZXzhFOmSTFmQdaWArce6HE61YJt26LWFgGelLgBdAwjSo0bBv2t7InLOqqvJszg7w==
X-Received: by 2002:a17:90a:4d4e:: with SMTP id l14mr382693pjh.10.1592844810989;
        Mon, 22 Jun 2020 09:53:30 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e9c:5ed9:f1ab:10ef:79f6:adb2])
        by smtp.gmail.com with ESMTPSA id o186sm11738489pgo.65.2020.06.22.09.53.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 09:53:30 -0700 (PDT)
Date:   Mon, 22 Jun 2020 22:23:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v41 2/3] dt-binding: can: mcp25xxfd: document device tree
 bindings
Message-ID: <20200622165325.GA23113@Mani-XPS-13-9360>
References: <20200622114603.965371-1-mkl@pengutronix.de>
 <20200622114603.965371-3-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622114603.965371-3-mkl@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

On Mon, Jun 22, 2020 at 01:46:02PM +0200, Marc Kleine-Budde wrote:
> From: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> This patch adds the device-tree binding documentation for the Microchip
> MCP25xxFD SPI CAN controller family.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

You need to CC Rob and devicetree list to get a review for this patch.

> ---
>  .../bindings/net/can/microchip,mcp25xxfd.yaml | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> new file mode 100644
> index 000000000000..4993dd49181c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/microchip,mcp25xxfd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP2517/18FD stand-alone CAN controller device tree bindings
> +

MCP251{7/8}FD?

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

Actually what benefit this generic compatible provides? User who is integrating
this driver should know the exact controller instance he is playing with, isn't
it?

> +  reg:
> +    maxItems: 1
> +
> +  interrupts-extended:
> +    maxItems: 1
> +

Document this just above 'interrupts' property.

> +  clocks:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that powers the CAN controller.
> +    maxItems: 1
> +
> +  xceiver-supply:
> +    description: Regulator that powers the CAN transceiver.
> +    maxItems: 1
> +
> +  rx-int-gpios:
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
> +  - clocks
> +

The controller is capable of generating clocks and also able to control few
GPIOs. So eventually you need to document those properties in bindings even
your driver is not supporting all of them atm.

If you want you can take a look at the bindings patch I posted earlier:

dt-bindings: can: Document devicetree bindings for MCP25XXFD

Thanks,
Mani

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
> +            rx-int-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
> +            vdd-supply = <&reg5v0>;
> +            xceiver-supply = <&reg5v0>;
> +        };
> +    };
> -- 
> 2.27.0
> 
