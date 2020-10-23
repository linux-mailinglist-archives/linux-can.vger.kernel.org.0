Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1761D296E13
	for <lists+linux-can@lfdr.de>; Fri, 23 Oct 2020 13:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463270AbgJWL60 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Oct 2020 07:58:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:42740 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463294AbgJWL6P (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 23 Oct 2020 07:58:15 -0400
IronPort-SDR: wut4zELxKx477zVAkHBBmUTDSDWKwYcLZIZwkBfuMklxB2LjNkz+y3j9WNYRaIwZCzSs95HUfZ
 GaJ0n6H7h8Ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="155447265"
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="155447265"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 04:58:10 -0700
IronPort-SDR: i+BMHU+ouDMAWNi0srausGvwR8XxqDuHw74oFMUA6uJjNs6c7k+VOveQct8Ht0is26aGrpjAhP
 nM2cnoS78uNA==
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="302649757"
Received: from hmulerox-mobl.amr.corp.intel.com (HELO pflykt-mobl1.ger.corp.intel.com) ([10.252.5.196])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 04:58:05 -0700
Received: by pflykt-mobl1.ger.corp.intel.com (Postfix, from userid 1100)
        id 0137A3200D0; Fri, 23 Oct 2020 14:58:00 +0300 (EEST)
From:   Patrik Flykt <patrik.flykt@linux.intel.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de, dmurphy@ti.com,
        sriram.dash@samsung.com, jarkko.nikula@intel.com
Subject: [PATCH v2 0/1] NET: mcan: Move runtime PM enable/disable to m_can_platform
Date:   Fri, 23 Oct 2020 14:57:59 +0300
Message-Id: <20201023115800.46538-1-patrik.flykt@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - PL 281, 00181 Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


        Hi,

This is a preparatory patch for modifying PM enabling due to PCI based
M_CAN devices. As the functionality is right now, adding a PCI based
M_CAN driver causes the core PCI functionality to call
pm_runtime_enable() from pci_pm_init() when the PCI device is added.
When the device is added, it is registered with m_can_class_register(),
which ends up calling pm_runtime_enable() once more and causes the
kernel to log an angry 'Unbalanced pm_runtime_enable!' message, as
dev->power.disable_depth has gone down to zero.

To resolve this situation, I have added a patch that moves runtime PM
enabling from m_can.c to the m_can_platform.c driver, which currently
is the only driver that ends up enabling runtime PM.

Thanks,

        Patrik


Patrik Flykt (1):
  NET: mcan: Move runtime PM enable/disable to m_can_platform

 drivers/net/can/m_can/m_can.c          | 9 ++-------
 drivers/net/can/m_can/m_can_platform.c | 7 ++++++-
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.28.0

