Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D174B4A58F1
	for <lists+linux-can@lfdr.de>; Tue,  1 Feb 2022 10:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiBAJIL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Feb 2022 04:08:11 -0500
Received: from dd15738.kasserver.com ([85.13.151.39]:54014 "EHLO
        dd15738.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiBAJIK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Feb 2022 04:08:10 -0500
Received: from dd15738.kasserver.com (dd0802.kasserver.com [85.13.143.1])
        by dd15738.kasserver.com (Postfix) with ESMTPSA id ABBD45B0068C;
        Tue,  1 Feb 2022 10:08:08 +0100 (CET)
Subject: Re: MCP2518FD : Failed to detect MCP2518FD (osc=0x00000000)
To:     mkl@pengutronix.de
References: <20220131083304.122C45B0007E@dd15738.kasserver.com>
 <20220131084205.53otmukeyt2dt4zj@pengutronix.de>
 <20220131093554.505C65B0025F@dd15738.kasserver.com>
 <20220131095849.5iw4jgeexc3egnb6@pengutronix.de>
 <20220131124428.B17CE5B0007E@dd15738.kasserver.com>
 <20220131130911.nyfg5ojq77hbqc7d@pengutronix.de>
 <20220131141503.C111C5B00631@dd15738.kasserver.com><20220131151735.mfxzloeppny62ow2@pengutronix.de>
Cc:     linux-can@vger.kernel.org
From:   petter@ka-long.de
User-Agent: ALL-INKL Webmail 2.11
X-SenderIP: 95.223.83.221
MIME-Version: 1.0
In-Reply-To: <20220131151735.mfxzloeppny62ow2@pengutronix.de>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20220201090808.ABBD45B0068C@dd15738.kasserver.com>
Date:   Tue,  1 Feb 2022 10:08:08 +0100 (CET)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Folks,

Embarrassing ...

There was a small build of 5. There was an hw change afterwarts regardging CS. Reworked 4/5. I got the one without rework but special "local" working test software.
I wonder why switching to master is not working ...

Sorry for your time lapse.

BR
Niels






Marc Kleine-Budde schrieb am 31.01.2022 15:17 (GMT +00:00):

> On 31.01.2022 15:15:03, petter@ka-long.de wrote:
>>
>> Hi Marc,
>>
>> CS = High (de-asserted, slave not selected)
>> CS = low (asserted, slave selected)
>>
>> I also did not like the 0/1 starting point, but it is defined here:
>>
>>         aliases {
>>                 gpio0 = &gpio1;
>>                 gpio1 = &gpio2;
>>                 gpio2 = &gpio3;
>>                 ...
>>
>>
>>
>> &gpio1 3 = gpiochip0 = 0*32 + 3 = gpio3
>> &gpio5 1 = gpiochip4 = 4*32 + 1 = gpio129
> 
> In your output of /sys/kernel/debug/gpio, gpiochip3 starts at 128:
> 
>>> gpiochip3: GPIOs 128-159, parent: platform/30240000.gpio, 30240000.gpio:
>>>  gpio-128 (                    |cd                  ) in  hi IRQ ACTIVE LOW
>>>  gpio-129 (                    |spi1 CS0            ) out hi ACTIVE LOW
> 
> Here it looks like this:
> 
> gpiochip4: GPIOs 128-159, parent: platform/20ac000.gpio, 20ac000.gpio:
>  gpio-130 (EIM_A25             |user1               ) out lo ACTIVE LOW
>  gpio-133 (GPIO5_05            )
>  gpio-134 (GPIO5_06            |reset               ) out lo
>  gpio-135 (GPIO5_07            )
>  gpio-136 (GPIO5_08            )
>  gpio-137 (CSPI2_CS1           |spi1 CS1            ) out hi ACTIVE LOW
>  gpio-138 (CSPI2_MOSI          )
>  gpio-139 (CSPI2_MISO          )
>  gpio-140 (CSPI2_CS0           |spi1 CS0            ) out hi ACTIVE LOW
>  gpio-141 (CSPI2_CLK           )
> 
>> Interresting with ACTIVE HIGH / LOW. cat debug/gpio tells me "ACTIVE
>> LOW" but anyway I did not see CS toggle at all. Also tested "1" but
>> nothing changed.
>>
>> By the way, the old kernel is working with the new device tree.
>>
>> I did a make clean and make sure that I really use latest build
>> artefacts. Everything is okay. Still failure.
>>
>> Maybe there are problems when using "make imx_v7_defconfig" ...
>> possible conflicts between drivers because there are much changes
>> between 5.4 and 5.10 whats enabled and/or new by default ? Try to go
>> with a very small kernel.
> 
> There shouldn't be any conflicts between drivers.
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
