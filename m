Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B026A314
	for <lists+linux-can@lfdr.de>; Tue, 16 Jul 2019 09:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfGPHi4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Jul 2019 03:38:56 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:48323 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfGPHi4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Jul 2019 03:38:56 -0400
X-ASG-Debug-ID: 1563262733-0a7b8d0ca01015c40001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.226.adsl.dyn.edpnet.net [77.109.119.226]) by relay-b02.edpnet.be with ESMTP id GEFqkPoWpmaiJ1y7; Tue, 16 Jul 2019 09:38:53 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.226.adsl.dyn.edpnet.net[77.109.119.226]
X-Barracuda-Apparent-Source-IP: 77.109.119.226
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 5312B908F9E;
        Tue, 16 Jul 2019 09:38:53 +0200 (CEST)
Date:   Tue, 16 Jul 2019 09:38:50 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Arthur Guyader <arthur.guyader@iot.bzh>,
        linux-can@vger.kernel.org
Subject: Re: J1939 : Address Claiming
Message-ID: <20190716073850.GB4257@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: J1939 : Address Claiming
Mail-Followup-To: Oleksij Rempel <o.rempel@pengutronix.de>,
        Arthur Guyader <arthur.guyader@iot.bzh>, linux-can@vger.kernel.org
References: <43c0a773-ec06-5288-9fcc-9cdf68e72879@iot.bzh>
 <20190706050020.GE22538@x1.vandijck-laurijssen.be>
 <f95b8200-31fa-e2f5-49a2-f576fae3cc9c@iot.bzh>
 <20190708084934.GA24954@x1.vandijck-laurijssen.be>
 <81056b49-a0c7-8b2d-d2d2-785b6107fd9d@iot.bzh>
 <a0d48616-86ac-a2f3-8d07-e0209e6f2021@iot.bzh>
 <e6ea6de2-e21d-04d2-656b-c71b68dbaa7f@pengutronix.de>
 <20190716070518.GA4257@x1.vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190716070518.GA4257@x1.vandijck-laurijssen.be>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.119.226.adsl.dyn.edpnet.net[77.109.119.226]
X-Barracuda-Start-Time: 1563262733
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1617
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9537 1.0000 3.8138
X-Barracuda-Spam-Score: 3.81
X-Barracuda-Spam-Status: No, SCORE=3.81 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.74017
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 16 jul 2019 09:05:18 +0200, Kurt Van Dijck wrote:
> On di, 16 jul 2019 06:36:35 +0200, Oleksij Rempel wrote:
> > Hi Arthur,
> > 
> > On 15.07.19 16:15, Arthur Guyader wrote:
> > >Hello,
> > >
> > >I encountered a problem when using the claiming address.
> > >When an ECU1 with a low name requests an address, it is saved in the kernel cache.
> > >If this ECU1 is cut, and we launch our ECU2 which will ask for the same address.
> > >He will have no answer from ECU1 and has no trace of him in his cache, so
> > >he can consider that the address is free.
> > >However, the kernel will consider that the address is busy and generate an
> > >error when sending a message. (99 : cannot assign requested address)
> > >
> > >How would you handle this situation?
> 
> AFAIK, J1939 does not describe a timeout on claimed addresses, so
> technically, ECU1 is never really away.
> The code will respect the j1939 spec, and will never timeout either on
> that.

Reading back my own reply, and trying to fix jacd.c, I realize that it
is allow to contest an address, and if the remote didn't respond within
time, you're the owner.

jacd is written like that, so I assume the kernel code is blocking so
to avoid unnecessary address claim congestion.

It's not nice to put a 'recently seen' notion in kernel to decide if an
address claim will problably fail or not, so that justifies to remove
the check completely, but it's not nice to
allow stupid contests either.
I'm undecided wether to add the 'recently seen' or not.

The problems you experience would in any case dissapear.

Kurt
