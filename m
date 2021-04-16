Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0217A361EB7
	for <lists+linux-can@lfdr.de>; Fri, 16 Apr 2021 13:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbhDPLbl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Apr 2021 07:31:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46832 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDPLbl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Apr 2021 07:31:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13GBV7jx106544;
        Fri, 16 Apr 2021 06:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618572667;
        bh=IlU5JTHbgq4me6qjMbuUKqaDA5SuF5DOc/xXRU46LRk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HnMQBAeEMo/H52ClX9Jm9ZuhXkLBmMmH2ArgcWYHHEi0hVcxF8dujEpa1pIf+XUNj
         Dq7URl8wU8NgoOxz+HXWWc1IX+Bv9NZfba9x7e80xdpUQFU67O7h7ucONQaYf6e5CB
         EUrKq97Lra64A73eUfiqjroYflTgyhCg/n79GhmU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13GBV7Uv122596
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Apr 2021 06:31:07 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Apr 2021 06:31:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 16 Apr 2021 06:31:06 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13GBUwIv073816;
        Fri, 16 Apr 2021 06:31:03 -0500
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
Subject: [PATCH v5 1/3] phy: core: Reword the comment specifying the units of max_link_rate to be Mbps
Date:   Fri, 16 Apr 2021 17:00:56 +0530
Message-ID: <20210416113058.23815-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416113058.23815-1-a-govindraju@ti.com>
References: <20210416113058.23815-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In some subsystems (eg. CAN, SPI), the max link rate supported can be less
than 1 Mbps and if the unit for max_link_rate is Mbps then it can't be
used. Therefore, leave the decision of units to be used, to the producer
and consumer.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 include/linux/phy/phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 0ed434d02196..f3286f4cd306 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -125,7 +125,7 @@ struct phy_ops {
 /**
  * struct phy_attrs - represents phy attributes
  * @bus_width: Data path width implemented by PHY
- * @max_link_rate: Maximum link rate supported by PHY (in Mbps)
+ * @max_link_rate: Maximum link rate supported by PHY (units to be decided by producer and consumer)
  * @mode: PHY mode
  */
 struct phy_attrs {
-- 
2.17.1

