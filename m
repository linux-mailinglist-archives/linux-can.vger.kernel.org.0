Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF0D26AB53
	for <lists+linux-can@lfdr.de>; Tue, 15 Sep 2020 19:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgIOR7M (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Sep 2020 13:59:12 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:32911 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgIOR7E (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 13:59:04 -0400
X-ASG-Debug-ID: 1600192728-0a7b8d13bddaa020001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.65.adsl.dyn.edpnet.net [77.109.119.65]) by relay-b02.edpnet.be with ESMTP id 6i2hAFXrAxjdwBwA; Tue, 15 Sep 2020 19:58:48 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.65.adsl.dyn.edpnet.net[77.109.119.65]
X-Barracuda-Apparent-Source-IP: 77.109.119.65
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 1037A1038192;
        Tue, 15 Sep 2020 19:58:48 +0200 (CEST)
Date:   Tue, 15 Sep 2020 19:58:38 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, o.rempel@pengutronix.de
Subject: Re: [PATCH 0/6] Add support for MCP25XXFD SPI-CAN Network driver
Message-ID: <20200915175838.GA12860@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH 0/6] Add support for MCP25XXFD SPI-CAN Network driver
Mail-Followup-To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, o.rempel@pengutronix.de
References: <20200910133806.25077-1-manivannan.sadhasivam@linaro.org>
 <20200915161925.GA5660@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915161925.GA5660@linux>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.119.65.adsl.dyn.edpnet.net[77.109.119.65]
X-Barracuda-Start-Time: 1600192728
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1141
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9731 1.0000 4.0333
X-Barracuda-Spam-Score: 4.03
X-Barracuda-Spam-Status: No, SCORE=4.03 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.84649
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 15 sep 2020 21:49:25 +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> On Thu, Sep 10, 2020 at 07:08:00PM +0530, Manivannan Sadhasivam wrote:
> > Hello,
> 
> Just a quick question: I don't see any activity on this specific driver for
> sometime (back in Martin days itself). Is it due to lack of reviewers or
> it is due to the patch size (lines of code) so that nobody is interested
> in reviewing?

If you look around, there are currently several versions of mcp251x
driver around, shipped by hardware vendors who glue the chip on there
SOM etc.
Until something more-or-less clean becomes mainline, the effort remains
spread.

A problem to import a complete driver is that ... its complete.
There was an suggestion to split into several patches, but that does not
really affect the review work.

The original driver failed to initialize under a loaded CAN bus, on my
desk. The current driver is more cleanly written than the original
and it seems to survive more than 1 use case (although I have a MAB overflow
report pending to investigate).
So, this is a good candidate for mainline.

Kind regards,
Kurt
