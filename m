Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9348EFACBD
	for <lists+linux-can@lfdr.de>; Wed, 13 Nov 2019 10:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfKMJT0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Nov 2019 04:19:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:30297 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfKMJT0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 13 Nov 2019 04:19:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 01:19:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,299,1569308400"; 
   d="scan'208";a="202693334"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 13 Nov 2019 01:19:23 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iUoo7-00008f-BL; Wed, 13 Nov 2019 11:19:23 +0200
Date:   Wed, 13 Nov 2019 11:19:23 +0200
From:   "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To:     Drew Fustini <pdp7pdp7@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>, mark@battlesnake.co.uk
Subject: Re: mcp251x: read oscillator frequency?
Message-ID: <20191113091923.GA32742@smile.fi.intel.com>
References: <CAEf4M_AVk=2cZJ4LQ8QdnNa=6se4bCLkBPLFY5qR=ECpaq7ZKg@mail.gmail.com>
 <9d854335-366a-0b7f-1985-5e1d3245d33a@pengutronix.de>
 <20191111183912.GA7051@x1>
 <e61a86f9-c201-458c-2522-a8044e93bc08@pengutronix.de>
 <20191112064624.GA13873@x1>
 <8557f946-bb99-5ff8-5651-91757dc958ba@pengutronix.de>
 <CAEf4M_CbSPS-HrOi_LcFm_SW50o6wH0pu17iKBQCA4dV9oDp-g@mail.gmail.com>
 <CAEf4M_B-ChHseDWkRLJKxF-sCrNXe8gCoGO32kZnkQfYXGMByA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4M_B-ChHseDWkRLJKxF-sCrNXe8gCoGO32kZnkQfYXGMByA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Nov 12, 2019 at 01:15:26PM -0800, Drew Fustini wrote:
> On Tue, Nov 12, 2019 at 1:01 PM Drew Fustini <pdp7pdp7@gmail.com> wrote:
> > I based the overlay I was using one a MCP2515 overlay for SPI0 on
> > BeagleBone Black:
> > https://github.com/battlesnake/beaglebone-spi0-mcp2515/blob/master/MCP2515.dts
> >
> > I'm not sure where those extra "mcp251x," properties come from since
> > the driver does not appear to use them at all.
> 
> I searched for "mcp251x,oscillator-frequency" on google and found this
> old patch by Alessandro Zummo <a.zummo@towertech.it>:
> https://github.com/beagleboard/meta-beagleboard/blob/master/common-bsp/recipes-kernel/linux/linux-mainline-3.8/net/0006-mcp251x-add-device-tree-support.patch
> 
> It does read some of those properties:
> + of_property_read_u32(np, "mcp251x,oscillator-frequency", &tmp);
> + pd->stay_awake = of_property_read_bool(np, "mcp251x,stay-awake");
> + pd->enable_clkout = of_property_read_bool(np, "mcp251x,enable-clkout");

> Maybe there are people using this out of tree patch still and
> therefore including those properties like Mark K Cowan did in:
> https://github.com/beagleboard/bb.org-overlays/blob/master/src/arm/MCP2515-SPI0.dts

First of all, there are rules (which are getting stricter all the time) about
property names and use in DT. Second, no one cares about out-of-tree
customizations. In kernel we consider no regression made if we introduce
properties that are not compatible with no-one-knows DTSes (it didn't work
with older kernel, it continue not working with new — status quo).

-- 
With Best Regards,
Andy Shevchenko


