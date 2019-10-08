Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C179CF710
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 12:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfJHKcv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 06:32:51 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:39436 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbfJHKcv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2019 06:32:51 -0400
X-ASG-Debug-ID: 1570530769-0a7ff54e97aefa40001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.74.adsl.dyn.edpnet.net [77.109.105.74]) by relay-b01.edpnet.be with ESMTP id hDDvpL6eGN7RRCav; Tue, 08 Oct 2019 12:32:49 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Apparent-Source-IP: 77.109.105.74
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id CA738A479FD;
        Tue,  8 Oct 2019 12:32:48 +0200 (CEST)
Date:   Tue, 8 Oct 2019 12:32:47 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>
Subject: Re: [PATCH v3 0/4] can: c_can/rx-offload
Message-ID: <20191008103247.GC21036@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH v3 0/4] can: c_can/rx-offload
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>
References: <20191008075226.12544-1-mkl@pengutronix.de>
 <20191008080711.GA20524@x1.vandijck-laurijssen.be>
 <002eccee-3357-2ed8-5ba8-6f1a39b345bc@pengutronix.de>
 <20191008082404.GC20524@x1.vandijck-laurijssen.be>
 <a7579a05-53a6-00b8-e084-1025d5e9adbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7579a05-53a6-00b8-e084-1025d5e9adbe@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Start-Time: 1570530769
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1483
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5001 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77213
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 08 okt 2019 10:32:18 +0200, Marc Kleine-Budde wrote:
> On 10/8/19 10:24 AM, Kurt Van Dijck wrote:
> >>>> taking up Kurt's work. I've cleaned up the rx-offload and c_can patches
> >>>> a bit. Untested as I don't have any hardware at hand.
> >>>
> >>> I had created equivalent code (skb_queue in isr, skb_dequeue in napi
> >>> handler) running on a 4.9 kernel since some days now. I didn't observe
> >>> any problems yet.
> >>
> >> This is based on the patches you send around.
> >> Anyways can you send me your currently working version?
> > 
> > I know. My first attempt was to backport rx-offload, but this was more
> > work than expected, so I created this patch, doing the skb_queue inside
> > c_can driver directly. I wrote that patch with the latest rx-offload.c
> > side-by-side.
> > 
> > I just wrote it this way quickly so I could go ahead and test the mower,
> > upgrading to a more recent kernel is scheduled within a few months or
> > so.
> 
> Ok, so which variant should be integrated into the kernel?

The maintenance of a linear skb_queue by itself felt not that complicated.
The napi part however requires more attention.

My ad-hoc skb_queue implementation feels dirty given the rx-offload work.
The risk of having duplicated napi-handlers convinced me to use
rx-offload, and I'm still convinced of that.

So I vote for the rx-offload variant.

As said, I created my ad-hoc skb_queue because rx-offload wasn't in v4.9.

Kurt
