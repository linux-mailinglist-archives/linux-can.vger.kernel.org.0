Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7724624E7
	for <lists+linux-can@lfdr.de>; Mon, 29 Nov 2021 23:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhK2WdH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 Nov 2021 17:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbhK2WbJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Nov 2021 17:31:09 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4975C096766
        for <linux-can@vger.kernel.org>; Mon, 29 Nov 2021 14:27:51 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso15479082pjb.2
        for <linux-can@vger.kernel.org>; Mon, 29 Nov 2021 14:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluerivertech.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/KmtMbfeaXHuTAh4g4GRV6pvDUPLEEqbIUrWqrzrkr4=;
        b=MVciiR/0Lt0NLKjRq9rUA8C0kKeHsKsdf0Qk7wdF1y1yrM0xmZfTFv/X/5yzqZ+9QB
         vTqZJ4KDLHlujFvzzv1PiPlPgDnDSPt7TffxI7pXBiB3BdQjXuSdy5AF+uGRdaamwIQk
         mXXVNute8wPzRxjw2nWVMe0cT4ZibcmIoAatoJ4Y1g2ovWmLrXKDhLXBQQ46RbGtXqzn
         niVALQcT8seeEMznpSq4A1x/40mpUf9Fztc+Oz3YR0c1pSnYkjId2+B2xWPrZ2v0Ao5C
         c/ljTZThfQVi0S9vhUqt9iAitGGQ25haovbzXuJ9v/GXssRhiVwLb8VCk+DvaBdWqZp5
         FP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/KmtMbfeaXHuTAh4g4GRV6pvDUPLEEqbIUrWqrzrkr4=;
        b=kse+KPfkg8i0viSHOhf3XkzBlmFUeXNNhLz/8SqEVC7ayVSWl0CHnSUB22wXZufCWv
         y+D2HaGzLmErYD8R2YyvmmrI/cKh6GqCRLm42AcZAvek/wsVQuTRTEfk4eEFYrU8zQDk
         QDSfkGy6gV63qhzbDKAwmLgQFpOYWMlb+W2Q9FhKG1pOVNuuAjPV649N3ut/ocAWTZnk
         gwxYvMu5r6MDLLFJgQaaK1XInuS+6VV48RPkr7ZXHwqZinTh9fdpM2N5kGGh+k1qosSp
         07qM8XI5LSLaY56owxgL1E1Sb7NGn0LAGX2phFYGElJtc8LuvUVpw1H391DNWi1NL3e+
         S1hA==
X-Gm-Message-State: AOAM532/j3pyZ3oCqwxNsO33/rExgNmsEs0jrz8ExbLmJAg3ZfYrFbvG
        k6i9fCkUW96kByArHAnqtTqw88/2FMThGg==
X-Google-Smtp-Source: ABdhPJzFMLhjVLY9yCkfDQgnTgKpGAYN3oXMd2qZQsYSNGPxE+7RvtTX5dk8CU0Oy91xu3uUaBwmoQ==
X-Received: by 2002:a17:90b:4a0f:: with SMTP id kk15mr1011991pjb.223.1638224871243;
        Mon, 29 Nov 2021 14:27:51 -0800 (PST)
Received: from localhost.localdomain (c-73-231-33-37.hsd1.ca.comcast.net. [73.231.33.37])
        by smtp.gmail.com with ESMTPSA id i2sm19489983pfg.90.2021.11.29.14.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:27:50 -0800 (PST)
From:   Brian Silverman <brian.silverman@bluerivertech.com>
Cc:     Brian Silverman <brian.silverman@bluerivertech.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Dong Aisheng <b29396@freescale.com>,
        Varka Bhadram <varkabhadram@gmail.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        linux-can@vger.kernel.org (open list:MCAN MMIO DEVICE DRIVER),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RESEND] can: m_can: Disable and ignore ELO interrupt
Date:   Mon, 29 Nov 2021 14:26:28 -0800
Message-Id: <20211129222628.7490-1-brian.silverman@bluerivertech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211109021240.3013-1-brian.silverman@bluerivertech.com>
References: <20211109021240.3013-1-brian.silverman@bluerivertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

With the design of this driver, this condition is often triggered.
However, the counter that this interrupt indicates an overflow is never
read either, so overflowing is harmless.

On my system, when a CAN bus starts flapping up and down, this locks up
the whole system with lots of interrupts and printks.

Specifically, this interrupt indicates the CEL field of ECR has
overflowed. All reads of ECR mask out CEL.

Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Signed-off-by: Brian Silverman <brian.silverman@bluerivertech.com>
---
 drivers/net/can/m_can/m_can.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2470c47b2e31..91be87c4f4d3 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -204,16 +204,16 @@ enum m_can_reg {
 
 /* Interrupts for version 3.0.x */
 #define IR_ERR_LEC_30X	(IR_STE	| IR_FOE | IR_ACKE | IR_BE | IR_CRCE)
-#define IR_ERR_BUS_30X	(IR_ERR_LEC_30X | IR_WDI | IR_ELO | IR_BEU | \
-			 IR_BEC | IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | \
-			 IR_RF1L | IR_RF0L)
+#define IR_ERR_BUS_30X	(IR_ERR_LEC_30X | IR_WDI | IR_BEU | IR_BEC | \
+			 IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | IR_RF1L | \
+			 IR_RF0L)
 #define IR_ERR_ALL_30X	(IR_ERR_STATE | IR_ERR_BUS_30X)
 
 /* Interrupts for version >= 3.1.x */
 #define IR_ERR_LEC_31X	(IR_PED | IR_PEA)
-#define IR_ERR_BUS_31X      (IR_ERR_LEC_31X | IR_WDI | IR_ELO | IR_BEU | \
-			 IR_BEC | IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | \
-			 IR_RF1L | IR_RF0L)
+#define IR_ERR_BUS_31X      (IR_ERR_LEC_31X | IR_WDI | IR_BEU | IR_BEC | \
+			 IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | IR_RF1L | \
+			 IR_RF0L)
 #define IR_ERR_ALL_31X	(IR_ERR_STATE | IR_ERR_BUS_31X)
 
 /* Interrupt Line Select (ILS) */
@@ -810,8 +810,6 @@ static void m_can_handle_other_err(struct net_device *dev, u32 irqstatus)
 {
 	if (irqstatus & IR_WDI)
 		netdev_err(dev, "Message RAM Watchdog event due to missing READY\n");
-	if (irqstatus & IR_ELO)
-		netdev_err(dev, "Error Logging Overflow\n");
 	if (irqstatus & IR_BEU)
 		netdev_err(dev, "Bit Error Uncorrected\n");
 	if (irqstatus & IR_BEC)

base-commit: d2f38a3c6507b2520101f9a3807ed98f1bdc545a
-- 
2.20.1

