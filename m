Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48B2372A68
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 14:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhEDMwa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 08:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhEDMwa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 08:52:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF41C061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 05:51:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l14so9294398wrx.5
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eoYrSRp+PhZWiRA0OZPv9ULJaIKFJNfevh0I1gRHaSA=;
        b=lHKTEwwR217b7/jPSxCiNan/Jf2lMAWfhgnrChindddYUppQJQ+TtzOISoCA2b6o+i
         6ccD5LY0U00iiZsste+BZfadl6Jd8q7p9UunnSYnZzuToyiI2P1EJRaNEsG4A3ZomSKN
         G8miwqthMWYIm/OfA3cpbaQSZBRC1nhRBcFPFyLFgOIDbEmbFUyAK3+1NBPVA0XoPVXk
         rQWNoXzoYcmZx0/uEZEE3+pUenq0RI8SZCqYsJ5AGeBASyAy+C5rhrI1MkFJ/xh2ROKO
         WCb2Hn4+Afp7TfZ5/Ito64OroL188EWW72IrHFN/gRPfO6ga4ZBp3ZLPlnxZjvTKqu90
         DpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eoYrSRp+PhZWiRA0OZPv9ULJaIKFJNfevh0I1gRHaSA=;
        b=g8odBIkDhmDynEcYt0OWWSpPYbbB5v8kpBQ36SYG0cKlXVLR827FqCnvVNw/ZPLrNp
         KOOKMUdlm5ujQLVihxzv2KPKscaPDYMTa3knk8zLZjx4ZY0aLEEsO6QeervYvejPg166
         B3+v44HEI0QgHrjif2zmPC13ItatzKoYVDRNPGQu9Ig6HXeh9FMpmiJk9YZTyL6q467N
         zzBPJkIMYvtRIPw1INJ2BSBYzfN2buWXTkKsRgtzK+VDmlw/M4Hv+kS06Mk1xl858M7Q
         3mbHQh0L25Phlnqckz2p3PFdaba/AdiCVZe4XssQY+kVqhMKbGsuCg32qdCBcIwXX47j
         R1OQ==
X-Gm-Message-State: AOAM531Hws6eCdcnb2uD03oh+HwNF+/c2SWqcUioJCo3hohX7eUwEnu+
        HTRnBBIibgVRRoAr5stYzrhDU4Tk+H990s8s
X-Google-Smtp-Source: ABdhPJyIXQPnv0B8jCbcEov9T7ebTTNAtwwFsDy5wa1grERfs695Kk0OwcMbXGCE5gGl4F/UqnTJ4Q==
X-Received: by 2002:adf:eb86:: with SMTP id t6mr32187949wrn.253.1620132694101;
        Tue, 04 May 2021 05:51:34 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id n5sm11679527wrx.31.2021.05.04.05.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 05:51:33 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH v2 4/4] can: m_can: fix whitespace in a few comments
Date:   Tue,  4 May 2021 13:51:23 +0100
Message-Id: <20210504125123.500553-5-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504125123.500553-1-torin@maxiluxsystems.com>
References: <20210504125123.500553-1-torin@maxiluxsystems.com>
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
index 14b47850e1e3..2fa10bc0befe 100644
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

