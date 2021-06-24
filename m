Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0638B3B2C90
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 12:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhFXKj7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Jun 2021 06:39:59 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:53268 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhFXKj6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Jun 2021 06:39:58 -0400
X-ASG-Debug-ID: 1624531057-15c4330a6c7da8f0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.105.164.dyn.edpnet.net [94.105.105.164]) by relay-b02.edpnet.be with ESMTP id ZGDHcioJPqqrYYcp; Thu, 24 Jun 2021 12:37:37 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.105.164.dyn.edpnet.net[94.105.105.164]
X-Barracuda-Apparent-Source-IP: 94.105.105.164
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id BD11D1504253;
        Thu, 24 Jun 2021 12:37:37 +0200 (CEST)
Date:   Thu, 24 Jun 2021 12:37:36 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 1/3] can-calc-bittiming: add stm32 bxcan
Message-ID: <20210624103736.GB20770@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH 1/3] can-calc-bittiming: add stm32 bxcan
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
References: <20210624031954.26195-1-dev.kurt@vandijck-laurijssen.be>
 <20210624062016.tabvejebommpqcuj@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210624062016.tabvejebommpqcuj@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.105.164.dyn.edpnet.net[94.105.105.164]
X-Barracuda-Start-Time: 1624531057
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 995
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.90865
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, 24 Jun 2021 08:20:16 +0200, Marc Kleine-Budde wrote:
> On 24.06.2021 05:19:52, Kurt Van Dijck wrote:
> > Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> > ---
> >  can-calc-bit-timing.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
> > index d99bd22..fb61947 100644
> > --- a/can-calc-bit-timing.c
> > +++ b/can-calc-bit-timing.c
> > @@ -273,6 +273,22 @@ static void printf_btr_rcar_can(struct can_bittiming *bt, bool hdr)
> >  	}
> >  }
> >  
> > +		.bittiming_const = {
> > +			.name = "bxcan",
> 
> What's that? A new CAN-IP  core?

It's the 'old' CAN core used in STM32 cortex-m mcu's.

> I can apply these patches to the can-utils or you can create a github
> pull request and I'll merge it there. What do you prefer?

my preference is to apply from email.
The dinosaur icon on my github account comes with a reason?

Kind regards
Kurt
