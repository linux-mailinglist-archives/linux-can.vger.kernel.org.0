Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F302C3A3C69
	for <lists+linux-can@lfdr.de>; Fri, 11 Jun 2021 08:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhFKG7K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 11 Jun 2021 02:59:10 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:58220 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKG7J (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 11 Jun 2021 02:59:09 -0400
X-ASG-Debug-ID: 1623394629-15c4354db919d030001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.106.252.dyn.edpnet.net [94.105.106.252]) by relay-b03.edpnet.be with ESMTP id xGY3Oo2Ysux6EFwm; Fri, 11 Jun 2021 08:57:09 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.106.252.dyn.edpnet.net[94.105.106.252]
X-Barracuda-Apparent-Source-IP: 94.105.106.252
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id A94E214BBA4C;
        Fri, 11 Jun 2021 08:57:09 +0200 (CEST)
Date:   Fri, 11 Jun 2021 08:57:08 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     =?utf-8?B?UsOpbXk=?= DZIEMIASZKO <remy.dziemiaszko@smile.fr>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: How to statically set J1939 addresses and names
Message-ID: <20210611065708.GA2028@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: How to statically set J1939 addresses and names
Mail-Followup-To: =?utf-8?B?UsOpbXk=?= DZIEMIASZKO <remy.dziemiaszko@smile.fr>,
        Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
References: <CAEWvZg2rvR=9kE_wcm-KtzMvDtnqTEXSLF56zrB=3TgqZbEs1w@mail.gmail.com>
 <20210611041232.6avft7jhzsqcuuwc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210611041232.6avft7jhzsqcuuwc@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.106.252.dyn.edpnet.net[94.105.106.252]
X-Barracuda-Start-Time: 1623394629
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2364
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.90564
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, 11 Jun 2021 06:12:32 +0200, Oleksij Rempel wrote:
> Hi Rémy,
> 
> On Tue, Jun 08, 2021 at 05:27:45PM +0200, Rémy DZIEMIASZKO wrote:
> > Hello,
> > 
> > I need that my applications do not care about J1939 node addresses but
> > directly bind / connect to socket based on node name only and the
> > kernel takes care of the conversion to addresses.
> > 
> > I know this is possible if addresses are dynamically assigned through
> > the Address Claiming protocol that is implemented in the kernel. The
> > kernel keeps track of its own address and name as well as the
> > addresses and names of other ECUs on the network and convert name to
> > adresse when requested by the applications.
> > 
> > But I don't want to use the Address Claiming protocol. I want to
> > statically set all addresses and names.

It is supported to not use Address Claiming.

> > 
> > Is there a way to assign J1939 addresses and names to a CAN interface
> > without using the J1939 address claim protocol?
> 
> Current version do not have this functionality.

If you bind() your socket with only sockaddr_can.j1939.sa set to your
SA, and sockaddr_can.j1939.name to 0, makes your socket use your SA as
static address.

> 
> > I found in old j1939 kernel documentation something like
> > ip addr add dev canX j1939 0xXX
> > ip addr add dev canX j1939 name 0xXX
> > See https://www.spinics.net/lists/netdev/msg162350.html
> > 
> > But in the latest j1939 kernel documentation I do not find any
> > reference to these commands.
> 
> Yes, it was pre mainline version. For mainlining we reduced UAPI to the
> minimum to simplify reviewing, mainlining and testing process.
> 

The strict addressing was rejected because it felt much heavier than
what most CAN users were used to. Moving to the current ad-hoc
implementation allowed to drop quite some kernel code too.

> IF you need this option, you are welcome to send patches :)
> Or you can contact us or other company to implement it.
> 
> Regards,
> Oleksij
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
