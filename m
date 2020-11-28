Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3EF2C730B
	for <lists+linux-can@lfdr.de>; Sat, 28 Nov 2020 23:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389376AbgK1Vt7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 28 Nov 2020 16:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387393AbgK1SST (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 28 Nov 2020 13:18:19 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC689C02A19E
        for <linux-can@vger.kernel.org>; Sat, 28 Nov 2020 05:29:04 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id i199so6756871qke.5
        for <linux-can@vger.kernel.org>; Sat, 28 Nov 2020 05:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7dJA1TKnbNN7W17LOSWam+wywCbZzuAy+Vbq2+hL4r8=;
        b=ekZcseY0lcXPhyg3VE8xLdmCYYa5YTPrwgHyWh/kqIw8Uxd0T9fKBkEVHqdmYzNkaX
         dK/aMUE4BadXC/mw1tY66hHKbb9Qp/BD5mMvlS0xSJKoTWIpgvJ6vlGGtK3NIBgX8NS1
         G0TRVqVbp0LpkRYkoWzIJNfP6q6e+oB2xaHq5OLuy9taNh2m11xZl8xQy9dd4YuukLBO
         j32DsuiIMM9T4ObJfsbHn4BXvVkXc3Vgfjy0w8LFIQNzb26wi9dEacUX4Q5v3MY/j/9b
         CAwmqOk530TmBnXd/VDZadiNibK7UxGdVcbHTLLXygrclLIFv1J9L+knc1bvu3aViMj9
         vJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7dJA1TKnbNN7W17LOSWam+wywCbZzuAy+Vbq2+hL4r8=;
        b=RNkh2bWWZ4z1L6J3fZnF2+wqf1XpW7fZgR2NfO82Q7AO0dWMK9Z9RLTqwVN9zBruig
         cyC//MgzeofiHXufzb+iXoG5QOLBmTAq/M5iYpZ4Pcib8AfAqym2yoRKmg02jAfTNkwU
         ENo/2DlXZR3Wq01pHosICxUCA8tYzp7rAgBkX9idlPR2Wt0FApzaj2bqW0GnvZOtdNXo
         LrJy5LOozfTXQ/WRSoIc32owwMrJF9oUDEF0R46AgNetK+JBiM9kI5XX0MUp03TYeh6l
         XBKFW5eM0vesxExPDyu3GvQ44Snt+7JGWgDg+VzbPBG0DUC3YtMRGdPKa7A0zr0tpUbj
         Yfpg==
X-Gm-Message-State: AOAM533OahOzgbhUapTSbfsMPbQ0uqfj/+4rFI1iPIwdE1MhOvbdMK+7
        mTNpUYXUyhp2iZam5iRXm+s=
X-Google-Smtp-Source: ABdhPJwYKZK52+6sXb3sBiey1vn8M7ZLsl8z6XZZ1k3bCEOqwNIyzTUq6y0tUTNbP1t1MWkXbsk8Eg==
X-Received: by 2002:a37:8ec5:: with SMTP id q188mr13678368qkd.85.1606570143702;
        Sat, 28 Nov 2020 05:29:03 -0800 (PST)
Received: from localhost.localdomain ([2804:431:d77f:b974:9ce8:56e7:5368:ece8])
        by smtp.gmail.com with ESMTPSA id k188sm9538875qkd.98.2020.11.28.05.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 05:29:02 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     mkl@pengutronix.de
Cc:     wg@grandegger.com, linux-can@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] can: flexcan: Convert the driver to DT-only
Date:   Sat, 28 Nov 2020 10:28:55 -0300
Message-Id: <20201128132855.7724-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The flexcan driver runs only on DT platforms, so simplify the
code by using of_device_get_match_data() to retrieve the
driver data and also by removing the unused id_table.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/net/can/flexcan.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index e85f20d18d67..038fe1036df2 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1940,15 +1940,8 @@ static const struct of_device_id flexcan_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
 
-static const struct platform_device_id flexcan_id_table[] = {
-	{ .name = "flexcan", .driver_data = (kernel_ulong_t)&fsl_p1010_devtype_data, },
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(platform, flexcan_id_table);
-
 static int flexcan_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id;
 	const struct flexcan_devtype_data *devtype_data;
 	struct net_device *dev;
 	struct flexcan_priv *priv;
@@ -1997,15 +1990,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	of_id = of_match_device(flexcan_of_match, &pdev->dev);
-	if (of_id) {
-		devtype_data = of_id->data;
-	} else if (platform_get_device_id(pdev)->driver_data) {
-		devtype_data = (struct flexcan_devtype_data *)
-			platform_get_device_id(pdev)->driver_data;
-	} else {
-		return -ENODEV;
-	}
+	devtype_data = of_device_get_match_data(&pdev->dev);
 
 	if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) &&
 	    !(devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)) {
@@ -2235,7 +2220,6 @@ static struct platform_driver flexcan_driver = {
 	},
 	.probe = flexcan_probe,
 	.remove = flexcan_remove,
-	.id_table = flexcan_id_table,
 };
 
 module_platform_driver(flexcan_driver);
-- 
2.17.1

