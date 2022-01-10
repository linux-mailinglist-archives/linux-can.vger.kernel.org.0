Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14589489C39
	for <lists+linux-can@lfdr.de>; Mon, 10 Jan 2022 16:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiAJPax (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Jan 2022 10:30:53 -0500
Received: from relay-b01.edpnet.be ([212.71.1.221]:43974 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiAJPax (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Jan 2022 10:30:53 -0500
X-ASG-Debug-ID: 1641828651-15c4341a2628614d0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.123.152.dyn.edpnet.net [94.105.123.152]) by relay-b01.edpnet.be with ESMTP id oOTCvengtcGGQ903; Mon, 10 Jan 2022 16:30:51 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.123.152.dyn.edpnet.net[94.105.123.152]
X-Barracuda-Apparent-Source-IP: 94.105.123.152
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 17661177ACE2;
        Mon, 10 Jan 2022 16:30:51 +0100 (CET)
Date:   Mon, 10 Jan 2022 16:30:49 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: softing: softing_startstop(): fix set but not used
 variable warning
Message-ID: <YdxRKewBfuHErJry@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH] can: softing: softing_startstop(): fix set but not used
 variable warning
Mail-Followup-To: Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20220109103126.1872833-1-mkl@pengutronix.de>
 <YdstmL4KSn70ziqx@x1.vandijck-laurijssen.be>
 <20220110082618.4jhkcwe3b7cm26ko@pengutronix.de>
 <bd809029-9fc2-1e04-92f8-8efbb8b87d1e@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd809029-9fc2-1e04-92f8-8efbb8b87d1e@hartkopp.net>
X-Barracuda-Connect: 94.105.123.152.dyn.edpnet.net[94.105.123.152]
X-Barracuda-Start-Time: 1641828651
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 933
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.95235
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On ma, 10 jan 2022 09:51:59 +0100, Oliver Hartkopp wrote:
> On 10.01.22 09:26, Marc Kleine-Budde wrote:
> > On 09.01.2022 19:46:48, Kurt Van Dijck wrote:
> > > Acked-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> > > 
> > > > out. Its stated that the functionality is not finally verified.
> > > 
> > > The subsequent call works, but I wasn't able to produce the bus errors,
> > > so I could not verify that is actually worked.
> > > 
> > > And by now, I don't have access to the card, nor do I have a PCMCIA slot :-)
> > 
> > I think Oliver still has a laptop with a PCMCIA slot, but I don't know
> > if he has that HW....
> 
> Huh. I can search for that card in the office when I get there next time. I
> have no idea if someone binned the card in the meantime - as the Laptops do
> not provide PCMCIA for years now ...

No-one ever asked for this feature, so would not spend too much time now.

Kurt
