Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6FF2929F5
	for <lists+linux-can@lfdr.de>; Mon, 19 Oct 2020 17:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgJSPCX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Mon, 19 Oct 2020 11:02:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:9551 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729562AbgJSPCX (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 19 Oct 2020 11:02:23 -0400
IronPort-SDR: WpUye0g/3KvWAFoSaiuEREMRm/uj9Ugr1g/DSdaej1e42nN/Qc0CoGCLfUEa15lx7EBrF3d7z2
 HT7pHwGzsb9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="163558098"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="163558098"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 08:02:01 -0700
IronPort-SDR: 8XU2BV+2s5P5KrI6TiLwrKKK/vdhxNraTD3ZiOrqpd0EG8Y5nERaAZ7pRDppk6/R5O3tCACVPK
 bhwaoJyz9wLA==
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="358854295"
Received: from ipdaly-mobl1.ger.corp.intel.com (HELO pflykt-mobl1.ger.corp.intel.com) ([10.252.19.1])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 08:01:59 -0700
Received: by pflykt-mobl1.ger.corp.intel.com (Postfix, from userid 1100)
        id D8B063200D0; Mon, 19 Oct 2020 18:01:55 +0300 (EEST)
Message-ID: <06568201ce997c0950bb41864df4c6c98a06ec9e.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] NET: mcan: Move runtime PM enable/disable to
 m_can_platform
From:   Patrik Flykt <patrik.flykt@linux.intel.com>
To:     Dan Murphy <dmurphy@ti.com>, linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de, sriram.dash@samsung.com,
        jarkko.nikula@intel.com
Date:   Mon, 19 Oct 2020 18:01:55 +0300
In-Reply-To: <fa0a6baa-99b0-8ddd-69cd-07c267419bbb@ti.com>
References: <20200825101736.158578-1-patrik.flykt@linux.intel.com>
         <20200825101736.158578-2-patrik.flykt@linux.intel.com>
         <fa0a6baa-99b0-8ddd-69cd-07c267419bbb@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 2020-09-01 at 13:22 -0500, Dan Murphy wrote:
> Patrik
> 
> On 8/25/20 5:17 AM, Patrik Flykt wrote:
> > This is a preparatory patch for upcoming PCI based M_CAN devices.
> > The current PM implementation would cause PCI based drivers to
> > enable PM twice, once when the pci device is added and a second
> > time in m_can_class_register(). This will cause 'Unbalanced
> > pm_runtime_enable!' to be logged, and is a situation that should
> > be avoided.
> > 
> > Therefore, in anticipation of PCI devices, move PM enabling out
> > from M_CAN class registration to its currently only user, the
> > m_can_platform driver.

> Reviewed-by: Dan Murphy <dmurphy@ti.com>

Ping?

Can this patch be added as-is or should it be sent in the patch set
providing a PCI based M_CAN device?

Cheers,

	Patrik

