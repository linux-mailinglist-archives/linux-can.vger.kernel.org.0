Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6727377B69
	for <lists+linux-can@lfdr.de>; Mon, 10 May 2021 07:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhEJFL4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 May 2021 01:11:56 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37680 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhEJFL4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 May 2021 01:11:56 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14A5AjBs081038;
        Mon, 10 May 2021 00:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620623445;
        bh=qAt2F4fkclW+C+54d5EikR+ummqe22jnG+GkI6TfYkY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RUI76Q/fO6kc2ASBWDSnQPLrn8NEPEDHP+8tWLLXbK1TMCntK26pCWh9rXj3e6DEX
         KPUnt0Y+PsaC3/aMn19uG9OEFN3V2Svguexf5Unb5L5HObHecorT3z5G1vW+dj1Y08
         //twplzARfyVFAHP3rEvKNtEWf4DYgTSCxFGlL5Q=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14A5AjUD055407
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 00:10:45 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 00:10:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 00:10:45 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14A5A9nN113970;
        Mon, 10 May 2021 00:10:37 -0500
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
Subject: [PATCH v6 2/3] dt-bindings: phy: Add binding for TI TCAN104x CAN transceivers
Date:   Mon, 10 May 2021 10:40:04 +0530
Message-ID: <20210510051006.11393-3-a-govindraju@ti.com>
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

Add binding documentation for TI TCAN104x CAN transceivers.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
index 601b5ae0368a..492eb53c0db0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4040,6 +4040,7 @@ W:	https://github.com/linux-can
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
 F:	Documentation/devicetree/bindings/net/can/
+F:	Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
 F:	drivers/net/can/
 F:	include/linux/can/bittiming.h
 F:	include/linux/can/dev.h
-- 
2.17.1

