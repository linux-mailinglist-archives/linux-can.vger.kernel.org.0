Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE9F88B4
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2019 07:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbfKLGq3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Nov 2019 01:46:29 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:42366 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfKLGq2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Nov 2019 01:46:28 -0500
Received: by mail-pg1-f170.google.com with SMTP id q17so11170717pgt.9
        for <linux-can@vger.kernel.org>; Mon, 11 Nov 2019 22:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JGub9REVao095o6Mnc3+3Xr/iPqOifkxoBhhY6xLuUk=;
        b=jNDVp6M28jMQzCZq5PYYE51+9nTyC8a60wO7S/1cbYsbU9ATVf+PTd5qQloCDBenEq
         McJocT/wCBJOXe7FE4XzH5rmUPzCtQ9YO2eKTN6wyTlcA1MEOU5CHu8nnKntIUr7+/2q
         UpuOy24vSOVvcvLQ0z4Ij0DT6EbQt4tw3tPFuiIpCYEAAI38Ew+H/4oHyNp2Z1UYFWWF
         wNfJLuy4W8udE/DSl0V1aNHqrEnlv47EodwPjXPQUjh8LLjSs3Zuoh+hTdlqVCxdjyxt
         c13u8/zYMP3Fjf8I1a4ugC4o90IejLZMWlH2cLiaoKfv5UXF1ZFfsynxQXCXwvwdm3z9
         45zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JGub9REVao095o6Mnc3+3Xr/iPqOifkxoBhhY6xLuUk=;
        b=Z2d5Gn1tnCDdDlQoS3ANdLD4FqJJZ72P8HAWayb44Cmal4+LGZO+GQQxIaM7qEbylr
         MkuBmZjT0zh318aANthAiXVaWwo/H7O7DVjV35xf5x5vjSk6dAgcjtaRG3d9gsQEB8a9
         QzbqaYwFEwKQZ/X0jBcDz3y6SNvy7V687v+swRANJLqVbN0jo5jNAA03u1JE7/TY4VSD
         LjpfUclUmXSp0IU/yhGTYGrpogPTAj1P2w723O0cmAnYNDxu/9qD/hHgtMIYJgk2x5HX
         Vos0tV/UFqWlhdg+oS72v+DTPBePPDby6iqqeAo3kSFDu6Rc++X7D1bp+E1Sv39VCRII
         7buw==
X-Gm-Message-State: APjAAAVXLtpzHi/hO7fFvO1V/TTSxEGu6zL6G7+xJ94u7dLyloThdayT
        4TzulApgJUlmuY2PuxrGr7Y=
X-Google-Smtp-Source: APXvYqxZGriO10L0UEvt83zqC/pqNJeOdzdQF844BKOHGlfauVKhnxi4N+35ieeCiN9IWIw1hILnmA==
X-Received: by 2002:a63:af13:: with SMTP id w19mr32038896pge.189.1573541187654;
        Mon, 11 Nov 2019 22:46:27 -0800 (PST)
Received: from x1 ([2602:41:6630:600:126:f04:dc48:e148])
        by smtp.gmail.com with ESMTPSA id e1sm16528408pgv.82.2019.11.11.22.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 22:46:26 -0800 (PST)
Date:   Mon, 11 Nov 2019 22:46:24 -0800
From:   Drew Fustini <drew@pdp7.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Drew Fustini <pdp7pdp7@gmail.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: mcp251x: read oscillator frequency?
Message-ID: <20191112064624.GA13873@x1>
References: <CAEf4M_AVk=2cZJ4LQ8QdnNa=6se4bCLkBPLFY5qR=ECpaq7ZKg@mail.gmail.com>
 <9d854335-366a-0b7f-1985-5e1d3245d33a@pengutronix.de>
 <20191111183912.GA7051@x1>
 <e61a86f9-c201-458c-2522-a8044e93bc08@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e61a86f9-c201-458c-2522-a8044e93bc08@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Nov 11, 2019 at 10:23:46PM +0100, Marc Kleine-Budde wrote:
> On 11/11/19 7:39 PM, Drew Fustini wrote:
> >> I assume you get the 8MHz clock rate from the "ip" output, right?
> 
> > I added printk to output the value of:
> > freq = clk_get_rate(clk);
> > 
> > which is from line 1041:
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/can/spi/mcp251x.c#L1041
> > 
> > which shows:
> > mcp251x_can_probe: clk_get_rate(clk)=8000000
> 
> Ok, then let's check if the device tree contains the correct value. Can
> you send the output of:
> 
>     dtc -I fs -O dts /proc/device-tree
> 


/dts-v1/;

/ {
        compatible = "ti,am335x-pocketbeagle", "ti,am335x-bone", "ti,am33xx";
        serial-number = "1740GPB21127";
        model = "TI AM335x PocketBeagle";
        interrupt-parent = <0x1>;
        #address-cells = <0x1>;
        #size-cells = <0x1>;

        mcp2515_clock {
                compatible = "fixed-clock";
                #clock-cells = <0x0>;
                phandle = <0x21a>;
                clock-frequency = <0xf42400>;
                linux,phandle = <0x21a>;
        };

<snip>

                        mcp2515@1 {
                                compatible = "microchip,mcp2515";
                                clocks = <0x21a>;
                                mcp251x,irq-gpios = <0x196 0x1c 0x0>;
                                mcp251x,stay-awake = <0x1>;
                                mcp251x,oscillator-frequency = <0xf42400>;
                                status = "okay";
                                interrupt-parent = <0x196>;
                                interrupts = <0x1c 0x2>;
                                mcp251x,enable-clkout = <0x1>;
                                phandle = <0x21b>;
                                reg = <0x1>;
                                pinctrl-0 = <0x219>;
                                linux,phandle = <0x21b>;
                                spi-max-frequency = <0x989680>;
                                pinctrl-names = "default";
                        };


0xf42400 is 16MHz so it does look like device tree has the correct value.

Maybe I am not defining the clock correctly?

It doesn't appear that the call clk_get_rate(clk) returns the value defined in DT.


thanks,
drew
