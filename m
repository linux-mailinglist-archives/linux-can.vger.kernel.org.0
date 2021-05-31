Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595113958C3
	for <lists+linux-can@lfdr.de>; Mon, 31 May 2021 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhEaKLn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 31 May 2021 06:11:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:46340 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhEaKLY (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 31 May 2021 06:11:24 -0400
IronPort-SDR: nJ4YGCiqJpMm6PzfCsCRM7PxjJckyvvHu5YF4pQ3DeKx4kzSUnR2gZ+6BsJZoqiFkXtxFrKwSm
 LZJn+JYfUPuw==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="203336821"
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="203336821"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 03:09:44 -0700
IronPort-SDR: xk2EOJafY4SP/bH20KX84iGJBdjmqhtc3w+qdLD8xVHfM48uw2khSjc4rheW4TSA/EtHfVD7VG
 TsMSxt6xihwA==
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="446554577"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 03:09:43 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lnerd-00G4C5-Js; Mon, 31 May 2021 13:09:41 +0300
Date:   Mon, 31 May 2021 13:09:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v3 1/2] can: mcp251xfd: mcp251xfd_probe(): try to get
 crystal clock rate from property
Message-ID: <YLS15VESjAVZ2w6G@smile.fi.intel.com>
References: <20210531084444.1785397-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531084444.1785397-1-mkl@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, May 31, 2021 at 10:44:43AM +0200, Marc Kleine-Budde wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> In some configurations, mainly ACPI-based, the clock frequency of the
> device is supplied by very well established 'clock-frequency'
> property. Hence, try to get it from the property at last if no other
> providers are available.

Oops, I have answered to v2 before looking for new version from you,

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

> v3: - only read clock-frequency property if no clk is found
>     - add error handling to device_property_read_u32()
> v2: new patch    
> 
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index 47c3f408a799..c8f8bdfc1bfb 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -2883,11 +2883,19 @@ static int mcp251xfd_probe(struct spi_device *spi)
>  		return dev_err_probe(&spi->dev, PTR_ERR(reg_xceiver),
>  				     "Failed to get Transceiver regulator!\n");
>  
> -	clk = devm_clk_get(&spi->dev, NULL);
> +	clk = devm_clk_get_optional(&spi->dev, NULL);
>  	if (IS_ERR(clk))
>  		return dev_err_probe(&spi->dev, PTR_ERR(clk),
>  				     "Failed to get Oscillator (clock)!\n");
> -	freq = clk_get_rate(clk);

> +	if (clk) {

This check basically only for property case, clk_get_rate() has it.
That's why I have different flow, but this one also will work, thanks!

> +		freq = clk_get_rate(clk);
> +	} else {
> +		err = device_property_read_u32(&spi->dev, "clock-frequency",
> +					       &freq);
> +		if (err)
> +			return dev_err_probe(&spi->dev, err,
> +					     "Failed to get clock-frequency!\n");
> +	}
>  
>  	/* Sanity check */
>  	if (freq < MCP251XFD_SYSCLOCK_HZ_MIN ||
> -- 
> 2.30.2
> 
> 

-- 
With Best Regards,
Andy Shevchenko


