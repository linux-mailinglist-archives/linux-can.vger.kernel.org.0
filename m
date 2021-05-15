Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7460F3818B6
	for <lists+linux-can@lfdr.de>; Sat, 15 May 2021 14:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhEOM13 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 15 May 2021 08:27:29 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:51732 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhEOM11 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 15 May 2021 08:27:27 -0400
X-ASG-Debug-ID: 1621081572-15c4337c2915de1d0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.122.62.dyn.edpnet.net [94.105.122.62]) by relay-b02.edpnet.be with ESMTP id IKHNp2ggqfbybzUt; Sat, 15 May 2021 14:26:12 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.122.62.dyn.edpnet.net[94.105.122.62]
X-Barracuda-Apparent-Source-IP: 94.105.122.62
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 3ABAB141AEF8;
        Sat, 15 May 2021 14:26:12 +0200 (CEST)
Date:   Sat, 15 May 2021 14:26:11 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Patrick Menschel <menschel.p@posteo.de>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: J1939 Questions on Intended usage
Message-ID: <20210515122611.GC2387@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: J1939 Questions on Intended usage
Mail-Followup-To: Patrick Menschel <menschel.p@posteo.de>,
        linux-can <linux-can@vger.kernel.org>
References: <f0d77797-c485-2f88-57e3-b5c7b4953706@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0d77797-c485-2f88-57e3-b5c7b4953706@posteo.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.122.62.dyn.edpnet.net[94.105.122.62]
X-Barracuda-Start-Time: 1621081572
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1719
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.89954
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, 14 May 2021 12:04:47 +0000, Patrick Menschel wrote:
> Hi Kurt,
> 
> J1939 just hit the raspberrypi-kernel-headers and will soon be part of
> regular raspberrypi-kernel [1] while it was already
> available in Python 3.9 for a couple of month. [2]
> 
> I was about to give it a spin but was confused of the call parameters.
> 
> Could you shed some light on the intended usage.
> 
> Do I need to open one socket per PGN I'm sending?
> e.g.
> 
> s1 = socket.socket(socket.AF_CAN, socket.SOCK_DGRAM, socket.CAN_J1939)
> s1.bind(interface_name, MY_NAME, PGN_OF_TSC1, MY_SA)
> s1.write(bytes(8))
> 
> s2 = socket.socket(socket.AF_CAN, socket.SOCK_DGRAM, socket.CAN_J1939)
> s2.bind(interface_name, MY_NAME, PGN_OF_EBC1, MY_SA)
> s2.write(bytes(8))

No, you don't _need_ to. You can.

If you need quite some different PGN's, it may be more interesting to:
s = socket.socket(socket.AF_CAN, socket.SOCK_DGRAM, socket.CAN_J1939)
s.bind(interface_name, MY_NAME, ANY_PGN, MY_SA)
s.sendto(bytes(8), DST_1, PGN_1)
s.sendto(bytes(8), DST_2, PGN_2)
...

I'm not a python expert, I just assume something like that is possible.

> 
> 
> What about the cyclic transmitted PGNs? Do I drop those into
> BroadcastManager somehow?

The broadcast manager is seperate from j1939, so it's apart.
> 
> 
> If I want to open an ISOTP Channel while a j1939 socket exists for my
> SA, does anything weird happen on that socket?

No, nothing weird will happen.

The only possible disadvantage I can think of is that the messages sent
using ISOTP do not honor the NAME-SA mapping, so on a bus with dynamic
addressing, you should be carefull to use local/remote addresses.

Kind regards,
Kurt
