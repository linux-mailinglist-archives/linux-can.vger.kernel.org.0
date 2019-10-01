Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC00C2E29
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2019 09:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfJAHRZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Oct 2019 03:17:25 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:47329 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfJAHRZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Oct 2019 03:17:25 -0400
X-ASG-Debug-ID: 1569914241-0a7b8d53c0e38d90001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.18.adsl.dyn.edpnet.net [77.109.119.18]) by relay-b02.edpnet.be with ESMTP id VpkUfk1yy4mycwfe; Tue, 01 Oct 2019 09:17:21 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Apparent-Source-IP: 77.109.119.18
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 2D935A1D893;
        Tue,  1 Oct 2019 09:17:21 +0200 (CEST)
Date:   Tue, 1 Oct 2019 09:17:18 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Jeroen Hofstee <jhofstee@victronenergy.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [RFC] c_can improvements
Message-ID: <20191001071718.GB28537@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [RFC] c_can improvements
Mail-Followup-To: Jeroen Hofstee <jhofstee@victronenergy.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <1569871843-28655-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <6f043fdd-8ade-c8cc-1894-152a2ecdc51f@victronenergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f043fdd-8ade-c8cc-1894-152a2ecdc51f@victronenergy.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Start-Time: 1569914241
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1119
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9527 1.0000 3.8025
X-Barracuda-Spam-Score: 3.80
X-Barracuda-Spam-Status: No, SCORE=3.80 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.76991
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On ma, 30 sep 2019 21:17:44 +0000, Jeroen Hofstee wrote:
> Hello Kurt,
> 
> On 9/30/19 9:30 PM, Kurt Van Dijck wrote:
> > First patch will (try to) remove lost busoff conditions by not reading
> > the status register wihtout pending status interrupt.
> > This has ran for several weeks, and not produced any lost busoff (I'm
> > not sure it would have issued a true positive in this time).
> > I run this on a beaglebone-alike board.
> >
> > Next patch will tear c_can bottom halve isr out of napi so I can better control
> > it's RT priority without affecting other napi handlers in the same softirq.
> >
> > Last patch will combine top and bottom halve isr in case of force irq threading
> > like on an RT kernel. Having the irq split across 2 threads does not seem wise.
> 
> I will have a better look at this, but can you also
> look at https://www.spinics.net/lists/linux-can/msg02302.html?

I'll take a look. I had seen them pass by, but they slipped through.

> It might solve part of your issue, but at least there is a
> merge conflict there, I think..
> 
> Regards,
> 
> Jeroen
> 
