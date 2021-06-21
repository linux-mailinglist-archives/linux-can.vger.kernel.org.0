Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF5F3AF572
	for <lists+linux-can@lfdr.de>; Mon, 21 Jun 2021 20:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhFUSte (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Jun 2021 14:49:34 -0400
Received: from mail.kernel-space.org ([195.201.34.187]:48192 "EHLO
        mail.kernel-space.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhFUSte (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Jun 2021 14:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1624301235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hO6lwUo8KdLyOuC1N3tXTu8RjL9dMEFc9jtud9ss8lk=;
        b=JkD2xaXnkfm7pQ67FAxmzd5QDKKEp93coJDMsPni/vswfd4+fjEJlpnmWfv2Wh49ZTPBvy
        /QNmGqs3nU/dERLpnD9BqZGl0GX0mLfm+UKZni5W/9F19YlskOOWLW27d39mEgdT6weOsJ
        oM1x+U9XMEL/hGMxTyAdyZ6KyE0GkAc=
Received: from dfj.bfc.timesys.com (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id 6c23e2f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 21 Jun 2021 18:47:15 +0000 (UTC)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     gerg@linux-m68k.org, wg@grandegger.com, mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v3 1/5] can: flexcan: add platform data header
Date:   Mon, 21 Jun 2021 20:46:11 +0200
Message-Id: <20210621184615.3345846-1-angelo@kernel-space.org>
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
---
 include/linux/can/platform/flexcan.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 include/linux/can/platform/flexcan.h

diff --git a/include/linux/can/platform/flexcan.h b/include/linux/can/platform/flexcan.h
new file mode 100644
index 000000000000..ab4628ce701b
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
+struct mcf_flexcan_platform_data {
+	u32 clock_frequency;
+	u8 clk_src;
+};
+
+#define FLEXCAN_MCF5411X_MB_CNT_MCF	16
+
+#endif /* _PLAT_FLEXCAN_H */
-- 
2.31.1

