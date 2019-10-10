Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7288D2B2D
	for <lists+linux-can@lfdr.de>; Thu, 10 Oct 2019 15:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbfJJNW5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Oct 2019 09:22:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:3081 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388099AbfJJNW4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 10 Oct 2019 09:22:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 06:22:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,280,1566889200"; 
   d="scan'208";a="394039443"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 10 Oct 2019 06:22:55 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iIYP8-0006lh-0R; Thu, 10 Oct 2019 16:22:54 +0300
Date:   Thu, 10 Oct 2019 16:22:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v2] can: mcp251x: Get rid of legacy platform data
Message-ID: <20191010132253.GU32742@smile.fi.intel.com>
References: <20191008162039.58458-1-andriy.shevchenko@linux.intel.com>
 <b0cbee28-7e4c-894a-1251-d981f883e3cc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0cbee28-7e4c-894a-1251-d981f883e3cc@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Oct 09, 2019 at 09:41:40AM +0200, Marc Kleine-Budde wrote:
> On 10/8/19 6:20 PM, Andy Shevchenko wrote:
> > Instead of using legacy platform data, switch to use device properties.
> > For clock frequency we are using well established clock-frequency property.
> > 
> > Users, two for now, are also converted here.
> > 
> > Cc: Daniel Mack <daniel@zonque.org>
> > Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> > Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v2: fix issues kbuild bot complains about
> 
> I've asked David not to merge, so I'll include v2 in my new pull request.

Thank you, and sorry it takes more iterations.

-- 
With Best Regards,
Andy Shevchenko


