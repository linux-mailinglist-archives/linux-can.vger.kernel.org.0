Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2620437297D
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 13:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhEDLVz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 07:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhEDLVy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 07:21:54 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F7FC061763
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 04:20:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l13so7356970wru.11
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 04:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nI2X005DC7GVhR87JU8m+j5MhrlPNwWdtQ1VO2NPoD0=;
        b=jx1FlhHI4JpQrXuJ5CWv8MemY9+0NnWmg0aL/HyKyu4ZmYCe8zaDHviRVmvCRcwfgk
         QjMcuV4tbV7Fri8BBmWXffsUFxpUde9g4HdReyjnHf0fHbZRGZRfWv/68rlpnCJb6uNL
         gtpoVlTGK5qTGsQ8EWFVTdLJmIOZbgc52X9KDMBNP0cCEueePABsmQvjbSh5q505/qVR
         PFb5lJKYQ/Wa85fNSymjNA4oXYCD9YwVmfJNc177IW4T6/O5eFkl83tm9lP/x0t8xyWO
         iLtQiMfaBLLUY+6BcullzYkSdRLLd7UG/nLagEva/1/mvjvnGXrBFE3luyQiPGr91N6d
         lhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nI2X005DC7GVhR87JU8m+j5MhrlPNwWdtQ1VO2NPoD0=;
        b=rK8X+aD/9kwjvYYLvFoxU//xZmnHzN4bTl/EUz8Nq7y1XlNraMgpU7Wy3HGHPl0q6x
         HQ3R5Uyolcp3NF43tPNQLLp68g8eGPydvZcB0dCpCZnhhp4nnBAQkyyfmI2ubQ9FGqLC
         3Xek9Y1sjQu9aoY6nwJS/zz7hYUq9BsDhtn8/8nNBS1g4pWCWWWcVkqNeuyM187AN4YX
         ytVo4Qi/tg9Z6OB+hQRTkdYzcAWjzLtY7zJs3aHPAZb6iJ3PFgMenrAytU+fAn+hNT+2
         TslQkfcIG52VhsNChaHj+M7F1FNv/1MKP5JVKXSjUj1PE/iKichtBZ8ywIvD2VGTeFVz
         nmKQ==
X-Gm-Message-State: AOAM533vp4/ky5Tsx+G7wC9i5iG1pGAi2ZAV9I7UK9Pq3CYEQtvkU3MC
        HRkuqmQTy4jiZOrdktSylD/Z6SjzfkaqaKrQ
X-Google-Smtp-Source: ABdhPJzGkzKRxLmjjPtR6PkOsG93Ia/5MhWvLe3DxoIqsxTjWePLu3HBwPTp/S+ItwYEBhYmev9Q5A==
X-Received: by 2002:a5d:4521:: with SMTP id j1mr24645970wra.116.1620127255530;
        Tue, 04 May 2021 04:20:55 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id a21sm2222022wmj.34.2021.05.04.04.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:20:55 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Pankaj Sharma <pankj.sharma@samsung.com>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH 2/4] can: m_can: clean up CCCR reg defs, order by revs
Date:   Tue,  4 May 2021 12:20:33 +0100
Message-Id: <20210504112035.336424-3-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504112035.336424-1-torin@maxiluxsystems.com>
References: <20210504112035.336424-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Ensures that the different CCCR regmasks for m_can revs 3.0.x, 3.1.x,
3.2.x and 3.3.x are clearly distinguishable. Removes incorrect
CCCR_CANFD define. Adds bit fields UTSU and WMM for rev 3.3.x, for
completeness.
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

