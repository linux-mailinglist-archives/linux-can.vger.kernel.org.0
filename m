Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6083917FB
	for <lists+linux-can@lfdr.de>; Wed, 26 May 2021 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhEZMxP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 May 2021 08:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbhEZMv1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 May 2021 08:51:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA1CC06134F
        for <linux-can@vger.kernel.org>; Wed, 26 May 2021 05:48:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so463438wmq.0
        for <linux-can@vger.kernel.org>; Wed, 26 May 2021 05:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10XHt5AYqqzXQJlriq1JGL4xitMAMRb6pHbN23oagVs=;
        b=yctwKrUBVq6NMk2ZXV0rn4FMawUFHRidXLl6biEAO2ek+zsDMm1PCtQRbYGDrsSyfp
         7qPXfrdj+oxoirxZ1jyxxZy7gEXgw3PAadAj8fIQewmsvIG/botZ3MH0CRw+qOkfzzBP
         gh4W0ugNht6Efqy5gpBo8TWGS+nPcvLMtsYR9bbj+8yKdTDCJrVCUYIRj+ciGwikt3ar
         kPdQ4YO2/RwHLM7+U6V9YUVHGkIuK9NsrHJHLT48JomsO8sPnjwLd0ppXHm/QcJu4caS
         XO3JKR+cmImgDVF//gkWqIwWGO3XhhFopFH7jkEANVpl+F6jS4AOpJ6a4433dwrH/7Rr
         s2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=10XHt5AYqqzXQJlriq1JGL4xitMAMRb6pHbN23oagVs=;
        b=hr5HYaJmJSrrxKWzUdpQTfnR0evSaAuJrmlRIjp4+WncyWT38rdpSBwIq64/RGAC4t
         Sp3EjVXJmBoCqFt8Fi/Zszn+KBik4Wg7qJVzX8egqQ5vJ9LiMx/HWVO87WXRKEtvLsuf
         Hte2pNX7Q27WQX14n9kpWpESYW+oD/KkEnpVvy8GEVnYv2Fn0ngY9SQ6f8LuM0EYnK2w
         T8obw///QSRPPA1EtAhbc3piCBgnoo9VLc0qlfjkiL6+0WzZSQZhSij/gYGKz2z3QhRz
         8BOim8vtbBujRsHkf8YIDQvqb9ncm4RSXJ6lKH63l6kPa+Wj5ayYBHiTsYyWmPiZu8hP
         v76g==
X-Gm-Message-State: AOAM531PcjhpwXqiSagvpa87njsFCFKM2/655TY99p5Jt6Jr1mwvGa/3
        7CgVQvL34ioeyDFJmv8JcsFjlQ==
X-Google-Smtp-Source: ABdhPJwyf775eC9e8qxpcRJsOQXpzXgfxY2R/cWa55Qy5za8Gq7bajY9+lvN5hNC2zPkWyskxcTniw==
X-Received: by 2002:a05:600c:21c3:: with SMTP id x3mr27976457wmj.131.1622033317845;
        Wed, 26 May 2021 05:48:37 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.155.threembb.co.uk. [92.41.10.155])
        by smtp.gmail.com with ESMTPSA id a4sm1864100wme.45.2021.05.26.05.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 05:48:37 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH can-next 1/5] can: m_can: ops: clear_interrupts -> handle_dev_interrupts
Date:   Wed, 26 May 2021 13:47:43 +0100
Message-Id: <20210526124747.674055-2-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210526124747.674055-1-torin@maxiluxsystems.com>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

M_CAN-based devices such as TI TCAN4550 have device-specific interrupts
which are not part of the M_CAN core, but are signaled on the same
interrupt pin. Therefore, replace the clear_interrupts callback with
handle_dev_interrupts, which can handle and clear interrupts, returning
irqreturn_t.

The clear_only argument is added to retain the option of clearing
interrupts without any handling, for the purpose of saving overhead due
to register accesses.

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/m_can.c         | 4 ++--
 drivers/net/can/m_can/m_can.h         | 4 +++-
 drivers/net/can/m_can/tcan4x5x-core.c | 9 ++++++++-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 34073cd077e4..fa853201d2c4 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1044,8 +1044,8 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	if (ir & IR_ALL_INT)
 		m_can_write(cdev, M_CAN_IR, ir);
 
-	if (cdev->ops->clear_interrupts)
-		cdev->ops->clear_interrupts(cdev);
+	if (cdev->ops->handle_dev_interrupts)
+		cdev->ops->handle_dev_interrupts(cdev, true);
 
 	/* schedule NAPI in case of
 	 * - rx IRQ
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index ace071c3e58c..81d201aa5af2 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -28,6 +28,7 @@
 #include <linux/iopoll.h>
 #include <linux/can/dev.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/irqreturn.h>
 
 /* m_can lec values */
 enum m_can_lec_type {
@@ -61,7 +62,8 @@ struct mram_cfg {
 struct m_can_classdev;
 struct m_can_ops {
 	/* Device specific call backs */
-	int (*clear_interrupts)(struct m_can_classdev *cdev);
+	irqreturn_t (*handle_dev_interrupts)(struct m_can_classdev *cdev,
+					     bool clear_only);
 	u32 (*read_reg)(struct m_can_classdev *cdev, int reg);
 	int (*write_reg)(struct m_can_classdev *cdev, int reg, int val);
 	u32 (*read_fifo)(struct m_can_classdev *cdev, int addr_offset);
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 4147cecfbbd6..b4aeab10d62f 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -221,6 +221,13 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
 				       TCAN4X5X_CLEAR_ALL_INT);
 }
 
+static irqreturn_t tcan4x5x_handle_dev_interrupts(struct m_can_classdev *cdev,
+						  bool clear_only)
+{
+	tcan4x5x_clear_interrupts(cdev);
+	return IRQ_NONE;
+}
+
 static int tcan4x5x_init(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
@@ -304,7 +311,7 @@ static struct m_can_ops tcan4x5x_ops = {
 	.write_reg = tcan4x5x_write_reg,
 	.write_fifo = tcan4x5x_write_fifo,
 	.read_fifo = tcan4x5x_read_fifo,
-	.clear_interrupts = tcan4x5x_clear_interrupts,
+	.handle_dev_interrupts = tcan4x5x_handle_dev_interrupts,
 };
 
 static int tcan4x5x_can_probe(struct spi_device *spi)
-- 
2.30.2

