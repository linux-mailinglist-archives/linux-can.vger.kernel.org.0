Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B345A6A2A0
	for <lists+linux-can@lfdr.de>; Tue, 16 Jul 2019 09:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfGPHFZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Jul 2019 03:05:25 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:37028 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfGPHFZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Jul 2019 03:05:25 -0400
X-ASG-Debug-ID: 1563260721-0a7b8d0ca11014380001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.226.adsl.dyn.edpnet.net [77.109.119.226]) by relay-b02.edpnet.be with ESMTP id 71Du4Lh6XkkvOel6; Tue, 16 Jul 2019 09:05:21 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.226.adsl.dyn.edpnet.net[77.109.119.226]
X-Barracuda-Apparent-Source-IP: 77.109.119.226
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 3C9C5908EC3;
        Tue, 16 Jul 2019 09:05:21 +0200 (CEST)
Date:   Tue, 16 Jul 2019 09:05:18 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Arthur Guyader <arthur.guyader@iot.bzh>, linux-can@vger.kernel.org
Subject: Re: J1939 : Address Claiming
Message-ID: <20190716070518.GA4257@x1.vandijck-laurijssen.be>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6ea6de2-e21d-04d2-656b-c71b68dbaa7f@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.119.226.adsl.dyn.edpnet.net[77.109.119.226]
X-Barracuda-Start-Time: 1563260721
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1710
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5070 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.74016
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 16 jul 2019 06:36:35 +0200, Oleksij Rempel wrote:
> Hi Arthur,
> 
> On 15.07.19 16:15, Arthur Guyader wrote:
> >Hello,
> >
> >I encountered a problem when using the claiming address.
> >When an ECU1 with a low name requests an address, it is saved in the kernel cache.
> >If this ECU1 is cut, and we launch our ECU2 which will ask for the same address.
> >He will have no answer from ECU1 and has no trace of him in his cache, so
> >he can consider that the address is free.
> >However, the kernel will consider that the address is busy and generate an
> >error when sending a message. (99 : cannot assign requested address)
> >
> >How would you handle this situation?

AFAIK, J1939 does not describe a timeout on claimed addresses, so
technically, ECU1 is never really away.
The code will respect the j1939 spec, and will never timeout either on
that.

> 
> You are describing a broken system. Is it a theoretical question or you was
> able to reproduce it with latest j1939 stack?
> 
> >I thought about sending a test message and handling the error case and
> >choosing another address.

Rather than sending a 'test message', you try to claim the address and
see if it works.
I realize (just looked into the code) and saw that jacd does not use the
errno=99 case when sending the address claim.
If it did, it could just choose the next address in line.

> >
> >Is there any way to clear the kernel cache?

> 
> No. You can send an address claim message with idle address.

The answer is yes, you can send an address claim with idle address :-)
This is hardly legal in j1939 terms to send the address claim on another
nodes behalf, but it would work.

Kurt
