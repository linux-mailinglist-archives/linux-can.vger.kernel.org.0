Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614B43BC91D
	for <lists+linux-can@lfdr.de>; Tue,  6 Jul 2021 12:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhGFKNn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Jul 2021 06:13:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:30535 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231208AbhGFKNn (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 6 Jul 2021 06:13:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="188769884"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="188769884"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 03:11:04 -0700
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="627635111"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 03:11:03 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m0i2d-009HNu-1e; Tue, 06 Jul 2021 13:10:59 +0300
Date:   Tue, 6 Jul 2021 13:10:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v3 1/2] can: mcp251xfd: mcp251xfd_probe(): try to get
 crystal clock rate from property
Message-ID: <YOQsM4spPVfca4dE@smile.fi.intel.com>
References: <20210531084444.1785397-1-mkl@pengutronix.de>
 <YLS15VESjAVZ2w6G@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLS15VESjAVZ2w6G@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, May 31, 2021 at 01:09:41PM +0300, Andy Shevchenko wrote:
> On Mon, May 31, 2021 at 10:44:43AM +0200, Marc Kleine-Budde wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > In some configurations, mainly ACPI-based, the clock frequency of the
> > device is supplied by very well established 'clock-frequency'
> > property. Hence, try to get it from the property at last if no other
> > providers are available.

Is this series missed merge window?
I never saw it in Linux Next and nor in vanilla...

-- 
With Best Regards,
Andy Shevchenko


