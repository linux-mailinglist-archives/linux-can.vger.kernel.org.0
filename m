Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D84311DF0F
	for <lists+linux-can@lfdr.de>; Fri, 13 Dec 2019 09:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfLMIGs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 13 Dec 2019 03:06:48 -0500
Received: from relay-b02.edpnet.be ([212.71.1.222]:36378 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfLMIGr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Dec 2019 03:06:47 -0500
X-ASG-Debug-ID: 1576224404-0a7b8d6ce0db4a0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.105.111.dyn.edpnet.net [94.105.105.111]) by relay-b02.edpnet.be with ESMTP id zZU9jLxAyV8AR1cr; Fri, 13 Dec 2019 09:06:44 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.105.111.dyn.edpnet.net[94.105.105.111]
X-Barracuda-Apparent-Source-IP: 94.105.105.111
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 092A3BBD059;
        Fri, 13 Dec 2019 09:06:44 +0100 (CET)
Date:   Fri, 13 Dec 2019 09:06:40 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Elenita Hinds <ecathinds@gmail.com>, linux-can@vger.kernel.org
Subject: Re: can-utils jacd questions
Message-ID: <20191213080640.GA22400@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: can-utils jacd questions
Mail-Followup-To: Oleksij Rempel <o.rempel@pengutronix.de>,
        Elenita Hinds <ecathinds@gmail.com>, linux-can@vger.kernel.org
References: <CAHChkrstQdjVcWtvX4oeUOQfZS3-G_RPWb8Y82Zvaku40dM_qA@mail.gmail.com>
 <20191206085923.GA4896@x1.vandijck-laurijssen.be>
 <CAHChkruBV2btmtk4FdfJ3-VvidGy5Z0hHhno4pPNuxMoDKAYtQ@mail.gmail.com>
 <CAHChkrtv9+hw30ymjMu9M-CpEnT__WWz7OmVCtxwCwyH42jJyg@mail.gmail.com>
 <20191213070253.a6dhb6vjmwlm6fqc@pengutronix.de>
 <20191213072434.2cezzjvnohmpntha@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191213072434.2cezzjvnohmpntha@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.105.111.dyn.edpnet.net[94.105.105.111]
X-Barracuda-Start-Time: 1576224404
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2859
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5415 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78628
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On vr, 13 dec 2019 08:24:34 +0100, Oleksij Rempel wrote:
> On Fri, Dec 13, 2019 at 08:02:53AM +0100, Oleksij Rempel wrote:
> > Hi Elenita,
> > 
> > On Thu, Dec 12, 2019 at 03:49:48PM -0600, Elenita Hinds wrote:
> > > Hi Kurt,
> > > 
> > > I tried using getsockname() to retrieve the source address that was
> > > successfully claimed by jacd but was always getting 0xfe (I was
> > > expecting it to be 0xf9 as claimed by jacd).
> > > Is getsockname() expected to be functional for J1939 with kernel v5.4?
> > > Is there another way to retrieving the dynamically claimed address real-time?
> > 
> > Current stack implementation will return on getsockname(sock, ...) and
> > getpeername(sock, ...) values provided by user via bind() and/or connect(). If
> > we configure the socket by name, then address are automatically resolved
> > over address claim cache.
> 
> Hm.. this sentence  can be misinterpreted. I'll rephrase it:
> 
> The address are automatically resolved for internal use. And could be
> potentially resolved for get[sock,peer]name() as well.

While being sure that it is possible, looking back at the kernel code,
I realised that the effective address is never cached per socket, which
is good.
> 
> > The question is, should we return some thing different?
> > If yes, it will be interesting to know, why is it needed? What is the
> > use case?

It started with:
> > > > > > (3) The claimed address is only saved to a file when the program
> > > > > > terminates.  What is the reason for this? Can it not be saved after
> > > > > > one is claimed already so that another process can  read it real-time
> > > > > > if needed?
> > > > >
> > > > > That should not be necessary.
> > > > > At time of writing jacd, you could consult 'ip addr show can0' to find
> > > > > out. I'm not sure what option remained to find it.
> > > > > I believe you can, from another program, bind() with the same name, and
> > > > > then getsockname() will return the complete sockaddr_can with SA filled
> > > > > in.

Getting the response from the kernel would eliminate a cache effect, but
I'm wrong there, a result via getsockname() is equally subject to
caching.

> > > > > > Also, in cases of a program crash or a power outage, the
> > > > > > claimed address is still saved.
> > > > >
> > > > > That is a true remark.
> > > > > Given a power outage (the program never crashes :-) ),
> > > > > and looking at the code, +10 years later, I would now write to a temp file,
> > > > > and rename() the file to make it an atomic operation.
> > > > > Doing that regularly, or upon change, would be an improvement.

Since saving the address in a cache file from jacd is good practise to guard against
power failures, the quick solution is to use that cache file from
anywhere you want.

Kind regards,
Kurt
