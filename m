Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7913613DC
	for <lists+linux-can@lfdr.de>; Thu, 15 Apr 2021 23:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhDOVJN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 15 Apr 2021 17:09:13 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:41618 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbhDOVJN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Apr 2021 17:09:13 -0400
Received: by mail-oo1-f50.google.com with SMTP id h2-20020a4ad7420000b02901e5901169a5so5473376oot.8;
        Thu, 15 Apr 2021 14:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dBWyxdU6sbfl8J7+Mi7uwU0zvgg5AWmI3XulvlHXtE0=;
        b=ZAQindKyZfVSQue+qmfd5XJbMmoebS8y3xd0EEM4fpDF8F+mwvf+0oqsRfaohngRl0
         uLeVs74cqngBI5RKIGmOqLYmMv5jJVlToR2cZWsajw2eMVdEpfHcRMkBb2SYboN8RixC
         3KBryPJgE7Q75A00yeY6Cxmm/KauQr0ZUsSzYf5hlHkLlhDATskbUzuF44cpgMEGYz3B
         kqsFPZcW8d3IMoX0EgvMpEg/C7ukRawBrsePo1lZOEXZC7g9iM3B1gTloCYnNdCF/V4d
         FFqeUCZTADIZQDosr6ESYturnlH9EXTIP368941HehlqT4/TIXuOuvc/PIZSI6EHE6J/
         oLyA==
X-Gm-Message-State: AOAM5323eO6raS1MFYsflmJDWhje+JNM8wNDyXYLF28ZmgsQoVqmiSpt
        NofB4dH1QdDcvheejC3A9ePyIV0QJQ==
X-Google-Smtp-Source: ABdhPJx11jv44MnT6jEOw+QxwzTP6f31Jok0fQUAizHEBbO1vMUV/JhaP/Ge0LqyHPQWXhQI3Xv5Ig==
X-Received: by 2002:a4a:4304:: with SMTP id k4mr816573ooj.42.1618520927976;
        Thu, 15 Apr 2021 14:08:47 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i11sm778714oot.11.2021.04.15.14.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 14:08:47 -0700 (PDT)
Received: (nullmailer pid 1885798 invoked by uid 1000);
        Thu, 15 Apr 2021 21:08:46 -0000
Date:   Thu, 15 Apr 2021 16:08:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-can@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: phy: Add binding for TI TCAN104x CAN
 transceivers
Message-ID: <20210415210846.GA1871445@robh.at.kernel.org>
References: <20210415144947.4725-1-a-govindraju@ti.com>
 <20210415144947.4725-4-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415144947.4725-4-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Apr 15, 2021 at 08:19:46PM +0530, Aswath Govindraju wrote:
> Add binding documentation for TI TCAN104x CAN transceivers.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  .../bindings/phy/ti,tcan104x-can.yaml         | 56 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> new file mode 100644
> index 000000000000..4643b979930a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/ti,tcan104x-can.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: TCAN104x CAN TRANSCEIVER PHY
> +
> +maintainers:
> +  - Aswath Govindraju <a-govindraju@ti.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^tcan104x-phy"

Node names should be generic. So 'phy' or 'can-phy'.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +  compatible:
> +    enum:
> +      - ti,tcan1042
> +      - ti,tcan1043
> +
> +  '#phy-cells':
> +    const: 0
> +
> +  standby-gpios:
> +    description:
> +      gpio node to toggle standby signal on transceiver
> +    maxItems: 1
> +
> +  enable-gpios:
> +    description:
> +      gpio node to toggle enable signal on transceiver
> +    maxItems: 1
> +
> +  max-bitrate:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      max bit rate supported in bps
> +    minimum: 1
> +
> +required:
> +  - compatible
> +  - '#phy-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    transceiver1: tcan104x-phy {
> +      compatible = "ti,tcan1043";
> +      #phy-cells = <0>;
> +      max-bitrate = <5000000>;
> +      standby-gpios = <&wakeup_gpio1 16 GPIO_ACTIVE_LOW>;
> +      enable-gpios = <&main_gpio1 67 GPIO_ACTIVE_HIGH>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 84ef96a444c3..e666d33af10d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4046,6 +4046,7 @@ W:	https://github.com/linux-can
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
>  F:	Documentation/devicetree/bindings/net/can/
> +F:	Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
>  F:	drivers/net/can/
>  F:	include/linux/can/bittiming.h
>  F:	include/linux/can/dev.h
> -- 
> 2.17.1
> 
