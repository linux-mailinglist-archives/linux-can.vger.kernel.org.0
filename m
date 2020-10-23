Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96479296E19
	for <lists+linux-can@lfdr.de>; Fri, 23 Oct 2020 13:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463313AbgJWL67 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 23 Oct 2020 07:58:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:21613 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463312AbgJWL67 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 23 Oct 2020 07:58:59 -0400
IronPort-SDR: hFV27u1ohVRBDk4oLP46zHANYY64jvATmOaq4RJGzY/vTWJJPGVBDsNqG25sjmVNBugJo5UVo4
 tNgVXDFhRcfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="154621063"
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="154621063"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 04:58:57 -0700
IronPort-SDR: 1ghCkyCksEFvuCjR5QMKaNhPlDKWcA5VjQ51mPksGU+rBvQgHbeB3YOiyhtzLNslRGV6kuA1/Y
 Ov9G/HblvtQA==
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="349184547"
Received: from hmulerox-mobl.amr.corp.intel.com (HELO pflykt-mobl1.ger.corp.intel.com) ([10.252.5.196])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 04:58:53 -0700
Received: by pflykt-mobl1.ger.corp.intel.com (Postfix, from userid 1100)
        id C71C43200D0; Fri, 23 Oct 2020 14:58:49 +0300 (EEST)
Message-ID: <b1d4f3945fc8d4775dc561da1e33209300740de8.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] NET: mcan: Move runtime PM enable/disable to
 m_can_platform
From:   Patrik Flykt <patrik.flykt@linux.intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     wg@grandegger.com, dmurphy@ti.com, sriram.dash@samsung.com,
        jarkko.nikula@intel.com
Date:   Fri, 23 Oct 2020 14:58:49 +0300
In-Reply-To: <078d9bcd-cff5-12e6-22f4-0fb225b86b5e@pengutronix.de>
References: <20200825101736.158578-1-patrik.flykt@linux.intel.com>
         <20200825101736.158578-2-patrik.flykt@linux.intel.com>
         <078d9bcd-cff5-12e6-22f4-0fb225b86b5e@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, 2020-10-19 at 17:47 +0200, Marc Kleine-Budde wrote:
> > Therefore, in anticipation of PCI devices, move PM enabling out
> > from M_CAN class registration to its currently only user, the
> > m_can_platform driver.
> 
> Makes sense.
> 
> > Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
> 
> Please rebase this patch onto linux-can/m_can
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/log/?h=m_can

Rebased and sent as v2.

Thanks!

	Patrik

