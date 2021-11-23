Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC93459D8A
	for <lists+linux-can@lfdr.de>; Tue, 23 Nov 2021 09:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbhKWIQU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Nov 2021 03:16:20 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51140 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbhKWIQT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Nov 2021 03:16:19 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AN8D0cm018430;
        Tue, 23 Nov 2021 02:13:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637655180;
        bh=F9DCa620EBhOWSMGuwO/rTA9ebG6ER5N7DJdYv3qsog=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DIC88gBPVJk2CJtZjmUJDxcfmJWUev6JfwDKyn6lrX4zMvEYV5yFrK0qlb1j8zBN6
         82qWKwqowb4fT43d8AdHM8Yq5yDLRvrXeHVse3015mrljojUcS5IaRbqJZM6vfVQFH
         58r3wAR75lrLZRAeST0z3sl7nVZzx0C68sax/H7k=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AN8D0uC017678
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Nov 2021 02:13:00 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 23
 Nov 2021 02:12:38 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 23 Nov 2021 02:12:38 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AN8CNe0101399;
        Tue, 23 Nov 2021 02:12:35 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH RFC v3 2/4] dt-bindings: phy: ti,tcan104x-can: Document mux-controls property
Date:   Tue, 23 Nov 2021 13:42:19 +0530
Message-ID: <20211123081222.27979-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123081222.27979-1-a-govindraju@ti.com>
References: <20211123081222.27979-1-a-govindraju@ti.com>
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
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 6107880e5246..7392088cf060 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -37,6 +37,13 @@ properties:
       max bit rate supported in bps
     minimum: 1
 
+  mux-controls:
+    description:
+      mux controller node to route the signals from controller to
+      transceiver. The first and second arguments can be used
+      representing the line in the mux-controller to control and
+      the state to be set in the given line respectively.
+
 required:
   - compatible
   - '#phy-cells'
@@ -53,4 +60,5 @@ examples:
       max-bitrate = <5000000>;
       standby-gpios = <&wakeup_gpio1 16 GPIO_ACTIVE_LOW>;
       enable-gpios = <&main_gpio1 67 GPIO_ACTIVE_HIGH>;
+      mux-controls = <&mux0 0 1>;
     };
-- 
2.17.1

