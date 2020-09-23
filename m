Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759C5276101
	for <lists+linux-can@lfdr.de>; Wed, 23 Sep 2020 21:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgIWTZb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 23 Sep 2020 15:25:31 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:55855 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIWTZb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 15:25:31 -0400
X-Greylist: delayed 1158 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 15:25:30 EDT
X-ASG-Debug-ID: 1600887970-0a8818631131d70001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.65.adsl.dyn.edpnet.net [77.109.119.65]) by relay-b03.edpnet.be with ESMTP id MX4cFnDHIyQYc2sE; Wed, 23 Sep 2020 21:06:10 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.65.adsl.dyn.edpnet.net[77.109.119.65]
X-Barracuda-Apparent-Source-IP: 77.109.119.65
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 4300B1060AA4;
        Wed, 23 Sep 2020 21:06:10 +0200 (CEST)
Date:   Wed, 23 Sep 2020 21:05:51 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Matthias =?utf-8?Q?Wei=C3=9Fer?= <m.weisser.m@gmail.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: mcp25xxfd driver testing
Message-ID: <20200923190551.GA14591@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: mcp25xxfd driver testing
Mail-Followup-To: Matthias =?utf-8?Q?Wei=C3=9Fer?= <m.weisser.m@gmail.com>,
        linux-can@vger.kernel.org
References: <CAO8h3eGqrxFMKrsrjECeog6cheLrRpn_y6Ty9BMUv_ncU1c67g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAO8h3eGqrxFMKrsrjECeog6cheLrRpn_y6Ty9BMUv_ncU1c67g@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.119.65.adsl.dyn.edpnet.net[77.109.119.65]
X-Barracuda-Start-Time: 1600887970
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2891
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8006 1.0000 2.2276
X-Barracuda-Spam-Score: 2.23
X-Barracuda-Spam-Status: No, SCORE=2.23 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.84829
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hey,

I did struggle with a variscite imx8+MCP25xxfd system.

On wo, 23 sep 2020 16:55:13 +0200, Matthias Weißer wrote:
> Hi
> 
> I currently try to get a MCP2518FD to work on our custom iMX6ULL based
> hardware. I use the driver currently in linux-can-next backported to
> our v5.4 kernel
> 
> DT:
>     can0: can@0 {
>         compatible = "microchip,mcp25xxfd";
>         reg = <0>;
>         clocks = <&can3_osc>;
>         spi-max-frequency = <85000000>;
I did not experience issues by using the real 20MHz upper limit here.
>         interrupts-extended = <&gpio1 18 IRQ_TYPE_LEVEL_LOW>;
>         status = "okay";
>     };
> 
>  # dmesg | grep mcp
> [    3.706085] mcp25xxfd spi1.0 can0: MCP2518FD rev0.0 (-RX_INT
> -MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:20.00MHz m:8.50MHz
> r:8.50MHz e:0.00MHz) successfully initialized.

off-topic:
Variscite deploys a 20HHz oscillator, which brings the max spi frequency
down to +/- 8.5MHz.
After discussion with Thomas Kopp, I learned that microchip uses a 40MHz
oscillator, to arrive (close to) 20MHz spi freq.
Would you not use a 40MHz oscillator too?

> 
> I then up the CAN interface
> # ip link set can0 up type can bitrate 125000 sample-point 0.75
> dbitrate 500000 dsample-point 0.8 fd on

I see. On 125k, the 20MHz crystal is sufficient.

> 
> I am then able to send CAN frames using
> # cansend can0 123#42
> and CAN-FD frames using
> # cansend can0 123##042
> 
> These frames are successfully received on a connected PC using an PCAN-USB FD
> 
> Trying to send a CAN-FD frame with baud rate switch fails
> # cansend can0 123##142
> [  190.921477] mcp25xxfd spi1.0 can0: bus-off
> 
> Also receiving of any CAN frame doesn't work
> # candump any,0:0,#FFFFFFFF
> [  259.937612] spi_master spi1: I/O Error in DMA RX
> [  259.943743] mcp25xxfd spi1.0: SPI transfer failed: -110
> [  259.949644] spi_master spi1: failed to transfer one message from queue
> [  259.956566] mcp25xxfd spi1.0 can0: IRQ handler
> mcp25xxfd_handle_rxif() returned -110.
> [  259.964547] mcp25xxfd spi1.0 can0: IRQ handler returned -110
> (intf=0x3f1a0002).

There is something bizarre with the DMA implementation of imx.
The variscite device-tree's come with dma disabled in their SPI nodes,
using

	&ecspi1 {
		status = "okay";
		/delete-property/ dmas;
		/delete-property/ dma-names;
	};

Since I was struggling to consume 1Mbit, I tried to enable DMA again,
and ran into the same SPI tranfer failed. Disabling DMA fixes this.

This is a workaround.
and it works for me.

Kind regards,

> 
> My first thought was that the interrupts of the controller are not
> recognized by the iMX but /proc/interrupts shows that there are some
> of them
>  78:         10  gpio-mxc  18 Level     spi1.0
> 
> Any hints are greatly appreciated
> 
> 
> Regards
> 
> Matthias
