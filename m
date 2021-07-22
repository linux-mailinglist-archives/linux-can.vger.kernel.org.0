Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9B63D2C2C
	for <lists+linux-can@lfdr.de>; Thu, 22 Jul 2021 20:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhGVSMo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jul 2021 14:12:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:46225 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhGVSMn (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 22 Jul 2021 14:12:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="233541808"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="233541808"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 11:53:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="662809561"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 11:53:00 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m6doU-00H8uR-QA; Thu, 22 Jul 2021 21:52:54 +0300
Date:   Thu, 22 Jul 2021 21:52:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v3 1/2] can: mcp251xfd: mcp251xfd_probe(): try to get
 crystal clock rate from property
Message-ID: <YPm+hkutsbtsTNlB@smile.fi.intel.com>
References: <20210531084444.1785397-1-mkl@pengutronix.de>
 <YLS15VESjAVZ2w6G@smile.fi.intel.com>
 <YOQsM4spPVfca4dE@smile.fi.intel.com>
 <20210706101421.ukdgfo3eyoijblbu@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706101421.ukdgfo3eyoijblbu@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Jul 06, 2021 at 12:14:21PM +0200, Marc Kleine-Budde wrote:
> On 06.07.2021 13:10:59, Andy Shevchenko wrote:
> > On Mon, May 31, 2021 at 01:09:41PM +0300, Andy Shevchenko wrote:
> > > On Mon, May 31, 2021 at 10:44:43AM +0200, Marc Kleine-Budde wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > 
> > > > In some configurations, mainly ACPI-based, the clock frequency of the
> > > > device is supplied by very well established 'clock-frequency'
> > > > property. Hence, try to get it from the property at last if no other
> > > > providers are available.
> > 
> > Is this series missed merge window?
> > I never saw it in Linux Next and nor in vanilla...
> 
> Yes, I missed the merge window. Will send a pull request after -rc1
> (when net-next is open again).

Still no sign of them anywhere. Please, proceed with them!

-- 
With Best Regards,
Andy Shevchenko


