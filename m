Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDBE3B2D17
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 12:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhFXK7y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Jun 2021 06:59:54 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:60844 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbhFXK7x (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Jun 2021 06:59:53 -0400
X-ASG-Debug-ID: 1624532252-15c4355b1471e6b0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.105.164.dyn.edpnet.net [94.105.105.164]) by relay-b03.edpnet.be with ESMTP id cy8RuG25KvZWwhQv; Thu, 24 Jun 2021 12:57:32 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.105.164.dyn.edpnet.net[94.105.105.164]
X-Barracuda-Apparent-Source-IP: 94.105.105.164
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 3C46815042E4;
        Thu, 24 Jun 2021 12:57:32 +0200 (CEST)
Date:   Thu, 24 Jun 2021 12:57:31 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 3/3] can-calc-bittiming: add mcan
Message-ID: <20210624105731.GB21224@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH 3/3] can-calc-bittiming: add mcan
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
References: <20210624031954.26195-1-dev.kurt@vandijck-laurijssen.be>
 <20210624031954.26195-3-dev.kurt@vandijck-laurijssen.be>
 <20210624105005.2kgj6o5hwskl6rqo@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210624105005.2kgj6o5hwskl6rqo@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.105.164.dyn.edpnet.net[94.105.105.164]
X-Barracuda-Start-Time: 1624532252
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 999
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.90866
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, 24 Jun 2021 12:50:05 +0200, Marc Kleine-Budde wrote:
> On 24.06.2021 05:19:54, Kurt Van Dijck wrote:
> > Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> > ---
> > +	}, {
> > +		.bittiming_const = {
> > +			.name = "mcan",
> 
> This is for mcan > v3.1

I don't have any earlier.
Can I just solve by putting "mcan-v3.1+"?

> 
> > +			.tseg1_min = 1,
> > +			.tseg1_max = 256,
> > +			.tseg2_min = 1,
> 
> I just re-chcked the datasheet, and tseg{1,2} min are actually 2.

Will adapt.
I clearly didn't pay enough attention to the lower limits.

> 
> > +			.tseg2_max = 128,
> > +			.sjw_max = 128,
> > +			.brp_min = 1,
> > +			.brp_max = 512,
> > +			.brp_inc = 1,
> > +		},
> > +		.ref_clk = {
> > +			{ .clk = 40000000, },
> > +		},
> > +		.printf_btr = printf_btr_mcan,
> >  	},
> >  };
> 
> Marc

btw, I just noticed I already have can-utils in my github account, I'll
create a Merge-Request for this V2 too, if you like.

Kurt
