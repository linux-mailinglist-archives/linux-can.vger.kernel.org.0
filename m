Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130D43729AB
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 13:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhEDLu3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 07:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhEDLu2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 07:50:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89BFC06174A
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 04:49:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x7so9062211wrw.10
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 04:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=19Wt47674v2F97LCOlvx92LIwZ/rYDVw9Y2aQUxJDUA=;
        b=BLze5l0CZlTBvOWJi5jy2oPTlsXzJqOi7kT2odsTM9L40OmyuTrPAD3Y1VWsCwDX0f
         lRBTxvGH7MBTBgTAmyfs76ZzuzlV2LRtW1MkIeFguhZP/0F2gi6OC7D7wX4FvBi3vOmw
         HwgWtCAj9Nbfsy4Pd8if/FAm4aZJl8hmnqea3oK0rysnZsXw8SokWfpDAZq+CaNwr/x6
         EK0WiqiVBlf5bltwHdBOq0TGsfwEy0Ld8ks4APHwic4Wy9REkgDRLDqALXa6adpXvxsl
         mU57GTcPpVAzYspkzFZtpA7AKxFAhh0I0LAqswNCKz+ZzXX8UvU+peEUuoYLghoWYrua
         WxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19Wt47674v2F97LCOlvx92LIwZ/rYDVw9Y2aQUxJDUA=;
        b=fpxVpjKoYBwKFWQ0zOz/y/4FajuVV1hitpvxHv8J7jk7Wu6n6PRZSmnLYog4WFIVAp
         rbZE/BscmKxSw8825vJ0uf74bgcwAtJnYvni0aibdRFDeoqqGm43uXF0aMkvN/df7vY+
         clLY8vymnE+kZDPS/bwB/zUjGZknJ8DJdaPi2wLInLPkKB3zm/DxDZrJMwga60yl2BB5
         LRvh/yU7eA4ZGVP08+Wvaf+S5k//PPWkoXAmZMSugl7ZirPFxeuH+ctVUfgAchlXaPpi
         Ugd1/ju60SBA+SoiSPKXFuZOLHAkc24rR60fNrdzG2Hrgnqlmuqq2aY4PNgAXfz7Ln8n
         awJA==
X-Gm-Message-State: AOAM530iHssG3rAfAU0JgsKc8cc9ZMZeWNVYY2hwT0avKLN/FUHOhe1L
        JAKXSBAprdYE3LfMCXINLwllx3WYJcYOidvs
X-Google-Smtp-Source: ABdhPJzTDZw8ktKV6SVht7lmKQvplfKVOnNePlFyRdY3sbRqvYTcSNXZtPnj/9+Xb2d673Nt4iLEvA==
X-Received: by 2002:adf:f74a:: with SMTP id z10mr31748016wrp.406.1620128972269;
        Tue, 04 May 2021 04:49:32 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id n10sm16181972wrw.37.2021.05.04.04.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:49:32 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH 2/4] can: m_can: clean up CCCR reg defs, order by revs
Date:   Tue,  4 May 2021 12:48:59 +0100
Message-Id: <20210504114900.351170-3-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504114900.351170-1-torin@maxiluxsystems.com>
References: <20210504114900.351170-1-torin@maxiluxsystems.com>
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
index f402a250e24f..c85f064de4a0 100644
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

