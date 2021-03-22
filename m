Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2696C343D33
	for <lists+linux-can@lfdr.de>; Mon, 22 Mar 2021 10:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCVJrU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Mar 2021 05:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhCVJqt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Mar 2021 05:46:49 -0400
Received: from relay.felk.cvut.cz (relay.felk.cvut.cz [IPv6:2001:718:2:1611:0:1:0:70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F382C061574
        for <linux-can@vger.kernel.org>; Mon, 22 Mar 2021 02:46:48 -0700 (PDT)
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 12M9jjsY006457;
        Mon, 22 Mar 2021 10:45:45 +0100 (CET)
        (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 12M9jjWi002167;
        Mon, 22 Mar 2021 10:45:45 +0100
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 12M9jer7002157;
        Mon, 22 Mar 2021 10:45:40 +0100
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     "Marc Kleine-Budde" <mkl@pengutronix.de>
Subject: Re: CAN FD controllers (M-CAN tcan4x5x as well as Microchip mcp251xfd) fails on iMX6 eCSPI interface
Date:   Mon, 22 Mar 2021 10:45:40 +0100
User-Agent: KMail/1.9.10
Cc:     linux-can@vger.kernel.org, Petr Porazil <porazil@volny.cz>,
        Han Xu <han.xu@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tiago Brusamarello <tiago.brusamarello@datacom.ind.br>,
        Pavel Machek <pavel@ucw.cz>
References: <202103220906.52896.pisa@cmp.felk.cvut.cz> <20210322083128.ehblmvyxo5rggeno@pengutronix.de>
In-Reply-To: <20210322083128.ehblmvyxo5rggeno@pengutronix.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202103221045.40634.pisa@cmp.felk.cvut.cz>
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 12M9jjsY006457
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
        score=-0.099, required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.40,
        NICE_REPLY_A -0.00, SPF_HELO_NONE 0.00, SPF_NONE 0.00,
        URIBL_BLOCKED 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1617011155.27573@dBDCBLue3wcgdmy/hKukdg
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

thanks much for the fast reply.

On Monday 22 of March 2021 09:31:28 Marc Kleine-Budde wrote:
> On 22.03.2021 09:06:52, Pavel Pisa wrote:
> > my colleague at Elektroline.cz works on design of iMX6
> > based system with CAN FD support realized by tcan4x5x
> > chip connected to eCSPI. It seems that there are problems
> > with eCSPI DMA stucks and other troubles. When the same
> > chip (or even Microchip's mcp251xfd) is connected to
> > other (less industry sound platforms) as Allwinner etc...
> > drivers seems to work reliably, but tests on iMX6 results
> > in failures. They consider fast redesign to slCAN connected
> > second Microchip MCU to resolve critical problem for the
> > project now....
>
> Don't use slcan, just don't.

Yes, I agree with it and argued it to my colleagues but they are
so frustrated by more problems in iMX6 and imxRT erratas that they
believe that serial port has highest probability to not been broken.

> - If you want to stick to the SPI, use a mcp2518fd.
> - If you don't need CAN-FD, attach a stm32f042 or f072 via USB. There is
>   a open source firmware and Linux drivers.

They have Microchip PIC32 for power management in the design and quite
good experience with it, so they can use little more advanced one
with CAN FD and use it at CAN interface. The idea to use SPI connected
MCU (in my case NXP LPC) come to my mind at LinCAN era when everybody
used MCP2515 with horrible single register operation overhead.
Can you suggest SPI protocol for CAN, CAN FD MCU connection as the
SocketCAN interface? Is there plan for CAN FD version?
Anyway if the problems are caused by NXP SPI, then they can creep
in still.

> - If you need CAN-FD, use a more modern stm32. I think some of the "G"
>   series have CAN-FD. But the firmware and Linux drivers are not
>   adopted, yet.

We have solved and mainlined CAN FD on imxRT on NuttX and Microchip
SAME70 (mainlining to NuttX expected soon) so we can reuse these.

> Expect quite some CPU load for the SPI based CAN controllers, due to the
> high Linux SPI overhead and the not that optimized imx SPI host driver.

Yes, I am not fan of these solution (you know our CTU CAN FD effort,
hopefully headers generator rewrite comes to the table next month),
but Elektroline company needs industrial range system and could not
wait for iMX8X with CAN FD controllers at the project start time.

> > The setup on 5.7 kernel partially works
>
> For the tcan4x5x better use latest v5.12 plus this series:
> https://lore.kernel.org/linux-can/20210308102427.63916-1-torin@maxiluxsyste
>ms.com/

Thanks, we will test that for sure but for production we probably
need to backport to 5.10 because it has chance for serious LTS
support from Civil Infrastructure Platform (adding Pavel to CC)
for standard and even better preempt-RT kernels.

> If the SPI DMA makes troubles, deactivate it. I think the tcan4x5x driver
> uses single tcan4x5x register reads, which results in small SPI
> transfers, so DMA brings no benefits.

Yes, we try that. I have some reminiscence form old time that we have
done some similar tricks on imx53 to make it work in infussion system demo.

Again thanks much for fast response,

                Pavel
--
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://dce.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/

