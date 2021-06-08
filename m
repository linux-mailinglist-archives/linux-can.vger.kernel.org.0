Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4048D3A053D
	for <lists+linux-can@lfdr.de>; Tue,  8 Jun 2021 22:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhFHUsb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Jun 2021 16:48:31 -0400
Received: from mail.kernel-space.org ([195.201.34.187]:37354 "EHLO
        mail.kernel-space.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFHUsb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Jun 2021 16:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1623185192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b0wt4MdYRnXoVJfyA4gpUQHt8ddNOiAimYy1woA8xBY=;
        b=a0JHbwrP/aKzHGeTO2A3jNL+lZ3D0Wt5Tc1sl+m+1vDkfHukX8gdJJtZ8E3wDt4cmfsyO7
        Zs97Z2Bh+vlveVJKEgBxFaMPPJlFaNklWkKWoZ3HlEGW6cPzWCOkjgWD0vkiFvs7QdzaUE
        DpWsId/UbZ2MG9fuJSicRYzWWyCAT5Y=
Received: from dfj.1.1.1.1 (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id 08454881 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Jun 2021 20:46:32 +0000 (UTC)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     gerg@linux-m68k.org, wg@grandegger.com, mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH 1/5] can: flexcan: add platform data for ColdFire
Date:   Tue,  8 Jun 2021 22:45:38 +0200
Message-Id: <20210608204542.983925-1-angelo@kernel-space.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add platform data object for ColdFire architecture.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
 include/linux/platform_data/flexcan-mcf.h | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 include/linux/platform_data/flexcan-mcf.h

diff --git a/include/linux/platform_data/flexcan-mcf.h b/include/linux/platform_data/flexcan-mcf.h
new file mode 100644
index 000000000000..71fe1a9df084
--- /dev/null
+++ b/include/linux/platform_data/flexcan-mcf.h
@@ -0,0 +1,27 @@
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
+	int stop_mode;
+	int clk_src;
+	int clock_frequency;
+	bool big_endian;
+};
+
+#endif /* _PLAT_FLEXCAN_MCF_H */
-- 
2.31.1

