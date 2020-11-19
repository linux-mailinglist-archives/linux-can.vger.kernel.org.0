Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CC92B8CF9
	for <lists+linux-can@lfdr.de>; Thu, 19 Nov 2020 09:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKSIRJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Nov 2020 03:17:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:1770 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgKSIRI (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 19 Nov 2020 03:17:08 -0500
IronPort-SDR: HWUQHgy4iAx3Nx8tsrzsFLaHDijl489jX/Ab3Eb4VzqXiBtMZTphVAubARo7iNngKmHIk0ErMT
 TUdW2CAwR0cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="170470355"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="170470355"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 00:17:08 -0800
IronPort-SDR: Q60qfCzDOYbGzEDo2PTL1uAnDSG7gfn7Ku5YJyd/0iU2mwvFt63qaQPoA6h2A4MhGU8FLYt7zK
 8gTebN3T+9EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="359868833"
Received: from mylly.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by fmsmga004.fm.intel.com with ESMTP; 19 Nov 2020 00:16:59 -0800
Subject: Re: [PATCH] can: m_can: Add PCI glue driver for Intel Elkhart Lake
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Patrik Flykt <patrik.flykt@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
References: <20201117160827.3636264-1-jarkko.nikula@linux.intel.com>
 <0730df74-60fb-8364-14ba-a4a6ce05b543@pengutronix.de>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <b742048b-5407-2853-a635-c0fabb624881@linux.intel.com>
Date:   Thu, 19 Nov 2020 10:16:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0730df74-60fb-8364-14ba-a4a6ce05b543@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 11/18/20 5:45 PM, Marc Kleine-Budde wrote:
> I've applied the patches to linux-can-next/m_can, which is available here
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?h=m_can
> 
> Can you please test that branch. This will go into next, once the net/master is
> merged to net-next/master.
> 
Thanks, works fine at quick test. I had the patch from top of linux-next 
tag next-20201117 so it wasn't very far away from you branch. Will send 
fixes if we'll notice and hopefully ours don't cause any :-)

Jarkko
