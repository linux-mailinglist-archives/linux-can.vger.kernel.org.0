Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0452A28B48B
	for <lists+linux-can@lfdr.de>; Mon, 12 Oct 2020 14:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388435AbgJLMWK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 12 Oct 2020 08:22:10 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:46974 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388491AbgJLMWK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 12 Oct 2020 08:22:10 -0400
X-ASG-Debug-ID: 1602505327-0a7b8d4d71147d5a0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.104.9.dyn.edpnet.net [94.105.104.9]) by relay-b02.edpnet.be with ESMTP id xQcX0wg8iFHOnJV7; Mon, 12 Oct 2020 14:22:07 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.104.9.dyn.edpnet.net[94.105.104.9]
X-Barracuda-Apparent-Source-IP: 94.105.104.9
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id F12B910C1616;
        Mon, 12 Oct 2020 14:22:06 +0200 (CEST)
Date:   Mon, 12 Oct 2020 14:22:02 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: mcp2517fd: transmit errors
Message-ID: <20201012122202.GB20394@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: mcp2517fd: transmit errors
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
References: <20201009141643.GE7238@x1.vandijck-laurijssen.be>
 <4b7e3856-ea32-ad61-2608-19923d7e4b0d@pengutronix.de>
 <20201009174057.GB16382@x1.vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201009174057.GB16382@x1.vandijck-laurijssen.be>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.104.9.dyn.edpnet.net[94.105.104.9]
X-Barracuda-Start-Time: 1602505327
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 749
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 1.0000 1.0000 4.3426
X-Barracuda-Spam-Score: 4.34
X-Barracuda-Spam-Status: No, SCORE=4.34 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.85236
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, 09 Oct 2020 19:40:57 +0200, Kurt Van Dijck wrote:
> On Fri, 09 Oct 2020 18:24:02 +0200, Marc Kleine-Budde wrote:
> > On 10/9/20 4:16 PM, Kurt Van Dijck wrote:
> > > Any ideas what to look for?
> > 
> > The mcp2517fd suffers from the MAB TX underflow errata: See 1. in
> > http://ww1.microchip.com/downloads/en/DeviceDoc/MCP2517FD-External-CAN-FD-Controller-with-SPI-Interface-20005688B.pdf
> > 
> > Compile the driver with "#define DEBUG" or remove the
> > "MCP251XFD_QUIRK_MAB_NO_WARN" from the mcp251xfd_devtype_data_mcp2517fd. Then
> > you should see an error message when the chip switches modes due to the MAB
> > underrun.
> I'll do this.

Yep, TX MAB underflow it is.
Thanks for the suggestion.

Kind regards,
Kurt
