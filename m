Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555F04A476E
	for <lists+linux-can@lfdr.de>; Mon, 31 Jan 2022 13:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiAaMoa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 31 Jan 2022 07:44:30 -0500
Received: from dd15738.kasserver.com ([85.13.151.39]:46630 "EHLO
        dd15738.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiAaMoa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 31 Jan 2022 07:44:30 -0500
Received: from dd15738.kasserver.com (dd0802.kasserver.com [85.13.143.1])
        by dd15738.kasserver.com (Postfix) with ESMTPSA id B17CE5B0007E;
        Mon, 31 Jan 2022 13:44:28 +0100 (CET)
Subject: Re: MCP2518FD : Failed to detect MCP2518FD (osc=0x00000000)
To:     mkl@pengutronix.de
References: <20220131083304.122C45B0007E@dd15738.kasserver.com>
 <20220131084205.53otmukeyt2dt4zj@pengutronix.de>
 <20220131093554.505C65B0025F@dd15738.kasserver.com><20220131095849.5iw4jgeexc3egnb6@pengutronix.de>
Cc:     linux-can@vger.kernel.org
From:   petter@ka-long.de
User-Agent: ALL-INKL Webmail 2.11
X-SenderIP: 95.223.83.221
MIME-Version: 1.0
In-Reply-To: <20220131095849.5iw4jgeexc3egnb6@pengutronix.de>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20220131124428.B17CE5B0007E@dd15738.kasserver.com>
Date:   Mon, 31 Jan 2022 13:44:28 +0100 (CET)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

DMA is disabled. CLK and MOSI are looking fine.

Very interessing, CSs are not asserted when loading driver (on old kernel it does), but I can measure "high" after HW initialisation.

Since I did not change the IOs between the old and new device tree assuming the "high" on CS also showing correct PAD / GPIO configuration there seems a problem asserting the CS.




cat /sys/kernel/debug/gpio looks good (gpio-3 and gpio-129)


gpiochip0: GPIOs 0-31, parent: platform/30200000.gpio, 30200000.gpio:
 gpio-3   (                    |spi1 CS1            ) out hi ACTIVE LOW
 gpio-5   (                    |regulator-vbus      ) out lo

gpiochip1: GPIOs 64-95, parent: platform/30220000.gpio, 30220000.gpio:
 gpio-67  (                    |spi3 CS0            ) out hi ACTIVE LOW

gpiochip2: GPIOs 96-127, parent: platform/30230000.gpio, 30230000.gpio:

gpiochip3: GPIOs 128-159, parent: platform/30240000.gpio, 30240000.gpio:
 gpio-128 (                    |cd                  ) in  hi IRQ ACTIVE LOW
 gpio-129 (                    |spi1 CS0            ) out hi ACTIVE LOW


BR
Niels

Marc Kleine-Budde schrieb am 31.01.2022 09:58 (GMT +00:00):

> On 31.01.2022 10:35:54, petter@ka-long.de wrote:
>> I have disabled DMAs in imx7s.dtsi for all ecspis and recompile the
>> device tree. Still get the same failure.
> 
> You can check if that really works by looking at the used DT:
> 
> $ dtc -I fs /proc/device-tree
> 
> Next step would be to get a scope and attach it to the MISO/MOSI/CLk/CS
> pins.
> 
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
> 
