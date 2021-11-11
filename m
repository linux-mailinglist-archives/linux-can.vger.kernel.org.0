Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C019044DAA7
	for <lists+linux-can@lfdr.de>; Thu, 11 Nov 2021 17:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhKKQqY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 11 Nov 2021 11:46:24 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47526 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbhKKQqX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 Nov 2021 11:46:23 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1ABGhNaB086301;
        Thu, 11 Nov 2021 10:43:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1636649004;
        bh=RUuZjBBt+NqprL4Mt3s0+KmkZ/pXzDCBbVfCQ2QDt74=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=envYL7d6z4BjqrENo9d0DY08PiT30qa/4r6aig76RuG8hzvZnLZj078RAc0b8r9yY
         /sRDx+otmzUho0HYPX63kwqu3V+QajE0ak6Ecukcdw/AVThg2aUN+VQKrsEgakvMQv
         po9FHA58FJW2/VhKdjEu3QBSQf5BEVcw5sq6oysI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1ABGhN4B091157
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Nov 2021 10:43:23 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 11
 Nov 2021 10:43:23 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 11 Nov 2021 10:43:23 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1ABGhEg3104171;
        Thu, 11 Nov 2021 10:43:20 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 1/2] dt-bindings: phy: ti,tcan104x-can: Document mux-controls property
Date:   Thu, 11 Nov 2021 22:13:11 +0530
Message-ID: <20211111164313.649-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111164313.649-1-a-govindraju@ti.com>
References: <20211111164313.649-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On some boards, for routing CAN signals from controller to transceivers,
muxes might need to be set. Use mux-controls property can be used for model
this.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 6107880e5246..24cc3c04b85d 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -37,6 +37,11 @@ properties:
       max bit rate supported in bps
     minimum: 1
 
+  mux-controls:
+    description:
+      mux controller node to route the signals from controller to
+      transceiver.
+
 required:
   - compatible
   - '#phy-cells'
@@ -53,4 +58,5 @@ examples:
       max-bitrate = <5000000>;
       standby-gpios = <&wakeup_gpio1 16 GPIO_ACTIVE_LOW>;
       enable-gpios = <&main_gpio1 67 GPIO_ACTIVE_HIGH>;
+      mux-controls = <&mux0>;
     };
-- 
2.17.1

