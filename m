Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE38276ADE
	for <lists+linux-can@lfdr.de>; Thu, 24 Sep 2020 09:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgIXHeJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Thu, 24 Sep 2020 03:34:09 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:33849 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgIXHeJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Sep 2020 03:34:09 -0400
X-ASG-Debug-ID: 1600932840-0a7b8d4d72dd720001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.65.adsl.dyn.edpnet.net [77.109.119.65]) by relay-b02.edpnet.be with ESMTP id bOZqJKpJbIdwRBS4; Thu, 24 Sep 2020 09:34:00 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.65.adsl.dyn.edpnet.net[77.109.119.65]
X-Barracuda-Apparent-Source-IP: 77.109.119.65
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 4CC17106289D;
        Thu, 24 Sep 2020 09:34:00 +0200 (CEST)
Date:   Thu, 24 Sep 2020 09:33:41 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Matthias =?utf-8?Q?Wei=C3=9Fer?= <m.weisser.m@gmail.com>,
        linux-can@vger.kernel.org
Subject: Re: mcp25xxfd driver testing
Message-ID: <20200924073341.GA26023@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: mcp25xxfd driver testing
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Matthias =?utf-8?Q?Wei=C3=9Fer?= <m.weisser.m@gmail.com>,
        linux-can@vger.kernel.org
References: <CAO8h3eGqrxFMKrsrjECeog6cheLrRpn_y6Ty9BMUv_ncU1c67g@mail.gmail.com>
 <20200923190551.GA14591@x1.vandijck-laurijssen.be>
 <9bbd4192-122b-8978-4bd2-ec13ef479b4e@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <9bbd4192-122b-8978-4bd2-ec13ef479b4e@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.119.65.adsl.dyn.edpnet.net[77.109.119.65]
X-Barracuda-Start-Time: 1600932840
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2505
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9834 1.0000 4.1507
X-Barracuda-Spam-Score: 4.15
X-Barracuda-Spam-Status: No, SCORE=4.15 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.84840
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On do, 24 sep 2020 08:50:45 +0200, Marc Kleine-Budde wrote:
> On 9/23/20 9:05 PM, Kurt Van Dijck wrote:
> > On wo, 23 sep 2020 16:55:13 +0200, Matthias Weißer wrote:
> >> Hi
> >>
> >> I currently try to get a MCP2518FD to work on our custom iMX6ULL based
> >> hardware. I use the driver currently in linux-can-next backported to
> >> our v5.4 kernel
> >>
> >> DT:
> >>     can0: can@0 {
> >>         compatible = "microchip,mcp25xxfd";
> >>         reg = <0>;
> >>         clocks = <&can3_osc>;
> >>         spi-max-frequency = <85000000>;
> 
> > I did not experience issues by using the real 20MHz upper limit here.
> 
> Not quite...

Well, the driver calculated things correctly, and it chose some 8.xx MHz
to use. I didn't need to limit the spi-max-frequency manually.

> 
> >>         interrupts-extended = <&gpio1 18 IRQ_TYPE_LEVEL_LOW>;
> >>         status = "okay";
> >>     };
> >>
> >>  # dmesg | grep mcp
> >> [    3.706085] mcp25xxfd spi1.0 can0: MCP2518FD rev0.0 (-RX_INT
> >> -MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:20.00MHz m:8.50MHz
> >> r:8.50MHz e:0.00MHz) successfully initialized.
> > 
> > off-topic:
> > Variscite deploys a 20HHz oscillator, which brings the max spi frequency
> > down to +/- 8.5MHz.
> > After discussion with Thomas Kopp, I learned that microchip uses a 40MHz
> > oscillator, to arrive (close to) 20MHz spi freq.
> > Would you not use a 40MHz oscillator too?
> 
> According to the debug output the can3_osc is 20 MHz. According to the datasheet
> this makes 10 MHz SPI clock, however it turns out, you can only use 85% of that
> to avoid stability problems. The driver takes care of the 85%, so you don't have
> to specify this in the DT.

I would have liked if Variscite had better investigated how to provide
the best performance using the chip. Instead, someone read '20MHz max spi frequency',
and put a 20MHz oscillator on the board.

Since Matthias uses 'custom iMX6ULL based hardware', I assumed they made
the same mistake.
my point here was that they could supply a 40MHz clock, and the driver would then
derive the spi max frequency to 0.85*20MHz = 17MHz. Things goes twice as
fast then.

> 
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
> 



