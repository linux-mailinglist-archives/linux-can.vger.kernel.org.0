Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9CB3729AC
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 13:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhEDLu3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 07:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhEDLu3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 07:50:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B937C061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 04:49:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1036760wmc.1
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 04:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pkZG77NQuvu4pN3YMU+SivC4mLtNJejx//34Gaa4SMw=;
        b=FORCmiFh/Zm5nPi9/unooPsUrnjfBU/C5f3rOpUzeqXgMJhisswDzhXHYi3AEBjpbu
         mnYHmsIINh0oZguu0KQTqgeYFGpxPm/Vz6eHGvuR4AQ8xWIb+0BZMV8CqlbuicSBFUG2
         jWrhAvpvHJ7OkZRiOycb9DtZUmTGi1ODo6x5TjnNaudWhVUIVa7KnW8Do+SyYZVhbgZr
         Ljdy7m5Vg75100kcHngNkoe1hDx7fozeSBVwThlIHQqITu49coCj7OvWeZSqaC9Wj+Xn
         Eq+BOV5azp4Al7bEp4jP1MSY6R9Y5ojM73YChUiHGm1kE1/+fjymxUNn9BS+sf1wEWbU
         zl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pkZG77NQuvu4pN3YMU+SivC4mLtNJejx//34Gaa4SMw=;
        b=K2WMjtCel+73uFA6X/yvmZ4vtowwLESN/HLno6qP96igsdfwN+vMf5cvO00OCY0XHL
         8Ut9TiILZ73jayhIz1LT0cmWTPlL5nxShjq4i9FG6VreYL2NRIuulJG8xVCf204gAIDs
         cPK2js4F76N2CsySbwQwA7B0Wwtt/qKZoms7SJ4HdP2l2L+np+PtL4upfLXonJYPL8Xe
         zSWORJMM+NO2UqmAUXw6qPV3uNcg1BfQrP3fNg5/WiKtvNWCVgdL2geIOMLUSqYhl+cP
         luvnWDqeirRBsJFRC5gtR8Fo44pk24LUCGo0TdES6AY4smsaynNf+l0fGOdmsDuvUbII
         BpfA==
X-Gm-Message-State: AOAM533WYVjt6knqSPaE70aApP3AOGyUDzksF76p7zYzikN4IoMLmt50
        QDvjPsySbEtIA6AG3grDHDVfvvj8mqFwiOvf
X-Google-Smtp-Source: ABdhPJwJQG7RUU4iPUSaHlJDnO279H8rhyDGPEgpnG5CxN7kR5z8VnPH225LXB6XwyeOjSbp6GYCGw==
X-Received: by 2002:a7b:c093:: with SMTP id r19mr10598196wmh.35.1620128973064;
        Tue, 04 May 2021 04:49:33 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id n10sm16181972wrw.37.2021.05.04.04.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:49:32 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH 3/4] can: m_can: make TXESC, RXESC config more explicit
Date:   Tue,  4 May 2021 12:49:00 +0100
Message-Id: <20210504114900.351170-4-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504114900.351170-1-torin@maxiluxsystems.com>
References: <20210504114900.351170-1-torin@maxiluxsystems.com>
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
index c85f064de4a0..e3b15b74fdc9 100644
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

