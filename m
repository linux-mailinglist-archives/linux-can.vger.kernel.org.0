Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E512EE74F
	for <lists+linux-can@lfdr.de>; Thu,  7 Jan 2021 22:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbhAGVAM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 7 Jan 2021 16:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbhAGVAM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 7 Jan 2021 16:00:12 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE981C0612F5;
        Thu,  7 Jan 2021 12:59:31 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id u21so5218530qtw.11;
        Thu, 07 Jan 2021 12:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h0t6RvEuK3QC6pz1reDucxNqeTNUSSiK/dbpy6+pD6w=;
        b=Bm/BWLXW5+F0jWLfRKXwxYmsKPRDC5tw1SEf8EPuuOfDVaihns0/dsxbn3psU8RG4N
         W2s0B5oiSdeQNPVOjnDh24hJqFw1U6NbiCOR8nHrpwPIGCxYvNlY7Z+n+AfhLJDt/BIJ
         wmCqtSiNmi3kjRBeJPZhhC5hh8cjbxymkZo2lLYllxElVXmFq0xNsMQzm0oFVoMsFa/m
         k5c3PpJaV+8dw9XOBUCpHZMUAN8KHSVLCtLVeeTNsBKLkvmzywjEjzflGvs1gzU/GELs
         GWwu2Ey6FlIAaHQENKNdkK9YAbgk7kRlBe9ILB/fjsiLHDWCCWnMsSadbHNunli1EFOB
         UD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h0t6RvEuK3QC6pz1reDucxNqeTNUSSiK/dbpy6+pD6w=;
        b=aIfJgxQ3rSLKvOktylGKPnFMgZVRCAUu9ng8vM7yegLisJKKA4snBA/718fiKdHhmj
         jgBJ9/x8SGzGaEIxdKVO8kdltkBWlKAFdeCBIV566PwZ21OJyde7IWAtYKL2zkHeFfz5
         CYyZiacZTOXsmtUQxELow5kI5QTQKmPW/WLBR0q7Z2X7rZD9l6sa/OQitfYr1qWC1d8D
         xJrLvyVgrwx4CiTqD2KRgALFv599yJFMAiaKUl4o0++ede2jKuuXgHYnRg0Z1g+Yadeu
         dZB1wAA1AjHQMaSU9LWEgT0xW5sDFsxsqkVawKgh0IrN/M0ZSJXZynIC8x+auCw+ZQHf
         dGtA==
X-Gm-Message-State: AOAM532D9JFDqLiBjK+lUdlQVEmShSJ73Ip++FbkD2wI5uCYGGuOcAVX
        0On1Q9Qki0yheveNh6YuvZI=
X-Google-Smtp-Source: ABdhPJwF69FgQ75hRmgpUCrb+PYdQ3qs/Xmk+jdaIfMPtDpkzOQrqIEDMQM6Yst3HYdpIVPV20FfTA==
X-Received: by 2002:ac8:588c:: with SMTP id t12mr508159qta.184.1610053171188;
        Thu, 07 Jan 2021 12:59:31 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:482:a80::1001])
        by smtp.gmail.com with ESMTPSA id u5sm3939152qka.86.2021.01.07.12.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:59:30 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] can: flexcan: allow the control of the STB CAN transceiver pin
Date:   Thu,  7 Jan 2021 17:59:15 -0300
Message-Id: <20210107205915.7602-2-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210107205915.7602-1-festevam@gmail.com>
References: <20210107205915.7602-1-festevam@gmail.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

It is very common to have an STB pin in CAN transceivers, which allows
putting the transceiver in standby or normal operation mode.

Add support for handling the STB pin.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/net/can/flexcan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 038fe1036df2..094050b4b461 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -17,6 +17,7 @@
 #include <linux/can/rx-offload.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
@@ -358,6 +359,8 @@ struct flexcan_priv {
 	struct regulator *reg_xceiver;
 	struct flexcan_stop_mode stm;
 
+	struct gpio_desc *stb;
+
 	/* Read and Write APIs */
 	u32 (*read)(void __iomem *addr);
 	void (*write)(u32 val, void __iomem *addr);
@@ -617,6 +620,8 @@ static void flexcan_clks_disable(const struct flexcan_priv *priv)
 
 static inline int flexcan_transceiver_enable(const struct flexcan_priv *priv)
 {
+	gpiod_set_value_cansleep(priv->stb, 0);
+
 	if (!priv->reg_xceiver)
 		return 0;
 
@@ -625,6 +630,8 @@ static inline int flexcan_transceiver_enable(const struct flexcan_priv *priv)
 
 static inline int flexcan_transceiver_disable(const struct flexcan_priv *priv)
 {
+	gpiod_set_value_cansleep(priv->stb, 1);
+
 	if (!priv->reg_xceiver)
 		return 0;
 
@@ -2044,6 +2051,10 @@ static int flexcan_probe(struct platform_device *pdev)
 		priv->can.bittiming_const = &flexcan_bittiming_const;
 	}
 
+	priv->stb = devm_gpiod_get_optional(&pdev->dev, "stb", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->stb))
+		return PTR_ERR(priv->stb);
+
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-- 
2.17.1

