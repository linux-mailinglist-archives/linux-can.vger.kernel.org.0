Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FDF3917FF
	for <lists+linux-can@lfdr.de>; Wed, 26 May 2021 14:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhEZMxS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 May 2021 08:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbhEZMvf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 May 2021 08:51:35 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA442C061353
        for <linux-can@vger.kernel.org>; Wed, 26 May 2021 05:48:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z130so649436wmg.2
        for <linux-can@vger.kernel.org>; Wed, 26 May 2021 05:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KV9OPdvkLE9lJcOLgvnbfvjH3bSi9Jsp496zmVnrnvU=;
        b=umnAcqU5q22Szmb/oTzF88nwvYG76ab+GcxfCkoFrZmUTfkIzjlZD03p0AKEyaN2pX
         MCWkOeoq3PbFZNByUkE/aJU1OXAHSxxW08G6mhsVen+ONusfTiYzCX7JdK+SfCuD6Hq7
         WNVQIMiKe59pKyidwOab6eIMzHF9O8PRQNzL9lD1T4HIsb7nKa5c5VAC67XrZiW4UK15
         xmRS5uOi3ubgcHfmJRqUSUB+qN+WElVs/Lz6LLy56lmrteExpeg3vkT7CBIIr9YQ04sm
         HdV+NiE54gl3ARZGz0AvAuz7DiuKbvbjaAkGNPmEVRTKpECNnh8QhhZfui9BGJzpqYpW
         c6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KV9OPdvkLE9lJcOLgvnbfvjH3bSi9Jsp496zmVnrnvU=;
        b=YqY6H7cyabXPLer6I6iqIRMchKekwo/A7pgX/9eDMoizg5lFpdDLSQSOT8PeOs3rg6
         X74H7Lj/CL/tMHU/0bfFKUNTeh/RSVC3PhIv8il4dPO+IXiAQcc8q3y6bmE9wzy3Tb53
         3iQnkjJj/FeDt59hTEi8AWpVmWOvB2UDk2Mg2GES6/+k+vA77lL3HVtw3SCtiAdsQQ+V
         FmbWYhH4v6ljUm7NabkviMLd6SgkyAw/sJtl/n+6+K/oaOShU1Q1CyphIDspmnlYQbD0
         srX0YiBXNRqcmHt+8UlbxaVHjzVtv+rxedCmtN4z8y+R4dCvzUZY4UkGjhxtkDkmUqdM
         nv2A==
X-Gm-Message-State: AOAM5304s0lXDnHIbvAARhCCy4CjTRNiXpQGyShHr5Lnk5WxN7clkyMC
        WCOhjUAOAzP1jI8gd3lvGUqPZ0M7uHym+A==
X-Google-Smtp-Source: ABdhPJzpFPwswFylicwWhV/WOJIC79+FeLROA6H6H6PUAeM34fOtTVYogydE3a9OOIjqD9gpP2Ap0g==
X-Received: by 2002:a1c:3186:: with SMTP id x128mr28051433wmx.167.1622033321530;
        Wed, 26 May 2021 05:48:41 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.155.threembb.co.uk. [92.41.10.155])
        by smtp.gmail.com with ESMTPSA id a4sm1864100wme.45.2021.05.26.05.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 05:48:41 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH can-next 5/5] can: tcan4x5x: implement handling of device interrupts
Date:   Wed, 26 May 2021 13:47:47 +0100
Message-Id: <20210526124747.674055-6-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210526124747.674055-1-torin@maxiluxsystems.com>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Handle power, transceiver and SPI failures by printing a useful error
message (multiple simultaneous failures are not logged) and disabling
the TCAN4550 by setting it to standby mode.

Additionally, print an error message if any regmap access fails in the
tcan4x5x_handle_dev_interrupts() call.

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 50 ++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index a300a14dc5de..2016a4b54a44 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -38,6 +38,7 @@
 #define TCAN4X5X_CANDOM_INT_EN BIT(8)
 #define TCAN4X5X_CANBUS_ERR_INT_EN BIT(5)
 #define TCAN4X5X_BUS_FAULT BIT(4)
+#define TCAN4X5X_SPIERR_INT BIT(3)
 #define TCAN4X5X_MCAN_INT BIT(1)
 #define TCAN4X5X_ENABLE_TCAN_INT \
 	(TCAN4X5X_UVSUP_INT_EN | TCAN4X5X_UVIO_INT_EN | TCAN4X5X_TSD_INT_EN | \
@@ -214,7 +215,54 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
 static irqreturn_t tcan4x5x_handle_dev_interrupts(struct m_can_classdev *cdev,
 						  bool clear_only)
 {
-	tcan4x5x_clear_interrupts(cdev);
+	struct tcan4x5x_priv *priv = cdev_to_priv(cdev);
+	int err = 0;
+	irqreturn_t handled = IRQ_NONE;
+
+	if (!clear_only) {
+		u32 ir = 0;
+		const char *fail_str = "";
+
+		err = regmap_read(priv->regmap, TCAN4X5X_INT_FLAGS, &ir);
+		if (err)
+			goto exit_regmap_failure;
+
+		handled = IRQ_HANDLED;
+
+		if (ir & TCAN4X5X_UVSUP_INT_EN)
+			fail_str = "supply under-voltage (UVSUP)";
+		else if (ir & TCAN4X5X_UVIO_INT_EN)
+			fail_str = "I/O under-voltage (UVIO)";
+		else if (ir & TCAN4X5X_TSD_INT_EN)
+			fail_str = "thermal shutdown (TSD)";
+		else if (ir & TCAN4X5X_ECCERR_INT_EN)
+			fail_str = "uncorrectable ECC error (ECCERR)";
+		else if (ir & TCAN4X5X_CANDOM_INT_EN)
+			fail_str = "CAN stuck dominant (CANDOM)";
+		else if (ir & TCAN4X5X_SPIERR_INT)
+			fail_str = "SPI error (SPIERR)";
+		else
+			handled = IRQ_NONE;
+
+		if (handled == IRQ_HANDLED) {
+			netdev_err(cdev->net, "%s: device is disabled.\n",
+				   fail_str);
+			err = regmap_update_bits(priv->regmap, TCAN4X5X_CONFIG,
+						 TCAN4X5X_MODE_SEL_MASK,
+						 TCAN4X5X_MODE_STANDBY);
+			if (err)
+				goto exit_regmap_failure;
+		}
+	}
+
+	err = tcan4x5x_clear_interrupts(cdev);
+	if (err)
+		goto exit_regmap_failure;
+
+	return handled;
+
+exit_regmap_failure:
+	netdev_err(cdev->net, "regmap access failed in IRQ handler.\n");
 	return IRQ_NONE;
 }
 
-- 
2.30.2

