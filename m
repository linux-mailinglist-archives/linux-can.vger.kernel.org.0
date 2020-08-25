Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753F5251678
	for <lists+linux-can@lfdr.de>; Tue, 25 Aug 2020 12:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgHYKRw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Aug 2020 06:17:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:60647 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729761AbgHYKRs (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 25 Aug 2020 06:17:48 -0400
IronPort-SDR: HlwF4+okgFV5dVyjQ3VZoKKHblry5yzGN4s6XOA1GYPi+GR2jzrw0a26GTXjGUueWnQiBCHmLi
 j/hLz+gmZS0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="220344034"
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="220344034"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 03:17:43 -0700
IronPort-SDR: zO5tX7u6BIxanDKKSBqiskYxioStbQvUHCO4WCf/WbSwK5Vq+psZjhGva1CPqilT+Q5jP4a4KH
 PmhrZWTpQ/2Q==
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="499257119"
Received: from jinalbex-wtg.gar.corp.intel.com (HELO pflykt-mobl1.ger.corp.intel.com) ([10.252.20.102])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 03:17:40 -0700
Received: by pflykt-mobl1.ger.corp.intel.com (Postfix, from userid 1100)
        id C7AAF321598; Tue, 25 Aug 2020 13:17:36 +0300 (EEST)
From:   Patrik Flykt <patrik.flykt@linux.intel.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de, dmurphy@ti.com,
        sriram.dash@samsung.com, jarkko.nikula@intel.com
Subject: [PATCH 0/1] NET: mcan: Move runtime PM enable/disable to  m_can_platform
Date:   Tue, 25 Aug 2020 13:17:35 +0300
Message-Id: <20200825101736.158578-1-patrik.flykt@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - PL 281, 00181 Helsinki
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
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
is the only driver that ends up enabling runtime PM. Would this
approach be appropriate, or should PM be enabled in some other way
with PCI based M_CAN devices?

Now, the actual sticky point is that there aren't yet any PCI based
M_CAN devices upstream, but one is in the works. So if the change
proposed works out, should this patch actually be sent in the patch
set providing a PCI based M_CAN device?


Thanks,

	Patrik


Patrik Flykt (1):
  NET: mcan: Move runtime PM enable/disable to m_can_platform

 drivers/net/can/m_can/m_can.c          | 6 +-----
 drivers/net/can/m_can/m_can_platform.c | 3 +++
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.27.0

