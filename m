Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EE6380957
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 14:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhENMVL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 08:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhENMVK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 08:21:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EF9C061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 05:19:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d11so29848623wrw.8
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 05:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a4y4DOwLyc217W5e3AXnzskGPr1TW2eqC5HRAbWdvnY=;
        b=HGHQpvos9F9Cw1m+zHBLleJNJncdW84PqZFi1e7iTknnGFsl8e4H4DEPbY0ToFymYV
         5rEaS2BtXPRC09/ILtwANKk6rTxBg6pDbxmnpNW3/XE589QnsrUm/+M25HzMDnSXrITc
         eFaf420GCCtrXI11a0W2E0L+RHeIm8HzQtAYVaLDp2EUfbElNJG1b1Jas49C7Gjh4UXg
         53nDHN3m+A8YE0NN7cmS5NzWdqkZ5P882itoUH0YspCMAAGOmh5+ioUhLghwMG6G7xJ6
         dMca4Pl1PnurwYZNSkAh8QRYm2zHlVlyuLv/LQmZcXcwuUwopEhBPDCyWHGDWXPpFWbt
         Vs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a4y4DOwLyc217W5e3AXnzskGPr1TW2eqC5HRAbWdvnY=;
        b=T86kJuYPgR+P+q7aTynTFaIS8NG1Cajhjze+ToFxu0Uh86OZmxquPsd3nA4EXkmZpq
         wCtb+oVlp5Hn73b5NJ7mEt3UYU4XK91DcaeF4nS1fVie0AR5DmnLC9DlyS2L0GXNUdTW
         HASjMf3XKhiVX4GVpDAYeEN8cemf9HzyuUZUpFqR792Vz0jk/zuMGWf03dQvjkE1xSrC
         R0XRxa9dxg0ABFY9PEdYCDuhzBi1N/3ynSCFChmmL3epsdsx5bkk7Xb3IoWH8j2EvLT3
         BRI+Hil+hD7hjqiw18+wdijQsTIc43Z76cAUW1dS4qShfAhqQHVXvjCt6nUffEGLfe9a
         W/sQ==
X-Gm-Message-State: AOAM533pdJAfJb9faU/DidlMBtDjByDhyviOV1vUYxnxkVGqk2YsX0Tf
        xwT2GBS1TCf1w/CdyVgP9c/9KXlWFNY6KA==
X-Google-Smtp-Source: ABdhPJzZhqaM1igloVtlolFp3TkGoJ5WqUS0XVk1lJBsgFMBjRYptqVL7Bro2f7v9psOy9xs1+TsQg==
X-Received: by 2002:adf:df8d:: with SMTP id z13mr15098945wrl.267.1620994797093;
        Fri, 14 May 2021 05:19:57 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.182.threembb.co.uk. [92.41.10.182])
        by smtp.gmail.com with ESMTPSA id r11sm15103wrp.46.2021.05.14.05.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:19:56 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH RFC can-next 3/3] can: tcan4x5x: add handle_dev_interrupts callback to ops
Date:   Fri, 14 May 2021 13:19:46 +0100
Message-Id: <20210514121946.2344901-4-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210514121946.2344901-1-torin@maxiluxsystems.com>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Though the TCAN4550's device-specific interrupts are cleared in
tcan4x5x_clear_interrupts(), they are ignored, which may cause the m_can
driver to stop working due to the ISR becoming disabled (the famous
"nobody cared" message).

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 4147cecfbbd6..cee7dfff381f 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -39,6 +39,7 @@
 #define TCAN4X5X_CANBUS_ERR_INT_EN BIT(5)
 #define TCAN4X5X_BUS_FAULT BIT(4)
 #define TCAN4X5X_MCAN_INT BIT(1)
+#define TCAN4X5X_VTWD_INT BIT(0)
 #define TCAN4X5X_ENABLE_TCAN_INT \
 	(TCAN4X5X_MCAN_INT | TCAN4X5X_BUS_FAULT | \
 	 TCAN4X5X_CANBUS_ERR_INT_EN | TCAN4X5X_CANINT_INT_EN)
@@ -190,6 +191,16 @@ static int tcan4x5x_power_enable(struct regulator *reg, int enable)
 		return regulator_disable(reg);
 }
 
+static u32 tcan4x5x_read_tcan_reg(struct m_can_classdev *cdev, int reg)
+{
+	struct tcan4x5x_priv *priv = cdev_to_priv(cdev);
+	u32 val;
+
+	regmap_read(priv->regmap, reg, &val);
+
+	return val;
+}
+
 static int tcan4x5x_write_tcan_reg(struct m_can_classdev *cdev,
 				   int reg, int val)
 {
@@ -221,6 +232,19 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
 				       TCAN4X5X_CLEAR_ALL_INT);
 }
 
+static irqreturn_t tcan4x5x_handle_dev_interrupts(struct m_can_classdev *cdev)
+{
+	irqreturn_t ret = IRQ_NONE;
+	int ir;
+
+	ir = tcan4x5x_read_tcan_reg(cdev, TCAN4X5X_INT_FLAGS);
+
+	if (ir & (TCAN4X5X_CANDOM_INT_EN | TCAN4X5X_VTWD_INT))
+		ret = IRQ_HANDLED;
+
+	return ret;
+}
+
 static int tcan4x5x_init(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
@@ -305,6 +329,7 @@ static struct m_can_ops tcan4x5x_ops = {
 	.write_fifo = tcan4x5x_write_fifo,
 	.read_fifo = tcan4x5x_read_fifo,
 	.clear_interrupts = tcan4x5x_clear_interrupts,
+	.handle_dev_interrupts = tcan4x5x_handle_dev_interrupts,
 };
 
 static int tcan4x5x_can_probe(struct spi_device *spi)
-- 
2.30.2

