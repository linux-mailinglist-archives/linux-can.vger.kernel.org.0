Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424BD4A3F50
	for <lists+linux-can@lfdr.de>; Mon, 31 Jan 2022 10:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbiAaJf6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 31 Jan 2022 04:35:58 -0500
Received: from dd15738.kasserver.com ([85.13.151.39]:60570 "EHLO
        dd15738.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbiAaJf4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 31 Jan 2022 04:35:56 -0500
Received: from dd15738.kasserver.com (dd0802.kasserver.com [85.13.143.1])
        by dd15738.kasserver.com (Postfix) with ESMTPSA id 505C65B0025F;
        Mon, 31 Jan 2022 10:35:54 +0100 (CET)
Subject: Re: MCP2518FD : Failed to detect MCP2518FD (osc=0x00000000)
To:     linux-can@vger.kernel.org
References: <20220131083304.122C45B0007E@dd15738.kasserver.com><20220131084205.53otmukeyt2dt4zj@pengutronix.de>
Cc:     mkl@pengutronix.de
From:   petter@ka-long.de
User-Agent: ALL-INKL Webmail 2.11
X-SenderIP: 95.223.83.221
MIME-Version: 1.0
In-Reply-To: <20220131084205.53otmukeyt2dt4zj@pengutronix.de>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20220131093554.505C65B0025F@dd15738.kasserver.com>
Date:   Mon, 31 Jan 2022 10:35:54 +0100 (CET)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


Hi Marc,

I have disabled DMAs in imx7s.dtsi for all ecspis and recompile the device tree.
Still get the same failure.

Thanks
Niels


                                ecspi2: spi@30830000 {
                                        #address-cells = <1>;
                                        #size-cells = <0>;
                                        compatible = "fsl,imx7d-ecspi", "fsl,imx51-ecspi";
                                        reg = <0x30830000 0x10000>;
                                        interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
                                        clocks = <&clks IMX7D_ECSPI2_ROOT_CLK>,
                                                <&clks IMX7D_ECSPI2_ROOT_CLK>;
                                        clock-names = "ipg", "per";
                                        /*
                                        dmas = <&sdma 2 7 1>, <&sdma 3 7 2>;
                                        dma-names = "rx", "tx";
                                        */
                                        status = "disabled";
                                };




Marc Kleine-Budde schrieb am 31.01.2022 08:42 (GMT +00:00):

> On 31.01.2022 09:33:04, petter@ka-long.de wrote:
>> I am working on an IMX7D board. Some time ago I have back-ported the
>> MCP2518FD driver to the official 5.4.70 NXP kernel and it works fine.
>> 
>> I am struggleing to get the mcp driver working on the latest nxp
>> kernel 5.10.72.
>> 
>> Same hardware.
>> 
>> I did not find any unusal in the logs. pinctrl did not complain, spi
>> seems to initialize normal.
>> 
>> The old kernel with the new (almost old one) device tree works. The
>> new kernel did not work with the old or new device tree.
>> 
>> At the moment I am stuck. Could be anything. Must not be the driver
>> itself.
> 
> Is SPI DMA enabled? Try disabling it.
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
