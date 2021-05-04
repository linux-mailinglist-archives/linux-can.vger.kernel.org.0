Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5F7372A67
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 14:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhEDMwa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 08:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhEDMw3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 08:52:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A73C061761
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 05:51:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d4so9288995wru.7
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 05:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMp5MW8kgXFtZQ9cZe3gWO9M1cwNwl0WR2nm/2Ke7ig=;
        b=riA1qpy10stjiwqRVzEiSLLK5RhoQkU/0lkvbAiRxEpSaw+tdpM++Y2SaEBHHqEIxD
         M5Aam/uliTBQuJGUGAT4L253Uufiyg9E0QMmCSKBnZ3eFiMuIgj5RtAQayhuyInEsG6x
         PLs9nEQiL8y1yD9JGWlbFGHJFqi/6tMG1nvMLQ8uI+TkHzUgV2FOMouvF2Qp5bp62pid
         WyfiTED91ohD1O92nJw5v2YP4CiwrF3irdCY7GOMqmKeY3NQIEEVpfYnXnos91mKpg+C
         WMuEFS3vmqA5b3SPAqs1+E/ygBm4H5MELa87E49k1Qs2aNkGWJg9CE5NYidUaX2BpmJU
         5vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMp5MW8kgXFtZQ9cZe3gWO9M1cwNwl0WR2nm/2Ke7ig=;
        b=TdGt6gRuigP5b7Kwp7jmdLJQ/luUQVIDvg3Ed8JbCWC5E04c5SJyT+YNC+MEegxFKH
         q3ZuGgemokQuL6ywqBqHDdPjdKFTzbltdWIh7Z7AGPaseJ2/auRCivoX/fWak9BuvzlE
         7oYnDiN4sOcZowQ2jv+P4IFCZepzjxiUF2nQbaNleZBp6mGtspFFEibRQuMXJCY8MNy/
         FAYMRm55h3fQl7CtdTiZrcAz46q3UfgKKGCrwZ+SndN0NJo213at5ipGKRCoP4igmlcY
         7LaEV9Rh8z8YfuR2znNotUlRvju6jOaanjxFZDZjyVffrfpjhplmPVW28Au/aQhyVixI
         80+g==
X-Gm-Message-State: AOAM532AIHBrcV5QSPcG/1ZYVG7xh3ME40BN+hTgInamKO7e4yCjoRUA
        /MKB2d9pVpbpWxy89ApdKua3sZlBUDyw9GR/
X-Google-Smtp-Source: ABdhPJzyi/TPTA8SVkQB6yBQaIUKgmMXJx/sQdST0F9uz0yHcAz2DjENnHikgVAxjRMPEl8knNWUTA==
X-Received: by 2002:adf:ed4b:: with SMTP id u11mr31912958wro.293.1620132692963;
        Tue, 04 May 2021 05:51:32 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id n5sm11679527wrx.31.2021.05.04.05.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 05:51:32 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH v2 3/4] can: m_can: make TXESC, RXESC config more explicit
Date:   Tue,  4 May 2021 13:51:22 +0100
Message-Id: <20210504125123.500553-4-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504125123.500553-1-torin@maxiluxsystems.com>
References: <20210504125123.500553-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Introduce masks for the three RXESC fields (RBDS, F1DS, F0DS) and the
one TXESC field (TBDS). Update m_can_chip_config() to explicitly set all
four fields to the 64-byte option (0x7) (and these defs are renamed to
be more concise).

This is an improvement in maintainability, and also makes it easier to
implement more flexible configuration of the M_CAN buffers in the
future.

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/m_can.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 458e47978c64..14b47850e1e3 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -235,8 +235,10 @@ enum m_can_reg {
 #define RXFS_FFL_MASK	GENMASK(6, 0)
 
 /* Rx Buffer / FIFO Element Size Configuration (RXESC) */
-#define M_CAN_RXESC_8BYTES	0x0
-#define M_CAN_RXESC_64BYTES	0x777
+#define RXESC_RBDS_MASK		GENMASK(10, 8)
+#define RXESC_F1DS_MASK		GENMASK(6, 4)
+#define RXESC_F0DS_MASK		GENMASK(2, 0)
+#define RXESC_64B		0x7
 
 /* Tx Buffer Configuration (TXBC) */
 #define TXBC_TFQS_MASK		GENMASK(29, 24)
@@ -249,8 +251,8 @@ enum m_can_reg {
 #define TXFQS_TFFL_MASK		GENMASK(5, 0)
 
 /* Tx Buffer Element Size Configuration(TXESC) */
-#define TXESC_TBDS_8BYTES	0x0
-#define TXESC_TBDS_64BYTES	0x7
+#define TXESC_TBDS_MASK		GENMASK(2, 0)
+#define TXESC_TBDS_64B		0x7
 
 /* Tx Event FIFO Configuration (TXEFC) */
 #define TXEFC_EFS_MASK		GENMASK(21, 16)
@@ -1191,7 +1193,10 @@ static void m_can_chip_config(struct net_device *dev)
 	m_can_config_endisable(cdev, true);
 
 	/* RX Buffer/FIFO Element Size 64 bytes data field */
-	m_can_write(cdev, M_CAN_RXESC, M_CAN_RXESC_64BYTES);
+	m_can_write(cdev, M_CAN_RXESC,
+		    FIELD_PREP(RXESC_RBDS_MASK, RXESC_64B) |
+		    FIELD_PREP(RXESC_F1DS_MASK, RXESC_64B) |
+		    FIELD_PREP(RXESC_F0DS_MASK, RXESC_64B));
 
 	/* Accept Non-matching Frames Into FIFO 0 */
 	m_can_write(cdev, M_CAN_GFC, 0x0);
@@ -1209,7 +1214,8 @@ static void m_can_chip_config(struct net_device *dev)
 	}
 
 	/* support 64 bytes payload */
-	m_can_write(cdev, M_CAN_TXESC, TXESC_TBDS_64BYTES);
+	m_can_write(cdev, M_CAN_TXESC,
+		    FIELD_PREP(TXESC_TBDS_MASK, TXESC_TBDS_64B));
 
 	/* TX Event FIFO */
 	if (cdev->version == 30) {
-- 
2.30.2

