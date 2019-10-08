Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A313D0032
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 19:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfJHRyi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 13:54:38 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:57526 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfJHRyh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2019 13:54:37 -0400
X-ASG-Debug-ID: 1570557275-0a88186e2048f68b0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.74.adsl.dyn.edpnet.net [77.109.105.74]) by relay-b03.edpnet.be with ESMTP id 21rWNEaMpeVVQhsO; Tue, 08 Oct 2019 19:54:35 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Apparent-Source-IP: 77.109.105.74
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 1970CA49185;
        Tue,  8 Oct 2019 19:54:35 +0200 (CEST)
Date:   Tue, 8 Oct 2019 19:54:33 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>
Subject: Re: [PATCH v3 0/4] can: c_can/rx-offload
Message-ID: <20191008175433.GA19084@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH v3 0/4] can: c_can/rx-offload
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>
References: <20191008080711.GA20524@x1.vandijck-laurijssen.be>
 <002eccee-3357-2ed8-5ba8-6f1a39b345bc@pengutronix.de>
 <20191008082404.GC20524@x1.vandijck-laurijssen.be>
 <a7579a05-53a6-00b8-e084-1025d5e9adbe@pengutronix.de>
 <20191008103247.GC21036@x1.vandijck-laurijssen.be>
 <558f7402-73cb-770a-7a24-5d417d5b2bb7@pengutronix.de>
 <20191008111253.GF21036@x1.vandijck-laurijssen.be>
 <06e01ef4-5e5f-e2fc-6827-df36a8e5c109@pengutronix.de>
 <20191008125922.GG21036@x1.vandijck-laurijssen.be>
 <b8f4936d-7e3a-d2ba-5649-9ff044dc78b2@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8f4936d-7e3a-d2ba-5649-9ff044dc78b2@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Start-Time: 1570557275
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1435
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 1.0000 1.0000 4.3430
X-Barracuda-Spam-Score: 4.34
X-Barracuda-Spam-Status: No, SCORE=4.34 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77225
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 08 okt 2019 15:55:35 +0200, Marc Kleine-Budde wrote:
> On 10/8/19 2:59 PM, Kurt Van Dijck wrote:
> > On di, 08 okt 2019 13:30:12 +0200, Marc Kleine-Budde wrote:
> >> On 10/8/19 1:12 PM, Kurt Van Dijck wrote:
> >>> On di, 08 okt 2019 12:39:45 +0200, Marc Kleine-Budde wrote:
> >>>> On 10/8/19 12:32 PM, Kurt Van Dijck wrote:
> >>>>> On di, 08 okt 2019 10:32:18 +0200, Marc Kleine-Budde wrote:
> >>>>>> On 10/8/19 10:24 AM, Kurt Van Dijck wrote:
> >>>>
> >>>> Tnx. Can you test the c_can branch from linux-can-next?
> >>>
> >>> That's the hard part, I can not advance kernel version at this point.
> >>> So a long-term test is out of question at this point.
> >>>
> >>> Funcionally, the rx-offload patch does the same as my inplace fifo patch
> >>> and that worked fine.
> >>>
> >>> I'll see where I can get with a bench test.
> >>
> >> You're using v4.9? I can backport all needed patches.
> > 
> > Yes, v4.9.
> > 
> > If you would be able to backport them, then I add them here and I'll
> > test. That's probably the easiest.
> 
> try:
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=for-kurt

Thanks for the backport.

It compiles and CAN works. I put it on a test machine now, but since it's
logically equivalent to my ad-hoc skb_queue, I expect no long-term surprises.
My test machine may need no to stop due to bad weather conditions.

Kind regards,
Kurt
