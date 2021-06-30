Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F47C3B8ABF
	for <lists+linux-can@lfdr.de>; Thu,  1 Jul 2021 01:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhF3XEG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 30 Jun 2021 19:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhF3XEF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Jun 2021 19:04:05 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D94EC061756;
        Wed, 30 Jun 2021 16:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1625094091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BzTpWjhuglx3ZJpmsnSuWElG8U0BoMwOehLzb1L4ML0=;
        b=tOhgwCBXoHftEsG9xXxE3tZCU8lrbvyHqucpb4iEu3OL5z5DkRj/OTwE3PuHTLCwt9ifsR
        IeMlw04Za0amgnmrJqEwuqbrBjKP87/tZhfyagmPyP+7H0KRsKFVHqFWVLhbuBwTnJ11lR
        PY+FH76IlpLNQ5n/gZRsnZOh/Qf9MlA=
Received: from dfj.bfc.timesys.com (host-87-4-238-130.retail.telecomitalia.it [87.4.238.130])
        by ziongate (OpenSMTPD) with ESMTPSA id 03095eb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 30 Jun 2021 23:01:31 +0000 (UTC)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     gerg@linux-m68k.org, wg@grandegger.com, mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v4 1/5] can: flexcan: add platform data header
Date:   Thu,  1 Jul 2021 01:00:12 +0200
Message-Id: <20210630230016.4099050-1-angelo@kernel-space.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add platform data header for flexcan.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
Changes for v2:
- move header file in more proper location
- remove irq defines
- change variable types to match driver types
Changes for v3:
- rename to more generic flexcan.h
- reorder struct fields to avoid paddings
- remove unused big_endian
Changes for v4:
- rename structure to flexcan_platform_data
---
 include/linux/can/platform/flexcan.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 include/linux/can/platform/flexcan.h

diff --git a/include/linux/can/platform/flexcan.h b/include/linux/can/platform/flexcan.h
new file mode 100644
index 000000000000..533dbe39c659
--- /dev/null
+++ b/include/linux/can/platform/flexcan.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021  Angelo Dureghello <angelo@kernel-space.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _PLAT_FLEXCAN_H
+#define _PLAT_FLEXCAN_H
+
+struct flexcan_platform_data {
+	u32 clock_frequency;
+	u8 clk_src;
+};
+
+#define FLEXCAN_MCF5411X_MB_CNT_MCF	16
+
+#endif /* _PLAT_FLEXCAN_H */
-- 
2.31.1

