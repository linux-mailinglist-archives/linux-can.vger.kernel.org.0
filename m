Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1B937297F
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 13:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhEDLVz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 07:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhEDLVy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 07:21:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C3CC061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 04:20:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j3-20020a05600c4843b02901484662c4ebso1047605wmo.0
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 04:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZAIrBNAGdubIxImzH4bJ+DfukA5xwd1feOLPy+4+v0I=;
        b=ZY9NSzmJauM/vMplZTMZH5bmMG9V+WZsoTbAc3RREKKp6OENwt5ZCReVMcxCw0OFeG
         n+/QDoKCijo0CkqF4irAEVZH8XBUGlkHIyZ2irDw2pY5c8KM8RoTfepYNSFViBmpUpTB
         diImlrf7UbXKUiWvybKSQYGJWINmVmiULlyIUxhWG3RLmrdZSalYTYXEDyANwhF46Nrl
         IuJRTcF+TiNE6TEwzP4zXiLtuJg8Nbwg2G1ZAnYL4WZQ547CoXvcdFKvOkC8P34La7F/
         GvcUnf4jCepYV+11QiTVykvnrEDm4hu0l3V87l6eCTYfHWicAeM4r5Xr74iD19N+pc4i
         wuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZAIrBNAGdubIxImzH4bJ+DfukA5xwd1feOLPy+4+v0I=;
        b=DJbhkm8HKVQaZcdCsXF4i8fpFf3fT3IXQrfhYjcsgOb5v6eebcotXYoCIxT68kt7kD
         LfcBogtCa2xAi31JCg9IHXxMl+xKktf62e7zJHVcwDtwECq537tZYi9v9EOdTMDFckDw
         opb6X16oWl5LgMROiVww3We0PR+g3LIis9IlVNU66OQryFsReWNHJo70FDlLomxW1eiJ
         pljmFv/o76dQewv2wgywMFuK4I6FLe96y+BZ8RhVwmiJXh80/uDx6OmVSckooNkkuufL
         uD9iUu36Fjl6M5fQSPceGFaSjX8ghQKqxUWlNhzclNaw5pu2bhrtuLg6gfxcUysZgkln
         5uHA==
X-Gm-Message-State: AOAM532meOgC7CNQg9LZh+DshiMpGIG2kRJRwX9IxhTRVslL2HE2g8TV
        njlZ/d8sinwkjOsWkdvaeUeyB8lrFzE+k6EN
X-Google-Smtp-Source: ABdhPJzzTyAxjCYHOEKogUJWj06nGuDRz7QN8kDxBWohwz3nXm75Qen6amF80cgH9HNfaDDikj40dw==
X-Received: by 2002:a1c:f614:: with SMTP id w20mr26281970wmc.70.1620127258350;
        Tue, 04 May 2021 04:20:58 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id a21sm2222022wmj.34.2021.05.04.04.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:20:57 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Pankaj Sharma <pankj.sharma@samsung.com>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH 4/4] can: m_can: fix whitespace in a few comments
Date:   Tue,  4 May 2021 12:20:35 +0100
Message-Id: <20210504112035.336424-5-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504112035.336424-1-torin@maxiluxsystems.com>
References: <20210504112035.336424-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fixes whitespace in comments titling sections of register masks.
---
 drivers/net/can/m_can/m_can.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e3b15b74fdc9..9d3c2116fd53 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -101,7 +101,7 @@ enum m_can_reg {
 /* Test Register (TEST) */
 #define TEST_LBCK		BIT(4)
 
-/* CC Control Register(CCCR) */
+/* CC Control Register (CCCR) */
 #define CCCR_TXP		BIT(14)
 #define CCCR_TEST		BIT(7)
 #define CCCR_DAR		BIT(6)
@@ -147,18 +147,18 @@ enum m_can_reg {
 /* Timestamp Counter Value Register (TSCV) */
 #define TSCV_TSC_MASK		GENMASK(15, 0)
 
-/* Error Counter Register(ECR) */
+/* Error Counter Register (ECR) */
 #define ECR_RP			BIT(15)
 #define ECR_REC_MASK		GENMASK(14, 8)
 #define ECR_TEC_MASK		GENMASK(7, 0)
 
-/* Protocol Status Register(PSR) */
+/* Protocol Status Register (PSR) */
 #define PSR_BO		BIT(7)
 #define PSR_EW		BIT(6)
 #define PSR_EP		BIT(5)
 #define PSR_LEC_MASK	GENMASK(2, 0)
 
-/* Interrupt Register(IR) */
+/* Interrupt Register (IR) */
 #define IR_ALL_INT	0xffffffff
 
 /* Renamed bits for versions > 3.1.x */
@@ -250,7 +250,7 @@ enum m_can_reg {
 #define TXFQS_TFGI_MASK		GENMASK(12, 8)
 #define TXFQS_TFFL_MASK		GENMASK(5, 0)
 
-/* Tx Buffer Element Size Configuration(TXESC) */
+/* Tx Buffer Element Size Configuration (TXESC) */
 #define TXESC_TBDS_MASK		GENMASK(2, 0)
 #define TXESC_TBDS_64B		0x7
 
-- 
2.30.2

