Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68A50FACBA
	for <lists+linux-can@lfdr.de>; Wed, 13 Nov 2019 10:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfKMJP0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Nov 2019 04:15:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:12192 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfKMJP0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 13 Nov 2019 04:15:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 01:15:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,299,1569308400"; 
   d="scan'208";a="216327634"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2019 01:15:24 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iUokF-00006D-U6; Wed, 13 Nov 2019 11:15:23 +0200
Date:   Wed, 13 Nov 2019 11:15:23 +0200
From:   "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To:     Drew Fustini <pdp7pdp7@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: mcp251x: read oscillator frequency?
Message-ID: <20191113091523.GZ32742@smile.fi.intel.com>
References: <CAEf4M_AVk=2cZJ4LQ8QdnNa=6se4bCLkBPLFY5qR=ECpaq7ZKg@mail.gmail.com>
 <9d854335-366a-0b7f-1985-5e1d3245d33a@pengutronix.de>
 <20191111183912.GA7051@x1>
 <e61a86f9-c201-458c-2522-a8044e93bc08@pengutronix.de>
 <20191112064624.GA13873@x1>
 <8557f946-bb99-5ff8-5651-91757dc958ba@pengutronix.de>
 <CAEf4M_CbSPS-HrOi_LcFm_SW50o6wH0pu17iKBQCA4dV9oDp-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4M_CbSPS-HrOi_LcFm_SW50o6wH0pu17iKBQCA4dV9oDp-g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Nov 12, 2019 at 01:01:29PM -0800, Drew Fustini wrote:
> On Tue, Nov 12, 2019 at 12:44 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > Several of these properties are not handled by the mainline driver
> > (mcp251x,irq-gpios, mcp251x,stay-awake, mcp251x,oscillator-frequency,
> > mcp251x,enable-clkout). This doesn't have any effect, it just bloats the
> > DT by some bytes.
> >
> > Which kernel are you using?
> 
> I'm using 4.14 kernel on the PocketBeagle:
> https://github.com/beagleboard/linux/blob/4.14/drivers/net/can/spi/mcp251x.c
> 
> I see now that those properties are not in the bindings:
> https://elixir.bootlin.com/linux/v5.4-rc7/source/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
> 
> I based the overlay I was using one a MCP2515 overlay for SPI0 on
> BeagleBone Black:
> https://github.com/battlesnake/beaglebone-spi0-mcp2515/blob/master/MCP2515.dts
> 
> I'm not sure where those extra "mcp251x," properties come from since
> the driver does not appear to use them at all.
> 
> I did see the Andy posted this in October:
> 
> [PATCH v2] can: mcp251x: Get rid of legacy platform data
> https://www.spinics.net/lists/linux-can/msg02407.html
> 
> The description:
> Instead of using legacy platform data, switch to use device properties.
> For clock frequency we are using well established clock-frequency property.

Yes. This property is used a lot in other drivers (*). The rule of thumb here
is to use Clock Framework for pure DT boards. The proposed patch relies on the
property to get rid of platform data. The true (but quite big) change should be
to move those two old platforms to use DT entirely.

Besides that, using that property allows to reuse chip on ACPI based platforms.
ACPI doesn't have (yet) proper support of clocks (it assumes that all clocks
are magically configured by onboard firmwares, etc).

(*) `git grep -n -w clock-frequency -- drivers/` shows the current users

> Do you know if that is going upstream?

Marc seems put it to his pending queue.

-- 
With Best Regards,
Andy Shevchenko


