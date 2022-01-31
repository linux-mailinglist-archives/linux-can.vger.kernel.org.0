Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DAC4A4926
	for <lists+linux-can@lfdr.de>; Mon, 31 Jan 2022 15:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377680AbiAaOPF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 31 Jan 2022 09:15:05 -0500
Received: from dd15738.kasserver.com ([85.13.151.39]:53814 "EHLO
        dd15738.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358531AbiAaOPF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 31 Jan 2022 09:15:05 -0500
Received: from dd15738.kasserver.com (dd0802.kasserver.com [85.13.143.1])
        by dd15738.kasserver.com (Postfix) with ESMTPSA id C111C5B00631;
        Mon, 31 Jan 2022 15:15:03 +0100 (CET)
Subject: Re: MCP2518FD : Failed to detect MCP2518FD (osc=0x00000000)
To:     mkl@pengutronix.de
References: <20220131083304.122C45B0007E@dd15738.kasserver.com>
 <20220131084205.53otmukeyt2dt4zj@pengutronix.de>
 <20220131093554.505C65B0025F@dd15738.kasserver.com>
 <20220131095849.5iw4jgeexc3egnb6@pengutronix.de>
 <20220131124428.B17CE5B0007E@dd15738.kasserver.com><20220131130911.nyfg5ojq77hbqc7d@pengutronix.de>
Cc:     linux-can@vger.kernel.org
From:   petter@ka-long.de
User-Agent: ALL-INKL Webmail 2.11
X-SenderIP: 95.223.83.221
MIME-Version: 1.0
In-Reply-To: <20220131130911.nyfg5ojq77hbqc7d@pengutronix.de>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20220131141503.C111C5B00631@dd15738.kasserver.com>
Date:   Mon, 31 Jan 2022 15:15:03 +0100 (CET)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


Hi Marc,

CS = High (de-asserted, slave not selected)
CS = low (asserted, slave selected)

I also did not like the 0/1 starting point, but it is defined here:

        aliases {
                gpio0 = &gpio1;
                gpio1 = &gpio2;
                gpio2 = &gpio3;
                ...



&gpio1 3 = gpiochip0 = 0*32 + 3 = gpio3
&gpio5 1 = gpiochip4 = 4*32 + 1 = gpio129

Interresting with ACTIVE HIGH / LOW. cat debug/gpio tells me "ACTIVE LOW" but anyway I did not see CS toggle at all. Also tested "1" but nothing changed.

By the way, the old kernel is working with the new device tree.

I did a make clean and make sure that I really use latest build artefacts. Everything is okay. Still failure.

Maybe there are problems when using "make imx_v7_defconfig" ... possible conflicts between drivers because there are much changes between 5.4 and 5.10 whats enabled and/or new by default ?
Try to go with a very small kernel.

BR
Niels














Marc Kleine-Budde schrieb am 31.01.2022 13:09 (GMT +00:00):

> On 31.01.2022 13:44:28, petter@ka-long.de wrote:
>> DMA is disabled. CLK and MOSI are looking fine.
>> 
>> Very interessing, CSs are not asserted when loading driver (on old
>> kernel it does), but I can measure "high" after HW initialisation.
> 
> Asserted means low?
> 
>> Since I did not change the IOs between the old and new device tree
>> assuming the "high" on CS also showing correct PAD / GPIO
>> configuration there seems a problem asserting the CS.
> 
> | &ecspi2 {
> |         pinctrl-names = "default";
> |         pinctrl-0 = <&pinctrl_ecspi2>;
> |         status = "okay";
> | 
> |         fsl,spi-num-chipselects = <2>;
>                            V
> |         cs-gpios = <&gpio5 1 0>, <&gpio1 3 0>;
>                                ^             ^
> Have a look at include/dt-bindings/gpio/gpio.h:
> 
> /* Bit 0 express polarity */
> #define GPIO_ACTIVE_HIGH 0
> #define GPIO_ACTIVE_LOW 1
> 
> I'm using GPIO_ACTIVE_LOW in my DT on imx6dl.
> 
> |                              
> | 
> |         mcp2518fd@0 {
> |                 compatible = "microchip,mcp2518fd";
> |                 reg = <0>;
> |                 interrupts-extended = <&gpio3 0 IRQ_TYPE_LEVEL_LOW>;
> |                 spi-max-frequency = <20000000>;
> |                 clocks = <&mcp2518fd_clk>;
> |         };                                                                    
>                                                                                
>                                                                                
>                  
> | 
> |         mcp2518fd@1 {
> |                 compatible = "microchip,mcp2518fd";
> |                 reg = <1>;
> |                 interrupts-extended = <&gpio4 23 IRQ_TYPE_LEVEL_LOW>;
> |                 spi-max-frequency = <20000000>;
> |                 clocks = <&mcp2518fd_clk>;
> |         };                                                                    
>                                                                                
>                                                                                
>                  
> | };           
> 
>> cat /sys/kernel/debug/gpio looks good (gpio-3 and gpio-129)
> 
> This doesn't look consistent with your DT, above. I'm always confused
> with numbering starting with 0 and 1 in the DT, but I think:
> 
> gpiochip0: gpio-3       == &gpio1 3
> gpiochip3: gpio-129     == &gpio4 1     (not &gpio5 1 as in you DT)
> 
>> gpiochip0: GPIOs 0-31, parent: platform/30200000.gpio, 30200000.gpio:
>>  gpio-3   (                    |spi1 CS1            ) out hi ACTIVE LOW
>>  gpio-5   (                    |regulator-vbus      ) out lo
>> 
>> gpiochip1: GPIOs 64-95, parent: platform/30220000.gpio, 30220000.gpio:
>>  gpio-67  (                    |spi3 CS0            ) out hi ACTIVE LOW
>> 
>> gpiochip2: GPIOs 96-127, parent: platform/30230000.gpio, 30230000.gpio:
>> 
>> gpiochip3: GPIOs 128-159, parent: platform/30240000.gpio, 30240000.gpio:
>>  gpio-128 (                    |cd                  ) in  hi IRQ ACTIVE LOW
>>  gpio-129 (                    |spi1 CS0            ) out hi ACTIVE LOW
> 
> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
> 
