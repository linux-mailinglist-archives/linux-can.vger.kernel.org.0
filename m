Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC35DA6A6
	for <lists+linux-can@lfdr.de>; Thu, 17 Oct 2019 09:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbfJQHrg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Oct 2019 03:47:36 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:44049 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387930AbfJQHrg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Oct 2019 03:47:36 -0400
X-ASG-Debug-ID: 1571298452-0a7b8d13be883510001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.116.161.adsl.dyn.edpnet.net [77.109.116.161]) by relay-b02.edpnet.be with ESMTP id FuWO8iK5rSRAdYGn; Thu, 17 Oct 2019 09:47:32 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.116.161.adsl.dyn.edpnet.net[77.109.116.161]
X-Barracuda-Apparent-Source-IP: 77.109.116.161
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 5C9D1A7C58D;
        Thu, 17 Oct 2019 09:47:32 +0200 (CEST)
Date:   Thu, 17 Oct 2019 09:47:27 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Elenita Hinds <ecathinds@gmail.com>, linux-can@vger.kernel.org
Subject: Re: c_can/d_can driver question
Message-ID: <20191017074727.GA700@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: c_can/d_can driver question
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Elenita Hinds <ecathinds@gmail.com>, linux-can@vger.kernel.org
References: <CAHChkrv6cKgNam-znKu_wOZm-y6gNkONmGWP6RFZpiSprq5_gQ@mail.gmail.com>
 <896bd824-1149-4229-a703-d2c946acd92b@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <896bd824-1149-4229-a703-d2c946acd92b@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.116.161.adsl.dyn.edpnet.net[77.109.116.161]
X-Barracuda-Start-Time: 1571298452
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1799
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5001 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77389
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On wo, 16 okt 2019 23:01:41 +0200, Marc Kleine-Budde wrote:
> On 10/16/19 9:06 PM, Elenita Hinds wrote:
> > I'm hoping someone can help me with this ...
> > 
> > The DCAN module I'm testing with supports 64 CAN messages and DMA. The
> > combined c_can/d_can driver seem to only support 16 RX message objects
> > and no DMA (as far as I can tell).
> 
> ACK
> 
> > I noticed that older Linux version
> > (3.1) implemented a separate d_can driver that supports both.  I'm
> > wondering why these were removed from the latest c_can/d_can files.
> 
> Can you give me a pointer to this driver? Are you talking about the
> mainline linux-3.1?
> 
> > The reason for this question is I'm seeing frame losses and I think it
> > is due to the driver. Increasing the socket buffer sizes did not have
> > any effect; the number is overruns was still pretty large.
> > 
> > Any feedback would be appreciated.
> 
> The problem with the c_can and d_can is, that it doesn't have a proper
> FIFO but only mailboxes. And these mailboxes don't implement a
> timestamp, so that it's not that easy to read messages in the correct order.
> 
> Does the device support bus master DMA? As CAN messages are quite small,
> the overhead of setting up DMA might be too high.
> 
> The algorithm that tries to read the CAN frames in the correct order was
> added in v3.15. That algorithm should be ported to the rx-offload
> helper. This way the mailboxes can be read in interrupt context and not
> from NAPI (which runs in softirq context only).
> 
> If this basically works, it can be extended to support 64 mailboxes.

I'm facing overflows, and have good results with the patchset I sent
last week. As Marc says, reading the mailboxes in NAPI softirq may cause
regular overflows.

Kurt
