Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE1C2047F0
	for <lists+linux-can@lfdr.de>; Tue, 23 Jun 2020 05:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgFWD0m (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Jun 2020 23:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730129AbgFWD0m (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2020 23:26:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7A9C061573
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 20:26:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q22so6371606pgk.2
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 20:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h+TqUzIHKl2R+h8rYO8/d3WB67HnCtORUPyo6F4xjPM=;
        b=mCwcbuiK9ZVMdIOqWTMnvN22kiYmlTvSTFdE0EYRb/qhEJF14Qp+HwbS5ySPWj1NPX
         CANEBmNYN80rL5rQHTpgMIoBSqrKiXq3rBoPrh4HBLaubyCN3Fh8x6ovVF9tGB+77+uW
         gd9+pAarJMSANthpPsa/U2T33GfjZlRqGFUZn1500FOEvA/WEWHGq+9zL+fZVQPjxenl
         ZgCQ4maouClDcKiEP2Uj/fco2HbtdploL6LslpRxaVKl8UMeW4+r3SPyNPfDpST0sQse
         voYFz1oaIl8/PVm6SBPsqh9VOjK2h89LFqanDuVPekIsi7Gw2YJDPs7VuhQoeZUISM+w
         HkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h+TqUzIHKl2R+h8rYO8/d3WB67HnCtORUPyo6F4xjPM=;
        b=CMyYqktJQbRbVRErhTSPcIL2vl9FV93fgttmRF5BYaLLoASMf2JjWYFBuFpIWca2kx
         RczcO4ieNQiMKfuSVl7cnyo4zVWawxC2nSkwhmpXGNvcK6+EkuGr8rgyePEIM+AFRRx3
         AXEDeElgi1xUxJDnJ5vl/2ana7Jzj4/mtPB4LQCFYOiIWufUYh9+cBup92p+1FtVSYgq
         kRU+vJOmqD3nD3nH2sa16rgzxOtE7wt5QkpN9D7U5HHqaBzRcfBeJv97PbNOCBlLpmMV
         tNHjzykfpC7T+29CkDtQDQ7r2q/wKUGKoXkhm5W/9HoYKkjxfWQQavBM3Zb21wNsSiQ2
         V6Eg==
X-Gm-Message-State: AOAM530HX21OEaGf0U9SUmDQIIN9nffSSPbJSSTZOXm36O0uMnS/oXF3
        kXofr8LqJqg9Ybt0X3wPpScsgPbC0Q==
X-Google-Smtp-Source: ABdhPJw5G5S1gtXzUG9CncEomcz8pMnXU/Kou82QQGfP2cgO/Vaqpdz7SYxFI8C3IgyPuCH6PTRoYQ==
X-Received: by 2002:a63:2a47:: with SMTP id q68mr3586751pgq.413.1592882801103;
        Mon, 22 Jun 2020 20:26:41 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:609d:7d26:d8c6:7efd:5f97:4df5])
        by smtp.gmail.com with ESMTPSA id l63sm15489636pfd.122.2020.06.22.20.26.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 20:26:40 -0700 (PDT)
Date:   Tue, 23 Jun 2020 08:56:35 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v41 2/3] dt-binding: can: mcp25xxfd: document device tree
 bindings
Message-ID: <20200623032635.GG11093@Mani-XPS-13-9360>
References: <20200622114603.965371-1-mkl@pengutronix.de>
 <20200622114603.965371-3-mkl@pengutronix.de>
 <20200622165325.GA23113@Mani-XPS-13-9360>
 <89ebabc5-dd88-32ed-65b3-911d3d80237b@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89ebabc5-dd88-32ed-65b3-911d3d80237b@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Jun 22, 2020 at 08:12:58PM +0200, Marc Kleine-Budde wrote:
> On 6/22/20 6:53 PM, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > On Mon, Jun 22, 2020 at 01:46:02PM +0200, Marc Kleine-Budde wrote:
> >> From: Oleksij Rempel <o.rempel@pengutronix.de>
> >>
> >> This patch adds the device-tree binding documentation for the Microchip
> >> MCP25xxFD SPI CAN controller family.
> >>
> >> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > 
> > You need to CC Rob and devicetree list to get a review for this patch.
> 
> Will do for next round.
> 
> > 
> >> ---
> >>  .../bindings/net/can/microchip,mcp25xxfd.yaml | 77 +++++++++++++++++++
> >>  1 file changed, 77 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> >> new file mode 100644
> >> index 000000000000..4993dd49181c
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> >> @@ -0,0 +1,77 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/net/can/microchip,mcp25xxfd.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Microchip MCP2517/18FD stand-alone CAN controller device tree bindings
> >> +
> > 
> > MCP251{7/8}FD?
> 
> Which expansion rules should be use for the title? In sh-like shells it would be
> MCP251{7,8}FD.
> 

Either one. I was just concerned about the original one which might create
ambiguity.

> > 
> >> +maintainers:
> >> +  - Marc Kleine-Budde <mkl@pengutronix.de>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    oneOf:
> >> +      - const: microchip,mcp2517fd
> >> +        description: for MCP2517FD
> >> +      - const: microchip,mcp2518fd
> >> +        description: for MCP2518FD
> >> +      - const: microchip,mcp25xxfd
> >> +        description: to autodetect chip variant
> >> +
> > 
> > Actually what benefit this generic compatible provides? User who is integrating
> > this driver should know the exact controller instance he is playing with, isn't
> > it?
> 
> As the chip variant can be autodetected why not do it? It makes device tree
> overlays (e.g. for the rpi much simpler), as you don't have to specify the exact
> chip variant.
> 
> Testing is much easier, as I don't have to change the overlays if swapping the
> CAN hat.
> 

Okay.

> > 
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  interrupts-extended:
> >> +    maxItems: 1
> >> +
> > 
> > Document this just above 'interrupts' property.
> 
> Do you mean I should change the order?
> - reg:
> - clocks:
> - interrupts-extended:
> 

Sorry, please ignore this comment. You can keep the order as it is.

> > 
> >> +  clocks:
> >> +    maxItems: 1
> >> +
> >> +  vdd-supply:
> >> +    description: Regulator that powers the CAN controller.
> >> +    maxItems: 1
> >> +
> >> +  xceiver-supply:
> >> +    description: Regulator that powers the CAN transceiver.
> >> +    maxItems: 1
> >> +
> >> +  rx-int-gpios:

This doesn't look like a standard property. So I think you need to add
'microchip' prefix to make it as vendor specific.

> >> +    description:
> >> +      GPIO phandle of GPIO connected to to INT1 pin of the MCP25XXFD, which
> >> +      signals a pending RX interrupt.
> >> +    maxItems: 1
> >> +
> >> +  spi-max-frequency:
> >> +    description:
> >> +      Must be half or less of "clocks" frequency.
> >> +    maximum: 20000000
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - interrupts-extended
> >> +  - clocks
> >> +
> > 
> > The controller is capable of generating clocks and also able to control few
> > GPIOs. So eventually you need to document those properties in bindings even
> > your driver is not supporting all of them atm.
> 
> I'd like to add support for clocks and GPIOs as soon as someone needs them. DT
> bindings will go along with that. So far I have no customer that needs support
> for that, do you?
> 

DT binding should describe what the controller is capable of and not the
capability of the driver. You can always add functionality to driver but binding
should stay as it is (although there are exceptions...).

Thanks,
Mani

> > If you want you can take a look at the bindings patch I posted earlier:
> > 
> > dt-bindings: can: Document devicetree bindings for MCP25XXFD
> 
> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
