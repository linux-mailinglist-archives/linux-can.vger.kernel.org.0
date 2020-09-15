Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BF326B7D5
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 02:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgIPAa3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Sep 2020 20:30:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:7058 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIONru (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 15 Sep 2020 09:47:50 -0400
IronPort-SDR: v1ti98fz4ilS+KGCszSB5lMGG3+z6nC4+JcOKmbLiclRMo3aRNQcxXen5ND0bk2cmR6AvD56dy
 BkQguw83qJNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="158542443"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="158542443"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 06:47:22 -0700
IronPort-SDR: Mem8204AS7xE1XzLYO4y9ZGFN/4emgntua355uBosYK+zK/iA6utqT2Hsgn1j3LqbPLO2yIQFG
 SITW53334NrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="409205615"
Received: from unknown (HELO mylly.fi.intel.com.) ([10.237.72.56])
  by fmsmga001.fm.intel.com with ESMTP; 15 Sep 2020 06:47:20 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-can@vger.kernel.org
Cc:     Dan Murphy <dmurphy@ti.com>, Sriram Dash <sriram.dash@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Patrik Flykt <patrik.flykt@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] can: m_can: Process interrupt only when not runtime suspended
Date:   Tue, 15 Sep 2020 16:47:15 +0300
Message-Id: <20200915134715.696303-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Avoid processing bogus interrupt statuses when the HW is runtime
suspended and the M_CAN_IR register read may get all bits 1's. Handler
can be called if the interrupt request is shared with other peripherals
or at the end of free_irq().

Therefore check the runtime suspended status before processing.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/net/can/m_can/m_can.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 02c5795b7393..81b32b03e246 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -956,6 +956,8 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	struct net_device_stats *stats = &dev->stats;
 	u32 ir;
 
+	if (pm_runtime_suspended(cdev->dev))
+		return IRQ_NONE;
 	ir = m_can_read(cdev, M_CAN_IR);
 	if (!ir)
 		return IRQ_NONE;
-- 
2.28.0

