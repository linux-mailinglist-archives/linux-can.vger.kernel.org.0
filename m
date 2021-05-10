Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CDD377B65
	for <lists+linux-can@lfdr.de>; Mon, 10 May 2021 07:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhEJFLq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 May 2021 01:11:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50570 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhEJFLp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 May 2021 01:11:45 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14A5AXvn073470;
        Mon, 10 May 2021 00:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620623433;
        bh=D09BNE/QEQl6N7z7qggHPyShQPUog3qk6d/UXkkKZok=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=r2NqDbSlCxTcDUFtpoNDlT2l0nFDX1I0MAud9qZxJM/+auuCXkDdO6XbaY6Ocpgf2
         ipDGqk09+x2hgOj+6jXJVcjrG0xIc2e3o0CSf7e6jzoxjLF1FQ+9wsEIEkrw7oyZu6
         4tpBGRD6rDXOXmvfTPNpDHcPE1OFLBYaqC4k2pAs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14A5AXZM061787
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 00:10:33 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 00:10:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 00:10:33 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14A5A9nM113970;
        Mon, 10 May 2021 00:10:24 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/3] phy: core: Reword the comment specifying the units of max_link_rate to be Mbps
Date:   Mon, 10 May 2021 10:40:03 +0530
Message-ID: <20210510051006.11393-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210510051006.11393-1-a-govindraju@ti.com>
References: <20210510051006.11393-1-a-govindraju@ti.com>
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
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
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

