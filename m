Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1E7461BEA
	for <lists+linux-can@lfdr.de>; Mon,  8 Jul 2019 10:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfGHItk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 Jul 2019 04:49:40 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:51347 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfGHItk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 Jul 2019 04:49:40 -0400
X-ASG-Debug-ID: 1562575776-0a88186e23a5f980001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.226.adsl.dyn.edpnet.net [77.109.119.226]) by relay-b03.edpnet.be with ESMTP id keZttVvKca40Fei2; Mon, 08 Jul 2019 10:49:36 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.226.adsl.dyn.edpnet.net[77.109.119.226]
X-Barracuda-Apparent-Source-IP: 77.109.119.226
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id E83F08F1B1E;
        Mon,  8 Jul 2019 10:49:35 +0200 (CEST)
Date:   Mon, 8 Jul 2019 10:49:34 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Arthur Guyader <arthur.guyader@iot.bzh>
Cc:     linux-can@vger.kernel.org
Subject: Re: J1939 : Address Claiming
Message-ID: <20190708084934.GA24954@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: J1939 : Address Claiming
Mail-Followup-To: Arthur Guyader <arthur.guyader@iot.bzh>,
        linux-can@vger.kernel.org
References: <43c0a773-ec06-5288-9fcc-9cdf68e72879@iot.bzh>
 <20190706050020.GE22538@x1.vandijck-laurijssen.be>
 <f95b8200-31fa-e2f5-49a2-f576fae3cc9c@iot.bzh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f95b8200-31fa-e2f5-49a2-f576fae3cc9c@iot.bzh>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.119.226.adsl.dyn.edpnet.net[77.109.119.226]
X-Barracuda-Start-Time: 1562575776
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 3060
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5019 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.73671
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

>    Each time a new address is assigned I rebind the other sockets with it.
This administration is inherently racy.
That's why you better bind the other sockets by name,
so you don't have to rebind each time the address changes.
The kernel will, based on the address claims passing in & out,
apply the correct address, if any is available.

As such, you can push the address claiming socket in another process,
and my re-use jacd.

Kind regards,
Kurt


On ma, 08 jul 2019 10:22:21 +0200, Arthur Guyader wrote:
>    Thank you for your answer !
> 
>    Let me get this straight :
>    I create a socket dedicated to the claiming address.
>    Each time a new address is assigned I rebind the other sockets with it.
>    If I use the wrong address, the message will not be sent.
> 
>    Best regards
> --
> Arthur Guyader - Embedded Engineer - IoT.bzh
> 
> 
>    On 06/07/2019 07:00, Kurt Van Dijck wrote:
> 
> Hey,
> 
> On vr, 05 jul 2019 17:52:16 +0200, Arthur Guyader wrote:
> 
> Hello all,
> 
> I looked at the code of can-utils and more precisely jacd.c.
> 
> In the way it is implemented, the deamon's only objective is to change its
> address according to the different requests it receives.
> 
> That is indeed the only thing jacd does. It helps other programs that
> use the same 64bit NAME so that they don't have to implement the same
> thing.
> 
> 
> More precisely, the socket is blocked until the next received claiming
> address request (recvfrom).
> 
> yes.
> Since it's the only thing it does, there is no need to use non-blocking
> calls.
> 
> 
> In a real implementation, do you need two sockets?
>     - one to receive and write messages
>     - another dedicated only to the claiming address
> Or did you have another solution?
> 
> The objective is to have multiple programs or sockets open that
> each implement a little functionality, and that share the same NAME and
> address. To the outer world howevers, they must cooperate and use the
> same address at all times.
> 
> This is not technically enforced, you could combine all logic
> in one program. In my experience, it's hard to get that one program
> correct and stable, and it's easier when you divide it in pieces.
> 
> 
> In the documentation, it says: "If another ECU claims the address, the
> kernel will mark the NAME-SA expired", how can this be checked?
> 
> This is implemented in the kernel-part of j1939, which is not yet
> mainline.
> That part does interprete address claim traffic.
> 
> You cannot check that from userspace, other than finding yourself
> blocked when using that SA. The kernel will enforce the address
> claiming.
> 
> 
> Do you plan to integrate the management of the claiming address (jacd.c)
> into the kernel or leave it to the user?
> 
> The kernel part of address claiming already exists, but is not
> mainlined. It enforces correct operation on the bus.
> 
> The userspace part is jacd, whose only job is to choose an address.
> 
> kind regards,
> Kurt
