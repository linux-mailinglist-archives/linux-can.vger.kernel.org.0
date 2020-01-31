Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 394B214F245
	for <lists+linux-can@lfdr.de>; Fri, 31 Jan 2020 19:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgAaSiJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 31 Jan 2020 13:38:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45648 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgAaSiI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 31 Jan 2020 13:38:08 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00VIbsdc054227;
        Fri, 31 Jan 2020 12:37:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580495874;
        bh=tP7sKFItqn9QuWrX3jgTW2QkwA1dUezZOkXCs9W7nsg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Zz+aL6EgZDALGWIhTLQ/Eop+8FToKXM5K19zQXngYf+LkWkS/uJmMupg0foL3f1GD
         7ar9SYtqG5T40bA89OCTkKAEywweYuu/cwnTHx/T40GKYVVfWmt3CcPmb3QQc7NzTX
         CSXTr+cQilDPuMN436F87cfYWvOnasfgm8b01Z18=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00VIbsDx101533
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jan 2020 12:37:54 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 31
 Jan 2020 12:37:53 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 31 Jan 2020 12:37:53 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00VIbrHW038928;
        Fri, 31 Jan 2020 12:37:53 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-kernel@vger.kernel.org>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <wg@grandegger.com>,
        <sriram.dash@samsung.com>
CC:     <davem@davemloft.net>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH linux-master 3/3] can: m_can: Remove unused clock function from the framework
Date:   Fri, 31 Jan 2020 12:34:33 -0600
Message-ID: <20200131183433.11041-4-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200131183433.11041-1-dmurphy@ti.com>
References: <20200131183433.11041-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Remove the unused clock function from the framework as the clock
discovery, initilaization and management are all within the registrars
code.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/can/m_can/m_can.c | 16 ----------------
 drivers/net/can/m_can/m_can.h |  3 ---
 2 files changed, 19 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 02c5795b7393..5794be1ef3ef 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1751,22 +1751,6 @@ void m_can_init_ram(struct m_can_classdev *cdev)
 }
 EXPORT_SYMBOL_GPL(m_can_init_ram);
 
-int m_can_class_get_clocks(struct m_can_classdev *m_can_dev)
-{
-	int ret = 0;
-
-	m_can_dev->hclk = devm_clk_get(m_can_dev->dev, "hclk");
-	m_can_dev->cclk = devm_clk_get(m_can_dev->dev, "cclk");
-
-	if (IS_ERR(m_can_dev->cclk)) {
-		dev_err(m_can_dev->dev, "no clock found\n");
-		ret = -ENODEV;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(m_can_class_get_clocks);
-
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev)
 {
 	struct m_can_classdev *class_dev = NULL;
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 49f42b50627a..c20a716b14cc 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -74,8 +74,6 @@ struct m_can_classdev {
 	struct napi_struct napi;
 	struct net_device *net;
 	struct device *dev;
-	struct clk *hclk;
-	struct clk *cclk;
 
 	struct workqueue_struct *tx_wq;
 	struct work_struct tx_work;
@@ -101,7 +99,6 @@ struct m_can_classdev {
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev);
 int m_can_class_register(struct m_can_classdev *cdev);
 void m_can_class_unregister(struct m_can_classdev *cdev);
-int m_can_class_get_clocks(struct m_can_classdev *cdev);
 void m_can_init_ram(struct m_can_classdev *priv);
 void m_can_config_endisable(struct m_can_classdev *priv, bool enable);
 
-- 
2.25.0

