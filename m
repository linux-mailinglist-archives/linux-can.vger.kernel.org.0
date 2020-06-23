Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AB0204997
	for <lists+linux-can@lfdr.de>; Tue, 23 Jun 2020 08:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgFWGMv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Jun 2020 02:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgFWGMv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Jun 2020 02:12:51 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49376C061573
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 23:12:51 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a127so9578999pfa.12
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 23:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v7Rp3kIubI66vVs2M1v4KEsSGgfZRwNIg0IOkOlV83I=;
        b=BNyb3T/EYosAo3F4BhuWXrZcS/gcfqUq6Aux11dQ5mGhvQftXWvbawPizowHsG/IhX
         Hu7NjIR9HtSYC804LodioNP2q8B0rqwWZnVUhVEhFfNC++tcHk8UwDDkvidejWbYRjzK
         W2NQXGjClUwu3hLHd246wTM69XVH72FVSBb/vG1WxOsSdyvd6BDURpWali2F2kF/32St
         ZR5LuaqbM1Nb+bjwRLb7zKDVLLAuURBeylbaBpaF+S1nZ1UJuR0Xxdm8E22MdE+/zFLx
         NuPZ4VmMEPDdu5OOxqJ9JdLFlfmLRHs/EmtIbIpw+CibGd+BMTQj5lPhaIMc/zhZby3W
         F3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v7Rp3kIubI66vVs2M1v4KEsSGgfZRwNIg0IOkOlV83I=;
        b=Khr3T2y55ENUWh7UaxZoLH1HxK/Tf32AdoUOillwzdieHdpb3qHPM/3LIwpxUAYKAy
         o0wIJfSNfOS2TppoHUX/jDts9/kXZ9+qWFUcZRKrloEXevXM29cSJV6EvU5AvKvlj6ZZ
         diUmcz0ZHFfdae7TA6ls7BlmjGbcPqfX1w70DXwKbQKAPclW1i4IWj/9HoidwfEI5MFE
         7VLULixvfb71tSZUXR81gjWsjN5UdMxtI9953l4rgG/YI4Zcp7YWGOktu2SyUEi9V8j/
         1gTg1fUcskwJNWShL7jZ8CJaG78p5jP386PH8xPakepsHOypp8zpmeLS1geO9ieuhxPm
         hBJA==
X-Gm-Message-State: AOAM533HW6WIwKGGhq76HQerKLYlrreE417yS1qgN24RcSfg0A94yXfg
        877znTvcAyxira6QuxCdVw4v
X-Google-Smtp-Source: ABdhPJyxfIdyxtwYK8cRMfEtD+0Kn5MC+XDP9H/6EFsM9GWo00z8Rk4hig9MUzu1lCANPd3sncpBRw==
X-Received: by 2002:a65:4908:: with SMTP id p8mr15628410pgs.214.1592892770592;
        Mon, 22 Jun 2020 23:12:50 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:609d:7d26:e4ff:f0b0:edd6:2484])
        by smtp.gmail.com with ESMTPSA id bv16sm1227319pjb.46.2020.06.22.23.12.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 23:12:50 -0700 (PDT)
Date:   Tue, 23 Jun 2020 11:42:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        dev.kurt@vandijck-laurijssen.be
Subject: Re: [PATCH v41 2/3] dt-binding: can: mcp25xxfd: document device tree
 bindings
Message-ID: <20200623061244.GA13669@Mani-XPS-13-9360>
References: <20200622114603.965371-1-mkl@pengutronix.de>
 <20200622114603.965371-3-mkl@pengutronix.de>
 <20200622165325.GA23113@Mani-XPS-13-9360>
 <89ebabc5-dd88-32ed-65b3-911d3d80237b@pengutronix.de>
 <20200623032635.GG11093@Mani-XPS-13-9360>
 <20200623060201.ms2brvzk7s6arnjf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623060201.ms2brvzk7s6arnjf@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Jun 23, 2020 at 08:02:01AM +0200, Oleksij Rempel wrote:
> On Tue, Jun 23, 2020 at 08:56:35AM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jun 22, 2020 at 08:12:58PM +0200, Marc Kleine-Budde wrote:
> > > On 6/22/20 6:53 PM, Manivannan Sadhasivam wrote:
> > > > Hi,
> > > > 
> > > > On Mon, Jun 22, 2020 at 01:46:02PM +0200, Marc Kleine-Budde wrote:
> > > >> From: Oleksij Rempel <o.rempel@pengutronix.de>
> > > >>
> > > >> This patch adds the device-tree binding documentation for the Microchip
> > > >> MCP25xxFD SPI CAN controller family.
> > > >>
> > > >> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > > 
> > > > You need to CC Rob and devicetree list to get a review for this patch.
> > > 
> > > Will do for next round.
> > > 
> > > > 
> > > >> ---
> > > >>  .../bindings/net/can/microchip,mcp25xxfd.yaml | 77 +++++++++++++++++++
> > > >>  1 file changed, 77 insertions(+)
> > > >>  create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> > > >>
> > > >> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> > > >> new file mode 100644
> > > >> index 000000000000..4993dd49181c
> > > >> --- /dev/null
> > > >> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> > > >> @@ -0,0 +1,77 @@
> > > >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > >> +%YAML 1.2
> > > >> +---
> > > >> +$id: http://devicetree.org/schemas/net/can/microchip,mcp25xxfd.yaml#
> > > >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > >> +
> > > >> +title: Microchip MCP2517/18FD stand-alone CAN controller device tree bindings
> > > >> +

[...]

> > > >> +required:
> > > >> +  - compatible
> > > >> +  - reg
> > > >> +  - interrupts-extended
> > > >> +  - clocks
> > > >> +
> > > > 
> > > > The controller is capable of generating clocks and also able to control few
> > > > GPIOs. So eventually you need to document those properties in bindings even
> > > > your driver is not supporting all of them atm.
> > > 
> > > I'd like to add support for clocks and GPIOs as soon as someone needs them. DT
> > > bindings will go along with that. So far I have no customer that needs support
> > > for that, do you?
> > > 
> > 
> > DT binding should describe what the controller is capable of and not the
> > capability of the driver. You can always add functionality to driver but binding
> > should stay as it is (although there are exceptions...).
> 
> Adding binding for not implemented functionality adds more confusion:
> - without implementing it, you do not know, how exactly should it be
>   done. Should we request gpio as gpio or as irq? This will affect
>   actual bindings.
> - we need to care about backwards compatibility, implementing binding
>   before knowing what they will do, will make driver development even harder.
>   You need to care about quirks for bogus binding which was actually
>   never used.
> - Extending a binding can be always done if needed. Making things "just
>   in case" will increase development overhead by reducing quality.
> 

This is not my call. Rob asked me to document all device specific properties
in binding before for some other controller. Let's see his response in next
iteration (we need to ask this question though).

Thanks,
Mani

> Regards,
> Oleksij
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


