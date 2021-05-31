Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7AF39589B
	for <lists+linux-can@lfdr.de>; Mon, 31 May 2021 12:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhEaKCJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 31 May 2021 06:02:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:3219 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230518AbhEaKBt (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 31 May 2021 06:01:49 -0400
IronPort-SDR: kAm0TQu2P+GRsG59E1wd3S/aZ1i/l1eOQy7/lyHWbpR2F9mGZL1YI+tKzPLIqrZL1TmxaMYpjU
 t0AMVurKb1wQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="264523054"
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="264523054"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 02:58:34 -0700
IronPort-SDR: oFTtw+LeyZUQE5FA8J3xvQs+G01ya/918el9293q9EmcOFvWzuBuH83b8Spnm/+ueHniTZh7pQ
 xyo/bnvkWE7w==
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="549368750"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 02:58:32 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lnegn-00G42P-Nk; Mon, 31 May 2021 12:58:29 +0300
Date:   Mon, 31 May 2021 12:58:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 1/2] can: mcp251xfd: Try to get crystal clock rate
 from property
Message-ID: <YLSzRdpp9EWsLeFy@smile.fi.intel.com>
References: <20210526193327.70468-1-andriy.shevchenko@linux.intel.com>
 <20210531084720.6xql2r4uhp6ruzl6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531084720.6xql2r4uhp6ruzl6@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, May 31, 2021 at 10:47:20AM +0200, Marc Kleine-Budde wrote:
> On 26.05.2021 22:33:26, Andy Shevchenko wrote:
> > In some configurations, mainly ACPI-based, the clock frequency of the device
> > is supplied by very well established 'clock-frequency' property. Hence, try
> > to get it from the property at last if no other providers are available.

> >  		return dev_err_probe(&spi->dev, PTR_ERR(reg_xceiver),
> >  				     "Failed to get Transceiver regulator!\n");
> >  
> > -	clk = devm_clk_get(&spi->dev, NULL);
> > +	/* Always ask for fixed clock rate from a property. */
> > +	device_property_read_u32(&spi->dev, "clock-frequency", &rate);
> 
> what about error handling....?

Not needed, but rate should be assigned to 0, which is missed.

> > +	clk = devm_clk_get_optional(&spi->dev, NULL);
> >  	if (IS_ERR(clk))
> >  		return dev_err_probe(&spi->dev, PTR_ERR(clk),
> >  				     "Failed to get Oscillator (clock)!\n");
> >  	freq = clk_get_rate(clk);
> > +	if (freq == 0)
> > +		freq = rate;
> 
> ... this means we don't fail if there is neither a clk nor a
> clock-frequency property.

The following will check for it (which is already in the code)

  if (freq <= MCP251XFD_SYSCLOCK_HZ_MAX / MCP251XFD_OSC_PLL_MULTIPLIER) {

> I've send a v3 to fix this.

You mean I have to send v3?
Sure!


-- 
With Best Regards,
Andy Shevchenko


