Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E24E3B9E84
	for <lists+linux-can@lfdr.de>; Fri,  2 Jul 2021 11:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhGBJwd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Jul 2021 05:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhGBJwd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Jul 2021 05:52:33 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34AEC061762;
        Fri,  2 Jul 2021 02:50:00 -0700 (PDT)
Received: from ziongate (localhost [127.0.0.1])
        by ziongate (OpenSMTPD) with ESMTP id 8e3ef6a9;
        Fri, 2 Jul 2021 09:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=from:to
        :cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=default; bh=gw206N044QA5bwE72D4MAD
        5/AT0=; b=bB0Y7b9K3rrHIk2ktenV+OOodkSupvKWDvt8PZdBEB+pZmGX9myURR
        kelCktf5taulWg8ZxVRgAFBdnMnyhYl+YSy7pGeORr24S3NdOar6za897YLQDJkw
        iCghnTETyijrFTvIuB49r1qu8OkSXfEsgYcHjeO47z+xWbglN/rPg=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=from:to
        :cc:subject:date:message-id:mime-version
        :content-transfer-encoding; q=dns; s=default; b=E8SKI4uzdbMKTq4U
        Xxb0ept4bKIn4wGwkPgc97mItWWdY9ZX45BlL7AOTYBfgVZkOVTg0Q+fZhXR1GsW
        we+wLWtKUkMlMyh4ohgT0/KUW4AVz/3/mNmwz79F9VOzwDy4CWA35b3dlp5dxKIT
        MEhKLxC02CymAO3PRyvh+m86Q9Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1625219398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=THidYCcboW/8Wcyu8f9u8cyrKuopXRA9L4bD1zrt4z0=;
        b=j2q+AItAD228bVnQK1tZEq4qEde/QJhSgF1zWl90eVb1cfjPXlbkefExNQDSCO9jmTeFNg
        tc/cdaV/20zbrkH29Z6fKLPyoDUKqwZEG8Qqvo3MA1w4WNfPTcl8qLB2HBwiucz7o54DEN
        NGfL0mRhr8hjG8Fz0XEIF1r25lq5PkU=
Received: from dfj.bfc.timesys.com (<unknown> [95.236.232.230])
        by ziongate (OpenSMTPD) with ESMTPSA id 4db83698 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 2 Jul 2021 09:49:58 +0000 (UTC)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     gerg@linux-m68k.org, wg@grandegger.com, mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v5 1/5] can: flexcan: add platform data header
Date:   Fri,  2 Jul 2021 11:48:37 +0200
Message-Id: <20210702094841.327679-1-angelo@kernel-space.org>
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
Changes for v5:
none
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

