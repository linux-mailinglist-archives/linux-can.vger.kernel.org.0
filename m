Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F0320C3F0
	for <lists+linux-can@lfdr.de>; Sat, 27 Jun 2020 21:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgF0T4M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Sat, 27 Jun 2020 15:56:12 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:40866 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0T4M (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 27 Jun 2020 15:56:12 -0400
X-ASG-Debug-ID: 1593287768-0a8818764c5edf00001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.122.82.adsl.dyn.edpnet.net [77.109.122.82]) by relay-b03.edpnet.be with ESMTP id haIFge6aoDwQ1Bk5; Sat, 27 Jun 2020 21:56:08 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.122.82.adsl.dyn.edpnet.net[77.109.122.82]
X-Barracuda-Apparent-Source-IP: 77.109.122.82
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 6CCE2F7552C;
        Sat, 27 Jun 2020 21:56:08 +0200 (CEST)
Date:   Sat, 27 Jun 2020 21:56:05 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH v41 3/3] can: mcp25xxfd: initial commit
Message-ID: <20200627195605.GC30275@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH v41 3/3] can: mcp25xxfd: initial commit
Mail-Followup-To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20200622114603.965371-1-mkl@pengutronix.de>
 <20200622114603.965371-4-mkl@pengutronix.de>
 <20200626133243.GA8333@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200626133243.GA8333@Mani-XPS-13-9360>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.122.82.adsl.dyn.edpnet.net[77.109.122.82]
X-Barracuda-Start-Time: 1593287768
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2128
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8850 1.0000 3.0675
X-Barracuda-Spam-Score: 3.07
X-Barracuda-Spam-Status: No, SCORE=3.07 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82850
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On vr, 26 jun 2020 19:02:43 +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> On Mon, Jun 22, 2020 at 01:46:03PM +0200, Marc Kleine-Budde wrote:
> > This patch add support for the Microchip MCP25xxFD SPI CAN controller family.
> > 
> > Pending-Tested-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> > Pending-Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> Could you please split this patch into multiple ones? Having ~4k lines for a
> patch makes it difficult to review. I know that some parts are difficult to
> split (happened with my series as well) but anything below 1k should be fine.

IMHO, there is a huge difference between a complete new driver of 4k
lines and a change of 100 lines.
It's useless to add a non-functional driver, only to add functionality
later on.

You're right concerning real changes to a driver.

Just my opinion ...

From what I see, Marc did a good job, providing minimal functionality in
the first series. now, the driver can evolve (like adding listen-only :-) )

Kurt

> 
> Thanks,
> Mani
> 
> > ---
> >  drivers/net/can/spi/Kconfig                   |    2 +
> >  drivers/net/can/spi/Makefile                  |    1 +
> >  drivers/net/can/spi/mcp25xxfd/Kconfig         |   17 +
> >  drivers/net/can/spi/mcp25xxfd/Makefile        |    8 +
> >  .../net/can/spi/mcp25xxfd/mcp25xxfd-core.c    | 2890 +++++++++++++++++
> >  .../net/can/spi/mcp25xxfd/mcp25xxfd-crc16.c   |   89 +
> >  .../net/can/spi/mcp25xxfd/mcp25xxfd-regmap.c  |  554 ++++
> >  drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h     |  828 +++++
> >  8 files changed, 4389 insertions(+)
> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/Kconfig
> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/Makefile
> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-crc16.c
> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-regmap.c
> >  create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h
> > 
