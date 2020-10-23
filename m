Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E992E296E14
	for <lists+linux-can@lfdr.de>; Fri, 23 Oct 2020 13:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463306AbgJWL6e (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Oct 2020 07:58:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:33876 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463297AbgJWL6S (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 23 Oct 2020 07:58:18 -0400
IronPort-SDR: bMiiAuzmrYHeD/R4CdH2KeF8FKMcVO+qjfWglkrvHXWHfE7Xu78ZVIeud3z6Gxm3xTBgNnBsGB
 YNERnTWeCtEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="146954784"
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="146954784"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 04:58:07 -0700
IronPort-SDR: Gvuq60ot8e0cucGg4fUt+nP7usXW9qC2ZHVMsFhJtRN8Bsy2Jkh1R54yVNGY+CBoKyZtMv6I8e
 k1otMTwWzItQ==
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="467049194"
Received: from hmulerox-mobl.amr.corp.intel.com (HELO pflykt-mobl1.ger.corp.intel.com) ([10.252.5.196])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 04:58:04 -0700
Received: by pflykt-mobl1.ger.corp.intel.com (Postfix, from userid 1100)
        id 03CB43200CF; Fri, 23 Oct 2020 14:58:01 +0300 (EEST)
From:   Patrik Flykt <patrik.flykt@linux.intel.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de, dmurphy@ti.com,
        sriram.dash@samsung.com, jarkko.nikula@intel.com
Subject: [PATCH v2 1/1] NET: mcan: Move runtime PM enable/disable to m_can_platform
Date:   Fri, 23 Oct 2020 14:58:00 +0300
Message-Id: <20201023115800.46538-2-patrik.flykt@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023115800.46538-1-patrik.flykt@linux.intel.com>
References: <20201023115800.46538-1-patrik.flykt@linux.intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - PL 281, 00181 Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is a preparatory patch for upcoming PCI based M_CAN devices.
The current PM implementation would cause PCI based drivers to
enable PM twice, once when the PCI device is added and a second
time in m_can_class_register(). This will cause 'Unbalanced
pm_runtime_enable!' to be logged, and is a situation that should
be avoided.

Therefore, in anticipation of PCI devices, move PM enabling out
from M_CAN class registration to its only user, the
m_can_platform driver.

Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
---
v2: Rebased on mkl/linux-can.git 9146843b11b6

 drivers/net/can/m_can/m_can.c          | 9 ++-------
 drivers/net/can/m_can/m_can_platform.c | 7 ++++++-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e1d8d1c8ab7d..f81a0761ddad 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1803,10 +1803,9 @@ int m_can_class_register(struct m_can_classdev *m_can_dev)
 	int ret;
 
 	if (m_can_dev->pm_clock_support) {
-		pm_runtime_enable(m_can_dev->dev);
 		ret = m_can_clk_start(m_can_dev);
 		if (ret)
-			goto pm_runtime_fail;
+			goto clk_fail;
 	}
 
 	ret = m_can_dev_setup(m_can_dev);
@@ -1832,12 +1831,8 @@ int m_can_class_register(struct m_can_classdev *m_can_dev)
 	 */
 clk_disable:
 	m_can_clk_stop(m_can_dev);
-pm_runtime_fail:
-	if (ret) {
-		if (m_can_dev->pm_clock_support)
-			pm_runtime_disable(m_can_dev->dev);
-	}
 
+clk_fail:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(m_can_class_register);
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index b5b7b77909d3..87264e0f4e94 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -134,7 +134,12 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	m_can_init_ram(mcan_class);
 
-	return m_can_class_register(mcan_class);
+	pm_runtime_enable(mcan_class->dev);
+	ret = m_can_class_register(mcan_class);
+	if (ret)
+		pm_runtime_disable(mcan_class->dev);
+
+	return ret;
 
 probe_fail:
 	m_can_class_free_dev(mcan_class->net);
-- 
2.28.0

