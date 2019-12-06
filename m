Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010981150A6
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 13:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfLFMu2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 07:50:28 -0500
Received: from first.geanix.com ([116.203.34.67]:33692 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfLFMu2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 6 Dec 2019 07:50:28 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id CB3273C0;
        Fri,  6 Dec 2019 12:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575636619; bh=jL21vQLUybDxx+cUdDV6eKWCwwsmmhPl/Wag/E26BMw=;
        h=Subject:From:To:References:Date:In-Reply-To;
        b=JoXcJ4z6qWRzP+2NX2jpnSctu6Q9G8qSC2YBtDcnyoUksEGmhK7szt3hypzflAGct
         PbwrzuAHvwW5ephe0MWrgbJLOKd0WZNpLfzMP2V7bwnmO9KOpK+E3LarYNO4z0Grxl
         +4TF6jp0Cer+wN3NZ+Bd1wh5A6otwrakEH3EKKSE5nMNG455kFyZv2eR0NBCLIbwe6
         HbUydFVhXnnvmb+qtrIoKeA1PVwtvaYp18o+zhiiHusiJxkS1aIBmWmFmucOHx063q
         zL/dCyW0vbHM2HC15XJJi9Fgxhbvu+TuJ1i/du5N2j+4LJGfLvIU03FVeAu+qbXEsQ
         Y6MoGrwKwaWUw==
Subject: Re: tcan4x5x
From:   Sean Nyekjaer <sean@geanix.com>
To:     Dan Murphy <dmurphy@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <c16a87a4-5021-b25f-076c-18aa7b482baf@geanix.com>
Message-ID: <354a10d7-f515-26af-e023-478c975bcb9a@geanix.com>
Date:   Fri, 6 Dec 2019 13:50:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <c16a87a4-5021-b25f-076c-18aa7b482baf@geanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8b5b6f358cc9
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 06/12/2019 13.41, Sean Nyekjaer wrote:
> Hi Dan,
> 
> 3. Questions or comments :)
> 
> All tests have been run with "net: m_can: Make wake-up gpio an optional" 
> applied.
> 
> 1.
>  From Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
> The reset gpio is ACTIVE_HIGH works if changed to this in my device-tree.
> I could do the patch for this if desired :)
> 
> 
> 2.
>  From Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> - device-state-gpios: Input GPIO that indicates if the device is in
>   a sleep state or if the device is active.
> 
> What pin is that exactly on the tcan4550 chip? I can't find a pin that 
> is matches this functionality.
> 
> 3.
> When my board is booted, the reset line to the tcan4x5x is high.
> At 1. probe it's failing because it can't talk to the tcan device. We 
> are not waiting the required 700 μs described in the datasheet.
> root@iwg26:/data/root# insmod tcan4x5x.ko
> 
> [  148.764733] tcan4x5x spi2.0: no clock found
> 
> [  148.768989] tcan4x5x spi2.0: no CAN clock source defined
> 
> [  148.807644] tcan4x5x spi2.0: Unsupported version number:  0
> 
> [  148.814117] tcan4x5x spi2.0: Probe failed, err=-22
> 
> [  148.829416] tcan4x5x: probe of spi2.0 failed with error -22
> 
> 
> Second probe
> root@iwg26:/data/root# rmmod tcan4x5x; insmod tcan4x5x.ko
> 
> [  180.351252] tcan4x5x spi2.0: no clock found
> 
> [  180.355506] tcan4x5x spi2.0: no CAN clock source defined
> 
> [  180.395946] tcan4x5x spi2.0 (unnamed net_device) (uninitialized): 
> Failed to init module
> 
> [  180.655459] tcan4x5x spi2.0: m_can device registered (irq=84, 
> version=32)
> 
> [  180.662629] tcan4x5x spi2.0 can2: TCAN4X5X successfully initialized.
> 
> Third probe (everthing seems fine)
> root@iwg26:/data/root# rmmod tcan4x5x; insmod tcan4x5x.ko
> 
> [  208.240726] tcan4x5x spi2.0: no clock found
> 
> [  208.244980] tcan4x5x spi2.0: no CAN clock source defined
> 
> [  208.542998] tcan4x5x spi2.0: m_can device registered (irq=84, 
> version=32)
> 
> [  208.550140] tcan4x5x spi2.0 can2: TCAN4X5X successfully initialized.
> 
> 
> I will try with a usleep >700us to fix this :)

A usleep_range(700, 1000); right after the reset pin is put low will fix 
the non talking device "Unsupported version number:  0".

But i still have this on first probe, gone on second:
tcan4x5x spi2.0 (unnamed net_device) (uninitialized):
Failed to init  module

/Sean
