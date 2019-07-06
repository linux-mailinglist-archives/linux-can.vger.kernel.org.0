Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0C560F02
	for <lists+linux-can@lfdr.de>; Sat,  6 Jul 2019 07:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfGFFA0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Sat, 6 Jul 2019 01:00:26 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:60775 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfGFFA0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 6 Jul 2019 01:00:26 -0400
X-ASG-Debug-ID: 1562389222-0a88186e218d0150001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.226.adsl.dyn.edpnet.net [77.109.119.226]) by relay-b03.edpnet.be with ESMTP id 4nQPAzItA28ZDXUZ; Sat, 06 Jul 2019 07:00:22 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.226.adsl.dyn.edpnet.net[77.109.119.226]
X-Barracuda-Apparent-Source-IP: 77.109.119.226
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 92BBF8EAF64;
        Sat,  6 Jul 2019 07:00:22 +0200 (CEST)
Date:   Sat, 6 Jul 2019 07:00:21 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Arthur Guyader <arthur.guyader@iot.bzh>
Cc:     linux-can@vger.kernel.org
Subject: Re: J1939 : Address Claiming
Message-ID: <20190706050020.GE22538@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: J1939 : Address Claiming
Mail-Followup-To: Arthur Guyader <arthur.guyader@iot.bzh>,
        linux-can@vger.kernel.org
References: <43c0a773-ec06-5288-9fcc-9cdf68e72879@iot.bzh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <43c0a773-ec06-5288-9fcc-9cdf68e72879@iot.bzh>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.119.226.adsl.dyn.edpnet.net[77.109.119.226]
X-Barracuda-Start-Time: 1562389222
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2042
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6851 1.0000 1.2591
X-Barracuda-Spam-Score: 1.26
X-Barracuda-Spam-Status: No, SCORE=1.26 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.73581
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hey,

On vr, 05 jul 2019 17:52:16 +0200, Arthur Guyader wrote:
> Hello all,
> 
> I looked at the code of can-utils and more precisely jacd.c.
> 
> In the way it is implemented, the deamon's only objective is to change its
> address according to the different requests it receives.

That is indeed the only thing jacd does. It helps other programs that
use the same 64bit NAME so that they don't have to implement the same
thing.

> More precisely, the socket is blocked until the next received claiming
> address request (recvfrom).

yes.
Since it's the only thing it does, there is no need to use non-blocking
calls.

> 
> In a real implementation, do you need two sockets?
>     - one to receive and write messages
>     - another dedicated only to the claiming address
> Or did you have another solution?

The objective is to have multiple programs or sockets open that
each implement a little functionality, and that share the same NAME and
address. To the outer world howevers, they must cooperate and use the
same address at all times.

This is not technically enforced, you could combine all logic
in one program. In my experience, it's hard to get that one program
correct and stable, and it's easier when you divide it in pieces.

> 
> In the documentation, it says: "If another ECU claims the address, the
> kernel will mark the NAME-SA expired", how can this be checked?

This is implemented in the kernel-part of j1939, which is not yet
mainline.
That part does interprete address claim traffic.

You cannot check that from userspace, other than finding yourself
blocked when using that SA. The kernel will enforce the address
claiming.

> 
> Do you plan to integrate the management of the claiming address (jacd.c)
> into the kernel or leave it to the user?

The kernel part of address claiming already exists, but is not
mainlined. It enforces correct operation on the bus.

The userspace part is jacd, whose only job is to choose an address.

kind regards,
Kurt
