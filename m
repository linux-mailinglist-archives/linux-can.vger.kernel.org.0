Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482ED3917FE
	for <lists+linux-can@lfdr.de>; Wed, 26 May 2021 14:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhEZMxR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 May 2021 08:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbhEZMv2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 May 2021 08:51:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7C0C061351
        for <linux-can@vger.kernel.org>; Wed, 26 May 2021 05:48:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h3so643036wmq.3
        for <linux-can@vger.kernel.org>; Wed, 26 May 2021 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AGcjh4qQwZf7olurqRtc2i5yeO9GnQLlCr1W5lh/u8M=;
        b=i7micjIk7dkgVDZM6jqPL9ab9E116vAxSPQSoJav6WAy3R72SJViilEMwFGGgVirqG
         j7KvWj9+CE+qFNdaVvk7o4wKon+uO2QUo1bkresCM7901nYV+i5eJRLQRHQkP6ayoPXs
         YgpGFbcBHL6WbEUFCGyExQp4jnDAuvfh5v3AijevyzkS1dlxCwq1VaOsVbKeUFuM2jmo
         rDR4/rlxfp4vJhOMFuRDCR5Rt8KkxpZTj5DSi5bDuk4n01NnmoRsHlLYd7YoGza5E9ZR
         aY7rRwACHAMN8WScpIZMotOi5yw1xS3bQNMGvRjeV9ZU3kqoLJoDksPiAJ4+a0ABck1+
         kJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGcjh4qQwZf7olurqRtc2i5yeO9GnQLlCr1W5lh/u8M=;
        b=j7oPaMfKMKaXGD9XhEWekR/E5VFYE727KPfK9UttioRpkPW2H3Ae6pYFVwIwbSX+AI
         B209aMWe5MQ3nCLpcd0xksAZowuqJ7ugdUFKqJ5MBn5k801fD+uqMMPGQBQcQ64S90Ca
         TlhL72IWMKkdEXgMeBw1arJE/GD0gOwiNWmNFXaRXXpHlnqtubQ2NCi3EbjWBUjMgsnI
         8GInMZdmAd8mu23m8lLfMDhoTtmuN588tuj6FbgDESgiHIyeGple3e9qwQxw6xW2LXZb
         4Lg9hQtNm5HbBqjRP2uWqe8o0BKlHjS0Sse50mTah2E9s0VLDLM9tUI17XtKKSRKA3ld
         o4qA==
X-Gm-Message-State: AOAM5310hxM/4gRxxHegnQ6OGO56ykCFSrxr3YwawErtBR/SaaFv9ZJ/
        wBKh6nfHCqxrkTaVYzkW2Xhp9w==
X-Google-Smtp-Source: ABdhPJySLryvF9KYlScsBCULocdHwTtpsAUBq9elW/OJzT6R1ugj35kqQcmK4QstDrSRcf4AmMslkg==
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr28191635wmd.20.1622033319696;
        Wed, 26 May 2021 05:48:39 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.155.threembb.co.uk. [92.41.10.155])
        by smtp.gmail.com with ESMTPSA id a4sm1864100wme.45.2021.05.26.05.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 05:48:39 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH can-next 3/5] can: tcan4x5x: tcan4x5x_clear_interrupts(): rm unnecessary reg clears
Date:   Wed, 26 May 2021 13:47:45 +0100
Message-Id: <20210526124747.674055-4-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210526124747.674055-1-torin@maxiluxsystems.com>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Remove clear of reg 0x0824 (TCAN4X5X_MCAN_INT_REG). It has no effect, as
this is a read-only copy of the M_CAN core interrupt register.

Remove clear of reg 0x0010 (TCAN4X5X_ERROR_STATUS). The reg is not
documented in the TCAN4550 datasheet. It is listed in the official TI
demo program headers, but is not used.

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index b4aeab10d62f..a938dbc617e3 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -207,17 +207,7 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
 	if (ret)
 		return ret;
 
-	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_MCAN_INT_REG,
-				      TCAN4X5X_ENABLE_MCAN_INT);
-	if (ret)
-		return ret;
-
-	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_INT_FLAGS,
-				      TCAN4X5X_CLEAR_ALL_INT);
-	if (ret)
-		return ret;
-
-	return tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
+	return tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_INT_FLAGS,
 				       TCAN4X5X_CLEAR_ALL_INT);
 }
 
-- 
2.30.2

