Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38E1251677
	for <lists+linux-can@lfdr.de>; Tue, 25 Aug 2020 12:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgHYKRt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Aug 2020 06:17:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:44646 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgHYKRo (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 25 Aug 2020 06:17:44 -0400
IronPort-SDR: YMMivPtdzlw0paYti+VrNVEI7UqKyihN411PV9npH7KrpTj/UBdJpc523ohKOUCxymvSBKaGCN
 HMPiPp/o0jyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="217631618"
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="217631618"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 03:17:43 -0700
IronPort-SDR: mTQ50+IjGTeW5yMuKKc/b/sEWL1PQcPOHJdffuIHwCFtVUW8u5RhU+zFC6bxRP4wEpbRcx0fjl
 bo3CFXdsAk/g==
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="322707985"
Received: from jinalbex-wtg.gar.corp.intel.com (HELO pflykt-mobl1.ger.corp.intel.com) ([10.252.20.102])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 03:17:40 -0700
Received: by pflykt-mobl1.ger.corp.intel.com (Postfix, from userid 1100)
        id C9959321596; Tue, 25 Aug 2020 13:17:36 +0300 (EEST)
From:   Patrik Flykt <patrik.flykt@linux.intel.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de, dmurphy@ti.com,
        sriram.dash@samsung.com, jarkko.nikula@intel.com
Subject: [PATCH 1/1] NET: mcan: Move runtime PM enable/disable to m_can_platform
Date:   Tue, 25 Aug 2020 13:17:36 +0300
Message-Id: <20200825101736.158578-2-patrik.flykt@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200825101736.158578-1-patrik.flykt@linux.intel.com>
References: <20200825101736.158578-1-patrik.flykt@linux.intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - PL 281, 00181 Helsinki
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is a preparatory patch for upcoming PCI based M_CAN devices.
The current PM implementation would cause PCI based drivers to
enable PM twice, once when the pci device is added and a second
time in m_can_class_register(). This will cause 'Unbalanced
pm_runtime_enable!' to be logged, and is a situation that should
be avoided.

Therefore, in anticipation of PCI devices, move PM enabling out
from M_CAN class registration to its currently only user, the
m_can_platform driver.


Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
---
 drivers/net/can/m_can/m_can.c          | 6 +-----
 drivers/net/can/m_can/m_can_platform.c | 3 +++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 02c5795b7393..2c4d74113443 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1817,7 +1817,6 @@ int m_can_class_register(struct m_can_classdev *m_can_dev)
 	int ret;
 
 	if (m_can_dev->pm_clock_support) {
-		pm_runtime_enable(m_can_dev->dev);
 		ret = m_can_clk_start(m_can_dev);
 		if (ret)
 			goto pm_runtime_fail;
@@ -1847,11 +1846,8 @@ int m_can_class_register(struct m_can_classdev *m_can_dev)
 clk_disable:
 	m_can_clk_stop(m_can_dev);
 pm_runtime_fail:
-	if (ret) {
-		if (m_can_dev->pm_clock_support)
-			pm_runtime_disable(m_can_dev->dev);
+	if (ret)
 		free_candev(m_can_dev->net);
-	}
 
 	return ret;
 }
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 38ea5e600fb8..1260e99b9322 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -111,7 +111,10 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	m_can_init_ram(mcan_class);
 
+	pm_runtime_enable(mcan_class->dev);
 	ret = m_can_class_register(mcan_class);
+	if (ret)
+		pm_runtime_disable(mcan_class->dev);
 
 failed_ret:
 	return ret;
-- 
2.27.0

