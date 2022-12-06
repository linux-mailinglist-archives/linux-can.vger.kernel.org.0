Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CB46442B6
	for <lists+linux-can@lfdr.de>; Tue,  6 Dec 2022 12:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiLFL6G (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Dec 2022 06:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbiLFL5s (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Dec 2022 06:57:48 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F0D7642
        for <linux-can@vger.kernel.org>; Tue,  6 Dec 2022 03:57:45 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n20so5725160ejh.0
        for <linux-can@vger.kernel.org>; Tue, 06 Dec 2022 03:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjYuBcD7jZlcMi+USU++Fjz73CmyNYItk4pm8+k3tKw=;
        b=nkfae4PG+fak6KgW7NpaTgVTR1s5fmIbeyaIHwuH6k6RzMXAcjRf4MZT4xkRwBQJvj
         GC4TH5ZEFsU42Ruukc7h0vli299sxiDdAhBkQ4wX4fY7fcgXmAWumToF8jK9v2jFdG+n
         GdPFMB6sK4dF2HTrx1qpp1ZRdhkWvHYzTw5ic2CwPjRXKivWRPwE5sQvOwOXsJadgVH5
         lElzZBdn6EJSHoirNtkAofdxX97Rc0cxtv+D63IXnow4sGs7WmmlYffD/Zs1wGPLxvCl
         8QzqR6vE9los4tFcq91h3yrIGoQwVURZobC/WaKt09LqfZUtYZLZ63nskdeTStzoclAg
         SdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjYuBcD7jZlcMi+USU++Fjz73CmyNYItk4pm8+k3tKw=;
        b=X1yZKSMKg6ceIXOhaOybPpMQLICXQtT28S5ZjWlP/aKyG36w/JMq2a2H0T84RAukgW
         KHBPfXzA/g/7i7h2l59bg55B4TLooORp9AJIBp9IlNLc/27Z80fCrbphlgv1fM3dxXd0
         KMnSQdAJZJmo/F98JmsA0RTt7g9QrqHX3zHI+ySPoSzQEHLPBzG5sIBCkEL02oMZA9Ee
         /vATyY4vM8weExnKFrlXbkQjz6auO0joM/p9ZzZTzxyPr0+OzWpJxQiM1bPZftdLw5Md
         BwTPtPOeiRjs1qO/bNfAkmUlfCZhX7rvUY47npMn47yyAekFWgZiV0zGO2jWXkb4efqO
         G/mQ==
X-Gm-Message-State: ANoB5pkaY8SymtUXkgo4lY86Yw+BYs2lirSp8/7P/aZum6NQKG9uBDYY
        8Lk0y6O4u6nlf35ie3VgymS0GA==
X-Google-Smtp-Source: AA0mqf5jgQ4FcTy7pql9K1HWIuuGxaAGky+FaR2hbtqlMXGvIx/3XQ0qK5f+PJGcznSejAY31xwf4Q==
X-Received: by 2002:a17:907:7884:b0:7c0:e6d8:6f22 with SMTP id ku4-20020a170907788400b007c0e6d86f22mr9275118ejc.670.1670327863538;
        Tue, 06 Dec 2022 03:57:43 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:8713:84e4:2a9e:cbe8])
        by smtp.gmail.com with ESMTPSA id ky20-20020a170907779400b007c0ac4e6b6esm6472076ejc.143.2022.12.06.03.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 03:57:43 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 09/11] can: tcan4x5x: Fix use of register error status mask
Date:   Tue,  6 Dec 2022 12:57:26 +0100
Message-Id: <20221206115728.1056014-10-msp@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206115728.1056014-1-msp@baylibre.com>
References: <20221206115728.1056014-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

TCAN4X5X_ERROR_STATUS is not a status register that needs clearing
during interrupt handling. Instead this is a masking register that masks
error interrupts. Writing TCAN4X5X_CLEAR_ALL_INT to this register
effectively masks everything.

Rename the register and mask all error interrupts only once by writing
to the register in tcan4x5x_init.

Fixes: 5443c226ba91 ("can: tcan4x5x: Add tcan4x5x driver to the kernel")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---

Notes:
    v2:
     - Add fixes tag

 drivers/net/can/m_can/tcan4x5x-core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 1fec394b3517..efa2381bf85b 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -10,7 +10,7 @@
 #define TCAN4X5X_DEV_ID1 0x04
 #define TCAN4X5X_REV 0x08
 #define TCAN4X5X_STATUS 0x0C
-#define TCAN4X5X_ERROR_STATUS 0x10
+#define TCAN4X5X_ERROR_STATUS_MASK 0x10
 #define TCAN4X5X_CONTROL 0x14
 
 #define TCAN4X5X_CONFIG 0x800
@@ -204,12 +204,7 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
 	if (ret)
 		return ret;
 
-	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_INT_FLAGS,
-				      TCAN4X5X_CLEAR_ALL_INT);
-	if (ret)
-		return ret;
-
-	return tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
+	return tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_INT_FLAGS,
 				       TCAN4X5X_CLEAR_ALL_INT);
 }
 
@@ -229,6 +224,11 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
 	if (ret)
 		return ret;
 
+	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS_MASK,
+				      TCAN4X5X_CLEAR_ALL_INT);
+	if (ret)
+		return ret;
+
 	/* Zero out the MCAN buffers */
 	ret = m_can_init_ram(cdev);
 	if (ret)
-- 
2.38.1

