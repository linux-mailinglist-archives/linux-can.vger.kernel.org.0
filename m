Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C31F372A66
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 14:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhEDMw3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 08:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhEDMw2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 08:52:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F66DC06174A
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 05:51:33 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id s82so5327382wmf.3
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 05:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yBSJU+N1Bb8b5Khowbd632nl1St9szgfNaa1+p/F7eY=;
        b=j4oEBud0wlB5K4nVd06MbvEG55g6F2iMu6j5byqL+ZLs2Dp8izD8wlb9iQCw3caF77
         SG1TX/3RNx9ZZlpzA4Pu8gaGbLFAZSEMHr2yOLxGkELi+B+adNb5AjCVZqvOHs0lJdDV
         Kwxb/xMyTaBxdEviadrEwVBMxAxJe5AcEjLKLd762zh72+E+YFFuF2FkFczEvbQdpDId
         9tBuBjEK+tdMkUYbsvjGJF4oazigadm87EnmBCE/U4jX0a/0uXRPePlCqC/vpnlNuTUi
         4ocTLr6jIbhjJHwokTN/TUuNe5RUzxlnacbbe30+/ZbxWbxLFSPLYbPc85YOqtsk3E2J
         mkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBSJU+N1Bb8b5Khowbd632nl1St9szgfNaa1+p/F7eY=;
        b=F5pLkUTT3Kv4OcK51367+wdMkTTf26QJ9sl6MN5WkA1+beeCPog5YcOM7hgNVKI4ch
         6t/dYtTRP5hM59mVbKEVPiMpX4Xy1+7iuI6TfJCWiCW9ZyaLWK2fcTCUxPKccLgyW0Mz
         vDUBIqQq/yvOe87kAG3eTJ3nIyO2e5QTO5oDQ3LAYTh1ZdDwf76dN6EcCheNCB9QJ3Hh
         kSzWLQm1yU2nfLEFJajLX5SfytvE//EUoBYBMxn4IWAaVCuLUkX/C9yyK8/atrchr9g4
         lFjnLhFKA8JKJ18Q3IHiIaSOUEzST6v2plQmXznUeJdsKH5Mm+cSeDfuy1iqbFrSRU1k
         Y/jw==
X-Gm-Message-State: AOAM532ox6bi5LTf20ShWC2+mhzwA4SQ9qv5h7CBeVugBiFgPG3dBwYK
        rJ1TpaDT6r3DQFtyKKY5YbncYtCgJ1wxWCvA
X-Google-Smtp-Source: ABdhPJy+rOhjY6Ib9PR5iRdk9kaYBceR9kaPjYxakpM8OZIKgKR6UHkWNKP12GRPKKl2V4BvxbET8g==
X-Received: by 2002:a7b:c348:: with SMTP id l8mr3953566wmj.152.1620132692154;
        Tue, 04 May 2021 05:51:32 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id n5sm11679527wrx.31.2021.05.04.05.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 05:51:31 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH v2 2/4] can: m_can: clean up CCCR reg defs, order by revs
Date:   Tue,  4 May 2021 13:51:21 +0100
Message-Id: <20210504125123.500553-3-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504125123.500553-1-torin@maxiluxsystems.com>
References: <20210504125123.500553-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Ensures that the different CCCR regmasks for m_can revs 3.0.x, 3.1.x,
3.2.x and 3.3.x are clearly distinguishable. Removes incorrect
CCCR_CANFD define. Adds bit fields UTSU and WMM for rev 3.3.x, for
completeness.

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/m_can.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 60f361a5f95a..458e47978c64 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -102,14 +102,6 @@ enum m_can_reg {
 #define TEST_LBCK		BIT(4)
 
 /* CC Control Register(CCCR) */
-#define CCCR_CMR_MASK		GENMASK(11, 10)
-#define CCCR_CMR_CANFD		0x1
-#define CCCR_CMR_CANFD_BRS	0x2
-#define CCCR_CMR_CAN		0x3
-#define CCCR_CME_MASK		GENMASK(9, 8)
-#define CCCR_CME_CAN		0
-#define CCCR_CME_CANFD		0x1
-#define CCCR_CME_CANFD_BRS	0x2
 #define CCCR_TXP		BIT(14)
 #define CCCR_TEST		BIT(7)
 #define CCCR_DAR		BIT(6)
@@ -119,14 +111,25 @@ enum m_can_reg {
 #define CCCR_ASM		BIT(2)
 #define CCCR_CCE		BIT(1)
 #define CCCR_INIT		BIT(0)
-#define CCCR_CANFD		BIT(4)
+/* for version 3.0.x */
+#define CCCR_CMR_MASK		GENMASK(11, 10)
+#define CCCR_CMR_CANFD		0x1
+#define CCCR_CMR_CANFD_BRS	0x2
+#define CCCR_CMR_CAN		0x3
+#define CCCR_CME_MASK		GENMASK(9, 8)
+#define CCCR_CME_CAN		0
+#define CCCR_CME_CANFD		0x1
+#define CCCR_CME_CANFD_BRS	0x2
 /* for version >=3.1.x */
 #define CCCR_EFBI		BIT(13)
 #define CCCR_PXHD		BIT(12)
 #define CCCR_BRSE		BIT(9)
 #define CCCR_FDOE		BIT(8)
-/* only for version >=3.2.x */
+/* for version >=3.2.x */
 #define CCCR_NISO		BIT(15)
+/* for version >=3.3.x */
+#define CCCR_WMM		BIT(11)
+#define CCCR_UTSU		BIT(10)
 
 /* Nominal Bit Timing & Prescaler Register (NBTP) */
 #define NBTP_NSJW_MASK		GENMASK(31, 25)
-- 
2.30.2

