Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5843A5EEB
	for <lists+linux-can@lfdr.de>; Mon, 14 Jun 2021 11:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhFNJMs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Mon, 14 Jun 2021 05:12:48 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:59086 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhFNJMs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Jun 2021 05:12:48 -0400
X-ASG-Debug-ID: 1623661842-15c43444e51c82d0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.106.252.dyn.edpnet.net [94.105.106.252]) by relay-b01.edpnet.be with ESMTP id e7nB3u5SwS6kRYqb; Mon, 14 Jun 2021 11:10:43 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.106.252.dyn.edpnet.net[94.105.106.252]
X-Barracuda-Apparent-Source-IP: 94.105.106.252
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id D0D6414CF42B;
        Mon, 14 Jun 2021 11:10:42 +0200 (CEST)
Date:   Mon, 14 Jun 2021 11:10:41 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     =?utf-8?B?UsOpbXk=?= DZIEMIASZKO <remy.dziemiaszko@smile.fr>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: How to statically set J1939 addresses and names
Message-ID: <20210614091041.GD2028@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: How to statically set J1939 addresses and names
Mail-Followup-To: =?utf-8?B?UsOpbXk=?= DZIEMIASZKO <remy.dziemiaszko@smile.fr>,
        Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
References: <CAEWvZg2rvR=9kE_wcm-KtzMvDtnqTEXSLF56zrB=3TgqZbEs1w@mail.gmail.com>
 <20210611041232.6avft7jhzsqcuuwc@pengutronix.de>
 <20210611065708.GA2028@x1.vandijck-laurijssen.be>
 <CAEWvZg3vk7WUr1S-e0VxWd-BuFgf51m9WXyASeCssAPc2Yo+dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAEWvZg3vk7WUr1S-e0VxWd-BuFgf51m9WXyASeCssAPc2Yo+dg@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.106.252.dyn.edpnet.net[94.105.106.252]
X-Barracuda-Start-Time: 1623661842
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 3701
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.90635
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, 14 Jun 2021 10:32:34 +0200, Rémy DZIEMIASZKO wrote:
> Le ven. 11 juin 2021 à 08:57, Kurt Van Dijck
> <dev.kurt@vandijck-laurijssen.be> a écrit :
> >
> > On Fri, 11 Jun 2021 06:12:32 +0200, Oleksij Rempel wrote:
> > > Hi Rémy,
> > >
> > > On Tue, Jun 08, 2021 at 05:27:45PM +0200, Rémy DZIEMIASZKO wrote:
> > > > Hello,
> > > >
> > > > I need that my applications do not care about J1939 node addresses but
> > > > directly bind / connect to socket based on node name only and the
> > > > kernel takes care of the conversion to addresses.
> > > >
> > > > I know this is possible if addresses are dynamically assigned through
> > > > the Address Claiming protocol that is implemented in the kernel. The
> > > > kernel keeps track of its own address and name as well as the
> > > > addresses and names of other ECUs on the network and convert name to
> > > > adresse when requested by the applications.
> > > >
> > > > But I don't want to use the Address Claiming protocol. I want to
> > > > statically set all addresses and names.

> >
> >
> Hi Kurt,
> 
> When I develop my application I don't know it's source address. I only
> know its name.
> In the future my application shall be integrated in different
> projects/vehicules.
> For each project, the source_address may be different but the name
> will never change.

Ok, I have a little misunderstood your question before.
The way I interpret your setup now is going a bit off the j1939 spec.

You use the NAME only, but don't want to use address claiming? that are
opposite requrements.

You want to re-use the same NAME on different projects/vehicules.
Part of the NAME is the ECU serial number. You may keep the manufacturer
and function attributes equal, but the NAME is (supposed to be) unique
across the universe. And due to that, you can't know the complete NAME
at compile time.

Please note that the kernel will only translate NAME to SA for dynamic
addresses, i.e. where address claiming took place.
Please also not that the kernel does not care if another application
dealt with the actual address claiming. So, can-utils contains a
program, j1939acd, that can do the job for you.

> I don't want to adapt the source code of the application for each
> project so I don't want to bind/connect to source_addresses but to
> names.

I understand. That is a true goal.

> That's why it would be nice if the platform / the kernel does the
> translation name --> source_address.

The way I now see your problem, you have 2 ways to proceed,
which are pretty equal in development and deploy work.
Both options avoid Address claiming code in your application, and avoid
hardcoded static addresses.

1. You absolutely want no Address claiming on the CAN bus.

You must use static addressing then.
You make the effective SA used on the bus a parameter of your
application, and use this static addressing mode.

2. You 'tolerate' Address claiming on the CAN bus, but only with a single
predictable address.

You can use j1939acd from can-utils to do the address claiming work.
Your application still needs the final NAME as a parameter of your final
application, who will use it to bind using dynamic addressing.

To j1939acd, you only proved the single address as option. All dynamic
addressing rules apply in case of address conflicts etc, but I suppose
you manage somehow to not have any address collisions.

A 3rd option with less deployment work could be a variation of 2., with
hardcoded fixed NAME. You would still need to call j1939acd.
Since hardcoded fixed NAME is out of the j1939 spec, it's a bit on your own risk.

Kind regards,
Kurt

