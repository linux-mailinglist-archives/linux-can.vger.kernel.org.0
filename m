Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12912361EBC
	for <lists+linux-can@lfdr.de>; Fri, 16 Apr 2021 13:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242102AbhDPLbo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Apr 2021 07:31:44 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46856 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242094AbhDPLbm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Apr 2021 07:31:42 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13GBVBTn106567;
        Fri, 16 Apr 2021 06:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618572671;
        bh=MelUBgWsylW80+RVjogTPjEFvjvSH2ZwkORUG97pKnw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cXlXL83p98zNZgPDUVA5Od5HzvZr7rrVL0UQpvk7Z620uY3SAIl89HzI7h7+0OpxC
         pL+cc7UjzRUaK7YeVht1nB1s2IX/6GalQf2vh/Z02PCHPHR3+Qau08U2MM2CKFMRTL
         7lVVwEo1e1Ie9cI2i0RIjg0jHOYRQ4C5N4pNSlFo=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13GBVBUv079822
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Apr 2021 06:31:11 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Apr 2021 06:31:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 16 Apr 2021 06:31:10 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13GBUwIw073816;
        Fri, 16 Apr 2021 06:31:07 -0500
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
Subject: [PATCH v5 2/3] dt-bindings: phy: Add binding for TI TCAN104x CAN transceivers
Date:   Fri, 16 Apr 2021 17:00:57 +0530
Message-ID: <20210416113058.23815-3-a-govindraju@ti.com>
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

Add binding documentation for TI TCAN104x CAN transceivers.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/ti,tcan104x-can.yaml         | 56 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
new file mode 100644
index 000000000000..6107880e5246
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/ti,tcan104x-can.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TCAN104x CAN TRANSCEIVER PHY
+
+maintainers:
+  - Aswath Govindraju <a-govindraju@ti.com>
+
+properties:
+  $nodename:
+    pattern: "^can-phy"
+
+  compatible:
+    enum:
+      - ti,tcan1042
+      - ti,tcan1043
+
+  '#phy-cells':
+    const: 0
+
+  standby-gpios:
+    description:
+      gpio node to toggle standby signal on transceiver
+    maxItems: 1
+
+  enable-gpios:
+    description:
+      gpio node to toggle enable signal on transceiver
+    maxItems: 1
+
+  max-bitrate:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      max bit rate supported in bps
+    minimum: 1
+
+required:
+  - compatible
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    transceiver1: can-phy {
+      compatible = "ti,tcan1043";
+      #phy-cells = <0>;
+      max-bitrate = <5000000>;
+      standby-gpios = <&wakeup_gpio1 16 GPIO_ACTIVE_LOW>;
+      enable-gpios = <&main_gpio1 67 GPIO_ACTIVE_HIGH>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 84ef96a444c3..e666d33af10d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4046,6 +4046,7 @@ W:	https://github.com/linux-can
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
 F:	Documentation/devicetree/bindings/net/can/
+F:	Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
 F:	drivers/net/can/
 F:	include/linux/can/bittiming.h
 F:	include/linux/can/dev.h
-- 
2.17.1

