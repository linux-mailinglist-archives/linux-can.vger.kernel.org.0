Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC77DE1360
	for <lists+linux-can@lfdr.de>; Wed, 23 Oct 2019 09:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389995AbfJWHqq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Oct 2019 03:46:46 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:55064 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389298AbfJWHqq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Oct 2019 03:46:46 -0400
X-ASG-Debug-ID: 1571816801-0a881812f4719640001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.221.wls.msr91gen3.adsl.dyn.edpnet.net [77.109.77.221]) by relay-b03.edpnet.be with ESMTP id tV6NawN76YnLcRgl; Wed, 23 Oct 2019 09:46:41 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.221.wls.msr91gen3.adsl.dyn.edpnet.net[77.109.77.221]
X-Barracuda-Apparent-Source-IP: 77.109.77.221
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id DCE04A9FE0B;
        Wed, 23 Oct 2019 09:46:40 +0200 (CEST)
Date:   Wed, 23 Oct 2019 09:46:38 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Elenita Hinds <ecathinds@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: c_can/d_can driver question
Message-ID: <20191023074638.GA10750@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: c_can/d_can driver question
Mail-Followup-To: Elenita Hinds <ecathinds@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <CAHChkrv6cKgNam-znKu_wOZm-y6gNkONmGWP6RFZpiSprq5_gQ@mail.gmail.com>
 <896bd824-1149-4229-a703-d2c946acd92b@pengutronix.de>
 <20191017074727.GA700@x1.vandijck-laurijssen.be>
 <CAHChkrsBMQy+=dQv-0JYqp7jrg3UvmQ_4JdR9WYrjAioNxfigw@mail.gmail.com>
 <CAHChkrs8iH4+2ZiQUjaD7B9CcqjfbeRG-_3R2uT+FWGSr5kGPA@mail.gmail.com>
 <20191017211604.GB27587@x1.vandijck-laurijssen.be>
 <CAHChkrtRD-KLct4BU1mq7MRL3N7YKfNpoDERRnN6SG9d7dzptw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHChkrtRD-KLct4BU1mq7MRL3N7YKfNpoDERRnN6SG9d7dzptw@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.77.221.wls.msr91gen3.adsl.dyn.edpnet.net[77.109.77.221]
X-Barracuda-Start-Time: 1571816801
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2492
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5016 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77522
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 22 okt 2019 14:58:42 -0500, Elenita Hinds wrote:
> Sorry for the delay.  Responses below ..
> 
> On Thu, Oct 17, 2019 at 4:16 PM Kurt Van Dijck
> <dev.kurt@vandijck-laurijssen.be> wrote:
> >
> > Hey,
> >
> > On do, 17 okt 2019 15:37:04 -0500, Elenita Hinds wrote:
> > > I pulled in the c_can patches from the for-kurt branch (63574e9 thru
> > > bf01f717) and tested on my device.
> > > The number of overruns are noticeably fewer; however, the overall
> > > system performance seems to have slowed down. For example,
> > > the console response and Bluetooth data rate are noticeably slower.
> >
> > You now give more precedence to CAN and less to console etc. ?
> > >
> [eh]  No. The priorities are the same or however Linux handles
> interrupt priorities.
> 
> > > I also noticed that while the number of overruns decreased, the number
> > > of errors increased:
> >
> > You have an interesting setup. I suspect that the FIFO is filled, and
> > does drop messages, although that is recorded in the statistics?
> >
> > Would you want to try branch c_can-v4.9 in github.com/kurt-vd/linux?
> > I improved the reception a bit, and increased the FIFO size.
> 
> [eh]  I pulled the c_can-v4.9 changes (delta from v4.9) and the
> behavior is the same --
> the number of overruns is reduced (about 0.011% loss compared to about
> 0.32%) but the number
> of errors is increased (used to be the same number as the overruns).

Did you look for CAN bus errors yet?
	$ ip link set can0 type can berr-reporting
	$ ip link set can0 up
and then
	$candump -e any,0~0,#FFFFFFFF

If you experience bus problems, the cpu may have troubles following
them.

> I still see a slight degradation
> in system performance.
> I also tried the c_can-more-objects branch (increased the message
> objects to 64) and this also
> improved CAN handling (about to 0.004% overruns).
> Then I combined both IRQ-rxoffload and more-objects changes together
> and the number of overruns
> is further reduced (loss is close to 0%).

That is good news for me.  I'll grab the 'more-objects' branch also.
Where did you get it?

> 
> > Besides that, can you give more details about your system and your load?
> 
> [eh] System is similar to Beagleboard Black: TI AM335x.
> From 'top', running about 0% idle, with sys about 44%, usr about 43%,
> sirq about 9%.
> Load average: 4.70 4.88 4.04
> Let me know if you need more info.
> 
> >
> > Kind regards,
> > Kurt
