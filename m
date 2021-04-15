Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56765360C73
	for <lists+linux-can@lfdr.de>; Thu, 15 Apr 2021 16:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbhDOOvB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 15 Apr 2021 10:51:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46794 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbhDOOu3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Apr 2021 10:50:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13FEnxpV001478;
        Thu, 15 Apr 2021 09:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618498199;
        bh=nOtbADv7gq9oWC93nIeG2KyriW+0wEaqeFfExSfoA3U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=leM+XDQgTsgfCQnRn+Rz9/bYVvqi1V4Pj6yX9eFZSDsQGqz9e4dHPSV+nOQbvOG1g
         WtVzEAYHIvYJ8UUnmwu8btoncZwyM1MT1yY+WRf9aT06jAwU+P+THsu2Va3GK15QQW
         zHwYL7HpgQxuxXLOxyrWxEJVkGSsz1dcIhsSyEsk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13FEnxtq117710
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Apr 2021 09:49:59 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Apr 2021 09:49:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 15 Apr 2021 09:49:59 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13FEnlS7037772;
        Thu, 15 Apr 2021 09:49:56 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-can@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH v3 2/4] phy: Add API for devm_of_phy_optional_get_by_index
Date:   Thu, 15 Apr 2021 20:19:45 +0530
Message-ID: <20210415144947.4725-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210415144947.4725-1-a-govindraju@ti.com>
References: <20210415144947.4725-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add API for devm_of_phy_optional_get_by_index, to obtain a reference to an
optional phy by index.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/phy-core.c  | 26 ++++++++++++++++++++++++++
 include/linux/phy/phy.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index ccb575b13777..bf06d4e0ede2 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -839,6 +839,32 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_get);
 
+/**
+ * devm_of_phy_optional_get_by_index() - lookup and obtain a reference to an optional phy by index.
+ * @dev: device that requests this phy
+ * @np: node containing the phy
+ * @index: index of the phy
+ *
+ * Gets the phy using _of_phy_get(), then gets a refcount to it,
+ * and associates a device with it using devres. On driver detach,
+ * release function is invoked on the devres data, then,
+ * devres data is freed. This differs to devm_of_phy_get_by_index() in
+ * that if the phy does not exist, it is not considered an error and
+ * -ENODEV will not be returned. Instead the NULL phy is returned,
+ * which can be passed to all other phy consumer calls.
+ */
+struct phy *devm_of_phy_optional_get_by_index(struct device *dev, struct device_node *np,
+					      int index)
+{
+	struct phy *phy = devm_of_phy_get_by_index(dev, np, index);
+
+	if (PTR_ERR(phy) == -ENODEV)
+		phy = NULL;
+
+	return phy;
+}
+EXPORT_SYMBOL_GPL(devm_of_phy_optional_get_by_index);
+
 /**
  * devm_of_phy_get_by_index() - lookup and obtain a reference to a phy by index.
  * @dev: device that requests this phy
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index f3286f4cd306..c5f32b4fadd6 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -253,6 +253,8 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 			    const char *con_id);
 struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 				     int index);
+struct phy *devm_of_phy_optional_get_by_index(struct device *dev, struct device_node *np,
+					      int index);
 void of_phy_put(struct phy *phy);
 void phy_put(struct device *dev, struct phy *phy);
 void devm_phy_put(struct device *dev, struct phy *phy);
-- 
2.17.1

