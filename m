Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB9C3729AD
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 13:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhEDLua (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 07:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhEDLua (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 07:50:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A3DC061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 04:49:35 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m9so9082170wrx.3
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 04:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+tCQ7Q+DlWb9L3xiHY3WIvsh8EpUIjqTwd7hAA7MXs=;
        b=Ce8SO67uH4LKewpv9UgbgCQDyJrwGRIfQogONu/j0QiaYB0N/qsY/KKZBprzXfr5UC
         cwHfccxzeirGXh5sdSZ4vmeQYq7JXAvU+6GR1j5ap1M3fkeYGILTcXLB0REhsDcHC3i9
         OTv+TORLHOR3bc6VBU5H7Vo2fvyS3xKx+C6MhUMt2dIkL1bWibxaYQK+kEANC8qhjynl
         zMKmagAbmY4ZvUdef0ZuHo3Ip6JVGlTuT0+zuzPB2nTQjGAwFmd5jE34/wJ9/LkoAHSt
         ycavcoDJ26F6XCKjjy9lxj+OxeciA+EJEEnp8fSoYGYlIwAj1pC1EUlY8o7NQwHSl2Ez
         6pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+tCQ7Q+DlWb9L3xiHY3WIvsh8EpUIjqTwd7hAA7MXs=;
        b=AlM4Jk3r67Wo0GH9DLPuQb4m8nUIJyuOXTHmNnuAgxSeQLhFym0vgwLVjJ5BWhmB0x
         zF8TV69X/g4Ks0m7ixaWVOTvvUkLb1f7YYKDOmXlP+9UOHzzXUHkDHk9waU+jZ+1mSFP
         4LYSvfxxBdY44J6nuEoxzrJV9V1coEzIHIiedrzn0u3PZz4qJOp9oSVBp4O96WKcYMF4
         t7yHS9FDWgudfSAdbWF/zG2tw++X87TxIOgIl31yxQpii86/kVGNwm5bTq57cQ7PiOrA
         E7IUYB3LLM/1cWujiQfYrOWj8VX8vc0t7706qp6uzWPMJnk88EQ0HK0YCMVDaZNGi2SK
         pc/w==
X-Gm-Message-State: AOAM530hQl/wRmc/xGBW9b3jLDnMgh9RAoHGxe9XBadmeEZQ5/50efXP
        E5nny9xs5N3s/nY3zVY3HoaADnl3U/WAnX73
X-Google-Smtp-Source: ABdhPJzg8RTr2alyYomarYQybftv2jMUjtpzwgKUfh6vE72nmTjz0fuVwZz5/iDF7+PpI+NKobwqcQ==
X-Received: by 2002:a5d:5008:: with SMTP id e8mr26897464wrt.386.1620128973856;
        Tue, 04 May 2021 04:49:33 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id n10sm16181972wrw.37.2021.05.04.04.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:49:33 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH 4/4] can: m_can: fix whitespace in a few comments
Date:   Tue,  4 May 2021 12:49:01 +0100
Message-Id: <20210504114900.351170-5-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504114900.351170-1-torin@maxiluxsystems.com>
References: <20210504114900.351170-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fixes whitespace in comments titling sections of register masks.

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
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

