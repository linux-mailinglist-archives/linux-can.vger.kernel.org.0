Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37B7289028
	for <lists+linux-can@lfdr.de>; Fri,  9 Oct 2020 19:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbgJIRlG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Oct 2020 13:41:06 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:53881 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731889AbgJIRlE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Oct 2020 13:41:04 -0400
X-ASG-Debug-ID: 1602265260-0a881813ef98a3a0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.104.9.dyn.edpnet.net [94.105.104.9]) by relay-b03.edpnet.be with ESMTP id Br89Y4HgeGpfhNm1; Fri, 09 Oct 2020 19:41:00 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.104.9.dyn.edpnet.net[94.105.104.9]
X-Barracuda-Apparent-Source-IP: 94.105.104.9
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id B80DA109BDC7;
        Fri,  9 Oct 2020 19:41:00 +0200 (CEST)
Date:   Fri, 9 Oct 2020 19:40:57 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: mcp2517fd: transmit errors
Message-ID: <20201009174057.GB16382@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: mcp2517fd: transmit errors
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
References: <20201009141643.GE7238@x1.vandijck-laurijssen.be>
 <4b7e3856-ea32-ad61-2608-19923d7e4b0d@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b7e3856-ea32-ad61-2608-19923d7e4b0d@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.104.9.dyn.edpnet.net[94.105.104.9]
X-Barracuda-Start-Time: 1602265260
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1735
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9029 1.0000 3.2573
X-Barracuda-Spam-Score: 3.26
X-Barracuda-Spam-Status: No, SCORE=3.26 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.85175
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, 09 Oct 2020 18:24:02 +0200, Marc Kleine-Budde wrote:
> On 10/9/20 4:16 PM, Kurt Van Dijck wrote:
> > I'm using a v5.4 kernel now, with backported 'can: mcp25xxfd: initial commit'.
> > I did focus up to now to CAN recv performance, but now I face another
> > issue. I have errors transmitting to CAN.
> 
> What kind of errors?
First observation is that no response is received for some requests.
This is very high level, I need to investigate if the request is really
sent. This is a needle in a haystack.
Due to the transmit error counter in `ip -s link show can0`, I guess
it's not sent.
> 
> > It's unstable.
> 
> What does that mean?

Each burst of >x CAN frames produces the problem.
I still figure x in this statement.

I'm porting the problem to my desk to reproduce.

> 
> > I need to collect more details, and it is now about focus number 1.
> > 
> > I managed to decrease the urgency for my project by inserting a delay
> > in the most busy transmitter.
> > 
> > Any ideas what to look for?
> 
> The mcp2517fd suffers from the MAB TX underflow errata: See 1. in
> http://ww1.microchip.com/downloads/en/DeviceDoc/MCP2517FD-External-CAN-FD-Controller-with-SPI-Interface-20005688B.pdf
> 
> Compile the driver with "#define DEBUG" or remove the
> "MCP251XFD_QUIRK_MAB_NO_WARN" from the mcp251xfd_devtype_data_mcp2517fd. Then
> you should see an error message when the chip switches modes due to the MAB
> underrun.
I'll do this.

> 
> If it's that errors there's not so much you can do, maybe optimize the SPI host
> driver (or use a mcp2518fd). Which SoC are you on?
still the imx8mm, on a variscite board, with suboptimal 20MHz
oscillator, 8.5Mhz SPI speed, 1Mbit CAN

Kurt
