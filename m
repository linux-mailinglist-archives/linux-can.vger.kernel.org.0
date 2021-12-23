Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C948047E7B4
	for <lists+linux-can@lfdr.de>; Thu, 23 Dec 2021 19:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbhLWSla convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Thu, 23 Dec 2021 13:41:30 -0500
Received: from lelija.serveriai.lt ([194.135.87.135]:60018 "EHLO
        lelija.serveriai.lt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbhLWSl3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 Dec 2021 13:41:29 -0500
X-Greylist: delayed 1175 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Dec 2021 13:41:29 EST
Received: from [78.61.95.68] (helo=smtpclient.apple)
        by lelija.serveriai.lt with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gediminas@rusoku.com>)
        id 1n0Siq-0007Ge-E7
        for linux-can@vger.kernel.org; Thu, 23 Dec 2021 20:21:52 +0200
From:   Gediminas Simanskis <gediminas@rusoku.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: Dual CAN(FD) board w/ MACP251xfd
Date:   Thu, 23 Dec 2021 20:21:52 +0200
References: <A271F63C-FA42-4864-A621-C5195A35EC83@vanille.de>
 <d91f084a-73de-4486-548d-d39fcb1480bc@posteo.de>
 <e5acf66b-33a5-363e-5076-f42e8994ac2d@posteo.de>
To:     linux-can@vger.kernel.org
In-Reply-To: <e5acf66b-33a5-363e-5076-f42e8994ac2d@posteo.de>
Message-Id: <5AB3E4E4-3DB8-4B5C-931C-6C8E2722B2EB@rusoku.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Sender: gediminas@rusoku.com
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Maybe it’s not such a bad idea to use independent spi bus eq SPI0 and SPI1  ;-)


> On 2021-12-23, at 19:54, Patrick Menschel <menschel.p@posteo.de> wrote:
> 
> LOL, already found an error in my own lines. That was sluggish of me.
> 
> In your case udev rules should be
> 
> SUBSYSTEM=="net", ACTION=="add",
> DEVPATH=="/devices/platform/soc/*/*/*/spi0.0/net/can?", NAME="mcp0"
> SUBSYSTEM=="net", ACTION=="add",
> DEVPATH=="/devices/platform/soc/*/*/*/spi1.0/net/can?", NAME="mcp1"
> 
> Best Regards,
> Patrick
> 
> Am 23.12.21 um 18:49 schrieb Patrick Menschel:
>> Hello,
>> 
>> afaik Drew got that board working.
>> 
>> https://marc.info/?l=linux-can&m=160427096004578&w=2
>> 
>> Same time we did PRs for board specific overlays, not waveshare but
>> seeed while waveshare is very similar to seeed v1
>> 
>> https://github.com/raspberrypi/linux/pull/4034
>> https://github.com/raspberrypi/linux/pull/4041
>> 
>> With some reverse engineering we get back to a hopefully working set of
>> lines.
>> 
>> Please try these lines in config.txt
>> 
>> dtoverlay=mcp251xfd,spi0-0,interrupt=25
>> dtoverlay=mcp251xfd,spi1-0,interrupt=16
>> 
>> 
>> There is also a popular way to get rid of the can0 / can1 swapping, use
>> udev rules.
>> 
>> Try pasting this into /etc/udev/rules.d/70-can.rules
>> 
>> SUBSYSTEM=="net", ACTION=="add",
>> DEVPATH=="/devices/platform/soc/*/*/*/spi0.0/net/can?", NAME="mcp0"
>> SUBSYSTEM=="net", ACTION=="add",
>> DEVPATH=="/devices/platform/soc/*/*/*/spi0.1/net/can?", NAME="mcp1"
>> 
>> 
>> and correspondingly this into /etc/network/interfaces.d/70-can but you
>> may want to change bitrates
>> 
>> auto mcp0
>> iface mcp0 inet manual
>> 	pre-up /sbin/ip link set $IFACE type can bitrate 1000000 sample-point
>> 0.75 dbitrate 8000000 dsample-point 0.8 fd on
>> 	up /sbin/ifconfig $IFACE up
>> 	down /sbin/ifconfig $IFACE down
>> 
>> auto mcp1
>> iface mcp1 inet manual
>> 	pre-up /sbin/ip link set $IFACE type can bitrate 1000000 sample-point
>> 0.75 dbitrate 8000000 dsample-point 0.8 fd on
>> 	up /sbin/ifconfig $IFACE up
>> 	down /sbin/ifconfig $IFACE down
>> 
>> 
>> It may be wise to open another PR for that board.
>> 
>> Best Regards,
>> Patrick
>> 
>> Am 23.12.21 um 18:05 schrieb Dr. Michael Lauer:
>>> Please forgive me, if this is not the proper list for this message,
>>> but as far as I know the developer of the mcp251xfd driver is also reading here.
>>> 
>>> I recently acquired a Dual CAN FD HAT (https://www.waveshare.com/wiki/2-CH_CAN_FD_HAT)
>>> to run on my Raspberry PI 4. Currently, this is using kernel 5.15.11, but for some
>>> reason, only one of the two ports are recognized. Instead of detecting the 2nd port,
>>> it seems to just _renames_ the port. Here is the relevant kernel log:
>>> 
>>> [    5.495409] CAN device driver interface
>>> [    5.552660] spi_master spi1: will run message pump with realtime priority
>>> [    5.559885] mcp251xfd spi1.0 (unnamed net_device) (uninitialized): Detected MCP2518FD, but firmware specifies a MCP2517FD. Fixing up.
>>> [    5.580908] vc4-drm gpu: bound fe400000.hvs (ops vc4_hvs_ops [vc4])
>>> [    5.585428] Registered IR keymap rc-cec
>>> [    5.599117] rc rc0: vc4 as /devices/platform/soc/fef00700.hdmi/rc/rc0
>>> [    5.601698] mcp251xfd spi1.0 can0: MCP2518FD rev0.0 (-RX_INT -MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00MHz e:16.66MHz) successfully initialized.
>>> [    5.633622] input: vc4 as /devices/platform/soc/fef00700.hdmi/rc/rc0/input3
>>> [    5.677448] vc4-drm gpu: bound fef00700.hdmi (ops vc4_hdmi_ops [vc4])
>>> [    5.697059] Registered IR keymap rc-cec
>>> [    5.698682] mcp251xfd spi1.0 can1: renamed from can0
>>> 
>>> The activated overlays in config.txt are
>>> 
>>> dtoverlay=2xMCP2517FD
>>> dtoverlay=2xMCP2518FD-spi0
>>> 
>>> Perhaps anyone of you has a similar config and can tell me what could be wrong?
>>> 
>>> Best,
>>> 
>>> Mickey.
>>> 
>> 
> 

