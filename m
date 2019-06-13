Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2534744EC8
	for <lists+linux-can@lfdr.de>; Thu, 13 Jun 2019 23:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfFMV4l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 13 Jun 2019 17:56:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43639 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfFMV4l (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 13 Jun 2019 17:56:41 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so393087qka.10;
        Thu, 13 Jun 2019 14:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=k0L1wTwwBKVO8fN5HgeovJ0u361UEeJyp2XXsEpN81Q=;
        b=rdl6TLWxh3lsRves+fF0v4nXKYjXZdOes9XdBuNLHIrTxniizDd1G50h24OXZ6SgAC
         e/qqStQcZncX9RiD/CSuScI6MyIfuqfarifT1BUZlsPj/AQnphSN7mIcuiMDubz41Fqu
         N1Fq2DwkcWqMGGOPo7a2aQBCbZ/1SYQ/Fl9eqFLZiUEfR4sce8/oZl5RCLmXq11X2KP+
         5JkEeWzY8fXuyFtFzKq3oWx2LVfamGpjUbjKHPLwx3jCr52MwWANdR12K7vbXHKg6qYb
         5t3zh+za3hJRl/CyMKNxao7L/nx10A9TCk7kqA0rw/HrQtzfysaZ0hrMKLNzSdbmcqIq
         FV+Q==
X-Gm-Message-State: APjAAAX/vAUQEBPrgcM6jT1imfAJyhFa6bIBsN942ZHsp8/xLO5uA4r8
        qPNU6w4XSZE229xCqbV5CQ==
X-Google-Smtp-Source: APXvYqwLNbuO9TlEayQmZJoMDcvC6+7kJBo5YiPj+oXCNO0poz53gh1K94PHPQjtVEmwnBT2WDYb1Q==
X-Received: by 2002:a37:783:: with SMTP id 125mr72538751qkh.0.1560463000454;
        Thu, 13 Jun 2019 14:56:40 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id e66sm367426qtb.55.2019.06.13.14.56.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 14:56:39 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:56:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pankaj Bansal <pankaj.bansal@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Documentation: can: flexcan: Add flexcan clocks'
 information
Message-ID: <20190613215637.GA4455@bogus>
References: <20190516133556.15872-1-pankaj.bansal@nxp.com>
 <20190516133556.15872-2-pankaj.bansal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190516133556.15872-2-pankaj.bansal@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, May 16, 2019 at 08:12:26AM +0000, Pankaj Bansal wrote:
> The clocking information is missing from flexcan device tree bindings.
> This information is needed to be able to use flexcan. Document the same.

'dt-bindings: can: ...' for the subject.

> 
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> ---
> 
> Notes:
>     Dependencies:
>     - https://lore.kernel.org/patchwork/cover/1024536/
>     
>     V2:
>     - Removed clock-frequency from optional properties
>     - Added Dependencies in Notes
> 
>  .../bindings/net/can/fsl-flexcan.txt         | 46 +++++++++++++++++-
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> index a04168605998..73c616ca0f9a 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> @@ -12,9 +12,42 @@ Required properties:
>  - reg : Offset and length of the register set for this device
>  - interrupts : Interrupt tuple for this device
>  
> -Optional properties:
> +Clocking information is must for flexcan. please refer below info for
> +understanding clocking in flexcan:
> +
> +• The FLEXCAN module is divided into two blocks. Controller host interface
> +  ("CHI") and Protocol Engine ("PE")
> +• Both these blocks require clock.
> +• CHI is responsible for registers read write including MB read/write.
> +  While PE is responsible for Transfer/receive data on CAN bus.
> +• The clocks feeding to these two blocks can be synchronous (i.e. same clock)
> +  or asynchronous (i.e. separate clocks).
> +• Selection is made in the CLK_SRC bit (bit 13) of Control 1 Register.
> +  - CLK_SRC = 0, asynchronous i.e. separate clocks for CHI and PE
> +  - CLK_SRC = 1, synchronous i.e. CHI clock is used for PE and PE
> +                 clock is not used.
> +• If this bit is not implemented in SOC, then SOC only supports asynchronous
> +  clocks.
> +• Either of the clock can be generated by any of the clock source.
> +• When the two clocks are asynchronous, then following restrictions apply to
> +  PE clock.
> +  - PE clock must be less than CHI clock.
> +• If low jitter is required on CAN bus, dedicated oscillator can be used to
> +  provide PE clock, but it must be less than CHI clock.
> +
> +Base on above information clocking info in flexcan can be defined in two ways:

s/Base/Based/

> +
> +Method 1(Preferred):
> +  - clocks: phandle to the clocks feeding the flexcan. Two can be given:
> +    - "ipg": Protocol Engine clock
> +    - "per": Controller host interface clock
> +  - clock-names: Must contain the clock names described just above.
>  
> -- clock-frequency : The oscillator frequency driving the flexcan device
> +Method 2(Not Preferred):
> +  - clock-frequency : The synchronous clock frequency supplied to both
> +  Controller host interface and Protocol Engine
> +
> +Optional properties:
>  
>  - xceiver-supply: Regulator that powers the CAN transceiver
>  
> @@ -47,5 +80,14 @@ Example:
>  		interrupts = <48 0x2>;
>  		interrupt-parent = <&mpic>;
>  		clock-frequency = <200000000>; // filled in by bootloader
> +	};
> +
> +	can@2180000 {
> +		compatible = "fsl,lx2160ar1-flexcan";
> +		reg = <0x0 0x2180000 0x0 0x10000>;
> +		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&sysclk>, <&clockgen 4 7>;
> +		clock-names = "ipg", "per";
>  		fsl,clk-source = <0>; // select clock source 0 for PE
> +		status = "disabled";

Don't show status in examples.

>  	};
> -- 
> 2.17.1
> 
