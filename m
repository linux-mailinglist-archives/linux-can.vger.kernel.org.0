Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0964F3AA751
	for <lists+linux-can@lfdr.de>; Thu, 17 Jun 2021 01:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhFPXTz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 19:19:55 -0400
Received: from mail.kernel-space.org ([195.201.34.187]:38042 "EHLO
        mail.kernel-space.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbhFPXTz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 19:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1623885464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GMzM6rne3aqNDELEFFWbt27YcLcmG9IGt3KJNXfYwgA=;
        b=e4mc4D/PVvsEDSWw1pJbtwFkPFRB9t9k3xdovlK76vkbdDoC5CvBY9mPrw+Qplq11i7lo+
        Brj35CwmtsJAiFehFmiz+UkNEd069fRgU7YChgzn10GS9Fo86xAZYjYU5ysCsUWoFonwpf
        +P154vTqNWKBoRMVYFH2E45iJ06h/jU=
Received: from dfj.1.1.1.1 (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id 34ec42f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Jun 2021 23:17:44 +0000 (UTC)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     gerg@linux-m68k.org, wg@grandegger.com, mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v2 1/5] can: flexcan: add platform data for ColdFire
Date:   Thu, 17 Jun 2021 01:16:48 +0200
Message-Id: <20210616231652.738027-1-angelo@kernel-space.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add platform data object for ColdFire architecture.

---
Changes for v2:
- move header file in more proper location
- remove irq defines
- change variable types to match driver types

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
 include/linux/can/platform/mcf5441x.h | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 include/linux/can/platform/mcf5441x.h

diff --git a/include/linux/can/platform/mcf5441x.h b/include/linux/can/platform/mcf5441x.h
new file mode 100644
index 000000000000..6866f0f60caf
--- /dev/null
+++ b/include/linux/can/platform/mcf5441x.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Flexcan options for ColdFire family
+ *
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
+#ifndef _PLAT_FLEXCAN_MCF_H
+#define _PLAT_FLEXCAN_MCF_H
+
+struct mcf_flexcan_platform_data {
+	u8 clk_src;
+	u32 clock_frequency;
+	bool big_endian;
+};
+
+#define FLEXCAN_MCF5411X_MB_CNT_MCF	16
+
+#endif /* _PLAT_FLEXCAN_MCF_H */
-- 
2.31.1

