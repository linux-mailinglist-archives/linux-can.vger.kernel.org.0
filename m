Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0D96C3123
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2019 12:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbfJAKWW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Oct 2019 06:22:22 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:42087 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJAKWW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Oct 2019 06:22:22 -0400
X-ASG-Debug-ID: 1569925338-0a7ff54e9759acb0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.18.adsl.dyn.edpnet.net [77.109.119.18]) by relay-b01.edpnet.be with ESMTP id vIHGIWV7ZLGUJdgH; Tue, 01 Oct 2019 12:22:18 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Apparent-Source-IP: 77.109.119.18
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 31F87A1E2DA;
        Tue,  1 Oct 2019 12:22:18 +0200 (CEST)
Date:   Tue, 1 Oct 2019 12:22:17 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 2/3] net can c_can: replace napi-hanlder with irqthread
Message-ID: <20191001102217.GA25141@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH 2/3] net can c_can: replace napi-hanlder with irqthread
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
References: <1569871843-28655-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <1569871843-28655-3-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <6aa6d0f0-e424-0874-19c8-73a8344a1458@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6aa6d0f0-e424-0874-19c8-73a8344a1458@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Start-Time: 1569925338
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1330
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8927 1.0000 3.1482
X-Barracuda-Spam-Score: 3.15
X-Barracuda-Spam-Status: No, SCORE=3.15 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.76996
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 01 okt 2019 11:40:09 +0200, Marc Kleine-Budde wrote:
> On 9/30/19 9:30 PM, Kurt Van Dijck wrote:
> > The napi-handler defers c_can reception to softirq, but it is hard to
> > control the RT priority of the CAN recv end inside a softirq.
> > Using an irqthread allows precise control of it's RT priority.
> > Having the quota still around in the IRQ thread allows to restrict
> > the work_done per cycle.
> > 
> > Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> 
> NACK, not pushing CAN frames though NAPI results in very strange things,
> such like package reordering.

This becomes interesting.
Would you mind elaborating a bit on that.

I'm currently trying to avoid CAN overflows on an RT system, where
I eleveated the can irq thread above the others.
Then I discovered that the softirqd waits a lot before being scheduled,
but this one deal with all others too, so I started to question the whole
softirq thing because its a garbage can for all postponed work.
Mirgrating to a threaded irq seems wise to me then.

If a single thread reads all the incoming messages from the chip,
the are received in order, I assume. Who would reorder the packets?
Is synchronizing rx/tx paths handled in napi? they depend on different
softirqs, if I remember well.

Kind regards,

Kurt
